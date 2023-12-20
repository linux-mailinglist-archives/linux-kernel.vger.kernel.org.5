Return-Path: <linux-kernel+bounces-6264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171281967D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68662B24CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CC17472;
	Wed, 20 Dec 2023 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpq3RUWu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEEE6101;
	Wed, 20 Dec 2023 01:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4EEC433C8;
	Wed, 20 Dec 2023 01:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703036868;
	bh=hvJlLQs5zEM/bYJflBKrAbgZJqlhq41MU0G88Uwz0hM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gpq3RUWuS8hO+S1jgyAHjVXsG3+cFamc3bcJOoIi8iPrhq9QDOekQbTSJ6p2z8Q7Y
	 w+bj6cb8yzE1TDe/gmFDV+3VVX3JCnYd43nZaucZfbP6c5dziAGfHuOkDoSliMEY1T
	 xTt4a1LuWOB1HLL0XBIFFZhcxcZA2yruk2mNlURMassntf2aLjohvaY6WU5YZ+DUf5
	 X4buKOJXg5hHlbzb6qXyoT9XlH7IPpP/itos69loMOcW5iAxJFMaxX1/DI9soakt01
	 odRYezTdZIkYV5VMItN8Y8YcvJGVoG1gXbvoMXAUwBdqPLKY2nnZRSLsUXokd6PiuW
	 CIPlVIAfG40mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B59CFCE10DA; Tue, 19 Dec 2023 17:47:47 -0800 (PST)
Date: Tue, 19 Dec 2023 17:47:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 6/7] rcu: Move sync related data to rcu_state structure
Message-ID: <664015f6-6064-4c51-8072-ff48f43ed000@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-7-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128080033.288050-7-urezki@gmail.com>

On Tue, Nov 28, 2023 at 09:00:32AM +0100, Uladzislau Rezki (Sony) wrote:
> Move synchronize_rcu() main control data under the rcu_state
> structure. An access is done via "rcu_state" global variable.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Could we please fold this into the earlier patches?  Your future self
might thank me.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 50 ++++++++++++++---------------------------------
>  kernel/rcu/tree.h | 19 ++++++++++++++++++
>  2 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 69663a6d5050..c0d3e46730e8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1384,19 +1384,6 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> -/*
> - * A max threshold for synchronize_rcu() users which are
> - * awaken directly by the rcu_gp_kthread(). Left part is
> - * deferred to the main worker.
> - */
> -#define SR_MAX_USERS_WAKE_FROM_GP 5
> -#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
> -
> -struct sr_wait_node {
> -	atomic_t inuse;
> -	struct llist_node node;
> -};
> -
>  /*
>   * There is a single llist, which is used for handling
>   * synchronize_rcu() users' enqueued rcu_synchronize nodes.
> @@ -1523,17 +1510,10 @@ struct sr_wait_node {
>   * +----------+     +--------+
>   *
>   */
> -static struct sr_normal_state {
> -	struct llist_head srs_next;	/* request a GP users. */
> -	struct llist_node *srs_wait_tail; /* wait for GP users. */
> -	struct llist_node *srs_done_tail; /* ready for GP users. */
> -	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
> -} sr;
> -
>  static bool rcu_sr_is_wait_head(struct llist_node *node)
>  {
> -	return &(sr.srs_wait_nodes)[0].node <= node &&
> -		node <= &(sr.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
> +	return &(rcu_state.srs_wait_nodes)[0].node <= node &&
> +		node <= &(rcu_state.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
>  }
>  
>  static struct llist_node *rcu_sr_get_wait_head(void)
> @@ -1542,7 +1522,7 @@ static struct llist_node *rcu_sr_get_wait_head(void)
>  	int i;
>  
>  	for (i = 0; i < SR_NORMAL_GP_WAIT_HEAD_MAX; i++) {
> -		sr_wn = &(sr.srs_wait_nodes)[i];
> +		sr_wn = &(rcu_state.srs_wait_nodes)[i];
>  
>  		if (!atomic_cmpxchg_acquire(&sr_wn->inuse, 0, 1))
>  			return &sr_wn->node;
> @@ -1590,7 +1570,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  	 * cannot execute concurrently by multiple kworkers,
>  	 * the done tail list manipulations are protected here.
>  	 */
> -	done = smp_load_acquire(&sr.srs_done_tail);
> +	done = smp_load_acquire(&rcu_state.srs_done_tail);
>  	if (!done)
>  		return;
>  
> @@ -1626,12 +1606,12 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	struct llist_node *wait_tail, *head, *rcu;
>  	int done = 0;
>  
> -	wait_tail = sr.srs_wait_tail;
> +	wait_tail = rcu_state.srs_wait_tail;
>  	if (wait_tail == NULL)
>  		return;
>  
> -	sr.srs_wait_tail = NULL;
> -	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> +	rcu_state.srs_wait_tail = NULL;
> +	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
>  
>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>  	head = wait_tail->next;
> @@ -1662,8 +1642,8 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	}
>  
>  	// concurrent sr_normal_gp_cleanup work might observe this update.
> -	smp_store_release(&sr.srs_done_tail, wait_tail);
> -	ASSERT_EXCLUSIVE_WRITER(sr.srs_done_tail);
> +	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>  
>  	if (wait_tail->next)
>  		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> @@ -1678,7 +1658,7 @@ static bool rcu_sr_normal_gp_init(void)
>  	struct llist_node *wait_head;
>  	bool start_new_poll = false;
>  
> -	first = READ_ONCE(sr.srs_next.first);
> +	first = READ_ONCE(rcu_state.srs_next.first);
>  	if (!first || rcu_sr_is_wait_head(first))
>  		return start_new_poll;
>  
> @@ -1690,23 +1670,23 @@ static bool rcu_sr_normal_gp_init(void)
>  	}
>  
>  	/* Inject a wait-dummy-node. */
> -	llist_add(wait_head, &sr.srs_next);
> +	llist_add(wait_head, &rcu_state.srs_next);
>  
>  	/*
>  	 * A waiting list of rcu_synchronize nodes should be empty on
>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
>  	 * rolls it over. If not, it is a BUG, warn a user.
>  	 */
> -	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
> -	sr.srs_wait_tail = wait_head;
> -	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> +	WARN_ON_ONCE(rcu_state.srs_wait_tail != NULL);
> +	rcu_state.srs_wait_tail = wait_head;
> +	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
>  
>  	return start_new_poll;
>  }
>  
>  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>  {
> -	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
>  }
>  
>  /*
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 192536916f9a..f72166b5067a 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -316,6 +316,19 @@ do {									\
>  	__set_current_state(TASK_RUNNING);				\
>  } while (0)
>  
> +/*
> + * A max threshold for synchronize_rcu() users which are
> + * awaken directly by the rcu_gp_kthread(). Left part is
> + * deferred to the main worker.
> + */
> +#define SR_MAX_USERS_WAKE_FROM_GP 5
> +#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
> +
> +struct sr_wait_node {
> +	atomic_t inuse;
> +	struct llist_node node;
> +};
> +
>  /*
>   * RCU global state, including node hierarchy.  This hierarchy is
>   * represented in "heap" form in a dense array.  The root (first level)
> @@ -397,6 +410,12 @@ struct rcu_state {
>  						/* Synchronize offline with */
>  						/*  GP pre-initialization. */
>  	int nocb_is_setup;			/* nocb is setup from boot */
> +
> +	/* synchronize_rcu() part. */
> +	struct llist_head srs_next;	/* request a GP users. */
> +	struct llist_node *srs_wait_tail; /* wait for GP users. */
> +	struct llist_node *srs_done_tail; /* ready for GP users. */
> +	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
>  };
>  
>  /* Values for rcu_state structure's gp_flags field. */
> -- 
> 2.39.2
> 

