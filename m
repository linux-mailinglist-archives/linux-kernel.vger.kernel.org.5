Return-Path: <linux-kernel+bounces-134260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A145589AFBD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ADC1F2212C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958D17554;
	Sun,  7 Apr 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvHwX7wE"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE4134AB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479433; cv=none; b=ej9kVpuCNc7RrMcVqjtvKivvZXiiiXqS0XWfvJhq9Ww8UjOwn1wvbaAXgqNa1/a4ZCDhvTLrDypmDREHePU6PSW1wRls1Bnwi0+/PDDeEzC4UYBaCD+MLtVPJz6RGqEethB40f5hzB+Zjg3IviL/WIeYYd9rrV41/R+0j48ZK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479433; c=relaxed/simple;
	bh=vbddrL8H+DecfzRA/hnxzeSBDteEz7YtqQgRFGmJ8ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dClEpe3maczpwFiQyG39lvC4XViYpnsYaH5cY2tb+5w7XjyJi8Ffsu8TxSW046aELgevCrDWHOgxl59RpUxLS8D+odiYA5uVRLHgcAYpEhE5SpQBgDyEfp4fFDDkQp4xtzw2+sDrIeU69Y3r518MlAazshGFpflWQIofaT4qQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvHwX7wE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51c8274403so57011766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479430; x=1713084230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn+uLsGt6mCxw1CzzaMig8BtXBKFT5BwV16SXTQmNbQ=;
        b=jvHwX7wEYlWEyC7cluRko28XWXBWdXE59n86fikDy2+VNOhQaXfXhZfCJ5au+EiQV5
         G0ptlf5xV2S3S61lgs5Y/dX95oE5rOXRY9VJgZ6rUEyAzSS4vJhcokHVXMggylyPDLr5
         xBp2Ii/YKzi92E5FZrN1x0H3PfDx5RIXg1sXjyXuzS8k5TIdPjztQp4PvTVVw7QmBAcM
         D+L4k3vW7UT0WRGuJyR/UQd32ykzUTSgeUDDH90GbCvYWJhyT1P/wrUNRbiQXoopkYa3
         k3VDniInnWxD5Ufp3lvHJ+VpqKuQ5PmLh3vcUMiStbXM/Uoe3bOWYxWcbcrS0qYcTG9Y
         iJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479430; x=1713084230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wn+uLsGt6mCxw1CzzaMig8BtXBKFT5BwV16SXTQmNbQ=;
        b=SAJUQSLvfmr7IbT/zFh5xcfPlDLtkUtxc/XWYaO5vV5f6nvhmPqW8/0/lwBYaXN6mq
         Gn/ZcdkK2uGNI1Z0yqG4U9mfrIJGISQBR/frCvkEWEHFEEcZ67j51/ZgPK9gvCE366EY
         zmMB3YsLyu+xHOsaZYCm3WVfMcDbxY0YSJ5apEUMntfw/vdpFQ9PiIeYxTe/qUXpT9hi
         JcozsD3MXhYIQUDlISp9HGWQYpX6V9LjWWo+RYkOv3g4hQWXOedzSZgHMiX7KI8V+SK9
         M3ocF4hw1ILfDgMdO8nn2eUno29KEyPNhmZxcUoy8uftCl+DPdArSclKT2EPWKkKLP7B
         PHpg==
X-Gm-Message-State: AOJu0YwpoRYRBKnIu3QLY/opzxDvXRzwFCCoeScWGbkc6bPIdePTWhgn
	8agM7VYl0+YvrRnLX4EKgd4p0FKjJ5IywtsP9yQAlqaoL4VKZDy/wJg84RmyUA0=
X-Google-Smtp-Source: AGHT+IHSmgBgDrWyJVKyizrq1ggiB/XpCSvPZYfvOSrRMzza++wrFuQwEhpyI5Wh2VYcA4VGP1QhuQ==
X-Received: by 2002:a17:906:4888:b0:a4e:b3f:1dda with SMTP id v8-20020a170906488800b00a4e0b3f1ddamr3432295ejq.74.1712479429948;
        Sun, 07 Apr 2024 01:43:49 -0700 (PDT)
Received: from thule.. (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm2891579ejz.57.2024.04.07.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:43:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/5] sched/fair: Rename set_next_buddy() to set_next_pick()
Date: Sun,  7 Apr 2024 10:43:19 +0200
Message-Id: <20240407084319.1462211-6-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407084319.1462211-1-mingo@kernel.org>
References: <20240407084319.1462211-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a mechanism to set the next task_pick target,
'buddy' is too ambiguous and refers to a historic feature we
don't have anymore.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93ea653065f5..fe730f232ffd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3200,7 +3200,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
+static void set_next_pick(struct sched_entity *se)
+{
+	for_each_sched_entity(se) {
+		if (SCHED_WARN_ON(!se->on_rq))
+			return;
+		if (se_is_idle(se))
+			return;
+		cfs_rq_of(se)->next = se;
+	}
+}
 
 /*
  * The dequeue_task method is called before nr_running is
@@ -3240,7 +3249,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			 * p is sleeping when it is within its sched_slice.
 			 */
 			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
-				set_next_buddy(se);
+				set_next_pick(se);
 			break;
 		}
 		flags |= DEQUEUE_SLEEP;
@@ -4631,17 +4640,6 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
-static void set_next_buddy(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
-			return;
-		if (se_is_idle(se))
-			return;
-		cfs_rq_of(se)->next = se;
-	}
-}
-
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4769,7 +4767,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto simple;
 
 	/*
-	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
+	 * Because of the set_next_pick() in dequeue_task_fair() it is rather
 	 * likely that a next task is from the same cgroup as the current.
 	 *
 	 * Therefore attempt to avoid putting and setting the entire cgroup
@@ -4957,7 +4955,7 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 		return false;
 
 	/* Tell the scheduler that we'd really like se to run next. */
-	set_next_buddy(se);
+	set_next_pick(se);
 
 	yield_task_fair(rq);
 
-- 
2.40.1


