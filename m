Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BD7665F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjG1H6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjG1H6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:58:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C463598;
        Fri, 28 Jul 2023 00:57:58 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkJmbLByvVLLbdC4tk/TA0S14VRcxaBYW/wOJ5jRGtg=;
        b=ohqTXWgPMsAgCzfdbrWAqv6qFru6K7gte+hLZG+lwGOMeaikQaxFL0DZTzGMkmqjASSyEK
        /5ovfShF8kxyShTAYQUSgC5/ceup9A8w8m9Q0CX3VlgWf/pnyQ4rSmxGK47x52r970ZkXu
        DaredsqRCQ8n2dQXclsdyh06tAzYzDSEZW6EeiKuIdiqaAQkw/1YmZNy9JSkCDxgxtCJH8
        dpDf8+JpQHmn2XcDiynUYGuxTQbGCL+05y3QkdsTDt83xZMkIvIt/9rsK82F6FwYzucM0E
        65NVH5QgqEOmQal3i1FxL0mTnV0qk2akhYaTa3cc15Werix60H1jjZW9qLHcnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkJmbLByvVLLbdC4tk/TA0S14VRcxaBYW/wOJ5jRGtg=;
        b=IfwLtX191mJLFH5Os9LZK7V92Xd3ve24a+XZq+F0Ks/DdpNt17jPD+nvTa+l/Sgs4ZE4dp
        UfxY+ffwy6fy+HDA==
From:   "tip-bot2 for Laurent Dufour" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove dependancy against
 cpu_primary_thread_mask
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-2-ldufour@linux.ibm.com>
References: <20230705145143.40545-2-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107559.28540.11243157708630222054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     7a4dcb4a5de1214c4a59448a759e2e264c2c4473
Gitweb:        https://git.kernel.org/tip/7a4dcb4a5de1214c4a59448a759e2e264c2c4473
Author:        Laurent Dufour <ldufour@linux.ibm.com>
AuthorDate:    Wed, 05 Jul 2023 16:51:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:36 +02:00

cpu/hotplug: Remove dependancy against cpu_primary_thread_mask

The commit 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to
CPUHP_BP_KICK_AP_STATE") introduce a dependancy against a global variable
cpu_primary_thread_mask exported by the X86 code. This variable is only
used when CONFIG_HOTPLUG_PARALLEL is set.

Since cpuhp_get_primary_thread_mask() and cpuhp_smt_aware() are only used
when CONFIG_HOTPLUG_PARALLEL is set, don't define them when it is not set.

No functional change.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-2-ldufour@linux.ibm.com

---
 kernel/cpu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 88a7ede..03309f2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -650,22 +650,8 @@ bool cpu_smt_possible(void)
 }
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
 
-static inline bool cpuhp_smt_aware(void)
-{
-	return topology_smt_supported();
-}
-
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_primary_thread_mask;
-}
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
-static inline bool cpuhp_smt_aware(void) { return false; }
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_present_mask;
-}
 #endif
 
 static inline enum cpuhp_state
@@ -1793,6 +1779,16 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+static inline bool cpuhp_smt_aware(void)
+{
+	return topology_smt_supported();
+}
+
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_primary_thread_mask;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state
