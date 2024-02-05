Return-Path: <linux-kernel+bounces-52988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFC849F32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DD6289C31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC532C8E;
	Mon,  5 Feb 2024 16:01:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD446481AA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148901; cv=none; b=mLBCjGUEEFCQ0mcdQDIKOt3hcJAhPtgzd7LfBq6t31430yaLFtZsd/L6b9dWD9CtwJJ6fDsWWMq4BmfxhKXCDaP1zhSA+CyDeFFUo+yai7sN6yUQsgOK0mpTX/Vw+fnBPsmo70cJeF0swNgWIoBEKHpzqCv1ZkBXPFncF5N+0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148901; c=relaxed/simple;
	bh=w39i9b5zeD4hlOJX+0l1a7jxiYP+46vPnTC8na2NbVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0g6cBq6+ZR21B0LIjYeGlxINL22os0cdQZW17tH8E1rrmlIkGNJIxIOz2Nn0xfx0xPvgxsW/vyIVbiMFbhF//k3/DoGkfflLttubn4xYQLie47awe1KEL5U1x50q13Sb2tPk2RrJ/dWPixdrc+EqmQ2xUlvx7AHG0v7YEHJfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE801FB;
	Mon,  5 Feb 2024 08:02:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777FE3F5A1;
	Mon,  5 Feb 2024 08:01:36 -0800 (PST)
Date: Mon, 5 Feb 2024 16:01:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul Heidekr\"uger" <paul.heidekrueger@tum.de>
Cc: elver@google.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Subject: Re: [PATCH] kasan: add atomic tests
Message-ID: <ZcEGWm30LsslEpMH@FVFF77S0Q05N>
References: <CANpmjNP033FCJUb_nzTMJZnvXQj8esFBv_tg5-rtNtVUsGLB_A@mail.gmail.com>
 <20240202113259.3045705-1-paul.heidekrueger@tum.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202113259.3045705-1-paul.heidekrueger@tum.de>

On Fri, Feb 02, 2024 at 11:32:59AM +0000, Paul Heidekr"uger wrote:
> Test that KASan can detect some unsafe atomic accesses.
> 
> As discussed in the linked thread below, these tests attempt to cover
> the most common uses of atomics and, therefore, aren't exhaustive.
> 
> CC: Marco Elver <elver@google.com>
> CC: Andrey Konovalov <andreyknvl@gmail.com>
> Link: https://lore.kernel.org/all/20240131210041.686657-1-paul.heidekrueger@tum.de/T/#u
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
> Signed-off-by: Paul Heidekr"uger <paul.heidekrueger@tum.de>
> ---
> Changes PATCH RFC v2 -> PATCH v1:
> * Remove casts to void*
> * Remove i_safe variable
> * Add atomic_long_* test cases
> * Carry over comment from kasan_bitops_tags()
> 
> Changes PATCH RFC v1 -> PATCH RFC v2:
> * Adjust size of allocations to make kasan_atomics() work with all KASan modes
> * Remove comments and move tests closer to the bitops tests
> * For functions taking two addresses as an input, test each address in a separate function call.
> * Rename variables for clarity
> * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_store_release()
> 
>  mm/kasan/kasan_test.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 8281eb42464b..4ef2280c322c 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1150,6 +1150,84 @@ static void kasan_bitops_tags(struct kunit *test)
>  	kfree(bits);
>  }
>  
> +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
> +{
> +	int *i_unsafe = (int *)unsafe;

Minor nit: you don't need the cast here either.

Regardless:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_and(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_andnot(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_or(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xor(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_and(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_andnot(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_or(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xor(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, safe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe));
> +}
> +
> +static void kasan_atomics(struct kunit *test)
> +{
> +	void *a1, *a2;
> +
> +	/*
> +	 * Just as with kasan_bitops_tags(), we allocate 48 bytes of memory such
> +	 * that the following 16 bytes will make up the redzone.
> +	 */
> +	a1 = kzalloc(48, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +	a2 = kzalloc(sizeof(int), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +
> +	/* Use atomics to access the redzone. */
> +	kasan_atomics_helper(test, a1 + 48, a2);
> +
> +	kfree(a1);
> +	kfree(a2);
> +}
> +
>  static void kmalloc_double_kzfree(struct kunit *test)
>  {
>  	char *ptr;
> @@ -1553,6 +1631,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_strings),
>  	KUNIT_CASE(kasan_bitops_generic),
>  	KUNIT_CASE(kasan_bitops_tags),
> +	KUNIT_CASE(kasan_atomics),
>  	KUNIT_CASE(kmalloc_double_kzfree),
>  	KUNIT_CASE(rcu_uaf),
>  	KUNIT_CASE(workqueue_uaf),
> -- 
> 2.40.1
> 
> 

