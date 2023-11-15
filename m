Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66447EC019
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjKOJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjKOJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9BB11C;
        Wed, 15 Nov 2023 01:58:59 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF97QW7010206;
        Wed, 15 Nov 2023 09:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GLwXmtvMjTXbDM2nrBNbYXCfGPprVUbImDq/3p/gXHw=;
 b=AIPNsjcAFSJJ3IGhVEtFcsbDJvAR3B/2YZL7aNtMmPmoenYArHvnh1g38/huWqH89Jsn
 pCng7ay0mjNRMzyBD/7mWWHKq5JAyUCV+rHoT6wVCbQYtvoOPMUtptUnELWKnkx6Bc5H
 vcTEU2pAxR8DrZMZLNhY9/fC6aWgtM82m8UN7TBgnOPdjdaMbgfCjJ+RkcmkX+R0qK7N
 1f7ttsQqUmiEDNbuO11nRAcrsRe4JBvygt8ss4QRjNv4KvPDoYFBFkaqj1SEN5zAlITy
 ivyay1Zrx/bTqjdM5lJSb5N90hObF74WRy8rSjp/Pu0ni8IMAdG7Sp9guvOLwkEFUQbB Xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfka9hdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 09:58:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF9woR1005753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 09:58:50 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 01:58:44 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <linux@armlinux.org.uk>, <ardb@kernel.org>, <mhiramat@kernel.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lijuang@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/1] ARM: kprobes: Explicitly reserve r7 for local variables
Date:   Wed, 15 Nov 2023 17:58:30 +0800
Message-ID: <20231115095830.20607-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CnoBJsaifzwKBk2Ab9I793wa8RzQnEcq
X-Proofpoint-GUID: CnoBJsaifzwKBk2Ab9I793wa8RzQnEcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_07,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=334 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Explicitly reserve r7 by adding attribute no-omit-frame-pointer for needed
function, then in T32 asm code r7 is used as a frame pointer and is not
available for use as a general-purpose register.
Note that "no-omit-frame-pointer" will make the code size a little bigger
to store the stack frame pointer. So limited to needed functions can have
the less impact than the full source file.

Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
Cc: stable@vger.kernel.org
---
 arch/arm/probes/kprobes/actions-thumb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/probes/kprobes/actions-thumb.c b/arch/arm/probes/kprobes/actions-thumb.c
index 51624fc263fc..c2fdaf9f6dba 100644
--- a/arch/arm/probes/kprobes/actions-thumb.c
+++ b/arch/arm/probes/kprobes/actions-thumb.c
@@ -438,7 +438,7 @@ t16_simulate_branch(probes_opcode_t insn,
 	regs->ARM_pc = pc + (offset * 2);
 }
 
-static unsigned long __kprobes
+static unsigned long __kprobes __attribute__((optimize("no-omit-frame-pointer")))
 t16_emulate_loregs(probes_opcode_t insn,
 		   struct arch_probes_insn *asi, struct pt_regs *regs)
 {
@@ -521,7 +521,7 @@ t16_decode_hiregs(probes_opcode_t insn, struct arch_probes_insn *asi,
 	return INSN_GOOD;
 }
 
-static void __kprobes
+static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
 t16_emulate_push(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
@@ -557,7 +557,7 @@ t16_decode_push(probes_opcode_t insn, struct arch_probes_insn *asi,
 	return INSN_GOOD;
 }
 
-static void __kprobes
+static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
 t16_emulate_pop_nopc(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
@@ -576,7 +576,7 @@ t16_emulate_pop_nopc(probes_opcode_t insn,
 		);
 }
 
-static void __kprobes
+static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
 t16_emulate_pop_pc(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {

base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
-- 
2.17.1

