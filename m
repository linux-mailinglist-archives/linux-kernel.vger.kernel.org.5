Return-Path: <linux-kernel+bounces-106908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38387F541
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4366EB218BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E364CE9;
	Tue, 19 Mar 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Kg8h8H"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11F33D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814337; cv=none; b=UETQhvgvLHV0UaqCwabTqveE3EvMECYU6WOlpybrFk2lP4Dky0el6Wcoi06N0D/rh9ssD7h+dQ2k1fj3YImqlK5MyFPlN/hRLCQGR5bAyVhVVpdSTxjEFPbYrUSUkAgQoXOpPX+sGtp5zB8JcvR+5Q/4/SaRLKLA3QZXi7lp9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814337; c=relaxed/simple;
	bh=ukpdVBE/AjAxNWV4xv1aFZULE0/bCg07pYEx83/035Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWxTEkMdTyPE77LY4oMnwcoE7jSUp0R8Ytx486yVpIRIpHFWPo4VkY5wczcgGdkwXAZvo52p/HoHegmvCELrtKRlgnooQWPO/x16XmDakD29+7wlbuEj/j2bdAXUqHXSL07ImrkCo+8g/Mrkwk4jlYVeXni1GApI8XqHUh9426M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Kg8h8H; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso2830725a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710814335; x=1711419135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRrUFubiyQa+xNw4epGiROH+bIbiheXOvm9xTiA2IGk=;
        b=a5Kg8h8H0hJDPbtZH88EKYpqVCp+47I+Aqo13Mh2bduNhn6aufDMdZ92jmLZBMZlcQ
         V+aYhgVYP6OmQ60FEYLNSf5C8sRkl4oW1sGNK1nESpB2eD8EkTA/S9rx/flFxB7KYjUW
         gvBXTKKsr13b+M/W8LHikFgKapr4DvaTqf9M8mAnQALA0Wloh3IestBY1uOVUb7kQ8KQ
         s8xdzRFgX3OzaPZJIYz2ZBUF4LLxJ2UT1FSf/3KCH9lxN/pa4nC8hmSNGmD7mDFs4yD0
         UrWXIRNeX87Qok2ZRB7rGQ1ia0eb4+cMBPhtnSMExOaUbGUcM+tYbjhvzi7pQ5pzf008
         twFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814335; x=1711419135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRrUFubiyQa+xNw4epGiROH+bIbiheXOvm9xTiA2IGk=;
        b=GbI6OsZelfpGrtfqodHofwD1SEFIbYjaVjXZFbRyv2Wg0AZfeM9LlEm2Wik2HqpwCd
         K8MVdmtl2kpzathI+y95RKryloZjwcsTjrL8OcPh6cOz/iTT52kWNR7CvDACLcst+RNk
         eE9L1cO+YfnFCg81S4H/9TzSoyPqYBy1LbcfjfCMRpgag+8c8FI+4XJO1zxY52KFtGIR
         Fr2ucj3w091J6u2y+FFCSUOcP9A2XiA2/kA7CjW1beO08fnHh7w50YG7zsGxiKMuFoSl
         JVmEQoLvEGfMJF/J6tNGrICmC4YrqlCoMTQ//k0/fPQdHb3CWOoxR0gI+58AJxQLLJrd
         VxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcIZdsTt4uWc3ZbJzti6wLMQPcq1FU82zRKTyXjx/bJ92AjdTeyRtnQ4Y/KP174QG2cmGTkx5DFlWGuKHcIXAfTE+ytzoZmhPnwJJj
X-Gm-Message-State: AOJu0YzmJ3m46voZ+zEmf6HE3R+5ikdD2sltkRZ2Kx2vnSMv+FvviaKQ
	H6c3UzYzQ733YhxPQ/0h8MbAdad+1alrd0rq4M6Kg9jmj8pb1SU/3DtV7e4Zxg1wu1KitVNY3wf
	gDctw7hnqoU8HWLnRMD3mzCo3enY=
X-Google-Smtp-Source: AGHT+IH3FPhYDol3brjVj65Oo7HYjg4sS1cHRR9EKZ3cqOZAY9BJne9Pwl2MbYnC5J3iAJSTsOkMgggkv6DbzFMQ+vg=
X-Received: by 2002:a17:90a:aa02:b0:29d:f554:4509 with SMTP id
 k2-20020a17090aaa0200b0029df5544509mr10752671pjq.0.1710814335219; Mon, 18 Mar
 2024 19:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
In-Reply-To: <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Mar 2024 19:12:04 -0700
Message-ID: <CAMo8BfJ+AOOY8Sn-2=CHCJ9M9kzU=w6nnkqEg=8V=2F2uNhhqQ@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Barry Song <21cnbao@gmail.com>
Cc: chris@zankel.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, willy@infradead.org, dennis@kernel.org, 
	alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
> On Tue, Mar 19, 2024 at 2:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> > generic implementation for this case in include/asm-generic/
> > cacheflush.h.
> >  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >  static inline void flush_dcache_page(struct page *page)
> >  {
> >  }
> >
> >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> >  #endif
> >
> > So remove the superfluous flush_dcache_page() definition, which also
> > helps silence potential build warnings complaining the page variable
> > passed to flush_dcache_page() is not used.
> >
> >    In file included from crypto/scompress.c:12:
> >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but=
 not used [-Wunused-but-set-variable]
> >       76 |                 struct page *page;
> >          |                              ^~~~
> >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wun=
used-variable]
> >      174 |                         struct page *dst_page =3D sg_page(re=
q->dst);
> >          |
> >
> > The issue was originally reported on LoongArch by kernel test
> > robot (Huacai fixed it on LoongArch), then reported by Guenter
> > and me on xtensa.

I wonder why this warning is considered useful in the first place?
If I'm missing something and it's indeed useful, should there be a
rule in the Documentation/process/coding-style.rst saying that
function-like macros should evaluate all their arguments?

> > This patch also removes lots of redundant macros which have
> > been defined by asm-generic/cacheflush.h.
> >
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp=
@intel.com/
> > Reported-by: Barry Song <v-songbaohua@oppo.com>
> > Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc=
9M5YOS1BobfDFXPA@mail.gmail.com/
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
>
> Hi Guenter,
> I am not a xtensa guy, so I will need your help for a full test. if
> turns out it is a too big(ambitious)
> fix, a minimal fix might be:
>
> diff --git a/arch/xtensa/include/asm/cacheflush.h
> b/arch/xtensa/include/asm/cacheflush.h
> index 38bcecb0e457..fdc692cf2b78 100644
> --- a/arch/xtensa/include/asm/cacheflush.h
> +++ b/arch/xtensa/include/asm/cacheflush.h
> @@ -145,7 +145,7 @@ void local_flush_cache_page(struct vm_area_struct *vm=
a,
>  #define flush_cache_vunmap(start,end)                  do { } while (0)
>
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -#define flush_dcache_page(page)                                do { } wh=
ile (0)
> +#define flush_dcache_page(page)                                do {
> (void)(page); } while (0)

This looks like a good fix, IMO better than adding __maybe_unused
to the variables reported in the warnings.

--=20
Thanks.
-- Max

