Return-Path: <linux-kernel+bounces-54153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0184AB97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB462851A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE0D139D;
	Tue,  6 Feb 2024 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Rrwaw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16410F4;
	Tue,  6 Feb 2024 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183083; cv=none; b=BZw8voMonx8xGtVTY0uJCKyvHD3oSaLIDQoXp4TNuQFJ7r0dznEuXBnRS84nFxStZEF3Yc0KSgCT07eFkiefRRL4+QQKLsbK9dQKtTuNpoGqowOxGJG8O/yAWzD2uuCfLGsnmnMeY8rZEbJnBbPqwkeC+F6oxVJ7/rBGtnHwJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183083; c=relaxed/simple;
	bh=32iDvBACWJxOXF6/oXubS4npaM7/Q4g4fdElgQomezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcjQNkxVVyu53impbEzeNPrT1o1LxPOxUZfu2hpyw2gW9R171nWxUxyATC7iKIgtulNnNW0fxA71w4OHu3elrBK9FfaRmwd5VsPsP6qFh6QrEdzmt6YP5zga5CPhasb1olrRznHd+5qQyfA9XmTEskcUNLljmd5+35N5R1F4Wxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/Rrwaw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A1C433F1;
	Tue,  6 Feb 2024 01:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707183083;
	bh=32iDvBACWJxOXF6/oXubS4npaM7/Q4g4fdElgQomezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/Rrwaw8t5gj73Rw7uEgJuX0GX+xIb6h6sK+16CarivRG+3ELluh+fjWPdFmx4qWv
	 3osU/ZvJfItj+s70GSsY00w/l1cCCinN7ABMeKLCrZzQTtR4sneXBy/eik5UgNp9nk
	 c4ZQFJUDozWPrEbyC6Os9Cds0s6g+zupS0DbMs+Dff2qQzrTfyh8ejvoslVDFHnhPY
	 QGmRzWEgF0pEMrTH/CIBA0OvJceFIqEi5MWjk5Hora4UltU9hcYOXwvbPfdP9aU2Ij
	 OXfINZbjSeRnpZsenZiAKjNF9NFaNipsMdqlB/tIF5M6wf05gwcuuHuJ56xCAIrGGD
	 vAHs7s/tyccsQ==
Date: Mon, 5 Feb 2024 18:31:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/fpu: make use of __uninitialized macro
Message-ID: <20240206013121.GB2616098@dev-arch.thelio-3990X>
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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

