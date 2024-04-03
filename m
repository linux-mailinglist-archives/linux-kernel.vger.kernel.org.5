Return-Path: <linux-kernel+bounces-129846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5D89712F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD1AB299E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EA14830F;
	Wed,  3 Apr 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGs5CDfT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C00148315;
	Wed,  3 Apr 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151165; cv=none; b=AHAoMRKisanq3xL4m1Gg0dFWDhdTZjfMAo3O+oC8K7vICDyJCJwlBsk+QFcnQEJG/Nq/pVR9Zfq9XKf757/ey4J6kr+t8oCNj7oWCZXYbDW626V1ff1sIuY4QL2kq1COagkDWFKh9r/3hKKJ8mAut8VNw8ww6bECF5Xzve/S5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151165; c=relaxed/simple;
	bh=KGuykfkTUFTUvwCIx2Bu71rwb8J7ZDimIljxvcChLVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U67LICEcVmmHT6ybr9xipDIMkJ1xIVESwyKIFO+ZW5f0eXI8kk3MXIWnLkiroLW8mc8h9eq51pTc9DUicm6Av0od4L4OIGeKnp37AbBYdHnTJLfsREMDFQEdz410iPmpuAKPCNe3xqHYs1bE5t8v8Egb9WUoN6TjMWUk2ZDIEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGs5CDfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5FDC433F1;
	Wed,  3 Apr 2024 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151165;
	bh=KGuykfkTUFTUvwCIx2Bu71rwb8J7ZDimIljxvcChLVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gGs5CDfTtJ8DRevtHYPlEtkmSdntQTRr3R1+3dSrKWIJIuCbLUrQDlE/cHpjdoe3y
	 +raoctoAxBVCwyz4xj1i9e0tJYdqEBIlEbd71TFJjDxW7Bikp5HWBTUhu6ZKVcrL90
	 PgcLWvbLCnFJAmkounW+dDyb1gtrFXXjoNV408omeL2vYjsRe8iBxlX7rF8/Ha3B7B
	 vqTdhC86ZYI1lkoQED3WDoCAIYNBu7USsRNttmF3mxq0oVIKFHCmpwmoVqkZUana3j
	 axNHy8/mPAYDqKrYRxQfMFIBZA/nMP0kb1CP0ACg/LsOgNMFvVXsdxjvdpt+vvDyli
	 oTOKAqQuGbpsQ==
From: Mark Brown <broonie@kernel.org>
To: alexander.sverdlin@siemens.com, carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, haibo.chen@nxp.com, jun.li@nxp.com, linux-imx@nxp.com
In-Reply-To: <20240403084029.2000544-1-carlos.song@nxp.com>
References: <20240403084029.2000544-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: remove redundant
 spi_controller_put call
Message-Id: <171215116351.907765.4790730663496497496.b4-ty@kernel.org>
Date: Wed, 03 Apr 2024 14:32:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 03 Apr 2024 16:40:29 +0800, carlos.song@nxp.com wrote:
> devm_spi_alloc_controller will allocate an SPI controller and
> automatically release a reference on it when dev is unbound from
> its driver. It doesn't need to call spi_controller_put explicitly
> to put the reference when lpspi driver failed initialization.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: remove redundant spi_controller_put call
      commit: bff892acf79cec531da6cb21c50980a584ce1476

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


