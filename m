Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A55784823
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjHVRCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjHVRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:02:24 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F5FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:02:22 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68a41031768so1618277b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692723742; x=1693328542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4sVlQQACP9KfO4dkY6wxP9XqMwO3mckdV+5TyWvLmA=;
        b=egia98hf0OolyM8oWh+QOYrV/QzDXGlIjPrW29cgN1hZv1dGdF7WFIqebsZb7lPqEK
         /CxOlWG1vBAnh8mbeQThU1bn6Ycho+QwDxx1KJMNBpBEHx6UAGoxDORMZumnJe+fexT5
         p9ABBXtmqG3BiTfxHDTTXDgejAIiuIxDFHBjQy4laeo3Nzd3hKOnifC5O/FniYP/C2QY
         nbw6DEdcX/zvt5hPJV/AJS4SOPY0I9Crd4NNQoKxDOKmfT4NinoZsqapAr02II2RUqkZ
         C99AhV6ox7v6AOCO0JVZbMym3Vf5l1wxdNKhv3vYQx6dONEcsaW2NBR3dUpLeH8kxLCN
         5bjg==
X-Gm-Message-State: AOJu0Ywx/iaBk3EMo3VQtQhe07nrVJCCehTUzSK1BSacIMB34Sg7eOhx
        0ks3PVSXlHNilJshvMFf1S8=
X-Google-Smtp-Source: AGHT+IF34UVPbfUAWwyA5LVhkb7wEW66G0fsDOo/mn220q8082TYndkx8753uBbmEvMqwqiEY2tOSg==
X-Received: by 2002:a05:6a20:4310:b0:149:2149:9491 with SMTP id h16-20020a056a20431000b0014921499491mr6131522pzk.43.1692723742138;
        Tue, 22 Aug 2023 10:02:22 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b006875a366acfsm4199880pfn.8.2023.08.22.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:02:21 -0700 (PDT)
Date:   Tue, 22 Aug 2023 10:02:19 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] pcpcntr: add group allocation/free
Message-ID: <ZOTqGwXoberbR9/5@snowbird>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <20230821202829.2163744-2-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202829.2163744-2-mjguzik@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On Mon, Aug 21, 2023 at 10:28:28PM +0200, Mateusz Guzik wrote:
> Allocations and frees are globally serialized on the pcpu lock (and the
> CPU hotplug lock if enabled, which is the case on Debian).
> 
> At least one frequent consumer allocates 4 back-to-back counters (and
> frees them in the same manner), exacerbating the problem.
> 
> While this does not fully remedy scalability issues, it is a step
> towards that goal and provides immediate relief.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

As I mentioned yesterday, I like this approach because instead of making
percpu smarter, we're batching against the higher level inits which I'm
assuming will have additional synchronization requirements.

Below is mostly style changes to conform and a few nits wrt naming.

> ---
>  include/linux/percpu_counter.h | 19 ++++++++---
>  lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
>  2 files changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 75b73c83bc9d..ff5850b07124 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -30,17 +30,26 @@ struct percpu_counter {
>  
>  extern int percpu_counter_batch;
>  
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key);
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  struct lock_class_key *key, u32 count);

1. Can we move count to before the lock_class_key?
2. count is an overloaded term between percpu_counters and
percpu_refcount. Maybe `nr` or `nr_counters` is better?

>  
> -#define percpu_counter_init(fbc, value, gfp)				\
> +#define percpu_counter_init_many(fbc, value, gfp, count)		\
>  	({								\
>  		static struct lock_class_key __key;			\
>  									\
> -		__percpu_counter_init(fbc, value, gfp, &__key);		\
> +		__percpu_counter_init_many(fbc, value, gfp, &__key, count);\
>  	})
>  
> -void percpu_counter_destroy(struct percpu_counter *fbc);
> +
> +#define percpu_counter_init(fbc, value, gfp)				\
> +	percpu_counter_init_many(fbc, value, gfp, 1)
> +
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count);
> +static inline void percpu_counter_destroy(struct percpu_counter *fbc)
> +{
> +	percpu_counter_destroy_many(fbc, 1);
> +}
> +
>  void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>  			      s32 batch);
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..2a33cf23df55 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -151,48 +151,73 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  }
>  EXPORT_SYMBOL(__percpu_counter_sum);
>  
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key)
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  struct lock_class_key *key, u32 count)
>  {
>  	unsigned long flags __maybe_unused;
> +	s32 __percpu *counters;
> +	u32 i;
>  
> -	raw_spin_lock_init(&fbc->lock);
> -	lockdep_set_class(&fbc->lock, key);
> -	fbc->count = amount;
> -	fbc->counters = alloc_percpu_gfp(s32, gfp);
> -	if (!fbc->counters)
> +	counters = __alloc_percpu_gfp(sizeof(*counters) * count,
> +				      sizeof(*counters), gfp);


So while a bit moot, I think it'd be nice to clarify what we should do
here wrt alignment and batch allocation. There has been a case in the
past where alignment > size.

This is from my batch api implementation:
+       /*
+        * When allocating a batch we need to align the size so that each
+        * element in the batch will have the appropriate alignment.
+        */
+       size = ALIGN(size, align);

So I think some variation of:
    element_size = ALIGN(sizeof(*counters, __alignof__(*counters)));
    counters = __alloc_percpu_gfp(nr * element_size, __alignof__(*counters), gfp);

While this isn't necessary here for s32's, I think it would be nice to
just set the precedent so we preserve alignment asks for future users if
they use this as a template.

> +	if (!counters) {
> +		fbc[0].counters = NULL;
>  		return -ENOMEM;
> +	}
>  
> -	debug_percpu_counter_activate(fbc);
> +	for (i = 0; i < count; i++) {
> +		raw_spin_lock_init(&fbc[i].lock);
> +		lockdep_set_class(&fbc[i].lock, key);
> +#ifdef CONFIG_HOTPLUG_CPU
> +		INIT_LIST_HEAD(&fbc[i].list);
> +#endif
> +		fbc[i].count = amount;
> +		fbc[i].counters = &counters[i];

This would have to become some (void *) math tho with element_size.

> +
> +		debug_percpu_counter_activate(&fbc[i]);
> +	}
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -	INIT_LIST_HEAD(&fbc->list);
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_add(&fbc->list, &percpu_counters);
> +	for (i = 0; i < count; i++) {
> +		list_add(&fbc[i].list, &percpu_counters);
> +	}

nit: we don't add {} for single line loops.

>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	return 0;
>  }
> -EXPORT_SYMBOL(__percpu_counter_init);
> +EXPORT_SYMBOL(__percpu_counter_init_many);
>  
> -void percpu_counter_destroy(struct percpu_counter *fbc)
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count)
>  {
>  	unsigned long flags __maybe_unused;
> +	u32 i;
>  
> -	if (!fbc->counters)
> +	if (WARN_ON_ONCE(!fbc))
>  		return;
>  
> -	debug_percpu_counter_deactivate(fbc);
> +	if (!fbc[0].counters)
> +		return;
> +
> +	for (i = 0; i < count; i++) {
> +		debug_percpu_counter_deactivate(&fbc[i]);
> +	}
>  

nit: no {}.

>  #ifdef CONFIG_HOTPLUG_CPU
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_del(&fbc->list);
> +	for (i = 0; i < count; i++) {
> +		list_del(&fbc[i].list);
> +	}

nit: no {}.

>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
> -	free_percpu(fbc->counters);
> -	fbc->counters = NULL;
> +
> +	free_percpu(fbc[0].counters);
> +
> +	for (i = 0; i < count; i++) {
> +		fbc[i].counters = NULL;
> +	}

nit: no {}.

>  }
> -EXPORT_SYMBOL(percpu_counter_destroy);
> +EXPORT_SYMBOL(percpu_counter_destroy_many);
>  
>  int percpu_counter_batch __read_mostly = 32;
>  EXPORT_SYMBOL(percpu_counter_batch);
> -- 
> 2.39.2
> 

Thanks,
Dennis
