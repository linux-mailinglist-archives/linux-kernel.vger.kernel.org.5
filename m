Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755579D490
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjILPPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjILPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:15:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E612E;
        Tue, 12 Sep 2023 08:15:37 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694531735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BA9ZKtT0aHe5e3qMEBNzLmWzYUXRj7Y7VShceSJve8=;
        b=HHQZMT8dNPjtgGXmkNo4IQU5gdwvp4W35HMijNmyAoHxp1ckfDFFWJjTEeGC016Qx5BtwQ
        sVtFKnTaHvcSD72rZPyKTk6yq5906WXohUEeBvbnaxdRiAxK2Pseh2NFcqHDpXThEQ6sJK
        YjCRJ/9kS+7sEzYavaWlrz98EKGWKpsGRsAdLPnM1ZA8jEos8Ilg+T3V5a6NUZ+aBg0SGh
        9sAm3g7Lplx3g32bePhfJcGFFa0hNBUihauZGqNgaH6Z7aUmL3DqSqSszP268wGal6GE3U
        sZPhvgvlB1zAaHn6BamSo/vGubnS544XUzPy9ZeXj4+IxPI4QAQu873tl9pxaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694531735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BA9ZKtT0aHe5e3qMEBNzLmWzYUXRj7Y7VShceSJve8=;
        b=JviQWbSrlIFhCbUAT8mYU5SuZI9jfFJ5i1JHGBOaLTpMD/qA8Ys5JEOueIdaQZfiYqlooz
        Ypg5E4xPWpG5tgDg==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86/sched: Restore the SD_ASYM_PACKING flag in
 the DIE domain
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Caleb Callaway <caleb.callaway@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
References: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169453173405.27769.6423819752573472154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c7d1d6e2b9e555d18d5e742fa67a16a0f36ef8d6
Gitweb:        https://git.kernel.org/tip/c7d1d6e2b9e555d18d5e742fa67a16a0f36ef8d6
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Mon, 14 Aug 2023 20:57:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 12 Sep 2023 17:07:34 +02:00

x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain

Commit 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup") dropped the
SD_ASYM_PACKING flag in the DIE domain added in commit 044f0e27dec6
("x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
processors"). Restore it on hybrid processors.

The die-level domain does not depend on any build configuration and now
x86_sched_itmt_flags() is always needed. Remove the build dependency on
CONFIG_SCHED_[SMT|CLUSTER|MC].

Fixes: 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Caleb Callaway <caleb.callaway@intel.com>
Link: https://lkml.kernel.org/r/20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/smpboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d40ed3a..266d05e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,7 +579,6 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -603,7 +602,14 @@ static int x86_cluster_flags(void)
 	return cpu_cluster_flags() | x86_sched_itmt_flags();
 }
 #endif
-#endif
+
+static int x86_die_flags(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+	       return x86_sched_itmt_flags();
+
+	return 0;
+}
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
@@ -640,7 +646,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
 		};
 	}
 
