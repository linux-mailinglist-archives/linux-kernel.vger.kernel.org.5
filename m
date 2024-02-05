Return-Path: <linux-kernel+bounces-52786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6BE849CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6FB1F25B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618124A1A;
	Mon,  5 Feb 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO/tia2c"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5C24A0A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142143; cv=none; b=Y9s/aCaumFAYFrV/ade8DBUZL2xRbMVlrZ+Ww4/2udBNvuIxbc+a6G4yhxkNy7udEKBUyAnybHtoj+7Nkq27R8juMNVgZ+jcuTpogeSpy/+eTSYjxI/lGzp0N5+mPrdCTDN0Qnw0V0z2k40hv7ulcakbvnfWYNi6xWCGlQ/cAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142143; c=relaxed/simple;
	bh=XuZpfRbeebLrjQN7Rkb7kD7tgJCkXvIT/kqM5FYNOm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3peBOti8l7RUBar9rohjt7TKgepe7L34KPazI1M4FoRxoyXV6JvUM/Mjs+GiziD7E22AUyJDgp6HA4swNeM2hQjJp1toTLUGt7enYHhaZpg89rvjM2dbD/hOcMmQ65ljXOA6zbEtXMrLiGaP52nCXHZ93ZDNTj9GvFvVzsBgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO/tia2c; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d317aafbd1so1968626241.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707142140; x=1707746940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzbh1UXzk14eXCXPK6xOaBGhFX+s/GQyOx72L7u65eE=;
        b=CO/tia2cfseCjcCKwkd8jL5uToOMmWT9h5h3h44rnoQQ55k2S6xU8gpVIimKdL6u05
         zGkspm79bYd/kzy9IpUEPBVUPoYyKdMF8qJ6Uh136C2M0dvZeKHZqwEehNiunaFV3su8
         NrP2n2JguJFZPMglWMyHE8MbWhecFNkVgFZS2ZKFA+a07Mz4u1B0aWGz1IVXeh3n+syt
         cCoEGqP9w0GYkGfyzlFsjjA6F4+6e5AUjVjkDaELL7bOO7tSd9PzhfucbbUt5Dod+s30
         H14LZYzbqaU1NRb6cM6w4low9Qlot5dVSWPXjr6qOF8oYfft8itLXV4xjATxJd8yO8Lt
         d8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142140; x=1707746940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzbh1UXzk14eXCXPK6xOaBGhFX+s/GQyOx72L7u65eE=;
        b=L+bMKcay52GvY0037uJlOHPWQlb+oXUsPCTddq4DD0U3MgyX7E049T9X41Vx1U+Dju
         C/4ys9oKU9uv97/8tfa+zG86EK4at9tf2ixh+5NXpWNp+cKGQgCqOPkpE1hFNHH6VG3k
         KELx5BNyojIPORNOFp1XC3OCV0iKHVO1kGyG5Wdtg8LWlA/buf2qsmFwZq7WtAzLG6NQ
         uqcji40qL54fx00H7UOxtZSiLyzF6I4uIZMIcsxtcIvhgbghp2SWWNSuhxpplhdyKcmo
         URS2bu9PNyXl4FHxA25lifmc1Pp4yJcQfBWsmop9pKZJ39yJ9tzZtArGpR2L0j6IZz7j
         GPNA==
X-Gm-Message-State: AOJu0YyMqLU/Fo59439eWcOi3hF6JX07I39c2zcK50w6o4t6j4eCZnlm
	FVnM6VIp5P788g6jajfKE8d8pdP1PxmcnU7NtffMBMIBW+z9Ywp1OcT53OHjVkSJeU6J0jipkki
	BBcwOoVVhUlqP3iHwj3Qq4mLkaY9m5E5kegkN
X-Google-Smtp-Source: AGHT+IEfgK2S3itWZnVRcEkyrIv+Myoo9jOJPQuHfD9CwzpcP5LU9a5FYEbCgpwpR9kba4bBMZE/mU2sUa5s6Ce2EBY=
X-Received: by 2002:a05:6122:20a9:b0:4c0:3390:7abe with SMTP id
 i41-20020a05612220a900b004c033907abemr1619708vkd.12.1707142140414; Mon, 05
 Feb 2024 06:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNP033FCJUb_nzTMJZnvXQj8esFBv_tg5-rtNtVUsGLB_A@mail.gmail.com>
 <20240202113259.3045705-1-paul.heidekrueger@tum.de>
In-Reply-To: <20240202113259.3045705-1-paul.heidekrueger@tum.de>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 15:08:24 +0100
Message-ID: <CANpmjNN9zoMt-ahcu0MEGNH4OSO44H3BSqkOv+Drwg0TZP+g7Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: add atomic tests
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, dvyukov@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 at 12:33, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.d=
e> wrote:
>
> Test that KASan can detect some unsafe atomic accesses.
>
> As discussed in the linked thread below, these tests attempt to cover
> the most common uses of atomics and, therefore, aren't exhaustive.
>
> CC: Marco Elver <elver@google.com>
> CC: Andrey Konovalov <andreyknvl@gmail.com>
> Link: https://lore.kernel.org/all/20240131210041.686657-1-paul.heidekrueg=
er@tum.de/T/#u
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D214055
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>

Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>

Thank you.


> ---
> Changes PATCH RFC v2 -> PATCH v1:
> * Remove casts to void*
> * Remove i_safe variable
> * Add atomic_long_* test cases
> * Carry over comment from kasan_bitops_tags()
>
> Changes PATCH RFC v1 -> PATCH RFC v2:
> * Adjust size of allocations to make kasan_atomics() work with all KASan =
modes
> * Remove comments and move tests closer to the bitops tests
> * For functions taking two addresses as an input, test each address in a =
separate function call.
> * Rename variables for clarity
> * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_sto=
re_release()
>
>  mm/kasan/kasan_test.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 8281eb42464b..4ef2280c322c 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1150,6 +1150,84 @@ static void kasan_bitops_tags(struct kunit *test)
>         kfree(bits);
>  }
>
> +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void =
*safe)
> +{
> +       int *i_unsafe =3D (int *)unsafe;
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_and(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_andnot(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_or(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_xor(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42=
));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42=
));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe))=
;
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe))=
;
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_and(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_andnot(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_or(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xor(42, unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42)=
);
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, saf=
e, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsaf=
e, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe=
));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe=
));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, =
42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(uns=
afe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(uns=
afe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe)=
);
> +}
> +
> +static void kasan_atomics(struct kunit *test)
> +{
> +       void *a1, *a2;
> +
> +       /*
> +        * Just as with kasan_bitops_tags(), we allocate 48 bytes of memo=
ry such
> +        * that the following 16 bytes will make up the redzone.
> +        */
> +       a1 =3D kzalloc(48, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +       a2 =3D kzalloc(sizeof(int), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +
> +       /* Use atomics to access the redzone. */
> +       kasan_atomics_helper(test, a1 + 48, a2);
> +
> +       kfree(a1);
> +       kfree(a2);
> +}
> +
>  static void kmalloc_double_kzfree(struct kunit *test)
>  {
>         char *ptr;
> @@ -1553,6 +1631,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kasan_strings),
>         KUNIT_CASE(kasan_bitops_generic),
>         KUNIT_CASE(kasan_bitops_tags),
> +       KUNIT_CASE(kasan_atomics),
>         KUNIT_CASE(kmalloc_double_kzfree),
>         KUNIT_CASE(rcu_uaf),
>         KUNIT_CASE(workqueue_uaf),
> --
> 2.40.1
>

