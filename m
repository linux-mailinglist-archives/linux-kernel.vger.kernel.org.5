Return-Path: <linux-kernel+bounces-131946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84C898DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E351F2BBAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3D130498;
	Thu,  4 Apr 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cXONBmin"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC44125B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254513; cv=none; b=dqtRd5DExA+4lUMbbzSFxzosq+4uNhTjCIt/ZsLHX92QCWxkAb6m89F/yNJkgm+fLnzhEmdW/IZWDrbihPpdQDZf86Qow9LbDOpi7WjrXKIlhBVUtBdjJhJP74CyP5oQnF1mcctOLhPzfFM7zIwNRxPsSHhJfgP3tlWoOFf4LGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254513; c=relaxed/simple;
	bh=yMTcvQjyx4yK2TgWYxBU/zVsUHL1XIcAf4s8MXZcTCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=tm9phqMSSUoVwVVVfTfAVb4aPwRq6WqB0Kwmq7MP5uq1wg189tsvo2XSXPfgA3r6r6vh8MVv97oU84LhA7IYO4LjrYKOvxu0p7UAYHZNjWGfg4GcxV3j1F2tfFg3UROL23IqQnnBSkWzamoZsrXqWpRC2HM3OEDG7pz5PzIc2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cXONBmin; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0486e3250so60101539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712254510; x=1712859310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PI0LLP9w1WjXiWU7aCp0TwHBscK/fXXWNmgARMtLns=;
        b=cXONBminWR2hS1KYDOsQm41lqwP5je3K7rCwiiI9YtpHpDR9rqN5QMX+cEctw8+igf
         9+dHVjWQ/aQ9Gj03PspBFuMUUxa3LCWpTbyWoLQz2Eiu/7RgqqzhEOfiMRtB+UifDCsG
         iCYdwplClB3o4mDWJvbPuYDqni2jeStaQ5Bv3LummGPRk5JqOXUtE9uyfsGX8imhGW9f
         peJJGC1jQLDEBIERtKPRfKAiPdE0/pZgVdBXiJQKml2RdyQJLPTLeXnMBhcKRZYLVG8Q
         sX6ZoNoAV8f6rzyt1E8NkbBJsf1KhdvW0btrqnFw/7xSLb3ZV34B8Yk5qqYHm6mWwsbt
         s5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254510; x=1712859310;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PI0LLP9w1WjXiWU7aCp0TwHBscK/fXXWNmgARMtLns=;
        b=vTkxmoGCfgA5J892/ySjqIrjCHuIimpE3b2yyeNeTOnGufUeaFtST/zaMiTKZPKFfH
         z2nuQT0U1ee8rNSI87RQv8oBYlK8oRLzgCbi6T3AZoRaNLy6UvrxE2yhogMWIFurXYpi
         4F0TqKL777DdREe4q/GcU5GbF0FFBe8AY6NN06wRk+ot2aDer1Te3fg4BITmu6sOD+7N
         61fL0q/H1Cy7IF9J2K4Qp3ve5++ZX/YqPoGGWyQ7y9OKjZ5GkQnq5y/4uUpt9aG5FefX
         5NXQhJuLo4btAhbmrmtjuD0YUHN8s7dsEAWdkUvspOSJ4K7gUKivS37EuTTGmIAtoQ76
         OGaA==
X-Gm-Message-State: AOJu0YxC37if+vpedMP+C7G6R2JMykyKTWflRh/q5qgDeMfF+F5zTV9l
	jBYXjnKZFPL22MYFpG8g/VVn/8D6hMfGQp+KOKlLJm6Yx7fz00xDL6W29W9PZZ8=
X-Google-Smtp-Source: AGHT+IH+Rz2ETv/jL0+emg9tpkztNGdXiBnx5+2D20KLbKT62Y5e+cMqoaoMr9jzNV+C6TVJwJWQdA==
X-Received: by 2002:a05:6602:4250:b0:7c8:55c2:63dc with SMTP id cc16-20020a056602425000b007c855c263dcmr616654iob.9.1712254510496;
        Thu, 04 Apr 2024 11:15:10 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id c60-20020a029642000000b00478ac4d9882sm4847957jai.53.2024.04.04.11.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:15:09 -0700 (PDT)
Message-ID: <0b817fa8-2a1c-4da4-b5d4-f36ac93dbfd9@sifive.com>
Date: Thu, 4 Apr 2024 13:15:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: thead: Rename T-Head PBMT to MAEE
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
 <20240329121414.688391-2-christoph.muellner@vrull.eu>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Heiko Stuebner <heiko@sntech.de>, Cooper Qu <cooper.qu@linux.alibaba.com>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240329121414.688391-2-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 2024-03-29 7:14 AM, Christoph Müllner wrote:
> T-Head's vendor extension to set page attributes has the name
> MAEE (MMU address attribute extension).
> Let's rename it, so it is clear what this referes to.
> 
> See also:
>   https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadmaee.adoc

My understanding is that MAEE is the name of the CSR bit and stands for "MMU (or
Memory) Attribute Extension Enable", so the name for the extension itself would
be "MAE" (just one E). This is similar to THEADISAEE => T-HEAD ISA Extension
Enable. Does that sound right?

Regards,
Samuel

> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>  arch/riscv/Kconfig.errata            |  8 ++++----
>  arch/riscv/errata/thead/errata.c     |  8 ++++----
>  arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 910ba8837add..2c24bef7e112 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -82,14 +82,14 @@ config ERRATA_THEAD
>  
>  	  Otherwise, please say "N" here to avoid unnecessary overhead.
>  
> -config ERRATA_THEAD_PBMT
> -	bool "Apply T-Head memory type errata"
> +config ERRATA_THEAD_MAEE
> +	bool "Apply T-Head's MMU address attribute (MAEE)"
>  	depends on ERRATA_THEAD && 64BIT && MMU
>  	select RISCV_ALTERNATIVE_EARLY
>  	default y
>  	help
> -	  This will apply the memory type errata to handle the non-standard
> -	  memory type bits in page-table-entries on T-Head SoCs.
> +	  This will apply the memory type errata to handle T-Head's MMU address
> +	  attribute extension (MAEE).
>  
>  	  If you don't know what to do here, say "Y".
>  
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index b1c410bbc1ae..8c8a8a4b0421 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -19,10 +19,10 @@
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
>  
> -static bool errata_probe_pbmt(unsigned int stage,
> +static bool errata_probe_maee(unsigned int stage,
>  			      unsigned long arch_id, unsigned long impid)
>  {
> -	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAEE))
>  		return false;
>  
>  	if (arch_id != 0 || impid != 0)
> @@ -140,8 +140,8 @@ static u32 thead_errata_probe(unsigned int stage,
>  {
>  	u32 cpu_req_errata = 0;
>  
> -	if (errata_probe_pbmt(stage, archid, impid))
> -		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
> +	if (errata_probe_maee(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_THEAD_MAEE);
>  
>  	errata_probe_cmo(stage, archid, impid);
>  
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index ea33288f8a25..7c377e137b41 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -23,7 +23,7 @@
>  #endif
>  
>  #ifdef CONFIG_ERRATA_THEAD
> -#define	ERRATA_THEAD_PBMT 0
> +#define	ERRATA_THEAD_MAEE 0
>  #define	ERRATA_THEAD_PMU 1
>  #define	ERRATA_THEAD_NUMBER 2
>  #endif
> @@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
>   * in the default case.
>   */
>  #define ALT_SVPBMT_SHIFT 61
> -#define ALT_THEAD_PBMT_SHIFT 59
> +#define ALT_THEAD_MAEE_SHIFT 59
>  #define ALT_SVPBMT(_val, prot)						\
>  asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
>  		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
>  			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
>  		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
> -			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
> +			ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)	\
>  		: "=r"(_val)						\
>  		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
> -		  "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
> +		  "I"(prot##_THEAD >> ALT_THEAD_MAEE_SHIFT),		\
>  		  "I"(ALT_SVPBMT_SHIFT),				\
> -		  "I"(ALT_THEAD_PBMT_SHIFT))
> +		  "I"(ALT_THEAD_MAEE_SHIFT))
>  
> -#ifdef CONFIG_ERRATA_THEAD_PBMT
> +#ifdef CONFIG_ERRATA_THEAD_MAEE
>  /*
>   * IO/NOCACHE memory types are handled together with svpbmt,
>   * so on T-Head chips, check if no other memory type is set,
> @@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(						\
>  	"slli    t3, t3, %3\n\t"					\
>  	"or      %0, %0, t3\n\t"					\
>  	"2:",  THEAD_VENDOR_ID,						\
> -		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
> +		ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)		\
>  	: "+r"(_val)							\
> -	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
> -	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
> -	  "I"(ALT_THEAD_PBMT_SHIFT)					\
> +	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAEE_SHIFT),		\
> +	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAEE_SHIFT),			\
> +	  "I"(ALT_THEAD_MAEE_SHIFT)					\
>  	: "t3")
>  #else
>  #define ALT_THEAD_PMA(_val)


