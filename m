Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE18055ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbjLENaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442202AbjLENam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:30:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBDD1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:30:48 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5DMKM6009958;
        Tue, 5 Dec 2023 13:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6ihL5NvRIOLsOPu0B41OLQgQb7BVJSoF09y4pnAe2uI=;
 b=POdtqm1rQKwGPcu6D1IU2fnqBB/DhXZK6L11REuvVd3gOqjjAmjqctGaVaabWzrhTm0j
 8CC4GhE6Am0P0BtMciqngLFdgkUPNrfdlt0Hnj2OoBZ8Sznmf73vQW84E68JbQRnmJby
 OnGynS2jENkXUE2JfL2iFhegmDL4HWFLZB01t7+9y1eA6jlMm1NYB+2iJQ4NehVmLy33
 +0VURI6hXKds6asJ19Q+Z8cYYNdI9k2tH+CeRnNTew9Mw+bGNU3uf8GZMzwrxHf8YJUk
 Ir1SrA/C1KMIPeV2wkHifqn5CF4G37l20lr8l5Jh6WEGykLBeKMVs4H3MLwMzxjCCav8 UQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut4p9rbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5ArfTp009203;
        Tue, 5 Dec 2023 13:30:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdkxqe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5DUOJd41550300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 13:30:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0376F2004B;
        Tue,  5 Dec 2023 13:30:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E810920040;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B5CF0E16C2; Tue,  5 Dec 2023 14:30:23 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/3] move enter_from_user_mode() to header file
Date:   Tue,  5 Dec 2023 14:30:14 +0100
Message-Id: <20231205133015.752543-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205133015.752543-1-svens@linux.ibm.com>
References: <20231205133015.752543-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ItzOICmd-dOkjSLQXRpFsmrACIAo6_Vu
X-Proofpoint-GUID: ItzOICmd-dOkjSLQXRpFsmrACIAo6_Vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_08,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1011 mlxlogscore=543 bulkscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow inlining of enter_from_user_mode(), move it to common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 15 ++++++++++++++-
 kernel/entry/common.c        | 26 +++-----------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f0f1a26dc638..e2c62d111318 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -11,6 +11,7 @@
 #include <linux/livepatch.h>
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
+#include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
 
@@ -102,7 +103,19 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-void enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
 
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6ba2bcfbe32c..90b995facd7a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,26 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* See comment for enter_from_user_mode() in entry-common.h */
-static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -105,7 +85,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -117,7 +97,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
@@ -215,7 +195,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-- 
2.40.1

