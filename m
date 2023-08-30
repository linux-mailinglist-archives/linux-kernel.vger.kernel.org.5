Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4F78DD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbjH3SsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbjH3Ie2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:34:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32F1AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:34:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so77762091fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693384464; x=1693989264; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt0PhngddEXeQF55w8XLKCuMlgv9f/y2sGmaKeHMR1g=;
        b=tTmscnd+oynfYWjkUgI1XblzLq07ZzL8Eutb6nwE4ZoQ1Mbbx7i0GSyq9mbVYEdKM9
         T5iK9ZNg3yeIUVMQoY3AnolHnbqKLc/3iDbZzQ2zmvlgvYh5yh8vTUBvzk1T6KjMpBA0
         JCUNfgKyOqohItRwepAffQnRME6kwf27niO4DzOP2VyAx+NvnJmO10tdSUh8hugA0UqW
         WhFzdqKgrgVcppQgdJ6Axv7/Q861DnvZ0ohC91vF84i8DkAH6qU2mfqh9N2631/fh84K
         H46rPbS9BBXvb3IUcDDKXZGw3ycFpRj/yUPZdpbR6YG3IWe64aK/QsZKr7ZOcR12Y+Qh
         xiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384464; x=1693989264;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt0PhngddEXeQF55w8XLKCuMlgv9f/y2sGmaKeHMR1g=;
        b=ReL+0k2F3oP07ZKPDI9b8P9p1yEAhzdTvVIAeQft8ZwYv2YmPnUirDQxUNDmLSNWlZ
         ASJEiXq8zt4vIHuVlmi9Nrq470T8D3f4vSUpe0ePrmdGveXv/6u5b2gGLdvZyOcFK7Tu
         qq3b8vmMX99zoGDoig0yh0g2uSTfVtsOTD9lWwXo0ABUOhrFZrO1wQGRIPrabmRGLj4y
         1QIgEBDKvEPCKnKQsZZoMI06FHXBX4uxj2ze39jT/8Y/HxutGn1tGK5k3Df3xEWn8o93
         gx498WXE6qpyF7g0Gpe4/eccTC99bLIGZI5Pi8sRa2jvOumy2H+X46p22d88/KZsfecR
         158A==
X-Gm-Message-State: AOJu0YyNitwhGRG9dmnzt0LBRIxQjb0Z7PtfSoD0jBOBkFxI1mRMI4gU
        FPmU8apSjhCqeFm5iueYIOrSZA==
X-Google-Smtp-Source: AGHT+IF5mj6CqUUVIWOYpJZkiR0PfqRBvcfVsy6nzRFSq/akc1Lk4stw6BD+EnUfeCleyyR0MIOHyg==
X-Received: by 2002:a2e:b60e:0:b0:2bc:d3a8:974a with SMTP id r14-20020a2eb60e000000b002bcd3a8974amr1259289ljn.24.1693384463909;
        Wed, 30 Aug 2023 01:34:23 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003fee65091fdsm1505056wmr.40.2023.08.30.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:34:23 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:34:18 +0200
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
Subject: Re: [PATCH 06/15] stackdepot: fix and clean-up atomic annotations
Message-ID: <ZO7/CqwhzqulWP7K@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <8ad8f778b43dab49e4e6214b8d90bed31b75436f.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad8f778b43dab49e4e6214b8d90bed31b75436f.1693328501.git.andreyknvl@google.com>
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
> Simplify comments accompanying the use of atomic accesses in the
> stack depot code.
> 
> Also turn smp_load_acquire from next_pool_required in depot_init_pool
> into READ_ONCE, as both depot_init_pool and the all smp_store_release's
> to this variable are executed under the stack depot lock.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> This patch is not strictly required, as the atomic accesses are fully
> removed in one of the latter patches. However, I decided to keep the
> patch just in case we end up needing these atomics in the following
> iterations of this series.
> ---
>  lib/stackdepot.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 93191ee70fc3..9ae71e1ef1a7 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -226,10 +226,10 @@ static void depot_init_pool(void **prealloc)
>  	/*
>  	 * If the next pool is already initialized or the maximum number of
>  	 * pools is reached, do not use the preallocated memory.
> -	 * smp_load_acquire() here pairs with smp_store_release() below and
> -	 * in depot_alloc_stack().
> +	 * READ_ONCE is only used to mark the variable as atomic,
> +	 * there are no concurrent writes.

This doesn't make sense. If there are no concurrent writes, we should
drop the marking, so that if there are concurrent writes, tools like
KCSAN can tell us about it if our assumption was wrong.

>  	 */
> -	if (!smp_load_acquire(&next_pool_required))
> +	if (!READ_ONCE(next_pool_required))
>  		return;
>  
>  	/* Check if the current pool is not yet allocated. */
> @@ -250,8 +250,8 @@ static void depot_init_pool(void **prealloc)
>  		 * At this point, either the next pool is initialized or the
>  		 * maximum number of pools is reached. In either case, take
>  		 * note that initializing another pool is not required.
> -		 * This smp_store_release pairs with smp_load_acquire() above
> -		 * and in stack_depot_save().
> +		 * smp_store_release pairs with smp_load_acquire in
> +		 * stack_depot_save.
>  		 */
>  		smp_store_release(&next_pool_required, 0);
>  	}
> @@ -275,15 +275,15 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  		/*
>  		 * Move on to the next pool.
>  		 * WRITE_ONCE pairs with potential concurrent read in
> -		 * stack_depot_fetch().
> +		 * stack_depot_fetch.
>  		 */
>  		WRITE_ONCE(pool_index, pool_index + 1);
>  		pool_offset = 0;
>  		/*
>  		 * If the maximum number of pools is not reached, take note
>  		 * that the next pool needs to initialized.
> -		 * smp_store_release() here pairs with smp_load_acquire() in
> -		 * stack_depot_save() and depot_init_pool().
> +		 * smp_store_release pairs with smp_load_acquire in
> +		 * stack_depot_save.
>  		 */
>  		if (pool_index + 1 < DEPOT_MAX_POOLS)
>  			smp_store_release(&next_pool_required, 1);
> @@ -414,8 +414,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  
>  	/*
>  	 * Fast path: look the stack trace up without locking.
> -	 * The smp_load_acquire() here pairs with smp_store_release() to
> -	 * |bucket| below.
> +	 * smp_load_acquire pairs with smp_store_release to |bucket| below.
>  	 */
>  	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
>  	if (found)
> @@ -425,8 +424,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	 * Check if another stack pool needs to be initialized. If so, allocate
>  	 * the memory now - we won't be able to do that under the lock.
>  	 *
> -	 * The smp_load_acquire() here pairs with smp_store_release() to
> -	 * |next_pool_inited| in depot_alloc_stack() and depot_init_pool().
> +	 * smp_load_acquire pairs with smp_store_release
> +	 * in depot_alloc_stack and depot_init_pool.

Reflow comment to match 80 cols used by comments elsewhere.

>  	 */
>  	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
>  		/*
> @@ -452,8 +451,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  		if (new) {
>  			new->next = *bucket;
>  			/*
> -			 * This smp_store_release() pairs with
> -			 * smp_load_acquire() from |bucket| above.
> +			 * smp_store_release pairs with smp_load_acquire
> +			 * from |bucket| above.
>  			 */
>  			smp_store_release(bucket, new);
>  			found = new;
> -- 
> 2.25.1
> 
