Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615867C4BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbjJKH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbjJKH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:27:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCAEBA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:27:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S546n2hJ1z1M9RB;
        Wed, 11 Oct 2023 15:25:21 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:27:54 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yuzenghui@huawei.com>, <anshuman.khandual@arm.com>,
        <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <youngmin.nam@samsung.com>,
        <renzhijie2@huawei.com>, <ardb@kernel.org>, <f.fainelli@gmail.com>,
        <james.morse@arm.com>, <sashal@kernel.org>,
        <scott@os.amperecomputing.com>, <ebiederm@xmission.com>,
        <haibinzhang@tencent.com>, <hewenliang4@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 02/15] arm64: die(): pass 'err' as long
Date:   Wed, 11 Oct 2023 07:26:48 +0000
Message-ID: <20231011072701.876772-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011072701.876772-1-ruanjinjie@huawei.com>
References: <20231011072701.876772-1-ruanjinjie@huawei.com>
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

Recently, we reworked a lot of code to consistentlt pass ESR_ELx as a
64-bit quantity. However, we missed that this can be passed into die()
and __die() as the 'err' parameter where it is truncated to a 32-bit
int.

As notify_die() already takes 'err' as a long, this patch changes die()
and __die() to also take 'err' as a long, ensuring that the full value
of ESR_ELx is retained.

At the same time, die() is updated to consistently log 'err' as a
zero-padded 64-bit quantity.

Subsequent patches will pass the ESR_ELx value to die() for a number of
exceptions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20220913101732.3925290-3-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/system_misc.h | 2 +-
 arch/arm64/kernel/traps.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 1ab63cfbbaf1..624a608933f1 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -18,7 +18,7 @@
 
 struct pt_regs;
 
-void die(const char *msg, struct pt_regs *regs, int err);
+void die(const char *msg, struct pt_regs *regs, long err);
 
 struct siginfo;
 void arm64_notify_die(const char *str, struct pt_regs *regs,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index fcc490699c22..3a88bb1202ad 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -90,12 +90,12 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 
 #define S_SMP " SMP"
 
-static int __die(const char *str, int err, struct pt_regs *regs)
+static int __die(const char *str, long err, struct pt_regs *regs)
 {
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
+	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
 		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
@@ -116,7 +116,7 @@ static DEFINE_RAW_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+void die(const char *str, struct pt_regs *regs, long err)
 {
 	int ret;
 	unsigned long flags;
-- 
2.34.1

