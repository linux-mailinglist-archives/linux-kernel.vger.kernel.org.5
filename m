Return-Path: <linux-kernel+bounces-81774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F48679FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5B329DD07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8312A17C;
	Mon, 26 Feb 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FMLCeEwZ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E312BE81
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960483; cv=none; b=rT/Psfs7WW7gMBw8f+zsH8a8IrHxCgLwWDT0MVXCNJv+4g0Bwyy4G2lUg8Jbdt7d0jLslFEZcteD/1F0e/NWyut0DZOAQV+kZr8TxLQPKS9NRER63pq4NC134lCQhU+W/ljZuMx82ZynLsAQDuS207BEKhuxj8wcgnye2SZTT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960483; c=relaxed/simple;
	bh=9ZO+k7p1X5BG5gLQi9CzSxrGFtzhnM6MFGltxOVCx7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gazPwoGtAgrhs1+LMf2rpXb0zh8VePVXOzDB19u1KqRdwbUdHEOJtv2yCN4kmMSrIcsA/uIHejbaOhgjsE+cpiOOoPr5KFqF52wXvocce21/wEjxHCEbtYPmwL5QCiSYR3rUd/15vVHncsgaMkul67E3wt0S+Ukw33/Aunjw8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FMLCeEwZ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beda6a274bso148068439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708960481; x=1709565281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnhDNqZldvfwo++1kr0TTTkp3od5W/IiFTP/MKj7Qek=;
        b=FMLCeEwZnzZUkMgda6NcaVQj8sN+ZF3lSphMUhcE8IvROlWUBgk6FGCk3zg0wADZ/b
         4/Ltmbpd0oNvCGDCSL2OF827S0LDNHgErXL9Xjkgf3YpS5VIgSz5d3alKn47nHNupxRb
         BPSIDOCsRLNE8nvxpUG3dBq+alSf5KpTw2ZeENCrck3tKm1AC6zRigygHJjCvuelYtub
         wB5D/+2H0LM8niEWYF+WO1+CD+6FyqczLR8lbiNojcxd1lprrZiSBoiANjDjJaJDDqxN
         Ubuup0e5+UOc+p6vNLIwdW8jI9eJYhm+3yU2Ols+f4482Ejm+7baOV+JwhlaRUcbCKKi
         2xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960481; x=1709565281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnhDNqZldvfwo++1kr0TTTkp3od5W/IiFTP/MKj7Qek=;
        b=QT/cXFH6zjGqzk7vJDhJh2cLicIyOXgO2c+qXIufL8r3Fo847DCagNS8nqe2Go1VuZ
         v/Yxhx6mS5FIgdmv7l3LKYo1/Zg6lqkuZLHxbmuNVVhp1bXa4NOH0f7boM/bnYYwEipl
         vBCpIi9MQEbsb0oRiMc1cbVfHSPCtBjcx9/dgWGUb1P6EeeiY0FriyOSyqk0Rabq/T4Q
         4UbTDHbEJLWvnup3kJ/DpmorAChQ4DIQuqqGm0O2qMF8LNH1N3LyLSIF25R7umUHHX2z
         cxmF/KAE/QOnEnIIyq5xIzVLKAy7vViukHPhe0goMmM2B9nRdIOiZb64/xoNbBrHwM35
         ik9w==
X-Forwarded-Encrypted: i=1; AJvYcCWXHGeHGpoPJvXAbgMtPtRerSF17oMB+rsgMMiJWndORb3tzLu8c5zChjCegz5h3vRfUPspdRYaMHaMgD7MJ+7w6LVK9GIYsucDOZKw
X-Gm-Message-State: AOJu0YyaS1CSvarIOY2wL9p40YsYgym/4YVWHj1UbPjDiXyQVNZxG4QV
	gNh+fLlK9rBgVJ+ADbWhV9ouB3dsbFBhE4eIi+JrAfSeGjlUOTZB+C1TxGtDdAE=
X-Google-Smtp-Source: AGHT+IHEaD4rR2rDzvAfb0spGPXwvQzyNLv0eR1h0rsYQclBtWakcm2H92kl96HePewGk7gyX70KWA==
X-Received: by 2002:a6b:4e12:0:b0:7c7:dca3:7e27 with SMTP id c18-20020a6b4e12000000b007c7dca37e27mr871256iob.17.1708960480771;
        Mon, 26 Feb 2024 07:14:40 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id d22-20020a5d9516000000b007c7b076f07asm1112155iom.15.2024.02.26.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:14:40 -0800 (PST)
Message-ID: <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
Date: Mon, 26 Feb 2024 09:14:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Damien Le Moal <dlemoal@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>
References: <20240226140649.293254-1-cleger@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240226140649.293254-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-02-26 8:06 AM, Clément Léger wrote:
> Deprecation of NOMMU support for riscv was discussed during LPC 2023
> [1]. Reasons for this involves lack of users as well as maintenance
> efforts to support this mode. psABI FDPIC specification also never
> made it upstream and last public messages of this development seems to
> date back from 2020 [2]. Plan the deprecation to be done in 2 years from

What are the criteria for delaying/canceling the removal? NOMMU support doesn't
rot nearly as fast as XIP; static PIE ELF works and is well specified; and as
mentioned at LPC, there are some users, even if "just for fun".

> now. Mark the Kconfig option as deprecated by adding a new dummy option
> which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
> is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
> select another one directly with a "select" in case of such CONFIG=n.
> Additionally, display a pr_err() message at boot time in case of NOMMU
> build to warn about upcoming deprecation.
> 
> Link: https://lpc.events/event/17/contributions/1478/ [1]
> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>  arch/riscv/Kconfig        | 8 ++++++++
>  arch/riscv/kernel/setup.c | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..8da58c102d3f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>  # set if we run in machine mode, cleared if we run in supervisor mode
>  config RISCV_M_MODE
>  	bool
> +	select NOMMU
>  	default !MMU
>  
>  # set if we are running in S-mode and can use SBI calls
> @@ -236,6 +237,13 @@ config MMU
>  	  Select if you want MMU-based virtualised addressing space
>  	  support by paged memory management. If unsure, say 'Y'.
>  
> +config NOMMU
> +	depends on !MMU
> +	bool "NOMMU kernel (DEPRECATED)"
> +	help
> +	  NOMMU kernel is deprecated and is scheduled for removal by
> +	  the beginning of 2027.
> +

The idiomatic way to display this kind of warning is a comment directive:

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4e890fb5b5a..b736440ce0f7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -248,6 +248,9 @@ config MMU
          Select if you want MMU-based virtualised addressing space
          support by paged memory management. If unsure, say 'Y'.

+comment "NOMMU support is deprecated (scheduled for removal in 2027)"
+       depends on !MMU
+
 config PAGE_OFFSET
        hex
        default 0xC0000000 if 32BIT && MMU

Regards,
Samuel

>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MMU
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..8799816ef0a6 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_set_dma_cache_alignment();
>  
>  	riscv_user_isa_enable();
> +
> +#if !defined(CONFIG_MMU)
> +	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");
> +#endif
>  }
>  
>  bool arch_cpu_is_hotpluggable(int cpu)


