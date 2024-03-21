Return-Path: <linux-kernel+bounces-109737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344C885511
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE314B21696
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A65812D;
	Thu, 21 Mar 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaehkjXK"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1353339B1;
	Thu, 21 Mar 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006972; cv=none; b=LD45JYhnrv8+boHUMWQ866WWARRyUKhdHqlTNI6eUe/4xvyGeNwgjaXjKqFN8gOvL7i3/BI2aOHqsLi6AphYJ+2FVg5Qs5tXtqNFF5FJQEz++8wcO5xqjjdojRisWYNNghTcbYUMxR0M9asbiNv6iEVyA9jYpwh2hLfqmBBS56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006972; c=relaxed/simple;
	bh=Becs+F28N9K1U02o0AkBnbKa+etvYaDo1+6e9Py9BYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F32hxcKQHoTMWmNUFhYeeq/lNhiWNjxYnLCA55Qst6/t935XrsFVw6VEImNGHRxx9MUDQS9/DlELx7ki0WwrVfGp02SpZlWRXx2dDl+yCHGkJpPlVv0JCg/LRTbbR5O7O24pf4o9s2mHegMb9/i41vlGyv9dl4Fv3pN8egVeHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaehkjXK; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e0abfea517so316470241.0;
        Thu, 21 Mar 2024 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711006970; x=1711611770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l/Bpgj/CMp2wahdMVwgC92LJlZFUWdlP+70wN3/HqI=;
        b=AaehkjXKHmf5C+laXophkKuJjGsK9I82gjgSPU/r/nHJMZ6Fv6v/IzyxQHZUZAJTc0
         juM6dhRX+lZ5Bo1AfKSGjyXfD4u4y6i0e221JfwnyRkFjKfPQrxqF5QsiCCQJ6vaupGd
         MSlEhHI0F/+dVg1CzTaUw4aXqcendsUYrQdhGas1taDfkMtdAgPfnIbqJIMkKMHu2hk4
         y3XTl+psnsaXvCJREefxthgzxD8+S4We7nU28dKC8sFZJE4sL2Hy+stE07eao8tXpr4l
         +uaM3iZCVLuAs4T2aEsHathu7SfY79e35WNzR7GW46u9LyO9miZZcT2XvwHfeqGNev1U
         wQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711006970; x=1711611770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l/Bpgj/CMp2wahdMVwgC92LJlZFUWdlP+70wN3/HqI=;
        b=tYZ5o/OvwA1UloCt5RuaZ2ptqQMUdSCc/tbWaTyx7eVJSmybFP1p8HouwtZppgN0XM
         ty6U7ePlTWB1TVSQqrsqP6KVnZoym4wT0jNtapp2eVagGmd2zrhteB7mK95CVVccXA7+
         Rg009Goy9jet/ucCdouEIqETEjaWvX7gFXB80gQ50U+H0ES4CU5kz/2dcw6G5exda8W5
         uF3C+0v2i7pWQ9N41xHnbfYJeVlDk8acdmRZJvA0WN2aboq/PdBkXC/ZE8WI/hqLvOEV
         6wugR1sCl4oIIaQgtTKb79v/0xsDyC7GSEiaMivdeLw/twqgZGDpSHXVZIArFElcw8/L
         NP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXeZUy2dpeqaIlpio5DQgv6ttWjfTdsqaWo5kgZdAQL2IbT4oS/IGP8Frzn6lEixNe52QW/+V9uqD2P523Asr3AmaAzgN35P+deB3cq2ZFV2UQl5idSH9CW6qnJX7NI6GUMsb9xrwx9fwuIE5NEvndRG7ClzkCcBn6fIehW6M0jlLRP
X-Gm-Message-State: AOJu0YxmT49llTG9qw5g+Ny5tatw/8+4rSwMW5zj1Wsibk+7nNgrFj4A
	VJKodkLyxmbR0wfoNJ09N7cS4etSK4k73msWqR+ihKSEgFACkqyTq2e58nwCjPyGiYCYMyyPCmZ
	2Q2UlIwEhg9utj/svwYRpmENkoNDKhJLxiSM=
X-Google-Smtp-Source: AGHT+IF6/6RWVQEbOqVGOn7GuNnKEwIS1gGwu6xBV4nlHLTca7pBKeCHHYG2sGcb/QSNzL77CHBnZ3Zu+cXBfPfC6JU=
X-Received: by 2002:a05:6122:a1c:b0:4d4:25f2:3ca6 with SMTP id
 28-20020a0561220a1c00b004d425f23ca6mr20336369vkn.3.1711006969698; Thu, 21 Mar
 2024 00:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320001656.10075-1-21cnbao@gmail.com> <EFB48F08-F0B5-47C0-8C47-00A542344AC9@126.com>
 <CAGsJ_4xJsqOO-NXs3OWVA47vcK-zUpcrMxCbnY7x5khRH0dnxA@mail.gmail.com> <7bdc4d24-adfd-4a8c-b824-6833149f5636@126.com>
In-Reply-To: <7bdc4d24-adfd-4a8c-b824-6833149f5636@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 20:42:38 +1300
Message-ID: <CAGsJ_4yoYjt__kvQd6snZeOYLxz9=N2S929+amZYiZvSNLgs+g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Meiyong Yu <meiyong.yu@126.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:40=E2=80=AFPM Meiyong Yu <meiyong.yu@126.com> wro=
te:
>
>
> =E5=9C=A8 2024/3/21 8:11, Barry Song =E5=86=99=E9=81=93:
> > On Thu, Mar 21, 2024 at 12:39=E2=80=AFPM Meiyong Yu <meiyong.yu@126.com=
> wrote:
> >>
> >>> On Mar 20, 2024, at 08:17, Barry Song <21cnbao@gmail.com> wrote:
> >>>
> >>> =EF=BB=BFFrom: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
> >>> sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
> >>> and loongarch,
> >>>    In file included from crypto/scompress.c:12:
> >>>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >>>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set b=
ut not used [-Wunused-but-set-variable]
> >>>       76 |                 struct page *page;
> >>>          |                              ^~~~
> >>>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wu=
nused-variable]
> >>>      174 |                         struct page *dst_page =3D sg_page(=
req->dst);
> >>>          |
> >>>
> >>> The reason is that flush_dcache_page() is implemented as a noop
> >>> macro on these platforms as below,
> >>>
> >>> #define flush_dcache_page(page) do { } while (0)
> >>>
> >>> The driver code, for itself, seems be quite innocent and placing
> >>> maybe_unused seems pointless,
> >>>
> >>> struct page *dst_page =3D sg_page(req->dst);
> >>>
> >>> for (i =3D 0; i < nr_pages; i++)
> >>>     flush_dcache_page(dst_page + i);
> >>>
> >>> And it should be independent of architectural implementation
> >>> differences.
> >>>
> >>> Let's have a guidance in codingstyle to ask for the evaluation
> >>> of parameters.
> >>>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Chris Zankel <chris@zankel.net>
> >>> Cc: Huacai Chen <chenhuacai@loongson.cn>
> >>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> >>> Cc: Guenter Roeck <linux@roeck-us.net>
> >>> Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>> Documentation/process/coding-style.rst | 7 +++++++
> >>> 1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/process/coding-style.rst b/Documentation/p=
rocess/coding-style.rst
> >>> index 9c7cf7347394..8065747fddff 100644
> >>> --- a/Documentation/process/coding-style.rst
> >>> +++ b/Documentation/process/coding-style.rst
> >>> @@ -827,6 +827,13 @@ Macros with multiple statements should be enclos=
ed in a do - while block:
> >>>                 do_this(b, c);        \
> >>>         } while (0)
> >>>
> >>
> >>> +Function-like macros should evaluate their parameters, for unused pa=
rameters,
> >> I do not support this point, if the parameter is unused, why not to re=
move it.
> >>
> > Linux boasts support for numerous architectures, striving for
> > independence in its
> > drivers and core code implementation across these architectures. Conseq=
uently,
> > certain architectures may utilize parameters for the same APIs, while o=
thers may
> > not.
>
> So the probem is  designed api is not reasonable,  it use not essential
> paramter,
>
> you can change the api, but not avoid it.
>

Incorrect again. As an API, it must take into account various consideration=
s.
Just because architecture A doesn't require flushing dcache doesn't imply
that architecture B doesn't need it.

> Anthor question, why you do not use the parameter, if not use it,  will
> trigger function/feature dismiss problem ?
>
> >> about the warning,  is  tool misreport,  the tool must make better
> >>
> > no. This is not the case.
> >
> >>> +cast them to void:
> >>> +
> >>> +.. code-block:: c
> >>> +
> >>> +    #define macrofun(a) do { (void) (a); } while (0)
> >>> +
> >>> Things to avoid when using macros:
> >>>
> >>> 1) macros that affect control flow:
> >>> --
> >>> 2.34.1
> >>>
> >>
>
>

