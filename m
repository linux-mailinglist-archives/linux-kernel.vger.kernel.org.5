Return-Path: <linux-kernel+bounces-83725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8F869DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8F1C20F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE92148FE8;
	Tue, 27 Feb 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk0SBPEO"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713AE487A5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054940; cv=none; b=RaPJkEBgi/e8dK3np1QoSphsrN73cRSabE5f0TUu+pmhTfAAP57YkzX7DHm5LU2/rnfFcffpjwVoGTOj1BQUk/oCdDVVUhSplNBm4lwhHJVV90QwyeKSjD9x9vfJKzVtjisEWxrCVNwkAjq3Czq2BypxkUpfh0odaKQ9SBcTwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054940; c=relaxed/simple;
	bh=2HWVi+Tfkakhu3gQVirEXtnvYmC8z8IRGCwi4KJtDTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYB4aBZ5u19z/N28plCG1kuAWB9V+kpI0B9FSC26AleWRIh2CJuNFLQi+diHz8wi8eGsHDVbPHqxXxN22hShbn9yyqzJvNrAV5KzAo1wsyBuvJdFWMVpV1h+KbniIXl87XbtEkte0Cv/tAl+4OiOk+zwqf+M7HJrmH9N7yx1mWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk0SBPEO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c7b9b25ba6so90488839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054937; x=1709659737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZlyQoghN9GBCCxkpBZzxQRSZjG7ZQUSHe19BeafxXM=;
        b=Pk0SBPEOnJvp72oVOb0cOEQ+C73gbrdygxxLFOYXgiEw+FuG440J0hvjwdlwosAVAi
         wtsnwR3C7sGKwubydu/HMGjF16AZBIoQ4frbteIEqGF0wht8W1oWFdU3G+z2275C/hn5
         rHe22TBEZ726xWd5kvjOYrJtFahp2oIirgjJmPupPVeeqNgUudbw09KrNfVG8dPYg618
         D1L9W+QC2BNj7Oe6AjhGd2nmDMluBi9yH2ugFmPH01ZOeQ3ilzk7Lf1N1glKOQyplpkd
         nOvo9vNb7UZq+82GXY9+b7AD7RHsTDRS2uKpu896IQ3AHqsc7lGRuGyYpQezDbrYZ9+d
         51uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054937; x=1709659737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZlyQoghN9GBCCxkpBZzxQRSZjG7ZQUSHe19BeafxXM=;
        b=JMxgA2PGJqcCNxk6uGW0T3dK1HmQ/55Ttz1OHvi5yk/JQ9XDm7Bbp1zBdAUANoZprk
         P6QGHQRWOwpbOj5kk7Qp5ifZPJpiXBXG+4k7IvQYgQQctcn8whzwNvR4XJHZXtG2A/d4
         2AT6Jv2q4zfSqcJCUyn4lcgKUmppD0twTVXePN+hGbArWcEGe1igpJPpMa08Pnk185XV
         IW8NS8KrJA1XrxGG1yO1Cff0F9qzPhBwaW63MwtrKgZw7zJIb1j8xbDEpk/vfSMfAZm9
         Q8szxV0msZQ4Br7J9R/uLaRSbOTsYj06BMaORKlaXtXdkiCiVH9D3jVywiKWg1vz6Gxn
         olHg==
X-Forwarded-Encrypted: i=1; AJvYcCU5gr2pjwYAXw2+J2LXvUJ2F35RaNqTCdGV0bHHsCX6lIKradWYX4DUmc7GPhtdNfj2D7LhI/0v4GEvhtByDWoBRqRFKlHCLeTTzZ3R
X-Gm-Message-State: AOJu0YyGnLfpUe9ONlIg9cpVns82YVnbOKVenMnqej1hG1Y35/BK/LyL
	NE+eu2qnEbrtq1IIsW42S2k2pTc8hTMLE3itlYyH4j6rHQRfnJq8
X-Google-Smtp-Source: AGHT+IGwNjBmKuzo98BGqJwEh8x3Jeanm6NSu541GRcVsfYrIKGnownwWmNgiNp09nPmcb9FUoVsqw==
X-Received: by 2002:a92:cac7:0:b0:365:175e:e7a3 with SMTP id m7-20020a92cac7000000b00365175ee7a3mr10625463ilq.20.1709054937462;
        Tue, 27 Feb 2024 09:28:57 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a600e00b00298cc4c56cdsm8599262pji.22.2024.02.27.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:28:57 -0800 (PST)
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
Subject: [PATCH 1/6] workqueue: Preserve OFFQ bits in cancel[_sync] paths
Date: Tue, 27 Feb 2024 07:28:12 -1000
Message-ID: <20240227172852.2386358-2-tj@kernel.org>
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
index 38783e3a60bb..ecd46fbed60b 100644
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
@@ -891,29 +896,23 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
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
@@ -4186,6 +4185,7 @@ EXPORT_SYMBOL(flush_rcu_work);
 
 static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
+	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	int ret;
 
@@ -4196,19 +4196,26 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
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
@@ -4218,12 +4225,16 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
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


