Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DD7F1704
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKTPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjKTPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:16:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81496A4;
        Mon, 20 Nov 2023 07:16:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKF2WHm027654;
        Mon, 20 Nov 2023 15:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=hlNIjt1lJtZP47W7eO4KvEIII2+KWpAFpv+PlhUsURU=;
 b=o58V0R8A+E1zQ+SsMJvASydoOg6yhLfPoVow6VNQGEyTW8yuHUx78AxnBxqu+geBa3f4
 pAgkQjoWEuFGUbkNQVRkB0M8hWgptRafKNvfQrv8sOf/IhWCunOsjUvupuereHMTuh0H
 OHkE3T7Tuq4WEFXC7xvGpRVbvJrKtm99EkSUORzMMY8+rfMFd+Oi4VM1acNWPboHYliJ
 0hqbi5Jbg/0S+8YYn+iQJ7BvwWLQC/VTmCBYpqqMSdKy3ZfsqPorEdImcv4hypc5H9jH
 4E9G465XiumZTMhrkmPOdQEaiaREMPh/dtTaJHPSocWTi672AvCDnuNJqs/HM9FZGoc1 nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpejwf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKF2wL7023702;
        Mon, 20 Nov 2023 15:15:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5gr46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:15:23 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKFFF8b037000;
        Mon, 20 Nov 2023 15:15:22 GMT
Received: from mihai.localdomain (ban25x6uut25.us.oracle.com [10.153.73.25])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uekq5gqwc-7;
        Mon, 20 Nov 2023 15:15:22 +0000
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
Subject: [PATCH 6/7] cpuidle-haltpoll: ARM64 support
Date:   Mon, 20 Nov 2023 16:01:37 +0200
Message-Id: <1700488898-12431-7-git-send-email-mihai.carabas@oracle.com>
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
X-Proofpoint-GUID: srZIfO3ZIE8aevxHjRldc4X9uOZ7nIZa
X-Proofpoint-ORIG-GUID: srZIfO3ZIE8aevxHjRldc4X9uOZ7nIZa
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

To test whether it's a guest or not for the default cases, the haltpoll
driver uses the kvm_para* helpers to find out if it's a guest or not.

ARM64 doesn't have or defined any of these, so it remains disabled on
the default. Although it allows to be force-loaded.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/cpuidle/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index cac5997dca50..067927eda466 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,7 +35,7 @@ config CPU_IDLE_GOV_TEO
 
 config CPU_IDLE_GOV_HALTPOLL
 	bool "Haltpoll governor (for virtualized systems)"
-	depends on KVM_GUEST
+	depends on (X86 && KVM_GUEST) || ARM64
 	help
 	  This governor implements haltpoll idle state selection, to be
 	  used in conjunction with the haltpoll cpuidle driver, allowing
@@ -73,7 +73,7 @@ endmenu
 
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
-	depends on X86 && KVM_GUEST
+	depends on (X86 && KVM_GUEST) || ARM64
 	select CPU_IDLE_GOV_HALTPOLL
 	default y
 	help
-- 
1.8.3.1

