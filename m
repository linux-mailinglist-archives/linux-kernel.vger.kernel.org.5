Return-Path: <linux-kernel+bounces-71284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E085A2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D651F23911
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494462E40A;
	Mon, 19 Feb 2024 12:11:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD32E3FB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344716; cv=none; b=jo5q3J9YufJ9cJOoSzGdRMkIlpobJLP8RssaH6fGL8o3Qwc3yx0VLplzKDlm1GUzmenzTuVHE8TULSuvwL0AXdv3538K5kUyPsYcNvfnQYNf0KzVCAiCTZc1kPN/G2YrU04Jc6ZEs1AiwwxQJne0BurKa1JP/8DXJwPvGhA+4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344716; c=relaxed/simple;
	bh=nbCrIiGQgT6OV9NF2rFr/ntsXQhipJEzvrro1OyOHAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz4QpB2nqKHMjn/DxqsuclS7HXS8Nj6JbG35Rt5YfxkEPQj4xT7B/A7RmgpnsL8O4GOD2PrJ/GRwmXyDmMjkYz06tlNz6etCic+WfR+Qpdqxll8FKQ/0mHZiMEXTJcwIk0A1WFg9JJ3jv4vLAr11WRCUjyBKeSAjJKi/nsxqeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 374FAFEC;
	Mon, 19 Feb 2024 04:12:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73ED73F73F;
	Mon, 19 Feb 2024 04:11:49 -0800 (PST)
Date: Mon, 19 Feb 2024 12:11:42 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: boqun.feng@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
	neeraj.iitr10@gmail.com, nphamcs@gmail.com, paulmck@kernel.org,
	peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] locking/atomic: scripts: clarify ordering of
 conditional atomics
Message-ID: <ZdNFfoN6V3qj3-FM@FVFF77S0Q05N>
References: <20240209124010.2096198-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209124010.2096198-1-mark.rutland@arm.com>

Hi Thomas/Ingo/Boris,

Atomic API patches normally go via tip locking/core, would one of you be happy
to queue this up? Normally I'd ask Peter.

If you'd prefer that I resend and/or fixup anything, please let me know!

Mark.

On Fri, Feb 09, 2024 at 12:40:10PM +0000, Mark Rutland wrote:
> Conditional atomic operations (e.g. cmpxchg()) only provide ordering
> when the condition holds; when the condition does not hold, the location
> is not modified and relaxed ordering is provided. Where ordering is
> needed for failed conditional atomics, it is necessary to use
> smp_mb__before_atomic() and/or smp_mb__after_atomic().
> 
> This is explained tersely in memory-barriers.txt, and is implied but not
> explicitly stated in the kerneldoc comments for the conditional
> operations. The lack of an explicit statement has lead to some off-list
> queries about the ordering semantics of failing conditional operations,
> so evidently this is confusing.
> 
> Update the kerneldoc comments to explcitly describe the lack of ordering
> for failed conditional atomic operations.
> 
> For most conditional atomic operations, this is written as:
> 
> | If (${condition}), atomically updates @v to (${new}) with ${desc_order} ordering.
> | Otherwise, @v is not modified and relaxed ordering is provided.
> 
> For the try_cmpxchg() operations, this is written as:
> 
> | If (${condition}), atomically updates @v to @new with ${desc_order} ordering.
> | Otherwise, @v is not modified, @old is updated to the current value of @v,
> | and relaxed ordering is provided.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/atomic/atomic-arch-fallback.h  | 46 ++++++++++---
>  include/linux/atomic/atomic-instrumented.h   | 68 ++++++++++++++++----
>  include/linux/atomic/atomic-long.h           | 24 +++++--
>  scripts/atomic/kerneldoc/add_unless          |  1 +
>  scripts/atomic/kerneldoc/cmpxchg             |  1 +
>  scripts/atomic/kerneldoc/dec_if_positive     |  1 +
>  scripts/atomic/kerneldoc/dec_unless_positive |  1 +
>  scripts/atomic/kerneldoc/inc_not_zero        |  1 +
>  scripts/atomic/kerneldoc/inc_unless_negative |  1 +
>  scripts/atomic/kerneldoc/try_cmpxchg         |  3 +-
>  10 files changed, 119 insertions(+), 28 deletions(-)
> 
> Since v1 [1]
> * Consistently use "relaxed ordering" rather than "no ordering"
> * Fold in Reviewed-by tags
> 
> [1] https://lore.kernel.org/lkml/ZcYb_U45Jro_MMeJ@FVFF77S0Q05N.cambridge.arm.com/T/#mcdcdc15b4e9e470196ecf4f3277d9e302034243f
> 
> Mark.
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 5e95faa959c42..956bcba5dbf2f 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -2005,6 +2005,7 @@ raw_atomic_xchg_relaxed(atomic_t *v, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
>   *
> @@ -2033,6 +2034,7 @@ raw_atomic_cmpxchg(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_cmpxchg_acquire() elsewhere.
>   *
> @@ -2061,6 +2063,7 @@ raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_cmpxchg_release() elsewhere.
>   *
> @@ -2088,6 +2091,7 @@ raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_cmpxchg_relaxed() elsewhere.
>   *
> @@ -2112,7 +2116,8 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_try_cmpxchg() elsewhere.
>   *
> @@ -2145,7 +2150,8 @@ raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_try_cmpxchg_acquire() elsewhere.
>   *
> @@ -2178,7 +2184,8 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_try_cmpxchg_release() elsewhere.
>   *
> @@ -2210,7 +2217,8 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_try_cmpxchg_relaxed() elsewhere.
>   *
> @@ -2403,6 +2411,7 @@ raw_atomic_add_negative_relaxed(int i, atomic_t *v)
>   * @u: int value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_fetch_add_unless() elsewhere.
>   *
> @@ -2432,6 +2441,7 @@ raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
>   * @u: int value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_add_unless() elsewhere.
>   *
> @@ -2452,6 +2462,7 @@ raw_atomic_add_unless(atomic_t *v, int a, int u)
>   * @v: pointer to atomic_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_inc_not_zero() elsewhere.
>   *
> @@ -2472,6 +2483,7 @@ raw_atomic_inc_not_zero(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_inc_unless_negative() elsewhere.
>   *
> @@ -2499,6 +2511,7 @@ raw_atomic_inc_unless_negative(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_dec_unless_positive() elsewhere.
>   *
> @@ -2526,6 +2539,7 @@ raw_atomic_dec_unless_positive(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_dec_if_positive() elsewhere.
>   *
> @@ -4117,6 +4131,7 @@ raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_cmpxchg() elsewhere.
>   *
> @@ -4145,6 +4160,7 @@ raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_cmpxchg_acquire() elsewhere.
>   *
> @@ -4173,6 +4189,7 @@ raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_cmpxchg_release() elsewhere.
>   *
> @@ -4200,6 +4217,7 @@ raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_cmpxchg_relaxed() elsewhere.
>   *
> @@ -4224,7 +4242,8 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_try_cmpxchg() elsewhere.
>   *
> @@ -4257,7 +4276,8 @@ raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_acquire() elsewhere.
>   *
> @@ -4290,7 +4310,8 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_release() elsewhere.
>   *
> @@ -4322,7 +4343,8 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_relaxed() elsewhere.
>   *
> @@ -4515,6 +4537,7 @@ raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
>   * @u: s64 value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_fetch_add_unless() elsewhere.
>   *
> @@ -4544,6 +4567,7 @@ raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>   * @u: s64 value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_add_unless() elsewhere.
>   *
> @@ -4564,6 +4588,7 @@ raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_inc_not_zero() elsewhere.
>   *
> @@ -4584,6 +4609,7 @@ raw_atomic64_inc_not_zero(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_inc_unless_negative() elsewhere.
>   *
> @@ -4611,6 +4637,7 @@ raw_atomic64_inc_unless_negative(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_dec_unless_positive() elsewhere.
>   *
> @@ -4638,6 +4665,7 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic64_dec_if_positive() elsewhere.
>   *
> @@ -4662,4 +4690,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// eec048affea735b8464f58e6d96992101f8f85f1
> +// 14850c0b0db20c62fdc78ccd1d42b98b88d76331
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 54d7bbe0aeaa6..debd487fe9716 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1182,6 +1182,7 @@ atomic_xchg_relaxed(atomic_t *v, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_cmpxchg() there.
>   *
> @@ -1202,6 +1203,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_acquire() there.
>   *
> @@ -1221,6 +1223,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_release() there.
>   *
> @@ -1241,6 +1244,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_relaxed() there.
>   *
> @@ -1260,7 +1264,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
>   *
> @@ -1282,7 +1287,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_acquire() there.
>   *
> @@ -1303,7 +1309,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_release() there.
>   *
> @@ -1325,7 +1332,8 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
>   * @new: int value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_relaxed() there.
>   *
> @@ -1475,6 +1483,7 @@ atomic_add_negative_relaxed(int i, atomic_t *v)
>   * @u: int value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_fetch_add_unless() there.
>   *
> @@ -1495,6 +1504,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
>   * @u: int value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_add_unless() there.
>   *
> @@ -1513,6 +1523,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
>   * @v: pointer to atomic_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_inc_not_zero() there.
>   *
> @@ -1531,6 +1542,7 @@ atomic_inc_not_zero(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_inc_unless_negative() there.
>   *
> @@ -1549,6 +1561,7 @@ atomic_inc_unless_negative(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_dec_unless_positive() there.
>   *
> @@ -1567,6 +1580,7 @@ atomic_dec_unless_positive(atomic_t *v)
>   * @v: pointer to atomic_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_dec_if_positive() there.
>   *
> @@ -2746,6 +2760,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg() there.
>   *
> @@ -2766,6 +2781,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_acquire() there.
>   *
> @@ -2785,6 +2801,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_release() there.
>   *
> @@ -2805,6 +2822,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_relaxed() there.
>   *
> @@ -2824,7 +2842,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg() there.
>   *
> @@ -2846,7 +2865,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_acquire() there.
>   *
> @@ -2867,7 +2887,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_release() there.
>   *
> @@ -2889,7 +2910,8 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
>   * @new: s64 value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_relaxed() there.
>   *
> @@ -3039,6 +3061,7 @@ atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
>   * @u: s64 value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_unless() there.
>   *
> @@ -3059,6 +3082,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>   * @u: s64 value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_add_unless() there.
>   *
> @@ -3077,6 +3101,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_inc_not_zero() there.
>   *
> @@ -3095,6 +3120,7 @@ atomic64_inc_not_zero(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_inc_unless_negative() there.
>   *
> @@ -3113,6 +3139,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_dec_unless_positive() there.
>   *
> @@ -3131,6 +3158,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
>   * @v: pointer to atomic64_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_dec_if_positive() there.
>   *
> @@ -4310,6 +4338,7 @@ atomic_long_xchg_relaxed(atomic_long_t *v, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg() there.
>   *
> @@ -4330,6 +4359,7 @@ atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_acquire() there.
>   *
> @@ -4349,6 +4379,7 @@ atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_release() there.
>   *
> @@ -4369,6 +4400,7 @@ atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_relaxed() there.
>   *
> @@ -4388,7 +4420,8 @@ atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg() there.
>   *
> @@ -4410,7 +4443,8 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_acquire() there.
>   *
> @@ -4431,7 +4465,8 @@ atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_release() there.
>   *
> @@ -4453,7 +4488,8 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_relaxed() there.
>   *
> @@ -4603,6 +4639,7 @@ atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
>   * @u: long value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_unless() there.
>   *
> @@ -4623,6 +4660,7 @@ atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
>   * @u: long value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_add_unless() there.
>   *
> @@ -4641,6 +4679,7 @@ atomic_long_add_unless(atomic_long_t *v, long a, long u)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_inc_not_zero() there.
>   *
> @@ -4659,6 +4698,7 @@ atomic_long_inc_not_zero(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_inc_unless_negative() there.
>   *
> @@ -4677,6 +4717,7 @@ atomic_long_inc_unless_negative(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_dec_unless_positive() there.
>   *
> @@ -4695,6 +4736,7 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_dec_if_positive() there.
>   *
> @@ -5008,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 2cc4bc990fef44d3836ec108f11b610f3f438184
> +// ce5b65e0f1f8a276268b667194581d24bed219d4
> diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
> index c82947170ddc8..3ef844b3ab8a3 100644
> --- a/include/linux/atomic/atomic-long.h
> +++ b/include/linux/atomic/atomic-long.h
> @@ -1352,6 +1352,7 @@ raw_atomic_long_xchg_relaxed(atomic_long_t *v, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_cmpxchg() elsewhere.
>   *
> @@ -1374,6 +1375,7 @@ raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_cmpxchg_acquire() elsewhere.
>   *
> @@ -1396,6 +1398,7 @@ raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_cmpxchg_release() elsewhere.
>   *
> @@ -1418,6 +1421,7 @@ raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_cmpxchg_relaxed() elsewhere.
>   *
> @@ -1440,7 +1444,8 @@ raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with full ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg() elsewhere.
>   *
> @@ -1463,7 +1468,8 @@ raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with acquire ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_acquire() elsewhere.
>   *
> @@ -1486,7 +1492,8 @@ raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with release ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_release() elsewhere.
>   *
> @@ -1509,7 +1516,8 @@ raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
>   * @new: long value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with relaxed ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_relaxed() elsewhere.
>   *
> @@ -1677,6 +1685,7 @@ raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
>   * @u: long value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_fetch_add_unless() elsewhere.
>   *
> @@ -1699,6 +1708,7 @@ raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
>   * @u: long value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_add_unless() elsewhere.
>   *
> @@ -1719,6 +1729,7 @@ raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_inc_not_zero() elsewhere.
>   *
> @@ -1739,6 +1750,7 @@ raw_atomic_long_inc_not_zero(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_inc_unless_negative() elsewhere.
>   *
> @@ -1759,6 +1771,7 @@ raw_atomic_long_inc_unless_negative(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_dec_unless_positive() elsewhere.
>   *
> @@ -1779,6 +1792,7 @@ raw_atomic_long_dec_unless_positive(atomic_long_t *v)
>   * @v: pointer to atomic_long_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * Safe to use in noinstr code; prefer atomic_long_dec_if_positive() elsewhere.
>   *
> @@ -1795,4 +1809,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_LONG_H */
> -// 4ef23f98c73cff96d239896175fd26b10b88899e
> +// 1c4a26fc77f345342953770ebe3c4d08e7ce2f9a
> diff --git a/scripts/atomic/kerneldoc/add_unless b/scripts/atomic/kerneldoc/add_unless
> index f828e5f6750c2..fbc2fadfbdc41 100644
> --- a/scripts/atomic/kerneldoc/add_unless
> +++ b/scripts/atomic/kerneldoc/add_unless
> @@ -10,6 +10,7 @@ cat <<EOF
>   * @u: ${int} value to compare with
>   *
>   * If (@v != @u), atomically updates @v to (@v + @a) with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/cmpxchg b/scripts/atomic/kerneldoc/cmpxchg
> index 3bce328f50cff..02b24ee9d8a4f 100644
> --- a/scripts/atomic/kerneldoc/cmpxchg
> +++ b/scripts/atomic/kerneldoc/cmpxchg
> @@ -6,6 +6,7 @@ cat <<EOF
>   * @new: ${int} value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/dec_if_positive b/scripts/atomic/kerneldoc/dec_if_positive
> index 04f1aed3cf830..9468b4a69603e 100644
> --- a/scripts/atomic/kerneldoc/dec_if_positive
> +++ b/scripts/atomic/kerneldoc/dec_if_positive
> @@ -4,6 +4,7 @@ cat <<EOF
>   * @v: pointer to ${atomic}_t
>   *
>   * If (@v > 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/dec_unless_positive b/scripts/atomic/kerneldoc/dec_unless_positive
> index ee73612f03547..06a678678f717 100644
> --- a/scripts/atomic/kerneldoc/dec_unless_positive
> +++ b/scripts/atomic/kerneldoc/dec_unless_positive
> @@ -4,6 +4,7 @@ cat <<EOF
>   * @v: pointer to ${atomic}_t
>   *
>   * If (@v <= 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/inc_not_zero b/scripts/atomic/kerneldoc/inc_not_zero
> index 618be08e653e5..c1a30fc66ee90 100644
> --- a/scripts/atomic/kerneldoc/inc_not_zero
> +++ b/scripts/atomic/kerneldoc/inc_not_zero
> @@ -4,6 +4,7 @@ cat <<EOF
>   * @v: pointer to ${atomic}_t
>   *
>   * If (@v != 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/inc_unless_negative b/scripts/atomic/kerneldoc/inc_unless_negative
> index 597f23d4dc8dc..ece0d2c7b38f1 100644
> --- a/scripts/atomic/kerneldoc/inc_unless_negative
> +++ b/scripts/atomic/kerneldoc/inc_unless_negative
> @@ -4,6 +4,7 @@ cat <<EOF
>   * @v: pointer to ${atomic}_t
>   *
>   * If (@v >= 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
> + * Otherwise, @v is not modified and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> diff --git a/scripts/atomic/kerneldoc/try_cmpxchg b/scripts/atomic/kerneldoc/try_cmpxchg
> index 296553206c06e..3ccff29538f5f 100644
> --- a/scripts/atomic/kerneldoc/try_cmpxchg
> +++ b/scripts/atomic/kerneldoc/try_cmpxchg
> @@ -6,7 +6,8 @@ cat <<EOF
>   * @new: ${int} value to assign
>   *
>   * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
> - * Otherwise, updates @old to the current value of @v.
> + * Otherwise, @v is not modified, @old is updated to the current value of @v,
> + * and relaxed ordering is provided.
>   *
>   * ${desc_noinstr}
>   *
> -- 
> 2.30.2
> 

