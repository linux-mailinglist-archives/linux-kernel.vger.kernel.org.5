Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0D75F616
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGXMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGXMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:18:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87F19BF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:17:55 -0700 (PDT)
X-UUID: 0286bff42a1c11ee9cb5633481061a41-20230724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4LFBjeliIMQEMATSDqju1i8NT+khZ1O/cNZSDh0O00U=;
        b=ls9uPhUUxCBGK10stm1LX/DHzypIzhKOTOAtwjX/hGkEgEQifMDU7H4WZ5//FsprNpODQ0IJ41UJEN/BkLtSnEc72ntJiDy0KowhJWri8mZkhv/D4oRrqvphyMPnQ+0YJuY2+Bi/gAYJfmiorago9VczPRBS94vYQVYXXUJgSdc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:aaaa10b5-8215-43eb-87df-1980f4f33404,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:e7562a7,CLOUDID:8d51fa87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0286bff42a1c11ee9cb5633481061a41-20230724
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 867062005; Mon, 24 Jul 2023 20:17:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jul 2023 20:17:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jul 2023 20:17:07 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] ARM: ptrace: fix scno of -1 cause SIGILL
Date:   Mon, 24 Jul 2023 20:16:55 +0800
Message-ID: <20230724121655.7894-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit [1], the -1 scno is used as a special scno when the task's
syscall is traced.

After commit [2], PTRACE_SET_SYSCALL will always mask syscall with
__NR_SYSCALL_MASK, this makes the condition `cmp scno, #-1` broken,
and some test like Android VTS[3] is also failed because SIGILL
interrupt the test program.

Let's test with `and` logic with #0x0ff000. Instead of #__NR_SYSCALL_MASK
because of the constraint of ARM Operand2 rules and avoid conflicting
with ARM private syscall.

[1] commit ad75b51459ae ("ARM: 7579/1: arch/allow a scno of -1 to not cause a SIGILL")
[2] commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
[3] vts_linux_kselftest_arm_32 seccomp_seccomp_bpf_arm_32#seccomp_seccomp_bpf_arm_32

Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm/kernel/entry-common.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index bcc4c9ec3aa4..8ff3ff476266 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -298,8 +298,15 @@ __sys_trace:
 	bl	syscall_trace_enter
 	mov	scno, r0
 	invoke_syscall tbl, scno, r10, __sys_trace_return, reload=1
-	cmp	scno, #-1			@ skip the syscall?
-	bne	2b
+	/*
+	 * We'd like to skip scno=-1 for avoiding SIGILL for tracer,
+	 * however, tracer or seccomp may have changed syscall and masked
+	 * with __NR_SYSCALL_MASK, make sure -1 is compared with correct
+	 * masked syscall number.
+	 */
+	and r10, scno, #0x0ff000
+	cmp r10, #0x0ff000
+	bne 2b
 	add	sp, sp, #S_OFF			@ restore stack
 
 __sys_trace_return_nosave:
-- 
2.18.0

