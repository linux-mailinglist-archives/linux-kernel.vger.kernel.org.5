Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1340E7B1679
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjI1Ixv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjI1Ixt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:53:49 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7713A;
        Thu, 28 Sep 2023 01:53:43 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Rx6fF2mMqzB0R6w;
        Thu, 28 Sep 2023 16:51:33 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 28 Sep
 2023 16:53:38 +0800
Date:   Thu, 28 Sep 2023 16:53:38 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [RFC/REFACT] Refactoring and significantly reducing code complexity
Message-ID: <ZRU/EjubEH/5QLlG@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refactored version with the following main changes:

- The parallel workqueue no longer uses the WQ_UNBOUND attribute
- Removal of CPU-related logic, sysfs-related interfaces
- removal of structures like padata_cpumask, and deletion of parallel_data
- Using completion to maintain sequencing
- no longer using lists
- removing structures like padata_list and padata_serial_queue
- Removal of padata_do_serial()
- padata automatically ensures the calling sequence.

Testing was conducted using ltp's pcrypt_aead01, and the execution time
comparison between the old and new versions is as follows:

Old Version:
real 0m27.451s
user 0m0.031s
sys 0m0.260s

New Version:
real 0m21.351s
user 0m0.023s
sys 0m0.260s

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 crypto/pcrypt.c        |  34 +-
 include/linux/padata.h |  95 +----
 kernel/padata.c        | 815 ++---------------------------------------
 3 files changed, 43 insertions(+), 901 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 8c1d0ca41213..db9a36c35229 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -70,8 +70,6 @@ static void pcrypt_aead_done(void *data, int err)
 	struct padata_priv *padata = pcrypt_request_padata(preq);
 
 	padata->info = err;
-
-	padata_do_serial(padata);
 }
 
 static void pcrypt_aead_enc(struct padata_priv *padata)
@@ -86,7 +84,6 @@ static void pcrypt_aead_enc(struct padata_priv *padata)
 		return;
 
 	padata->info = ret;
-	padata_do_serial(padata);
 }
 
 static int pcrypt_aead_encrypt(struct aead_request *req)
@@ -114,7 +111,7 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 			       req->cryptlen, req->iv);
 	aead_request_set_ad(creq, req->assoclen);
 
-	err = padata_do_parallel(ictx->psenc, padata, &ctx->cb_cpu);
+	err = padata_do_parallel(ictx->psenc, padata);
 	if (!err)
 		return -EINPROGRESS;
 
@@ -133,7 +130,6 @@ static void pcrypt_aead_dec(struct padata_priv *padata)
 		return;
 
 	padata->info = ret;
-	padata_do_serial(padata);
 }
 
 static int pcrypt_aead_decrypt(struct aead_request *req)
@@ -161,7 +157,7 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 			       req->cryptlen, req->iv);
 	aead_request_set_ad(creq, req->assoclen);
 
-	err = padata_do_parallel(ictx->psdec, padata, &ctx->cb_cpu);
+	err = padata_do_parallel(ictx->psdec, padata);
 	if (!err)
 		return -EINPROGRESS;
 
@@ -304,31 +300,18 @@ static int pcrypt_create(struct crypto_template *tmpl, struct rtattr **tb)
 	return -EINVAL;
 }
 
-static int pcrypt_sysfs_add(struct padata_instance *pinst, const char *name)
-{
-	int ret;
-
-	pinst->kobj.kset = pcrypt_kset;
-	ret = kobject_add(&pinst->kobj, NULL, "%s", name);
-	if (!ret)
-		kobject_uevent(&pinst->kobj, KOBJ_ADD);
-
-	return ret;
-}
-
 static int pcrypt_init_padata(struct padata_instance **pinst, const char *name)
 {
 	int ret = -ENOMEM;
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
 
 	*pinst = padata_alloc(name);
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
+	pr_info("%s:%d %s *pinst=%p\n", __FILE__, __LINE__, __func__, *pinst);
+
 	if (!*pinst)
 		return ret;
-
-	ret = pcrypt_sysfs_add(*pinst, name);
-	if (ret)
-		padata_free(*pinst);
-
-	return ret;
+	return 0;
 }
 
 static struct crypto_template pcrypt_tmpl = {
@@ -344,15 +327,18 @@ static int __init pcrypt_init(void)
 	pcrypt_kset = kset_create_and_add("pcrypt", NULL, kernel_kobj);
 	if (!pcrypt_kset)
 		goto err;
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
 
 	err = pcrypt_init_padata(&pencrypt, "pencrypt");
 	if (err)
 		goto err_unreg_kset;
 
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
 	err = pcrypt_init_padata(&pdecrypt, "pdecrypt");
 	if (err)
 		goto err_deinit_pencrypt;
 
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
 	return crypto_register_template(&pcrypt_tmpl);
 
 err_deinit_pencrypt:
diff --git a/include/linux/padata.h b/include/linux/padata.h
index 495b16b6b4d7..ed880ef155c2 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -19,107 +19,36 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 
-#define PADATA_CPU_SERIAL   0x01
-#define PADATA_CPU_PARALLEL 0x02
 
 /**
  * struct padata_priv - Represents one job
  *
- * @list: List entry, to attach to the padata lists.
- * @pd: Pointer to the internal control structure.
- * @cb_cpu: Callback cpu for serializatioon.
- * @seq_nr: Sequence number of the parallelized data object.
  * @info: Used to pass information from the parallel to the serial function.
+ * @parallel_done: completetion of parallel_work.
+ * @parallel_work: Parallel work.
+ * @serial_work: Serial work.
  * @parallel: Parallel execution function.
  * @serial: Serial complete function.
  */
 struct padata_priv {
-	struct list_head	list;
-	struct parallel_data	*pd;
-	int			cb_cpu;
-	unsigned int		seq_nr;
 	int			info;
+	struct completion parallel_done;
+	struct work_struct	parallel_work;
+	struct work_struct	serial_work;
 	void                    (*parallel)(struct padata_priv *padata);
 	void                    (*serial)(struct padata_priv *padata);
 };
 
-/**
- * struct padata_list - one per work type per CPU
- *
- * @list: List head.
- * @lock: List lock.
- */
-struct padata_list {
-	struct list_head        list;
-	spinlock_t              lock;
-};
-
-/**
-* struct padata_serial_queue - The percpu padata serial queue
-*
-* @serial: List to wait for serialization after reordering.
-* @work: work struct for serialization.
-* @pd: Backpointer to the internal control structure.
-*/
-struct padata_serial_queue {
-       struct padata_list    serial;
-       struct work_struct    work;
-       struct parallel_data *pd;
-};
-
-/**
- * struct padata_cpumask - The cpumasks for the parallel/serial workers
- *
- * @pcpu: cpumask for the parallel workers.
- * @cbcpu: cpumask for the serial (callback) workers.
- */
-struct padata_cpumask {
-	cpumask_var_t	pcpu;
-	cpumask_var_t	cbcpu;
-};
-
-/**
- * struct parallel_data - Internal control structure, covers everything
- * that depends on the cpumask in use.
- *
- * @ps: padata_shell object.
- * @reorder_list: percpu reorder lists
- * @squeue: percpu padata queues used for serialuzation.
- * @refcnt: Number of objects holding a reference on this parallel_data.
- * @seq_nr: Sequence number of the parallelized data object.
- * @processed: Number of already processed objects.
- * @cpu: Next CPU to be processed.
- * @cpumask: The cpumasks in use for parallel and serial workers.
- * @reorder_work: work struct for reordering.
- * @lock: Reorder lock.
- */
-struct parallel_data {
-	struct padata_shell		*ps;
-	struct padata_list		__percpu *reorder_list;
-	struct padata_serial_queue	__percpu *squeue;
-	refcount_t			refcnt;
-	unsigned int			seq_nr;
-	unsigned int			processed;
-	int				cpu;
-	struct padata_cpumask		cpumask;
-	struct work_struct		reorder_work;
-	spinlock_t                      ____cacheline_aligned lock;
-};
-
 /**
  * struct padata_shell - Wrapper around struct parallel_data, its
  * purpose is to allow the underlying control structure to be replaced
  * on the fly using RCU.
  *
  * @pinst: padat instance.
- * @pd: Actual parallel_data structure which may be substituted on the fly.
- * @opd: Pointer to old pd to be freed by padata_replace.
  * @list: List entry in padata_instance list.
  */
 struct padata_shell {
 	struct padata_instance		*pinst;
-	struct parallel_data __rcu	*pd;
-	struct parallel_data		*opd;
 	struct list_head		list;
 };
 
@@ -151,24 +80,17 @@ struct padata_mt_job {
 /**
  * struct padata_instance - The overall control structure.
  *
- * @cpu_online_node: Linkage for CPU online callback.
- * @cpu_dead_node: Linkage for CPU offline callback.
  * @parallel_wq: The workqueue used for parallel work.
  * @serial_wq: The workqueue used for serial work.
  * @pslist: List of padata_shell objects attached to this instance.
- * @cpumask: User supplied cpumasks for parallel and serial works.
  * @kobj: padata instance kernel object.
  * @lock: padata instance lock.
  * @flags: padata flags.
  */
 struct padata_instance {
-	struct hlist_node		cpu_online_node;
-	struct hlist_node		cpu_dead_node;
 	struct workqueue_struct		*parallel_wq;
 	struct workqueue_struct		*serial_wq;
 	struct list_head		pslist;
-	struct padata_cpumask		cpumask;
-	struct kobject                   kobj;
 	struct mutex			 lock;
 	u8				 flags;
 #define	PADATA_INIT	1
@@ -187,9 +109,6 @@ extern void padata_free(struct padata_instance *pinst);
 extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
 extern void padata_free_shell(struct padata_shell *ps);
 extern int padata_do_parallel(struct padata_shell *ps,
-			      struct padata_priv *padata, int *cb_cpu);
-extern void padata_do_serial(struct padata_priv *padata);
+			      struct padata_priv *padata);
 extern void __init padata_do_multithreaded(struct padata_mt_job *job);
-extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
-			      cpumask_var_t cpumask);
 #endif
diff --git a/kernel/padata.c b/kernel/padata.c
index 222d60195de6..ec80e2b9556d 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -13,9 +13,7 @@
 
 #include <linux/completion.h>
 #include <linux/export.h>
-#include <linux/cpumask.h>
 #include <linux/err.h>
-#include <linux/cpu.h>
 #include <linux/padata.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
@@ -44,31 +42,8 @@ struct padata_mt_job_state {
 	unsigned long		chunk_size;
 };
 
-static void padata_free_pd(struct parallel_data *pd);
 static void __init padata_mt_helper(struct work_struct *work);
 
-static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
-{
-	int cpu, target_cpu;
-
-	target_cpu = cpumask_first(pd->cpumask.pcpu);
-	for (cpu = 0; cpu < cpu_index; cpu++)
-		target_cpu = cpumask_next(target_cpu, pd->cpumask.pcpu);
-
-	return target_cpu;
-}
-
-static int padata_cpu_hash(struct parallel_data *pd, unsigned int seq_nr)
-{
-	/*
-	 * Hash the sequence numbers to the cpus by taking
-	 * seq_nr mod. number of cpus in use.
-	 */
-	int cpu_index = seq_nr % cpumask_weight(pd->cpumask.pcpu);
-
-	return padata_index_to_cpu(pd, cpu_index);
-}
-
 static struct padata_work *padata_work_alloc(void)
 {
 	struct padata_work *pw;
@@ -144,27 +119,18 @@ static void __init padata_works_free(struct list_head *works)
 
 static void padata_parallel_worker(struct work_struct *parallel_work)
 {
-	struct padata_work *pw = container_of(parallel_work, struct padata_work,
-					      pw_work);
-	struct padata_priv *padata = pw->pw_data;
-
-	local_bh_disable();
+	struct padata_priv *padata = container_of(parallel_work, struct padata_priv, parallel_work);						  
 	padata->parallel(padata);
-	spin_lock(&padata_works_lock);
-	padata_work_free(pw);
-	spin_unlock(&padata_works_lock);
-	local_bh_enable();
+	complete(&padata->parallel_done);
 }
 
+static void padata_serial_worker(struct work_struct *serial_work);
+
 /**
  * padata_do_parallel - padata parallelization function
  *
  * @ps: padatashell
  * @padata: object to be parallelized
- * @cb_cpu: pointer to the CPU that the serialization callback function should
- *          run on.  If it's not in the serial cpumask of @pinst
- *          (i.e. cpumask.cbcpu), this function selects a fallback CPU and if
- *          none found, returns -EINVAL.
  *
  * The parallelization callback function will run with BHs off.
  * Note: Every object which is parallelized by padata_do_parallel
@@ -173,269 +139,36 @@ static void padata_parallel_worker(struct work_struct *parallel_work)
  * Return: 0 on success or else negative error code.
  */
 int padata_do_parallel(struct padata_shell *ps,
-		       struct padata_priv *padata, int *cb_cpu)
+		       struct padata_priv *padata)
 {
 	struct padata_instance *pinst = ps->pinst;
-	int i, cpu, cpu_index, err;
-	struct parallel_data *pd;
-	struct padata_work *pw;
-
-	rcu_read_lock_bh();
-
-	pd = rcu_dereference_bh(ps->pd);
+	int err;
 
 	err = -EINVAL;
 	if (!(pinst->flags & PADATA_INIT) || pinst->flags & PADATA_INVALID)
 		goto out;
 
-	if (!cpumask_test_cpu(*cb_cpu, pd->cpumask.cbcpu)) {
-		if (cpumask_empty(pd->cpumask.cbcpu))
-			goto out;
-
-		/* Select an alternate fallback CPU and notify the caller. */
-		cpu_index = *cb_cpu % cpumask_weight(pd->cpumask.cbcpu);
-
-		cpu = cpumask_first(pd->cpumask.cbcpu);
-		for (i = 0; i < cpu_index; i++)
-			cpu = cpumask_next(cpu, pd->cpumask.cbcpu);
-
-		*cb_cpu = cpu;
-	}
-
 	err =  -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	refcount_inc(&pd->refcnt);
-	padata->pd = pd;
-	padata->cb_cpu = *cb_cpu;
-
-	spin_lock(&padata_works_lock);
-	padata->seq_nr = ++pd->seq_nr;
-	pw = padata_work_alloc();
-	spin_unlock(&padata_works_lock);
-
-	if (!pw) {
-		/* Maximum works limit exceeded, run in the current task. */
-		padata->parallel(padata);
-	}
-
-	rcu_read_unlock_bh();
-
-	if (pw) {
-		padata_work_init(pw, padata_parallel_worker, padata, 0);
-		queue_work(pinst->parallel_wq, &pw->pw_work);
-	}
+	INIT_WORK(&padata->parallel_work, padata_parallel_worker);
+	INIT_WORK(&padata->serial_work, padata_serial_worker);
+	init_completion(&padata->parallel_done);
+	queue_work(pinst->serial_wq, &padata->serial_work);
+	queue_work(pinst->parallel_wq, &padata->parallel_work);
 
 	return 0;
 out:
-	rcu_read_unlock_bh();
-
 	return err;
 }
 EXPORT_SYMBOL(padata_do_parallel);
 
-/*
- * padata_find_next - Find the next object that needs serialization.
- *
- * Return:
- * * A pointer to the control struct of the next object that needs
- *   serialization, if present in one of the percpu reorder queues.
- * * NULL, if the next object that needs serialization will
- *   be parallel processed by another cpu and is not yet present in
- *   the cpu's reorder queue.
- */
-static struct padata_priv *padata_find_next(struct parallel_data *pd,
-					    bool remove_object)
-{
-	struct padata_priv *padata;
-	struct padata_list *reorder;
-	int cpu = pd->cpu;
-
-	reorder = per_cpu_ptr(pd->reorder_list, cpu);
-
-	spin_lock(&reorder->lock);
-	if (list_empty(&reorder->list)) {
-		spin_unlock(&reorder->lock);
-		return NULL;
-	}
-
-	padata = list_entry(reorder->list.next, struct padata_priv, list);
-
-	/*
-	 * Checks the rare case where two or more parallel jobs have hashed to
-	 * the same CPU and one of the later ones finishes first.
-	 */
-	if (padata->seq_nr != pd->processed) {
-		spin_unlock(&reorder->lock);
-		return NULL;
-	}
-
-	if (remove_object) {
-		list_del_init(&padata->list);
-		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
-	}
-
-	spin_unlock(&reorder->lock);
-	return padata;
-}
-
-static void padata_reorder(struct parallel_data *pd)
-{
-	struct padata_instance *pinst = pd->ps->pinst;
-	int cb_cpu;
-	struct padata_priv *padata;
-	struct padata_serial_queue *squeue;
-	struct padata_list *reorder;
-
-	/*
-	 * We need to ensure that only one cpu can work on dequeueing of
-	 * the reorder queue the time. Calculating in which percpu reorder
-	 * queue the next object will arrive takes some time. A spinlock
-	 * would be highly contended. Also it is not clear in which order
-	 * the objects arrive to the reorder queues. So a cpu could wait to
-	 * get the lock just to notice that there is nothing to do at the
-	 * moment. Therefore we use a trylock and let the holder of the lock
-	 * care for all the objects enqueued during the holdtime of the lock.
-	 */
-	if (!spin_trylock_bh(&pd->lock))
-		return;
-
-	while (1) {
-		padata = padata_find_next(pd, true);
-
-		/*
-		 * If the next object that needs serialization is parallel
-		 * processed by another cpu and is still on it's way to the
-		 * cpu's reorder queue, nothing to do for now.
-		 */
-		if (!padata)
-			break;
-
-		cb_cpu = padata->cb_cpu;
-		squeue = per_cpu_ptr(pd->squeue, cb_cpu);
-
-		spin_lock(&squeue->serial.lock);
-		list_add_tail(&padata->list, &squeue->serial.list);
-		spin_unlock(&squeue->serial.lock);
-
-		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
-	}
-
-	spin_unlock_bh(&pd->lock);
-
-	/*
-	 * The next object that needs serialization might have arrived to
-	 * the reorder queues in the meantime.
-	 *
-	 * Ensure reorder queue is read after pd->lock is dropped so we see
-	 * new objects from another task in padata_do_serial.  Pairs with
-	 * smp_mb in padata_do_serial.
-	 */
-	smp_mb();
-
-	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
-	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
-		queue_work(pinst->serial_wq, &pd->reorder_work);
-}
-
-static void invoke_padata_reorder(struct work_struct *work)
-{
-	struct parallel_data *pd;
-
-	local_bh_disable();
-	pd = container_of(work, struct parallel_data, reorder_work);
-	padata_reorder(pd);
-	local_bh_enable();
-}
-
 static void padata_serial_worker(struct work_struct *serial_work)
 {
-	struct padata_serial_queue *squeue;
-	struct parallel_data *pd;
-	LIST_HEAD(local_list);
-	int cnt;
-
-	local_bh_disable();
-	squeue = container_of(serial_work, struct padata_serial_queue, work);
-	pd = squeue->pd;
-
-	spin_lock(&squeue->serial.lock);
-	list_replace_init(&squeue->serial.list, &local_list);
-	spin_unlock(&squeue->serial.lock);
-
-	cnt = 0;
-
-	while (!list_empty(&local_list)) {
-		struct padata_priv *padata;
-
-		padata = list_entry(local_list.next,
-				    struct padata_priv, list);
-
-		list_del_init(&padata->list);
-
-		padata->serial(padata);
-		cnt++;
-	}
-	local_bh_enable();
-
-	if (refcount_sub_and_test(cnt, &pd->refcnt))
-		padata_free_pd(pd);
-}
-
-/**
- * padata_do_serial - padata serialization function
- *
- * @padata: object to be serialized.
- *
- * padata_do_serial must be called for every parallelized object.
- * The serialization callback function will run with BHs off.
- */
-void padata_do_serial(struct padata_priv *padata)
-{
-	struct parallel_data *pd = padata->pd;
-	int hashed_cpu = padata_cpu_hash(pd, padata->seq_nr);
-	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
-	struct padata_priv *cur;
-	struct list_head *pos;
-
-	spin_lock(&reorder->lock);
-	/* Sort in ascending order of sequence number. */
-	list_for_each_prev(pos, &reorder->list) {
-		cur = list_entry(pos, struct padata_priv, list);
-		if (cur->seq_nr < padata->seq_nr)
-			break;
-	}
-	list_add(&padata->list, pos);
-	spin_unlock(&reorder->lock);
-
-	/*
-	 * Ensure the addition to the reorder list is ordered correctly
-	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
-	 * in padata_reorder.
-	 */
-	smp_mb();
-
-	padata_reorder(pd);
-}
-EXPORT_SYMBOL(padata_do_serial);
-
-static int padata_setup_cpumasks(struct padata_instance *pinst)
-{
-	struct workqueue_attrs *attrs;
-	int err;
-
-	attrs = alloc_workqueue_attrs();
-	if (!attrs)
-		return -ENOMEM;
-
-	/* Restrict parallel_wq workers to pd->cpumask.pcpu. */
-	cpumask_copy(attrs->cpumask, pinst->cpumask.pcpu);
-	err = apply_workqueue_attrs(pinst->parallel_wq, attrs);
-	free_workqueue_attrs(attrs);
-
-	return err;
+	struct padata_priv *padata = container_of(serial_work, struct padata_priv, serial_work);
+	wait_for_completion(&padata->parallel_done);
+	padata->serial(padata);
 }
 
 static void __init padata_mt_helper(struct work_struct *w)
@@ -530,449 +263,11 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	padata_works_free(&works);
 }
 
-static void __padata_list_init(struct padata_list *pd_list)
-{
-	INIT_LIST_HEAD(&pd_list->list);
-	spin_lock_init(&pd_list->lock);
-}
-
-/* Initialize all percpu queues used by serial workers */
-static void padata_init_squeues(struct parallel_data *pd)
-{
-	int cpu;
-	struct padata_serial_queue *squeue;
-
-	for_each_cpu(cpu, pd->cpumask.cbcpu) {
-		squeue = per_cpu_ptr(pd->squeue, cpu);
-		squeue->pd = pd;
-		__padata_list_init(&squeue->serial);
-		INIT_WORK(&squeue->work, padata_serial_worker);
-	}
-}
-
-/* Initialize per-CPU reorder lists */
-static void padata_init_reorder_list(struct parallel_data *pd)
-{
-	int cpu;
-	struct padata_list *list;
-
-	for_each_cpu(cpu, pd->cpumask.pcpu) {
-		list = per_cpu_ptr(pd->reorder_list, cpu);
-		__padata_list_init(list);
-	}
-}
-
-/* Allocate and initialize the internal cpumask dependend resources. */
-static struct parallel_data *padata_alloc_pd(struct padata_shell *ps)
-{
-	struct padata_instance *pinst = ps->pinst;
-	struct parallel_data *pd;
-
-	pd = kzalloc(sizeof(struct parallel_data), GFP_KERNEL);
-	if (!pd)
-		goto err;
-
-	pd->reorder_list = alloc_percpu(struct padata_list);
-	if (!pd->reorder_list)
-		goto err_free_pd;
-
-	pd->squeue = alloc_percpu(struct padata_serial_queue);
-	if (!pd->squeue)
-		goto err_free_reorder_list;
-
-	pd->ps = ps;
-
-	if (!alloc_cpumask_var(&pd->cpumask.pcpu, GFP_KERNEL))
-		goto err_free_squeue;
-	if (!alloc_cpumask_var(&pd->cpumask.cbcpu, GFP_KERNEL))
-		goto err_free_pcpu;
-
-	cpumask_and(pd->cpumask.pcpu, pinst->cpumask.pcpu, cpu_online_mask);
-	cpumask_and(pd->cpumask.cbcpu, pinst->cpumask.cbcpu, cpu_online_mask);
-
-	padata_init_reorder_list(pd);
-	padata_init_squeues(pd);
-	pd->seq_nr = -1;
-	refcount_set(&pd->refcnt, 1);
-	spin_lock_init(&pd->lock);
-	pd->cpu = cpumask_first(pd->cpumask.pcpu);
-	INIT_WORK(&pd->reorder_work, invoke_padata_reorder);
-
-	return pd;
-
-err_free_pcpu:
-	free_cpumask_var(pd->cpumask.pcpu);
-err_free_squeue:
-	free_percpu(pd->squeue);
-err_free_reorder_list:
-	free_percpu(pd->reorder_list);
-err_free_pd:
-	kfree(pd);
-err:
-	return NULL;
-}
-
-static void padata_free_pd(struct parallel_data *pd)
-{
-	free_cpumask_var(pd->cpumask.pcpu);
-	free_cpumask_var(pd->cpumask.cbcpu);
-	free_percpu(pd->reorder_list);
-	free_percpu(pd->squeue);
-	kfree(pd);
-}
-
 static void __padata_start(struct padata_instance *pinst)
 {
 	pinst->flags |= PADATA_INIT;
 }
 
-static void __padata_stop(struct padata_instance *pinst)
-{
-	if (!(pinst->flags & PADATA_INIT))
-		return;
-
-	pinst->flags &= ~PADATA_INIT;
-
-	synchronize_rcu();
-}
-
-/* Replace the internal control structure with a new one. */
-static int padata_replace_one(struct padata_shell *ps)
-{
-	struct parallel_data *pd_new;
-
-	pd_new = padata_alloc_pd(ps);
-	if (!pd_new)
-		return -ENOMEM;
-
-	ps->opd = rcu_dereference_protected(ps->pd, 1);
-	rcu_assign_pointer(ps->pd, pd_new);
-
-	return 0;
-}
-
-static int padata_replace(struct padata_instance *pinst)
-{
-	struct padata_shell *ps;
-	int err = 0;
-
-	pinst->flags |= PADATA_RESET;
-
-	list_for_each_entry(ps, &pinst->pslist, list) {
-		err = padata_replace_one(ps);
-		if (err)
-			break;
-	}
-
-	synchronize_rcu();
-
-	list_for_each_entry_continue_reverse(ps, &pinst->pslist, list)
-		if (refcount_dec_and_test(&ps->opd->refcnt))
-			padata_free_pd(ps->opd);
-
-	pinst->flags &= ~PADATA_RESET;
-
-	return err;
-}
-
-/* If cpumask contains no active cpu, we mark the instance as invalid. */
-static bool padata_validate_cpumask(struct padata_instance *pinst,
-				    const struct cpumask *cpumask)
-{
-	if (!cpumask_intersects(cpumask, cpu_online_mask)) {
-		pinst->flags |= PADATA_INVALID;
-		return false;
-	}
-
-	pinst->flags &= ~PADATA_INVALID;
-	return true;
-}
-
-static int __padata_set_cpumasks(struct padata_instance *pinst,
-				 cpumask_var_t pcpumask,
-				 cpumask_var_t cbcpumask)
-{
-	int valid;
-	int err;
-
-	valid = padata_validate_cpumask(pinst, pcpumask);
-	if (!valid) {
-		__padata_stop(pinst);
-		goto out_replace;
-	}
-
-	valid = padata_validate_cpumask(pinst, cbcpumask);
-	if (!valid)
-		__padata_stop(pinst);
-
-out_replace:
-	cpumask_copy(pinst->cpumask.pcpu, pcpumask);
-	cpumask_copy(pinst->cpumask.cbcpu, cbcpumask);
-
-	err = padata_setup_cpumasks(pinst) ?: padata_replace(pinst);
-
-	if (valid)
-		__padata_start(pinst);
-
-	return err;
-}
-
-/**
- * padata_set_cpumask - Sets specified by @cpumask_type cpumask to the value
- *                      equivalent to @cpumask.
- * @pinst: padata instance
- * @cpumask_type: PADATA_CPU_SERIAL or PADATA_CPU_PARALLEL corresponding
- *                to parallel and serial cpumasks respectively.
- * @cpumask: the cpumask to use
- *
- * Return: 0 on success or negative error code
- */
-int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
-		       cpumask_var_t cpumask)
-{
-	struct cpumask *serial_mask, *parallel_mask;
-	int err = -EINVAL;
-
-	cpus_read_lock();
-	mutex_lock(&pinst->lock);
-
-	switch (cpumask_type) {
-	case PADATA_CPU_PARALLEL:
-		serial_mask = pinst->cpumask.cbcpu;
-		parallel_mask = cpumask;
-		break;
-	case PADATA_CPU_SERIAL:
-		parallel_mask = pinst->cpumask.pcpu;
-		serial_mask = cpumask;
-		break;
-	default:
-		 goto out;
-	}
-
-	err =  __padata_set_cpumasks(pinst, parallel_mask, serial_mask);
-
-out:
-	mutex_unlock(&pinst->lock);
-	cpus_read_unlock();
-
-	return err;
-}
-EXPORT_SYMBOL(padata_set_cpumask);
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-static int __padata_add_cpu(struct padata_instance *pinst, int cpu)
-{
-	int err = 0;
-
-	if (cpumask_test_cpu(cpu, cpu_online_mask)) {
-		err = padata_replace(pinst);
-
-		if (padata_validate_cpumask(pinst, pinst->cpumask.pcpu) &&
-		    padata_validate_cpumask(pinst, pinst->cpumask.cbcpu))
-			__padata_start(pinst);
-	}
-
-	return err;
-}
-
-static int __padata_remove_cpu(struct padata_instance *pinst, int cpu)
-{
-	int err = 0;
-
-	if (!cpumask_test_cpu(cpu, cpu_online_mask)) {
-		if (!padata_validate_cpumask(pinst, pinst->cpumask.pcpu) ||
-		    !padata_validate_cpumask(pinst, pinst->cpumask.cbcpu))
-			__padata_stop(pinst);
-
-		err = padata_replace(pinst);
-	}
-
-	return err;
-}
-
-static inline int pinst_has_cpu(struct padata_instance *pinst, int cpu)
-{
-	return cpumask_test_cpu(cpu, pinst->cpumask.pcpu) ||
-		cpumask_test_cpu(cpu, pinst->cpumask.cbcpu);
-}
-
-static int padata_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct padata_instance *pinst;
-	int ret;
-
-	pinst = hlist_entry_safe(node, struct padata_instance, cpu_online_node);
-	if (!pinst_has_cpu(pinst, cpu))
-		return 0;
-
-	mutex_lock(&pinst->lock);
-	ret = __padata_add_cpu(pinst, cpu);
-	mutex_unlock(&pinst->lock);
-	return ret;
-}
-
-static int padata_cpu_dead(unsigned int cpu, struct hlist_node *node)
-{
-	struct padata_instance *pinst;
-	int ret;
-
-	pinst = hlist_entry_safe(node, struct padata_instance, cpu_dead_node);
-	if (!pinst_has_cpu(pinst, cpu))
-		return 0;
-
-	mutex_lock(&pinst->lock);
-	ret = __padata_remove_cpu(pinst, cpu);
-	mutex_unlock(&pinst->lock);
-	return ret;
-}
-
-static enum cpuhp_state hp_online;
-#endif
-
-static void __padata_free(struct padata_instance *pinst)
-{
-#ifdef CONFIG_HOTPLUG_CPU
-	cpuhp_state_remove_instance_nocalls(CPUHP_PADATA_DEAD,
-					    &pinst->cpu_dead_node);
-	cpuhp_state_remove_instance_nocalls(hp_online, &pinst->cpu_online_node);
-#endif
-
-	WARN_ON(!list_empty(&pinst->pslist));
-
-	free_cpumask_var(pinst->cpumask.pcpu);
-	free_cpumask_var(pinst->cpumask.cbcpu);
-	destroy_workqueue(pinst->serial_wq);
-	destroy_workqueue(pinst->parallel_wq);
-	kfree(pinst);
-}
-
-#define kobj2pinst(_kobj)					\
-	container_of(_kobj, struct padata_instance, kobj)
-#define attr2pentry(_attr)					\
-	container_of(_attr, struct padata_sysfs_entry, attr)
-
-static void padata_sysfs_release(struct kobject *kobj)
-{
-	struct padata_instance *pinst = kobj2pinst(kobj);
-	__padata_free(pinst);
-}
-
-struct padata_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct padata_instance *, struct attribute *, char *);
-	ssize_t (*store)(struct padata_instance *, struct attribute *,
-			 const char *, size_t);
-};
-
-static ssize_t show_cpumask(struct padata_instance *pinst,
-			    struct attribute *attr,  char *buf)
-{
-	struct cpumask *cpumask;
-	ssize_t len;
-
-	mutex_lock(&pinst->lock);
-	if (!strcmp(attr->name, "serial_cpumask"))
-		cpumask = pinst->cpumask.cbcpu;
-	else
-		cpumask = pinst->cpumask.pcpu;
-
-	len = snprintf(buf, PAGE_SIZE, "%*pb\n",
-		       nr_cpu_ids, cpumask_bits(cpumask));
-	mutex_unlock(&pinst->lock);
-	return len < PAGE_SIZE ? len : -EINVAL;
-}
-
-static ssize_t store_cpumask(struct padata_instance *pinst,
-			     struct attribute *attr,
-			     const char *buf, size_t count)
-{
-	cpumask_var_t new_cpumask;
-	ssize_t ret;
-	int mask_type;
-
-	if (!alloc_cpumask_var(&new_cpumask, GFP_KERNEL))
-		return -ENOMEM;
-
-	ret = bitmap_parse(buf, count, cpumask_bits(new_cpumask),
-			   nr_cpumask_bits);
-	if (ret < 0)
-		goto out;
-
-	mask_type = !strcmp(attr->name, "serial_cpumask") ?
-		PADATA_CPU_SERIAL : PADATA_CPU_PARALLEL;
-	ret = padata_set_cpumask(pinst, mask_type, new_cpumask);
-	if (!ret)
-		ret = count;
-
-out:
-	free_cpumask_var(new_cpumask);
-	return ret;
-}
-
-#define PADATA_ATTR_RW(_name, _show_name, _store_name)		\
-	static struct padata_sysfs_entry _name##_attr =		\
-		__ATTR(_name, 0644, _show_name, _store_name)
-#define PADATA_ATTR_RO(_name, _show_name)		\
-	static struct padata_sysfs_entry _name##_attr = \
-		__ATTR(_name, 0400, _show_name, NULL)
-
-PADATA_ATTR_RW(serial_cpumask, show_cpumask, store_cpumask);
-PADATA_ATTR_RW(parallel_cpumask, show_cpumask, store_cpumask);
-
-/*
- * Padata sysfs provides the following objects:
- * serial_cpumask   [RW] - cpumask for serial workers
- * parallel_cpumask [RW] - cpumask for parallel workers
- */
-static struct attribute *padata_default_attrs[] = {
-	&serial_cpumask_attr.attr,
-	&parallel_cpumask_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(padata_default);
-
-static ssize_t padata_sysfs_show(struct kobject *kobj,
-				 struct attribute *attr, char *buf)
-{
-	struct padata_instance *pinst;
-	struct padata_sysfs_entry *pentry;
-	ssize_t ret = -EIO;
-
-	pinst = kobj2pinst(kobj);
-	pentry = attr2pentry(attr);
-	if (pentry->show)
-		ret = pentry->show(pinst, attr, buf);
-
-	return ret;
-}
-
-static ssize_t padata_sysfs_store(struct kobject *kobj, struct attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct padata_instance *pinst;
-	struct padata_sysfs_entry *pentry;
-	ssize_t ret = -EIO;
-
-	pinst = kobj2pinst(kobj);
-	pentry = attr2pentry(attr);
-	if (pentry->show)
-		ret = pentry->store(pinst, attr, buf, count);
-
-	return ret;
-}
-
-static const struct sysfs_ops padata_sysfs_ops = {
-	.show = padata_sysfs_show,
-	.store = padata_sysfs_store,
-};
-
-static const struct kobj_type padata_attr_type = {
-	.sysfs_ops = &padata_sysfs_ops,
-	.default_groups = padata_default_groups,
-	.release = padata_sysfs_release,
-};
-
 /**
  * padata_alloc - allocate and initialize a padata instance
  * @name: used to identify the instance
@@ -986,57 +281,27 @@ struct padata_instance *padata_alloc(const char *name)
 	pinst = kzalloc(sizeof(struct padata_instance), GFP_KERNEL);
 	if (!pinst)
 		goto err;
-
-	pinst->parallel_wq = alloc_workqueue("%s_parallel", WQ_UNBOUND, 0,
+	pr_info("%s:%d %s\n", __FILE__, __LINE__, __func__);
+	pinst->parallel_wq = alloc_workqueue("%s_parallel", WQ_CPU_INTENSIVE, 0,
 					     name);
 	if (!pinst->parallel_wq)
 		goto err_free_inst;
 
-	cpus_read_lock();
-
-	pinst->serial_wq = alloc_workqueue("%s_serial", WQ_MEM_RECLAIM |
-					   WQ_CPU_INTENSIVE, 1, name);
+	pinst->serial_wq = alloc_ordered_workqueue ("%s_serial",
+									WQ_MEM_RECLAIM | WQ_FREEZABLE,
+									name);
 	if (!pinst->serial_wq)
-		goto err_put_cpus;
-
-	if (!alloc_cpumask_var(&pinst->cpumask.pcpu, GFP_KERNEL))
-		goto err_free_serial_wq;
-	if (!alloc_cpumask_var(&pinst->cpumask.cbcpu, GFP_KERNEL)) {
-		free_cpumask_var(pinst->cpumask.pcpu);
-		goto err_free_serial_wq;
-	}
+		goto err_free_parallel_wq;
 
 	INIT_LIST_HEAD(&pinst->pslist);
 
-	cpumask_copy(pinst->cpumask.pcpu, cpu_possible_mask);
-	cpumask_copy(pinst->cpumask.cbcpu, cpu_possible_mask);
-
-	if (padata_setup_cpumasks(pinst))
-		goto err_free_masks;
-
 	__padata_start(pinst);
 
-	kobject_init(&pinst->kobj, &padata_attr_type);
 	mutex_init(&pinst->lock);
 
-#ifdef CONFIG_HOTPLUG_CPU
-	cpuhp_state_add_instance_nocalls_cpuslocked(hp_online,
-						    &pinst->cpu_online_node);
-	cpuhp_state_add_instance_nocalls_cpuslocked(CPUHP_PADATA_DEAD,
-						    &pinst->cpu_dead_node);
-#endif
-
-	cpus_read_unlock();
-
 	return pinst;
 
-err_free_masks:
-	free_cpumask_var(pinst->cpumask.pcpu);
-	free_cpumask_var(pinst->cpumask.cbcpu);
-err_free_serial_wq:
-	destroy_workqueue(pinst->serial_wq);
-err_put_cpus:
-	cpus_read_unlock();
+err_free_parallel_wq:
 	destroy_workqueue(pinst->parallel_wq);
 err_free_inst:
 	kfree(pinst);
@@ -1052,7 +317,11 @@ EXPORT_SYMBOL(padata_alloc);
  */
 void padata_free(struct padata_instance *pinst)
 {
-	kobject_put(&pinst->kobj);
+	WARN_ON(!list_empty(&pinst->pslist));
+
+	destroy_workqueue(pinst->serial_wq);
+	destroy_workqueue(pinst->parallel_wq);
+	kfree(pinst);
 }
 EXPORT_SYMBOL(padata_free);
 
@@ -1065,7 +334,6 @@ EXPORT_SYMBOL(padata_free);
  */
 struct padata_shell *padata_alloc_shell(struct padata_instance *pinst)
 {
-	struct parallel_data *pd;
 	struct padata_shell *ps;
 
 	ps = kzalloc(sizeof(*ps), GFP_KERNEL);
@@ -1074,22 +342,12 @@ struct padata_shell *padata_alloc_shell(struct padata_instance *pinst)
 
 	ps->pinst = pinst;
 
-	cpus_read_lock();
-	pd = padata_alloc_pd(ps);
-	cpus_read_unlock();
-
-	if (!pd)
-		goto out_free_ps;
-
 	mutex_lock(&pinst->lock);
-	RCU_INIT_POINTER(ps->pd, pd);
 	list_add(&ps->list, &pinst->pslist);
 	mutex_unlock(&pinst->lock);
 
 	return ps;
 
-out_free_ps:
-	kfree(ps);
 out:
 	return NULL;
 }
@@ -1107,7 +365,6 @@ void padata_free_shell(struct padata_shell *ps)
 
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
-	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
@@ -1117,20 +374,6 @@ EXPORT_SYMBOL(padata_free_shell);
 void __init padata_init(void)
 {
 	unsigned int i, possible_cpus;
-#ifdef CONFIG_HOTPLUG_CPU
-	int ret;
-
-	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "padata:online",
-				      padata_cpu_online, NULL);
-	if (ret < 0)
-		goto err;
-	hp_online = ret;
-
-	ret = cpuhp_setup_state_multi(CPUHP_PADATA_DEAD, "padata:dead",
-				      NULL, padata_cpu_dead);
-	if (ret < 0)
-		goto remove_online_state;
-#endif
 
 	possible_cpus = num_possible_cpus();
 	padata_works = kmalloc_array(possible_cpus, sizeof(struct padata_work),
@@ -1144,11 +387,5 @@ void __init padata_init(void)
 	return;
 
 remove_dead_state:
-#ifdef CONFIG_HOTPLUG_CPU
-	cpuhp_remove_multi_state(CPUHP_PADATA_DEAD);
-remove_online_state:
-	cpuhp_remove_multi_state(hp_online);
-err:
-#endif
 	pr_warn("padata: initialization failed\n");
 }
-- 
2.40.0

