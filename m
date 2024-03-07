Return-Path: <linux-kernel+bounces-96370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF8875B36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C6F1C2129A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3247F57;
	Thu,  7 Mar 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UqYhQJyU"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC0743ADE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855341; cv=none; b=lgD2rkFgD2HvR2avAZ+F4kln0J6P2WhH4boaSePGzyPBNkIHxdZi0VBpWjDnTVBadm+paKSsZXfK9zc30KBmftLMn5q6ROikkr7OxKt1x+m2TxEWB0Wnr+rcfoxZDZf5C5aCeq14skNpw9nuRDlgCGFSpfvK8BqtjBcbBWLP6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855341; c=relaxed/simple;
	bh=RxrVHpsg2Dx2BK8X3581XvrwOzOq8HuNBnuD6LOVaeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hFSo2jdmfRj+aqHFC0/bpyVaXm2HAgw+bNBvRSRQvcuA2OyZPuM2OLo4u21TYIe5faUR2z1de2mJLy8MF1LjTnseM66NJ78LO6Z0CSWXJMehyffv1NDx/9YDXKkjdWR0bmdM4coTFzCB7OFjwyjcQ7sTOlyL6T3fxpWY4UA+7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=UqYhQJyU; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7dba7098dd8so293868241.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709855338; x=1710460138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYvliaxZHHBmxRsoWW/yY+ZGpMLYNfkC8wPuph2ba+I=;
        b=UqYhQJyUXhxEkZLK/rHVtwYhsz2FtravUlbjPH0/ZdC3hlERktMkw7NZNlHbYeMPiL
         otAvY5uW4OkY8BEY6CWBi1aX/XnfDWD+mCSr4cMzZa9JHNyf5sokwuC6rkxb7Ce1w/TY
         KDizQH0P9VED4p+M2mGaLy0l9vtYLzWhMcbVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709855338; x=1710460138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYvliaxZHHBmxRsoWW/yY+ZGpMLYNfkC8wPuph2ba+I=;
        b=FaE8c+VoOrw79PYKmAaYgJ+Mc0TOUvLbuoGB/l3T7HdQnyrXs7WWHlPf9Zx0O5Blq4
         1BCOF+co17cSVA/9SxAbnGneL3TLMDUkX6bkWfYRo+mAst441nBm0kDZlpZ2/fnCWZUO
         b4TN6JiMmQwQM83o5a0TO2H/zWhZxKbSHlZDGOoMnyx8jmxK3Ne3uowzWJWgXfb/azhD
         DVBrxcRjuKOJ4bReh+duDejUsPwPXjr/2ZrLCFpHzoTq0JpicctQbRQ4qUPueFzTlzrV
         D65nCn6kXz8W9ObzIpelhi2VhA2mYmGhMLpxq8MovbtwxpOmLgvORi408Eqt8Zw0LWSb
         GtwA==
X-Gm-Message-State: AOJu0YyxqnciIpqTqyHmiWV+NJ1QHB0Se4RGEE+tDaJrI1/9tdg+ajJ4
	kQR4ts/9NZh4hK/C9/WrDbtCvBzmDnrwEaihbaG7i92Th4p7SH84ttgsbJmApC+o1D8wJNG1dUM
	b
X-Google-Smtp-Source: AGHT+IG80+aEd9lIN5B2HVx0CQ34g6WerPXfDJlUp6/m/zTDrrep9d6Wz39fnLHME4Zb74ahclhAbw==
X-Received: by 2002:a05:6122:996:b0:4cd:44db:b24b with SMTP id g22-20020a056122099600b004cd44dbb24bmr9607129vkd.5.1709855337543;
        Thu, 07 Mar 2024 15:48:57 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id t4-20020ac865c4000000b0042f04d37e89sm2980907qto.10.2024.03.07.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:48:56 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Thu,  7 Mar 2024 18:48:51 -0500
Message-Id: <20240307234852.2132637-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the synchronize_rcu() common case, we will have less than
SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
is pointless just to free the last injected wait head since at that point,
all the users have already been awakened.

Introduce a new counter to track this and prevent the wakeup in the
common case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 12978049cb99..cba3a82e9ed9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
+	.srs_cleanups_pending = ATOMIC_INIT(0),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1641,8 +1642,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * the done tail list manipulations are protected here.
 	 */
 	done = smp_load_acquire(&rcu_state.srs_done_tail);
-	if (!done)
+	if (!done) {
+		/* See comments below. */
+		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 		return;
+	}
 
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
 	head = done->next;
@@ -1665,6 +1669,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 
 		rcu_sr_put_wait_head(rcu);
 	}
+
+	/* Order list manipulations with atomic access. */
+	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 }
 
 /*
@@ -1672,7 +1679,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail, *next, *rcu;
+	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
 	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
@@ -1698,16 +1705,35 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process. Remove the last wait head
+	 * if no inflight-workers. If there are in-flight workers, let them
+	 * remove the last wait head.
+	 */
+	WARN_ON_ONCE(!rcu);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
+	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+		/* Order atomic access with list manipulation. */
+		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		wait_tail->next = NULL;
+		rcu_sr_put_wait_head(rcu);
+		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+		return;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work)) {
+		atomic_dec(&rcu_state.srs_cleanups_pending);
+	}
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2832787cee1d..f162b947c5b6 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -420,6 +420,7 @@ struct rcu_state {
 	struct llist_node *srs_done_tail; /* ready for GP users. */
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
+	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.34.1


