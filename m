Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303717EE1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbjKPNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbjKPNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:39:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E41A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:39:11 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDRmWZ016619;
        Thu, 16 Nov 2023 13:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gU7vbPwhVN7muCTCU/0kp+lelIegbVTYu2YjwnbykWc=;
 b=OTuonKfs/lyxa74NmnmPAJdhG6cvaZN6L0J99/cm0h1yOOT1FAOTANvCinUi5ZmyOyiW
 i6/ZVvNbnHtHub3bb9bLmkGs/zG0ieJNJa/HlWmneiMhUV51bcv8fJbyf+cTz4LHFuZy
 Mjr/CNVm2+J652X7T31c0Lm8KpCwZ1+x41QahN6D+HCJPrnsiCN3XXJ/5imt/AjSxDON
 2Hkxwmh7ibu+7+B755OvTyAPYP2bIGot4t+ZM69WaT6fxx9wif93bgZnwCsciz6fUYhl
 JOG+KpboOYqxJ6/DdU0kyah7/N7UjXym5jSbL6vpj9fJ/jtJg1aBLWEXrmkhK26kOO/+ mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkyur8bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:38:57 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGDRvib016864;
        Thu, 16 Nov 2023 13:38:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkyur7vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:38:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBeC2B000447;
        Thu, 16 Nov 2023 13:36:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekxrsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGDadXk13369926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 13:36:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F7A2004F;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EDD620043;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arch: remove ARCH_TASK_STRUCT_ALLOCATOR
Date:   Thu, 16 Nov 2023 14:36:37 +0100
Message-Id: <20231116133638.1636277-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116133638.1636277-1-hca@linux.ibm.com>
References: <20231116133638.1636277-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FfD6q5Cb3BTS-54B56ChfBplkUHFebB3
X-Proofpoint-ORIG-GUID: X3Nvu-xvWovAL78vdRsD0QCZnlXaQ6Nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_13,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA-64 was the only architecture which selected ARCH_TASK_STRUCT_ALLOCATOR.
IA-64 was removed with commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture"). Therefore remove support for ARCH_THREAD_STACK_ALLOCATOR
as well.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig  | 5 -----
 kernel/fork.c | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 310162b41a1c..c2f87ef9f0ae 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -305,13 +305,8 @@ config ARCH_HAS_CPU_FINALIZE_INIT
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
 
-# Select if arch has its private alloc_task_struct() function
-config ARCH_TASK_STRUCT_ALLOCATOR
-	bool
-
 config HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	bool
-	depends on !ARCH_TASK_STRUCT_ALLOCATOR
 	help
 	  An architecture should select this to provide hardened usercopy
 	  knowledge about what region of the thread_struct should be
diff --git a/kernel/fork.c b/kernel/fork.c
index d071809866e0..ce8a4b8c04e2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -165,7 +165,6 @@ void __weak arch_release_task_struct(struct task_struct *tsk)
 {
 }
 
-#ifndef CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
 static struct kmem_cache *task_struct_cachep;
 
 static inline struct task_struct *alloc_task_struct_node(int node)
@@ -177,7 +176,6 @@ static inline void free_task_struct(struct task_struct *tsk)
 {
 	kmem_cache_free(task_struct_cachep, tsk);
 }
-#endif
 
 /*
  * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
@@ -1001,7 +999,6 @@ static void set_max_threads(unsigned int max_threads_suggested)
 int arch_task_struct_size __read_mostly;
 #endif
 
-#ifndef CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
 static void task_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
 	/* Fetch thread_struct whitelist for the architecture. */
@@ -1016,12 +1013,10 @@ static void task_struct_whitelist(unsigned long *offset, unsigned long *size)
 	else
 		*offset += offsetof(struct task_struct, thread);
 }
-#endif /* CONFIG_ARCH_TASK_STRUCT_ALLOCATOR */
 
 void __init fork_init(void)
 {
 	int i;
-#ifndef CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
 #ifndef ARCH_MIN_TASKALIGN
 #define ARCH_MIN_TASKALIGN	0
 #endif
@@ -1034,7 +1029,6 @@ void __init fork_init(void)
 			arch_task_struct_size, align,
 			SLAB_PANIC|SLAB_ACCOUNT,
 			useroffset, usersize, NULL);
-#endif
 
 	/* do the arch specific task caches init */
 	arch_task_cache_init();
-- 
2.39.2

