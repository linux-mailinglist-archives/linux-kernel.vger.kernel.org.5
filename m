Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676478E051
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbjH3TKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbjH3JUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:20:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3919A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:20:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c3726cc45so4617384f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693387210; x=1693992010; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3mfR1VNhnX8t7/rO2iFNZaVWO0Cq4zowvDh6il0OaE=;
        b=5BHPZwEwTOv/VSGVEEMb5jlEnE09gSvp5WhTQpwVY7WGcYnzH9IcRjNj7U1dKrfk9/
         7WlyCexQuYmyunMMWxJIt/SjN7DKw5yt/4jKEjLgXknhNX3rHgsT3LsKSLd9XYivRK9V
         3QglMloIpO23hg69LEPgUwlG7+IX4DxtF9wPtb535egKyF0v3Uz7+aI5CCih1kLgmiwX
         8je/VGcVTJa4r+h98hUu57qSyjtxu2m6bkKk7QAw3D9UglPfnGukiD8//Tis7RcyqsaE
         7xlzxj9eMm+WGYRmypT/+puToT2MlHvH2+p2hHDhP6u1q3jzpwHxCPoDN5TkzZ6CpxLP
         bDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387210; x=1693992010;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3mfR1VNhnX8t7/rO2iFNZaVWO0Cq4zowvDh6il0OaE=;
        b=KH6XAlyn6ixj1nYSwMkIM+JqbzQz9PbWh2K6tVZEGbJBrixyvdONX0fnVx2AuTcmrj
         0ruRlT3hFSeuq9skIJLrvjVGSuBjxCLKzG3qhALnNkNuQgJNRGwHqomkONkp1PxaCMYZ
         OM30DhhReCBG/pW+Mf4ytqwFs+oMb5ZW+MrfwOCCVu9HtiNCESM6aGwvYfoAVEp7EbBh
         rdHKLLeAG521xvfOxHOSVrWd5k7XjWb+ZPmo43i+Oj7cpm4wbXCY7oX3FHhVriGYstaA
         Wy6vGZBTIqx4vYqU2yP7mPTZ/QxXnTxcN7vI1t2VLaaD/FHpyc/kKoeiPZd+Wmgetwmw
         j7Zg==
X-Gm-Message-State: AOJu0Ywz9Z7b9lGIRiWoTHoHFWTtFQtX/VmUyme5PjjadkRr5m1BCebx
        r2VCLSKVX7klXH+X00sWnsTrUw==
X-Google-Smtp-Source: AGHT+IEr3qJVf+Evdd0/8WrCb5RUc45X401I+nSpQJmzHBkwBH8GGI1/nZ4ZYAnqd1H3u+GWVTwhEA==
X-Received: by 2002:a5d:4049:0:b0:313:f45f:74a1 with SMTP id w9-20020a5d4049000000b00313f45f74a1mr1221197wrp.51.1693387209795;
        Wed, 30 Aug 2023 02:20:09 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d4b4c000000b0031416362e23sm16155248wrs.3.2023.08.30.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:20:09 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:20:03 +0200
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
Subject: Re: [PATCH 14/15] stackdepot: allow users to evict stack traces
Message-ID: <ZO8Jwy5SAgkrQ5Qz@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <99cd7ac4a312e86c768b933332364272b9e3fb40.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cd7ac4a312e86c768b933332364272b9e3fb40.1693328501.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Add stack_depot_evict, a function that decrements a reference counter
> on a stack record and removes it from the stack depot once the counter
> reaches 0.
> 
> Internally, when removing a stack record, the function unlinks it from
> the hash table bucket and returns to the freelist.
> 
> With this change, the users of stack depot can call stack_depot_evict
> when keeping a stack trace in the stack depot is not needed anymore.
> This allows avoiding polluting the stack depot with irrelevant stack
> traces and thus have more space to store the relevant ones before the
> stack depot reaches its capacity.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/stackdepot.h | 11 ++++++++++
>  lib/stackdepot.c           | 43 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index e58306783d8e..b14da6797714 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -121,6 +121,17 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries);
>  
> +/**
> + * stack_depot_evict - Drop a reference to a stack trace from stack depot
> + *
> + * @handle:	Stack depot handle returned from stack_depot_save()
> + *
> + * The stack trace gets fully removed from stack depot once all references

"gets fully removed" -> "is evicted" ?

> + * to it has been dropped (once the number of stack_depot_evict calls matches

"has been" -> "have been"

> + * the number of stack_depot_save calls for this stack trace).
> + */
> +void stack_depot_evict(depot_stack_handle_t handle);
> +
>  /**
>   * stack_depot_print - Print a stack trace from stack depot
>   *
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 641db97d8c7c..cf28720b842d 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -384,6 +384,13 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
>  	return stack;
>  }
>  
> +/* Frees stack into the freelist. */
> +static void depot_free_stack(struct stack_record *stack)
> +{
> +	stack->next = next_stack;
> +	next_stack = stack;
> +}
> +
>  /* Calculates the hash for a stack. */
>  static inline u32 hash_stack(unsigned long *entries, unsigned int size)
>  {
> @@ -555,6 +562,42 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_fetch);
>  
> +void stack_depot_evict(depot_stack_handle_t handle)
> +{
> +	struct stack_record *stack, **bucket;
> +	unsigned long flags;
> +
> +	if (!handle || stack_depot_disabled)
> +		return;
> +
> +	write_lock_irqsave(&pool_rwlock, flags);
> +
> +	stack = depot_fetch_stack(handle);
> +	if (WARN_ON(!stack))
> +		goto out;
> +
> +	if (refcount_dec_and_test(&stack->count)) {
> +		/* Drop stack from the hash table. */
> +		if (stack->next)
> +			stack->next->prev = stack->prev;
> +		if (stack->prev)
> +			stack->prev->next = stack->next;
> +		else {
> +			bucket = &stack_table[stack->hash & stack_hash_mask];
> +			*bucket = stack->next;
> +		}
> +		stack->next = NULL;
> +		stack->prev = NULL;
> +
> +		/* Free stack. */
> +		depot_free_stack(stack);
> +	}
> +
> +out:
> +	write_unlock_irqrestore(&pool_rwlock, flags);
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_evict);
> +
>  void stack_depot_print(depot_stack_handle_t stack)
>  {
>  	unsigned long *entries;
> -- 
> 2.25.1
> 
