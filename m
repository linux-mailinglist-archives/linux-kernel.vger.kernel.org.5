Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1E8055EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442191AbjLENan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442197AbjLENam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:30:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123EBA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:30:46 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5DCLWx027348;
        Tue, 5 Dec 2023 13:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2kATv5htjxiKX4ukRJoogxRpzBhC6yrnbatuoEfa0/Q=;
 b=rRzqojxhoX7omjdRjpBOMLm8iFxT2bH1+cVmA9yckRJ8z2BSZevnTTUkcHMTXPwT/jWz
 7KrZLNSRyd7VDRqxE1Xn1vqNLMmbuc+GYPBBUZ3E3b6xWwAZd3O3WC1mC4OVimi7Owpv
 PA/TBmG0Hv9c8UuHEfxWfBXb4MHzl+i7PU/ee3Vof5e0Gl9//tn3oske2dlcxnegSnYW
 0nhvdWuH94P25Xp9GHux5GMzG7JS6v1TksxFZmHTm4vQQOAekcWU9EF9zUXNqLh83n2/
 dhn6eYrEfKCAiA5Bg2UIrWzWpnanERCA6EX9SinnhxWTQu+B6CGs7WgpM9wExehL/bqH oQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut4hqgfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5As5hO028492;
        Tue, 5 Dec 2023 13:30:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8b3knc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5DUORp41747006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 13:30:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0085F2004D;
        Tue,  5 Dec 2023 13:30:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E569220040;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B7F19E16D3; Tue,  5 Dec 2023 14:30:23 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 3/3] entry: move syscall_enter_from_user_mode() to header file
Date:   Tue,  5 Dec 2023 14:30:15 +0100
Message-Id: <20231205133015.752543-4-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205133015.752543-1-svens@linux.ibm.com>
References: <20231205133015.752543-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ApgN7KepFqzo9SvrUKodm65wdQnqZ3HS
X-Proofpoint-ORIG-GUID: ApgN7KepFqzo9SvrUKodm65wdQnqZ3HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_08,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=794 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow inlining of syscall_enter_from_user_mode(), move it
to the entry-common.h header file.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 27 +++++++++++++++++++++++++--
 kernel/entry/common.c        | 32 +-------------------------------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index e2c62d111318..ed26d626d587 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -134,6 +134,9 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+			 unsigned long work);
+
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -157,7 +160,15 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
@@ -176,7 +187,19 @@ long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
  */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = syscall_enter_from_user_mode_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
 
 /**
  * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90b995facd7a..dde4a9c1f9f3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -25,7 +25,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
-static long syscall_trace_enter(struct pt_regs *regs, long syscall,
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
 	long ret = 0;
@@ -65,36 +65,6 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall;
 }
 
-static __always_inline long
-__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
-
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	return __syscall_enter_from_user_work(regs, syscall);
-}
-
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = __syscall_enter_from_user_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
-- 
2.40.1

