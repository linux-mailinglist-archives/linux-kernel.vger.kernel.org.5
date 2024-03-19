Return-Path: <linux-kernel+bounces-107481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8287FD20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1523D1C21D60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1F7F46E;
	Tue, 19 Mar 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUsR6on6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F71CD13;
	Tue, 19 Mar 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848857; cv=none; b=QJ1lSpWoUn8p9J95tSbM2Gw8ZTvhqpbab+/Kh3KMTfU1LTH5sDmSMiSmGnSoR7Az2Cb04+HjToS9jqvx9toTjnuV1TteOQW1UrgwWqBXNUEYaITFUh+92xe5/UK0dCSPlxzgRnAn3Hvvjgwa8E3KYt+mxOTX05unO8VA6DDD0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848857; c=relaxed/simple;
	bh=2T6/owfvraXQAZBBPfQGNITgod+zDpUnLP2QaUfJv+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i4jm5aKCXiUj+1LXdjPsukHASolT1u5siyyZRVrRPGT2SnwG8dwUCJPSO+DB00rW2GRDv2oU5C+uFjH0Y/L5SFfEHrRf43/V6bNbgo0d6GWf33CFToAAg1q9tVaQ9PEkDlLEx5tuiRhtxkH8He73buYolNO2gvEAvmZx4h6CsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUsR6on6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAF6C43390;
	Tue, 19 Mar 2024 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848856;
	bh=2T6/owfvraXQAZBBPfQGNITgod+zDpUnLP2QaUfJv+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YUsR6on6CZCZ/LVMj5glv4eoNpKHz3Pia6pURKHCGBpjGBFmzC3380SY6xvmHH5jW
	 LV5asCkR8Ar/0vPuhpZralZYoOpyq/f8IEnelLWzC/Yv9FLUdClVl1O+aI67yx3fd0
	 qmpSBJAg93ZJ/DWWbI6Uwtk+Vg9eku/zEQ/q3mH1U/fKFqYSk4T8nZ3AGFnoPtHaIE
	 gN69Iz9B4QxuecnAeb2hvBQNk7mSUy+8vHwsJfDhXyORwRaNiszFP+RHrOO8bAzIkv
	 iVdLTFQbm0KUNeqbiDM1F8tGzXoXoB1E7QfOCO+HjGiyOvwz7RR2mAcb1/yLGI42jd
	 uLOpiO17x+m3A==
From: Mark Brown <broonie@kernel.org>
To: benjamin@bigler.one, carlos.song@nxp.com, s.hauer@pengutronix.de, 
 shawnguo@kernel.org, stefanmoring@gmail.com, 
 Adam Butcher <adam@jessamine.co.uk>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240313210258.5990-1-adam@jessamine.co.uk>
References: <20240313210258.5990-1-adam@jessamine.co.uk>
Subject: Re: [PATCH v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
Message-Id: <171084885426.22687.12295821303362062927.b4-ty@kernel.org>
Date: Tue, 19 Mar 2024 11:47:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 13 Mar 2024 20:58:19 +0000, Adam Butcher wrote:
> 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
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


