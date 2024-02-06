Return-Path: <linux-kernel+bounces-54871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBA84B4A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4800D1F2913D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65049133291;
	Tue,  6 Feb 2024 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBpEVxGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EE132C3A;
	Tue,  6 Feb 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221350; cv=none; b=ryE3xI8W6rZEuoHH7I1w3RU4RB7rQa6KfnDC/E2HAhLKXO9Om50zA0UBpEHKu9GLm+6/jIkkr9MYbAIQYLi2C1mui2qHh43SeUvHJPd+Nmd/iWZFYS5e51Ou1gYvEwb40ecPaZ3Mqjq8AGx3+KvG2y2eS+MaF1GcaO++vf8Ixmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221350; c=relaxed/simple;
	bh=4ZVF5lk/addHaP1sMhaPzPoGDFlYeX2aYy74JDMb6iY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yc9aNokCvcRpkSD4j1+QTk+KaWJ+2CtRgpzV5PVCiBiKHuzOBsygb1VUVEezAPofTiGKOY349mVIpCxMqst+TIzYoVdnKSpj/7CPyinCpDXBj/UQpF+2AkDQE4hnb4XulbpijYjm5RMoMGDG6NNGGlcmVrb14ZSVyzUvmxqnMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBpEVxGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D0C433C7;
	Tue,  6 Feb 2024 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221350;
	bh=4ZVF5lk/addHaP1sMhaPzPoGDFlYeX2aYy74JDMb6iY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rBpEVxGUXm/c8tfSJELsqw9Jm/d0flbsUKz1zl75kvsJoGhE6Yg77n9hZjICbzMps
	 toKXAtbLsTTA+4KDppNUzoj4p44EZZ4CntxAdHZVxrfQ7fCxhUXjyfoKv6inswTQZI
	 tLkTN7JwBNxUEAsNhUcW5swA85gRhjZE4kV/FOQpqDsrmLRolSIyNRB3A5+4vcttcw
	 z6bytk+sQYOc5kLKWG0+vHch4fbVL4h9mBuqKoZAtZF07U5SyMDec3yVw+a/uCTUQL
	 m3NfmmQYGAsGLP9BAVtSYpcrYIQz6a+SpGrUiRGqEH/4M1vH74DBSKdGMMj2xTGw3o
	 LCRdY5BpDbUig==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andy.shevchenko@gmail.com
Cc: Vladimir Oltean <olteanv@gmail.com>, Minjie Du <duminjie@vivo.com>
In-Reply-To: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
References: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/2] spi: fsl-dspi: A couple of error handling
 improvements
Message-Id: <170722134868.992289.7755960695527262263.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 22:29:17 +0200, andy.shevchenko@gmail.com wrote:
> A couple of error handling improvements here:
> - unshadowing error code from dmaengine_slave_config()
> - making error messages uniform
> 
> In v2:
> - split to two patches (Vladimir)
> - improved commit message in the patch 2 (Vladimir)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: fsl-dspi: Preserve error code returned by dmaengine_slave_config()
      commit: f156743c526281ddcc19511e9073f8c987506913
[2/2] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
      commit: 51b8e79c45d5a42891c6196dcd3f73cbb599940a

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


