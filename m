Return-Path: <linux-kernel+bounces-53936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAE84A838
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA81C281BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEE513B786;
	Mon,  5 Feb 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhPmU55p"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D64B5CA;
	Mon,  5 Feb 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167083; cv=none; b=SfdKgstRMPPVfgRbXA1Kad7BZyLhtx2eRa5eqTL7ZQGBdGMMXN2en9Bc9pVjgv21LIHyr0hh96iu4jatuUovUlfn1KYLse80vugB5olpDVtYjfnykV1UXPq4p2FBgaNqmMmZZ3jCiKhx4inEvk7lCKLh9YP0qXHElWYUq6xkGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167083; c=relaxed/simple;
	bh=2Y5zTYq3JDcBNKrygDZnVvkzgvkx3yeiZP/IvSxcEf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=av3lddy1KPkTkvsDO2Pr1ucth0I0SLQnYc8cl6nhfF9Yfd/+KGGXf40K9GFkGSfqg3LpDSGmsREU+0j0u76j3hJnpOBY1Ebwj/pPRuzG/ecc5ecX8XWcYWkOikdPlbZnWD64IKSJAU4j1CWgKY6JCftvpzLeeLdoRBi+XW5Nmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhPmU55p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so42920535e9.1;
        Mon, 05 Feb 2024 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707167080; x=1707771880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqJL7TqpfRwuD6pFCu0aeAbehlV+SJSjj9oqhH2/TvU=;
        b=XhPmU55pBk6ZYfTQCs4jU7O3BlbP3g3pL7ord6U9qizUt9ceXhwJ37yDE1Ek9o0Dki
         7fm4AnY+bpvTT153UtUGW871w11ZmXiqL3yr56janBnlZDJisyNTkFFMFN3/FyHK1VEa
         VoxXUFhqq3jjqOuyv1rco1tN2ZAjeRuZ5l8hxwhb1KYFVdQG9FqFRGlScNVM/p+jH1dz
         koa5gXFoxSDjfpNkCJpYKVm6PVSlnd1uYf6y/ZbrdgVER9td9oNo7/tVQjDWOkwc0YUO
         hizBKFJjqvmuF8+KiC3feAQGtMJ+h3iM9Q3/45lLnn2BDQA8W/uhHkCL5ugxJCozRGnC
         0Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167080; x=1707771880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqJL7TqpfRwuD6pFCu0aeAbehlV+SJSjj9oqhH2/TvU=;
        b=TgXwxkbUEWyet+k1/m7WN8KmfWrFM3VRNrYskF6leSH7D+Be427TEdZzMaCjBJY7UR
         ypDITCa/nZq6m9RuXEsYC9oR1E7zf0xL0+IxA6lzvBV291ZMkuFSqYmvNW/9xCdIF14H
         n2XOu9O3hmlq/m9ArY3SXt92NRLztHgJA+oihmyCvL4an92aT1+1uWTJzocFkyefWqy9
         j9i5It31RdtTzmy2SvLOHkSCG9n19TCVx9XQNPGplHUxf4i+5yrRrCsBYDVS538msVYG
         yBZKIaF3XYl86fojy2F+0RTiwF7KB7L2mVkCYLUCY+1VK51l65FOtqNpwsFXNMaLM0Sy
         0APw==
X-Gm-Message-State: AOJu0YxbOw/yBQcJD3K2R0IHDuV7pNWD7upIdt3nOWAlWmfJ7isCpKcP
	2BCUVFAyQoR8N1w+VKErlZgFHznRYH6utEP+CIEnNZNYPNC6ZCxdo61zntT+375CZCK8FfIlc0x
	gZG7G2++wR0gUVCz7+YHOvWr7vp0=
X-Google-Smtp-Source: AGHT+IEP7m1pFNxLpKm57RSiq7BlXeKoOy2/rAnaInBujPX4AtYK02xZ0tLEJdvVcq9o9ngXgRCfMrmSgjFRm3CG6EM=
X-Received: by 2002:a5d:67d0:0:b0:33b:4164:5fbe with SMTP id
 n16-20020a5d67d0000000b0033b41645fbemr464734wrw.20.1707167079640; Mon, 05 Feb
 2024 13:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205060925.15594-1-yangtiezhu@loongson.cn> <20240205060925.15594-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240205060925.15594-2-yangtiezhu@loongson.cn>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 5 Feb 2024 22:04:28 +0100
Message-ID: <CA+fCnZfDZvcFHG0anZQQKD_GVOfmcKhCmY82U9X2ZKBJp4oRZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: docs: Update descriptions about test file and module
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:09=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> After commit f7e01ab828fd ("kasan: move tests to mm/kasan/"), the test
> file is renamed to mm/kasan/kasan_test.c and the test module is renamed
> to kasan_test.ko, so update the descriptions in the document.
>
> While at it, update the line number and testcase number when the tests
> kmalloc_large_oob_right and kmalloc_double_kzfree failed to sync with
> the current code in mm/kasan/kasan_test.c.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/dev-tools/kasan.rst             | 20 +++++++++----------
>  .../translations/zh_CN/dev-tools/kasan.rst    | 20 +++++++++----------
>  .../translations/zh_TW/dev-tools/kasan.rst    | 20 +++++++++----------
>  3 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 858c77fe7dc4..a5a6dbe9029f 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -169,7 +169,7 @@ Error reports
>  A typical KASAN report looks like this::
>
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_=
kasan]
> +    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan=
_test]
>      Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
>
>      CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
> @@ -179,8 +179,8 @@ A typical KASAN report looks like this::
>       print_address_description+0x73/0x280
>       kasan_report+0x144/0x187
>       __asan_report_store1_noabort+0x17/0x20
> -     kmalloc_oob_right+0xa8/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0xa8/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -200,8 +200,8 @@ A typical KASAN report looks like this::
>       save_stack+0x43/0xd0
>       kasan_kmalloc+0xa7/0xd0
>       kmem_cache_alloc_trace+0xe1/0x1b0
> -     kmalloc_oob_right+0x56/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0x56/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -510,15 +510,15 @@ When a test passes::
>
>  When a test fails due to a failed ``kmalloc``::
>
> -        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:=
163
> +        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_te=
st.c:245
>          Expected ptr is not null, but is
> -        not ok 4 - kmalloc_large_oob_right
> +        not ok 5 - kmalloc_large_oob_right
>
>  When a test fails due to a missing KASAN report::
>
> -        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:=
974
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_te=
st.c:709
>          KASAN failure expected in "kfree_sensitive(ptr)", but none occur=
red
> -        not ok 44 - kmalloc_double_kzfree
> +        not ok 28 - kmalloc_double_kzfree
>
>
>  At the end the cumulative status of all KASAN tests is printed. On succe=
ss::
> @@ -534,7 +534,7 @@ There are a few ways to run KUnit-compatible KASAN te=
sts.
>  1. Loadable module
>
>     With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a lo=
adable
> -   module and run by loading ``test_kasan.ko`` with ``insmod`` or ``modp=
robe``.
> +   module and run by loading ``kasan_test.ko`` with ``insmod`` or ``modp=
robe``.
>
>  2. Built-In
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Docum=
entation/translations/zh_CN/dev-tools/kasan.rst
> index 8fdb20c9665b..2b1e8f74904b 100644
> --- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
> @@ -137,7 +137,7 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=82=E6=95=B0=E7=9A=84=E5=BD=B1=E5=
=93=8D=E3=80=82=E5=BD=93=E5=AE=83=E8=A2=AB=E5=90=AF=E7=94=A8
>  =E5=85=B8=E5=9E=8B=E7=9A=84KASAN=E6=8A=A5=E5=91=8A=E5=A6=82=E4=B8=8B=E6=
=89=80=E7=A4=BA::
>
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_=
kasan]
> +    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan=
_test]
>      Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
>
>      CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
> @@ -147,8 +147,8 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=82=E6=95=B0=E7=9A=84=E5=BD=B1=E5=
=93=8D=E3=80=82=E5=BD=93=E5=AE=83=E8=A2=AB=E5=90=AF=E7=94=A8
>       print_address_description+0x73/0x280
>       kasan_report+0x144/0x187
>       __asan_report_store1_noabort+0x17/0x20
> -     kmalloc_oob_right+0xa8/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0xa8/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -168,8 +168,8 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=82=E6=95=B0=E7=9A=84=E5=BD=B1=E5=
=93=8D=E3=80=82=E5=BD=93=E5=AE=83=E8=A2=AB=E5=90=AF=E7=94=A8
>       save_stack+0x43/0xd0
>       kasan_kmalloc+0xa7/0xd0
>       kmem_cache_alloc_trace+0xe1/0x1b0
> -     kmalloc_oob_right+0x56/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0x56/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -421,15 +421,15 @@ KASAN=E8=BF=9E=E6=8E=A5=E5=88=B0vmap=E5=9F=BA=E7=A1=
=80=E6=9E=B6=E6=9E=84=E4=BB=A5=E6=87=92=E6=B8=85=E7=90=86=E6=9C=AA=E4=BD=BF=
=E7=94=A8=E7=9A=84=E5=BD=B1=E5=AD=90=E5=86=85=E5=AD=98=E3=80=82
>
>  =E5=BD=93=E7=94=B1=E4=BA=8E ``kmalloc`` =E5=A4=B1=E8=B4=A5=E8=80=8C=E5=
=AF=BC=E8=87=B4=E6=B5=8B=E8=AF=95=E5=A4=B1=E8=B4=A5=E6=97=B6::
>
> -        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:=
163
> +        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_te=
st.c:245
>          Expected ptr is not null, but is
> -        not ok 4 - kmalloc_large_oob_right
> +        not ok 5 - kmalloc_large_oob_right
>
>  =E5=BD=93=E7=94=B1=E4=BA=8E=E7=BC=BA=E5=B0=91KASAN=E6=8A=A5=E5=91=8A=E8=
=80=8C=E5=AF=BC=E8=87=B4=E6=B5=8B=E8=AF=95=E5=A4=B1=E8=B4=A5=E6=97=B6::
>
> -        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:=
974
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_te=
st.c:709
>          KASAN failure expected in "kfree_sensitive(ptr)", but none occur=
red
> -        not ok 44 - kmalloc_double_kzfree
> +        not ok 28 - kmalloc_double_kzfree
>
>
>  =E6=9C=80=E5=90=8E=E6=89=93=E5=8D=B0=E6=89=80=E6=9C=89KASAN=E6=B5=8B=E8=
=AF=95=E7=9A=84=E7=B4=AF=E7=A7=AF=E7=8A=B6=E6=80=81=E3=80=82=E6=88=90=E5=8A=
=9F::
> @@ -445,7 +445,7 @@ KASAN=E8=BF=9E=E6=8E=A5=E5=88=B0vmap=E5=9F=BA=E7=A1=
=80=E6=9E=B6=E6=9E=84=E4=BB=A5=E6=87=92=E6=B8=85=E7=90=86=E6=9C=AA=E4=BD=BF=
=E7=94=A8=E7=9A=84=E5=BD=B1=E5=AD=90=E5=86=85=E5=AD=98=E3=80=82
>  1. =E5=8F=AF=E5=8A=A0=E8=BD=BD=E6=A8=A1=E5=9D=97
>
>     =E5=90=AF=E7=94=A8 ``CONFIG_KUNIT`` =E5=90=8E=EF=BC=8CKASAN-KUnit=E6=
=B5=8B=E8=AF=95=E5=8F=AF=E4=BB=A5=E6=9E=84=E5=BB=BA=E4=B8=BA=E5=8F=AF=E5=8A=
=A0=E8=BD=BD=E6=A8=A1=E5=9D=97=EF=BC=8C=E5=B9=B6=E9=80=9A=E8=BF=87=E4=BD=BF=
=E7=94=A8
> -   ``insmod`` =E6=88=96 ``modprobe`` =E5=8A=A0=E8=BD=BD ``test_kasan.ko`=
` =E6=9D=A5=E8=BF=90=E8=A1=8C=E3=80=82
> +   ``insmod`` =E6=88=96 ``modprobe`` =E5=8A=A0=E8=BD=BD ``kasan_test.ko`=
` =E6=9D=A5=E8=BF=90=E8=A1=8C=E3=80=82
>
>  2. =E5=86=85=E7=BD=AE
>
> diff --git a/Documentation/translations/zh_TW/dev-tools/kasan.rst b/Docum=
entation/translations/zh_TW/dev-tools/kasan.rst
> index 979eb84bc58f..ed342e67d8ed 100644
> --- a/Documentation/translations/zh_TW/dev-tools/kasan.rst
> +++ b/Documentation/translations/zh_TW/dev-tools/kasan.rst
> @@ -137,7 +137,7 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=83=E6=95=B8=E7=9A=84=E5=BD=B1=E9=
=9F=BF=E3=80=82=E7=95=B6=E5=AE=83=E8=A2=AB=E5=95=93=E7=94=A8
>  =E5=85=B8=E5=9E=8B=E7=9A=84KASAN=E5=A0=B1=E5=91=8A=E5=A6=82=E4=B8=8B=E6=
=89=80=E7=A4=BA::
>
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_=
kasan]
> +    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan=
_test]
>      Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
>
>      CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
> @@ -147,8 +147,8 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=83=E6=95=B8=E7=9A=84=E5=BD=B1=E9=
=9F=BF=E3=80=82=E7=95=B6=E5=AE=83=E8=A2=AB=E5=95=93=E7=94=A8
>       print_address_description+0x73/0x280
>       kasan_report+0x144/0x187
>       __asan_report_store1_noabort+0x17/0x20
> -     kmalloc_oob_right+0xa8/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0xa8/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -168,8 +168,8 @@ KASAN=E5=8F=97=E5=88=B0=E9=80=9A=E7=94=A8 ``panic_on_=
warn`` =E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=83=E6=95=B8=E7=9A=84=E5=BD=B1=E9=
=9F=BF=E3=80=82=E7=95=B6=E5=AE=83=E8=A2=AB=E5=95=93=E7=94=A8
>       save_stack+0x43/0xd0
>       kasan_kmalloc+0xa7/0xd0
>       kmem_cache_alloc_trace+0xe1/0x1b0
> -     kmalloc_oob_right+0x56/0xbc [test_kasan]
> -     kmalloc_tests_init+0x16/0x700 [test_kasan]
> +     kmalloc_oob_right+0x56/0xbc [kasan_test]
> +     kmalloc_tests_init+0x16/0x700 [kasan_test]
>       do_one_initcall+0xa5/0x3ae
>       do_init_module+0x1b6/0x547
>       load_module+0x75df/0x8070
> @@ -421,15 +421,15 @@ KASAN=E9=80=A3=E6=8E=A5=E5=88=B0vmap=E5=9F=BA=E7=A4=
=8E=E6=9E=B6=E6=A7=8B=E4=BB=A5=E6=87=B6=E6=B8=85=E7=90=86=E6=9C=AA=E4=BD=BF=
=E7=94=A8=E7=9A=84=E5=BD=B1=E5=AD=90=E5=85=A7=E5=AD=98=E3=80=82
>
>  =E7=95=B6=E7=94=B1=E6=96=BC ``kmalloc`` =E5=A4=B1=E6=95=97=E8=80=8C=E5=
=B0=8E=E8=87=B4=E6=B8=AC=E8=A9=A6=E5=A4=B1=E6=95=97=E6=99=82::
>
> -        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:=
163
> +        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_te=
st.c:245
>          Expected ptr is not null, but is
> -        not ok 4 - kmalloc_large_oob_right
> +        not ok 5 - kmalloc_large_oob_right
>
>  =E7=95=B6=E7=94=B1=E6=96=BC=E7=BC=BA=E5=B0=91KASAN=E5=A0=B1=E5=91=8A=E8=
=80=8C=E5=B0=8E=E8=87=B4=E6=B8=AC=E8=A9=A6=E5=A4=B1=E6=95=97=E6=99=82::
>
> -        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:=
974
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_te=
st.c:709
>          KASAN failure expected in "kfree_sensitive(ptr)", but none occur=
red
> -        not ok 44 - kmalloc_double_kzfree
> +        not ok 28 - kmalloc_double_kzfree
>
>
>  =E6=9C=80=E5=BE=8C=E6=89=93=E5=8D=B0=E6=89=80=E6=9C=89KASAN=E6=B8=AC=E8=
=A9=A6=E7=9A=84=E7=B4=AF=E7=A9=8D=E7=8B=80=E6=85=8B=E3=80=82=E6=88=90=E5=8A=
=9F::
> @@ -445,7 +445,7 @@ KASAN=E9=80=A3=E6=8E=A5=E5=88=B0vmap=E5=9F=BA=E7=A4=
=8E=E6=9E=B6=E6=A7=8B=E4=BB=A5=E6=87=B6=E6=B8=85=E7=90=86=E6=9C=AA=E4=BD=BF=
=E7=94=A8=E7=9A=84=E5=BD=B1=E5=AD=90=E5=85=A7=E5=AD=98=E3=80=82
>  1. =E5=8F=AF=E5=8A=A0=E8=BC=89=E6=A8=A1=E5=A1=8A
>
>     =E5=95=93=E7=94=A8 ``CONFIG_KUNIT`` =E5=BE=8C=EF=BC=8CKASAN-KUnit=E6=
=B8=AC=E8=A9=A6=E5=8F=AF=E4=BB=A5=E6=A7=8B=E5=BB=BA=E7=88=B2=E5=8F=AF=E5=8A=
=A0=E8=BC=89=E6=A8=A1=E5=A1=8A=EF=BC=8C=E4=B8=A6=E9=80=9A=E9=81=8E=E4=BD=BF=
=E7=94=A8
> -   ``insmod`` =E6=88=96 ``modprobe`` =E5=8A=A0=E8=BC=89 ``test_kasan.ko`=
` =E4=BE=86=E9=81=8B=E8=A1=8C=E3=80=82
> +   ``insmod`` =E6=88=96 ``modprobe`` =E5=8A=A0=E8=BC=89 ``kasan_test.ko`=
` =E4=BE=86=E9=81=8B=E8=A1=8C=E3=80=82
>
>  2. =E5=85=A7=E7=BD=AE
>
> --
> 2.42.0

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

