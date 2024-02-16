Return-Path: <linux-kernel+bounces-69128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253728584DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7ACC284314
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79913AA57;
	Fri, 16 Feb 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwxTxdQm"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E31384B5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106794; cv=none; b=a3i3d2SxWbrema/Ki8ZmhjAErNxa4DLg//mec9j4jlPqPNsx8klah1g7vT0Qth9RcrFFpqOpNYtU/WrDaKeoWsk3Ar1jBll0jymcSoAQOQU9sQCyYTGvfOVeI9UXe39s8qNuzs0HgIVgHOAgc/dT+Yk6rCaBD30ONc2XxjO4Awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106794; c=relaxed/simple;
	bh=cPP5CIKEOYRT6epnHGsws/oABavjhCk4bIN8XpK22Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKITA9x0/AMymPSzXmhIVmZ9ifyrJprIT9LmSuMm/Bg7/Sz7vxOF4oljAy+JTNygKV8ImlZOvys9BI47VnGQ+xQJdPdze+Qx2V7FREZ6tOB37d1NINW1EipXfBe8L6+LWrY3S8DRYAC0241OXgu2JHn9RVMZVm012b2jQYKfM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwxTxdQm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1749892a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106792; x=1708711592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41qYLxE4dVgv1c5XbTIQWibRRdLdTaJ138CgAqO4goo=;
        b=dwxTxdQmJBJC9sl+oXNRB5dqMHScmAwNXDuwQ5HwAxO3dtUEq5WsQeBMNXh5SPj9zU
         wI9Oxn2M3HAnmYilLY8CBVHNgv248RHoJ3HrY16k8xhq0iXMRys6z0arPy+LZP77i0SM
         HZkqJ9d30iL/jsQgiANS1GCx6gx38qGIb40f/T3Z8on3WE5bPUumbN9T+PQ0pxBE738w
         drBFM4C4zx8CWTDZi2umIYSt190aKFPPikoHJ8eAfiP/0tU5s/ZRjeomR/nQb/PlNIxG
         yafc6s/dKcLI/eHCj7dfehY7SLP/QYN5T4Mxu5Pym4qtp7KGOWcmWCSxJPnWURWI1NuL
         kR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106792; x=1708711592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41qYLxE4dVgv1c5XbTIQWibRRdLdTaJ138CgAqO4goo=;
        b=LakPDhblC1j8SXq/6Z1EVd2P3olj6zCG8Q7rjU7mGOMiJPMcA1b1uBIgd2s4agf8UJ
         SKgfzAnJnEN7ZUjrkDAPQob6PyoYBs9Y9tuXmLg5XLheAEAugzUKWJ+yKQakClBZsHpn
         QqBs41f0DCbGNOtoBzU62XR6B7telvmH2rJExOmnIbuTTBJUbT4G66coQrXfijHo2hZR
         qK9p9ynC79cDxwVk9IYPY0uhtFog0H2k622aAaEorKzVrJ/UXMbysD03I8fJR0uRu2S3
         nTYEeng6ZqC4UOs/uv6oex4/SFfrKVz7fM067PrVrYGJl42ShA7c9uNWEoVdgwtS6BQI
         4iKg==
X-Forwarded-Encrypted: i=1; AJvYcCWBXvdTXi1mQPonJeVY3sgTtnjZhwd3kZ/PcNLB0CKvOFXtRAmYiH3QD+egTTCokqsuJyzNXHdTK3GLQ132bMopKobkqPy1fmsuoQ2/
X-Gm-Message-State: AOJu0YzVjM/aYNBvHVYxVr6bgq0FEIT+Ovj8fIJQgZXiTYeXQ+20scgw
	kB8U4k8hk3vLmh5VLZUaNMDIBmrKB9HRd7Y5w2jW1Ghez1Yxp/Dx
X-Google-Smtp-Source: AGHT+IF4O05+Yse0vLxiLY/eUZAMwN7fh7fbJWVpYz3+u1uTNezFrf3ZCNlMm3pJ/SUI71SIK4z4Zw==
X-Received: by 2002:a17:90b:3ecc:b0:299:4e65:7c10 with SMTP id rm12-20020a17090b3ecc00b002994e657c10mr330669pjb.48.1708106791953;
        Fri, 16 Feb 2024 10:06:31 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id s22-20020a63af56000000b005dc507e8d13sm183390pgo.91.2024.02.16.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/17] workqueue: Make @flags handling consistent across set_work_data() and friends
Date: Fri, 16 Feb 2024 08:04:51 -1000
Message-ID: <20240216180559.208276-11-tj@kernel.org>
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

- set_work_data() takes a separate @flags argument but just ORs it to @data.
  This is more confusing than helpful. Just take @data.

- Use the name @flags consistently and add the parameter to
  set_work_pool_and_{keep|clear}_pending(). This will be used by the planned
  disable/enable support.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ea53b53f8ff9..7aa53a2e41af 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -777,29 +777,28 @@ static int work_next_color(int color)
  * but stay off timer and worklist for arbitrarily long and nobody should
  * try to steal the PENDING bit.
  */
-static inline void set_work_data(struct work_struct *work, unsigned long data,
-				 unsigned long flags)
+static inline void set_work_data(struct work_struct *work, unsigned long data)
 {
 	WARN_ON_ONCE(!work_pending(work));
-	atomic_long_set(&work->data, data | flags | work_static(work));
+	atomic_long_set(&work->data, data | work_static(work));
 }
 
 static void set_work_pwq(struct work_struct *work, struct pool_workqueue *pwq,
-			 unsigned long extra_flags)
+			 unsigned long flags)
 {
-	set_work_data(work, (unsigned long)pwq,
-		      WORK_STRUCT_PENDING | WORK_STRUCT_PWQ | extra_flags);
+	set_work_data(work, (unsigned long)pwq | WORK_STRUCT_PENDING |
+		      WORK_STRUCT_PWQ | flags);
 }
 
 static void set_work_pool_and_keep_pending(struct work_struct *work,
-					   int pool_id)
+					   int pool_id, unsigned long flags)
 {
-	set_work_data(work, (unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT,
-		      WORK_STRUCT_PENDING);
+	set_work_data(work, ((unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT) |
+		      WORK_STRUCT_PENDING | flags);
 }
 
 static void set_work_pool_and_clear_pending(struct work_struct *work,
-					    int pool_id)
+					    int pool_id, unsigned long flags)
 {
 	/*
 	 * The following wmb is paired with the implied mb in
@@ -808,7 +807,8 @@ static void set_work_pool_and_clear_pending(struct work_struct *work,
 	 * owner.
 	 */
 	smp_wmb();
-	set_work_data(work, (unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT, 0);
+	set_work_data(work, ((unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT) |
+		      flags);
 	/*
 	 * The following mb guarantees that previous clear of a PENDING bit
 	 * will not be reordered with any speculative LOADS or STORES from
@@ -909,7 +909,7 @@ static void mark_work_canceling(struct work_struct *work)
 	unsigned long pool_id = get_work_pool_id(work);
 
 	pool_id <<= WORK_OFFQ_POOL_SHIFT;
-	set_work_data(work, pool_id | WORK_OFFQ_CANCELING, WORK_STRUCT_PENDING);
+	set_work_data(work, pool_id | WORK_STRUCT_PENDING | WORK_OFFQ_CANCELING);
 }
 
 static bool work_is_canceling(struct work_struct *work)
@@ -2127,7 +2127,7 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		 * this destroys work->data needed by the next step, stash it.
 		 */
 		work_data = *work_data_bits(work);
-		set_work_pool_and_keep_pending(work, pool->id);
+		set_work_pool_and_keep_pending(work, pool->id, 0);
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);
@@ -3203,7 +3203,7 @@ __acquires(&pool->lock)
 	 * PENDING and queued state changes happen together while IRQ is
 	 * disabled.
 	 */
-	set_work_pool_and_clear_pending(work, pool->id);
+	set_work_pool_and_clear_pending(work, pool->id, 0);
 
 	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
@@ -4186,7 +4186,7 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
 	if (unlikely(ret < 0))
 		return false;
 
-	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
+	set_work_pool_and_clear_pending(work, get_work_pool_id(work), 0);
 	local_irq_restore(irq_flags);
 	return ret;
 }
@@ -4213,7 +4213,7 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	 * with prepare_to_wait() above so that either waitqueue_active() is
 	 * visible here or !work_is_canceling() is visible there.
 	 */
-	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE);
+	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE, 0);
 
 	if (waitqueue_active(&wq_cancel_waitq))
 		__wake_up(&wq_cancel_waitq, TASK_NORMAL, 1, work);
-- 
2.43.2


