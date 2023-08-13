Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFB77A4A8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjHMCQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 22:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHMCP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 22:15:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A480D7;
        Sat, 12 Aug 2023 19:16:02 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37D26frd006382;
        Sun, 13 Aug 2023 02:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+Ki1oKIwDxjtgyY+7vdefE9L5j5AW/bixMirZNbv5xM=;
 b=ZvjUsqPb1P7t4n9Na9JpD/dIC8opKoZDsGPu7gATYUcBLXq/z93zoAecqipGkipIaI8w
 wgU1XZGCYXmPkvbDdlH4ztxpsLTq802IZ5Avoj35J88m4Zh1AMU0GCDFCdMGzhrYC4P/
 krDX+YUXfsLZ4IDWnEpsOy3dKouZ1c420LYvePQa7JXBg+S8b9gHoXNJEiX6l8JgqXj4
 AqbcNAN25B3UIf4RsazNba81DNWSW3SZ+WpKIAHQb7N5k12Ytc9PlxZRuvGmJcj7nWYs
 LkAaicEH7OR+gBAuKtiS5sCiRYIUrZMnBqzJWhvgE8ovlgJj0vKDGQsUvZh7jo/lOnvI iQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3senyj0ag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 02:15:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37D1GYBx017899;
        Sun, 13 Aug 2023 02:15:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3se376qb3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 02:15:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37D2Fi1x21037618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Aug 2023 02:15:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D43AA2004B;
        Sun, 13 Aug 2023 02:15:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C328620040;
        Sun, 13 Aug 2023 02:15:42 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Aug 2023 02:15:42 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3 2/6] integrity: ignore keys failing CA restrictions on non-UEFI platform
Date:   Sat, 12 Aug 2023 22:15:27 -0400
Message-Id: <20230813021531.1382815-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230813021531.1382815-1-nayna@linux.ibm.com>
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 49hTOhTodGLnNVQfdBd1ia4D0jdHCKer
X-Proofpoint-GUID: 49hTOhTodGLnNVQfdBd1ia4D0jdHCKer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_27,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130016
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-UEFI platforms, handle restrict_link_by_ca failures differently.

Certificates which do not satisfy CA restrictions on non-UEFI platforms
are ignored.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
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

