Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760377769FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjHIU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHIU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABF2100;
        Wed,  9 Aug 2023 13:26:07 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379KI25m021452;
        Wed, 9 Aug 2023 20:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qz4Dew3cRnzz1YOHjjbIpeIDKp5w8Os4Y5mnSWoXiMg=;
 b=tnqlIs0TRldqFD4uuq3pYRxhxSfzDWqKlz03ff5hhRfqNUFWsl/JFyynFzSvsFbexzPm
 B+TucwEzSNOHP2Ka+SGM1wMtOaMUxVqSCHVxpIePktONg698pSUeKq6cXoUGQs0Twqnr
 gdh81wXJRHpljquDD9JeLmKJxG1v4N+1ouL5e78SuckqQ8kazz+rvjZ8nhBZQWYY/avv
 ZRviE6/i1ClhhrFuWGCiVtSZZj0kjAp1FjrLB8RrYJ0H+qkLt7jxn6rmmkkpkNJf2qSC
 8BErWiwxcJQiiB+u/mGe7wORdw/43RI59V7J89Cwe3DhNmlHV6CIW8+PBMF4o9XOL+uM Iw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3schq4g5ug-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 20:25:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379Ick7h001792;
        Wed, 9 Aug 2023 19:53:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f22pug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379JrWOr42533144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 19:53:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 593D72004B;
        Wed,  9 Aug 2023 19:53:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4073B20040;
        Wed,  9 Aug 2023 19:53:30 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 19:53:30 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 1/6] integrity: PowerVM support for loading CA keys on machine keyring
Date:   Wed,  9 Aug 2023 15:53:10 -0400
Message-Id: <20230809195315.1085656-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809195315.1085656-1-nayna@linux.ibm.com>
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0ppBrqmCPEhWPRpX92rsiutdhKl5rhOr
X-Proofpoint-ORIG-GUID: 0ppBrqmCPEhWPRpX92rsiutdhKl5rhOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_18,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keys that derive their trust from an entity such as a security officer,
administrator, system owner, or machine owner are said to have "imputed
trust". CA keys with imputed trust can be loaded onto the machine keyring.
The mechanism for loading these keys onto the machine keyring is platform
dependent.

Load keys stored in the variable trustedcadb onto the .machine keyring
on PowerVM platform.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/platform_certs/keyring_handler.c  |  8 ++++++++
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 .../integrity/platform_certs/load_powerpc.c     | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 8a1124e4d769..1649d047e3b8 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -69,6 +69,14 @@ __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 	return NULL;
 }
 
+__init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_machine_keyring;
+
+	return NULL;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 212d894a8c0c..6f15bb4cc8dc 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -29,6 +29,11 @@ efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
  */
 efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types for CA keys.
+ */
+efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 170789dc63d2..6263ce3b3f1e 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -59,6 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 static int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL, *data = NULL;
+	void *trustedca = NULL;
 	u64 dsize = 0;
 	u64 offset = 0;
 	int rc = 0;
@@ -120,6 +121,22 @@ static int __init load_powerpc_certs(void)
 		kfree(data);
 	}
 
+	data = get_cert_list("trustedcadb", 12,  &dsize);
+	if (!data) {
+		pr_info("Couldn't get trustedcadb list from firmware\n");
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		pr_err("Error reading trustedcadb from firmware: %d\n", rc);
+	} else {
+		extract_esl(trustedca, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:trustedca", trustedca, dsize,
+					      get_handler_for_ca_keys);
+		if (rc)
+			pr_err("Couldn't parse trustedcadb signatures: %d\n", rc);
+		kfree(data);
+	}
+
 	return rc;
 }
 late_initcall(load_powerpc_certs);
-- 
2.31.1

