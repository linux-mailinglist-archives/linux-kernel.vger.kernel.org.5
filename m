Return-Path: <linux-kernel+bounces-25090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3398E82C7D8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502181C219A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F618E33;
	Fri, 12 Jan 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWyfoPNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC618C2F;
	Fri, 12 Jan 2024 23:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D34C433F1;
	Fri, 12 Jan 2024 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705100994;
	bh=efTI8B5muEIKqGCBPUBKmsADMSjVD/REEPOCMdTkE/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWyfoPNXyKJEhKGXUj7KSKllQ6JLPm2xKqjl7YpSLMHORqfS9ohgTqHH1poT1/M0C
	 LN/hbtbQx6cFrr++HvCe8PEA5iyevhrVAH5TslsOzL88xFLeLKyANgYidtBlIALNXg
	 Q2+rZcnccRmqFeodEIh63X3ZJXz5POndb0ZXChM/uR/pIgtHscbWd+pYHSKgenBbJ3
	 w38WIPRYVW5wCJVA5tGkmk6yDmogJZv57sv9SYBxDK2HygvnO/PBfRLSGZygEHmjmj
	 Y4KcuWyRfn5JaJEYbVDAPTsXbhUw6svq0ZW8vfVtcUlO3vFX10CJs8aLRRGomMkq8z
	 KXSIjJfGOS02Q==
Date: Sat, 13 Jan 2024 00:09:51 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZaHGv3wMYP4LDCxG@localhost.localdomain>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104162510.72773-2-urezki@gmail.com>

Le Thu, Jan 04, 2024 at 05:25:07PM +0100, Uladzislau Rezki (Sony) a écrit :
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 9b0b52e1836f..4812c6249185 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -168,4 +168,16 @@ config RCU_STRICT_GRACE_PERIOD
>  	  when looking for certain types of RCU usage bugs, for example,
>  	  too-short RCU read-side critical sections.
>  
> +config RCU_SR_NORMAL_DEBUG_GP
> +	bool "Debug synchronize_rcu() callers for a grace period completion"
> +	depends on DEBUG_KERNEL && RCU_EXPERT
> +	default n
> +	help
> +	  This option enables additional debugging for detecting a grace
> +	  period incompletion for synchronize_rcu() users. If a GP is not
> +	  fully passed for any user, the warning message is emitted.
> +
> +	  Say Y here if you want to enable such debugging
> +	  Say N if you are unsure.

How about just reuse CONFIG_PROVE_RCU instead?

> +
>  endmenu # "RCU Debugging"
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 499803234176..b756c40e4960 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1422,6 +1422,106 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> +/*
> + * There are three lists for handling synchronize_rcu() users.
> + * A first list corresponds to new coming users, second for users
> + * which wait for a grace period and third is for which a grace
> + * period is passed.
> + */
> +static struct sr_normal_state {
> +	struct llist_head srs_next;	/* request a GP users. */
> +	struct llist_head srs_wait;	/* wait for GP users. */
> +	struct llist_head srs_done;	/* ready for GP users. */
> +
> +	/*
> +	 * In order to add a batch of nodes to already
> +	 * existing srs-done-list, a tail of srs-wait-list
> +	 * is maintained.
> +	 */
> +	struct llist_node *srs_wait_tail;
> +} sr;

"sr" is good enough for a function scope variable but not for a file scope one.

At least "sr_state" would be better. Or maybe you don't even need to name that
struct and make instead:

struct {
    ...
    ...
} sr_normal_state;


> +
> +/* Disabled by default. */
> +static int rcu_normal_wake_from_gp;
> +module_param(rcu_normal_wake_from_gp, int, 0644);
> +
> +static void rcu_sr_normal_complete(struct llist_node *node)
> +{
> +	struct rcu_synchronize *rs = container_of(
> +		(struct rcu_head *) node, struct rcu_synchronize, head);

Should there be some union in struct rcu_synchronize between struct rcu_head
and struct llist_node?

Anyway it's stack allocated, they could even be separate fields.

> +	unsigned long oldstate = (unsigned long) rs->head.func;

Luckily struct callback_head layout allows such magic but if rcu_head
and llist_node were separate, reviewers would be less hurt.

If stack space really matters, something like the below?

struct rcu_synchronize {
	union {
		struct rcu_head head;
		struct {
			struct llist_node node;
			unsigned long seq;
		}
	}
	struct completion completion;
};


> +
> +	WARN_ONCE(IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP) &&
> +		!poll_state_synchronize_rcu(oldstate),
> +		"A full grace period is not passed yet: %lu",
> +		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> +
> +	/* Finally. */
> +	complete(&rs->completion);
> +}
> +
[...]
> +
> +/*
> + * Helper function for rcu_gp_cleanup().
> + */
> +static void rcu_sr_normal_gp_cleanup(void)
> +{
> +	struct llist_node *head, *tail;
> +
> +	if (llist_empty(&sr.srs_wait))
> +		return;
> +
> +	tail = READ_ONCE(sr.srs_wait_tail);

Is the READ_ONCE() needed?

A part from those boring details:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

