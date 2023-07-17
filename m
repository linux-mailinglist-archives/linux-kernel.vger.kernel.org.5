Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49795756BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGQSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGQSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282608E;
        Mon, 17 Jul 2023 11:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC19611E7;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2389C433C9;
        Mon, 17 Jul 2023 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618043;
        bh=2Slt+IrSEDPTRvcods8x8gQpC5P9QCC5UcNVjkmH36M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4JwDIU2WkXnsck6qwzLK6vpNYgskw2MPjWEXN07ysKStgn6bit89R2rMW/er603p
         Hf885dbVtRykn2Hfodigm5Da9iRLzDgRdmKr1pm3N56kA9VCsXDc5CelNy5EfKMsQu
         ZRqnOCqVlmSJe41TeRVCWDS3xZlqbdHs/P5/XZOKMYlFSw2k+k1CuuvOUiwgDOe7tS
         S2ySKhZRZFhJx8UzHTf37vMO+8xSTvB0OCeKbwrZsP9A2Prdx22y4+rqGLxwBl69Li
         vgtqOkRLA5q6DWJw0Q+apyAG/OA/ck/G9iEnEl8oDT7NyUDP6xrGikkXR15LCHGrsS
         vc5GebhHI7x6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8DF9ECE04CD; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Connor O'Brien <connoro@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH rcu 2/9] torture: Support randomized shuffling for proxy exec testing
Date:   Mon, 17 Jul 2023 11:20:35 -0700
Message-Id: <20230717182042.1098651-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor O'Brien <connoro@google.com>

Currently shuffling sets the same cpu affinities for all tasks,
which makes us less likely to hit paths involving migrating
blocked tasks onto a cpu where they can't run.

This patch adds an element of randomness to allow affinities of
different writer tasks to diverge.

This has helped uncover issues in testing with Proxy Execution

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1a0519b836ac..8be83fdc6be1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -54,6 +54,9 @@ module_param(verbose_sleep_frequency, int, 0444);
 static int verbose_sleep_duration = 1;
 module_param(verbose_sleep_duration, int, 0444);
 
+static int random_shuffle;
+module_param(random_shuffle, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -518,6 +521,7 @@ static void torture_shuffle_task_unregister_all(void)
  */
 static void torture_shuffle_tasks(void)
 {
+	DEFINE_TORTURE_RANDOM(rand);
 	struct shuffle_task *stp;
 
 	cpumask_setall(shuffle_tmp_mask);
@@ -537,8 +541,10 @@ static void torture_shuffle_tasks(void)
 		cpumask_clear_cpu(shuffle_idle_cpu, shuffle_tmp_mask);
 
 	mutex_lock(&shuffle_task_mutex);
-	list_for_each_entry(stp, &shuffle_task_list, st_l)
-		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	list_for_each_entry(stp, &shuffle_task_list, st_l) {
+		if (!random_shuffle || torture_random(&rand) & 0x1)
+			set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	}
 	mutex_unlock(&shuffle_task_mutex);
 
 	cpus_read_unlock();
-- 
2.40.1

