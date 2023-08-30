Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69878DE52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjH3TBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbjH3JNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:13:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA2D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:13:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so47005885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693386810; x=1693991610; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhyEw/ePQDVdb4vOINYViLe53fZAlgyX/muJWosF9Kc=;
        b=5zounGdaM/7md1ZI73fYdXUxPmTagfA37RqoztNO0Wsf7Q/C636DAjgTPEKvVkB+ag
         /XUjA0BD07JcXkzofueZ1r4FmJ+Y1TYaP3qHHLI3nZCRKfcEie+lpAHFmNKOBlu8ip50
         +kgCQnpF8aEbiG4wq9PejuM3ey4AFge/8MGrdFPwUafTNd6M+0xGotxfyA+Exf7QiUZt
         raJ4gBz7LhCe20bkFFN8siGucSMJgEL0Pble/9mVtN3Z+VDLZE/snT+u1ojcjCr7kUN/
         0e7vCbUZbeDN4h+HffY2TBs76yABOF4/HkVTF1qfkp8ny5pDalTrKTn+keGTrPYCNuDS
         j4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386810; x=1693991610;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhyEw/ePQDVdb4vOINYViLe53fZAlgyX/muJWosF9Kc=;
        b=TwzLXUKughHMhAzDeQTi1iGd0SGmeil9MQGfZFKAVRTU0lxOkq7N3m4cJaPwjXIKs4
         0TAo+ibgGDn785TNFy9fIvf2Si2z1gqSFkp5pmniSoelLfJ+x+MPRxH18oPIUHx1EwaE
         CeEAiMO6kmGYszaBYtFBM2pGvoBWotLJHHfr615a3takUr2ZZRlWuqFtReL3OKzps41J
         nPfL8icgG8AlGQkAZIgVD31UZpj9bXcQ3YCYZ6qIix63vwIuAcpbOiuUFzgrebpWyoFd
         cOkONZHDBoazwSa9B8TeLW2xlpLDl/lVG3K+WFJH0wiIy3zDKXM9AbYMPVdOfDRXqV1r
         sCJQ==
X-Gm-Message-State: AOJu0YzdbQuDlUioSBgoNUI0qA/zOYDhcwfXkuhc3FRpD0BCd1vEsxfv
        2pXzTtciXk4IQPdob+RtzIUveQ==
X-Google-Smtp-Source: AGHT+IGgAbxwgYEoPhl4bJ2BDFMtfUkHB6K97Foi5ciCXfQt5NVDpODiy/rU94dxBruBEL0YTv+xtQ==
X-Received: by 2002:a5d:69ce:0:b0:31c:7001:3873 with SMTP id s14-20020a5d69ce000000b0031c70013873mr1009604wrw.60.1693386810299;
        Wed, 30 Aug 2023 02:13:30 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b003140f47224csm16003124wrt.15.2023.08.30.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:13:29 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:13:23 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
Message-ID: <ZO8IMysDIT7XnN9Z@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:11PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, stack depot uses the following locking scheme:
> 
> 1. Lock-free accesses when looking up a stack record, which allows to
>    have multiple users to look up records in parallel;
> 2. Spinlock for protecting the stack depot pools and the hash table
>    when adding a new record.
> 
> For implementing the eviction of stack traces from stack depot, the
> lock-free approach is not going to work anymore, as we will need to be
> able to also remove records from the hash table.
> 
> Convert the spinlock into a read/write lock, and drop the atomic accesses,
> as they are no longer required.
> 
> Looking up stack traces is now protected by the read lock and adding new
> records - by the write lock. One of the following patches will add a new
> function for evicting stack records, which will be protected by the write
> lock as well.
> 
> With this change, multiple users can still look up records in parallel.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/stackdepot.c | 76 ++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 9011f4adcf20..5ad454367379 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -23,6 +23,7 @@
>  #include <linux/percpu.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/stacktrace.h>
>  #include <linux/stackdepot.h>
>  #include <linux/string.h>
> @@ -92,15 +93,15 @@ static void *new_pool;
>  static int pools_num;
>  /* Next stack in the freelist of stack records within stack_pools. */
>  static struct stack_record *next_stack;
> -/* Lock that protects the variables above. */
> -static DEFINE_RAW_SPINLOCK(pool_lock);
>  /*
>   * Stack depot tries to keep an extra pool allocated even before it runs out
>   * of space in the currently used pool. This flag marks whether this extra pool
>   * needs to be allocated. It has the value 0 when either an extra pool is not
>   * yet allocated or if the limit on the number of pools is reached.
>   */
> -static int new_pool_required = 1;
> +static bool new_pool_required = true;
> +/* Lock that protects the variables above. */
> +static DEFINE_RWLOCK(pool_rwlock);

Despite this being a rwlock, it'll introduce tons of (cache) contention
for the common case (stack depot entry exists).

If creating new stack depot entries is only common during "warm-up" and
then becomes exceedingly rare, I think a percpu-rwsem (read-lock is a
CPU-local access, but write-locking is expensive) may be preferable.

>  static int __init disable_stack_depot(char *str)
>  {
> @@ -248,12 +249,7 @@ static void depot_init_pool(void *pool)
>  
>  	/* Save reference to the pool to be used by depot_fetch_stack. */
>  	stack_pools[pools_num] = pool;
> -
> -	/*
> -	 * WRITE_ONCE pairs with potential concurrent read in
> -	 * depot_fetch_stack.
> -	 */
> -	WRITE_ONCE(pools_num, pools_num + 1);
> +	pools_num++;
>  }
>  
>  /* Keeps the preallocated memory to be used for a new stack depot pool. */
> @@ -262,10 +258,8 @@ static void depot_keep_new_pool(void **prealloc)
>  	/*
>  	 * If a new pool is already saved or the maximum number of
>  	 * pools is reached, do not use the preallocated memory.
> -	 * READ_ONCE is only used to mark the variable as atomic,
> -	 * there are no concurrent writes.
>  	 */
> -	if (!READ_ONCE(new_pool_required))
> +	if (!new_pool_required)

In my comment for the other patch I already suggested this change. Maybe
move it there.

>  		return;
>  
>  	/*
> @@ -281,9 +275,8 @@ static void depot_keep_new_pool(void **prealloc)
>  	 * At this point, either a new pool is kept or the maximum
>  	 * number of pools is reached. In either case, take note that
>  	 * keeping another pool is not required.
> -	 * smp_store_release pairs with smp_load_acquire in stack_depot_save.
>  	 */
> -	smp_store_release(&new_pool_required, 0);
> +	new_pool_required = false;
>  }
>  
>  /* Updates refences to the current and the next stack depot pools. */
> @@ -300,7 +293,7 @@ static bool depot_update_pools(void **prealloc)
>  
>  		/* Take note that we might need a new new_pool. */
>  		if (pools_num < DEPOT_MAX_POOLS)
> -			smp_store_release(&new_pool_required, 1);
> +			new_pool_required = true;
>  
>  		/* Try keeping the preallocated memory for new_pool. */
>  		goto out_keep_prealloc;
> @@ -369,18 +362,13 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
>  {
>  	union handle_parts parts = { .handle = handle };
> -	/*
> -	 * READ_ONCE pairs with potential concurrent write in
> -	 * depot_init_pool.
> -	 */
> -	int pools_num_cached = READ_ONCE(pools_num);
>  	void *pool;
>  	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
>  	struct stack_record *stack;

I'd add lockdep assertions to check that the lock is held appropriately
when entering various helper functions that don't actually take the
lock. Similarly for places that should not have the lock held you could
assert the lock is not held.

> -	if (parts.pool_index > pools_num_cached) {
> +	if (parts.pool_index > pools_num) {
>  		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
> -			parts.pool_index, pools_num_cached, handle);
> +			parts.pool_index, pools_num, handle);
>  		return NULL;
>  	}
>  
> @@ -439,6 +427,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	depot_stack_handle_t handle = 0;
>  	struct page *page = NULL;
>  	void *prealloc = NULL;
> +	bool need_alloc = false;
>  	unsigned long flags;
>  	u32 hash;
>  
> @@ -458,22 +447,26 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	hash = hash_stack(entries, nr_entries);
>  	bucket = &stack_table[hash & stack_hash_mask];
>  
> -	/*
> -	 * Fast path: look the stack trace up without locking.
> -	 * smp_load_acquire pairs with smp_store_release to |bucket| below.
> -	 */
> -	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
> -	if (found)
> +	read_lock_irqsave(&pool_rwlock, flags);
> +
> +	/* Fast path: look the stack trace up without full locking. */
> +	found = find_stack(*bucket, entries, nr_entries, hash);
> +	if (found) {
> +		read_unlock_irqrestore(&pool_rwlock, flags);
>  		goto exit;
> +	}
> +
> +	/* Take note if another stack pool needs to be allocated. */
> +	if (new_pool_required)
> +		need_alloc = true;
> +
> +	read_unlock_irqrestore(&pool_rwlock, flags);
>  
>  	/*
> -	 * Check if another stack pool needs to be allocated. If so, allocate
> -	 * the memory now: we won't be able to do that under the lock.
> -	 *
> -	 * smp_load_acquire pairs with smp_store_release
> -	 * in depot_update_pools and depot_keep_new_pool.
> +	 * Allocate memory for a new pool if required now:
> +	 * we won't be able to do that under the lock.
>  	 */
> -	if (unlikely(can_alloc && smp_load_acquire(&new_pool_required))) {
> +	if (unlikely(can_alloc && need_alloc)) {
>  		/*
>  		 * Zero out zone modifiers, as we don't have specific zone
>  		 * requirements. Keep the flags related to allocation in atomic
> @@ -487,7 +480,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  			prealloc = page_address(page);
>  	}
>  
> -	raw_spin_lock_irqsave(&pool_lock, flags);
> +	write_lock_irqsave(&pool_rwlock, flags);
>  
>  	found = find_stack(*bucket, entries, nr_entries, hash);
>  	if (!found) {
> @@ -496,11 +489,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  
>  		if (new) {
>  			new->next = *bucket;
> -			/*
> -			 * smp_store_release pairs with smp_load_acquire
> -			 * from |bucket| above.
> -			 */
> -			smp_store_release(bucket, new);
> +			*bucket = new;
>  			found = new;
>  		}
>  	} else if (prealloc) {
> @@ -511,7 +500,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  		depot_keep_new_pool(&prealloc);
>  	}
>  
> -	raw_spin_unlock_irqrestore(&pool_lock, flags);
> +	write_unlock_irqrestore(&pool_rwlock, flags);
>  exit:
>  	if (prealloc) {
>  		/* Stack depot didn't use this memory, free it. */
> @@ -535,6 +524,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries)
>  {
>  	struct stack_record *stack;
> +	unsigned long flags;
>  
>  	*entries = NULL;
>  	/*
> @@ -546,8 +536,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  	if (!handle || stack_depot_disabled)
>  		return 0;
>  
> +	read_lock_irqsave(&pool_rwlock, flags);
> +
>  	stack = depot_fetch_stack(handle);
>  
> +	read_unlock_irqrestore(&pool_rwlock, flags);
> +
>  	*entries = stack->entries;
>  	return stack->size;
>  }
> -- 
> 2.25.1
> 
