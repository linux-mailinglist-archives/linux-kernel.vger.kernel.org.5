Return-Path: <linux-kernel+bounces-99909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222E878F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F23F1C20D59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7306995C;
	Tue, 12 Mar 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neUouczJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CB32C84;
	Tue, 12 Mar 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228248; cv=none; b=ZvEj9pindJSu0qtVt32MmsjgbwOaMu9qDJ2f/FTH4nvFuGl09XlPVRDGJcoT983oiHTvtpPdI/sCRdupdAbM+3ECHt1lvpVrjuchXlerU3XRYGeC5iWZkyQX5n/Ol7L8l8GVHs8Cq+49+ib75kcZN2zMKQP06Jz71e0n/gOXKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228248; c=relaxed/simple;
	bh=GFewVEBBjXTCg6pPRyLzX1Aees4I5q0KrCFb3G3hCno=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EExhGlgERbpiqcAlqF0tkRBO7e7AGBsmbUdDMeAJ4ZHtHyzBYLIqx4UQsNdjyeG9Jj2S1ojBhG2X2BRi6UvzefYttoq9i+dZLYxu4mPW2ygAKEt53gTDYs7dEj/eP3YaBW/8Hh7e143jejjfdL+BmA5SITfrDIonXg5uTEy/UQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neUouczJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so3352943b3a.2;
        Tue, 12 Mar 2024 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710228246; x=1710833046; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKEepurocW2wMDsEwr7aAkhw/260KFoxQ25h+rdxZo4=;
        b=neUouczJEYbSfY8PhJd5ztV+6tsNaarHNmLAx8nNRzMyqM1hJjrc9H7idavFNqokUz
         0HnFS71Rjtd9xZFj1fDQ3l6l03cHxp04d0vuL3jddyUU4xv3XVP083jzXv9dQDhw4XNz
         KpgR9BTFiYlK985qFEuT0wO4+G/bESbASEr7gAcLfsdg58d4t63T9WCvNWB4xKHD6izE
         pBZrdVeq5dV12WV/PYsi7Y7sJfuls/FtSwI4QRvta01XV4tCQR9bBaDqQRxJqSN6qfY4
         RGEW+wavAf9YQIFA8VF0zUP6X5/UsINAfkgUNKWumtrPGANhkEv8KSTogyxv4L7EXhO0
         5J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710228246; x=1710833046;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKEepurocW2wMDsEwr7aAkhw/260KFoxQ25h+rdxZo4=;
        b=QR11BvIEDxj2tmlMhJIeLUkMzGWp315q/4gA55uHs/YUHRuDK5JmyjAd/qa8qaN5Mi
         D/LQVS9OHQKTemLHcYvNShPTxb5nHyRYZLYc/sfPgyitSp+KVYJ0996mrd3sNBXd8K+P
         Pf5Ffbvg1zvxrJ+zYh8pt8aYa8sgkeA913NFpO0beTSgJQHgXtT91oGq9XaKQL8wdlVw
         6Sm5bNDAhIp/Sa4tGmRDYbR3JF399QsSzd06sKYGK/Vhmzil2sMCxF+Fvok4tPQkACCQ
         9NQnQ55GFPXQ5OwUV2eKMxM90Si2FL4UGAt5cGjAUdfsJX224nt9ejmelPaxnsXsJTRr
         6f9w==
X-Forwarded-Encrypted: i=1; AJvYcCV9y4kfjG+ITpGt/yjAooKvHeD4uZo+m18CkmZups1amY9e305GnikIqernHuJX3PqZuWYJ17uidBYtriVdao+noaAIpeHLJvFdKRwJEcdT2ySiI+DaWsCTyTTfFsH8mxQX
X-Gm-Message-State: AOJu0YzTaHi9t1MeroptfxxO4pRsYVAQqp1UhmlMPlMmRGtog1uxJPdD
	Yp49xD1VgwpJmoPgEKfTCciE0bYv+S1gxhomX8UrLjU0MjdpkjyN8GtS/TsF
X-Google-Smtp-Source: AGHT+IF/qZBhbkr2KvfBIzUERorO9PixdlfZ6sB1oJizlyjnrZOOOOQs4aBBAll0USgd20ivTeECGA==
X-Received: by 2002:a05:6a00:2291:b0:6e6:3237:a461 with SMTP id f17-20020a056a00229100b006e63237a461mr12074880pfe.9.1710228245696;
        Tue, 12 Mar 2024 00:24:05 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a0000c600b006e4432027d1sm5611541pfj.142.2024.03.12.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 00:24:05 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Make rcutorture support print rcu-tasks gp state
Date: Tue, 12 Mar 2024 15:23:57 +0800
Message-Id: <20240312072357.23517-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit make rcu-tasks related rcutorture test support rcu-tasks
gp state printing when the writer stall occurs or the at the end of
rcutorture test.

The test is as follows:
[ 3872.548702] tasks-tracing:  Start-test grace-period state: g4560 f0x0
[ 4332.661283] tasks-tracing:  End-test grace-period state: g41540 f0x0 total-gps=36980

[ 4401.381138] tasks:  Start-test grace-period state: g8 f0x0
[ 4565.619354] tasks:  End-test grace-period state: g1732 f0x0 total-gps=1724

[ 4589.006917] tasks-rude:  Start-test grace-period state: g8 f0x0
[ 5059.379321] tasks-rude:  End-test grace-period state: g8508 f0x0 total-gps=8500

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcu.h        |  8 ++++++++
 kernel/rcu/rcutorture.c |  3 +++
 kernel/rcu/tasks.h      | 25 +++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 86fce206560e..3353e3697645 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -556,6 +556,14 @@ static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
 static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
+void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
+				unsigned long *gp_seq);
+#else
+static inline void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
+				unsigned long *gp_seq) { }
+#endif
+
 #if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dd7d5ba45740..91c03f37fd97 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2267,6 +2267,7 @@ rcu_torture_stats_print(void)
 				       &flags, &gp_seq);
 		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
 					&flags, &gp_seq);
+		rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
 		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
@@ -3391,6 +3392,7 @@ rcu_torture_cleanup(void)
 
 	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
 		 cur_ops->name, (long)gp_seq, flags,
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
@@ -3763,6 +3765,7 @@ rcu_torture_init(void)
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
 	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	start_gp_seq = gp_seq;
 	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
 		 cur_ops->name, (long)gp_seq, flags);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e83adcdb49b5..b1254cf3c210 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -2149,6 +2149,31 @@ late_initcall(rcu_tasks_verify_schedule_work);
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
 
+void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
+				unsigned long *gp_seq)
+{
+	switch (test_type) {
+	case RCU_TASKS_FLAVOR:
+#ifdef CONFIG_TASKS_RCU
+		*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
+#endif
+		break;
+	case RCU_TASKS_RUDE_FLAVOR:
+#ifdef CONFIG_TASKS_RUDE_RCU
+		*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
+#endif
+		break;
+	case RCU_TASKS_TRACING_FLAVOR:
+#ifdef CONFIG_TASKS_TRACE_RCU
+		*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
+#endif
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rcutaskstorture_get_gp_data);
+
 void __init tasks_cblist_init_generic(void)
 {
 	lockdep_assert_irqs_disabled();
-- 
2.17.1


