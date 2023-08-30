Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD878DF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbjH3TWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbjH3JiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:38:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D67137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:38:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d67434daso15764935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693388294; x=1693993094; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7w982v/e1jzg2/UemZ2RnWkspcdmAHHRTHnHv5ffU8=;
        b=TJnldFgh6WMQBB2ZnNUL+hwygTKI17JjQUw6UdkiOa/2fLxwzaCHvw57ee/r/WM4+F
         KVfZjvh1OnicJ3NKmk+96jjFhtb8w7JMcXCq1rGW76kpuUORWxz74AncFtzmQh43RSOs
         N9nL3+Mr2/KVxNJBqoB8AwcqgHguF8ARJdftlTwxYeYF/FbCvCLUO0lItnw1CTd3AVTk
         vK5QsAev5o8BV/WWB/1dbNMPEbUVZCbmRk3A8gvC9jtYnRTFxOYIaVndsRzITb7tIwhk
         jelwlOk8NMcorL4T2dmYCPyaUuZTxcRmNBcsDD7/a6M0HOLemd3Yqy/eU6uq9kxkDupg
         Qsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693388294; x=1693993094;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7w982v/e1jzg2/UemZ2RnWkspcdmAHHRTHnHv5ffU8=;
        b=fViT2jljFV5OCOzyvxWVP09vl2waeU2CaJ/76XweJJ97L5GaT+CEf3oBZ7CkJCK/4Y
         bGdoHn3Mf31p++bLNcGRWH+YuuYKrLWi6Evkyi/KEVar0bKWTV6UMEXQthlz6GP4TIS3
         hOm5ypv0UTp+NzEGHHbdeeg8QnCZ6XwrcYPEwcLze4TM/0y/HlNEGVn/dbdvArpke+Rz
         Mw/KcKdTvjmc/ufPx3NJ7PK4A0arWXQNT8FNrPcpQqRVVK7Gv9JBJO7AxB1zNfA0XPCO
         tGGZ+ZMIfBpTCneyFs5Cf+2iR22npAaUhW+PqQEq7D5JrJcR53n47bQE6OzNh8T83czX
         WB3g==
X-Gm-Message-State: AOJu0YxaDATAqoOuCkudAx6PEy7mxPNZQ+0w78KAGdB2DI7S/+KVI4nH
        AdNsNfeebcpnfFNmgzxOSaVfxg==
X-Google-Smtp-Source: AGHT+IH7T4lA8VKDVfX4ZbWxQucDyzEIV4N2/dAMItsXboYSXdL36/SsL46Qx29abbIde5hUVuPovg==
X-Received: by 2002:a7b:c8c3:0:b0:3fe:d71a:d84e with SMTP id f3-20020a7bc8c3000000b003fed71ad84emr1520377wml.1.1693388293802;
        Wed, 30 Aug 2023 02:38:13 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d46cf000000b0031762e89f94sm16003691wrs.117.2023.08.30.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:38:13 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:38:08 +0200
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
Subject: Re: [PATCH 15/15] kasan: use stack_depot_evict for tag-based modes
Message-ID: <ZO8OACjoGtRuy1Rm@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
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
> Evict stack traces from the stack depot for the tag-based KASAN modes
> once they are evicted from the stack ring.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/tags.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 7dcfe341d48e..fa6b0f77a7dd 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -96,7 +96,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>  			gfp_t gfp_flags, bool is_free)
>  {
>  	unsigned long flags;
> -	depot_stack_handle_t stack;
> +	depot_stack_handle_t stack, old_stack;
>  	u64 pos;
>  	struct kasan_stack_ring_entry *entry;
>  	void *old_ptr;
> @@ -120,6 +120,8 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>  	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
>  		goto next; /* Busy slot. */
>  
> +	old_stack = READ_ONCE(entry->stack);

Why READ_ONCE? Is it possible that there is a concurrent writer once the
slot has been "locked" with STACK_RING_BUSY_PTR?

If there is no concurrency, it would be clearer to leave it unmarked and
add a comment to that effect. (I also think a comment would be good to
say what the WRITE_ONCE below pair with, because at this point I've
forgotten.)

>  	WRITE_ONCE(entry->size, cache->object_size);
>  	WRITE_ONCE(entry->pid, current->pid);
>  	WRITE_ONCE(entry->stack, stack);
> @@ -131,6 +133,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>  	smp_store_release(&entry->ptr, (s64)object);
>  
>  	read_unlock_irqrestore(&stack_ring.lock, flags);
> +
> +	if (old_stack)
> +		stack_depot_evict(old_stack);
>  }
>  
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> -- 
> 2.25.1
> 
