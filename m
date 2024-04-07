Return-Path: <linux-kernel+bounces-134280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A289AFE5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13F81F22BCB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55B2C19F;
	Sun,  7 Apr 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTEgtn7Z"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7B2BAF2;
	Sun,  7 Apr 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480631; cv=none; b=hkd4U9UaJX/4+8qu8mg9+23MXcyRTtdresRXhh3CvI+BANdaJRlZbQkDBSW4uKmYr3gCFgYsula9AXHq5T+DTRGmMfqq0eUIHPtixfVsqGYS0kDkWlEo5P9iapZ0lsT6BnSUWaypoDBxjn6mZIqt0cAXWGXqJHEAwfkaIb1U/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480631; c=relaxed/simple;
	bh=WQzpAah6Oo2bkMAnx/zWo1QQcwsq2Z/42lDo9dpY4/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSyX0UAy2o13e69fSSpHuY633NjLqE8MY1DoXVIYqi91zQTL5nVd9JvL6tOsunpQibSKorzvL0cJLi49DWCr8BJXeIVkOkuIf5ACqCrFyst806kQqY8xpsEZzRA+DaYix7ICxEb1+IyBk53sJtF1Ocf5y2wUtKsp1P+Azkt1za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTEgtn7Z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso28881515ad.1;
        Sun, 07 Apr 2024 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480629; x=1713085429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwgJg6qGDb4F/2vLVULuXMEXIMCZTw7ICcUrvera85s=;
        b=FTEgtn7Zt1EOobuHeT/vt/VT462oSr1qdMiG6mmuwkTV0znRAXAr2UO1MUpj+TwlqT
         cbIUclZdEXMAK0ADqGAKfbhSQiszUk77TEX1NEDu3j9axLO5sPhNKNNYmwDcNGhNv6QI
         rdwnOYI8Hd0FyFNQ23/DKsjF4H/esIJBGo3xB86d8iVlS/XG6HDu3Ilr4/vJzEsI0Z7P
         ANe0wAZXtnRGlTP9ompFOVAhUXVwwC0CS+Z6tsu4vkc+Nhxukobj1JrDYG/+hNRPMGcE
         5BCRZm0HSFnrrgYnkStR9Cuwe5CVupupV1++UzjBvei7YElYy6t//SHfR6SgbuzS5GsI
         01qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480629; x=1713085429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwgJg6qGDb4F/2vLVULuXMEXIMCZTw7ICcUrvera85s=;
        b=bWKrJjUc3gG30LBjP5dm5eNsj0n1NBZHg7kp9hC7/7z+YCjRLHIBLGqzsjsjFkm+y8
         PE/PEcbTTwiur42bcyWtqf6awjUPtfmt4u+m9EndYY+g7FLJFKmkui350yM7OdST2hg/
         b2h53tP0RLkiSc3gndfncguBWPbdYlJheACARfbyAgS62+X5GrQXVlTeghMBzfX6LeAc
         ABcCoXl3LLFaHosRBxUxDLfa6w6F5niTtXsyUKqxzLcsqcWsQ9/be7obbeoagCoQH8RM
         KodB03cfKWEEiO5qPUJ5OYStuouUWcynTGXBbOHPhGL4ZPGtvQs/iX+GJrFj2yscuMXF
         bZWg==
X-Gm-Message-State: AOJu0YzoFlfmaAaPgma6Stcnoeft4MwzE0RCYn0DUXfsehgZ5QyvL1Xf
	/zG7I0gd5h7yWAfXOAJluVPznmj0CKaeWXO6q9djoVnpq6+tcm2XfCyYPn6p
X-Google-Smtp-Source: AGHT+IFNSd0I3oJLebO3gMhdolrLbFNc1uMWBKx4Hq0g7mWJqEwiqFZrjSqYatrRa2/RMSDzojoBog==
X-Received: by 2002:a17:903:1112:b0:1e2:3d61:e266 with SMTP id n18-20020a170903111200b001e23d61e266mr8168295plh.49.1712480628868;
        Sun, 07 Apr 2024 02:03:48 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001ddc83fda95sm4508784plr.186.2024.04.07.02.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:48 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH V2 05/11] rcu: Make rcu_read_unlock_special() global
Date: Sun,  7 Apr 2024 17:05:52 +0800
Message-Id: <20240407090558.3395-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Make it global so that it can be used in the future inlined rcu_read_unlock().

Make it exported so that the inlined rcu_read_unlock() can be used in modules.

Make it taking a void-argument so that the caller can reduce instructions
obtaining the "current" task and it can be used in THUNK later.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/rcupdate.h | 2 ++
 kernel/rcu/tree_plugin.h | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ebe9bfc700bb..328667ae8086 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -68,6 +68,8 @@ static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned
 
 #ifdef CONFIG_PREEMPT_RCU
 
+void rcu_read_unlock_special(void);
+
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3dbd5609185e..880b3fef1158 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -104,7 +104,6 @@ static void __init rcu_bootup_announce_oddness(void)
 
 static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
 static bool sync_rcu_exp_done(struct rcu_node *rnp);
-static void rcu_read_unlock_special(struct task_struct *t);
 
 #define set_rcu_preempt_special(reason)	do {				\
 	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, true);	\
@@ -427,7 +426,7 @@ void __rcu_read_unlock(void)
 	if (rcu_preempt_read_exit() == 0) {
 		barrier();  // critical-section exit before .s check.
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
-			rcu_read_unlock_special(t);
+			rcu_read_unlock_special();
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		int rrln = rcu_preempt_depth();
@@ -627,8 +626,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+void rcu_read_unlock_special(void)
 {
+	struct task_struct *t = current;
 	unsigned long flags;
 	bool irqs_were_disabled;
 	bool preempt_bh_were_disabled =
@@ -684,6 +684,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	}
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
+EXPORT_SYMBOL_GPL(rcu_read_unlock_special);
 
 /*
  * Check that the list of blocked tasks for the newly completed grace
-- 
2.19.1.6.gb485710b


