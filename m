Return-Path: <linux-kernel+bounces-45115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774A842BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0510C1C21760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051B69DFC;
	Tue, 30 Jan 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUf3U2Mw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D1762C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639643; cv=none; b=mEcIzLQLi95J2y2Bo/swU+UTh1tJIQZOk6oqmDpNFnlZoKmVCa5BBeCaC9W5m0BPFj3AvGaUwUsi2E0WUwe9fA5d7YtZn7Nw7TTv7rRE4trTA3FnTOGZ7CgA3TgmZUzy0g59HQfyy9Ol1N3TROqSovRxa2l/IOZ5dRsowZx/OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639643; c=relaxed/simple;
	bh=VQCexM6e++RY+6jzM1DaC5wChCDVDeV0eB8BVjKjVgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HO1rtQ82vG8Z5Llpiyo0YRYCIbpMeLtVsR5XSIXIcERVS51HqGiKMPS7VPJGBFd7ZPnRn0/ZZBdhmL2azi4TBuMJF1gJzKpx9kiBsPX0E0WDScY/A+uHnpRFDackyzGfooCifsxJJytJcaeHKEe247YCvOp0BdPMyBnftea3VWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUf3U2Mw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706639640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0l50zp4DV93ToPjoT6lIoiAHIsdSlkpo+6laKp6mmI=;
	b=NUf3U2MwoS3/G0R8SKk5wkcEJ9yCTxi7eu3tsRs7GR5PEHj05wGZzg0bjxxKFrmWjYDYqI
	+H8/rjq0k8c29WZnfn4wl+T6bN+crGQoVWxYuKI997M3tTnLsEXcO9rdmYDxKqLNVtrfbM
	jVKRdyoA//l3dNaJRk8yLjo/CZWZsyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-IKjcfz2fNZWmlSRedM76xg-1; Tue, 30 Jan 2024 13:33:59 -0500
X-MC-Unique: IKjcfz2fNZWmlSRedM76xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 795C284A298;
	Tue, 30 Jan 2024 18:33:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19B3740CD14B;
	Tue, 30 Jan 2024 18:33:57 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 3/3] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Tue, 30 Jan 2024 13:33:36 -0500
Message-Id: <20240130183336.511948-4-longman@redhat.com>
In-Reply-To: <20240130183336.511948-1-longman@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Ordered workqueues does not currently follow changes made to the
global unbound cpumask because per-pool workqueue changes may break
the ordering guarantee. IOW, a work function in an ordered workqueue
may run on a cpuset isolated CPU.

This patch enables ordered workqueues to follow changes made to the
global unbound cpumask by temporaily saving the work items in an
internal queue until the old pwq has been properly flushed and to be
freed. At that point, those work items, if present, are queued back to
the new pwq to be executed.

This enables ordered workqueues to follow the unbound cpumask changes
like other unbound workqueues at the expense of some delay in execution
of work functions during the transition period.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 169 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 13 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 98c741eb43af..0ecbeecc74f2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -320,11 +320,30 @@ struct workqueue_struct {
 	 */
 	struct rcu_head		rcu;
 
+	/*
+	 * For orderly transition from old pwq to new pwq in ordered workqueues.
+	 *
+	 * During transition, queue_work() will queue the work items in a
+	 * temporary o_list. Once the old pwq is properly flushed and to be
+	 * freed, the pending work items in o_list will be queued to the new
+	 * pwq to start execution.
+	 */
+	raw_spinlock_t		o_lock;	 /* for protecting o_list & o_state */
+	atomic_t		o_nr_qw; /* queue_work() in progress count */
+	int			o_state; /* pwq transition state */
+	struct list_head	o_list;	 /* pending ordered work items */
+
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
 };
 
+enum ordered_wq_states {
+	ORD_NORMAL = 0,	/* default normal working state */
+	ORD_QUEUE,	/* queue works in o_list */
+	ORD_WAIT,	/* busy waiting */
+};
+
 static struct kmem_cache *pwq_cache;
 
 /*
@@ -1425,8 +1444,24 @@ static void get_pwq(struct pool_workqueue *pwq)
 static void put_pwq(struct pool_workqueue *pwq)
 {
 	lockdep_assert_held(&pwq->pool->lock);
+	lockdep_assert_irqs_disabled();
 	if (likely(--pwq->refcnt))
 		return;
+
+	/*
+	 * If pwq transition is in progress for ordered workqueue and
+	 * there is no pending work in wq->o_list, we can end this
+	 * transition period here.
+	 */
+	if (READ_ONCE(pwq->wq->o_state)) {
+		struct workqueue_struct *wq = pwq->wq;
+
+		raw_spin_lock(&wq->o_lock);
+		if (list_empty(&wq->o_list))
+			WRITE_ONCE(wq->o_state, ORD_NORMAL);
+		raw_spin_unlock(&wq->o_lock);
+	}
+
 	/*
 	 * @pwq can't be released under pool->lock, bounce to a dedicated
 	 * kthread_worker to avoid A-A deadlocks.
@@ -1795,6 +1830,8 @@ static void __queue_work_rcu_locked(int cpu, struct workqueue_struct *wq,
 static void __queue_work(int cpu, struct workqueue_struct *wq,
 			 struct work_struct *work)
 {
+	bool owq = wq->flags & __WQ_ORDERED_EXPLICIT;
+
 	/*
 	 * While a work item is PENDING && off queue, a task trying to
 	 * steal the PENDING will busy-loop waiting for it to either get
@@ -1813,7 +1850,35 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		return;
 
 	rcu_read_lock();
+	if (owq) {
+		/* Provide an acquire barrier */
+		atomic_inc_return_acquire(&wq->o_nr_qw);
+		for (;;) {
+			int ostate = READ_ONCE(wq->o_state);
+
+			if (!ostate)
+				break;
+			if (ostate == ORD_QUEUE) {
+				int new_ostate;
+
+				raw_spin_lock(&wq->o_lock);
+				new_ostate = READ_ONCE(wq->o_state);
+				if (unlikely(new_ostate != ostate)) {
+					raw_spin_unlock(&wq->o_lock);
+					continue;
+				}
+				list_add_tail(&work->entry, &wq->o_list);
+				raw_spin_unlock(&wq->o_lock);
+				goto unlock_out;
+			} else {	/* ostate == ORD_WAIT */
+				cpu_relax();
+			}
+		}
+	}
 	__queue_work_rcu_locked(cpu, wq, work);
+unlock_out:
+	if (owq)
+		atomic_dec(&wq->o_nr_qw);
 	rcu_read_unlock();
 }
 
@@ -4107,6 +4172,57 @@ static void rcu_free_pwq(struct rcu_head *rcu)
 			container_of(rcu, struct pool_workqueue, rcu));
 }
 
+/* requeue the work items stored in wq->o_list */
+static void requeue_ordered_works(struct workqueue_struct *wq)
+{
+	LIST_HEAD(head);
+	struct work_struct *work, *next;
+
+	raw_spin_lock_irq(&wq->o_lock);
+	if (list_empty(&wq->o_list))
+		goto unlock_out;	/* No requeuing is needed */
+
+	list_splice_init(&wq->o_list, &head);
+	raw_spin_unlock_irq(&wq->o_lock);
+
+	/*
+	 * Requeue the first batch of work items. Since it may take a while
+	 * to drain the old pwq and update the workqueue attributes, there
+	 * may be a rather long list of work items to process. So we allow
+	 * queue_work() callers to continue putting their work items in o_list.
+	 */
+	list_for_each_entry_safe(work, next, &head, entry) {
+		list_del_init(&work->entry);
+		local_irq_disable();
+		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
+		local_irq_enable();
+	}
+
+	/*
+	 * Now check if there are more work items queued, if so set ORD_WAIT
+	 * and force incoming queue_work() callers to busy wait until the 2nd
+	 * batch of work items have been properly requeued. It is assumed
+	 * that the 2nd batch should be much smaller.
+	 */
+	raw_spin_lock_irq(&wq->o_lock);
+	if (list_empty(&wq->o_list))
+		goto unlock_out;
+	WRITE_ONCE(wq->o_state, ORD_WAIT);
+	list_splice_init(&wq->o_list, &head);
+	raw_spin_unlock(&wq->o_lock);	/* Leave interrupt disabled */
+	list_for_each_entry_safe(work, next, &head, entry) {
+		list_del_init(&work->entry);
+		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
+	}
+	WRITE_ONCE(wq->o_state, ORD_NORMAL);
+	local_irq_enable();
+	return;
+
+unlock_out:
+	WRITE_ONCE(wq->o_state, ORD_NORMAL);
+	raw_spin_unlock_irq(&wq->o_lock);
+}
+
 /*
  * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
  * refcnt and needs to be destroyed.
@@ -4123,6 +4239,9 @@ static void pwq_release_workfn(struct kthread_work *work)
 	 * When @pwq is not linked, it doesn't hold any reference to the
 	 * @wq, and @wq is invalid to access.
 	 */
+	if (READ_ONCE(wq->o_state) && !WARN_ON_ONCE(list_empty(&pwq->pwqs_node)))
+		requeue_ordered_works(wq);
+
 	if (!list_empty(&pwq->pwqs_node)) {
 		mutex_lock(&wq->mutex);
 		list_del_rcu(&pwq->pwqs_node);
@@ -4389,6 +4508,17 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
 
+	/*
+	 * For initialized ordered workqueues, start the pwq transition
+	 * sequence of setting o_state to ORD_QUEUE and wait until there
+	 * is no outstanding queue_work() caller in progress.
+	 */
+	if (!list_empty(&wq->pwqs) && (wq->flags & __WQ_ORDERED_EXPLICIT)) {
+		smp_store_mb(wq->o_state, ORD_QUEUE);
+		while (atomic_read(&wq->o_nr_qw))
+			cpu_relax();
+	}
+
 	ctx->wq = wq;
 	return ctx;
 
@@ -4429,13 +4559,8 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	if (WARN_ON(!(wq->flags & WQ_UNBOUND)))
 		return -EINVAL;
 
-	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
+	if (!list_empty(&wq->pwqs) && !(wq->flags & __WQ_ORDERED_EXPLICIT))
 		wq->flags &= ~__WQ_ORDERED;
-	}
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
@@ -4713,6 +4838,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->flusher_queue);
 	INIT_LIST_HEAD(&wq->flusher_overflow);
 	INIT_LIST_HEAD(&wq->maydays);
+	INIT_LIST_HEAD(&wq->o_list);
+	atomic_set(&wq->o_nr_qw, 0);
+	raw_spin_lock_init(&wq->o_lock);
 
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
@@ -5793,11 +5921,27 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
 
-		/* creating multiple pwqs breaks ordering guarantee */
+		/*
+		 * We does not support changing attrs of ordered workqueue
+		 * again before the previous attrs change is completed.
+		 * Sleep up to 100ms in 10ms interval to allow previous
+		 * operation to complete and skip it if not done by then.
+		 */
 		if (!list_empty(&wq->pwqs)) {
-			if (wq->flags & __WQ_ORDERED_EXPLICIT)
-				continue;
-			wq->flags &= ~__WQ_ORDERED;
+			if (!(wq->flags & __WQ_ORDERED_EXPLICIT))
+				wq->flags &= ~__WQ_ORDERED;
+			else if (READ_ONCE(wq->o_state)) {
+				int i, ostate;
+
+				for (i = 0; i < 10; i++) {
+					msleep(10);
+					ostate = READ_ONCE(wq->o_state);
+					if (!ostate)
+						break;
+				}
+				if (WARN_ON_ONCE(ostate))
+					continue;
+			}
 		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
@@ -6313,9 +6457,8 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	int ret;
 
 	/*
-	 * Adjusting max_active or creating new pwqs by applying
-	 * attributes breaks ordering guarantee.  Disallow exposing ordered
-	 * workqueues.
+	 * Adjusting max_active breaks ordering guarantee.  Disallow exposing
+	 * ordered workqueues.
 	 */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return -EINVAL;
-- 
2.39.3


