Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D697C4BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjJKH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbjJKH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:27:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC800AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:27:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S546l2SH7zrTSD;
        Wed, 11 Oct 2023 15:25:19 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:27:52 +0800
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
Subject: [PATCH v5.10 01/15] arm64: report EL1 UNDEFs better
Date:   Wed, 11 Oct 2023 07:26:47 +0000
Message-ID: <20231011072701.876772-2-ruanjinjie@huawei.com>
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

If an UNDEFINED exception is taken from EL1, and do_undefinstr() doesn't
find any suitable undef_hook, it will call:

	BUG_ON(!user_mode(regs))

... and the kernel will report a failure witin do_undefinstr() rather
than reporting the original context that the UNDEFINED exception was
taken from. The pt_regs and ESR value reported within the BUG() handler
will be from within do_undefinstr() and the code dump will be for the
BRK in BUG_ON(), which isn't sufficient to debug the cause of the
original exception.

This patch makes the reporting better by having do_undefinstr() call
die() directly in this case to report the original context from which
the UNDEFINED exception was taken.

Prior to this patch, an undefined instruction is reported as:

| kernel BUG at arch/arm64/kernel/traps.c:497!
| Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00127-geff044f1b04e-dirty #3
| Hardware name: linux,dummy-virt (DT)
| pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : do_undefinstr+0x28c/0x2ac
| lr : do_undefinstr+0x298/0x2ac
| sp : ffff800009f63bc0
| x29: ffff800009f63bc0 x28: ffff800009f73c00 x27: ffff800009644a70
| x26: ffff8000096778a8 x25: 0000000000000040 x24: 0000000000000000
| x23: 00000000800000c5 x22: ffff800009894060 x21: ffff800009f63d90
| x20: 0000000000000000 x19: ffff800009f63c40 x18: 0000000000000006
| x17: 0000000000403000 x16: 00000000bfbfd000 x15: ffff800009f63830
| x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000019
| x11: 0101010101010101 x10: 0000000000161b98 x9 : 0000000000000000
| x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
| x5 : ffff800009f761d0 x4 : 0000000000000000 x3 : ffff80000a2b80f8
| x2 : 0000000000000000 x1 : ffff800009f73c00 x0 : 00000000800000c5
| Call trace:
|  do_undefinstr+0x28c/0x2ac
|  el1_undef+0x2c/0x4c
|  el1h_64_sync_handler+0x84/0xd0
|  el1h_64_sync+0x64/0x68
|  setup_arch+0x550/0x598
|  start_kernel+0x88/0x6ac
|  __primary_switched+0xb8/0xc0
| Code: 17ffff95 a9425bf5 17ffffb8 a9025bf5 (d4210000)

With this patch applied, an undefined instruction is reported as:

| Internal error: Oops - Undefined instruction: 0 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00128-gf27cfcc80e52-dirty #5
| Hardware name: linux,dummy-virt (DT)
| pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : setup_arch+0x550/0x598
| lr : setup_arch+0x50c/0x598
| sp : ffff800009f63d90
| x29: ffff800009f63d90 x28: 0000000081000200 x27: ffff800009644a70
| x26: ffff8000096778c8 x25: 0000000000000040 x24: 0000000000000000
| x23: 0000000000000100 x22: ffff800009f69a58 x21: ffff80000a2b80b8
| x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000006
| x17: 0000000000403000 x16: 00000000bfbfd000 x15: ffff800009f63830
| x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000019
| x11: 0101010101010101 x10: 0000000000161b98 x9 : 0000000000000000
| x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
| x5 : 0000000000000008 x4 : 0000000000000010 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
| Call trace:
|  setup_arch+0x550/0x598
|  start_kernel+0x88/0x6ac
|  __primary_switched+0xb8/0xc0
| Code: b4000080 90ffed80 912ac000 97db745f (00000000)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20220913101732.3925290-2-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2cdd53425509..fcc490699c22 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -404,7 +404,9 @@ void do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	BUG_ON(!user_mode(regs));
+	if (!user_mode(regs))
+		die("Oops - Undefined instruction", regs, 0);
+
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
 NOKPROBE_SYMBOL(do_undefinstr);
-- 
2.34.1

