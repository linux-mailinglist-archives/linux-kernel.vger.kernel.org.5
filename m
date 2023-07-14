Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A75753EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjGNPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjGNPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A3730FF;
        Fri, 14 Jul 2023 08:34:58 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EFMnfv018982;
        Fri, 14 Jul 2023 15:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UYmZLJIjUId/1XEmnLnxhQB3awjVh4Lt7A9mezfmqhc=;
 b=XLKw4ekIyK4yes8uXXze1ZP3EpP/vw/zc9a00grLlyrmuescJxCoO5Wig9GigPz567SE
 YYDqZHPHCF+fzTGoaYZgQdxE2Sb1lk46azON01zYQ6Y6mOgwxv5ZnYtVYzj3jTPy1krt
 9xfflxRrJAOHCsQVnL0ESo2KAL2gUTprcLJNicUkQKjlav7xWUpcghJ7GpCEojgJN/NU
 AzE/39mAu/khx1Aa3fJQoHfJoMj62CfwgZ3M+joZsE58FH3+AWO97SKjIr5S3jra+5X5
 sgU5gViMCk/fZXFamB1AdMUCQ0Tbpy1nbVQfovzr4Vn0HA2bcFhLbQF7RFvSDjfbUIch 6g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8y1r8eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:34:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E7lWiS019677;
        Fri, 14 Jul 2023 15:34:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rtpvthg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:34:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EFYkTX39518638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:34:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9230020040;
        Fri, 14 Jul 2023 15:34:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D1192004B;
        Fri, 14 Jul 2023 15:34:44 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.52.39])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 15:34:44 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 2/6] integrity: ignore keys failing CA restrictions on non-UEFI platform
Date:   Fri, 14 Jul 2023 11:34:31 -0400
Message-Id: <20230714153435.28155-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230714153435.28155-1-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ETAppa6TO6I2VSKI2Euo68F29ztuiuKS
X-Proofpoint-ORIG-GUID: ETAppa6TO6I2VSKI2Euo68F29ztuiuKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
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

On non-UEFI platforms, handle restrict_link_by_ca failures differently.

Certificates which do not satisfy CA restrictions on non-UEFI platforms
are ignored.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/platform_certs/machine_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 7aaed7950b6e..389a6e7c9245 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -36,7 +36,7 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	 * If the restriction check does not pass and the platform keyring
 	 * is configured, try to add it into that keyring instead.
 	 */
-	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
 		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
 					 data, len, perm);
 
-- 
2.31.1

