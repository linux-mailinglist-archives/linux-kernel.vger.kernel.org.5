Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE77BB87B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjJFNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjJFNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:02:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48196ED;
        Fri,  6 Oct 2023 06:02:00 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Clq1s026747;
        Fri, 6 Oct 2023 13:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=EzIkQvdqHkvqU8pfoi8auX9WuaFYkA4CdPiXxhdMDJM=;
 b=aMB5YnwwdD81Fs/pqdankSbbxB248JstoF0QDgTEXcNgMPh6hDJl4ljJ/elSctI4U3cA
 odFrSY0WBNjrfkVOIOxdU+C7KTFQrPXFanavJa4aUYjPiKprhYxZ65BfEQgK+ItWNzdH
 HKjS20ScH6jlpvQgNT+Lbsu7D5kPzb/L94rWRLXESGsGCxlSaBRt1XqcuZ11awQene6s
 oRMeJk7fL7oRyjZEiKtPYMWNYFJCpIHdhg8eVeKPV5DnFwXrzetDqwzb9jl+YL3rDsQa
 nmwqGoCeNiLeCdipYkI851Q5t5LbmfDgIwf47BK+Xnzjn5refTy4+P3aEx+h0e1VRSW2 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjjj70h27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:00:06 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396Cm8ur027771;
        Fri, 6 Oct 2023 12:59:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjjj70edd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 12:59:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 396CPqMk017592;
        Fri, 6 Oct 2023 12:58:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0pkg8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 12:58:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 396Cwm2G43254510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 12:58:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17F320043;
        Fri,  6 Oct 2023 12:58:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4E3D2004B;
        Fri,  6 Oct 2023 12:58:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  6 Oct 2023 12:58:47 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     rdunlap@infradead.org, wenjia@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
        alibuda@linux.alibaba.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
        jaka@linux.ibm.com
Subject: [PATCH net] net/smc: Fix dependency of SMC on ISM
Date:   Fri,  6 Oct 2023 14:58:47 +0200
Message-Id: <20231006125847.1517840-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SG6ZWIKrpDqZYggufCdzL7By_oFzYgj7
X-Proofpoint-GUID: wzbrlymHai5pgffCHOQI33fNRdJYEgKO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_10,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=816
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SMC protocol is built into the kernel proper while ISM is
configured to be built as module, linking the kernel fails due to
unresolved dependencies out of net/smc/smc_ism.o to
ism_get_smcd_ops, ism_register_client, and ism_unregister_client
as reported via the linux-next test automation (see link).
This however is a bug introduced a while ago.

Correct the dependency list in ISM's and SMC's Kconfig to reflect the
dependencies that are actually inverted. With this you cannot build a
kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
too - or a 'n'. That way, SMC can still be configured on non-s390
architectures that do not have (nor need) an ISM driver.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/s390/net/Kconfig | 2 +-
 net/smc/Kconfig          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 74760c1a163b..4902d45e929c 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -102,7 +102,7 @@ config CCWGROUP
 
 config ISM
 	tristate "Support for ISM vPCI Adapter"
-	depends on PCI && SMC
+	depends on PCI
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 1ab3c5a2c5ad..746be3996768 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -2,6 +2,7 @@
 config SMC
 	tristate "SMC socket protocol family"
 	depends on INET && INFINIBAND
+	depends on m || ISM != m
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
 	  RDMA over Converged Ethernet (RoCE) technology to upgrade
-- 
2.39.2

