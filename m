Return-Path: <linux-kernel+bounces-122534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9088F920
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C1A29522F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495B53E11;
	Thu, 28 Mar 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLL0x/ZB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42654FA0;
	Thu, 28 Mar 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612267; cv=none; b=msizqNwohbIDXGR4HS3q0VjkcKi70BVlzs2ctyRbYA6fibD1+ilMVF3TXRjdNY2JvmSxmi909rXlCkUmUu5unPp4IWLEfIrow0ExtlHbIVTaffAejElZCNKa8dF7UnGJ5zWFq5oL6CjSHpcTBR9/9Jv2/kJtKt6QLq/CkqHJzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612267; c=relaxed/simple;
	bh=dyDjW0emqk3ra0mcQ2J2Pyvf/leGXIhR8J75jqjVAuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQvD8dQP+xgZPIjtiVWIaiTKEsOsHXCTQld3csrc/ki9mgzRi7oAUvD1/zakZXtBYG2YzIXKU6BtGKcylEuU90Ntuk+eixU1xDxoS7vg9gqj8O1UxZbPEhOIrqAEEvEpQkprB2BBbIXeUEmEDE8qVHKwJLvPOLMlhI/4Ih9YGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLL0x/ZB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so424740a12.1;
        Thu, 28 Mar 2024 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612265; x=1712217065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvoBd6HF4JbE2BHoe97A/COYGhUtV93EmRmWHbLWiDc=;
        b=YLL0x/ZBgaAhW7Mkj57I/jN4jzQ1Sc6kOBTQg5jbfjJa5PNIfE+witr5XzMtVGFGOp
         RfqKhluy2qAz7ZMkgISNOG4Kif1SFVbQdcnHgW8o2RnNRrrrwa3T1GRlrzedShTNydjA
         VTGaiq+gKhqmugz4V1N4U3g8AJz8Yx7uuJkepzMC9pE9ckC3HX9f1167p8lsO9C3EbMx
         Nh91CR/bGSvB15p/4pCYRaRJ5RMwH5jIiccAwPIPOtvv2efbFNPKTVS0PfrpKwfMRLNh
         nsY7Vx0ezW+keupUiuwXUPGIwWh06RVb8IoEXLJjyQ8n5pc3gdClmLtGJx7T9WOUqdug
         TbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612265; x=1712217065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvoBd6HF4JbE2BHoe97A/COYGhUtV93EmRmWHbLWiDc=;
        b=bQQcPVFohPiY9AAQerDTPYzr/Xd7sezFIOc0Oh89XhDU52qvacXHhwQZ5IZUz3RNjC
         trCYUgGfrAjtEbZL5KebYXle6ZehDFhP06Ig4fNxgvVcf5+/lpJPaN7L9dnBTRanqD1b
         rUxVVSReYXPvkV1aoBWnVcgzQg614Vs1jCw1i7vWM1+MMoOv2VSgQYrFtE0F83J/X3gS
         ZGz3YUivxX9uywLLn3KvdCXRU6IxyMgOq5Dj2hrnfleZvvcOg0xFCro/7lQRSLTbWYzi
         2eHpQyMEFaCEyExOuVdM2ZSRQqVt8qzQtrjtrVoEiwhsaUajVFxG5tPdewTIHL31BdO6
         LFqg==
X-Gm-Message-State: AOJu0YwWdI8VQm1sYrBQc0idGB9yPAfpWJ4aBSjOCHrJ+AU4quxmFo7y
	bNyTrz/u3sayG0CktcozZvBicH71euvjtkdNvbczMP5hiO61oE70S2XEyBCm
X-Google-Smtp-Source: AGHT+IH7DhtUYNn/v811iMBSHET6XQNvp0TWBqztbY6OYCDBxmyvhgvpjskjy0i0ovFiIRQ7h/j9sA==
X-Received: by 2002:a05:6a20:daa9:b0:1a3:af03:6b0 with SMTP id iy41-20020a056a20daa900b001a3af0306b0mr2913532pzb.7.1711612264778;
        Thu, 28 Mar 2024 00:51:04 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001e0b5d4a2a8sm857817pls.149.2024.03.28.00.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:04 -0700 (PDT)
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
Subject: [PATCH 04/10] rcu: Add macros set_rcu_preempt_special() and clear_rcu_preempt_special()
Date: Thu, 28 Mar 2024 15:53:12 +0800
Message-Id: <20240328075318.83039-5-jiangshanlai@gmail.com>
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

Add wrappers accessing to t->rcu_read_unlock_special.b so that the
wrappers can be adapted for synching the value with the later-introduced
per-cpu rcu_preempt_count.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/tree_exp.h    |  2 +-
 kernel/rcu/tree_plugin.h | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6b83537480b1..4e91414552e6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -725,7 +725,7 @@ static void rcu_exp_handler(void *unused)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-			t->rcu_read_unlock_special.b.exp_hint = true;
+			set_rcu_preempt_special(exp_hint);
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d899b4afc21c..3dbd5609185e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -106,6 +106,14 @@ static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
 static bool sync_rcu_exp_done(struct rcu_node *rnp);
 static void rcu_read_unlock_special(struct task_struct *t);
 
+#define set_rcu_preempt_special(reason)	do {				\
+	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, true);	\
+	} while (0)
+
+#define clear_rcu_preempt_special(reason)	do {			\
+	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, false);	\
+	} while (0)
+
 /*
  * Tell them what RCU they are running.
  */
@@ -293,7 +301,7 @@ static void rcu_qs(void)
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
+		clear_rcu_preempt_special(need_qs);
 	}
 }
 
@@ -325,7 +333,7 @@ void rcu_note_context_switch(bool preempt)
 		/* Possibly blocking in an RCU read-side critical section. */
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp);
-		t->rcu_read_unlock_special.b.blocked = true;
+		set_rcu_preempt_special(blocked);
 		t->rcu_blocked_node = rnp;
 
 		/*
@@ -399,7 +407,7 @@ void __rcu_read_lock(void)
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
+		set_rcu_preempt_special(need_qs);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -738,7 +746,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
 	    time_after(jiffies, rcu_state.gp_start + HZ))
-		t->rcu_read_unlock_special.b.need_qs = true;
+		set_rcu_preempt_special(need_qs);
 }
 
 /*
@@ -751,12 +759,10 @@ static void rcu_flavor_sched_clock_irq(int user)
  */
 void exit_rcu(void)
 {
-	struct task_struct *t = current;
-
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
 		rcu_preempt_depth_set(1);
 		barrier();
-		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
+		set_rcu_preempt_special(blocked);
 	} else if (unlikely(rcu_preempt_depth())) {
 		rcu_preempt_depth_set(1);
 	} else {
-- 
2.19.1.6.gb485710b


