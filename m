Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D32798C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjIHSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbjIHSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:16:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90864212D;
        Fri,  8 Sep 2023 11:16:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B101DC433C7;
        Fri,  8 Sep 2023 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196178;
        bh=x3gniB19YhFkHNpuiOBnIlSK4dZqs3R/6VQq2mQpTpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnfPsBC8AElNcvCKEgFuo0RPqF813WpVjc8gzlNNCnYE952EOKc+wtvdj+VRIGDz4
         C9nyzTyJxrNsh3BaAkKbQkYP7yVN9K4FUpiyLtwz9XbwN22DEwsYgbFG/GIs0Uatmf
         ce62qXwBXOKpQKTpQicF/jYCJiQV1RluAx9WfL2kjFbjH5C7fVd25oFDHmdfoMqNAf
         gb87N0ZiUBooWy23v1+OgGeuWNC0LTh2INJzFJg19Za0XrM9PprI4aRnez5B0v3fda
         bPKpuNQW7Vpl9SGdImGu5xwQNIQscQ6vVrymcgIcimqIQYyzaBkpEhoI8VjiZF0e6i
         GDELFxrsEOb0A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 4/9] scftorture: Forgive memory-allocation failure if KASAN
Date:   Fri,  8 Sep 2023 14:02:35 -0400
Message-Id: <20230908180240.3458469-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180240.3458469-1-sashal@kernel.org>
References: <20230908180240.3458469-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 013608cd0812bdb21fc26d39ed8fdd2fc76e8b9b ]

Kernels built with CONFIG_KASAN=y quarantine newly freed memory in order
to better detect use-after-free errors.  However, this can exhaust memory
more quickly in allocator-heavy tests, which can result in spurious
scftorture failure.  This commit therefore forgives memory-allocation
failure in kernels built with CONFIG_KASAN=y, but continues counting
the errors for use in detailed test-result analyses.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/scftorture.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 27286d99e0c28..41006eef003f6 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -175,7 +175,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
@@ -327,7 +328,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-		if (WARN_ON_ONCE(!scfcp)) {
+		if (!scfcp) {
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_KASAN));
 			atomic_inc(&n_alloc_errs);
 		} else {
 			scfcp->scfc_cpu = -1;
-- 
2.40.1

