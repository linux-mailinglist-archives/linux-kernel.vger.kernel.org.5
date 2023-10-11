Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3AA7C4FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbjJKKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjJKKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622611D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:39 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S57cH4SQ9zkY1J;
        Wed, 11 Oct 2023 18:02:39 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:06:36 +0800
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
Subject: [PATCH v5.10 RESEND 11/15] arm64: armv8_deprecated: fold ops into insn_emulation
Date:   Wed, 11 Oct 2023 10:05:41 +0000
Message-ID: <20231011100545.979577-12-ruanjinjie@huawei.com>
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

commit b4453cc8a7ebbd45436a8cd3ffeaa069ceac146f upstream.

The code for emulating deprecated instructions has two related
structures: struct insn_emulation_ops and struct insn_emulation, where
each struct insn_emulation_ops is associated 1-1 with a struct
insn_emulation.

It would be simpler to combine the two into a single structure, removing
the need for (unconditional) dynamic allocation at boot time, and
simplifying some runtime pointer chasing.

This patch merges the two structures together.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-7-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 76 ++++++++++++----------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 91b8a8378ba3..ada20ed7ecb6 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -41,16 +41,12 @@ enum legacy_insn_status {
 	INSN_OBSOLETE,
 };
 
-struct insn_emulation_ops {
-	const char		*name;
-	enum legacy_insn_status	status;
-	struct undef_hook	*hooks;
-	int			(*set_hw_mode)(bool enable);
-};
-
 struct insn_emulation {
-	struct list_head node;
-	struct insn_emulation_ops *ops;
+	const char			*name;
+	struct list_head		node;
+	enum legacy_insn_status		status;
+	struct undef_hook		*hooks;
+	int				(*set_hw_mode)(bool enable);
 	int current_mode;
 	int min;
 	int max;
@@ -61,48 +57,48 @@ static int nr_insn_emulated __initdata;
 static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
 static DEFINE_MUTEX(insn_emulation_mutex);
 
-static void register_emulation_hooks(struct insn_emulation_ops *ops)
+static void register_emulation_hooks(struct insn_emulation *insn)
 {
 	struct undef_hook *hook;
 
-	BUG_ON(!ops->hooks);
+	BUG_ON(!insn->hooks);
 
-	for (hook = ops->hooks; hook->instr_mask; hook++)
+	for (hook = insn->hooks; hook->instr_mask; hook++)
 		register_undef_hook(hook);
 
-	pr_notice("Registered %s emulation handler\n", ops->name);
+	pr_notice("Registered %s emulation handler\n", insn->name);
 }
 
-static void remove_emulation_hooks(struct insn_emulation_ops *ops)
+static void remove_emulation_hooks(struct insn_emulation *insn)
 {
 	struct undef_hook *hook;
 
-	BUG_ON(!ops->hooks);
+	BUG_ON(!insn->hooks);
 
-	for (hook = ops->hooks; hook->instr_mask; hook++)
+	for (hook = insn->hooks; hook->instr_mask; hook++)
 		unregister_undef_hook(hook);
 
-	pr_notice("Removed %s emulation handler\n", ops->name);
+	pr_notice("Removed %s emulation handler\n", insn->name);
 }
 
 static void enable_insn_hw_mode(void *data)
 {
 	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(true);
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(true);
 }
 
 static void disable_insn_hw_mode(void *data)
 {
 	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(false);
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(false);
 }
 
 /* Run set_hw_mode(mode) on all active CPUs */
 static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
 {
-	if (!insn->ops->set_hw_mode)
+	if (!insn->set_hw_mode)
 		return -EINVAL;
 	if (enable)
 		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
@@ -126,9 +122,9 @@ static int run_all_insn_set_hw_mode(unsigned int cpu)
 	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
 	list_for_each_entry(insn, &insn_emulation, node) {
 		bool enable = (insn->current_mode == INSN_HW);
-		if (insn->ops->set_hw_mode && insn->ops->set_hw_mode(enable)) {
+		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
 			pr_warn("CPU[%u] cannot support the emulation of %s",
-				cpu, insn->ops->name);
+				cpu, insn->name);
 			rc = -EINVAL;
 		}
 	}
@@ -145,11 +141,11 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
 	case INSN_UNDEF: /* Nothing to be done */
 		break;
 	case INSN_EMULATE:
-		remove_emulation_hooks(insn->ops);
+		remove_emulation_hooks(insn);
 		break;
 	case INSN_HW:
 		if (!run_all_cpu_set_hw_mode(insn, false))
-			pr_notice("Disabled %s support\n", insn->ops->name);
+			pr_notice("Disabled %s support\n", insn->name);
 		break;
 	}
 
@@ -157,31 +153,25 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
 	case INSN_UNDEF:
 		break;
 	case INSN_EMULATE:
-		register_emulation_hooks(insn->ops);
+		register_emulation_hooks(insn);
 		break;
 	case INSN_HW:
 		ret = run_all_cpu_set_hw_mode(insn, true);
 		if (!ret)
-			pr_notice("Enabled %s support\n", insn->ops->name);
+			pr_notice("Enabled %s support\n", insn->name);
 		break;
 	}
 
 	return ret;
 }
 
-static void __init register_insn_emulation(struct insn_emulation_ops *ops)
+static void __init register_insn_emulation(struct insn_emulation *insn)
 {
 	unsigned long flags;
-	struct insn_emulation *insn;
-
-	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
-	if (!insn)
-		return;
 
-	insn->ops = ops;
 	insn->min = INSN_UNDEF;
 
-	switch (ops->status) {
+	switch (insn->status) {
 	case INSN_DEPRECATED:
 		insn->current_mode = INSN_EMULATE;
 		/* Disable the HW mode if it was turned on at early boot time */
@@ -247,7 +237,7 @@ static void __init register_insn_emulation_sysctl(void)
 		sysctl->mode = 0644;
 		sysctl->maxlen = sizeof(int);
 
-		sysctl->procname = insn->ops->name;
+		sysctl->procname = insn->name;
 		sysctl->data = &insn->current_mode;
 		sysctl->extra1 = &insn->min;
 		sysctl->extra2 = &insn->max;
@@ -451,7 +441,7 @@ static struct undef_hook swp_hooks[] = {
 	{ }
 };
 
-static struct insn_emulation_ops swp_ops = {
+static struct insn_emulation insn_swp = {
 	.name = "swp",
 	.status = INSN_OBSOLETE,
 	.hooks = swp_hooks,
@@ -538,7 +528,7 @@ static struct undef_hook cp15_barrier_hooks[] = {
 	{ }
 };
 
-static struct insn_emulation_ops cp15_barrier_ops = {
+static struct insn_emulation insn_cp15_barrier = {
 	.name = "cp15_barrier",
 	.status = INSN_DEPRECATED,
 	.hooks = cp15_barrier_hooks,
@@ -611,7 +601,7 @@ static struct undef_hook setend_hooks[] = {
 	{}
 };
 
-static struct insn_emulation_ops setend_ops = {
+static struct insn_emulation insn_setend = {
 	.name = "setend",
 	.status = INSN_DEPRECATED,
 	.hooks = setend_hooks,
@@ -625,14 +615,14 @@ static struct insn_emulation_ops setend_ops = {
 static int __init armv8_deprecated_init(void)
 {
 	if (IS_ENABLED(CONFIG_SWP_EMULATION))
-		register_insn_emulation(&swp_ops);
+		register_insn_emulation(&insn_swp);
 
 	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
-		register_insn_emulation(&cp15_barrier_ops);
+		register_insn_emulation(&insn_cp15_barrier);
 
 	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
 		if (system_supports_mixed_endian_el0())
-			register_insn_emulation(&setend_ops);
+			register_insn_emulation(&insn_setend);
 		else
 			pr_info("setend instruction emulation is not supported on this system\n");
 	}
-- 
2.34.1

