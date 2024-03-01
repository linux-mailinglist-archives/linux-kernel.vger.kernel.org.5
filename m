Return-Path: <linux-kernel+bounces-87966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13186DB96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDDF1F22B48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F0867E8E;
	Fri,  1 Mar 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jizRiZ7O"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3851C59
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275332; cv=none; b=FOSKEVHqogZFvPz0gEGfBU5sYuBvzmAd7FugqZMtKSdxAawNoN81X8Q8rMFPVaIZ4T9BTZ12pugJfWaTbkeWg1J/4LH1ewPQ/avGoj4DNzhUXBYM/vqqdngqKn1VPZVLiy2g99LD6G5JnQBaot4ThYwPfGmHpeeskTSwuQJVEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275332; c=relaxed/simple;
	bh=sOsR+rEMTVlJlwecWhbnALo6XtUp3alMHAtj892IZCc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pFJMf7ojIH/mAzzrJALaHU1bXNfJlUvtF+YZVVtMrVEEDl22lFfDrfL9UexeXZnEBaDuJbLzs1sdk7BSHoNlLNLOVuigSBZQTbNGa3LPZ1+iozWh/TTx4lnuSzGUaze5hUYVsX2BB6gT5WjgKE6qMb9YvEORVE1TrFcR9xPflco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jizRiZ7O; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709275320; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=sqwdvmtygLAFL1CWoSfkJRZvmTqRa73rEJVDg9NqqtI=;
	b=jizRiZ7OOMEaJyBbrNd5GL07K2bTmq+6gVC0YfCGcuKqT7IVmVh6IZGUXhKwLF3/b9LpmCb66CEJOo+NNIeryvSdrYVVO5Vl7crJp6xaea57fgMHS9z4UkGIZEnCtbPXM+smSQFp3X++RDNRMbME8M1sTqsURUThFBEaT7edItc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W1Y8i9M_1709275316;
Received: from 30.97.48.218(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1Y8i9M_1709275316)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 14:41:58 +0800
Message-ID: <9b58ef1d-0d45-4fbb-b154-abcbb10211c9@linux.alibaba.com>
Date: Fri, 1 Mar 2024 14:41:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Barry Song <21cnbao@gmail.com>, Benjamin Segall <bsegall@google.com>,
 Chen Yu <yu.c.chen@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mike Galbraith <efault@gmx.de>,
 Qais Yousef <qyousef@layalina.io>, Tim Chen <tim.c.chen@linux.intel.com>,
 Yicong Yang <yangyicong@huawei.com>,
 Youssef Esmat <youssefesmat@chromium.org>, linux-kernel@vger.kernel.org
References: <c2ceff07-e1b4-4dbc-b945-f91a9076375e@linux.alibaba.com>
 <59585184-d13d-46e0-8d68-42838e97a702@bytedance.com>
Content-Language: en-US
In-Reply-To: <59585184-d13d-46e0-8d68-42838e97a702@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/29 22:25, Abel Wu wrote:
> Good catch. And to the best of my knowledge, the answer is YES. The
> above Equation in the paper, which is Eq. (20), is based on the
> assumption that:
> 
>      "once client 3 leaves, the remaining two clients will
>       proportionally support the eventual loss or gain in the
>       service time"  -- Page 10
> 
>      "by updating the virtual time according to Eq. (18,19) we
>       ensure that the sum over the lags of all active clients
>       is always zero"  -- Page 11
> 
> But in Peter's implementation, it is the competitors in the new group
> that client 3 later joins in who actually support the effect. So when
> client 3 leaves competition with !0-lag in Linux, the rq's sum(lag_i)
> is no longer zero.
> 

I've different opinions. According to the comments above avg_vruntime_add(), V
is calculated exactly to satisfy sum(lag_i)=0. This is guaranteed by math.

Actually I print some logs in enqueue_entity() and dequeue_entity() to verify this:

[  293.261236] before dequeue: V=2525278131 W=3072 v=2526243139 w=1024 lag_sum=0
[  293.261237] after dequeue: V=2524795627 W=2048 v=2526243139 w=1024 lag_sum=0
[  293.262286] before enqueue: V=2525319064 W=2048 v=2526766576 w=1024 lag_sum=0
[  293.262287] after enqueue: V=2525801568 W=3072 v=2526766576 w=1024 lag_sum=0

For the first 2 lines, we have 2524795627 = 2525278131 + (2525278131 - 2526243139) * 1024 / 2048.
Which is Eq. (18)

For the last 2 lines, we have 2525801568 = 2525319064 - (2525319064 - 2526766576) * 1024 / 3072.
Which is Eq. (19)

So whatever client 3 leave or join competition with !0-lag in Linux, V is handled properly.

> Good catch again! It smells like a bug. Since this @se is still on_rq,
> it should be taken into consideration when calculating avg_runtime(),
> but in fact it isn't because __dequeue_entity() will remove its share.
> 
> And I seem to spot another bug, although not relate to this problem,
> that we actually need to call update_curr() unconditionally if curr is
> available, because we need to commit curr's outstanding runtime to
> ensure the result of avg_runtime() is up to date.
> 

I've tried to record avg_vruntime before __dequeue_entity() and pass it to
reweight_eevdf(). Then the issue is fixed. The V keeps the same during the whole
reweight_entity().

I could send these two bugfix patches (one for this bug and one you sugguested
about update_curr). But before doing so, I still want to dig out the answer of
my first question.

Hi Peter, would you please provide any information?

Thanks.



My rough logging code:
(Note: lag_sum may output a minus value, with its absolute value less than W.
This is ok because my lag_sum calculate is not so accurate due to the sign flips
in avg_vruntime())

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..9306c1bbd472 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5260,6 +5260,62 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
  
  static inline bool cfs_bandwidth_used(void);
  
+static int rbtree_all(const void *key, const struct rb_node *node)
+{
+	return 0;
+}
+
+static s64 get_lag_sum(struct cfs_rq *cfs_rq)
+{
+	u64 avruntime = avg_vruntime(cfs_rq);
+	struct sched_entity *curr = cfs_rq->curr;
+	struct rb_node *node;
+	s64 lag_sum = 0;
+
+	rb_for_each(node, 0, &cfs_rq->tasks_timeline.rb_root, rbtree_all) {
+		struct sched_entity *se = __node_2_se(node);
+
+		if (se->on_rq)
+			lag_sum += (avruntime - se->vruntime) * scale_load_down(se->load.weight);
+	}
+
+	if (curr && curr->on_rq) {
+		lag_sum += (avruntime - curr->vruntime) * scale_load_down(curr->load.weight);
+	}
+
+	return lag_sum;
+}
+
+static void print_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se, bool before, bool enqueue)
+{
+	if (cpu_of(rq_of(cfs_rq)))
+		return; // avoid too many printings.
+
+	long load = cfs_rq->avg_load;
+	struct sched_entity *curr = cfs_rq->curr;
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 lag_sum = get_lag_sum(cfs_rq);
+	u64 avruntime = avg_vruntime(cfs_rq);
+
+	if (curr && curr->on_rq) {
+		unsigned long curr_weight = scale_load_down(curr->load.weight);
+		load += curr_weight;
+	}
+
+	if (before) {
+		if (enqueue)
+			printk("before enqueue: V=%llu W=%ld v=%llu w=%lu lag_sum=%lld\n", avruntime, load, se->vruntime, weight, lag_sum);
+		else
+			printk("before dequeue: V=%llu W=%ld v=%llu w=%lu lag_sum=%lld\n", avruntime, load, se->vruntime, weight, lag_sum);
+	}
+	else {
+		if (enqueue)
+			printk("after enqueue: V=%llu W=%ld v=%llu w=%lu lag_sum=%lld\n", avruntime, load, se->vruntime, weight, lag_sum);
+		else
+			printk("after dequeue: V=%llu W=%ld v=%llu w=%lu lag_sum=%lld\n", avruntime, load, se->vruntime, weight, lag_sum);
+	}
+}
+
  static void
  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  {
@@ -5307,9 +5363,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  
  	check_schedstat_required();
  	update_stats_enqueue_fair(cfs_rq, se, flags);
+	print_eevdf(cfs_rq, se, true, true);
  	if (!curr)
  		__enqueue_entity(cfs_rq, se);
  	se->on_rq = 1;
+	print_eevdf(cfs_rq, se, false, true);
  
  	if (cfs_rq->nr_running == 1) {
  		check_enqueue_throttle(cfs_rq);
@@ -5347,6 +5405,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
  
  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
  
+
  static void
  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  {
@@ -5377,9 +5436,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  	clear_buddies(cfs_rq, se);
  
  	update_entity_lag(cfs_rq, se);
+	print_eevdf(cfs_rq, se, true, false);
  	if (se != cfs_rq->curr)
  		__dequeue_entity(cfs_rq, se);
  	se->on_rq = 0;
+	print_eevdf(cfs_rq, se, false, false);
  	account_entity_dequeue(cfs_rq, se);
  
  	/* return excess runtime on last dequeue */

