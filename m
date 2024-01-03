Return-Path: <linux-kernel+bounces-15913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B75823595
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4098286A04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5D1CFA9;
	Wed,  3 Jan 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7TVXpZr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B31CF82
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5768AC433C8;
	Wed,  3 Jan 2024 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704310188;
	bh=Unr4OY0Hx42q1pzNznUCuug80mRkrj/aXFvZHPSqafo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=a7TVXpZrmMPVW+N9r64ybQlcCK17O9AndoUM3kYIJkOHrzb6JV3zyDtEZ4OsRnxXu
	 6lv9sYBzzgjpsOqS+/9dkiJPYhcZj7ssJ/0S/jGPigO+1cbKaWygnOXr5QTRbyhII4
	 hHytQVLC3OtTMwDFO2XUXb3kFsPkwJVeW48TlZrIH85PvbpxD7f4u+3k3C9O/Ph+l6
	 8NB+hI2DKKrhFQItSGWs5RrjQb7M+H+tTiPjzRzoYPfEnldW+oEvYN+rvb5V4+1/zS
	 slgFUYPs3moQWEhyMnT77fZpFOfSTHtttRDO20xtfXeoNntpHkaWb0pM3rXxC9wD8B
	 4GaxU5Fuxdnpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DB2CACE09BD; Wed,  3 Jan 2024 11:29:47 -0800 (PST)
Date: Wed, 3 Jan 2024 11:29:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Prototype patch to avoid TREE07 rcu_torture_writer() stalls
Message-ID: <a40344c8-a260-41f3-bd7a-6a63d8660489@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Frederic,

You mentioned rcu_torture_writer() stall issues on TREE07.  Does the
patch shown below help?

If so, I predict that your bisection will converge on commit af19a2526cba9
("rcutorture: Add mid-sized stall to TREE07").

							Thanx, Paul

------------------------------------------------------------------------

commit 7e9794bb7017593da427f555e4e23da2d42744e5
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jan 3 10:59:25 2024 -0800

    rcutorture: Suppress rtort_pipe_count warnings until after stalls
    
    Currently, if rcu_torture_writer() sees fewer than ten grace periods
    having elapsed during a call to stutter_wait() that actually waited,
    the rtort_pipe_count warning is emitted.  This has worked well for
    a long time.  Except that the rcutorture TREE07 scenario now does a
    short-term 14-second RCU CPU stall, which can most definitely case
    false-positive rtort_pipe_count warnings.
    
    This commit therefore changes rcu_torture_writer() to compute the
    full expected holdoff and stall duration, and to refuse to report any
    rtort_pipe_count warnings until after all stalls have completed.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 50ac86a34876..b4317ef1b092 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1372,9 +1372,13 @@ rcu_torture_writer(void *arg)
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
+	unsigned long stallsdone = jiffies;
 	bool stutter_waited;
 	unsigned long ulo[NUM_ACTIVE_RCU_POLL_OLDSTATE];
 
+	// If a new stall test is added, this must be adjusted.
+	if (stall_cpu_holdoff + stall_gp_kthread + stall_cpu)
+		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) * HZ;
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
@@ -1580,11 +1584,11 @@ rcu_torture_writer(void *arg)
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    boot_ended)
+		    boot_ended &&
+		    time_after(jiffies, stallsdone))
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
-				    rcu_access_pointer(rcu_torture_current) !=
-				    &rcu_tortures[i]) {
+				    rcu_access_pointer(rcu_torture_current) != &rcu_tortures[i]) {
 					tracing_off();
 					show_rcu_gp_kthreads();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
@@ -2445,7 +2449,8 @@ static struct notifier_block rcu_torture_stall_block = {
 
 /*
  * CPU-stall kthread.  It waits as specified by stall_cpu_holdoff, then
- * induces a CPU stall for the time specified by stall_cpu.
+ * induces a CPU stall for the time specified by stall_cpu.  If a new
+ * stall test is added, stallsdone in rcu_torture_writer() must be adjusted.
  */
 static int rcu_torture_stall(void *args)
 {

