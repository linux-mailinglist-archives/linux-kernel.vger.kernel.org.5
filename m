Return-Path: <linux-kernel+bounces-53816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06E84A6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3081E1C269A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967985A79B;
	Mon,  5 Feb 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRk7HDCs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8E5A796
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161034; cv=none; b=bWoBGfOlYySZM/veErRf4QSqb1wpFzG4D1Aibntv7LW6jfhmhNSLUPQtvHT0cz8W2BgAxd4qUxm/GxV00L6trH6S/XJ2HCZAbf3eps3XpBDV6sY7nM3R6A9jkZGSQm1DaK4it4HcbQPY1YUto43OsSDx2sWNAC3UZlCsh85S7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161034; c=relaxed/simple;
	bh=Pp/VE6IxdDLOKt+U/z52MStGw+89Y1Ok6vIYZffa1zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjySBKfYc0TREgfTmOb1ZOyhFpCz5ODEdvcRcLM9vHuOfilmsKH+hj5YNpUKyfI08zt8ZfwSQmV0e9yNskmhPf88NLRNwbMEJSaLyM9aw13ig/ryzfOeG9Jzv0q61Ub598Gxp6DNL3fvzMbDScrXUKUl/uOHX8ozBW8JycZJq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRk7HDCs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d93f2c3701so24779405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707161032; x=1707765832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaRfm38gHSDEMHQzmeyu0uP0yZtmTJUaE9bRLsDS+Fw=;
        b=eRk7HDCspGCytverKaSjnSAIkQtxrqnLBJ7hbPGqrFoz32yxuZa1GFoZB2jnfCjwDO
         DG6AsZofWr0BjO5O1TX0f773bsMOKC4BM8WCohOHZ5LmfkcDnww/YywCP5+hLnI3g05I
         WLT9Qc6Cypqx69NH5LPDd9c1/xpXqqg1fzYZ4XGlSfI/Q8tCGLGlY0ToweG789tGvpkc
         0oSN4vnYv43xqxbP2pdkzlfvmwx2EdsB3pFcAUZecS3imt7p4OWEwUq+55r5ysH5ygEY
         dbDkry7wn//hyzH/WZGedV6qGsmLC58FY1yC5ExC++A5VdO9fBNvXiTBWzPgijGXM8UL
         Irow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161032; x=1707765832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaRfm38gHSDEMHQzmeyu0uP0yZtmTJUaE9bRLsDS+Fw=;
        b=DFvqdlFPAQ4Cghightuejc99mo5ThM13VIOAcNc/qXWoCXpRaqlre2qnw1HLlye78L
         2m7lupPb6Yk+8plLtlZ8MVxlHRluTjmu3LyyqvDZw+OlDiMknUzs27bNqglgrsp76gWg
         dDo6CxINg6S0YKgyOpNxhHQC2cQ32Aw5KzTVUm1PbkFYZ99ke81yAKlYDdGqKxHg3uFS
         xcaILVMyOVnNOqkSmAbmBiHD9y9ymT16q10eZU36cskjwGTK8SC54vCLgGmYMrSCxvkN
         xZTMfQF35Hx+uQ/OhnUBpsDLqjsU45MZ8SQNP23eAbx1zowUpq4ZNIxbal0OIoaYdhVs
         njbQ==
X-Gm-Message-State: AOJu0YxrzFi5w4ogno9AzswgUk3GAmzrdxLqfcmKf74+gTgHxdFzcOvV
	8ZGDf70Cj5oUDr9gX7M8HZEGzsWqjwS/qQqRT36scNBfT6JJE6BA
X-Google-Smtp-Source: AGHT+IHlUljmEcwMJvi+xcQwqcOfjuuLU0KJx5TwwI4WRIpM4+G1IXCZiqTouUiREhtopb5qsxW1eQ==
X-Received: by 2002:a17:902:7486:b0:1d9:b58e:70a2 with SMTP id h6-20020a170902748600b001d9b58e70a2mr121072pll.8.1707161032425;
        Mon, 05 Feb 2024 11:23:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUxUDc6IcpNf9UuA5YOHFmW2r8eHjV8sB8zOOJe4u34tw7MiZLfz33va7L6IHZN6PXfHNxiWyeIiYE3vhyxae01CpNHsGwu0Kh3KfzcFgyY8kfjh5LlYzpDIKHwCTVNKYR/1MP3DsPRSLAaJ1cvXOSc6/UPvuCt+R5kUJVzarv4XYkkj5xIfUCD33vfbK2hxuzfe47XhIHc4nMCbAj1awoprZmk80dddiXzLeothnGXqkV2X84hTLmXZQYtl3VZ64IO2F79hA==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001d083fed5f3sm229183plt.60.2024.02.05.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:23:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 09:23:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v2 2/5] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcE1xx8g-GULRkvW@slm.duckdns.org>
References: <20240203154334.791910-1-longman@redhat.com>
 <20240203154334.791910-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203154334.791910-3-longman@redhat.com>

Hello, Waiman.

On Sat, Feb 03, 2024 at 10:43:31AM -0500, Waiman Long wrote:
> @@ -242,6 +242,7 @@ struct pool_workqueue {
>  	int			refcnt;		/* L: reference count */
>  	int			nr_in_flight[WORK_NR_COLORS];
>  						/* L: nr of in_flight works */
> +	int			frozen;		/* L: temporarily frozen */

Can we say "plugged" instead? This is a bit confusing because freeze/thaw
are used by PM.

> @@ -1667,6 +1668,9 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>  
>  	lockdep_assert_held(&pool->lock);
>  
> +	if (pwq->frozen)
> +		return false;

Given that this only applied to unbound workqueues, this can be after the if
(!nna) block, right? And also maybe add unlikely()?

> +/**
> + * thaw_pwq - thaw a frozen pool_workqueue
> + * @pwq: pool_workqueue to be thawed
> + */
> +static void thaw_pwq(struct pool_workqueue *pwq)

and "unplug".

> @@ -4595,6 +4614,14 @@ static void pwq_release_workfn(struct kthread_work *work)
>  		mutex_lock(&wq->mutex);
>  		list_del_rcu(&pwq->pwqs_node);
>  		is_last = list_empty(&wq->pwqs);
> +
> +		/*
> +		 * For ordered workqueue with a frozen dfl_pwq, thaw it now.
> +		 */
> +		if (!is_last && (wq->flags & __WQ_ORDERED_EXPLICIT) &&
> +		    wq->dfl_pwq->frozen)
> +			thaw_pwq(wq->dfl_pwq);

It should thaw the last pwq in the wq->pwqs list, not the current dfl_pwq,
right? Imagine an ordered workqueue went through two unbound mask changes.
There will be three pwq's. Let's say there are work items queued on all
three. A, B, C are the workqueues in the oldest to neweest order. 0, 1, 2..
are work items in the queueing order.

   dfl_pwq --\
              |
              v
      pwqs -> C -> B -> A (oldest)
              |    |    |
              3    2    0
                        |
                        1

dfl_pwq should point to the latest pwq as that's where the new work items
should be queued. But, execution should only be allowed in the oldest pwq to
maintain execution order.

I think maybe a simpler way express the logic is "always keep only the last
pwq in the pwq list unplugged".

Also, we likely want to test __WQ_ORDERED as this should also apply to
implicitly ordered workqueues (they should go away eventually but still with
us for now). The problem is that __WQ_ORDERED can go off and when it goes of
it'd need to unplug all the pwqs and so on.

> @@ -4758,10 +4785,30 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
>  {
>  	if (ctx) {
>  		int cpu;
> +		bool refcheck = false;
>  
>  		for_each_possible_cpu(cpu)
>  			put_pwq_unlocked(ctx->pwq_tbl[cpu]);
> +
> +		/*
> +		 * For ordered workqueue with a frozen dfl_pwq and a reference
> +		 * count of 1 in ctx->dfl_pwq, it is highly likely that the
> +		 * refcnt will become 0 after the final put_pwq(). Acquire
> +		 * wq->mutex to ensure that the pwq won't be freed by
> +		 * pwq_release_workfn() when we check pwq later.
> +		 */
> +		if ((ctx->wq->flags & __WQ_ORDERED_EXPLICIT) &&
> +		     ctx->wq->dfl_pwq->frozen &&
> +		    (ctx->dfl_pwq->refcnt == 1)) {
> +			mutex_lock(&ctx->wq->mutex);
> +			refcheck = true;
> +		}
>  		put_pwq_unlocked(ctx->dfl_pwq);
> +		if (refcheck) {
> +			if (!ctx->dfl_pwq->refcnt)
> +				thaw_pwq(ctx->wq->dfl_pwq);
> +			mutex_unlock(&ctx->wq->mutex);
> +		}

I don't think it's a worthwhile optimization to not grab wq->mutex in
apply_wqattrs path. Can you please simplify the code?

> @@ -6316,11 +6367,28 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
>  		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
>  			continue;
>  
> -		/* creating multiple pwqs breaks ordering guarantee */
> +		/*
> +		 * We does not support changing cpumask of an ordered workqueue
                      ^
		      do

> +		 * again before the previous cpumask change is completed.

Maybe explain why?

> +		 * Sleep up to 100ms in 10ms interval to allow previous
> +		 * operation to complete and skip it if not done by then.
> +		 */
>  		if (!list_empty(&wq->pwqs)) {
> -			if (wq->flags & __WQ_ORDERED_EXPLICIT)
> -				continue;
> -			wq->flags &= ~__WQ_ORDERED;
> +			struct pool_workqueue *pwq = wq->dfl_pwq;
> +
> +			if (!(wq->flags & __WQ_ORDERED_EXPLICIT)) {
> +				wq->flags &= ~__WQ_ORDERED;
> +			} else if (pwq && pwq->frozen) {
> +				int i;
> +
> +				for (i = 0; i < 10; i++) {
> +					msleep(10);
> +					if (!pwq->frozen)
> +						break;
> +				}
> +				if (WARN_ON_ONCE(pwq->frozen))
> +					continue;
> +			}

I don't understand this. Why do we need to block further changes?

Thanks.

-- 
tejun

