Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC20798C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbjIHSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjIHSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:17:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31860268A;
        Fri,  8 Sep 2023 11:16:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7472AC433AD;
        Fri,  8 Sep 2023 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196139;
        bh=oiCBIEZY60tSkOgWmSR8mY0q64KgwOAVwN8avxxJu5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eohpkLfuw3frwShv4ONacJKC8ofgAcuG5K6Q1ih6lWcbupn5P39g6hnEoTA8Uxj5m
         DBb9ZknLN9lyG0y0Fw0FvUghUxmgXlgXpW7bpCbO9HK0MyVBVxCMuKmeFBe+CCIb0f
         2yR9gdO9l2K6PwTs3KKCpu+moig+oeiy53HsyVFADaqNTnmqccuNn4gedQksRsnIOg
         T5Wj13qN7Pf+d+ut9LSSAIQNcviFfT1bL6Kkv7tQKgU6Rcymsy7lk5Cuxvbie98Izx
         CfonofO9M2omXDaJZHHBISV3NQ6gmJ+3F/RI9svMV3YaC7odwXC+wxOgI8hTLoUNA1
         /MYvKXHxpRheg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 04/10] scftorture: Forgive memory-allocation failure if KASAN
Date:   Fri,  8 Sep 2023 14:01:56 -0400
Message-Id: <20230908180203.3458330-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180203.3458330-1-sashal@kernel.org>
References: <20230908180203.3458330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index 5d113aa59e773..83c33ba0ca7e0 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -171,7 +171,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
@@ -323,7 +324,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
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

