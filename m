Return-Path: <linux-kernel+bounces-106886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC987F4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427D3B21885
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B460ED9;
	Tue, 19 Mar 2024 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5iVXtIv"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9260B8C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811648; cv=none; b=FBSlGx1bODPxS2Ks25fAX/BJrUJIPRG8BSv1bkCehlECn0YvjDij1muJBBOsdy87N8f63pB8szQimu1lY9Kz7zsvmZNPxn1zHg3bovtQ/RRVzzrVKb325m+zLVZS+fN439DTiogX9KiAaKN2gHZemFkhcC8nWw6BQRTrN4BZdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811648; c=relaxed/simple;
	bh=uIB1TjLnvqmRdTKmwcxhJJqOih7h4Sx+dQ6OUQfsg28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj8QGVsvL/rLuw1cqy+4/OMIj1XqpBeri4PKPpZIfs5iH9TfEio20C5d2gZupNVYlV6fM47Lr33Ee4eRUc7w+J8Sq46ncYjA0bGecriXDxXnjccHlei1tcEITaF+CGpftVXC3s761A9zhJ3SAJea5lOIsTIx0OlyuUWs0KyV5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5iVXtIv; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d45bda6696so513290e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710811646; x=1711416446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liHKh9UomfodPROQWe+N5RWa9EoteCRQ0+hb5rxxprU=;
        b=F5iVXtIv+DX2vfTpE8dsAuygjB+/wRogQG+t36h4kA3MSIB9jH0RKDZwz2kD8kSJKp
         8vsyfr/OqlImdjuP5iBW0UlWWm1WPV+lIDcVnYT8PeE4MkQOk/zdS7TOtZM655rxIFyy
         GFIXGIl7xNsuSGC62GrjEYxORXXM13ol6itNPfXlW7R9v5+ziNKeUEJKlRVwRpMgL3SH
         BOW7CemVu4hdg6TLbtR8gNygpTL56RQknfqSlbQDUKoGsqh8hidvSFBYvnQjVI8+1mCG
         WX8Y2T41KPoi+n5fox9xTdkMqN0cglBz3MP1Hd7W9wdqlxsdvBYECbNwk9znW7rLTD5d
         HzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710811646; x=1711416446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liHKh9UomfodPROQWe+N5RWa9EoteCRQ0+hb5rxxprU=;
        b=Bny8fg7mNz7UauLzuWRcdXLaCaFWOwmZ579kx+0JyD0IWYq9xAG8EN5VGOAJtDtRAI
         3/Q7vdaFcLg8HE9t0kKG3P5Xne2yJuKS6SpJ7jpxjxtn8aFCOkG+XRADLPOIzEm1XPBu
         naouKqE3d07XYmBRxRTegOghspVUvtlv9uliZ3NfFACrSVF+jnfoVIAyLjs3C/kFEIDW
         85e/3oNQ1Q2TNaIhH6utrJxaFhrcDOim1xAXWCgqC1ErLD3aViL6I5JI03n7byue6y8g
         x6jGM8nZ4k5qyZ8bYX0rfC05zPB16g1d5p03Odp8k5Ksnb9OFFXB2fFQK7d+On0hDEXr
         jlAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGQG1owRA8uEPsp3w7MBaZurBwZToHsFNQZjOB1nul6yKDqtP75duGZW6CRWTFbstUTs0ASjedVdaWY4k7lxJmSDaDjj384g2dmbQl
X-Gm-Message-State: AOJu0YxI4Ow3U8z5WdMXPvgJDPFtvzq22+I6njGy4cBHReDtfOnu1T+h
	TXutLA2oO0zizXKYrYpEkViFqmuU5BUdSRXjdLnhJW+6CUwHLh6/P1XvvsvGSlkd5bb+qktCqCE
	FY+2NMX1s/cFXwvzJIsu2AxRHeys=
X-Google-Smtp-Source: AGHT+IE8u7rLbGf/ex12LCseAHxyxZIiMMv38tZ4HBuMZinr5pds0rWMUYFtd9WxRve+TrOaC20GP7HA/0Tv4L4gJEk=
X-Received: by 2002:a67:e211:0:b0:474:c1aa:afe with SMTP id
 g17-20020a67e211000000b00474c1aa0afemr1081256vsa.10.1710811645770; Mon, 18
 Mar 2024 18:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com>
In-Reply-To: <20240319010920.125192-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 14:27:14 +1300
Message-ID: <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc: willy@infradead.org, dennis@kernel.org, alexghiti@rivosinc.com, 
	Barry Song <v-songbaohua@oppo.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> generic implementation for this case in include/asm-generic/
> cacheflush.h.
>  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>  static inline void flush_dcache_page(struct page *page)
>  {
>  }
>
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>  #endif
>
> So remove the superfluous flush_dcache_page() definition, which also
> helps silence potential build warnings complaining the page variable
> passed to flush_dcache_page() is not used.
>
>    In file included from crypto/scompress.c:12:
>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but n=
ot used [-Wunused-but-set-variable]
>       76 |                 struct page *page;
>          |                              ^~~~
>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunus=
ed-variable]
>      174 |                         struct page *dst_page =3D sg_page(req-=
>dst);
>          |
>
> The issue was originally reported on LoongArch by kernel test
> robot (Huacai fixed it on LoongArch), then reported by Guenter
> and me on xtensa.
>
> This patch also removes lots of redundant macros which have
> been defined by asm-generic/cacheflush.h.
>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@i=
ntel.com/
> Reported-by: Barry Song <v-songbaohua@oppo.com>
> Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M=
5YOS1BobfDFXPA@mail.gmail.com/
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Hi Guenter,
I am not a xtensa guy, so I will need your help for a full test. if
turns out it is a too big(ambitious)
fix, a minimal fix might be:

diff --git a/arch/xtensa/include/asm/cacheflush.h
b/arch/xtensa/include/asm/cacheflush.h
index 38bcecb0e457..fdc692cf2b78 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -145,7 +145,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 #define flush_cache_vunmap(start,end)                  do { } while (0)

 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)                                do { } whil=
e (0)
+#define flush_dcache_page(page)                                do {
(void)(page); } while (0)

 #define flush_icache_range local_flush_icache_range
 #define flush_cache_page(vma, addr, pfn)               do { } while (0)


> Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436472@=
roeck-us.net/
> Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 and =
pages are lowmem")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v2: include asm-generic/cacheflush.h and remove lots of redundant macro=
s
>
>  arch/xtensa/include/asm/cacheflush.h | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/a=
sm/cacheflush.h
> index 38bcecb0e457..a2b6bb5429f5 100644
> --- a/arch/xtensa/include/asm/cacheflush.h
> +++ b/arch/xtensa/include/asm/cacheflush.h
> @@ -100,6 +100,10 @@ void flush_cache_range(struct vm_area_struct*, ulong=
, ulong);
>  void flush_icache_range(unsigned long start, unsigned long end);
>  void flush_cache_page(struct vm_area_struct*,
>                              unsigned long, unsigned long);
> +#define flush_cache_all flush_cache_all
> +#define flush_cache_range flush_cache_range
> +#define flush_icache_range flush_icache_range
> +#define flush_cache_page flush_cache_page
>  #else
>  #define flush_cache_all local_flush_cache_all
>  #define flush_cache_range local_flush_cache_range
> @@ -136,20 +140,7 @@ void local_flush_cache_page(struct vm_area_struct *v=
ma,
>
>  #else
>
> -#define flush_cache_all()                              do { } while (0)
> -#define flush_cache_mm(mm)                             do { } while (0)
> -#define flush_cache_dup_mm(mm)                         do { } while (0)
> -
> -#define flush_cache_vmap(start,end)                    do { } while (0)
> -#define flush_cache_vmap_early(start,end)              do { } while (0)
> -#define flush_cache_vunmap(start,end)                  do { } while (0)
> -
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -#define flush_dcache_page(page)                                do { } wh=
ile (0)
> -
>  #define flush_icache_range local_flush_icache_range
> -#define flush_cache_page(vma, addr, pfn)               do { } while (0)
> -#define flush_cache_range(vma, start, end)             do { } while (0)
>
>  #endif
>
> @@ -162,15 +153,14 @@ void local_flush_cache_page(struct vm_area_struct *=
vma,
>                 __invalidate_icache_range(start,(end) - (start));       \
>         } while (0)
>
> -#define flush_dcache_mmap_lock(mapping)                        do { } wh=
ile (0)
> -#define flush_dcache_mmap_unlock(mapping)              do { } while (0)
> -
>  #if defined(CONFIG_MMU) && (DCACHE_WAY_SIZE > PAGE_SIZE)
>
>  extern void copy_to_user_page(struct vm_area_struct*, struct page*,
>                 unsigned long, void*, const void*, unsigned long);
>  extern void copy_from_user_page(struct vm_area_struct*, struct page*,
>                 unsigned long, void*, const void*, unsigned long);
> +#define copy_to_user_page copy_to_user_page
> +#define copy_from_user_page copy_from_user_page
>
>  #else
>
> @@ -186,4 +176,6 @@ extern void copy_from_user_page(struct vm_area_struct=
*, struct page*,
>
>  #endif
>
> +#include <asm-generic/cacheflush.h>
> +
>  #endif /* _XTENSA_CACHEFLUSH_H */
> --
> 2.34.1
>

Thanks
Barry

