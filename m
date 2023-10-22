Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318197D2590
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJVTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJVTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 15:04:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C785E6;
        Sun, 22 Oct 2023 12:04:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MIwwBJ013066;
        Sun, 22 Oct 2023 19:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=maKKcoH6eUl7NYDIpjbc31lMxZYF8rVLYvLdNVhOu50=;
 b=inw/RrBe+b3sbOZ6FOoso7s6++PgipdH2mx7bkVyk1gm8CFF6FULJAzF2mo/WiXJtHWh
 RrEzOwt27WMsa5pYv4GHoslfUEDugiQMNGVdP7IVEwanYes5fmLHwzXTueQxgJHqDkw6
 ROc6q0U/ZNcqVDxAckrYaiznXP+h7gG9gbq7Sn/Vacds+98L/7mw2q42DmYdzpi/QTN3
 grBPdPvp1m+n6HeJpreovxpBwS2Py6Y7Isn8CfVpOIOb9EGuUfsRlzBSWx/ckILLnXcL
 KSocE+p6TkgHnQTcVDWDlYnWVAte+lp3OG9UgStMqZHr9gxgi/p9SPhvJyeLjsx8+WZp Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581hvdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 19:04:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MHFdbw031205;
        Sun, 22 Oct 2023 19:04:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv539qhv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 19:04:36 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MJ4ZQM013416;
        Sun, 22 Oct 2023 19:04:35 GMT
Received: from localhost.localdomain (dhcp-10-175-52-84.vpn.oracle.com [10.175.52.84])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv539qhu6-1;
        Sun, 22 Oct 2023 19:04:35 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] kdump: fix reference to nonexistent file
Date:   Sun, 22 Oct 2023 21:04:24 +0200
Message-Id: <20231022190424.919982-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310220176
X-Proofpoint-GUID: OuayZRL-O4eZBxCVOODviB5CkcX2iDyO
X-Proofpoint-ORIG-GUID: OuayZRL-O4eZBxCVOODviB5CkcX2iDyO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the s390 docs were moved from Documentation/s390/ to
Documentation/arch/s390/ but this reference didn't get updated. Fix it.

Fixes: 37002bc6b603 ("docs: move s390 under arch")
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 kernel/Kconfig.kexec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 9bfe68fe9676..7aff28ded2f4 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -110,7 +110,7 @@ config CRASH_DUMP
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
 	  For s390, this option also enables zfcpdump.
-	  See also <file:Documentation/s390/zfcpdump.rst>
+	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
-- 
2.34.1

