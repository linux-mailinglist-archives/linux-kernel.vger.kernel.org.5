Return-Path: <linux-kernel+bounces-61018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC1850C50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC73B1C2179A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9F17BC2;
	Sun, 11 Feb 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmbHNase"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA71799E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693433; cv=none; b=YegLMCucLo5xqszb9EfreNQzDbNw0KY3jgUXcpU577sE4yKRtUDh6u/DJpS40icFLGbxKR2d2ThSaU1V+gsJoS/8M7NJ0kkLoCp1QVLpdlzMJGSkLBaVbMvU79OHmm4Sow6sIX+llgUC0+6VhY5g9r8V85T4Qv5QDxCwLCIkAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693433; c=relaxed/simple;
	bh=5v1qibF1z7pef9W6fHNf4GtAJhT/AJKPPL+wYwD4sIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6rUOufi09YQOUIW2/JJNTHC3rFKx75YzHZX80Ci4Uwt5gVdIBRas7GXMvRjx16IRaYvBJYcPSy0stEZyMdIIMIHN+GG1rcvBvEdiFRhTNSsvUqzturdB+vAcDtpALd5DnoU/XgPjqJy6KxL8APk9qHyiq6oGAjeXUOQOHx3/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmbHNase; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33aeb088324so1736714f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707693430; x=1708298230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BelCqyqaTU+jGU/MDi1SS3yrhgj8pP4yG8n+9l1MNk=;
        b=kmbHNasezYEHT/YKpfImt4tpKnwYUHIqLsE5Q/56dOSizKWxhtql8c4FYPoxUQU7Rb
         8FE3jIqoOuzll0mduHO1ZMuWHbpxrX4S98x3c5W25suqJbv7aIUv22dAWur8oRP0b45U
         jKXaC9FSWlsyGOHmHUmS7StGP1BlBDGB/DJ5HhVa0XtxSYYCF3u4JLpKpZmsYX1Ui7w2
         LdT2Bl2L2qJYS190rheuZPKBBzLytWKRz02BjxgNUDOj9c6GhuMbaHueuvC9hd0BNDqr
         0S75QuMBaV8H+PjHIe+D6Q9kccnIZcg2820FD5P5hsuNbLH7n1yex+W4mqPCeJePNhoc
         1EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693430; x=1708298230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BelCqyqaTU+jGU/MDi1SS3yrhgj8pP4yG8n+9l1MNk=;
        b=NiTFhDMvjpiTr84tk8vwb90fEHCE6TtVuKE25/JPgz5WqUfvOL+1tRnO25B12i5nao
         ahiAeNeY4K3AbcjTfc76d2ooG+3vAFQDW16izl1qe7YvFesDpAbGejYoeplyeElCKIJ1
         JQTYSR2w8jjH6KASHs7m9EqKZcQgXgm4vfEYfQSGRc0kIxOnK0ZdrdcORW8qsPoRboZM
         2pA5JPtVVZpJ3Nur/LvEg2D5Ndu6XK9Pqg2Q5VQCCHtynzoO2cjto6+86wX1GUkfPxJa
         lDrIJ6IDaoyjdRybzPXr4sCL0yGHA3pklpnulLZNsRKoPsUdIPTN0MXbxLSmwPEk/029
         2Wtg==
X-Gm-Message-State: AOJu0YwVa52xYtet7qU9mbcdH6W6spCs3SNH3a+QnpPpEcLWGo8PE0dK
	eDxzLKfkak8Gs6COHbKj/2my0lliD8EPUBzQyYrFdOvTSNqLmlkjf3OLVut4JVPSx0jEFM4YLJI
	DB3rFW5+dW+fLr5py6eloJgDbrDA=
X-Google-Smtp-Source: AGHT+IFFL/MKwizXOriFDstOkB8SNAUe6UMzjEPg2XrPAtb+ThnWt+digxgGf9Pux0b5RssTvp42Ayek14h5s66PUSw=
X-Received: by 2002:adf:f812:0:b0:33b:66a1:d3d5 with SMTP id
 s18-20020adff812000000b0033b66a1d3d5mr3951831wrp.19.1707693429624; Sun, 11
 Feb 2024 15:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202113259.3045705-1-paul.heidekrueger@tum.de> <20240211091720.145235-1-paul.heidekrueger@tum.de>
In-Reply-To: <20240211091720.145235-1-paul.heidekrueger@tum.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 12 Feb 2024 00:16:58 +0100
Message-ID: <CA+fCnZcfUyqzok0yV2uvsDdhiT95Y-KYnozY77y04YDBwKhj-Q@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add atomic tests
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 10:17=E2=80=AFAM Paul Heidekr=C3=BCger
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
> Reviewed-by: Marco Elver <elver@google.com>
> Tested-by: Marco Elver <elver@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>
> ---
> Changes PATCH v1 -> PATCH v2:
> * Make explicit cast implicit as per Mark's feedback
> * Increase the size of the "a2" allocation as per Andrey's feedback
> * Add tags
>
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
> index 8281eb42464b..7bf09699b145 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1150,6 +1150,84 @@ static void kasan_bitops_tags(struct kunit *test)
>         kfree(bits);
>  }
>
> +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void =
*safe)
> +{
> +       int *i_unsafe =3D unsafe;
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
> +       a2 =3D kzalloc(sizeof(atomic_long_t), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);

This should check for a2, not a1. Sorry for not spotting this before.

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

With the mentioned change:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

