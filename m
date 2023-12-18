Return-Path: <linux-kernel+bounces-4049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62717817737
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EF02856BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E93D546;
	Mon, 18 Dec 2023 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp7stAMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31F42375;
	Mon, 18 Dec 2023 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2331e7058aso242144966b.2;
        Mon, 18 Dec 2023 08:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702916215; x=1703521015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bezxA4w3BofKoayOrhRD9PM6sHufVYtq2w+UEfMweo=;
        b=bp7stAMFGAuiGiMOeyZ6ts3Ga2hDTGmygl8FkiAZBqjzwRURMUS4OCyQD04zO+xGmG
         LaiME3hslPgFuWlfiMRwQrEswv8UD5l3luGVx93JMOR24FdrjsxI8dESDOol5q6J2x1y
         uguQRFcr480GZMzSEFVGgeEPyvI264X0gD4W8N/1LV3OMD18NE5X3dEFSciFnLZetaMv
         raUJUhk+t1DOQ5Va/EEyE9ntF8vYRk0wHf9oycQjpBrM6fK8SpngU7cc+YMWwF7aoYOA
         ZgmhVL2vaR4PS2wX/ymjmBXCV3vRpRE21I7dmecpAJrsff9xYDWJ01hbmTN/MdDxfZ17
         miSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916215; x=1703521015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bezxA4w3BofKoayOrhRD9PM6sHufVYtq2w+UEfMweo=;
        b=pdfm/ZZi5yPmZhSU3ZOn/hv2LXXc1B2hd8kou0u0IjMp1qzJIA9fkDPrptxmVAL3Lp
         Szkvk1A3WcDDmLuctWwCsLM04lK+jsAhUsQ3OrK/4tIGlaZ38PVdpeLDb8QSFW7kYI18
         zQDEiDPnMooHFRq1NhSrL5+Lx+guboWHNM6hTZH36+Uo3U5u5NjSvAUT/QbbJWoiwjIT
         y1O9Kbk1dFUWHDUZNP7lWsQlfKzFy6cFEHlByzup4xoxpq4436Fghg0LyKlPdwb9S0oJ
         Pt92gLZoPqrRIpXUMd+BiaDGQviK1o2CnAMF/hZDMtjzHUF0nPzbKTq9kxvk9d/9gZ39
         biig==
X-Gm-Message-State: AOJu0YxW7BswB1a3wIh0YbrJEnHYDPTJ4ZMoYFHP5Be8Ji4FOjurzNGj
	SMdT2LdvA9LhONbq/2iWhNg=
X-Google-Smtp-Source: AGHT+IGGXZM869rCvborKIS6+AaZ6Fg2Fee5h0yXK5Lip2vogxh1X3uCF4McDxJ8OOYxEvnqggmR6w==
X-Received: by 2002:a17:906:516:b0:a23:4e3a:a643 with SMTP id j22-20020a170906051600b00a234e3aa643mr528083eja.168.1702916214829;
        Mon, 18 Dec 2023 08:16:54 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id fj8-20020a1709069c8800b00a1d5c342674sm14186209ejc.27.2023.12.18.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:16:54 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject:
 Re: [PATCH v2 5/5] cpufreq: Make sun50i h6 cpufreq Kconfig option arch
 generic
Date: Mon, 18 Dec 2023 17:16:52 +0100
Message-ID: <5737049.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20231218110543.64044-6-fusibrandon13@gmail.com>
References:
 <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218110543.64044-6-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 12:05:43 CET je Brandon Cheo Fusi napisal(a):
> Move the Allwinner SUN50I cpufreq driver from Kconfig.arm to the
> main Kconfig file so it supports other architectures, like RISC-V
> in our case, and drop the 'ARM_' prefix.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/Kconfig     | 12 ++++++++++++
>  drivers/cpufreq/Kconfig.arm | 12 ------------
>  drivers/cpufreq/Makefile    |  2 +-
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 35efb53d5..50aa66cfc 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -301,5 +301,17 @@ config QORIQ_CPUFREQ
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
>  	  which are capable of changing the CPU's frequency dynamically.
>  
> +config ALLWINNER_SUN50I_CPUFREQ_NVMEM
> +	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
> +	depends on ARCH_SUNXI
> +	depends on NVMEM_SUNXI_SID
> +	select PM_OPP
> +	help
> +	  This adds the nvmem based CPUFreq driver for Allwinner
> +	  h6/D1 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sun50i-cpufreq-nvmem.
> +
>  endif
>  endmenu
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index f91160689..98b8e6eef 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -29,18 +29,6 @@ config ACPI_CPPC_CPUFREQ_FIE
>  
>  	  If in doubt, say N.
>  
> -config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
> -	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
> -	depends on ARCH_SUNXI
> -	depends on NVMEM_SUNXI_SID
> -	select PM_OPP
> -	help
> -	  This adds the nvmem based CPUFreq driver for Allwinner
> -	  h6 SoC.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called sun50i-cpufreq-nvmem.
> -
>  config ARM_APPLE_SOC_CPUFREQ
>  	tristate "Apple Silicon SoC CPUFreq support"
>  	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b..110b676d2 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -78,7 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
> -obj-$(CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
> +obj-$(CONFIG_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o

This should be moved, so it's sorted alphabetically.

Best regards,
Jernej

>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
> 





