Return-Path: <linux-kernel+bounces-64091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5E853A15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CA0B22964
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2A10A21;
	Tue, 13 Feb 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/mfkWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6121CA92;
	Tue, 13 Feb 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849901; cv=none; b=OsCGSyDO7GyfGX5wzjWNgmAb2qc3TAKS2CfCFzLSvkoo72FweqoJnYeaV6LfGIxvZJDHnNjRNLPmpo4Cj8by2CX/rJ9cIzDzj8dFkpUjD7YM2IqD3QqTCpBlYmsL+pSI8qyY3Lf6NKyOi8tpGG92eDunhwn1c+mxsTVoueJe2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849901; c=relaxed/simple;
	bh=W+9yCHylRTpGfiETlVt/ON0MhFzrCWbkokZEs7EpAy0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HhMuSY2GrYFJNDvpv2ZB17GSd/7Nvv9j9zhXoFLyAOVsHvbZ7KdWe2NkoN43fCNs+/KxEDepZ63cCY8q+0jOBQ2AVABQ0JLQjIe9SK9xAGU+vmHZoAa8QMqFfC6iM6ykV2pPTLXQRZrDuw3g0HrU3fWdenA1iw3Ge2jUpgL5D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/mfkWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D3C433C7;
	Tue, 13 Feb 2024 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707849901;
	bh=W+9yCHylRTpGfiETlVt/ON0MhFzrCWbkokZEs7EpAy0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Qk/mfkWH0Q5xknKP92DPG/oZYMcN/WkRaXTE3zB3jlWojtU6DZz4qUGM8MY5eodmb
	 edR8NwmhQd9mFn1lbRCZAVWZc8x1vKHMXas8E7IAsCMakGU67RnoFg8OXeq2BVz10S
	 D+VRgT4LcSPuFEsCQz/P+FywnNDTTi3xIptrrGbGIgqV0fRc6ozUcnzQDpl6Vcf0Fe
	 YaSJ/9TPF65qnZwHAAeI4UfVpKgrUXGIoHQmvOCDrnnyxVgXgRtOrYta+TBRL05W9s
	 t/403HXQO4LHIzgMLz7rMnW6VpKNbocj56ivSwkmDxlGjTjheL35v0Yhoq9jmjsQdT
	 M/Sm7OhwCauuw==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ralf Schlatterbeck <rsc@runtux.com>
In-Reply-To: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-Id: <170784989820.681459.6695714509639866106.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 18:44:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 02 Feb 2024 12:53:30 +0100, Ralf Schlatterbeck wrote:
> There was a change in the mxs-dma engine that uses a new custom flag.
> The change was not applied to the mxs spi driver.
> This results in chipselect being deasserted too early.
> This fixes the chipselect problem by using the new flag in the mxs-spi
> driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi-mxs: Fix chipselect glitch
      commit: 269e31aecdd0b70f53a05def79480f15cbcc0fd6

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


