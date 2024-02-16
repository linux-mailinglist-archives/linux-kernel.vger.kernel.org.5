Return-Path: <linux-kernel+bounces-69129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2598584DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C031F218F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088213B2BC;
	Fri, 16 Feb 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGlfhXnC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1913AA49
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106796; cv=none; b=WmghuzTK7TGPF7kc45SDwp0nb4Y7Q7ngcCTTkTzaEMtDt7Y9sa1NfCYxbaKjU7biAIwaJLyZCMp9LKpRuWowReUcRaTSnXnHdf1nhfMduXgsVcbm0iyaFQYQCIKFhWGQIxCT3tJmvZniZYhkEsH0pafwmB13FvNg2e5QOKogy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106796; c=relaxed/simple;
	bh=kaVesntSH9WtASpo/ITaFDU41OYmgmXbJfft7L0rkZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxLsWt0HGy8CBx0ImpfDN+HjZSevPExetTpecUtfhYnlQTjAYuI3pngiM9pjBvYxK1LOatfLief6VLdKsX9oJVYRVTTh5ebfNZTOZSeOUU7xbvEqO7TL1KSeq2GK4EBU+seaAGNERAGHmrWviwvyRhfRkP72yrt/3KsUAPHHebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGlfhXnC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-363c2edac5aso6694365ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106794; x=1708711594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYw17V2FqKp0C6CYJFYt8WJLZzrh9NJi0Sqb0UNwGU0=;
        b=cGlfhXnCY15ermxqwL3BXB/C52oZ8DhIeuCZTqOFqmTZSosb411H9oY04xxjJlC/Dh
         yKhpnjHqTshQMtV752vr+2DlOZeRwD/xZPjGnjdzN306ggCBr4tMafR3q3BSlg668Imx
         aX86ONAzBOJDriYCcEViR/74snj0hLoulqtXD/EYatJerqD7QChLbiRUJwsgaA3Pxp4Z
         74+aLGpzLLBSFOCCnBPG5B9kA6jVST8zjmsseTZb40P+PW+vO6/Se+NJQhvkg26tXUMS
         8zkhsqnYAx9tkGyEYgTRU3WVuneKhx3bEjI2RZ8WB1d2KF6eHwC0ZohqHqXgJkyDieQ1
         GUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106794; x=1708711594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYw17V2FqKp0C6CYJFYt8WJLZzrh9NJi0Sqb0UNwGU0=;
        b=SHYW6l2u3gymBy5IFRWnXgK3YgHMOkeaMdgHU1zv0HNCflvhiivw0xSyzt2OVO7v2i
         iKZFHGT/mXkmMlgrTv9wrBG20KsuYeYRUIo7mrf6smmIbIlYQo/MByXGF7F4x3aDkuJz
         fhfvZLf5zrG4pnbGzglLCmMZ88DU2zma+3Z3U0fQYjfhe4nxD/rUQBDey7VjwiXTmqLj
         8cbGPYh+OpM2s/EQeIb7u8ymIeTgIStahhZAWVSGOBj0zPbKv2b/7J5Eljb7BeLnj3Xd
         wYjIroayLsH3VF/QaJ2mn4iXUkRCKmmsA9fI5dztZ2taXm3WTRsutRmem/F0AbbbTY5h
         e6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu8oSHa+ZKNBNt4VB/EEWKUKQHTGlhm9DS97VwSNMZYMhLCNgfWi45/+Oaaeu5Vzo61cb8w+41dstEdzlfmjCXatFZwQWsu19Zbv9h
X-Gm-Message-State: AOJu0YyM40TsKkG/yuOtr4sQaCflQvC/5d8hhs38uEiV6uGefGAnL2zQ
	uiqAfPVV2y8SlQOMzazpa7qYNhTTIu4W0Rxiv++uLPc2YSwJa9Zs
X-Google-Smtp-Source: AGHT+IFNWQ/sv3Bjf6771BHNcBXMFQVdJtk9zqAKpJTecYXNn1NDx1aWeoGrBfL5tBRsD5eW7omG7g==
X-Received: by 2002:a05:6e02:13c8:b0:363:d734:14b with SMTP id v8-20020a056e0213c800b00363d734014bmr6223644ilj.26.1708106793656;
        Fri, 16 Feb 2024 10:06:33 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id k131-20020a636f89000000b005d8b89bbf20sm190558pgc.63.2024.02.16.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/17] workqueue: Preserve OFFQ bits in cancel[_sync] paths
Date: Fri, 16 Feb 2024 08:04:52 -1000
Message-ID: <20240216180559.208276-12-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cancel[_sync] paths acquire and release WORK_STRUCT_PENDING, and
manipulate WORK_OFFQ_CANCELING. However, they assume that all the OFFQ bit
values except for the pool ID are statically known and don't preserve them,
which is not wrong in the current code as the pool ID and CANCELING are the
only information carried. However, the planned disable/enable support will
add more fields and need them to be preserved.

This patch updates work data handling so that only the bits which need
updating are updated.

- struct work_offq_data is added along with work_offqd_unpack() and
  work_offqd_pack_flags() to help manipulating multiple fields contained in
  work->data. Note that the helpers look a bit silly right now as there
  isn't that much to pack. The next patch will add more.

- mark_work_canceling() which is used only by __cancel_work_sync() is
  replaced by open-coded usage of work_offq_data and
  set_work_pool_and_keep_pending() in __cancel_work_sync().

- __cancel_work[_sync]() uses offq_data helpers to preserve other OFFQ bits
  when clearing WORK_STRUCT_PENDING and WORK_OFFQ_CANCELING at the end.

- This removes all users of get_work_pool_id() which is dropped. Note that
  get_work_pool_id() could handle both WORK_STRUCT_PWQ and !WORK_STRUCT_PWQ
  cases; however, it was only being called after try_to_grab_pending()
  succeeded, in which case WORK_STRUCT_PWQ is never set and thus it's safe
  to use work_offqd_unpack() instead.

No behavior changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 51 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0ad534fe6673..e15fc77bf2e2 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -97,6 +97,7 @@ enum wq_misc_consts {
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
 #define WORK_OFFQ_CANCELING	(1ul << WORK_OFFQ_CANCELING_BIT)
+#define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
 #define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
 #define WORK_STRUCT_PWQ_MASK	(~((1ul << WORK_STRUCT_PWQ_SHIFT) - 1))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7aa53a2e41af..e8f310aa16d6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -391,6 +391,11 @@ struct wq_pod_type {
 	int			*cpu_pod;	/* cpu -> pod */
 };
 
+struct work_offq_data {
+	u32			pool_id;
+	u32			flags;
+};
+
 static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
 	[WQ_AFFN_DFL]		= "default",
 	[WQ_AFFN_CPU]		= "cpu",
@@ -887,29 +892,23 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	return idr_find(&worker_pool_idr, pool_id);
 }
 
-/**
- * get_work_pool_id - return the worker pool ID a given work is associated with
- * @work: the work item of interest
- *
- * Return: The worker_pool ID @work was last associated with.
- * %WORK_OFFQ_POOL_NONE if none.
- */
-static int get_work_pool_id(struct work_struct *work)
+static unsigned long shift_and_mask(unsigned long v, u32 shift, u32 bits)
 {
-	unsigned long data = atomic_long_read(&work->data);
+	return (v >> shift) & ((1 << bits) - 1);
+}
 
-	if (data & WORK_STRUCT_PWQ)
-		return work_struct_pwq(data)->pool->id;
+static void work_offqd_unpack(struct work_offq_data *offqd, unsigned long data)
+{
+	WARN_ON_ONCE(data & WORK_STRUCT_PWQ);
 
-	return data >> WORK_OFFQ_POOL_SHIFT;
+	offqd->pool_id = shift_and_mask(data, WORK_OFFQ_POOL_SHIFT,
+					WORK_OFFQ_POOL_BITS);
+	offqd->flags = data & WORK_OFFQ_FLAG_MASK;
 }
 
-static void mark_work_canceling(struct work_struct *work)
+static unsigned long work_offqd_pack_flags(struct work_offq_data *offqd)
 {
-	unsigned long pool_id = get_work_pool_id(work);
-
-	pool_id <<= WORK_OFFQ_POOL_SHIFT;
-	set_work_data(work, pool_id | WORK_STRUCT_PENDING | WORK_OFFQ_CANCELING);
+	return (unsigned long)offqd->flags;
 }
 
 static bool work_is_canceling(struct work_struct *work)
@@ -4176,6 +4175,7 @@ EXPORT_SYMBOL(flush_rcu_work);
 
 static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
+	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	int ret;
 
@@ -4186,19 +4186,26 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
 	if (unlikely(ret < 0))
 		return false;
 
-	set_work_pool_and_clear_pending(work, get_work_pool_id(work), 0);
+	work_offqd_unpack(&offqd, *work_data_bits(work));
+	set_work_pool_and_clear_pending(work, offqd.pool_id,
+					work_offqd_pack_flags(&offqd));
 	local_irq_restore(irq_flags);
 	return ret;
 }
 
 static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 {
+	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	bool ret;
 
 	/* claim @work and tell other tasks trying to grab @work to back off */
 	ret = work_grab_pending(work, cflags, &irq_flags);
-	mark_work_canceling(work);
+
+	work_offqd_unpack(&offqd, *work_data_bits(work));
+	offqd.flags |= WORK_OFFQ_CANCELING;
+	set_work_pool_and_keep_pending(work, offqd.pool_id,
+				       work_offqd_pack_flags(&offqd));
 	local_irq_restore(irq_flags);
 
 	/*
@@ -4208,12 +4215,16 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	if (wq_online)
 		__flush_work(work, true);
 
+	work_offqd_unpack(&offqd, *work_data_bits(work));
+
 	/*
 	 * smp_mb() at the end of set_work_pool_and_clear_pending() is paired
 	 * with prepare_to_wait() above so that either waitqueue_active() is
 	 * visible here or !work_is_canceling() is visible there.
 	 */
-	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE, 0);
+	offqd.flags &= ~WORK_OFFQ_CANCELING;
+	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE,
+					work_offqd_pack_flags(&offqd));
 
 	if (waitqueue_active(&wq_cancel_waitq))
 		__wake_up(&wq_cancel_waitq, TASK_NORMAL, 1, work);
-- 
2.43.2


