Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDB776944
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjHITyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjHITx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:53:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9281121;
        Wed,  9 Aug 2023 12:53:55 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379JgVhm017716;
        Wed, 9 Aug 2023 19:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NVTquuvX9dsflLTtBwvvwzl0i+D4hoEfcRmwtYlvu/4=;
 b=R3m3JvUAYDR5YwMGD3yy6tNv/md0nsdn5LRIIg5PT6LUWPMt8AW/g1gaOWQiCejoPSSi
 hfj8fhGST8Axt6fSCCxv5t242iip6rJeUIOE08yPd5kNKJ9Geu263pr5T2V7YmS9T2+P
 BILo3QyyBP5KcVSosyNys5DPnFKVgXqHKUzbeCRTSm/R2VptW6arEZiOgacwiMjahT0W
 GujeqPNS0vkbcKUqx6+3wLqK9NJDO4K+lsiSCCBvxcEewA0vPG5bDY+Oe9mrRQ747YQX
 PfuGbdiu26vNIg4xH8o0EeHujQI/VSTcnaJtI3qwlOhL++3VcCmvLQAwQcQgpvJNlMIG JA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scgvagmps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379I8lMY015354;
        Wed, 9 Aug 2023 19:53:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f34ucd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379JriiD16777886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 19:53:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E23A2004B;
        Wed,  9 Aug 2023 19:53:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B5120040;
        Wed,  9 Aug 2023 19:53:42 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 19:53:42 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 6/6] integrity: PowerVM support for loading third party code signing keys
Date:   Wed,  9 Aug 2023 15:53:15 -0400
Message-Id: <20230809195315.1085656-7-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809195315.1085656-1-nayna@linux.ibm.com>
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eOTOhSqbVFQUPJe-VBabWmBWWQz5HpZO
X-Proofpoint-ORIG-GUID: eOTOhSqbVFQUPJe-VBabWmBWWQz5HpZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_17,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On secure boot enabled PowerVM LPAR, third party code signing keys are
needed during early boot to verify signed third party modules. These
third party keys are stored in moduledb object in the Platform
KeyStore(PKS).

Load third party code signing keys onto .secondary_trusted_keys keyring.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/system_keyring.c                        | 23 +++++++++++++++++++
 include/keys/system_keyring.h                 |  7 ++++++
 security/integrity/integrity.h                |  1 +
 .../platform_certs/keyring_handler.c          |  8 +++++++
 .../platform_certs/keyring_handler.h          |  5 ++++
 .../integrity/platform_certs/load_powerpc.c   | 18 ++++++++++++++-
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index b348e0898d34..3435d4936fb2 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -396,3 +396,26 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+void __init add_to_secondary_keyring(const char *source, const void *data,
+				     size_t len)
+{
+	key_ref_t key;
+	key_perm_t perm;
+	int rc = 0;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+
+	key = key_create_or_update(make_key_ref(secondary_trusted_keys, 1),
+				   "asymmetric",
+				   NULL, data, len, perm,
+				   KEY_ALLOC_NOT_IN_QUOTA);
+	if (IS_ERR(key)) {
+		rc = PTR_ERR(key);
+		pr_err("Problem loading X.509 certificate %d\n", rc);
+	} else {
+		pr_notice("Loaded X.509 cert '%s'\n",
+			  key_ref_to_ptr(key)->description);
+		key_ref_put(key);
+	}
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 7e2583208820..4188f75d1bac 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -50,9 +50,16 @@ int restrict_link_by_digsig_builtin_and_secondary(struct key *keyring,
 						  const struct key_type *type,
 						  const union key_payload *payload,
 						  struct key *restriction_key);
+void __init add_to_secondary_keyring(const char *source, const void *data,
+				     size_t len);
+
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_digsig_builtin
+void __init add_to_secondary_keyring(const char *source, const void *data,
+				     size_t len)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index d7553c93f5c0..efaa2eb789ad 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -228,6 +228,7 @@ static inline int __init integrity_load_cert(const unsigned int id,
 {
 	return 0;
 }
+
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 586027b9a3f5..13ea17207902 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -78,6 +78,14 @@ __init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type)
 	return NULL;
 }
 
+__init efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_secondary_keyring;
+
+	return NULL;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 6f15bb4cc8dc..f92895cc50f6 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -34,6 +34,11 @@ efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
  */
 efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types for code signing keys.
+ */
+efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 6263ce3b3f1e..32c4e5fbf0fb 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -59,7 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
 static int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL, *data = NULL;
-	void *trustedca = NULL;
+	void *trustedca = NULL, *moduledb = NULL;
 	u64 dsize = 0;
 	u64 offset = 0;
 	int rc = 0;
@@ -137,6 +137,22 @@ static int __init load_powerpc_certs(void)
 		kfree(data);
 	}
 
+	data = get_cert_list("moduledb", 9,  &dsize);
+	if (!data) {
+		pr_info("Couldn't get moduledb list from firmware\n");
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		pr_err("Error reading moduledb from firmware: %d\n", rc);
+	} else {
+		extract_esl(moduledb, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:moduledb", moduledb, dsize,
+					      get_handler_for_code_signing_keys);
+		if (rc)
+			pr_err("Couldn't parse moduledb signatures: %d\n", rc);
+		kfree(data);
+	}
+
 	return rc;
 }
 late_initcall(load_powerpc_certs);
-- 
2.31.1

