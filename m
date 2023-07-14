Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C8753F08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjGNPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjGNPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:35:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFA0358C;
        Fri, 14 Jul 2023 08:35:06 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EFMYnI012606;
        Fri, 14 Jul 2023 15:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wKsyvZxINajd7roXNUCnVAM2kv5ZDuXfXM1O5Z/e+FE=;
 b=dtBvY+piveb0hYj84Caj7pwA1KwyTm/ytpILz7xuN0N9eZA9Y+saHj/0Wo2F0O2PBeTW
 xzPe+1Tqe3nJjT+qD/0XzKb7fCMFiL2ktqOHQTurySG2yEbpCDb6QmWYw+DlQqiS+ReI
 LRqlOkEyqHY8dR22vV3yd7QYsHt4xq6nyiCJhQVxhZawCErEshK2cwBKRLaVxjVVsrWd
 tHgptJ6vIul/1JQrSghD+D4juxtUp+lnWC6eZaSlOU5/XGaSyJ5NMHFR127UuBVfGw5P
 XjOi4ar/MWR7tHjPIGC+hs+f+Q3BDExTY7DTA98DBWHtONHPah407T9Xz31+ZN+Nn1uB QA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8xx89fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:34:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E0l58X015810;
        Fri, 14 Jul 2023 15:34:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rtqk18dj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:34:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EFYrFh37880536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:34:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D271920040;
        Fri, 14 Jul 2023 15:34:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEB502004B;
        Fri, 14 Jul 2023 15:34:51 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.52.39])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 15:34:51 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 5/6] integrity: PowerVM machine keyring enablement.
Date:   Fri, 14 Jul 2023 11:34:34 -0400
Message-Id: <20230714153435.28155-6-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230714153435.28155-1-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g3KV4gdNzUJaP78dc5MT3c94cq4gzGii
X-Proofpoint-GUID: g3KV4gdNzUJaP78dc5MT3c94cq4gzGii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=786 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Kconfig to enable machine keyring and limit to CA certificates
on PowerVM.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index ec6e0d789da1..03c40ade0214 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -67,7 +67,8 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
-	depends on LOAD_UEFI_KEYS
+	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
+	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
-- 
2.31.1

