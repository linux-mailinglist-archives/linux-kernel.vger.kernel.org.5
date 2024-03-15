Return-Path: <linux-kernel+bounces-104984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AD87D742
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304E61F22B32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B995A11B;
	Fri, 15 Mar 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="isPHTi0T"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A145A0F4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544420; cv=none; b=XYK813Z3Tncku2RZtYjMWqmg/mdOjXwPg4DV9zAxjdzcf5Iw/U9lwI3sHltavU/hgaX+w5SRJYNd0m6fmWAVJS9NHnNX0NRN/26Ka5mO5y6EogO2VA9SifrwxSHAs+uHWyVFQQhoaX+mVWkwbF6k/5Sm5KJQhuGoTvIpiip/uSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544420; c=relaxed/simple;
	bh=Zjv6sIG5TsfIjOfw5GN/h6HebnF+orhWYl3wzJnO5yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtZj49UqFeORa+aV+AhMWZmfr7eRqxU2vlTTML6/DVAI6DLmnKTp6S4p5nHpVEXVsaAV2S9s3QGasBCCcwFdafe4BwEAx0/lQRYg3nufVWX/rXa2UYiTYPT8a6XPBxDpUvgz3GMz1qjgKOaIAkwVwrCjnK+0Mh3N3c2qWXEXSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=isPHTi0T; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36678885723so16037935ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710544416; x=1711149216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ik0WgA0NYbsNgyUpEeTOF/vMyU1VZieyn2u6T3u4Jh4=;
        b=isPHTi0Tj3BlgaGWYN7DZ2zEeS7Q2TiziMDSdByYEECSq8Sfd8t+HpK9IN2zNtDAmX
         S4iZQMhhKNRllJ8wQ15osDHLQ6qz2XksJR/8xDkzEC0GEDHri3oWK4NGYYLAjbtcjJWE
         ZWiq2BXFYvIYawRvMkWEUr/vRkkKyhsGAYmtOoQuJ0uF48qQUFR5YxpTgvBsaknQlX8Q
         As+RzHEw2ljy2hzugUufDrgtkrApagztEsPFYu8V+sOq+L3+2YBBZwhx3BhLlBI7EEXo
         eNVXI2JzopiX9OnUSumJJM+sA1JtwotyYYk54g2WuA+VpxzMjWwQLs5xm1hE38n4eCF8
         LqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710544416; x=1711149216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ik0WgA0NYbsNgyUpEeTOF/vMyU1VZieyn2u6T3u4Jh4=;
        b=pWqVyqQlasNnzBoAHBIcN7OThT8ja1Q2c3kU2zH8Y7cqEmbBssAHXWJwKnXLPouVbO
         +ZmiKnIa/nqV9qC91Y3JS7ptKmOAFCuY1fI/W+G0bmOEFrEeIEgp0Kr1+NL3M2uEweDp
         O9rqn82z64K0W9lIGOxorS9Wb0h2osFCgLsf565GA3gr2m7uLT5HXhZvkhi9Eap6/Md/
         6/kWeswuuqNX/dTEXl76C0XqUaRh5BTY1vMsV0PPM3e2z+hsVQ8++/YBaRlsGUnNKPh+
         qYGRJlSUId8v7qBvNT50eY7osBDOKV8SWNl+tUPovf0Xw5sQwUP01fCg8akb8Ao3PRcy
         CjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGBkh++ALLJJaX3WDLod97LkFbgiSnRO+roTnGVBjEXR5vgdyclMDsycmcurE+fsVyq0o0fkCWPO8pe2GdrosNenqU+iQPtfYVqdvf
X-Gm-Message-State: AOJu0YzovKJu9zukx+sB2CZ5YEbvMkT0N8bDiZuQlBwWQFnAo6y0nKYu
	B7/rkRCnnIlOvoAJUYjI+SyF95F343BuhAAmMdbkQvfdc0uWEayHw5hcISbmje0=
X-Google-Smtp-Source: AGHT+IGmWV+7gORxW1R384X6QiwEgLn1AxgnTY/2dOT9BBzXCSKh7z21EEUx/s44+ntxvgCJXtMhfQ==
X-Received: by 2002:a92:d952:0:b0:366:1f42:dc53 with SMTP id l18-20020a92d952000000b003661f42dc53mr6424138ilq.18.1710544416406;
        Fri, 15 Mar 2024 16:13:36 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id r5-20020a056638044500b004773027eee2sm964542jap.12.2024.03.15.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:13:36 -0700 (PDT)
Message-ID: <b662bb30-d5e2-4bf0-a156-ac38461fcea2@sifive.com>
Date: Fri, 15 Mar 2024 18:13:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] riscv: errata: Add StarFive alternative ports
Content-Language: en-US
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com, conor.dooley@microchip.com,
 alexghiti@rivosinc.com, evan@rivosinc.com, ajones@ventanamicro.com,
 heiko@sntech.de, guoren@kernel.org, uwu@icenowy.me, jszhang@kernel.org,
 conor@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, leyfoon.tan@starfivetech.com,
 jeeheng.sia@starfivetech.com
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240314061205.26143-3-joshua.yeong@starfivetech.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240314061205.26143-3-joshua.yeong@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-14 1:12 AM, Joshua Yeong wrote:
> Add required ports of the Alternative scheme for
> StarFive CPU cores.
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  arch/riscv/Kconfig.errata            | 21 ++++++
>  arch/riscv/errata/Makefile           |  1 +
>  arch/riscv/errata/starfive/Makefile  |  1 +
>  arch/riscv/errata/starfive/errata.c  | 95 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h |  3 +
>  arch/riscv/include/asm/errata_list.h |  5 ++
>  arch/riscv/kernel/alternative.c      |  5 ++
>  7 files changed, 131 insertions(+)
>  create mode 100644 arch/riscv/errata/starfive/Makefile
>  create mode 100644 arch/riscv/errata/starfive/errata.c
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 910ba8837add..1438dd09533b 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -53,6 +53,16 @@ config ERRATA_SIFIVE_CIP_1200
>  
>  	  If you don't know what to do here, say "Y".
>  
> +config ERRATA_STARFIVE
> +	bool "StarFive errata"
> +	depends on RISCV_ALTERNATIVE
> +	help
> +	  All StarFive errata Kconfig depend on this Kconfig. Disabling
> +	  this Kconfig will disable all StarFive errata. Please say "Y"
> +	  here if your platform uses StarFive CPU cores.
> +
> +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> +
>  config ERRATA_STARFIVE_JH7100
>  	bool "StarFive JH7100 support"
>  	depends on ARCH_STARFIVE
> @@ -72,6 +82,17 @@ config ERRATA_STARFIVE_JH7100
>  	  Say "Y" if you want to support the BeagleV Starlight and/or
>  	  StarFive VisionFive V1 boards.
>  
> +config ERRATA_STARFIVE_CMO
> +	bool "Apply StarFive cache management errata"
> +	depends on ERRATA_STARFIVE && MMU
> +	select RISCV_DMA_NONCOHERENT
> +	default y
> +	help
> +	  This will apply the cache management errata to handle the
> +	  non-standard handling on non-coherent operations on StarFive cores.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  config ERRATA_THEAD
>  	bool "T-HEAD errata"
>  	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index 8a2739485123..4713a686b9f7 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -4,4 +4,5 @@ endif
>  
>  obj-$(CONFIG_ERRATA_ANDES) += andes/
>  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> +obj-$(CONFIG_ERRATA_STARFIVE) += starfive/
>  obj-$(CONFIG_ERRATA_THEAD) += thead/
> diff --git a/arch/riscv/errata/starfive/Makefile b/arch/riscv/errata/starfive/Makefile
> new file mode 100644
> index 000000000000..2d644e19caef
> --- /dev/null
> +++ b/arch/riscv/errata/starfive/Makefile
> @@ -0,0 +1 @@
> +obj-y += errata.o
> diff --git a/arch/riscv/errata/starfive/errata.c b/arch/riscv/errata/starfive/errata.c
> new file mode 100644
> index 000000000000..3ee360cd5e81
> --- /dev/null
> +++ b/arch/riscv/errata/starfive/errata.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Erratas to be applied for StarFive CPU cores
> + *
> + * Copyright (C) 2024 Shanghai StarFive Technology Co., Ltd.
> + *
> + * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
> + */
> +
> +#include <linux/memory.h>
> +#include <linux/module.h>
> +
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/errata_list.h>
> +#include <asm/patch.h>
> +#include <asm/processor.h>
> +#include <asm/sbi.h>
> +#include <asm/vendorid_list.h>
> +
> +#define STARFIVE_JH8100_DUBHE90_MARCHID	0x80000000DB000090UL
> +#define STARFIVE_JH8100_DUBHE90_MIMPID	0x0000000020230930UL
> +#define STARFIVE_JH8100_DUBHE80_MARCHID	0x80000000DB000080UL
> +#define STARFIVE_JH8100_DUBHE80_MIMPID	0x0000000020230831UL
> +#define STARFIVE_JH8100_L3		0x40
> +
> +static bool errata_probe_cmo(unsigned int stage, unsigned long arch_id,
> +			      unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_STARFIVE_CMO))
> +		return false;
> +
> +	if ((arch_id != STARFIVE_JH8100_DUBHE90_MARCHID ||
> +	    impid != STARFIVE_JH8100_DUBHE90_MIMPID) &&
> +	    (arch_id != STARFIVE_JH8100_DUBHE80_MARCHID ||
> +	    impid != STARFIVE_JH8100_DUBHE80_MIMPID))
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	riscv_cbom_block_size = STARFIVE_JH8100_L3;
> +	riscv_noncoherent_supported();

This patch doesn't add any alternatives, so you don't need to use the errata
framework. Please move these two lines to the cache driver -- see
drivers/cache/sifive_ccache.c -- and then you can drop this patch.

Regards,
Samuel

> +
> +	return true;
> +}
> +
> +static u32 starfive_errata_probe(unsigned int stage,
> +			      unsigned long archid, unsigned long impid)
> +{
> +	u32 cpu_req_errata = 0;
> +
> +	if (errata_probe_cmo(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_STARFIVE_CMO);
> +
> +	return cpu_req_errata;
> +}
> +
> +void __init_or_module starfive_errata_patch_func(struct alt_entry *begin,
> +					         struct alt_entry *end,
> +					         unsigned long archid,
> +						 unsigned long impid,
> +						 unsigned int stage)
> +{
> +	struct alt_entry *alt;
> +	u32 cpu_apply_errata = 0;
> +	u32 tmp;
> +	u32 cpu_req_errata;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +
> +	cpu_req_errata = starfive_errata_probe(stage, archid, impid);
> +
> +	for (alt = begin; alt < end; alt++) {
> +		if (alt->vendor_id != STARFIVE_VENDOR_ID)
> +			continue;
> +		if (alt->patch_id >= ERRATA_STARFIVE_NUMBER)
> +			continue;
> +
> +		tmp = (1U << alt->patch_id);
> +		if (cpu_req_errata & tmp) {
> +			mutex_lock(&text_mutex);
> +			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> +					  alt->alt_len);
> +			mutex_unlock(&text_mutex);
> +			cpu_apply_errata |= tmp;
> +		}
> +	}
> +
> +	if (stage != RISCV_ALTERNATIVES_MODULE &&
> +	    cpu_apply_errata != cpu_req_errata) {
> +		pr_warn("WARNING: Missing StarFive errata patches! \n");
> +	    }
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 3c2b59b25017..8f5e6883db97 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -51,6 +51,9 @@ void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  			      unsigned long archid, unsigned long impid,
>  			      unsigned int stage);
> +void starfive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +			     unsigned long archid, unsigned long impid,
> +			     unsigned int stage);
>  void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  			     unsigned long archid, unsigned long impid,
>  			     unsigned int stage);
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index ea33288f8a25..1cd5ba3a1466 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -22,6 +22,11 @@
>  #define	ERRATA_SIFIVE_NUMBER 2
>  #endif
>  
> +#ifdef CONFIG_ERRATA_STARFIVE
> +#define	ERRATA_STARFIVE_CMO 0
> +#define	ERRATA_STARFIVE_NUMBER 1
> +#endif
> +
>  #ifdef CONFIG_ERRATA_THEAD
>  #define	ERRATA_THEAD_PBMT 0
>  #define	ERRATA_THEAD_PMU 1
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 319a1da0358b..deedd4b76472 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -52,6 +52,11 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
>  		cpu_mfr_info->patch_func = sifive_errata_patch_func;
>  		break;
>  #endif
> +#ifdef CONFIG_ERRATA_STARFIVE
> +	case STARFIVE_VENDOR_ID:
> +		cpu_mfr_info->patch_func = starfive_errata_patch_func;
> +		break;
> +#endif
>  #ifdef CONFIG_ERRATA_THEAD
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func = thead_errata_patch_func;


