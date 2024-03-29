Return-Path: <linux-kernel+bounces-125253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F268922D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E71F26CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2B139596;
	Fri, 29 Mar 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIZQfmjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C07137932;
	Fri, 29 Mar 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733736; cv=none; b=FCO+jgpm+6vN+jSoeEIvq20KV2zBzPN4t2VTaat8QWFd//qYNNmFLGjeMsT2x/pljWpa68GecFj8FEY5HTgthwHvzj9DS4N1sU7Ph5er3MRSBOkYycn0B7ZbfzucjBD+7qjoDPRjOcBoIs1TTdArNP2eaeL8nwxKyUCJc4pDNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733736; c=relaxed/simple;
	bh=o4A1HO9SIxvTZDIl37Qyw+HvUHARhJ6hxjCxrOrTbU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BEj4+maieL1nQ0BYSjwJsLl0fSKp0VveQeml9tXBgB+b2LwHK+JT34GYhR8c4N7OhIMDyVE2JG2UztoPY46+VyU0+RsV3O5I59dHYlifGhgbSYn61yjZwmjtfUvz7RRTMAAJtIuMsTjU4o65IEealByaLQh0BzEKIYezthF69nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIZQfmjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C54EC433F1;
	Fri, 29 Mar 2024 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711733736;
	bh=o4A1HO9SIxvTZDIl37Qyw+HvUHARhJ6hxjCxrOrTbU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vIZQfmjQzaA4ofkQ0H6qG+dzf3wO3WXHT5uGtVPRykGw5iHbztGUnsnMNouv0Sf3d
	 y7fVkzTLNAzixYo96VrlldogyP1kt/xFQ3uMSKifNvdqgC8HAz5MQX4uzzTcTalWoa
	 oybOAEBM91cBAGda6b1UhP4i2PG2iqopZcA4XDm47x8+kmlxrD5DxqUm2819K67sSO
	 ZWgtwwRqsIcuk5eMwSIaRibxFMGik5CFdRp6CTRqpHd+skL1v3bkC9O0MeA84c56Bg
	 YOaG0ALmC/v64mL5S6g41v2vIp76EIzdNgAkRGMgZCOeWSVSAl8cE04f8nXdZEqc90
	 +qDnSeeXuKvCg==
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240329085840.65856-1-jaewon02.kim@samsung.com>
References: <CGME20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8@epcas2p2.samsung.com>
 <20240329085840.65856-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: Use DMA mode from fifo size
Message-Id: <171173373339.1605661.7010691165644854540.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 17:35:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 29 Mar 2024 17:58:40 +0900, Jaewon Kim wrote:
> If the SPI data size is smaller than FIFO, it operates in PIO mode,
> and if it is larger than FIFO size, it oerates in DMA mode.
> 
> If the SPI data size is equal to fifo, it operates in PIO mode and it is
> separated to 2 transfers. To prevent it, it must operate in DMA mode
> from the case where the data size and the fifo size are the same.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Use DMA mode from fifo size
      commit: a3d3eab627bbbb0cb175910cf8d0f7022628a642

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


