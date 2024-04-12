Return-Path: <linux-kernel+bounces-142147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ADE8A2817
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A414283681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DAF5029E;
	Fri, 12 Apr 2024 07:31:02 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10D4EB24;
	Fri, 12 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907061; cv=none; b=nTi6hImbI/vPV7VtNFj8YuYUaXEcbW95Kl1MyVRskpvwGyz4iLv90zTdI8UYPbwL5BfG5TUiYrgw5uw27z0OV0uEJIPMoCoypoD/CkopsXO7fC3YXB/GC4hMY33djq4vBx8pZLQ4Kz2F0i0vnVPgYPhDUVaB42+piekfC75r11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907061; c=relaxed/simple;
	bh=JzUBqVV2GtDa8Lur/NtFXs7KTrObWRaTEOv5fRP7nkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo6eCuJTY1QmfCH6sxUjG3O7IvqeCazqduAu++JC0JJ7um2DdTYeggh8InFR9nYhDjFIqt/sh4DTP7JUYAytvRmQGvk/WomApr4Yo2+BE7962+vneCxENCLoLsjW5T0jIhLo0FbPQgYAm5VtV922tDy4q0zhJsog58PygaBxT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBMx-000lgX-Jc; Fri, 12 Apr 2024 15:30:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:31:01 +0800
Date: Fri, 12 Apr 2024 15:31:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: davem@davemloft.net, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
	airlied@gmail.com, daniel@ffwll.ch, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 0/5] Add Tegra Security Engine driver
Message-ID: <ZhjjNWKexg8p8cJp@gondor.apana.org.au>
References: <20240403100039.33146-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403100039.33146-1-akhilrajeev@nvidia.com>

On Wed, Apr 03, 2024 at 03:30:34PM +0530, Akhil R wrote:
> Add support for Tegra Security Engine which can accelerates various
> crypto algorithms. The Engine has two separate instances within for
> AES and HASH algorithms respectively.
> 
> The driver registers two crypto engines - one for AES and another for
> HASH algorithms and these operate independently and both uses the host1x
> bus. Additionally, it provides  hardware-assisted key protection for up to
> 15 symmetric keys which it can use for the cipher operations.
> 
> v6->v7:
> * Move fallback_tfm and fallback_req to end of struct
> * Set reqsize and statesize based on fallback_tfm
> * Remove ofb(aes)
> v5->v6:
> * Move copy/pase of intermediate results in export()/import() to
>   'update()' callback for CMAC as well.
> * Check for rctx size when using fallback alg.
> * Updated blocksizes to align with generic implementation
> * Combined GCM and CCM init into aead_cra_init
> * Updates to handle invalid cases better
> * Reduce log levels for invalid cases to dev_dbg
> v4->v5:
> * Move copy/paste of intermediate results in export()/import() to
>   'update()' callback
> v3->v4:
> * Remove unused header in bindings doc.
> * Update commit message in host1x change.
> * Fix test bot warning.
> v2->v3:
> * Update compatible in driver and device trees.
> * Remove extra new lines and symbols in binding doc.
> v1->v2:
> * Update probe errors with 'dev_err_probe'.
> * Clean up function prototypes and redundant prints.
> * Remove readl/writel wrappers.
> * Fix test bot warnings.
> 
> 
> Akhil R (5):
>   dt-bindings: crypto: Add Tegra Security Engine
>   gpu: host1x: Add Tegra SE to SID table
>   crypto: tegra: Add Tegra Security Engine driver
>   arm64: defconfig: Enable Tegra Security Engine
>   arm64: tegra: Add Tegra Security Engine DT nodes
> 
>  .../crypto/nvidia,tegra234-se-aes.yaml        |   52 +
>  .../crypto/nvidia,tegra234-se-hash.yaml       |   52 +
>  MAINTAINERS                                   |    5 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   16 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/crypto/Kconfig                        |    8 +
>  drivers/crypto/Makefile                       |    1 +
>  drivers/crypto/tegra/Makefile                 |    9 +
>  drivers/crypto/tegra/tegra-se-aes.c           | 1933 +++++++++++++++++
>  drivers/crypto/tegra/tegra-se-hash.c          | 1060 +++++++++
>  drivers/crypto/tegra/tegra-se-key.c           |  156 ++
>  drivers/crypto/tegra/tegra-se-main.c          |  439 ++++
>  drivers/crypto/tegra/tegra-se.h               |  560 +++++
>  drivers/gpu/host1x/dev.c                      |   24 +
>  14 files changed, 4316 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
>  create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
>  create mode 100644 drivers/crypto/tegra/Makefile
>  create mode 100644 drivers/crypto/tegra/tegra-se-aes.c
>  create mode 100644 drivers/crypto/tegra/tegra-se-hash.c
>  create mode 100644 drivers/crypto/tegra/tegra-se-key.c
>  create mode 100644 drivers/crypto/tegra/tegra-se-main.c
>  create mode 100644 drivers/crypto/tegra/tegra-se.h
> 
> -- 
> 2.43.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

