Return-Path: <linux-kernel+bounces-107482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B187FD22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B12808EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616C7F7C1;
	Tue, 19 Mar 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB8YZdxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AC7F486;
	Tue, 19 Mar 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848859; cv=none; b=EaJIcNasf3fQZlVpUkWe4sf7+42MNz+hl/1Pv1HNVvGgPFR3AVdUuhYbIqi08n+E3C2IHIqi474SuCZD9cbE18zcojVzfO3hTKD6l8Zx3LAVN73BE6VhTDqM/BqzrrVBnvlsj8DypYkVwTHgp5I6afOuOrIe3tl9DOzZ7uZxkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848859; c=relaxed/simple;
	bh=y6OMOgyQBckPt7R6AbuWEn1qSTOmp0H9qDN+tit2aAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rU6lN6peRLXuF1DtdEsbh7z1JcEsXPE7ZVft/S2SDOEpqfoiIUBcr4eO1IsGhOj5vBwHNhz5qdO20RnioELuj4DxSreNxzEBoNsBZNYcsVe+iHfLEJsPiKE5/cJLAbAU86lB/UagD6dX2FCAjt5nu+8aFH3CuKnZCkezo/ZIKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB8YZdxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A31C43394;
	Tue, 19 Mar 2024 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848859;
	bh=y6OMOgyQBckPt7R6AbuWEn1qSTOmp0H9qDN+tit2aAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GB8YZdxxD+5MBPcliTzkCNQtAc1hMzNX8QhswisFogrCBGtvWI/g5xbUVjajJFFG5
	 UZXyOdBvt0Qd6RAjEj31H4BKwNj7/psnXMX1+logW/mzdv1Y+vlqQMQCB5BJeJaFxy
	 frd1h/6HfRG+Yao1+bPzRUkdNe5tWiR3bqmK5QNqJ+hEqP4lU0qFELfB3FYecuIiyP
	 FiFyiHzSdgCYSGIKcVdY3p6GLpjeNftzi2prLICamYE7cZwNG1IaCtRjfOfigcYJ3y
	 N2JNKeZxLivhViM905cJyCZg5maxspsCShwVM+zfxqr413gsjFEshl4nqSDVcRuRg6
	 BgQaMqJWTu88Q==
From: Mark Brown <broonie@kernel.org>
To: benjamin@bigler.one, carlos.song@nxp.com, s.hauer@pengutronix.de, 
 shawnguo@kernel.org, stefanmoring@gmail.com, 
 Adam Butcher <adam@jessamine.co.uk>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240318175119.3334-1-adam@jessamine.co.uk>
References: <20240318175119.3334-1-adam@jessamine.co.uk>
Subject: Re: [PATCH v3] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
Message-Id: <171084885691.22687.1626199972838540212.b4-ty@kernel.org>
Date: Tue, 19 Mar 2024 11:47:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 18 Mar 2024 17:50:52 +0000, Adam Butcher wrote:
> c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
> corrects three cases of setting the ECSPI burst length but erroneously
> leaves the in-range CPU case one bit to big (in that field a value of
> 0 means 1 bit).  The effect was that transmissions that should have been
> 8-bit bytes appeared as 9-bit causing failed communication with SPI
> devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
      commit: cf6d79a0f5769b5f4d9579ddaf88d2c30b03b873

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


