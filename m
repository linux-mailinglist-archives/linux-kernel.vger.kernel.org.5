Return-Path: <linux-kernel+bounces-123037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED2890155
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43493291E49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9F12D77B;
	Thu, 28 Mar 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRpN4Xry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A457199BC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635013; cv=none; b=gNzFIphI4fiWdwkC+amG8qaRaVzdNJCel8ETbhN/vkwWEctqdXn9dLCB6eDczRgnnX2Apq/nWPRDts2gUmeaRWBkJrCU87q5OnFe/B8a3ToFtOnAdMw9f8p8+2IASWuDYbVcKrjzohX5bsULetj7crUZZey5TPV9tELd+rG/5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635013; c=relaxed/simple;
	bh=GV6iHbk8G+1IAC8aqbD0IvBMdnIYfcUoFdz3NEJc4Io=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h4HAcYMXnE48FAYsYk2MJq7pgDrZmYe7SvuXLyUsGoWFkUESUGgVYts219U4CYN5kAUnCQ0VEqq+0eiuKuuIcxgCx3KDiznoYlGWWK2N8+LwtvKcaCPaWgGxZ6PuG9B2PbXAdTAOpBroDSMZcEu9usBitaOdPLTrg0YhboPHo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRpN4Xry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E19AC433A6;
	Thu, 28 Mar 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711635013;
	bh=GV6iHbk8G+1IAC8aqbD0IvBMdnIYfcUoFdz3NEJc4Io=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rRpN4XrymAcc9PwagT8541WrrwmSGVmZwBoUH9JmmytEbJ0ptBIi9WO8kKrEUNcpN
	 K6tGDww3o3Msf7Up8RM22Uoap6WCNcoEMRvlRux4f6XrnPAZU4ExETr72m5hNZDVyT
	 Twm8nBDfsi7vXRAPOEM23WElSgxMTnj04RmVuGQo35LQUnmTVhoCxAixbaJKBzyyES
	 +MO6TloDH0knu7ASCQELRMTTSSooup3B8webyboy2nEIngKm8hF8e/zOIYhrnZ6CLp
	 CYqIetDta+t9SRNIXBXbrsfxFeZOxAn7lcXDEfEUsaLKsMvxohSmMojLf2Zx0oPsDb
	 fA2Ca3LC9QMjQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240327114406.976986-1-rf@opensource.cirrus.com>
References: <20240327114406.976986-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: maple: Fix cache corruption in
 regcache_maple_drop()
Message-Id: <171163501205.33337.6238909725521756529.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 14:10:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 11:44:06 +0000, Richard Fitzgerald wrote:
> When keeping the upper end of a cache block entry, the entry[] array
> must be indexed by the offset from the base register of the block,
> i.e. max - mas.index.
> 
> The code was indexing entry[] by only the register address, leading
> to an out-of-bounds access that copied some part of the kernel
> memory over the cache contents.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Fix cache corruption in regcache_maple_drop()
      commit: 00bb549d7d63a21532e76e4a334d7807a54d9f31

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


