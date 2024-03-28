Return-Path: <linux-kernel+bounces-122535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFD88F922
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B86E1C25EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3925789B;
	Thu, 28 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6Z0Qld"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BC53E38;
	Thu, 28 Mar 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612271; cv=none; b=Q4O9HlggntnapK41ujF4Ry1Or6Yn30w/8oEAJjih5jlXITbv2f388qtjXEPJURaTtzCxtldYrgm2DhRArByBqzq2g/1R4I/iptoPf6nWKbR4JUeY7z4FbdkNnEeoEggepBXA2MEIul5pZLYbmvKyLPtHa5tisX+JnAr5kS5R6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612271; c=relaxed/simple;
	bh=enZx1n4OK01lUXHrdd+7erDRpBSJsnAVbuYv7QzWELA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJj6gVIIKiE/oUeiSUIJrbGMrGK22dqpplaBQF02wYRMIzMxYA4Yl1bV6DIljhH0bTH7/Fb3MBlVbzThZbK1nDqgMtFdDDDjDMpZp56NOHMPyca2N0vdSbMxrm+ESWt0WtJCsjK34eATxumwzkK2Zyz4loCzRNKixy+/hNsjUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ6Z0Qld; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a4f7a648dbso347027eaf.3;
        Thu, 28 Mar 2024 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612268; x=1712217068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9VU/pyKywB+unjTxJCyReyW8qdQmEQO6VzP1yTJUvM=;
        b=dJ6Z0QldmwkElLfKJSFgNP+9sTSj8I2hmUoOJQmArT4mZkcSr/1E8PqXVJIh2IZfpO
         S1Z/7FdDqzWgrVrVabIwyQuBRQhigCPyF/HsAhn8Pqvd9s63THBQlMrw61vebJN03EUM
         MUte3qQN+Rwn2HpIU1PuR31m75mZmpsZP9iGosxFLkX2h8dyii/PXoFZMP8pjPWW7nms
         zkiHfvyHC84h0XrHPtWvpe/Qbkgj/spfY95pxierhLso00CJ/wdMANPEPmB/Jsymxb5M
         TXxibNA84ycYeM3jDFjtNoTSG2MstASFxtUewYY4XzdgxKoa2tdVIwgjqLtgdDZ6P33Q
         In4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612268; x=1712217068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9VU/pyKywB+unjTxJCyReyW8qdQmEQO6VzP1yTJUvM=;
        b=qFqz7X6ilcVupbilY5s70cGgs39INKIvSMnlluVGlFX4zdp7kycjMI4IfGzRIc2qWV
         vokr/ODZ/tdfp1GQOV9uJVgrnnTxlaffydWM4dtxHZmDzyz0LCYgTCvdoYJdnxzgrg9/
         EKHhiF0iHYCaGXuuTXtNQeMNU/ot553Gczh3lyvrGwgevgQP5a+7fYU3yfcnFHCiApRL
         eMIgDXAQc46P49TZnyGkDHxsTKqLnxBW3tnAABrMuujZiBeEsgEig7q3gyf8rSV+4A/B
         vCuK52FdzwuwFij4qC8Yg7WNx8WvKsLI2kUIp2iaVKolznkIs/ExGTYxqCx8EzTcDvE+
         7LEg==
X-Gm-Message-State: AOJu0YyoykFO6FItchm6Oesh9CPvtkT2Z6hRoa1YKND+XJ/R+nn44g3b
	OSRcu51ffCFDG5qPiFN6pB5fO9NC56vBpJMantxvbay22icxaFkngkbQtB+e
X-Google-Smtp-Source: AGHT+IF4SFu3dyS1jq9c9JUIbB6hOPx5Georf4Ru081wj7PhhUuL+ItBLD0KHsC5/M3U3iMREBbs6A==
X-Received: by 2002:a05:6870:c34c:b0:22a:a40a:a09f with SMTP id e12-20020a056870c34c00b0022aa40aa09fmr1115197oak.54.1711612268597;
        Thu, 28 Mar 2024 00:51:08 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id gx5-20020a056a001e0500b006e729dd12d5sm749531pfb.48.2024.03.28.00.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:08 -0700 (PDT)
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
Subject: [PATCH 05/10] rcu: Make rcu_read_unlock_special() global
Date: Thu, 28 Mar 2024 15:53:13 +0800
Message-Id: <20240328075318.83039-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
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
obtaining the "current" task value and it can be used in THUNK later.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/rcupdate.h | 2 ++
 kernel/rcu/tree_plugin.h | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 210f65baf47c..cc77d76a870b 100644
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


