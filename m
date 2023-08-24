Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E251C786781
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbjHXG3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbjHXG3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:29:09 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB981735
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:28:46 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-34baf19955cso20985115ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858526; x=1693463326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KoOHMSDlEnpGFHlNiaW0IwLUMumyRYSBQp0VuouMWQ=;
        b=cRC2goC0rgzAzcef3msJEp2UAOLhHbV3SSdZGDct0sbzRndk2ddGfmOENFY3AFg77d
         X7kTIMoJ6zLVU6mJjyMAnMo4JjyHRV8bTt9YzBsAAR07WTJzhsul5jYI2+ff11N1NpDP
         iGEBkd3E//i8NdZrQJilsgLVfsSjOwcugNYSh3FtY++4fy+yU+4iX7bHAra0jUuBZ2kL
         /7xrbHBYDeYf/z+eG+Lh7EYzrSYtoCAHrGBYDod4ZzqJKYbuzjflfWKc72D/xxJisCrz
         GvOft+KMEBwvWUZwvYQ0ChAAHe3qqBF8pWWAJoQE3hFHbfFswi+K9FCsm6ZZjmplpcqV
         qmEA==
X-Gm-Message-State: AOJu0YxoE4q3XWg/AOrLrhp/KV6+DTtpqaVWK7frokLfQ6vU4YE4I5qj
        Th4qgllylXXeXGyb5X7HHuLncSyjfTo=
X-Google-Smtp-Source: AGHT+IHQJBEXv4D2EaFHKC6j5lUD5/R+FKr5LMXLQOdMiAQKonT3YVOJ3rjvYfsZqzNotzdnXLPypw==
X-Received: by 2002:a05:6e02:104b:b0:34c:a7e2:c9a6 with SMTP id p11-20020a056e02104b00b0034ca7e2c9a6mr4191882ilj.31.1692858525811;
        Wed, 23 Aug 2023 23:28:45 -0700 (PDT)
Received: from snowbird (c-73-228-235-230.hsd1.mn.comcast.net. [73.228.235.230])
        by smtp.gmail.com with ESMTPSA id t17-20020a05663801f100b0042b2959e6dcsm4299317jaq.87.2023.08.23.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 23:28:45 -0700 (PDT)
Date:   Wed, 23 Aug 2023 23:28:43 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] kernel/fork: group allocation/free of per-cpu
 counters for mm struct
Message-ID: <ZOb4m4hCR0MbCqGd@snowbird>
References: <20230823050609.2228718-1-mjguzik@gmail.com>
 <20230823050609.2228718-3-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823050609.2228718-3-mjguzik@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 07:06:09AM +0200, Mateusz Guzik wrote:
> A trivial execve scalability test which tries to be very friendly
> (statically linked binaries, all separate) is predominantly bottlenecked
> by back-to-back per-cpu counter allocations which serialize on global
> locks.
> 
> Ease the pain by allocating and freeing them in one go.
> 
> Bench can be found here:
> http://apollo.backplane.com/DFlyMisc/doexec.c
> 
> $ cc -static -O2 -o static-doexec doexec.c
> $ ./static-doexec $(nproc)
> 
> Even at a very modest scale of 26 cores (ops/s):
> before:	133543.63
> after:	186061.81 (+39%)
> 
> While with the patch these allocations remain a significant problem,
> the primary bottleneck shifts to page release handling.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Same message as for 1/2. I'm happy with this, just a minor reflow. I'll
take this for-6.6 unless there are other comments / objections to that.

I'll run a few tests myself too tomorrow just for validation.

Reviewed-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

> ---
>  kernel/fork.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b18..4f0ada33457e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -909,8 +909,6 @@ static void cleanup_lazy_tlbs(struct mm_struct *mm)
>   */
>  void __mmdrop(struct mm_struct *mm)
>  {
> -	int i;
> -
>  	BUG_ON(mm == &init_mm);
>  	WARN_ON_ONCE(mm == current->mm);
>  
> @@ -925,9 +923,8 @@ void __mmdrop(struct mm_struct *mm)
>  	put_user_ns(mm->user_ns);
>  	mm_pasid_drop(mm);
>  	mm_destroy_cid(mm);
> +	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>  
> -	for (i = 0; i < NR_MM_COUNTERS; i++)
> -		percpu_counter_destroy(&mm->rss_stat[i]);
>  	free_mm(mm);
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1252,8 +1249,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	struct user_namespace *user_ns)
>  {
> -	int i;
> -
>  	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
>  	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
>  	atomic_set(&mm->mm_users, 1);
> @@ -1301,17 +1296,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	if (mm_alloc_cid(mm))
>  		goto fail_cid;
>  
> -	for (i = 0; i < NR_MM_COUNTERS; i++)
> -		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
> -			goto fail_pcpu;
> +	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT, NR_MM_COUNTERS))
> +		goto fail_pcpu;
>  
>  	mm->user_ns = get_user_ns(user_ns);
>  	lru_gen_init_mm(mm);
>  	return mm;
>  
>  fail_pcpu:
> -	while (i > 0)
> -		percpu_counter_destroy(&mm->rss_stat[--i]);
>  	mm_destroy_cid(mm);
>  fail_cid:
>  	destroy_context(mm);
> -- 
> 2.41.0
> 
