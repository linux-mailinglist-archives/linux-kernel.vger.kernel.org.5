Return-Path: <linux-kernel+bounces-6263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571E81967B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515E128832F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5B101CC;
	Wed, 20 Dec 2023 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUUb2y/s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C9FBE0;
	Wed, 20 Dec 2023 01:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49AAC433C8;
	Wed, 20 Dec 2023 01:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703036771;
	bh=G6Na+o08O7NvAM3bYJH+ZZ+NK7OTd5tAWejkpq8S3is=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KUUb2y/sHWhFgVekG/obY+YNv4mGHuJZsQjcavJYzw+jXF1hQQBXTSB9neIlQQJy1
	 ny+2zguYZ3696R/65ejcOATwpMP+VglDW1pCuGf/z5YWIpISr3BRf32kJm8rjaLyxs
	 f1bZqlNaQnrGtTnOEpCByxD7qt9DiLq3c7Jf71fFtB1Y9MJxM1xKQRKVxIAKSiZwWr
	 Xcru5wMtEjs+Vd5j6ep1Y42PmtI9WuyHgDFJbqC/+j7rjZwaSrh8OtDDGcxQ9WV4sb
	 cVleMWNJSFezChCOVVLmtld71r7gzh7zCR2nMtd+8OdOUdl7B11pTLXbhmDiEbQ1OE
	 r/OIKurv/8QKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B9EFCE10DA; Tue, 19 Dec 2023 17:46:11 -0800 (PST)
Date: Tue, 19 Dec 2023 17:46:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 5/7] rcu: Support direct wake-up of synchronize_rcu()
 users
Message-ID: <e04f30bf-9793-4c42-a9a9-24c8f3545f3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-6-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128080033.288050-6-urezki@gmail.com>

On Tue, Nov 28, 2023 at 09:00:31AM +0100, Uladzislau Rezki (Sony) wrote:
> This patch introduces a small enhancement which allows to do a
> direct wake-up of synchronize_rcu() callers. It occurs after a
> completion of grace period, thus by the gp-kthread.
> 
> Number of clients is limited by the hard-coded maximum allowed
> threshold. The remaining part, if still exists is deferred to
> a main worker.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Nice optimization!

One question below.

> ---
>  kernel/rcu/tree.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d7b48996825f..69663a6d5050 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1384,6 +1384,12 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> +/*
> + * A max threshold for synchronize_rcu() users which are
> + * awaken directly by the rcu_gp_kthread(). Left part is
> + * deferred to the main worker.
> + */
> +#define SR_MAX_USERS_WAKE_FROM_GP 5
>  #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
>  
>  struct sr_wait_node {
> @@ -1617,7 +1623,8 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
>   */
>  static void rcu_sr_normal_gp_cleanup(void)
>  {
> -	struct llist_node *wait_tail;
> +	struct llist_node *wait_tail, *head, *rcu;
> +	int done = 0;
>  
>  	wait_tail = sr.srs_wait_tail;
>  	if (wait_tail == NULL)
> @@ -1626,11 +1633,39 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	sr.srs_wait_tail = NULL;
>  	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
>  
> +	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> +	head = wait_tail->next;
> +
> +	/*
> +	 * Process (a) and (d) cases. See an illustration. Apart of
> +	 * that it handles the scenario when all clients are done,
> +	 * wait-head is released if last. The worker is not kicked.
> +	 */
> +	llist_for_each_safe(rcu, head, head) {

This does appear to be a clever way to save eight bytes on the stack,
but is our stack space really so restricted?  We are being invoked from
the RCU GP kthread, which isn't using much stack, right?

If so, let's spend the extra local variable and spare the reader a
trip to the llist_for_each_safe() definition.

> +		if (rcu_sr_is_wait_head(rcu)) {
> +			if (!rcu->next) {
> +				rcu_sr_put_wait_head(rcu);
> +				wait_tail->next = NULL;
> +			} else {
> +				wait_tail->next = rcu;
> +			}
> +
> +			break;
> +		}
> +
> +		rcu_sr_normal_complete(rcu);
> +		// It can be last, update a next on this step.
> +		wait_tail->next = head;
> +
> +		if (++done == SR_MAX_USERS_WAKE_FROM_GP)
> +			break;
> +	}
> +
>  	// concurrent sr_normal_gp_cleanup work might observe this update.
>  	smp_store_release(&sr.srs_done_tail, wait_tail);
>  	ASSERT_EXCLUSIVE_WRITER(sr.srs_done_tail);
>  
> -	if (wait_tail)
> +	if (wait_tail->next)
>  		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
>  }
>  
> -- 
> 2.39.2
> 

