Return-Path: <linux-kernel+bounces-69127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A128584DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DC71C21C18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5C1384B6;
	Fri, 16 Feb 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G28AetZ0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376A1350F6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106792; cv=none; b=Hs/vZ4cDjH6GD1QcO+FW1RKQw3ZpOSzEii+AdidM6xxhKVdHtIbGy8WuQgP/aHndriXVYLv55cIR/KBEZTAuoCh0K/2D1NbJKBVzcC+pzHLtx1XpL9DCq4ctnYtpp0R+gsmZRs/o4DJm6KoAxkY6om8cDhmOSUHT3WCdvLOw9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106792; c=relaxed/simple;
	bh=FJO8f8DVbJeanF+hpUj3gFVOJ/tGxb7K3WHo8qwoQnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV8ZBu3Coju1Ph+diiGFuF7KGCD6GtDP6/0DSLI1SwuyucZ2wbvLZoD5+Z5h+CQctlKF83/xZ7LWRvTAhjLKXxbJOn7YI4MFPrZEU4LGrvRH9JpAzW7zOiQecM8KYFalQW2cKMXChG/qICyRI3TTRlG5x9lEivJsRt+ZImEOBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G28AetZ0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0f803d9dfso738749b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106790; x=1708711590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B89hT+vvVK1kAIqQN3SycMfFOJPiZ6Bixp7yRrf8y94=;
        b=G28AetZ05W+dKbDim0E5x30azyX3/ONa4nCzBeWE+BwM1qjO80c7MLvRUrGrii4KcO
         ywPtZP9M6SlwMrvmr+WDvQnKfZVNCORFlIqJ36/3+dc0/MJVAyD/+lwQg3aexQt4nUz+
         8x4derTTfsMtKW546d1B3TItUX/13kTntra89b46AQ947XqJFibaQU+76KMYh76+JxOv
         nLvbkmSrt0qaTt5ebFXEMXwmqbwPTweP1x2XDqnDm0NHtMMvrFMg8CMtdn0NfJ0DURKj
         Kyrz1fghGfAWnLpQiZR+4Mtzs+eSWI2rz6eTa7/p6FES4h8k2Q7VndeYO1z0+2AjBImp
         mDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106790; x=1708711590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B89hT+vvVK1kAIqQN3SycMfFOJPiZ6Bixp7yRrf8y94=;
        b=Pdsc+bgHBLOTxsZVygCc9nu1DNSwixeSdZlMRyrMjCrS4tekrtkSTlbwozg+cL7pSw
         IP4IhFfaJFMBe7nf2EbEo2loujFHpEE5TG7RX8Uk1zHJ99y3DPwqGGiM+w+YKT/zTM8Y
         NN2Mrk/GI44UWIwY0NdxCaYNucDRJIJrxqOGw8O+UeM3sLfW4n9hzp82PqMcqJDTQsQU
         Fakfk3Q/Ph/vTk6GnGj7GpueMknyS7LO2atvtGLCX3+XBsGIQSAA61YpqcU2r/pdg78m
         +cHkJXr2N9QrvsFN8TSu9JTPqg7KmEuLVgBMkwarEaJ6b9uh3fJza+COMlzcCwI3tnu6
         0RoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr5Y93zg2tHlaYW+DBBcsIfNz6bY+gulmQs7JUK4PI+Z1Xr2kk6H8XvAvhZcMbI0Fvc7lDbZPXPDhvijVxfr/JyMTHhCehLqXRQ7rY
X-Gm-Message-State: AOJu0YyNtwZBd+gQTmehITJzwEezw/m6MW4IfiBdE46VKRNgfZKWCDNM
	FpEgcewxNjIREoWoDPjnW2nBrviY1rI/19Mb0N9HtQ9F0leJ7x9NYR6OTP9PcpI=
X-Google-Smtp-Source: AGHT+IF+LxF406alcHjEjl8X4WS2AzA2SAMab1lvP40rK5AS+rK+AQv7AIURjzz0xbkLHUhLprD12w==
X-Received: by 2002:a05:6a20:be93:b0:1a0:6856:d12c with SMTP id gf19-20020a056a20be9300b001a06856d12cmr4149085pzb.18.1708106789781;
        Fri, 16 Feb 2024 10:06:29 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id v7-20020aa78507000000b006e13ce6f4d8sm238055pfn.72.2024.02.16.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/17] workqueue: Remove clear_work_data()
Date: Fri, 16 Feb 2024 08:04:50 -1000
Message-ID: <20240216180559.208276-10-tj@kernel.org>
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

clear_work_data() is only used in one place and immediately followed by
smp_mb(), making it equivalent to set_work_pool_and_clear_pending() w/
WORK_OFFQ_POOL_NONE for @pool_id. Drop it. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 38e589b6871c..ea53b53f8ff9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -763,10 +763,9 @@ static int work_next_color(int color)
  * contain the pointer to the queued pwq.  Once execution starts, the flag
  * is cleared and the high bits contain OFFQ flags and pool ID.
  *
- * set_work_pwq(), set_work_pool_and_clear_pending(), mark_work_canceling()
- * and clear_work_data() can be used to set the pwq, pool or clear
- * work->data.  These functions should only be called while the work is
- * owned - ie. while the PENDING bit is set.
+ * set_work_pwq(), set_work_pool_and_clear_pending() and mark_work_canceling()
+ * can be used to set the pwq, pool or clear work->data. These functions should
+ * only be called while the work is owned - ie. while the PENDING bit is set.
  *
  * get_work_pool() and get_work_pwq() can be used to obtain the pool or pwq
  * corresponding to a work.  Pool is available once the work has been
@@ -841,12 +840,6 @@ static void set_work_pool_and_clear_pending(struct work_struct *work,
 	smp_mb();
 }
 
-static void clear_work_data(struct work_struct *work)
-{
-	smp_wmb();	/* see set_work_pool_and_clear_pending() */
-	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
-}
-
 static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
 {
 	return (struct pool_workqueue *)(data & WORK_STRUCT_PWQ_MASK);
@@ -4215,14 +4208,13 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	if (wq_online)
 		__flush_work(work, true);
 
-	clear_work_data(work);
-
 	/*
-	 * Paired with prepare_to_wait() above so that either
-	 * waitqueue_active() is visible here or !work_is_canceling() is
-	 * visible there.
+	 * smp_mb() at the end of set_work_pool_and_clear_pending() is paired
+	 * with prepare_to_wait() above so that either waitqueue_active() is
+	 * visible here or !work_is_canceling() is visible there.
 	 */
-	smp_mb();
+	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE);
+
 	if (waitqueue_active(&wq_cancel_waitq))
 		__wake_up(&wq_cancel_waitq, TASK_NORMAL, 1, work);
 
-- 
2.43.2


