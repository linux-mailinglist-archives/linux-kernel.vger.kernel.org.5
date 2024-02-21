Return-Path: <linux-kernel+bounces-75212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F285E4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85938B24191
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095F84FD3;
	Wed, 21 Feb 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ5czUYs"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE683CC2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537424; cv=none; b=TnomaMSRnB7hzUSsGrlQmQw5RaBn+UqNs9rr/O3qfuZ4lX+H6LisiVeaHq+hVejqtEw1UDwYDA2vJcdTkNz7Q+HgCcr70syEu3MlCvuyCuEIl8I6yjLpnCMWZ8rXoGgIXupI21669VgnU/yB8Fw0IDdEmDYoEXs9SWFFvGfGvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537424; c=relaxed/simple;
	bh=Q6mpJ7TjDxCNRoth/nOFlxr4b82LU8lAzubaoktdcaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTvTollZwz1sBYtPGg5EA0Suhx+5I8wVBLfkrlwiLtCidLbdkkspq4Wa3zUDhws+vVe77eHVPJTY/hQn/RPZ2bGgigeFRHDIOG2WGWIVXfhO3LAvsryI1G/xshDKDd3SK2XVluLcozQowir+LYeNjoCp4FZmttrtgcM2tk+fgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ5czUYs; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59d489e8d68so2142512eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537421; x=1709142221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWjIMUo9QNa0Y18oWiKlbpz/N7Q0JdxgvV+thsMb6tI=;
        b=FJ5czUYsVOkb5YWHXSI5dWCZxbvQd55KPr1BA0wthJoZD9ZLFrYcoIrX1XQNN//hQ2
         31szOUSGk0nsDfRK089alECaIDcqHDqRTFE5Yg6PKquZfnQ/dphvfwbt6nJPJQz+EJ43
         Birg5pojFvSCgSREGr/MAaDlsvkmnd19KGxMvz8y1mrysEmc/yeWXvjMK5HaRMBHP+eo
         XI8QmoH+bYpLBn7E9Uei8kkSJuIV8ZRA1qkoZgh6k1l2Ej5HBKsOXso/ofpD0KMlO3JB
         jhPMtcm7eXcKhRnNqmWV+5nNQsyMdkbPqwZtnbofqCXTY+sTIcAVoO1CUTcTCvQrTART
         /17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537421; x=1709142221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWjIMUo9QNa0Y18oWiKlbpz/N7Q0JdxgvV+thsMb6tI=;
        b=qNPNz2kKUa866KjT6hOwzXQjLrJ8JZMzwNc0wmVdQnEhzVZJCCmdcMqQOYQafqs8W2
         JWtcYhLtkfij6rJ+1BUrQ81QVO3v9K0hJLrXiPoCPimToLmeBvuOFs433PIqiKPvaLYX
         S2BLQecSGHju1dyBBeznTV2l1kMavqK21H3vyDqPSx3r+pmmERO4qhVHt6J0Q5uRmhgB
         7eM+sdEVr/viPXbqphHxPgyddusgtwrvySYeif2vY7x6zthEhqam7nonWWyZSaaHmmE3
         ZKaqGS0UBsHKr0eKFxYgwVfviyruq608blzmKpJm+5KVlc5YgqSIxIo1WaB9QjTmiMis
         DVCA==
X-Forwarded-Encrypted: i=1; AJvYcCXdmVDm0Zsu12ab3meGzEIk8vmZ7vAl2Nkwbf03xjxaF0xDs+L0Uhpk9EJpdfeZOP6i0/eKhnb95+UWu3PP8ejq9LpN0FX52rENlHBg
X-Gm-Message-State: AOJu0YwcFXw8EuD4ArhXkVqX8H0M230wDfF9XLtuuHF8nrJ9Vc5a1uII
	3mgbyUFaj4HQ9Np8tfHVCNgKb5yCGmESLD5o6oH/iDwJukdTZYom
X-Google-Smtp-Source: AGHT+IF/3RmMXPavFOwi7joNYd1ssgiL12zlSYgbTupAK4vfpMeNgtZeOAkrJwExQvfnMeGyOhIWag==
X-Received: by 2002:a05:6358:7c17:b0:17b:5864:4ae4 with SMTP id p23-20020a0563587c1700b0017b58644ae4mr3413381rwf.20.1708537421574;
        Wed, 21 Feb 2024 09:43:41 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id q18-20020a056a00089200b006e043d3e5c2sm9292342pfj.162.2024.02.21.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] workqueue: Preserve OFFQ bits in cancel[_sync] paths
Date: Wed, 21 Feb 2024 07:42:59 -1000
Message-ID: <20240221174333.700197-2-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
References: <20240221174333.700197-1-tj@kernel.org>
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
index 65a27be81452..279be7d12e20 100644
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
@@ -4178,6 +4177,7 @@ EXPORT_SYMBOL(flush_rcu_work);
 
 static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
+	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	int ret;
 
@@ -4188,19 +4188,26 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
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
@@ -4210,12 +4217,16 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
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


