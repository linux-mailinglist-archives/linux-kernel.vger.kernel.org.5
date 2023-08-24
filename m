Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFB78677B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbjHXG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbjHXG1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:27:05 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675710F5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:27:02 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77acb04309dso227555939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858422; x=1693463222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaYFol9VpMoa7wRnrH7aK64tMzJrKbUDz5W/yZnlsfE=;
        b=QkNtc0Lf/vgxpImAhXXPXT1HSid+hEf74dT1c9/0BX6jblZmyymn6B+/vj1FUrGblT
         /Z30omY0Y480irCdYdTqq3OjAcCzG6Znn1sFRfW446C66dozaZaVnfDGVabqPd02Khp7
         VLo6I14L/FZTXZRiltHPF7De/F6YoaO3+ouJLUqbertIIhy3pq9ErsFb29XcrqQP/Ht7
         cBAxi30WeSRS7uy/D1RJ8OQSz/co5ytrt4RlzPxF/Z+G2aXyAIvwBJoHz9F1CpDLSGzO
         Z30mjYMjJ9/WFDIZhHxmj/EA8q9ZPBUtzQJhxnhsLPsAPqVwt3jdRh02zTcjdq5quBoo
         q/UA==
X-Gm-Message-State: AOJu0YxtHVpQktK1ZAGL1/WY/IRWMhe3lH8D4Jhe4YseLq4hZk0ri2uI
        jBGXoXCx41uGkLFjMkmkzZA=
X-Google-Smtp-Source: AGHT+IFh2m58yqt3RSg/o96un1ggqGI1jq8zQZvoCW3XNg5TdHmiYRDBByWAUNMdKvoLsoI8mKKFwA==
X-Received: by 2002:a5d:930c:0:b0:786:f352:e3d4 with SMTP id l12-20020a5d930c000000b00786f352e3d4mr5539601ion.7.1692858421804;
        Wed, 23 Aug 2023 23:27:01 -0700 (PDT)
Received: from snowbird (c-73-228-235-230.hsd1.mn.comcast.net. [73.228.235.230])
        by smtp.gmail.com with ESMTPSA id l17-20020a5e8811000000b007871aa2f144sm3559487ioj.16.2023.08.23.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 23:27:01 -0700 (PDT)
Date:   Wed, 23 Aug 2023 23:26:59 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] pcpcntr: add group allocation/free
Message-ID: <ZOb4Mwv5eFv2n7R8@snowbird>
References: <20230823050609.2228718-1-mjguzik@gmail.com>
 <20230823050609.2228718-2-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823050609.2228718-2-mjguzik@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 07:06:08AM +0200, Mateusz Guzik wrote:
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

I'm happy with this. There are a few minor reflow of lines that I'd like
to do but other than that nice.

If there are no other comments and it's okay with Andrew I'll pick this
up tomorrow for-6.6 and the corresponding changes to fork.c.

Reviewed-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

> ---
>  include/linux/percpu_counter.h | 39 ++++++++++++++++++----
>  lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
>  2 files changed, 74 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 75b73c83bc9d..f1e7c987e3d3 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -30,17 +30,27 @@ struct percpu_counter {
>  
>  extern int percpu_counter_batch;
>  
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key);
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  u32 nr_counters, struct lock_class_key *key);
>  
> -#define percpu_counter_init(fbc, value, gfp)				\
> +#define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
>  	({								\
>  		static struct lock_class_key __key;			\
>  									\
> -		__percpu_counter_init(fbc, value, gfp, &__key);		\
> +		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
> +					   &__key);			\
>  	})
>  
> -void percpu_counter_destroy(struct percpu_counter *fbc);
> +
> +#define percpu_counter_init(fbc, value, gfp)				\
> +	percpu_counter_init_many(fbc, value, gfp, 1)
> +
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters);
> +static inline void percpu_counter_destroy(struct percpu_counter *fbc)
> +{
> +	percpu_counter_destroy_many(fbc, 1);
> +}
> +
>  void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>  			      s32 batch);
> @@ -116,11 +126,26 @@ struct percpu_counter {
>  	s64 count;
>  };
>  
> +static inline int percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
> +				           gfp_t gfp, u32 nr_counters)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < nr_counters; i++)
> +		fbc[i].count = amount;
> +
> +	return 0;
> +}
> +
>  static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
>  				      gfp_t gfp)
>  {
> -	fbc->count = amount;
> -	return 0;
> +	return percpu_counter_init_many(fbc, amount, gfp, 1);
> +}
> +
> +static inline void percpu_counter_destroy_many(struct percpu_counter *fbc,
> +					       u32 nr_counters)
> +{
>  }
>  
>  static inline void percpu_counter_destroy(struct percpu_counter *fbc)
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..9338b27f1cdd 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -151,48 +151,71 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  }
>  EXPORT_SYMBOL(__percpu_counter_sum);
>  
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key)
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  u32 nr_counters, struct lock_class_key *key)
>  {
>  	unsigned long flags __maybe_unused;
> -
> -	raw_spin_lock_init(&fbc->lock);
> -	lockdep_set_class(&fbc->lock, key);
> -	fbc->count = amount;
> -	fbc->counters = alloc_percpu_gfp(s32, gfp);
> -	if (!fbc->counters)
> +	size_t counter_size;
> +	s32 __percpu *counters;
> +	u32 i;
> +
> +	counter_size = ALIGN(sizeof(*counters), __alignof__(*counters));
> +	counters = __alloc_percpu_gfp(nr_counters * counter_size,
> +				      __alignof__(*counters), gfp);
> +	if (!counters) {
> +		fbc[0].counters = NULL;
>  		return -ENOMEM;
> +	}
>  
> -	debug_percpu_counter_activate(fbc);
> +	for (i = 0; i < nr_counters; i++) {
> +		raw_spin_lock_init(&fbc[i].lock);
> +		lockdep_set_class(&fbc[i].lock, key);
> +#ifdef CONFIG_HOTPLUG_CPU
> +		INIT_LIST_HEAD(&fbc[i].list);
> +#endif
> +		fbc[i].count = amount;
> +		fbc[i].counters = (void *)counters + (i * counter_size);
> +
> +		debug_percpu_counter_activate(&fbc[i]);
> +	}
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -	INIT_LIST_HEAD(&fbc->list);
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_add(&fbc->list, &percpu_counters);
> +	for (i = 0; i < nr_counters; i++)
> +		list_add(&fbc[i].list, &percpu_counters);
>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	return 0;
>  }
> -EXPORT_SYMBOL(__percpu_counter_init);
> +EXPORT_SYMBOL(__percpu_counter_init_many);
>  
> -void percpu_counter_destroy(struct percpu_counter *fbc)
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters)
>  {
>  	unsigned long flags __maybe_unused;
> +	u32 i;
> +
> +	if (WARN_ON_ONCE(!fbc))
> +		return;
>  
> -	if (!fbc->counters)
> +	if (!fbc[0].counters)
>  		return;
>  
> -	debug_percpu_counter_deactivate(fbc);
> +	for (i = 0; i < nr_counters; i++)
> +		debug_percpu_counter_deactivate(&fbc[i]);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_del(&fbc->list);
> +	for (i = 0; i < nr_counters; i++)
> +		list_del(&fbc[i].list);
>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
> -	free_percpu(fbc->counters);
> -	fbc->counters = NULL;
> +
> +	free_percpu(fbc[0].counters);
> +
> +	for (i = 0; i < nr_counters; i++)
> +		fbc[i].counters = NULL;
>  }
> -EXPORT_SYMBOL(percpu_counter_destroy);
> +EXPORT_SYMBOL(percpu_counter_destroy_many);
>  
>  int percpu_counter_batch __read_mostly = 32;
>  EXPORT_SYMBOL(percpu_counter_batch);
> -- 
> 2.41.0
> 
