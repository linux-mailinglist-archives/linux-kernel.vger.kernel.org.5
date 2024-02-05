Return-Path: <linux-kernel+bounces-53006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C6849F71
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6485F1C220D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71C436B0E;
	Mon,  5 Feb 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fxq7x8He"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999053A1CC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150396; cv=none; b=QvsMxC7I0b3N2URFV/GceNFXJFj+4/mHZaOIHx8568ggQyY3LWqYZYPO/GFvcbpfb2sdNgRioaB5VzYBT8PP3p8/H5x20lB9EZVt7U2AyucYv8hx7vhWSjK07mxWn1i/IaQeTcPsabwvFJL7QD18Sm2O8CKZdOs37pZKWkjKUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150396; c=relaxed/simple;
	bh=5tqq0FdmMaEArrTgA0b0O0F+fb1t799dHCr0ICSacNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvLgBE23+zXn+9xC0LQcnmaCUOPQvA1mwG8vA/ycbXKksLGjyNHCp9vScYtPLQl6c2lyq9mUgq3MOj+MIiQzzBT1FbNn6EkjXPmOZQPmJoA3Cmfm3AqzfZfCzQuRsS5Ht7JLKWhMnYrYfv3Hktk+1kSW6rnVywiPiWjLmq1yKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fxq7x8He; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29631796acdso2112390a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707150394; x=1707755194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSN5kQKNkmN+cXEoE2qz/ndx6yByj79ug1SGB5prSww=;
        b=Fxq7x8He4o9G9j6FL3fL0n0l5tVdVXqOsPHGlNpdx3JFDNJco32QH4DwINBnygwhNB
         UMaxmv7xYfpQPCw5WkR3Vtk8sjdapQXT/kNFXZQ4gZweeVaqkaj/hcXScmnEaekvqZod
         CQxYntPjVK0+ny9/VYjkXx7w/PoR5jAei+Yq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150394; x=1707755194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSN5kQKNkmN+cXEoE2qz/ndx6yByj79ug1SGB5prSww=;
        b=OCrKfRdJcK/T0I0xSEWz5NS3Zgjd3nrL4m7jnroIZ/kbuHCEtXSoY/81BTTXcoXLGI
         i+kxLuFZiQt1zqSx/Smzj4AfxrFNgAPgFzf2ES1rSyD031ZTEF5+lHiI1OsaXruejrp5
         jd0pVnMG39XDy4MXlDY964h39YUuvb1sBx3LmqdXiWHDb1Oe1VAprrLOfz7Lc9vRUWgD
         DS9AJdW7hKAoeiUhX8FZH+5W44Ah4qNZbkDvykw/8eF3fZjEjHHlf5T4ctdt2+O+7F+j
         VwzwOcn7rYjhYunVzZ9nhQUU4/hIAd7YahHGPakaRWrB/59qZGYbtt/LRxQ/u1MhuqZr
         duCg==
X-Gm-Message-State: AOJu0Ywjok5J8PDfh63vpF0qQ/lHTRV/SGcMB9HJ4ipLEkBDxu7Wtpip
	6K4Pwb0u7cJ5OQkv9cgMvOLAOiDuayEqrd7rgcYOc7dJB4/AWcc+BDkR+DSXTQ==
X-Google-Smtp-Source: AGHT+IFl7DYl3f1zB/KHuiGxwg7q8MpflDnTt1drQK2gQlwln5TzUdbsnd5JnIlv+Tsyq7QCR6Mrqg==
X-Received: by 2002:a17:90a:fe07:b0:296:a767:f6d2 with SMTP id ck7-20020a17090afe0700b00296a767f6d2mr1949786pjb.38.1707150393874;
        Mon, 05 Feb 2024 08:26:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWGGFup8e+td6iUOWaunAZM42As0IC01Js3Takr+RosOpHsapmKnKIKuRRpvAjMkrMDj+9Z3U0YBT3uX6FkhSKuyabKY4mob+Vf1nZOyhniVpnX68VUy7ZIpnDlphWWvABEophCxzBOJOlMTmELZmL/kulI6fHKsKY/maiUmT2kcG5GmlcHPl54VI8BXHeNfrM9pRac+E+dqBCRhGKfbsoNMMmXLDJFoUOoMJV
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090adf8f00b00295e671dfb8sm5151592pjv.22.2024.02.05.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:26:33 -0800 (PST)
Date: Mon, 5 Feb 2024 08:26:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/fpu: make use of __uninitialized macro
Message-ID: <202402050822.E6E6E978@keescook>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154844.3757121-3-hca@linux.ibm.com>

On Mon, Feb 05, 2024 at 04:48:44PM +0100, Heiko Carstens wrote:
> Code sections in s390 specific kernel code which use floating point or
> vector registers all come with a 520 byte stack variable to save already in
> use registers, if required.
> 
> With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled this variable
> will always be initialized on function entry in addition to saving register
> contents, which contradicts the intend (performance improvement) of such
> code sections.
> 
> Therefore provide a DECLARE_KERNEL_FPU_ONSTACK() macro which provides
> struct kernel_fpu variables with an __uninitialized attribute, and convert
> all existing code to use this.
> 
> This way only this specific type of stack variable will not be initialized,
> regardless of config options.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/crypto/chacha-glue.c    | 2 +-
>  arch/s390/crypto/crc32-vx.c       | 2 +-
>  arch/s390/include/asm/fpu/types.h | 3 +++
>  arch/s390/kernel/sysinfo.c        | 2 +-
>  lib/raid6/s390vx.uc               | 4 ++--
>  5 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/crypto/chacha-glue.c
> index ed9959e6f714..a823132fc563 100644
> --- a/arch/s390/crypto/chacha-glue.c
> +++ b/arch/s390/crypto/chacha-glue.c
> @@ -22,7 +22,7 @@ static void chacha20_crypt_s390(u32 *state, u8 *dst, const u8 *src,
>  				unsigned int nbytes, const u32 *key,
>  				u32 *counter)
>  {
> -	struct kernel_fpu vxstate;
> +	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
>  
>  	kernel_fpu_begin(&vxstate, KERNEL_VXR);
>  	chacha20_vx(dst, src, nbytes, key, counter);
> diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
> index 017143e9cef7..6ae3e3ff5b0a 100644
> --- a/arch/s390/crypto/crc32-vx.c
> +++ b/arch/s390/crypto/crc32-vx.c
> @@ -49,8 +49,8 @@ u32 crc32c_le_vgfm_16(u32 crc, unsigned char const *buf, size_t size);
>  	static u32 __pure ___fname(u32 crc,				    \
>  				unsigned char const *data, size_t datalen)  \
>  	{								    \
> -		struct kernel_fpu vxstate;				    \
>  		unsigned long prealign, aligned, remaining;		    \
> +		DECLARE_KERNEL_FPU_ONSTACK(vxstate);			    \
>  									    \
>  		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK)		    \
>  			return ___crc32_sw(crc, data, datalen);		    \
> diff --git a/arch/s390/include/asm/fpu/types.h b/arch/s390/include/asm/fpu/types.h
> index d889e9436865..b1afa13c07b7 100644
> --- a/arch/s390/include/asm/fpu/types.h
> +++ b/arch/s390/include/asm/fpu/types.h
> @@ -35,4 +35,7 @@ struct kernel_fpu {
>  	};
>  };
>  
> +#define DECLARE_KERNEL_FPU_ONSTACK(name)	\
> +	struct kernel_fpu name __uninitialized

Are there cases when struct kernel_fpu should be initialized? e.g.
should the attribute just be added to the struct definition instead of
marking each use?

-Kees

> +
>  #endif /* _ASM_S390_FPU_TYPES_H */
> diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> index f6f8f498c9be..b439f17516eb 100644
> --- a/arch/s390/kernel/sysinfo.c
> +++ b/arch/s390/kernel/sysinfo.c
> @@ -426,9 +426,9 @@ subsys_initcall(create_proc_service_level);
>   */
>  void s390_adjust_jiffies(void)
>  {
> +	DECLARE_KERNEL_FPU_ONSTACK(fpu);
>  	struct sysinfo_1_2_2 *info;
>  	unsigned long capability;
> -	struct kernel_fpu fpu;
>  
>  	info = (void *) get_zeroed_page(GFP_KERNEL);
>  	if (!info)
> diff --git a/lib/raid6/s390vx.uc b/lib/raid6/s390vx.uc
> index cd0b9e95f499..7b0b355e1a26 100644
> --- a/lib/raid6/s390vx.uc
> +++ b/lib/raid6/s390vx.uc
> @@ -81,7 +81,7 @@ static inline void COPY_VEC(int x, int y)
>  
>  static void raid6_s390vx$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
>  {
> -	struct kernel_fpu vxstate;
> +	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
>  	u8 **dptr, *p, *q;
>  	int d, z, z0;
>  
> @@ -114,7 +114,7 @@ static void raid6_s390vx$#_gen_syndrome(int disks, size_t bytes, void **ptrs)
>  static void raid6_s390vx$#_xor_syndrome(int disks, int start, int stop,
>  					size_t bytes, void **ptrs)
>  {
> -	struct kernel_fpu vxstate;
> +	DECLARE_KERNEL_FPU_ONSTACK(vxstate);
>  	u8 **dptr, *p, *q;
>  	int d, z, z0;
>  
> -- 
> 2.40.1
> 

-- 
Kees Cook

