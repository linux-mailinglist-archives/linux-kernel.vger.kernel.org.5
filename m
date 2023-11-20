Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B27F171C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjKTPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjKTPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:17:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18C1719;
        Mon, 20 Nov 2023 07:16:53 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKF2Z4L005926;
        Mon, 20 Nov 2023 15:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2V8o9BaQ17wiFTJFImvoF31znAoRVZkAB3vW9iybNe4=;
 b=lYsJ3knbU8SDz0I3uqfqg7oUXll/0QCVmQZUyZQdJkVEk0ICCXbReZAHmvc4VePULkVx
 eSLWcWrd6XoqQ3wWUhMDPxjW0Kr+MLmXN5oRV6lPJ2PeXE3zuLoCwRMctmF6EQ9eRG5v
 5ByW01SMgAXOrxLi2zwGxjYKgadp3NuGOs6EcYhz6UCO5Gvs4K8Hhgy+x2+0fhJnXb2N
 2jd6SXjsTy58zv/bSmQMNUY/jpLDGRlDkM9IGd+/4vr5Qxb9ZyBRe9Yqh2ap+at9ALiM
 5jLtWSi+KjFgR/kA6hBaoCM5VnxbNkSaN4wmqAo2lkECeGIz43Hwu4gyTueASHHh1ITD sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuav9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKE2Me6023469;
        Mon, 20 Nov 2023 15:15:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5gqym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKFFF8R037000;
        Mon, 20 Nov 2023 15:15:16 GMT
Received: from mihai.localdomain (ban25x6uut25.us.oracle.com [10.153.73.25])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uekq5gqwc-2;
        Mon, 20 Nov 2023 15:15:16 +0000
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
Subject: [PATCH 1/7] x86: Move ARCH_HAS_CPU_RELAX to arch
Date:   Mon, 20 Nov 2023 16:01:32 +0200
Message-Id: <1700488898-12431-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_15,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200106
X-Proofpoint-GUID: QT8FxzDkqsUsT7eSEWgaw5FTRjZ6RwsG
X-Proofpoint-ORIG-GUID: QT8FxzDkqsUsT7eSEWgaw5FTRjZ6RwsG
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

ARM64 is going to use it for haltpoll support (for poll-state)
so move the definition to be arch-agnostic and allow architectures
to override it.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4a85a10b12fd..92af0e9bc35e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1371,6 +1371,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_CPU_RELAX
+	bool
+
 config ARCH_HAS_CC_PLATFORM
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d1c362f479d9..0c77670d020e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -73,6 +73,7 @@ config X86
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
+	select ARCH_HAS_CPU_RELAX
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
-- 
1.8.3.1

