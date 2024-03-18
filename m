Return-Path: <linux-kernel+bounces-105605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3587E143
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1305E2825F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDADEAD7;
	Mon, 18 Mar 2024 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E61P8NvW"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E72F50
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722280; cv=none; b=FwCPWkQfk6z2FV/N9c8mQ5VhEnKcleCzVfF4WpBSQPXeb8lCH1vPD+LRhlGr2kmlX5sIBnGSBdUgl8Hrvj+rHMdaircYK2S3TaCn3w5FvNhx/S4gZAD96NUJyZgzkubKecocvAVzcFChLhI9778nxpsDGURNcHeBccTLAVPQlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722280; c=relaxed/simple;
	bh=qBPM3oPalt/c0JhwItpOBOLzEHmAmBaqv6/kGQMl6e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDNhS5yFIdyfHbtTqGlNWtMe/Rpn6U7/y7I1M71N/0wP55VRgn80aLQPVO/2WWSgG76hgWBJYu5DaTSRPVfv3T9ZGh5ppnVW9bkDRBnjNrHLA2fAvqrUfqOa8okTp2tfcF+gmbT6YoTHAoKg9fy42sefH2M3+aFMQGe4mVWuO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E61P8NvW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so40170241.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710722278; x=1711327078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llGLw6AKMSrRr3ZFJczh7zHhHhI2K4vflzOhWhhSUHw=;
        b=E61P8NvW9D2nCZmI8sso2b1Z/ZDxotzrftdwxCusT8pFm9BoGYcwNjYmfs8obqFNMj
         03YNC66NqhTSAtCvKljTQsstdRRMYcUCk9beRSr0+lfUSLGlTb0FdCQIryWW8gWDvfxD
         yJR4hxOxSiLrUhKqPr9iYSeBE3WK3iFazKx+YrdyYBqfxkbY0T1LdYoVNlp6TyFP2Uuj
         cLjLxyYBxokDNfPtS/sEF3GaWZ4Z2lp5XbjzIhmQuqOZ1dwmf4GlLu0MzzFdjERKOGhZ
         9pd3/aoo78LIgqiFR2WbkocpMGj1ZwcYPW32PqR/fP8Ve68XjpK+W1o50k84Z4KnvWPp
         5KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710722278; x=1711327078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llGLw6AKMSrRr3ZFJczh7zHhHhI2K4vflzOhWhhSUHw=;
        b=BoJ6l1qOaW7O6gNCVv1ZBv8PNyQ2L7T4OK63z/AhEvi+NEazVPUnTVyaImx9Bc9007
         tmEH6ui8M2ciRKjrtU4eGz93YR7ED2nvlx1bGDWVuMR/V4nr+EBg/2Bx6F9v/gnacYIJ
         YhrtF/l3++7OMHL9BRWuLs92XeXzu5GFBrwRULfyDEHkAEjh+H1D1FkZpXog3Cj+3hPJ
         3le3Gv0oVxH5pQjpM4ZAqb8JL/NA4FbJQ0oUm/SqHonwJ4HeUAsci3zFPJ7qzU8rx90s
         LFRote0syVfYELeDug37qS8G6YV9POQmqOjO+cFr5yR8GhQo69mBY0xMOpBDFg+6YQIe
         s3jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7kl/2y+4N+CdjVi5u7/gQ5pP/lVdt1WLO53Tj8DBSuPCjlLaPyCp6cDyzGJzFRYDyMX0684C4AoF7v16UNrTOX0mzZNdlmL0SoS6K
X-Gm-Message-State: AOJu0YxM8Y3i1GbQtQfYrIqVwCy/zalCaiaOpiFAaTIVrMR8d5lDH9v+
	5eWSa+GaR/ZrEq84n/IukDifPdAgVXjSWlRCEvzCJj4fdpzpaiuxeXcVMjL2enihs+RghH2Xof0
	YJOQHNI/nKVWmKu+rnbrvbDoUhSw=
X-Google-Smtp-Source: AGHT+IEhTTOor+fIaRmdN2WSSQ8KJWBwZMzkxELDywzsTWhhSRC7cYJrdxj3V89063oGH9Y3g6Iqo1I7o9i/H+8axnQ=
X-Received: by 2002:a05:6102:190b:b0:472:990d:84a with SMTP id
 jk11-20020a056102190b00b00472990d084amr7129007vsb.20.1710722277713; Sun, 17
 Mar 2024 17:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313045036.51065-1-21cnbao@gmail.com> <369716bf-0216-4114-b502-a2d2c819ee8c@roeck-us.net>
 <CAGsJ_4zVQVCBv4+b=pmd78hsv=LnQoBcC+bDmuL0oM7EOGF4eg@mail.gmail.com> <ff895fa4-cf78-4f71-b9d8-6a2a0a0084d9@roeck-us.net>
In-Reply-To: <ff895fa4-cf78-4f71-b9d8-6a2a0a0084d9@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Mar 2024 08:37:44 +0800
Message-ID: <CAGsJ_4y-bnuS_EkHuvm5BpmWb2BrTvYBU97ObTo3bwmHBNiqfA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Guenter Roeck <linux@roeck-us.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, willy@infradead.org, alexghiti@rivosinc.com, 
	rppt@kernel.org, dennis@kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/17/24 17:27, Barry Song wrote:
> > On Mon, Mar 18, 2024 at 8:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On Wed, Mar 13, 2024 at 05:50:36PM +1300, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> >>> generic implementation for this case in include/asm-generic/
> >>> cacheflush.h.
> >>>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >>>   static inline void flush_dcache_page(struct page *page)
> >>>   {
> >>>   }
> >>>
> >>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> >>>   #endif
> >>>
> >>> So remove the superfluous flush_dcache_page() definition, which also
> >>> helps silence potential build warnings complaining the page variable
> >>> passed to flush_dcache_page() is not used.
> >>>
> >>>     In file included from crypto/scompress.c:12:
> >>>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >>>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set =
but not used [-Wunused-but-set-variable]
> >>>        76 |                 struct page *page;
> >>>           |                              ^~~~
> >>>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wu=
nused-variable]
> >>>       174 |                         struct page *dst_page =3D sg_page=
(req->dst);
> >>>           |
> >>>
> >>> The issue was originally reported on LoongArch by kernel test
> >>> robot. And Huacai fixed it on LoongArch, but I found xtensa
> >>> obviously has the same issue.
> >>>
> >>
> >> Maybe I am doing something wrong, but this patch doesn't build
> >> for me.
> >>
> >>   CC      arch/xtensa/kernel/asm-offsets.s
> >> In file included from ./include/linux/highmem.h:8,
> >>                   from ./include/linux/bvec.h:10,
> >>                   from ./include/linux/blk_types.h:10,
> >>                   from ./include/linux/writeback.h:13,
> >>                   from ./include/linux/memcontrol.h:23,
> >>                   from ./include/linux/swap.h:9,
> >>                   from ./include/linux/suspend.h:5,
> >>                   from arch/xtensa/kernel/asm-offsets.c:24:
> >> ./include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE=
_PAGE" is not defined, evaluates to 0 [-Werror=3Dundef]
> >>      9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >
> > is it because xtensa doesn't include this at the end of
> > arch/xtensa/include/asm/cacheflush.h
> > while other architectures do?
> >
> > #include <asm-generic/cacheflush.h>
> >
>
> Looks like it (see my other e-mail).

i will send v2 and it seems a lot of other code can also be removed in
arch/xtensa/include/asm/cacheflush.h,

for example

#define flush_cache_all() do { } while (0)
#define flush_cache_mm(mm) do { } while (0)
#define flush_cache_dup_mm(mm) do { } while (0)

#define flush_cache_vmap(start,end) do { } while (0)
#define flush_cache_vmap_early(start,end) do { } while (0)
#define flush_cache_vunmap(start,end) do { } while (0)

#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
#define flush_dcache_page(page) do { } while (0)

#define flush_cache_page(vma, addr, pfn) do { } while (0)
#define flush_cache_range(vma, start, end) do { } while (0)


#define flush_dcache_mmap_lock(mapping) do { } while (0)
#define flush_dcache_mmap_unlock(mapping) do { } while (0)

>
> Guenter
>

