Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DFA7C4F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjJKKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjJKKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083BF131
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:42 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S57cM4GXrzLqKP;
        Wed, 11 Oct 2023 18:02:43 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:06:39 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yuzenghui@huawei.com>, <anshuman.khandual@arm.com>,
        <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <youngmin.nam@samsung.com>,
        <ardb@kernel.org>, <f.fainelli@gmail.com>, <james.morse@arm.com>,
        <sashal@kernel.org>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 RESEND 13/15] arm64: armv8_deprecated: move aarch32 helper earlier
Date:   Wed, 11 Oct 2023 10:05:43 +0000
Message-ID: <20231011100545.979577-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100545.979577-1-ruanjinjie@huawei.com>
References: <20231011100545.979577-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit 0c5f416219da3795dc8b33e5bb7865a6b3c4e55c upstream.

Subsequent patches will rework the logic in armv8_deprecated.c.

In preparation for subsequent changes, this patch moves some shared logic
earlier in the file. This will make subsequent diffs simpler and easier to
read.

At the same time, drop the `__kprobes` annotation from
aarch32_check_condition(), as this is only used for traps from compat
userspace, and has no risk of recursion within kprobes. As this is the
last kprobes annotation in armve8_deprecated.c, we no longer need to
include <asm/kprobes.h>.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-9-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 39 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 529a877a1bb2..98dc7f8b8c08 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -17,7 +17,6 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
-#include <asm/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace-events-emulation.h"
@@ -52,6 +51,25 @@ struct insn_emulation {
 	int max;
 };
 
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
+
+#define	ARM_OPCODE_CONDITION_UNCOND	0xf
+
+static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
+{
+	u32 cc_bits  = opcode >> 28;
+
+	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
+		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
+			return ARM_OPCODE_CONDTEST_PASS;
+		else
+			return ARM_OPCODE_CONDTEST_FAIL;
+	}
+	return ARM_OPCODE_CONDTEST_UNCOND;
+}
+
 /*
  *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
  *  store-exclusive.
@@ -138,25 +156,6 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	return res;
 }
 
-#define ARM_OPCODE_CONDTEST_FAIL   0
-#define ARM_OPCODE_CONDTEST_PASS   1
-#define ARM_OPCODE_CONDTEST_UNCOND 2
-
-#define	ARM_OPCODE_CONDITION_UNCOND	0xf
-
-static unsigned int __kprobes aarch32_check_condition(u32 opcode, u32 psr)
-{
-	u32 cc_bits  = opcode >> 28;
-
-	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
-		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
-			return ARM_OPCODE_CONDTEST_PASS;
-		else
-			return ARM_OPCODE_CONDTEST_FAIL;
-	}
-	return ARM_OPCODE_CONDTEST_UNCOND;
-}
-
 /*
  * swp_handler logs the id of calling process, dissects the instruction, sanity
  * checks the memory location, calls emulate_swpX for the actual operation and
-- 
2.34.1

