Return-Path: <linux-kernel+bounces-108231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12259880824
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0981C20D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3815FBAA;
	Tue, 19 Mar 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpZsMoc0"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD65A4E9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890590; cv=none; b=CBkS5+eY1R1p8uATbh5Hi1gI0TKKi89/BID29CWIJpVG1eii3888sYbvmjgGuEqFtkw0eUgWRPdHmMt9Iz/Rq8+83dPyiwfCtQzHWwSSlLKjGnPAQPth4I4WE2shw5TSXC3Yn6IlVsMKr0gdqGbGNjvu22EizFdF3hmxGQx+Ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890590; c=relaxed/simple;
	bh=MnNt/VMa4IT3l390prhhkwK9TVqN7CpO5cntvcTaBgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA1vUvrmiCSNQB5ED+UxrBSc24jqY7tfzLphw2tCiEE3T0+KdRtuRVFGu0gKzlGqvVDXwBzOP6dDu+KXkIm7u/g14O817bOvwMsQEh6B4emPPPSnrAS1pSV4fXrNoItE33HB3T2yenvt1IeUcpHmYfVNk/zq8ilcnS45kqHdJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpZsMoc0; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e05d6871ddso1001518241.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710890588; x=1711495388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+4A2h4w8QtM3WAY0aEieq/AhMxGRQzY01tqgJ4WnAs=;
        b=DpZsMoc0nRjGQibYws/iVrUM4CRW97yv8TjlsT4or26ZAD29tGDLqQ00L9LRqf3U2F
         re1FNHqSN1g40B5uKAfClbk4oT6TCIQcXBJbu9Us/NhPnQy5Qo5JDE9+QPKz570U5fsT
         vgcaMn1zZMdJ7zx3u7qnJN7upQT98kTncpR4+35OMrfRqRwXjx8vioX9A5m8m6MWHpDt
         W4Liepgj0untQ5N3fwcMa8IaIPqtoXdtstlRdgHuLXOXZRH65k3kAkE6IKq+6GVRlZv7
         eWB6yqnrSC4gk+DpG0Kp9ZumzXTdPqlHdgmEM6AIPD6upZDHgk71azJ+4Qxg/W8djNEs
         AmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710890588; x=1711495388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+4A2h4w8QtM3WAY0aEieq/AhMxGRQzY01tqgJ4WnAs=;
        b=cDN0sLLjvlEg9U7JDMFq0OzvtUChEVG+2Z+xui20FHoyknnrKDzdvlsVEQh2zqTdEP
         sWL+gdf1CDj47r/DLotFkAq3Il9n1BxP4f18q66LcvOxXz5NKk25ikd4Ema3Nn3FdvvK
         u0EBMHwbyJeVr4moDauBYmzG97YZNg5KxJwqHF7SX1WvuFrOIP7b1gEIaSqSryxlD0GA
         4ZUazy6vM+pOdWw94pLyIIY7v1FW2hguHL1iJIY6EDhZhE+lUKDN771eF7zQxSctWp8z
         umItwQ8z8v6uOC05DjdUh4xVl3dSlTg+LeDPXAezSLze8kZTiE37sNmQQcctXUnK3PA/
         fmDw==
X-Forwarded-Encrypted: i=1; AJvYcCUqjJUuq21FbPx+SSpIEUpHtfSR2g8lX5p9efOKPjgG3afGHjCgsQ6jrUhniCbaOAqt3O1QTieXOe07HBIEply6pJbP25fwcwpfwrbN
X-Gm-Message-State: AOJu0Yy6iYcEWtOYas9VFfLkuIUeCGmyuuskCQH0KZI4xdxkY77E76j5
	KdMncsYtofiD0S+Rtg3RZSWyrb9CkrYvSVFuZhvAEj9qO8QNqmpip/Zs+zUqdxC5/Z0EcD2MdaW
	0xF/kkUwzd6JSS0dDndeRvdIjdWs=
X-Google-Smtp-Source: AGHT+IG5rctB0llwIo0GxGvsXkoh6DmicO9LzjhUhH/8A0CECOcs4CyrgDjHtQfqFbyC0rs54BmgDo0qStMr6LYxpro=
X-Received: by 2002:a05:6102:3126:b0:476:396:486c with SMTP id
 f6-20020a056102312600b004760396486cmr10709817vsh.15.1710890587752; Tue, 19
 Mar 2024 16:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
 <ce352c9c-2052-4a23-809a-ef4cc9b7169c@roeck-us.net>
In-Reply-To: <ce352c9c-2052-4a23-809a-ef4cc9b7169c@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Mar 2024 12:22:56 +1300
Message-ID: <CAGsJ_4xOSjmA5c_b2M+_EM9eZkna7ePTV=MSvgOrt-VYvPEO3g@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Guenter Roeck <linux@roeck-us.net>
Cc: chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, dennis@kernel.org, 
	alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:18=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/18/24 18:27, Barry Song wrote:
> > On Tue, Mar 19, 2024 at 2:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> >> generic implementation for this case in include/asm-generic/
> >> cacheflush.h.
> >>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >>   static inline void flush_dcache_page(struct page *page)
> >>   {
> >>   }
> >>
> >>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> >>   #endif
> >>
> >> So remove the superfluous flush_dcache_page() definition, which also
> >> helps silence potential build warnings complaining the page variable
> >> passed to flush_dcache_page() is not used.
> >>
> >>     In file included from crypto/scompress.c:12:
> >>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set b=
ut not used [-Wunused-but-set-variable]
> >>        76 |                 struct page *page;
> >>           |                              ^~~~
> >>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wun=
used-variable]
> >>       174 |                         struct page *dst_page =3D sg_page(=
req->dst);
> >>           |
> >>
> >> The issue was originally reported on LoongArch by kernel test
> >> robot (Huacai fixed it on LoongArch), then reported by Guenter
> >> and me on xtensa.
> >>
> >> This patch also removes lots of redundant macros which have
> >> been defined by asm-generic/cacheflush.h.
> >>
> >> Cc: Huacai Chen <chenhuacai@loongson.cn>
> >> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lk=
p@intel.com/
> >> Reported-by: Barry Song <v-songbaohua@oppo.com>
> >> Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrE=
c9M5YOS1BobfDFXPA@mail.gmail.com/
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Hi Guenter,
> > I am not a xtensa guy, so I will need your help for a full test. if
> > turns out it is a too big(ambitious)
>
> I sent a Tested-by: tag to your patch. As far as my testing goes, it work=
s fine,
> and I added your patch to my "testing" branch (which tries to be buildabl=
e
> and testable for all architectures).

Thank you very much, Guenter. It would be nice if xtensa can leverage
the common cacheflush.h just like other architectures.

>
> > fix, a minimal fix might be:
> >
>
> FWIW, I think a minimal fix would have been to mark the variable as __may=
be_unused,

I am not quite sure we want this as the point is that drivers should
be independent of
architectural differences.

The driver code, for itself, seems quite innocent,

struct page *dst_page =3D sg_page(req->dst);

for (i =3D 0; i < nr_pages; i++)
            flush_dcache_page(dst_page + i);

The only problem is that xtensa's flush_dcache_page is a macro and
doesn't use the "page"
parameter.
if we re-use the inline function in common cacheflush.h, it won't be a prob=
lem.

> but as others have pointed out it would be nice if there would be a guida=
nce
> about optional API functions like this one that specifies if it may be
> implemented as macro and, if so, how it has to handle unused variables.

I agree. personally I like this and will have a go in
Documentation/process/coding-style.rst
and see others' opinions.

>
> Thanks,
> Guenter

Thanks
Barry

