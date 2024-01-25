Return-Path: <linux-kernel+bounces-38697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD383C442
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D23B22043
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D160EE5;
	Thu, 25 Jan 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4TkpIWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5760EC4;
	Thu, 25 Jan 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191367; cv=none; b=tQtgjJsWWavrThbH5mH3p8suC/q4PgHJRxPziaJg6u7TTJPXkkk50l1cho17HHOSdW+mDRDlhBBE6sEVLyANjdjHSoW6DFRtJ5mgIVOq+diS1g83VX5hLeyAHrKxMHAdV4d23rIaWtEXUgNPBU+wE/8lfSDE/CTltqCyDskdfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191367; c=relaxed/simple;
	bh=hW+7KwLKI/bBlcGNcAWmmmbt2DqB5Fpalsq0UAOigPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pFuPFm2ctjmDIMrZf98R7N+OgkKNVB0A+hgwMPAmTl6Zp5ugjv+H+jwurY+U+8yPKSxmx0RmQfrCCGBwqBP7WmxWmU5BgxjQN/JcRVK7aud9gYXvr4Nd/haK+rPnurYgP+RxmvwOmsE9980hJrBbGQcJHwfxS5eLypJO2r+iNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4TkpIWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D06C433C7;
	Thu, 25 Jan 2024 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706191367;
	bh=hW+7KwLKI/bBlcGNcAWmmmbt2DqB5Fpalsq0UAOigPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N4TkpIWNTxnqtSfosttOzWNDmPZ2ZYsvTxL0myI5GpDkNU9ZvpFOO2zmmsD7czfzA
	 HDwNl5P6IFmNpXBKtreSRDRglECxaHo+sV8ahx6TKXDuHlQiuyZ5NDZ20qNNDVvPaA
	 RPKOQWpxH8OlCF9Iz7Pms/LiE4Q+D6clzU7pzVNfH1uC+tDNTbq/wF6tDhRHOUxn2H
	 xNuZKDM63XZOHrB2b/iwB2fsGX8FU1ZU1JNtUspUYIGx7SfH/VQ4LsUgXEfJws/Z6a
	 KEBGdRxpUt+ui/69T85DafdBLm+8nuHzlWygg6IZtGmw1i4iwcdUKNBRb0glA88Q9x
	 e0Agwd3NHwKfw==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
In-Reply-To: <20240120012948.8836-1-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH 0/7] arm64: exynos: Enable SPI for Exynos850
Message-Id: <170619136385.38074.4377918274781683592.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 14:02:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 19 Jan 2024 19:29:41 -0600, Sam Protsenko wrote:
> This series enables SPI for Exynos850 SoC. The summary:
> 
>   1. Enable PDMA, it's needed for SPI (dts, clk)
>   2. Propagate SPI src clock rate change up to DIV clocks, to make it
>      possible to change SPI frequency (clk driver)
>   3. Add Exynos850 support in SPI driver
>   4. Add SPI nodes to Exynos850 SoC dtsi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/7] dt-bindings: spi: samsung: Add Exynos850 SPI
      commit: 737cf74b38007fd5d5d2f15d4d4bc16e5f1cbfed
[5/7] spi: s3c64xx: Add Exynos850 support
      commit: 0229278bf33ea69cc1bba12c287f173e9b18c1f8

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


