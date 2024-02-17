Return-Path: <linux-kernel+bounces-69709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5613858D90
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA17283168
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F491CAB3;
	Sat, 17 Feb 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FwTE1kEj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C41C2BC
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708152653; cv=none; b=MtIIFJaOHEO+r49fXtgLk4oKFpoU8LqWBp5IGwfPDEC5pX3TPWQCTeVDayaHrgIpn9c+I/ny4jfPF0htg3stNd9jGP6S2YfFSe+P9ktMmJ75b4t6xBWXx4EMTkgkEC5Gvvn2Ol23wRu+ykqX4fdCC2s/6MR1J3qiVUXKK/vdCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708152653; c=relaxed/simple;
	bh=qcMK+mURa9874jU0PVCvy2wIzqu0h8z9BCMIzikP4I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNlYbo1hlGwt6gscSeQ8CgbfBjO0OiuCpFIDAM/fa0dvy6HsVGzgeADFgR0EUSUovAel365dEmYj+mzgrQNfjtzzCa3i6W9lF7iHKjdPWSDQOxuO3w6MsshbIH8x8kc2wDPk8xlJIx+nw/2KkPJxSCDdxIyPboljMVZAjHcuR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FwTE1kEj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d934c8f8f7so28752885ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708152651; x=1708757451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0q5qNIApr2OHWTfe/JN5Axwx5QFdCs/VPp5utoSVVg=;
        b=FwTE1kEj8HOolxCjt0151cLgEna5eDUBBoLRhpxQHvxUlq3tQKXlJERIgli9ZEmEA3
         XJV/fNdSyPsnaJ+JOYXnwgQlD48CrFfLBNeemAKEcLpCzaNHI/oCia22tKVsicyGlMqq
         Npaq0Q5RdenO7WO/MSM4g1I1jlyNU3H4tI7ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708152651; x=1708757451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0q5qNIApr2OHWTfe/JN5Axwx5QFdCs/VPp5utoSVVg=;
        b=knDN5IsFPngiPgSVfpLDeMhY7uTIkz+ofqRZF8JL/eyReGeFLkMlGNxTQTGVy7cpUs
         n+cs0TYTtaTwQ2irMQcYQ2xvU3anS4XcAO8TjVAhES0T02ErwcRWhg/hvle8lTPhzVTM
         G/L1tTfuo6Yni+VdZDX/LMP8oKsRBV2RWlVGAuToYWjh21c3Dsk4kGOwpaSSnHxWGmVP
         XHwC/cMgCZtRljqxCln4g1ufqOLMCL/FDVEAnL+0YHlvLogmxBnNy+QVEbZzYlhLhoBF
         sxyDnoi66ClIZCNCH+j76bY07MHMhmmx7/oCHZ9hFthUzOrSMz8Qs9IH5t41AVkFEX3W
         hadw==
X-Forwarded-Encrypted: i=1; AJvYcCUO4XgpsqTSjp9fouRMl0zpgM+D++SjDvC6StXEHt0bmQ1oEw2lEmmORNESoZV92pC7bkf3kUaR0gWEmfMxtcuJF7b7eXTOcTZmwCDC
X-Gm-Message-State: AOJu0YzunPPDhQOv60OlulAmltcN2vVHWVRsFNmxlcuA3pY80WcWDRzH
	j20hsZdGaQe0/gKmM+iRwvYB0Pcm5zYTwVHQNJg3BXWj4n/h6ZwOxpDohdSSBA==
X-Google-Smtp-Source: AGHT+IFSRrYHCfvNmI4dBaEfzwYrVFvg0hjm2ZEaDRlwH/ZNcq3QNYV4GRamj4PDHKIaB210IqDS8w==
X-Received: by 2002:a17:902:eb83:b0:1db:aef8:8db4 with SMTP id q3-20020a170902eb8300b001dbaef88db4mr3585714plg.24.1708152650948;
        Fri, 16 Feb 2024 22:50:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db60446abdsm815390plp.262.2024.02.16.22.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 22:50:50 -0800 (PST)
Date: Fri, 16 Feb 2024 22:50:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Kostya Serebryany <kcc@google.com>, Vitaly Buka <vitalybuka@google.com>,
	glider@google.com
Cc: Evgeniy Stepanov <eugenis@google.com>,
	Daniel Micay <danielmicay@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Pratyush Anand <panand@redhat.com>,
	Dong Bo <dongbo4@huawei.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Rik van Riel <riel@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Reid Kleckner <rnk@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, address-sanitizer@googlegroups.com
Subject: Re: [PATCH] mm: Revert x86_64 and arm64 ELF_ET_DYN_BASE base
Message-ID: <202402162238.E5D08F5968@keescook>
References: <20170807201542.GA21271@beast>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807201542.GA21271@beast>

*extreme thread[1] necromancy*

On Mon, Aug 07, 2017 at 01:15:42PM -0700, Kees Cook wrote:
> Moving the x86_64 and arm64 PIE base from 0x555555554000 to 0x000100000000
> broke AddressSanitizer. This is a partial revert of:
> 
>   commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
>   commit 02445990a96e ("arm64: move ELF_ET_DYN_BASE to 4GB / 4MB")
> 
> The AddressSanitizer tool has hard-coded expectations about where
> executable mappings are loaded. The motivation for changing the PIE
> base in the above commits was to avoid the Stack-Clash CVEs that
> allowed executable mappings to get too close to heap and stack. This
> was mainly a problem on 32-bit, but the 64-bit bases were moved too,
> in an effort to proactively protect those systems (proofs of concept
> do exist that show 64-bit collisions, but other recent changes to fix
> stack accounting and setuid behaviors will minimize the impact).

I happened to be looking at this again today, and wondered where things
stood. It seems like ASan's mappings are documented here:
https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit

This implies that it would be safe to move the ELF_ET_DYN_BASE from
0x555555554000 down to 0x200000000000, since the shadow map ends at
0x10007fff7fff. (Well, anything above there would work, I was just
picking a "round" number above it. We could just as well use
0x100080000000, I think.)

Is this correct? I'd like to open up some more room between mmap and
stack...

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20170807201542.GA21271@beast/

> 
> The new 32-bit PIE base is fine for ASan (since it matches the ET_EXEC
> base), so only the 64-bit PIE base needs to be reverted to let x86 and
> arm64 ASan binaries run again. Future changes to the 64-bit PIE base on
> these architectures can be made optional once a more dynamic method for
> dealing with AddressSanitizer is found. (e.g. always loading PIE into
> the mmap region for marked binaries.)
> 
> Reported-by: Kostya Serebryany <kcc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/elf.h | 4 ++--
>  arch/x86/include/asm/elf.h   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index acae781f7359..3288c2b36731 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -114,10 +114,10 @@
>  
>  /*
>   * This is the base location for PIE (ET_DYN with INTERP) loads. On
> - * 64-bit, this is raised to 4GB to leave the entire 32-bit address
> + * 64-bit, this is above 4GB to leave the entire 32-bit address
>   * space open for things that want to use the area for 32-bit pointers.
>   */
> -#define ELF_ET_DYN_BASE		0x100000000UL
> +#define ELF_ET_DYN_BASE		(2 * TASK_SIZE_64 / 3)
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 1c18d83d3f09..9aeb91935ce0 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -247,11 +247,11 @@ extern int force_personality32;
>  
>  /*
>   * This is the base location for PIE (ET_DYN with INTERP) loads. On
> - * 64-bit, this is raised to 4GB to leave the entire 32-bit address
> + * 64-bit, this is above 4GB to leave the entire 32-bit address
>   * space open for things that want to use the area for 32-bit pointers.
>   */
>  #define ELF_ET_DYN_BASE		(mmap_is_ia32() ? 0x000400000UL : \
> -						  0x100000000UL)
> +						  (TASK_SIZE / 3 * 2))
>  
>  /* This yields a mask that user programs can use to figure out what
>     instruction set this CPU supports.  This could be done in user space,
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Kees Cook

