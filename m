Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33A2789B12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjH0CyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjH0Cx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:53:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679DF1AC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:53:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34cb979c9b9so8259205ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693104835; x=1693709635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+p7c6hBX/kTnboG8LhQNLZuVYdMHSGC3d9ZfEphxqY=;
        b=Pcb8Y8KRWhAvPSfQFUbAZrxgmWa5wvP7a+72bMsOE9xMs/O3hnwNzpWJU2RilxP6gl
         26X1f8AaQRcdXebB0XZSXclB9XfYQSj2cgi2HCwGWjHJ+PtjlbCyjQ5i/zIgl2oAYRMj
         o/PxO6Kpp0pZ3H/yAdkSuJhyWLf6xml6r88d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693104835; x=1693709635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+p7c6hBX/kTnboG8LhQNLZuVYdMHSGC3d9ZfEphxqY=;
        b=DTrB584ZT6/qRc8WYGyiTjsfM/QU0/QpI22ynSQ0wNpz59UY92moatraUUc3owG/Mv
         ERtKAqA25B9NUdCYoWwXpg1xRtdv/W9eWm5Fvvb1zoPEQLU558rtb9hqxLiiWpX+ItMD
         lI7zjN34/yo35H+PHghN+D0CEmBfS7JSKApMYOfVOkOmhbcD82xv00sb4c+BV2mQs0nn
         1KrwYYWQBVbPMIbRyYHxHBFiXZ+3zSA7mtjbO6z0PztGRwMZbXBx0cgwsvN6l9uQsrp+
         6NHejISDyeeVfr5MzXgdXlod8kqb7+ksNKH/3daPI7zw17ZuVLWCZP4t5VGgIwi+2hYm
         5csw==
X-Gm-Message-State: AOJu0YwqiJJruvlMiesNHjhi1BvB87h9/RFjg4JfhVpeFsnkOuig95XN
        Uuq0YFkITG1AeF6ERgcQoQhfzCos77IZfRc9d54=
X-Google-Smtp-Source: AGHT+IGNPWk4GwwEbRb4wE6Vurb3F5YErVqgDyYhJ1bSfPtG2nCj0VypbCDtSPWZ5aeS82/NU5fJwQ==
X-Received: by 2002:a05:6e02:104b:b0:348:7396:184b with SMTP id p11-20020a056e02104b00b003487396184bmr11997913ilj.24.1693104835288;
        Sat, 26 Aug 2023 19:53:55 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c809000000b003498df5ca0fsm1558209iln.20.2023.08.26.19.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:53:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org
Subject: [PATCH] rcu/tree: Defer setting of jiffies during stall reset
Date:   Sun, 27 Aug 2023 02:53:47 +0000
Message-ID: <20230827025349.4161262-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are instances where rcu_cpu_stall_reset() is called when jiffies
did not get a chance to update for a long time. Before jiffies is
updated, the CPU stall detector can go off triggering false-positives
where a just-started grace period appears to be ages old. In the past,
we disabled stall detection in rcu_cpu_stall_reset() however this got
changed [1]. This is resulting in false-positives in KGDB usecase [2].

Fix this by deferring the update of jiffies to the third run of the FQS
loop. This is more robust, as, even if rcu_cpu_stall_reset() is called
just before jiffies is read, we would end up pushing out the jiffies
read by 3 more FQS loops. Meanwhile the CPU stall detection will be
delayed and we will not get any false positives.

[1] https://lore.kernel.org/all/20210521155624.174524-2-senozhatsky@chromium.org/
[2] https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/

Tested with rcutorture.cpu_stall option as well to verify stall behavior
with/without patch.

Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Closes: https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/
Suggested-by: Paul  McKenney <paulmck@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c       | 11 +++++++++++
 kernel/rcu/tree.h       |  4 ++++
 kernel/rcu/tree_stall.h | 20 ++++++++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..9273f2318ea1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1552,10 +1552,21 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
  */
 static void rcu_gp_fqs(bool first_time)
 {
+	int nr_fqs = READ_ONCE(rcu_state.nr_fqs_jiffies_stall);
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
+
+	WARN_ON_ONCE(nr_fqs > 3);
+	if (nr_fqs) {
+		if (nr_fqs == 1) {
+			WRITE_ONCE(rcu_state.jiffies_stall,
+				   jiffies + rcu_jiffies_till_stall_check());
+		}
+		WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, --nr_fqs);
+	}
+
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..e9821a8422db 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,6 +386,10 @@ struct rcu_state {
 						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
+	int nr_fqs_jiffies_stall;		/* Number of fqs loops after
+						 * which read jiffies and set
+						 * jiffies_stall. Stall
+						 * warnings disabled if !0. */
 	unsigned long jiffies_resched;		/* Time at which to resched */
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..a2fa6b22e248 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -149,12 +149,17 @@ static void panic_on_rcu_stall(void)
 /**
  * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
+ * To perform the reset request from the caller, disable stall detection until
+ * 3 fqs loops have passed. This is required to ensure a fresh jiffies is
+ * loaded.  It should be safe to do from the fqs loop as enough timer
+ * interrupts and context switches should have passed.
+ *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + rcu_jiffies_till_stall_check());
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
+	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -170,6 +175,7 @@ static void record_gp_stall_check_time(void)
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
 	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 0);
 	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
@@ -725,6 +731,16 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
+
+	/*
+	 * Check if it was requested (via rcu_cpu_stall_reset()) that the FQS
+	 * loop has to set jiffies to ensure a non-stale jiffies value. This
+	 * is required to have good jiffies value after coming out of long
+	 * breaks of jiffies updates. Not doing so can cause false positives.
+	 */
+	if (READ_ONCE(rcu_state.nr_fqs_jiffies_stall) > 0)
+		return;
+
 	j = jiffies;
 
 	/*
-- 
2.42.0.rc1.204.g551eb34607-goog

