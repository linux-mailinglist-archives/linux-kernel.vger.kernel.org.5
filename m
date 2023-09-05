Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4A792ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjIEQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354735AbjIENz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:55:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF33CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2wN1X5fBI4q9X5EmxRXxR3Y4mZ7KwP1OsUi7wgvSTwU=; b=mMf5NkibFQ3qJ9YZ822tgtfwkY
        s8DuaIlFcLj/Xz+ocUqZnnfu9fJT+XlomEawIUfq9/sIXhxOeYXdiFM6rMih4kusTg/OQsfmTQm97
        2FaHjndgUCcobDZc7e7fZrC7nznty1nz0EdyjTUykRL8r2He1OFP7JG8YRk2LZK0mW4e0xZbS6GC/
        1be3Y4QabE0WfGYtx1Hvgr4/z9oWUzLa8M8xEY6Bo0iqHzHva7k5BnNdjZd/oVaSLgSDD60zLZ8Kl
        w3pT/GiHtN5qxhgbjaPe98czf/+vdNElsU/Srtdzgkpbod4JwZ8KNRBbKbtCzg/LAKVSqlTDuQljK
        ShDdVamg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdWWB-000Wbq-2F;
        Tue, 05 Sep 2023 13:55:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD043300687; Tue,  5 Sep 2023 15:55:00 +0200 (CEST)
Date:   Tue, 5 Sep 2023 15:55:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 7/7] sched/fair: Fair server interface
Message-ID: <20230905135500.GB20703@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:28:58PM +0200, Daniel Bristot de Oliveira wrote:
> +static ssize_t
> +sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
> +				size_t cnt, loff_t *ppos)
> +{
> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
> +	struct rq *rq = cpu_rq(cpu);
> +	unsigned long flags;
> +	u64 runtime;
> +	int err;
> +
> +	err = kstrtoull_from_user(ubuf, cnt, 10, &runtime);
> +	if (err)
> +		return err;
> +
> +	raw_spin_rq_lock_irqsave(rq, flags);
> +	if (runtime > rq->fair_server.dl_period)
> +		err = -EINVAL;
> +	else
> +		rq->fair_server.dl_runtime = runtime;
> +	raw_spin_rq_unlock_irqrestore(rq, flags);
> +
> +	if (err)
> +		return err;
> +
> +	*ppos += cnt;
> +	return cnt;
> +}

> +static ssize_t
> +sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
> +			       size_t cnt, loff_t *ppos)
> +{
> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
> +	struct rq *rq = cpu_rq(cpu);
> +	unsigned long flags;
> +	u64 period;
> +	int err;
> +
> +	err = kstrtoull_from_user(ubuf, cnt, 10, &period);
> +	if (err)
> +		return err;
> +
> +	if (period < fair_server_period_min || period > fair_server_period_max)
> +		return -EINVAL;
> +
> +	raw_spin_rq_lock_irqsave(rq, flags);
> +	if (period < rq->fair_server.dl_runtime)
> +		err = -EINVAL;
> +	else
> +		rq->fair_server.dl_period = period;
> +	raw_spin_rq_unlock_irqrestore(rq, flags);
> +
> +	if (err)
> +		return err;
> +
> +	*ppos += cnt;
> +	return cnt;
> +}

> +static ssize_t
> +sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
> +			      size_t cnt, loff_t *ppos)
> +{
> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
> +	struct rq *rq = cpu_rq(cpu);
> +	unsigned long flags;
> +	u64 defer;
> +	int err;
> +
> +	err = kstrtoull_from_user(ubuf, cnt, 10, &defer);
> +	if (err)
> +		return err;
> +
> +	if (defer < 0 || defer > 1)
> +		return -EINVAL;
> +
> +	raw_spin_rq_lock_irqsave(rq, flags);
> +	rq->fair_server_defer = defer;
> +	raw_spin_rq_unlock_irqrestore(rq, flags);
> +
> +	*ppos += cnt;
> +	return cnt;
> +}

Surely we can write a single function that does all of that with less
duplication?

Additionally, should not the deadline parameters be vetted by access
control before being accepted ?

Perhaps something like so:

static ssize_t
sched_fair_server_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos, enum dl_param param)
{
	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
	struct rq *rq = cpu_rq(cpu);
	u64 value;

	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
	if (err)
		return err;

	scoped_guard (rq_lock_irqsave, rq) {

		u64 runtime, deadline, period;

		runtime  = rq->fair_server.dl_runtime;
		deadline = rq->fair_server.dl_deadline;
		period   = rq->fair_server.dl_period;

		switch (param) {
			case dl_runtime:  runtime  = value; break;
			case dl_deadline: deadline = value; break;
			case dl_period:   period   = value; break;
		}

		if (runtime > deadline ||
		    deadline > period ||
		    /* more stuff like access controll */)
			return -EINVAL;

		rq->fair_server.dl_runtime  = runtime;
		rq->fair_server.dl_deadline = deadline;
		rq->fair_server.dl_period   = period;
	}

	*ppos += cnt;
	return cnt;
}


