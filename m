Return-Path: <linux-kernel+bounces-154516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BC8ADD07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111381C217B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB2208A0;
	Tue, 23 Apr 2024 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbmEcnVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827F1CA82;
	Tue, 23 Apr 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848648; cv=none; b=MekHGrTmZCklaA7eDQf/T7DEUN3p2ah4zLXYuyBxda1dNyi01HLHlSOmkv//4KjBV3TEL6oI31Rndal+akZWMEOn9ZjgDgxpwKWMR3qgUW0OkjQErUk31CmpsuHlFe9q7C12jy0af9YVgQ/09IRVuob0lXaeJ4gadC50mNTy6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848648; c=relaxed/simple;
	bh=M0Oo2/rDVfDRqkmgxoKkdOS/0wTXJfumeJLtRvmFJgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dqyid22Jhj+A8PyhKVl4dyweZHKdkPJg3fD5ykbZ9nlkrlWHLLnEWv2G1HGbJz+jQ09Lj36BvEgK7yYBmfKidOJfbAWsOteY7W+zhWJak7gpeVcIMAVu5dhV7K2FK6nH6s/hNeez1Axl5XQ18SMlriY/fc8w1+Unf+csCoBQwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbmEcnVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBAC116B1;
	Tue, 23 Apr 2024 05:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713848648;
	bh=M0Oo2/rDVfDRqkmgxoKkdOS/0wTXJfumeJLtRvmFJgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FbmEcnVFYX/wRd+3iJS9w/ncO82zw1Y3QSKTqKcnSYKYkRRwtDnJtXzkdfvPwkwut
	 DWl+78pKKbZ4ORHGucJeyjMRBv4WhsrErs8aRMNmpZvoCEnWDSZqop3lC2evggPicv
	 9yy8i2SBaWT5dg425a9gef4qt4dLrC01knMfrTa+DybCqv9ecwL55HcQMr95yUi0lC
	 ghkVmBlPtipFRD5TlL0eXs1cTlz+OVkcVpL2P7NwtdEb18UWr5yGN7ocitoTyxqYrl
	 fhNEleWsitvFWfM7MJSPDjTm3tTMX3CCtxyszLaH8k3X/w9qZxsG8s4n09hHM2tq02
	 hOSlZauRzN/IQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20240422103211.236063-1-rf@opensource.cirrus.com>
References: <20240422103211.236063-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Avoid static analysis warning of
 uninitialised variable
Message-Id: <171384864615.1769239.12719650496450465908.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 14:04:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 22 Apr 2024 11:32:11 +0100, Richard Fitzgerald wrote:
> Static checkers complain that the silicon_uid variable passed by
> pointer to cs35l56_read_silicon_uid() could later be used
> uninitialised when calling cs_amp_get_efi_calibration_data().
> 
> cs35l56_read_silicon_uid() must have succeeded to call
> cs_amp_get_efi_calibration_data() and that would have populated the
> variable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Avoid static analysis warning of uninitialised variable
      commit: f2602fba4723e408380eb9a56e921d36a1ae21f8

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


