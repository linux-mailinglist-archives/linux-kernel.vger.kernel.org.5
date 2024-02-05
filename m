Return-Path: <linux-kernel+bounces-53934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4984A835
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE61F2C242
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED213B285;
	Mon,  5 Feb 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0C+WqFO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2913AA5F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166869; cv=none; b=ZwW3GcISKbkKChMYdU402o+QjAnJBIj+4LY6Le6+ZBDqbGPDhr++u+PhLR/gF0pxjwnHVIBUDi7Zdf/nnJeQkOrx6VoHqZpv46LnRIYFgqD9Sb7MA9DOJZ/ZPsSqHmKTOrQQdjCh293A+tgV35VK+CSdtNmHswymmFqWNRgO7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166869; c=relaxed/simple;
	bh=rkLt5FkXhEz5XoHo6rs7WfvH4tpX3idH0DtDBm2eDiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+dPUTvrVpei1H64mPuQilNN5amhBCYl+Iki4NIc5FqmtOlMtFAMNm8lyOkRNX0q2HxO/7k/Mlpn4WMHG80GqszEklwPjp6Qj6HI+AeAUg8QixM+RtWZjDJdPjFczIvtNjlkHr8LLO3kJRbc4s9k2n/9VOPJtrUAgoaGBDxxOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0C+WqFO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so15572565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166865; x=1707771665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2K15Hg3yhqnl2UBe8X+/YSPQqkoXC0ybPHCaX0Zh/g=;
        b=d0C+WqFOqBV89QgKPXrOqfjdMRBLQ2WO/RHzKrmmOV7PTMXLTCu5MvLNP5p4epWCgQ
         k35vh6YUGQ2ne9lOcgBoZoA3SDYW2e95oNGQA8PPYv3xlOdylG2EH3WZxXxrHQrZOpq7
         XpN497nwbnU8WL5OIFvb1l0E6VzYeGb13CL7GvXn51L+HsZcpllKMwSrR8U7LYrRKTgn
         sTNC+zK0snvHK2rq6xvE9Ed9sEvzQvD0CQtp2nxclI/WiDDchJcYrVKBJ/6VdYgDgHjP
         UDU3NURsJobVxyWgEnplZE2xGoLGNdzL/HjN8cl3NQnl59m9Hc371krQZu4eHAZvSIZ9
         4PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166865; x=1707771665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2K15Hg3yhqnl2UBe8X+/YSPQqkoXC0ybPHCaX0Zh/g=;
        b=RwwsWSCRXfXdCuChzl9vPAPr1OyIy1VQJOnW39NykOO5f4zufUVH2tzgRgpT02l/P8
         g8Fa4pgMFsDLZgOTwl1KJe9jsylaC3OcEzbSn1BjMZ80ca6/y00+M2id8MRwxdToshMT
         mUfz3OrRiHVj6JVybGkDxUGA/jWg4XYIAo9KBYyVkjMTHKWukD3bTee4L45rJ3kF5aCg
         o+G61WH7osxHRERSWGOa1VD9NH+ZMMS+/c/h0oWHsM5FXnbr2HDh8+fRIztHBs7267nU
         wPlnZU2EPO5/5BUJWIm7Vq6tBYsxHKjBGNYWQh7+ekTjEqG2PIyYqHqkHYaLd1x69Atq
         H7UQ==
X-Gm-Message-State: AOJu0YzjOY0C1jc551XxtSLnAmh5WAFdui74rwwA0wtLFciis3zhIKHH
	UAJNCO8pqZ56Uv7dlUNpZZjBt2PECKQVBJGVlTayjvcYIMiAMlYb4370i6LUt6KreuMROgsDZoM
	FWJAmY8ANgPH55B68byoirmmptq0=
X-Google-Smtp-Source: AGHT+IHv7CWDrlJc0y95Et/8uxW/u+e33lGEvUS6q5bJN3/r7tYPHSiz//ebwdGTRN968PxNRNmtl7sKxMDYX+zeI0k=
X-Received: by 2002:a5d:4b4e:0:b0:33b:1a43:578 with SMTP id
 w14-20020a5d4b4e000000b0033b1a430578mr484273wrs.25.1707166864881; Mon, 05 Feb
 2024 13:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNP033FCJUb_nzTMJZnvXQj8esFBv_tg5-rtNtVUsGLB_A@mail.gmail.com>
 <20240202113259.3045705-1-paul.heidekrueger@tum.de>
In-Reply-To: <20240202113259.3045705-1-paul.heidekrueger@tum.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 5 Feb 2024 22:00:53 +0100
Message-ID: <CA+fCnZdDxot_wms3XmZonBCo7=qkCSj72inhSX+zHNF9gkMv2A@mail.gmail.com>
Subject: Re: [PATCH] kasan: add atomic tests
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: elver@google.com, akpm@linux-foundation.org, dvyukov@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:33=E2=80=AFPM Paul Heidekr=C3=BCger
<paul.heidekrueger@tum.de> wrote:
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

I think this should be sizeof(atomic_long_t) or sizeof(long),
otherwise a2 will not work as the safe argument for
atomic_long_try_cmpxchg on 64-bit architectures.

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

