Return-Path: <linux-kernel+bounces-83726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DF869DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5191E283F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F6149E08;
	Tue, 27 Feb 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A86V4NUH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3711487D5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054942; cv=none; b=Sx1SuvKVPnguqYqjaJcqwtmBys17D28oNP4fudPJDiRkAAlSrBtrigRHNIY9Kx6k9eQ+o9Fiqdgyyi1UQdAeFE50wgT/VZfhuqOqt6Fb1b4ZFFId14BtlqZtEBVnZMLyXN7kTHniC0OB5svLjSGhmyt/rLG9rJTpTpsIarSsGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054942; c=relaxed/simple;
	bh=8j9O7fbKpKNgOozhCUm0J0cL4Ud8NkaLUeQFgeTAH3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B66xUzN9IRV50XOjAbw2y255ItMYUwoPDEKz3YyHkmM5zkFIZI43ZxZ0BOT9oX/pYl+3bHnM9QDgEMaDRkDkfSF5q6DHfzl0su75V06JlZKCcKFAKUmnHztGgbrdQlcPfk8hmcNIXO/Yl5fFQsgU7A2nPnwISf/Kv+kkvCPpTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A86V4NUH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc0e5b223eso37825725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054939; x=1709659739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0Ekf56kJLi7dYIIZeSuDI3c9Him+81uK7xWqIKuLwY=;
        b=A86V4NUHuv9Ubxn+ZS2r9HHY8SlyJJg5gxpuqvRhrWmc8iAB8FaqOtmGqAYvpNnQfY
         eu+sSyNNr3QfZvGl0NGhRXKfWUr8QNDGi0k2Oot+uPcaw8VaRgAscfDP9nG6yS6uhQpE
         50fdMjewSHSIuoVDKpVPKqMzxtnREi1h8ecBjHVlaWOGizyuIESFrkwvf+Cvjizjwi9v
         ChYlLiMwMTR50HxCWgUwYjsa6lvE6WbksZz2gBvjPgEpwaRDFGWxpxapgD5Y/WJApqOd
         F7Ca/Y0QFWiqzjturLKJJ49gK/VaU4NfpcRJ8IFMAPZa2wow9XpA9R3r4Ui5BMVhbVTD
         fmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054939; x=1709659739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0Ekf56kJLi7dYIIZeSuDI3c9Him+81uK7xWqIKuLwY=;
        b=rp8Jal/WUUp4HsVnxkuQ4/pD9Jq7OdaU5vYZuxJsdSldTSbtl7PTR4JSo0Ou3W6AmB
         u574eYpXuvLDtc5OfINum3b3ON3aOlfiD0DUEALel2axpdY8Bg5NT4f5J3J+HVfW+/Tr
         vX80Ikq2mQtHIJLjkPYKZxvn7x7pozUcXv/ZXcZyHHzb88dz4YqabzNjFD87Ly+af7iE
         hhUIpMYOq4bap2cFmgraBz0vOfu4LiUISz0+JtPebrdSxOo8ze9jBq8ThpNAgN6MR7p7
         dWq3LFo+PX3gjGECnMyD4q1M4Lws5DIi12q39Eaw5cNfR/dg7vCRsu/u9ZX7niyu2we1
         ZLnw==
X-Forwarded-Encrypted: i=1; AJvYcCUf2MwroITCvsoqKGDysxzK2ryPKRUNJe/RPi24++X9zBZvOayRwfm+Kzb8G9fpvuE27mf3xrQa7LLQUSa3xqpPF49xzpi6eqZ2olQI
X-Gm-Message-State: AOJu0YzuJruL4evXNhWU8b7RIluFWHG81wk+OKlX4+ePGWt0QE314792
	BInFNc7jt3ewUwtZv2rrTnknc+nIaicEF0K9BgWYZQKPyV/BeyMW
X-Google-Smtp-Source: AGHT+IEG+dyFdnH9myUOOre3RO56815OOw3bS4c8OZh3Ktbj1JePS8kkFf71o4vNVDzD5HawFaqTzA==
X-Received: by 2002:a17:902:ef8d:b0:1dc:1ca9:daf9 with SMTP id iz13-20020a170902ef8d00b001dc1ca9daf9mr8300287plb.12.1709054939240;
        Tue, 27 Feb 2024 09:28:59 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id mq11-20020a170902fd4b00b001dc8f1e06eesm1768959plb.291.2024.02.27.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:28:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] workqueue: Implement disable/enable for (delayed) work items
Date: Tue, 27 Feb 2024 07:28:13 -1000
Message-ID: <20240227172852.2386358-3-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
References: <20240227172852.2386358-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While (delayed) work items could be flushed and canceled, there was no way
to prevent them from being queued in the future. While this didn't lead to
functional deficiencies, it sometimes required a bit more effort from the
workqueue users to e.g. sequence shutdown steps with more care.

Workqueue is currently in the process of replacing tasklet which does
support disabling and enabling. The feature is used relatively widely to,
for example, temporarily suppress main path while a control plane operation
(reset or config change) is in progress.

To enable easy conversion of tasklet users and as it seems like an inherent
useful feature, this patch implements disabling and enabling of work items.

- A work item carries 16bit disable count in work->data while not queued.
  The access to the count is synchronized by the PENDING bit like all other
  parts of work->data.

- If the count is non-zero, the work item cannot be queued. Any attempt to
  queue the work item fails and returns %false.

- disable_work[_sync](), enable_work(), disable_delayed_work[_sync]() and
  enable_delayed_work() are added.

v3: enable_work() was using local_irq_enable() instead of
    local_irq_restore() to undo IRQ-disable by work_grab_pending(). This is
    awkward now and will become incorrect as enable_work() will later be
    used from IRQ context too. (Lai)

v2: Lai noticed that queue_work_node() wasn't checking the disable count.
    Fixed. queue_rcu_work() is updated to trigger warning if the inner work
    item is disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 include/linux/workqueue.h |  18 +++-
 kernel/workqueue.c        | 177 +++++++++++++++++++++++++++++++++++---
 2 files changed, 182 insertions(+), 13 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index e15fc77bf2e2..f25915e47efb 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -51,20 +51,23 @@ enum work_bits {
 	 * data contains off-queue information when !WORK_STRUCT_PWQ.
 	 *
 	 * MSB
-	 * [ pool ID ] [ OFFQ flags ] [ STRUCT flags ]
-	 *                 1 bit        4 or 5 bits
+	 * [ pool ID ] [ disable depth ] [ OFFQ flags ] [ STRUCT flags ]
+	 *                  16 bits          1 bit        4 or 5 bits
 	 */
 	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
 	WORK_OFFQ_CANCELING_BIT = WORK_OFFQ_FLAG_SHIFT,
 	WORK_OFFQ_FLAG_END,
 	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
+	WORK_OFFQ_DISABLE_SHIFT	= WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS,
+	WORK_OFFQ_DISABLE_BITS	= 16,
+
 	/*
 	 * When a work item is off queue, the high bits encode off-queue flags
 	 * and the last pool it was on. Cap pool ID to 31 bits and use the
 	 * highest number to indicate that no pool is associated.
 	 */
-	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS,
+	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_DISABLE_SHIFT + WORK_OFFQ_DISABLE_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
 };
@@ -98,6 +101,7 @@ enum wq_misc_consts {
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
 #define WORK_OFFQ_CANCELING	(1ul << WORK_OFFQ_CANCELING_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
+#define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
 #define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
 #define WORK_STRUCT_PWQ_MASK	(~((1ul << WORK_STRUCT_PWQ_SHIFT) - 1))
@@ -556,6 +560,14 @@ extern bool flush_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
 
+extern bool disable_work(struct work_struct *work);
+extern bool disable_work_sync(struct work_struct *work);
+extern bool enable_work(struct work_struct *work);
+
+extern bool disable_delayed_work(struct delayed_work *dwork);
+extern bool disable_delayed_work_sync(struct delayed_work *dwork);
+extern bool enable_delayed_work(struct delayed_work *dwork);
+
 extern bool flush_rcu_work(struct rcu_work *rwork);
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ecd46fbed60b..a2f2847d464b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -98,6 +98,7 @@ enum worker_flags {
 
 enum work_cancel_flags {
 	WORK_CANCEL_DELAYED	= 1 << 0,	/* canceling a delayed_work */
+	WORK_CANCEL_DISABLE	= 1 << 1,	/* canceling to disable */
 };
 
 enum wq_internal_consts {
@@ -393,6 +394,7 @@ struct wq_pod_type {
 
 struct work_offq_data {
 	u32			pool_id;
+	u32			disable;
 	u32			flags;
 };
 
@@ -907,12 +909,15 @@ static void work_offqd_unpack(struct work_offq_data *offqd, unsigned long data)
 
 	offqd->pool_id = shift_and_mask(data, WORK_OFFQ_POOL_SHIFT,
 					WORK_OFFQ_POOL_BITS);
+	offqd->disable = shift_and_mask(data, WORK_OFFQ_DISABLE_SHIFT,
+					WORK_OFFQ_DISABLE_BITS);
 	offqd->flags = data & WORK_OFFQ_FLAG_MASK;
 }
 
 static unsigned long work_offqd_pack_flags(struct work_offq_data *offqd)
 {
-	return (unsigned long)offqd->flags;
+	return ((unsigned long)offqd->disable << WORK_OFFQ_DISABLE_SHIFT) |
+		((unsigned long)offqd->flags);
 }
 
 static bool work_is_canceling(struct work_struct *work)
@@ -2405,6 +2410,21 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	rcu_read_unlock();
 }
 
+static bool clear_pending_if_disabled(struct work_struct *work)
+{
+	unsigned long data = *work_data_bits(work);
+	struct work_offq_data offqd;
+
+	if (likely((data & WORK_STRUCT_PWQ) ||
+		   !(data & WORK_OFFQ_DISABLE_MASK)))
+		return false;
+
+	work_offqd_unpack(&offqd, data);
+	set_work_pool_and_clear_pending(work, offqd.pool_id,
+					work_offqd_pack_flags(&offqd));
+	return true;
+}
+
 /**
  * queue_work_on - queue work on specific cpu
  * @cpu: CPU number to execute work on
@@ -2427,7 +2447,8 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		__queue_work(cpu, wq, work);
 		ret = true;
 	}
@@ -2505,7 +2526,8 @@ bool queue_work_node(int node, struct workqueue_struct *wq,
 
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		int cpu = select_numa_node_cpu(node);
 
 		__queue_work(cpu, wq, work);
@@ -2587,7 +2609,8 @@ bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	/* read the comment in __queue_work() */
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret = true;
 	}
@@ -2660,7 +2683,12 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 {
 	struct work_struct *work = &rwork->work;
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	/*
+	 * rcu_work can't be canceled or disabled. Warn if the user reached
+	 * inside @rwork and disabled the inner work.
+	 */
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !WARN_ON_ONCE(clear_pending_if_disabled(work))) {
 		rwork->wq = wq;
 		call_rcu_hurry(&rwork->rcu, rcu_work_rcufn);
 		return true;
@@ -4183,20 +4211,46 @@ bool flush_rcu_work(struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(flush_rcu_work);
 
+static void work_offqd_disable(struct work_offq_data *offqd)
+{
+	const unsigned long max = (1lu << WORK_OFFQ_DISABLE_BITS) - 1;
+
+	if (likely(offqd->disable < max))
+		offqd->disable++;
+	else
+		WARN_ONCE(true, "workqueue: work disable count overflowed\n");
+}
+
+static void work_offqd_enable(struct work_offq_data *offqd)
+{
+	if (likely(offqd->disable > 0))
+		offqd->disable--;
+	else
+		WARN_ONCE(true, "workqueue: work disable count underflowed\n");
+}
+
 static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
 	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	int ret;
 
-	do {
-		ret = try_to_grab_pending(work, cflags, &irq_flags);
-	} while (unlikely(ret == -EAGAIN));
+	if (cflags & WORK_CANCEL_DISABLE) {
+		ret = work_grab_pending(work, cflags, &irq_flags);
+	} else {
+		do {
+			ret = try_to_grab_pending(work, cflags, &irq_flags);
+		} while (unlikely(ret == -EAGAIN));
 
-	if (unlikely(ret < 0))
-		return false;
+		if (unlikely(ret < 0))
+			return false;
+	}
 
 	work_offqd_unpack(&offqd, *work_data_bits(work));
+
+	if (cflags & WORK_CANCEL_DISABLE)
+		work_offqd_disable(&offqd);
+
 	set_work_pool_and_clear_pending(work, offqd.pool_id,
 					work_offqd_pack_flags(&offqd));
 	local_irq_restore(irq_flags);
@@ -4213,6 +4267,10 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	ret = work_grab_pending(work, cflags, &irq_flags);
 
 	work_offqd_unpack(&offqd, *work_data_bits(work));
+
+	if (cflags & WORK_CANCEL_DISABLE)
+		work_offqd_disable(&offqd);
+
 	offqd.flags |= WORK_OFFQ_CANCELING;
 	set_work_pool_and_keep_pending(work, offqd.pool_id,
 				       work_offqd_pack_flags(&offqd));
@@ -4312,6 +4370,105 @@ bool cancel_delayed_work_sync(struct delayed_work *dwork)
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
+/**
+ * disable_work - Disable and cancel a work item
+ * @work: work item to disable
+ *
+ * Disable @work by incrementing its disable count and cancel it if currently
+ * pending. As long as the disable count is non-zero, any attempt to queue @work
+ * will fail and return %false. The maximum supported disable depth is 2 to the
+ * power of %WORK_OFFQ_DISABLE_BITS, currently 65536.
+ *
+ * Must be called from a sleepable context. Returns %true if @work was pending,
+ * %false otherwise.
+ */
+bool disable_work(struct work_struct *work)
+{
+	return __cancel_work(work, WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_work);
+
+/**
+ * disable_work_sync - Disable, cancel and drain a work item
+ * @work: work item to disable
+ *
+ * Similar to disable_work() but also wait for @work to finish if currently
+ * executing.
+ *
+ * Must be called from a sleepable context. Returns %true if @work was pending,
+ * %false otherwise.
+ */
+bool disable_work_sync(struct work_struct *work)
+{
+	return __cancel_work_sync(work, WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_work_sync);
+
+/**
+ * enable_work - Enable a work item
+ * @work: work item to enable
+ *
+ * Undo disable_work[_sync]() by decrementing @work's disable count. @work can
+ * only be queued if its disable count is 0.
+ *
+ * Must be called from a sleepable context. Returns %true if the disable count
+ * reached 0. Otherwise, %false.
+ */
+bool enable_work(struct work_struct *work)
+{
+	struct work_offq_data offqd;
+	unsigned long irq_flags;
+
+	work_grab_pending(work, 0, &irq_flags);
+
+	work_offqd_unpack(&offqd, *work_data_bits(work));
+	work_offqd_enable(&offqd);
+	set_work_pool_and_clear_pending(work, offqd.pool_id,
+					work_offqd_pack_flags(&offqd));
+	local_irq_restore(irq_flags);
+
+	return !offqd.disable;
+}
+EXPORT_SYMBOL_GPL(enable_work);
+
+/**
+ * disable_delayed_work - Disable and cancel a delayed work item
+ * @dwork: delayed work item to disable
+ *
+ * disable_work() for delayed work items.
+ */
+bool disable_delayed_work(struct delayed_work *dwork)
+{
+	return __cancel_work(&dwork->work,
+			     WORK_CANCEL_DELAYED | WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_delayed_work);
+
+/**
+ * disable_delayed_work_sync - Disable, cancel and drain a delayed work item
+ * @dwork: delayed work item to disable
+ *
+ * disable_work_sync() for delayed work items.
+ */
+bool disable_delayed_work_sync(struct delayed_work *dwork)
+{
+	return __cancel_work_sync(&dwork->work,
+				  WORK_CANCEL_DELAYED | WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_delayed_work_sync);
+
+/**
+ * enable_delayed_work - Enable a delayed work item
+ * @dwork: delayed work item to enable
+ *
+ * enable_work() for delayed work items.
+ */
+bool enable_delayed_work(struct delayed_work *dwork)
+{
+	return enable_work(&dwork->work);
+}
+EXPORT_SYMBOL_GPL(enable_delayed_work);
+
 /**
  * schedule_on_each_cpu - execute a function synchronously on each online CPU
  * @func: the function to call
-- 
2.43.2


