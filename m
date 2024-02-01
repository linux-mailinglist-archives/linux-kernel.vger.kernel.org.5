Return-Path: <linux-kernel+bounces-47894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96984543F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB878B2702D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C74DA0E;
	Thu,  1 Feb 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQt3V5mK"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73915D5B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780329; cv=none; b=dcQwGFDKaRN8/WgwFY2TSUjQvsggER0Xgl1jTTp92UCFVnySB618Cpz0GYxvjxC+No7RBBchn+Mx4mdEGCUjiQ3RrBqNBCyP41/cZIzz41VjoWWxhIZ2sOWecLk7eScNk/xXw/14WDk0S47ShJtkT4FwTngSpEWoCLRW4rSaGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780329; c=relaxed/simple;
	bh=a/aTDNN6EMDkD+niHUP8ICMvAXcz4gxgK/NiZj68fgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifWmaj3GVkSeEX1ThGbTkXySQQ1CPAQWem51NPBwZIchgl+YxT0LBGY4B3vXKl/T8KDn/2j6orQd/9kdJ+zF6mwqdGllr8wPY7ShYr2BoXxBx+/bKLlSOi9DxBxOKBpfFD5Diny0blsnBFXuqj6H0T45M8TaX0P7pXYfWiVgyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQt3V5mK; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bffff28c08so141583e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780326; x=1707385126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD0yQ/tI+tg2dm8uEuvvq9XaoXhsRoncokKKzr2jeMM=;
        b=CQt3V5mKUZJtQ1Uc8NnqYw51bPgPqJyKqw3J+2N7R+9c9SBZzi+UxRbOQLbmei3KH3
         QlTbiuP1hflU64f8mbOo5j7TgWUqH/O48q7wAvBHhUZ/sW1C4LE6Ucs5sDW62sqgCI8l
         d2SpKqkLGIgQZZ4v0ZwX/J7CBCrNI7TGleUuBAECg7x7Ty3/f4CKvRyQVM+Cekv1VnMp
         4z6Bsm0sWyJZIwmbivPzWVUHChqNMzbGekWOzjqCy3OYHB+xfSixyIbwZkx1iiJeGQnO
         YwdH6C9S3GXG0TTzkeyINNgFk1ojCVBeNhvfxf4s+Eq5RcU+jAR1PCOXU2vthM9xAAUK
         d6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780326; x=1707385126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XD0yQ/tI+tg2dm8uEuvvq9XaoXhsRoncokKKzr2jeMM=;
        b=RhNcgab1i25lgDWjveFu89XRti3BMLbcAxUy+o2cODDxcvx6lBgBT8cjZzcnF69t3c
         hJIvv5fbM5ybNKpDzDKwA6wMFGIc8qOwkLZuYbVZdq67ygLJwIp1St/4Whs4zcX0mfYN
         xOLEcDakCqsFnhY1x9JDKYRbzEoN129WWDCa5sMH0Wm/MN5Mj9ClD+vJB4I5wRsjhnc/
         +g/IIPSv5JcnBRL+6R+P5+65x4L1Ok3R8fOb3lxdgK/VG6RgifbXYm0/DYrqgJ42LSBz
         60ezfnMvQ7JKwjk1rGHN42N3EFnWHFkbKaNttGvXWRCsLPgVFUKDcO1UZoYQX3zZyf0I
         0hLQ==
X-Gm-Message-State: AOJu0YzvgZedIlke79lV7jdML7GZaK6yKBnlwr2D578IvtXsjA62M7T5
	znnu7B7MLzGtGJVyA8sHySonDYaBDCGaq5XaK/N+Kz5wwZd7rqOp1QQJ/Q6s9f+5Q9+fw9bBEW6
	f0JxCFCok8oZmmBGPqlqXGcCTskdAFUaNqDVw
X-Google-Smtp-Source: AGHT+IH+sgJyGjTNJ8nrAZACpyhjF1aGCbvp4J/0sKBmH4acCQHArxhx13e7Uh8RuNCOYXyQzWjA12EqMJKHy6Nh8Ic=
X-Received: by 2002:a05:6122:1d87:b0:4bd:7da1:a2ea with SMTP id
 gg7-20020a0561221d8700b004bd7da1a2eamr1519212vkb.14.1706780326396; Thu, 01
 Feb 2024 01:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131210041.686657-1-paul.heidekrueger@tum.de>
In-Reply-To: <20240131210041.686657-1-paul.heidekrueger@tum.de>
From: Marco Elver <elver@google.com>
Date: Thu, 1 Feb 2024 10:38:07 +0100
Message-ID: <CANpmjNPvQ16mrQOTzecN6ZpYe+N8dBw8V+Mci53CBgC2sx84Ew@mail.gmail.com>
Subject: Re: [PATCH RFC v2] kasan: add atomic tests
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 22:01, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.=
de> wrote:
>
> Hi!
>
> This RFC patch adds tests that detect whether KASan is able to catch
> unsafe atomic accesses.
>
> Since v1, which can be found on Bugzilla (see "Closes:" tag), I've made
> the following suggested changes:
>
> * Adjust size of allocations to make kasan_atomics() work with all KASan =
modes
> * Remove comments and move tests closer to the bitops tests
> * For functions taking two addresses as an input, test each address in a =
separate function call.
> * Rename variables for clarity
> * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_sto=
re_release()
>
> I'm still uncelar on which kinds of atomic accesses we should be testing
> though. The patch below only covers a subset, and I don't know if it
> would be feasible to just manually add all atomics of interest. Which
> ones would those be exactly?

The atomics wrappers are generated by a script. An exhaustive test
case would, if generated by hand, be difficult to keep in sync if some
variants are removed or renamed (although that's probably a relatively
rare occurrence).

I would probably just cover some of the most common ones that all
architectures (that support KASAN) provide. I think you are already
covering some of the most important ones, and I'd just say it's good
enough for the test.

> As Andrey pointed out on Bugzilla, if we
> were to include all of the atomic64_* ones, that would make a lot of
> function calls.

Just include a few atomic64_ cases, similar to the ones you already
include for atomic_. Although beware that the atomic64_t helpers are
likely not available on 32-bit architectures, so you need an #ifdef
CONFIG_64BIT.

Alternatively, there is also atomic_long_t, which (on 64-bit
architectures) just wraps atomic64_t helpers, and on 32-bit the
atomic_t ones. I'd probably opt for the atomic_long_t variants, just
to keep it simpler and get some additional coverage on 32-bit
architectures.

> Also, the availability of atomics varies between architectures; I did my
> testing on arm64. Is something like gen-atomic-instrumented.sh required?

I would not touch gen-atomic-instrumented.sh for the test.

> Many thanks,
> Paul
>
> CC: Marco Elver <elver@google.com>
> CC: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D214055
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>
> ---
>  mm/kasan/kasan_test.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 8281eb42464b..1ab4444fe4a0 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1150,6 +1150,55 @@ static void kasan_bitops_tags(struct kunit *test)
>         kfree(bits);
>  }
>
> +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void =
*safe)
> +{
> +       int *i_safe =3D (int *)safe;
> +       int *i_unsafe =3D (int *)unsafe;
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> +       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +       KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
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
> +}
> +
> +static void kasan_atomics(struct kunit *test)
> +{
> +       int *a1, *a2;

If you're casting it to void* below and never using as an int* in this
function, just make these void* (the sizeof can just be sizeof(int)).

> +       a1 =3D kzalloc(48, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +       a2 =3D kzalloc(sizeof(*a1), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +
> +       kasan_atomics_helper(test, (void *)a1 + 48, (void *)a2);

We try to ensure (where possible) that the KASAN tests are not
destructive to the rest of the kernel. I think the size of "48" was
chosen to fall into the 64-byte size class, similar to the bitops. I
would just copy that comment, so nobody attempts to change it in
future. :-)

> +       kfree(a1);
> +       kfree(a2);

Thanks,
-- Marco

