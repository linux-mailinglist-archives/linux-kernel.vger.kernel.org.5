Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF797F170D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjKTPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjKTPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:16:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE02CF;
        Mon, 20 Nov 2023 07:16:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKF2bwP005937;
        Mon, 20 Nov 2023 15:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=pp3oJCE+l4dkX48YqTrLpZqytXIk14RQ2yK9nosdrJs=;
 b=CI9F+SCdR/2H1DUT4In+BIN+OkyLXpvdpMVYDWHIfCXjxmzvP7R1vZllEc1XM+MTGylC
 EHlY9tgiwNLjC1grH2ktMjKX4GU8sl504X8eICJnnR+5MTXrj2eARUtcFaSokuNb5fer
 Qgsgo0QrFSwnXup5jjetf4lUNpvTGsjatfVTYmZB8bR455kAv3dERcYcTEQEKXjA4VXw
 0zQChqo3/EY8KfkBSwoB/ogGw7cuRtaYKHahxtSIJmqc3hRhQ8PyzcZr7vhyaaophQ8Y
 FdWrdFG8x1criycN7C95dHOnLLjFHbAf2Zu+X1fC3EEdmBax5T+eSubuCh4eogtn8E6y 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuava1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKFAjmd023633;
        Mon, 20 Nov 2023 15:15:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5gr2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKFFF8Z037000;
        Mon, 20 Nov 2023 15:15:21 GMT
Received: from mihai.localdomain (ban25x6uut25.us.oracle.com [10.153.73.25])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uekq5gqwc-6;
        Mon, 20 Nov 2023 15:15:21 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        wanpengli@tencent.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, akpm@linux-foundation.org,
        pmladek@suse.com, peterz@infradead.org, dianders@chromium.org,
        npiggin@gmail.com, rick.p.edgecombe@intel.com,
        joao.m.martins@oracle.com, juerg.haefliger@canonical.com,
        mic@digikod.net, mihai.carabas@oracle.com, arnd@arndb.de,
        ankur.a.arora@oracle.com
Subject: [PATCH 5/7] arm64: Define TIF_POLLING_NRFLAG
Date:   Mon, 20 Nov 2023 16:01:36 +0200
Message-Id: <1700488898-12431-6-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_15,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=872 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200106
X-Proofpoint-GUID: hrfueO0l1RIGqOXgnbRbJW6s5m_a1g8c
X-Proofpoint-ORIG-GUID: hrfueO0l1RIGqOXgnbRbJW6s5m_a1g8c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

The default idle method for arm64 is WFI and it therefore
unconditionally requires the reschedule interrupt when idle.

Commit 842514849a61 ("arm64: Remove TIF_POLLING_NRFLAG") had
reverted it because WFI was the only idle method. ARM64 support
for haltpoll means that poll_idle() polls for TIF_POLLING_NRFLAG,
so define on arm64 *only if* haltpoll is built, using the same bit.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/arm64/include/asm/thread_info.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 2c62ab3aeb84..c5fd3107c8ce 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -69,6 +69,9 @@ struct thread_info {
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
+#if IS_ENABLED(CONFIG_HALTPOLL_CPUIDLE) || IS_ENABLED(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+#define TIF_POLLING_NRFLAG      16      /* poll_idle() polls TIF_NEED_RESCHED */
+#endif
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -94,6 +97,9 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
+#if IS_ENABLED(CONFIG_HALTPOLL_CPUIDLE) || IS_ENABLED(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+#endif
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
-- 
1.8.3.1

