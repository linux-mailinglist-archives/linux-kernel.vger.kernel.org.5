Return-Path: <linux-kernel+bounces-108076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139988059E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F46A283C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2A3A1C7;
	Tue, 19 Mar 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ouxU6D/P"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85E39FD6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877585; cv=none; b=mmhiUDvPElwLBR5ffxI16q86b6nVL28/cCi3nSf82GQptDZhGo0z0SOAKK/R/X/sQl9R8tKjPa6CX1wtos5XbGRIOtyT0X3g8oqwomDx50bTl9aosSB1JqVsBT3b8pdf+iHPpmOnZzQNc6CRCpeb880W6vsL/FGbrIkr8z1ThW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877585; c=relaxed/simple;
	bh=E0laA+maX+3WM1LAyUqrdePpnPI8sjcd5w4HIpjLOas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZgBiFnJLOdD2yUQYBWOE5kmTGI8yS2UJsmlgD+v+pretXJyVslkvvex1OGOrKXVJWx2JRDiiIIRYRgScGimjkbW+C0xxrcTRqzcxpgv64NeV/s6B8qqaUfwOq8ZHhb5yxPRw3UDggXK+tGIaNKwWsYZo2ZzE1iAw4tsxmMZa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ouxU6D/P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso3294055b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710877582; x=1711482382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KQUlQtO0GZQ94WgTKWt7iDIjBKiCX2QYDYayr502WQ=;
        b=ouxU6D/PMlDYIeusihbrYssUUTSyxio6DXaFkt9aMmSqyZGXrooq7iEkWde1p0wI6U
         mpA2NP46BTRyj2CBsAk0R2AS9hj61VAm8stOUTeIS8u2hqxiYqBo6klOnL07Xvaxt6eu
         F+8CSOrRsYd8hAEOP7WF6eKRCYsFMfuCqQT69LOK1kSsQitr4/U6Hzk3Y7dHqm7EqSp2
         OV31i/wSVLF/67h/2yTdGmvKqY6+107BjEtyW7CGShQt34BXTIR3amgplkuO9dx6915u
         iTDVAYZa3OMwrjvUD4K0k8mjqtBacot1tIDD/e0W0WMU+8Odz+8nYoiH++8rIfqfjzqo
         sYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877582; x=1711482382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KQUlQtO0GZQ94WgTKWt7iDIjBKiCX2QYDYayr502WQ=;
        b=KMOnfuBs1cIX+utd4/PrPMhGev+hMWDfCy2ipvUB+GPhi8btsEPUz2PRhWYXC3ddgg
         KjEUcj2CCBf4ioEZeMpNN3mhBU29QsiEYYe+eYyOLZWJ4fP2x6P0Z3oUGDUWbJ6cd5Is
         mrT+cTRpjWcuC7eidrx1yK2a19z3A/sH+fWIWPtQH1wV7TePJV5CH70/QcRaaFo79HjH
         6wckk+xwa9Ml+alkTI674YkitVDLocHDszKRqhB15K86t11BxEDPKE8bLdQmbKUXIYnE
         nQs5UV/slXEicS7jqP5/zeHajIDf8B5n6wacFL90QolKS2GJgZQeK3h+umgz+/sxKeV+
         zX6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4eN07KF2SuuHQgr/wIN88y6/9M6ph4XgDWm9tMkXRm4FCJ7tbZdEY7GzGQsiDSMjgpYKYzwLLeV70IG/UUIaXGQu/ci0RKrIu0G7/
X-Gm-Message-State: AOJu0YyxJUyY7Qd0G9HXUWDwSz24pChqX4LAJsnZuO+OLye2wmJfHabn
	mQ2kWaTBDGBFGTCi7hBg7vKrKv+dOsEus0PBMJFCGg0HZmKNVS7GOKWnd116lpk=
X-Google-Smtp-Source: AGHT+IH6Fr5ZQEaEEHnSwEVcf9F4d8R5mfhqSyj3jB2/xuGnf1ofBEDsSI4KPtl9LfuHjq/4erJvMg==
X-Received: by 2002:a05:6a20:d045:b0:1a3:579f:2c5c with SMTP id hv5-20020a056a20d04500b001a3579f2c5cmr9441879pzb.53.1710877582405;
        Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b006da96503d9fsm10149006pfi.109.2024.03.19.12.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
Message-ID: <7d69fac0-4cd1-4db6-b19f-fb5a418549ab@rivosinc.com>
Date: Tue, 19 Mar 2024 12:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
Content-Language: en-US
To: Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org
Cc: aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
 xiaobo55x@gmail.com, ardb@kernel.org
References: <20240318020916.1299190-1-haibo1.xu@intel.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240318020916.1299190-1-haibo1.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/24 19:09, Haibo Xu wrote:
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> 
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
> Changes since v1
>    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
>      definition(suggested by Ard)
>    - Minor clean up for comments (Ard)
> ---
>   arch/riscv/Kconfig                   | 11 +++++++++++
>   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
>   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
>   3 files changed, 48 insertions(+)
>   create mode 100644 arch/riscv/include/asm/dmi.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8ebafe337eac..3639151cb4ef 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -952,6 +952,17 @@ config EFI
>   	  allow the kernel to be booted as an EFI application. This
>   	  is only useful on systems that have UEFI firmware.
>   
> +config DMI
> +	bool "Enable support for SMBIOS (DMI) tables"
> +	depends on EFI
> +	default y
> +	help
> +	  This enables SMBIOS/DMI feature for systems.
> +
> +	  This option is only useful on systems that have UEFI firmware.
> +	  However, even with this option, the resultant kernel should
> +	  continue to boot on existing non-UEFI platforms.
> +
>   config CC_HAVE_STACKPROTECTOR_TLS
>   	def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
>   
> diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.h
> new file mode 100644
> index 000000000000..ca7cce557ef7
> --- /dev/null
> +++ b/arch/riscv/include/asm/dmi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Intel Corporation
> + *
> + * based on arch/arm64/include/asm/dmi.h
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#ifndef __ASM_DMI_H
> +#define __ASM_DMI_H
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#define dmi_early_remap(x, l)		memremap(x, l, MEMREMAP_WB)
> +#define dmi_early_unmap(x, l)		memunmap(x)
> +#define dmi_remap(x, l)			memremap(x, l, MEMREMAP_WB)
> +#define dmi_unmap(x)			memunmap(x)
> +#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
> +
> +#endif
> diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
> index 09525fb5c240..c3bfb9e77e02 100644
> --- a/drivers/firmware/efi/riscv-runtime.c
> +++ b/drivers/firmware/efi/riscv-runtime.c
> @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
>   {
>   	efi_virtmap_unload();
>   }
> +
> +static int __init riscv_dmi_init(void)
> +{
> +	/*
> +	 * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> +	 * be called early because dmi_id_init(), which is an arch_initcall
> +	 * itself, depends on dmi_scan_machine() having been called already.
> +	 */
> +	dmi_setup();
> +
> +	return 0;
> +}
> +core_initcall(riscv_dmi_init);

Reviewed-by: Atish Patra <atishp@rivosinc.com>

