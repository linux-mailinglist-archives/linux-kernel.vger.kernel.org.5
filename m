Return-Path: <linux-kernel+bounces-36239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F4839DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C51F1C24E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FA1841;
	Wed, 24 Jan 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="QqicEDN6"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69B1FB9;
	Wed, 24 Jan 2024 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057915; cv=none; b=sDvtwMzULQcjUttm/VW5Q2M4gMrHcfm3AOvs6Uy/U4SsSB23yLaSMVjDDCf7d/COV2f1tgEakgiHZI2v/n+D7JQxY+kAbcX3ekhJFmYyNSXsNJWfSK4c5Upk0tjmO5SNvWaIuVG/WeuqbW8v6N+nGwPt7I4VRMHypQ/xAHffkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057915; c=relaxed/simple;
	bh=+AtNfFRSJOpH18CKVrmuF/scPXxsWAx8Z+SsFLD/Qcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urhPOF5ln6j3Ppsyx/qsRUioaOixhHOsoyzAeH2K3LWxepCklVnKjVo2wtT7lHSsMmOjOVkT23x8eM466bdDoVXknVX3ofFiDgCStQfrHXYwE64oboTYmuCx63lVFnjBRAKWrDw9Tq/bDMMbVcEddABIGEEZUxlz6P4dtvbg5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=QqicEDN6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=xmPpmTCXC+l3vmysIVkGD33uWqyaTP5tz/rZDAydbXw=; b=QqicEDN6a6NscS8Xpc9ph1ELqE
	ppKYoQTth4+CdTkYZIYhMYyBKzL8rJpTsqP21DcOQ9zH7BLT0Z4lZlYg1b8e1t+Ul4RHhI8WNOCZZ
	JPj5JdNLhcLeldRvy/vvBAPFlWPC/UcZT3uN0zjLpwDOpJYcrmF/TXTnDFoJXkC4vSewP2MDmxK4p
	3fLwQZ3WrAdrZiQNDfspkItCuX014Olj8fh5lyxiELNJ/2TnffPAzx/FC1qohz2oMG+SeKre3UK1D
	8lBI9oTvGMUpVmuzc3sZFEcdcPCSK0Q3NopbjxkcyQyQMFnM4C7EzNfh0QKu9LiiiBE7uewX4m4vg
	nD+q+MQQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-38;
	Tue, 23 Jan 2024 18:42:06 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH 6/9] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Date: Tue, 23 Jan 2024 18:40:25 -0600
Message-ID: <20240124004028.16826-7-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124004028.16826-1-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to part of the functionality of the NT syscall
NtWaitForMultipleObjects(). Specifically, it implements the behaviour where
the third argument (wait_any) is FALSE, and it does not yet handle alertable
waits.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 241 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |   2 +
 2 files changed, 235 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 2e8d3c2d51a4..2685363fae9e 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -23,7 +23,34 @@ struct ntsync_obj {
 	struct kref refcount;
 	spinlock_t lock;
 
+	/*
+	 * any_waiters is protected by the object lock, but all_waiters is
+	 * protected by the device wait_all_lock.
+	 */
 	struct list_head any_waiters;
+	struct list_head all_waiters;
+
+	/*
+	 * Hint describing how many tasks are queued on this object in a
+	 * wait-all operation.
+	 *
+	 * Any time we do a wake, we may need to wake "all" waiters as well as
+	 * "any" waiters. In order to atomically wake "all" waiters, we must
+	 * lock all of the objects, and that means grabbing the wait_all_lock
+	 * below (and, due to lock ordering rules, before locking this object).
+	 * However, wait-all is a rare operation, and grabbing the wait-all
+	 * lock for every wake would create unnecessary contention. Therefore we
+	 * first check whether all_hint is zero, and, if it is, we skip trying
+	 * to wake "all" waiters.
+	 *
+	 * This hint isn't protected by any lock. It might change during the
+	 * course of a wake, but there's no meaningful race there; it's only a
+	 * hint.
+	 *
+	 * Since wait requests must originate from user-space threads, we're
+	 * limited here by PID_MAX_LIMIT, so there's no risk of saturation.
+	 */
+	atomic_t all_hint;
 
 	enum ntsync_type type;
 
@@ -54,11 +81,25 @@ struct ntsync_q {
 	 */
 	atomic_t signaled;
 
+	bool all;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
 
 struct ntsync_device {
+	/*
+	 * Wait-all operations must atomically grab all objects, and be totally
+	 * ordered with respect to each other and wait-any operations. If one
+	 * thread is trying to acquire several objects, another thread cannot
+	 * touch the object at the same time.
+	 *
+	 * We achieve this by grabbing multiple object locks at the same time.
+	 * However, this creates a lock ordering problem. To solve that problem,
+	 * wait_all_lock is taken first whenever multiple objects must be locked
+	 * at the same time.
+	 */
+	spinlock_t wait_all_lock;
+
 	struct xarray objects;
 };
 
@@ -107,6 +148,8 @@ static int ntsync_char_open(struct inode *inode, struct file *file)
 	if (!dev)
 		return -ENOMEM;
 
+	spin_lock_init(&dev->wait_all_lock);
+
 	xa_init_flags(&dev->objects, XA_FLAGS_ALLOC);
 
 	file->private_data = dev;
@@ -132,8 +175,81 @@ static int ntsync_char_release(struct inode *inode, struct file *file)
 static void init_obj(struct ntsync_obj *obj)
 {
 	kref_init(&obj->refcount);
+	atomic_set(&obj->all_hint, 0);
 	spin_lock_init(&obj->lock);
 	INIT_LIST_HEAD(&obj->any_waiters);
+	INIT_LIST_HEAD(&obj->all_waiters);
+}
+
+static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
+{
+	lockdep_assert_held(&obj->lock);
+
+	switch (obj->type) {
+	case NTSYNC_TYPE_SEM:
+		return !!obj->u.sem.count;
+	}
+
+	WARN(1, "bad object type %#x\n", obj->type);
+	return false;
+}
+
+/*
+ * "locked_obj" is an optional pointer to an object which is already locked and
+ * should not be locked again. This is necessary so that changing an object's
+ * state and waking it can be a single atomic operation.
+ */
+static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
+			 struct ntsync_obj *locked_obj)
+{
+	__u32 count = q->count;
+	bool can_wake = true;
+	__u32 i;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	if (locked_obj)
+		lockdep_assert_held(&locked_obj->lock);
+
+	for (i = 0; i < count; i++) {
+		if (q->entries[i].obj != locked_obj)
+			spin_lock_nest_lock(&q->entries[i].obj->lock, &dev->wait_all_lock);
+	}
+
+	for (i = 0; i < count; i++) {
+		if (!is_signaled(q->entries[i].obj, q->owner)) {
+			can_wake = false;
+			break;
+		}
+	}
+
+	if (can_wake && atomic_cmpxchg(&q->signaled, -1, 0) == -1) {
+		for (i = 0; i < count; i++) {
+			struct ntsync_obj *obj = q->entries[i].obj;
+
+			switch (obj->type) {
+			case NTSYNC_TYPE_SEM:
+				obj->u.sem.count--;
+				break;
+			}
+		}
+		wake_up_process(q->task);
+	}
+
+	for (i = 0; i < count; i++) {
+		if (q->entries[i].obj != locked_obj)
+			spin_unlock(&q->entries[i].obj->lock);
+	}
+}
+
+static void try_wake_all_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert_held(&obj->lock);
+
+	list_for_each_entry(entry, &obj->all_waiters, node)
+		try_wake_all(dev, entry->q, obj);
 }
 
 static void try_wake_any_sem(struct ntsync_obj *sem)
@@ -234,14 +350,29 @@ static int ntsync_put_sem(struct ntsync_device *dev, void __user *argp)
 	if (!sem)
 		return -EINVAL;
 
-	spin_lock(&sem->lock);
+	if (atomic_read(&sem->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
 
-	prev_count = sem->u.sem.count;
-	ret = put_sem_state(sem, args.count);
-	if (!ret)
-		try_wake_any_sem(sem);
+		prev_count = sem->u.sem.count;
+		ret = put_sem_state(sem, args.count);
+		if (!ret) {
+			try_wake_all_obj(dev, sem);
+			try_wake_any_sem(sem);
+		}
 
-	spin_unlock(&sem->lock);
+		spin_unlock(&sem->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&sem->lock);
+
+		prev_count = sem->u.sem.count;
+		ret = put_sem_state(sem, args.count);
+		if (!ret)
+			try_wake_any_sem(sem);
+
+		spin_unlock(&sem->lock);
+	}
 
 	put_obj(sem);
 
@@ -278,7 +409,7 @@ static int ntsync_schedule(const struct ntsync_q *q, ktime_t *timeout)
  * Also, calculate the relative timeout.
  */
 static int setup_wait(struct ntsync_device *dev,
-		      const struct ntsync_wait_args *args,
+		      const struct ntsync_wait_args *args, bool all,
 		      ktime_t *ret_timeout, struct ntsync_q **ret_q)
 {
 	const __u32 count = args->count;
@@ -321,6 +452,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->task = current;
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
+	q->all = all;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -330,6 +462,16 @@ static int setup_wait(struct ntsync_device *dev,
 		if (!obj)
 			goto err;
 
+		if (all) {
+			/* Check that the objects are all distinct. */
+			for (j = 0; j < i; j++) {
+				if (obj == q->entries[j].obj) {
+					put_obj(obj);
+					goto err;
+				}
+			}
+		}
+
 		entry->obj = obj;
 		entry->q = q;
 		entry->index = i;
@@ -370,7 +512,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
 
-	ret = setup_wait(dev, &args, &timeout, &q);
+	ret = setup_wait(dev, &args, false, &timeout, &q);
 	if (ret < 0)
 		return ret;
 
@@ -432,6 +574,87 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	return ret;
 }
 
+static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_wait_args args;
+	struct ntsync_q *q;
+	ktime_t timeout;
+	int signaled;
+	__u32 i;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	ret = setup_wait(dev, &args, true, &timeout, &q);
+	if (ret < 0)
+		return ret;
+
+	/* queue ourselves */
+
+	spin_lock(&dev->wait_all_lock);
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		atomic_inc(&obj->all_hint);
+
+		/*
+		 * obj->all_waiters is protected by dev->wait_all_lock rather
+		 * than obj->lock, so there is no need to acquire it here.
+		 */
+		list_add_tail(&entry->node, &obj->all_waiters);
+	}
+
+	/* check if we are already signaled */
+
+	try_wake_all(dev, q, NULL);
+
+	spin_unlock(&dev->wait_all_lock);
+
+	/* sleep */
+
+	ret = ntsync_schedule(q, args.timeout ? &timeout : NULL);
+
+	/* and finally, unqueue */
+
+	spin_lock(&dev->wait_all_lock);
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		/*
+		 * obj->all_waiters is protected by dev->wait_all_lock rather
+		 * than obj->lock, so there is no need to acquire it here.
+		 */
+		list_del(&entry->node);
+
+		atomic_dec(&obj->all_hint);
+
+		put_obj(obj);
+	}
+
+	spin_unlock(&dev->wait_all_lock);
+
+	signaled = atomic_read(&q->signaled);
+	if (signaled != -1) {
+		struct ntsync_wait_args __user *user_args = argp;
+
+		/* even if we caught a signal, we need to communicate success */
+		ret = 0;
+
+		if (put_user(signaled, &user_args->index))
+			ret = -EFAULT;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+	}
+
+	kfree(q);
+	return ret;
+}
+
 static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long parm)
 {
@@ -445,6 +668,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_delete(dev, argp);
 	case NTSYNC_IOC_PUT_SEM:
 		return ntsync_put_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ALL:
+		return ntsync_wait_all(dev, argp);
 	case NTSYNC_IOC_WAIT_ANY:
 		return ntsync_wait_any(dev, argp);
 	default:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 10f07da7864e..a5bed5a39b21 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -36,5 +36,7 @@ struct ntsync_wait_args {
 					      struct ntsync_sem_args)
 #define NTSYNC_IOC_WAIT_ANY		_IOWR(NTSYNC_IOC_BASE, 3, \
 					      struct ntsync_wait_args)
+#define NTSYNC_IOC_WAIT_ALL		_IOWR(NTSYNC_IOC_BASE, 4, \
+					      struct ntsync_wait_args)
 
 #endif
-- 
2.43.0


