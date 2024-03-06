Return-Path: <linux-kernel+bounces-94639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D2874287
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA54B20AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3131BC2C;
	Wed,  6 Mar 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtP0IQve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AF1758D;
	Wed,  6 Mar 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763242; cv=none; b=HfloSzpcDLdH9gybCMD4VKpjl2VKYtq5ZWX2jtWOjud3jpMydMMPHAcQzR+b55fRlhe//OuxXDjt0w/Q7Nd8wo1ZiN2mk0Wld+NsbtfN9mSy7Sp/buJKQMhP5j+/c6DUir/g2U8DiaTJxXkMhYMEBVa0eirRPPIhTIZyxn18aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763242; c=relaxed/simple;
	bh=jNi48i2+fTqYr+Y58lY9CyC84hVExCbXJ7dH0iED4sI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDygA3DeCjJ1b32qWjXWYQM16/n+moQhdfSLyQyr84nxWkQvNKGRML78bkm36Zc+LXtSa4lGHSsvqHIqH5tqAtyOw843g4oGJ1nQ+vEMs1s7fVGnPU/sjYApsVQN+pFZdNGsqiRK8+dEKRPZpDa/wAI8W9bilXDsAd7IDL/qkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtP0IQve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C74C433F1;
	Wed,  6 Mar 2024 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709763241;
	bh=jNi48i2+fTqYr+Y58lY9CyC84hVExCbXJ7dH0iED4sI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dtP0IQveXPFOCfjtVqkLfh3XrhZydw2wvGttiP5imzfdj6UF8pR/3oVVVDXHVM9wf
	 L5DynDz528mMoNmkAjsvVEKLoTJeOOFK0aGrt4G7MpZZlfo8YCOMVaFY5w6uS68UOl
	 KPHggEKI4UpCxNd3RbRlor8FjUPahA4Sda7oG6+32DxJalTWl0uZzv3LTwOPKdjcyN
	 SSTMfFHzdL62LqHWHYxEhuhGe1qIGKZf6Swdb47VxalENqAxW4BdA2TtH9Pvt7Kh27
	 5G3ASoVBtGobZvXr0EtlANsJ/jeQ5WjI5NX06C0i2W4WuUeaPT6ejSGEZ5zt5BSUaP
	 yJpYbxSIdpvzQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/5] ASoC: wm8962: Enable oscillator if
 selecting WM8962_FLL_OSC
Message-Id: <170976323989.264577.10300247732017142650.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 22:13:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 16:14:35 +0000, Stuart Henderson wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
      commit: 03c7874106ca5032a312626b927b1c35f07b1f35
[2/5] ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
      commit: 6fa849e4d78b880e878138bf238e4fd2bac3c4fa
[5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
      commit: 96e202f8c52ac49452f83317cf3b34cd1ad81e18

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


