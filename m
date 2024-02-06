Return-Path: <linux-kernel+bounces-54873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5546684B4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C461F291D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A921332B1;
	Tue,  6 Feb 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1wIAVQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B8134CC5;
	Tue,  6 Feb 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221355; cv=none; b=uk1Y9LTbTwglayyBj4yWnhwjNcV8F4qoGz+BAPTGLaPqPOgwv8OCWIbOOf/n2Yo/TGLQuL4B8Wjm0ccR+Bpz1SexqOgKA3e1A16SkoNYqf8rvq2fqSxtlWVtbjKhxERlmwMf/SWsH8n+AsPKe6UUo7Lx3FAZI6aKxvg08MohsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221355; c=relaxed/simple;
	bh=T+6mtzRx975G9vZcGMt5Mg+MAazPc5UIQRcEY/W6Cfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HSJ6MJx7QLnF3YBSYVmvOZp9zP4eIz4+nSdSVxLRzyMdVHZYRd3DVPgnajFdlHDlq8CLETvSfCrncJKNFDWUiSSCH+/c42i1nGC6D4VTWU/Zyie+kNTcvWeLVW5tdhKauafluzviRJxChM580wKmfv14PLFO83ifKL31uJbuczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1wIAVQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0770C43399;
	Tue,  6 Feb 2024 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221354;
	bh=T+6mtzRx975G9vZcGMt5Mg+MAazPc5UIQRcEY/W6Cfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g1wIAVQShOEFR33uhqw7FoHyLxnOCzfP+bvJi/qVA25KdprZLhR6y55rcX5ZtSoW6
	 UlTlmQhppBhg6U9urJH8BTsMeMTayy6X4siGrl294OTp851ejk4mgIiHHAZ1QTaZw2
	 6Z8PxBBB1Ft+KLG2VTFF4iToFfZZS6F53C07K44SA+px6qK8lhH8Hpz+gwueA7dOpF
	 RnfnPXE7qJvap3XVCOkZJJNOQhT62FByjeo4LdCC4aRd4CstHDj8QZXIEsV/ycz0jW
	 ZY30yMG3QBrR7qnL4JgOPHuDtxSt6AGQQhkl0sap18d5EirxsZoOxG3cJVwhbFkw8G
	 UaRwx+MFuJS9Q==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126212358.3916280-2-dlechner@baylibre.com>
References: <20240126212358.3916280-2-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: move split xfers for CS_WORD emulation
Message-Id: <170722135351.992289.8405956770330505412.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 26 Jan 2024 15:23:57 -0600, David Lechner wrote:
> This moves splitting transfers for CS_WORD software emulation to the
> same place where we split transfers for controller-specific reasons.
> 
> This fixes a few subtle bugs.
> 
> The calculation for maxsize was wrong for bit sizes between 17 and 24.
> This is fixed by making use of spi_split_transfers_maxwords() which
> already has the correct calculation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: move split xfers for CS_WORD emulation
      commit: c8bec3355f08ddb887d5c13b7095dfa79e6db108

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


