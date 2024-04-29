Return-Path: <linux-kernel+bounces-161965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769A8B53E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA48F1C218FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA5E1AAA5;
	Mon, 29 Apr 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S55dBUep"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32612E7F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381919; cv=none; b=HODimhE9413UanxzMpYVdnhKwghF2afpNxZKaqbfEQ7wNzOYcPe68bwDSuMjH3xhr3pOPn2garZIW1SkAJxdW6VjxyexfujGOJQRMdhcHAguX8Rxm7iUqAGVfH15erIeATzIpHVAx7tSoDjDmughijdS4AOQ9EQ55fFuFFJiKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381919; c=relaxed/simple;
	bh=Yl1ZoNMiWYXwoU/S1421c17p+hEvnhat19Jy0CmGSMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDQ3LJkVdtzc8g85RKf0w22DcGswdY2kNtHeQwUkicdlCljGP0/BMihbByYLdBYi7wo92QNxoJIaUtISVZA9XXvQwzIvM4x68HmiCCKaucIVbyKQ2ZWLwTgJ09rpC1pTrt9Hv1wkCxG38c/S/+7gp1DSc48qOMriwH6jUCP9rrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S55dBUep; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7efcdc89872so969463241.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714381917; x=1714986717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Stgo6Dxtb5dKPf4odo5eyp2rmXqPNzOhx3G5+MgJJvU=;
        b=S55dBUepbT+AAPqvxP4Dmr5HCqN98qo67TmHvUhwZWB/y2G2AooCW0ws+3Dg5VkLDP
         9C/uCy8ZHBFmzyc5eJH2ePT1J7PgqlyuP89ENilnoeI3BHG8ZdA3a03s4Rod4h6NIadU
         n+Y8pmytrr4pI85xSD4grvuZjCYiywCIK1MxeYLx4Z83J0css7McrFm5wAP0PmxfHelP
         7sr+98YjqdTan+Axkg6etGy4YAM9hIy9kvxIdrZ0xo5+qmMLP7PNcRpmFhCMWY8eVQQV
         vkdaNu2ccfN6CRK9d8QVkKccN8yRjwDob1TkZHjFEupGnGULh31sD3jlF+YMe0I1kLtd
         XyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714381917; x=1714986717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Stgo6Dxtb5dKPf4odo5eyp2rmXqPNzOhx3G5+MgJJvU=;
        b=Kp5LTuAryqBJ9PtzsCO0sFb811ssn3Oc6/W7Yoy1puB71k8dMKR7Wvwo9Ci5e54Jvx
         DJND39hgGkZ3C5zEIPhgd3lQqTe7TzVBB2cxFvKnYNSIoIzWwtzU/6CoqvQDyqKStQ3K
         Hn9aOwfWrKmzXZLfNkKrY+H1wLoujHhJrc1dTzwuA61csQ8S7cGctsy7dYOg23lLSI6L
         soUMv3jGBXqa6MkxGhJd8uz7Fn1lN638HKmP0Dt7ZjzeFlQfMgEtrw8Js2MPG3Fdki0t
         jekKKDPO4fxHsVmwI0RqtwzlkdgFXT4k1H1hM2sbeXDILgDnsVwdjczmfXczIOKLyL6t
         1VRA==
X-Forwarded-Encrypted: i=1; AJvYcCXF0GsZdYWH+7jcQbCIGcXq7hOQ2CCisQefVyThcUt6ZUs+NxMjrbqVOcXry7FMGAilcW5vkFIoSiKoTyCOSzLB7FkbNjHjGYx9gjDh
X-Gm-Message-State: AOJu0Yzc/XphQr9dF1tio1VM20/AXElwflpf30BzCoRtxsGTV97VO1/f
	hsdxCa0REDyHnFF0LOlO4zMSbEKwBJeKbTg2suknhhP8unw7WN+EnYUOYLbxbO5EEwu646tEmIG
	0rKLa+I+jf7pI8qr0CiRG2SSLUnI=
X-Google-Smtp-Source: AGHT+IGpzyRj1gRk27YdA9s7LvX4y/BA+7L8TtwXpkpRVv2myhNigyeZMKpOUT8byTk/awVja3dq+I7j+73x4n1spiU=
X-Received: by 2002:a67:f644:0:b0:47c:2a70:422a with SMTP id
 u4-20020a67f644000000b0047c2a70422amr8610761vso.6.1714381917220; Mon, 29 Apr
 2024 02:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
 <CAMo8BfJTutHPByNZcpjb-2xeUX-Nu2XkjN0DWE6w5xV=zg__Kg@mail.gmail.com>
In-Reply-To: <CAMo8BfJTutHPByNZcpjb-2xeUX-Nu2XkjN0DWE6w5xV=zg__Kg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Apr 2024 21:11:45 +1200
Message-ID: <CAGsJ_4zrnw5ziZHZciC3asgsZUzWP8N69k7o48WKdV2qNn6+pw@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, chris@zankel.net, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, dennis@kernel.org, 
	alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 5:10=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com> w=
rote:
>
> On Sat, Apr 27, 2024 at 12:05=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 19, 2024 at 02:09:20PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> > > generic implementation for this case in include/asm-generic/
> > > cacheflush.h.
> > >  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> > >  static inline void flush_dcache_page(struct page *page)
> > >  {
> > >  }
> > >
> > >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> > >  #endif
> > >
> > > So remove the superfluous flush_dcache_page() definition, which also
> > > helps silence potential build warnings complaining the page variable
> > > passed to flush_dcache_page() is not used.
> > >
> > >    In file included from crypto/scompress.c:12:
> > >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> > >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set b=
ut not used [-Wunused-but-set-variable]
> > >       76 |                 struct page *page;
> > >          |                              ^~~~
> > >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > > >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-W=
unused-variable]
> > >      174 |                         struct page *dst_page =3D sg_page(=
req->dst);
> > >          |
> > >
> > > The issue was originally reported on LoongArch by kernel test
> > > robot (Huacai fixed it on LoongArch), then reported by Guenter
> > > and me on xtensa.
> > >
> > > This patch also removes lots of redundant macros which have
> > > been defined by asm-generic/cacheflush.h.
> > >
> > > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-l=
kp@intel.com/
> > > Reported-by: Barry Song <v-songbaohua@oppo.com>
> > > Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFr=
Ec9M5YOS1BobfDFXPA@mail.gmail.com/
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436=
472@roeck-us.net/
> > > Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 =
and pages are lowmem")
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > The mainline kernel still fails to build xtensa:allmodconfig.
> >
> > Building xtensa:allmodconfig ... failed
> > --------------
> > Error log:
> > crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > crypto/scompress.c:174:38: error: unused variable 'dst_page' [-Werror=
=3Dunused-variable]
> >   174 |                         struct page *dst_page =3D sg_page(req->=
dst);
> >
> > This patch fixes the problem. Is there a chance to get it applied to th=
e
> > upstream kernel, or should I just stop build testing xtensa:allmodconfi=
g ?
>
> Applied to my xtensa tree.

Thanks for taking care of this, Max!

> I was still hoping to see rationale for why this is a useful warning.

Personally, I think the reason is quite obvious.

This warning serves as a valuable alert, highlighting an issue where Xtensa
fails to properly implement flush_dcache_page(). The problem lies in a macr=
o
definition that neglects to evaluate its argument. Such discrepancies can
impact driver functionality across various architectures, rendering them
independent of specific architectural considerations.

>
> --
> Thanks.
> -- Max

Thanks
Barry

