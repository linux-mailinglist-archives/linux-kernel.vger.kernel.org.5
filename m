Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA327AFA92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjI0GCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjI0GB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:01:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6611737;
        Tue, 26 Sep 2023 23:00:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R5xIxM009674;
        Wed, 27 Sep 2023 06:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GQ1DMvTXhhfB80mhrb7a8FVdm5i8kN20QDXnaTJQ5X0=;
 b=LuEl1lj2QYbEkS96V/RWEfLpyKKHrP70u5NKOlJFo4mE1tPsHOYbOY7q5LwKIuNdvHn6
 cpZuIFbpse+C8p6wN9aGgHGpCQmmm7BIo14QCpk8+/84S+eMIln8aNijIyKqceJBrQnx
 buD+EswdrDQW6xH7ugLef+Es2x77Udrvk30ASQBjosMQtFfZwvUJGk9M8uS0GJHn5P00
 VfjmSXu4Jgmi56/x0Y22aCIKmSMHJP4KEUgJxalNYFQffDKJnCDKMNxZWAbF6IwlS41R
 JNcnBFj1BSXIkVC4/s5Zr2iOV0KwgByCpd43WIE/6KptgdiLh/fNNaKTz+66ZBIJpqHf oA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc6hrrryw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:00:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R60L5X006257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:00:21 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 23:00:15 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <linux@armlinux.org.uk>, <mhiramat@kernel.org>, <ardb@kernel.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_lijuang@quicinc.com>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] ARM: kprobes: Explicitly assign register for local variables
Date:   Wed, 27 Sep 2023 13:59:54 +0800
Message-ID: <20230927055954.3755-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EM_2D8QhYkaTF_UKwBvODMXloM1GzFX_
X-Proofpoint-ORIG-GUID: EM_2D8QhYkaTF_UKwBvODMXloM1GzFX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=493 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers r7 is removed in clobber list, so compiler may choose r7 for
local variables usage, while r7 will be actually updated by the inline asm
code. This caused the runtime behavior wrong.
While those kind of reserved registers cannot be set to clobber list
because of error like "inline asm clobber list contains reserved
registers".
To both working for reserved register case and non-reserved register case,
explicitly assign register for local variables which will be used as asm
input.

Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 arch/arm/probes/kprobes/actions-thumb.c | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/probes/kprobes/actions-thumb.c b/arch/arm/probes/kprobes/actions-thumb.c
index 51624fc263fc..f667b2f00b3e 100644
--- a/arch/arm/probes/kprobes/actions-thumb.c
+++ b/arch/arm/probes/kprobes/actions-thumb.c
@@ -442,8 +442,10 @@ static unsigned long __kprobes
 t16_emulate_loregs(probes_opcode_t insn,
 		   struct arch_probes_insn *asi, struct pt_regs *regs)
 {
-	unsigned long oldcpsr = regs->ARM_cpsr;
-	unsigned long newcpsr;
+	register unsigned long oldcpsr asm("r8") = regs->ARM_cpsr;
+	register unsigned long newcpsr asm("r9");
+	register void *rregs asm("r10") = regs;
+	register void *rfn asm("lr") = asi->insn_fn;
 
 	__asm__ __volatile__ (
 		"msr	cpsr_fs, %[oldcpsr]	\n\t"
@@ -454,10 +456,10 @@ t16_emulate_loregs(probes_opcode_t insn,
 		"mov	r7, r11			\n\t"
 		"mrs	%[newcpsr], cpsr	\n\t"
 		: [newcpsr] "=r" (newcpsr)
-		: [oldcpsr] "r" (oldcpsr), [regs] "r" (regs),
-		  [fn] "r" (asi->insn_fn)
+		: [oldcpsr] "r" (oldcpsr), [regs] "r" (rregs),
+		  [fn] "r" (rfn)
 		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r11",
-		  "lr", "memory", "cc"
+		  "memory", "cc"
 		);
 
 	return (oldcpsr & ~APSR_MASK) | (newcpsr & APSR_MASK);
@@ -525,6 +527,9 @@ static void __kprobes
 t16_emulate_push(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
+	register void *rfn asm("lr") = asi->insn_fn;
+	register void *rregs asm("r10") = regs;
+
 	__asm__ __volatile__ (
 		"mov	r11, r7			\n\t"
 		"ldr	r9, [%[regs], #13*4]	\n\t"
@@ -534,9 +539,9 @@ t16_emulate_push(probes_opcode_t insn,
 		"str	r9, [%[regs], #13*4]	\n\t"
 		"mov	r7, r11			\n\t"
 		:
-		: [regs] "r" (regs), [fn] "r" (asi->insn_fn)
+		: [regs] "r" (rregs), [fn] "r" (rfn)
 		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r8", "r9", "r11",
-		  "lr", "memory", "cc"
+		  "memory", "cc"
 		);
 }
 
@@ -561,6 +566,9 @@ static void __kprobes
 t16_emulate_pop_nopc(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
+	register void *rfn asm("lr") = asi->insn_fn;
+	register void *rregs asm("r8") = regs;
+
 	__asm__ __volatile__ (
 		"mov	r11, r7			\n\t"
 		"ldr	r9, [%[regs], #13*4]	\n\t"
@@ -570,9 +578,9 @@ t16_emulate_pop_nopc(probes_opcode_t insn,
 		"str	r9, [%[regs], #13*4]	\n\t"
 		"mov	r7, r11			\n\t"
 		:
-		: [regs] "r" (regs), [fn] "r" (asi->insn_fn)
+		: [regs] "r" (rregs), [fn] "r" (rfn)
 		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
-		  "lr", "memory", "cc"
+		  "memory", "cc"
 		);
 }
 
@@ -581,6 +589,8 @@ t16_emulate_pop_pc(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
 	register unsigned long pc asm("r8");
+	register void *rfn asm("lr") = asi->insn_fn;
+	register void *rregs asm("r10") = regs;
 
 	__asm__ __volatile__ (
 		"mov	r11, r7			\n\t"
@@ -591,9 +601,9 @@ t16_emulate_pop_pc(probes_opcode_t insn,
 		"str	r9, [%[regs], #13*4]	\n\t"
 		"mov	r7, r11			\n\t"
 		: "=r" (pc)
-		: [regs] "r" (regs), [fn] "r" (asi->insn_fn)
+		: [regs] "r" (rregs), [fn] "r" (rfn)
 		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
-		  "lr", "memory", "cc"
+		  "memory", "cc"
 		);
 
 	bx_write_pc(pc, regs);

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.17.1

