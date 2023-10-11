Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE407C4FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjJKKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjJKKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:18:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29B10C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:07:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S57f35Mm2zVl8Q;
        Wed, 11 Oct 2023 18:04:11 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:07:40 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <broonie@kernel.org>,
        <anshuman.khandual@arm.com>, <alexandru.elisei@arm.com>,
        <sashal@kernel.org>, <maz@kernel.org>,
        <gregkh@linuxfoundation.org>, <james.morse@arm.com>,
        <pcc@google.com>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 06/15] arm64: allow kprobes on EL0 handlers
Date:   Wed, 11 Oct 2023 10:06:46 +0000
Message-ID: <20231011100655.979626-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100655.979626-1-ruanjinjie@huawei.com>
References: <20231011100655.979626-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

commit b3a0c010e900a9f89dcd99f10bd8f7538d21b0a9 upstream.

Currently do_sysinstr() and do_cp15instr() are marked with
NOKPROBE_SYMBOL(). However, these are only called for exceptions taken
from EL0, and there is no risk of recursion in kprobes, so this is not
necessary.

Remove the NOKPROBE_SYMBOL() annotation, and rename the two functions to
more clearly indicate that these are solely for exceptions taken from
EL0, better matching the names used by the lower level entry points in
entry-common.c.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-2-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/exception.h | 4 ++--
 arch/arm64/kernel/entry-common.c   | 4 ++--
 arch/arm64/kernel/traps.c          | 6 ++----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 81b559a780e8..7466239adac0 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -66,10 +66,10 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned long esr, struct pt_regs *regs);
-void do_sysinstr(unsigned long esr, struct pt_regs *regs);
+void do_el0_sys(unsigned long esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr);
-void do_cp15instr(unsigned long esr, struct pt_regs *regs);
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 6caab4453b11..31bdaccabd29 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -541,7 +541,7 @@ static void noinstr el0_sys(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_sysinstr(esr, regs);
+	do_el0_sys(esr, regs);
 	exit_to_user_mode(regs);
 }
 
@@ -728,7 +728,7 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_cp15instr(esr, regs);
+	do_el0_cp15(esr, regs);
 	exit_to_user_mode(regs);
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ae1844e9daf0..2ff0c8ddcacf 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -742,7 +742,7 @@ static const struct sys64_hook cp15_64_hooks[] = {
 	{},
 };
 
-void do_cp15instr(unsigned long esr, struct pt_regs *regs)
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook, *hook_base;
 
@@ -780,10 +780,9 @@ void do_cp15instr(unsigned long esr, struct pt_regs *regs)
 	 */
 	do_undefinstr(regs, esr);
 }
-NOKPROBE_SYMBOL(do_cp15instr);
 #endif
 
-void do_sysinstr(unsigned long esr, struct pt_regs *regs)
+void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook;
 
@@ -800,7 +799,6 @@ void do_sysinstr(unsigned long esr, struct pt_regs *regs)
 	 */
 	do_undefinstr(regs, esr);
 }
-NOKPROBE_SYMBOL(do_sysinstr);
 
 static const char *esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
-- 
2.34.1

