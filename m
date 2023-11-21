Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844E7F2D88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKUMrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjKUMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:47:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FEE1AA;
        Tue, 21 Nov 2023 04:47:29 -0800 (PST)
Date:   Tue, 21 Nov 2023 12:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700570848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm4rGOTIFKOao0hf47WFW6l4sHhRkc9cnu8zuTG+csc=;
        b=dnZwKO/ji7wWRY8HTuoXrllWfJsRBDgEssJMuYxS19CjXzXvuEPJ/VkLyy5RZ4j0jrRPmV
        tPib/EPv8XMhneK9v+QHWfcqRAFlyn1c4XO5WpsOxBXJxmr9KSdRcgEN6Cs+1wvPUcp7PZ
        w5RnWBbOfWLANQdOZWmD08IlZAGRS7JLigmfuvuZ0YjkI539WfW3/I3GhWB3PlmDimlHau
        qITZ3AedXEir9CrRjI9zxZUEPamDrzxvXH3qFjurItZpQWicV9w9jXPJ2PlaBmlQ5nzD0O
        fY7q7l61JVQcH3WxGctRrtO46A4E1z983Jfw4ZY870PcfhdIsBt5zw5c/1skuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700570848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm4rGOTIFKOao0hf47WFW6l4sHhRkc9cnu8zuTG+csc=;
        b=3xYDM3xNkE7fJKwxuP5W0xTU/MM9NUMlRqJHAWn6YWJ4svrJN+Xs8a3rMYTuCUpmiP/dCV
        HiqtonZOfX8uURCw==
From:   "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Correct incorrect 'or' operation
 for PMU capabilities
Cc:     Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231121014628.729989-1-dapeng1.mi@linux.intel.com>
References: <20231121014628.729989-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170057084740.398.2179310454610572769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e8df9d9f4209c04161321d8c12640ae560f65939
Gitweb:        https://git.kernel.org/tip/e8df9d9f4209c04161321d8c12640ae560f65939
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 21 Nov 2023 09:46:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Nov 2023 13:44:36 +01:00

perf/x86/intel: Correct incorrect 'or' operation for PMU capabilities

When running perf-stat command on Intel hybrid platform, perf-stat
reports the following errors:

  sudo taskset -c 7 ./perf stat -vvvv -e cpu_atom/instructions/ sleep 1

  Opening: cpu/cycles/:HG
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    config                           0xa00000000
    disabled                         1
  ------------------------------------------------------------
  sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -16

   Performance counter stats for 'sleep 1':

       <not counted>      cpu_atom/instructions/

It looks the cpu_atom/instructions/ event can't be enabled on atom PMU
even when the process is pinned on atom core. Investigation shows that
exclusive_event_init() helper always returns -EBUSY error in the perf
event creation. That's strange since the atom PMU should not be an
exclusive PMU.

Further investigation shows the issue was introduced by commit:

  97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")

The commit originally intents to clear the bit PERF_PMU_CAP_AUX_OUTPUT
from PMU capabilities if intel_cap.pebs_output_pt_available is not set,
but it incorrectly uses 'or' operation and leads to all PMU capabilities
bits are set to 1 except bit PERF_PMU_CAP_AUX_OUTPUT.

Testing this fix on Intel hybrid platforms, the observed issues
disappear.

Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231121014628.729989-1-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794..ce1c777 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4660,7 +4660,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	if (pmu->intel_cap.pebs_output_pt_available)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 	else
-		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
+		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->num_counters,
