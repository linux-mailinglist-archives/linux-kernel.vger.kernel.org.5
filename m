Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1B7C4F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjJKKHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJKKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC697115
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:37 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S57cF3Jq7zkY4j;
        Wed, 11 Oct 2023 18:02:37 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:06:34 +0800
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
Subject: [PATCH v5.10 RESEND 09/15] arm64: factor insn read out of call_undef_hook()
Date:   Wed, 11 Oct 2023 10:05:39 +0000
Message-ID: <20231011100545.979577-10-ruanjinjie@huawei.com>
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

commit dbfbd87efa79575491af0ba1a87bf567eaea6cae upstream.

Subsequent patches will rework EL0 UNDEF handling, removing the need for
struct undef_hook and call_undef_hook. In preparation for those changes,
this patch factors the logic for reading user instructions out of
call_undef_hook() and into a new user_insn_read() helper, matching the
style of the existing aarch64_insn_read() helper used for reading kernel
instructions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-5-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/traps.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 15d490ef7462..be9c7bb89e98 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -303,25 +303,22 @@ void unregister_undef_hook(struct undef_hook *hook)
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs)
+static int user_insn_read(struct pt_regs *regs, u32 *insnp)
 {
-	struct undef_hook *hook;
-	unsigned long flags;
 	u32 instr;
-	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
 	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le16_to_cpu(instr_le);
 		if (aarch32_insn_is_wide(instr)) {
 			u32 instr2;
 
 			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
-				goto exit;
+				return -EFAULT;
 			instr2 = le16_to_cpu(instr_le);
 			instr = (instr << 16) | instr2;
 		}
@@ -329,10 +326,20 @@ static int call_undef_hook(struct pt_regs *regs)
 		/* 32-bit ARM instruction */
 		__le32 instr_le;
 		if (get_user(instr_le, (__le32 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le32_to_cpu(instr_le);
 	}
 
+	*insnp = instr;
+	return 0;
+}
+
+static int call_undef_hook(struct pt_regs *regs, u32 instr)
+{
+	struct undef_hook *hook;
+	unsigned long flags;
+	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
+
 	raw_spin_lock_irqsave(&undef_lock, flags);
 	list_for_each_entry(hook, &undef_hook, node)
 		if ((instr & hook->instr_mask) == hook->instr_val &&
@@ -340,7 +347,7 @@ static int call_undef_hook(struct pt_regs *regs)
 			fn = hook->fn;
 
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
-exit:
+
 	return fn ? fn(regs, instr) : 1;
 }
 
@@ -392,13 +399,19 @@ void arm64_notify_segfault(unsigned long addr)
 
 void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
+	u32 insn;
+
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
 
-	if (call_undef_hook(regs) == 0)
+	if (user_insn_read(regs, &insn))
+		goto out_err;
+
+	if (call_undef_hook(regs, insn) == 0)
 		return;
 
+out_err:
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
 
-- 
2.34.1

