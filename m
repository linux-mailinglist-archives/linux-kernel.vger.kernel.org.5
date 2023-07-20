Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6F75B303
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjGTPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGTPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:36:37 -0400
Received: from frasgout13.his.huawei.com (ecs-14-137-139-46.compute.hwclouds-dns.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D52D53;
        Thu, 20 Jul 2023 08:36:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R6GhV51dvz9xyNl;
        Thu, 20 Jul 2023 23:24:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S11;
        Thu, 20 Jul 2023 16:35:35 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 9/9] ima: Support non-PKCS#7 modsig types
Date:   Thu, 20 Jul 2023 17:32:45 +0200
Message-Id: <20230720153247.3755856-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S11
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW7uw4fWFykCw1ktF18Krg_yoW7Ww48p3
        ZxuF1rCrZ8G3WxJFnYyw1aywnIkw15Gw15K3yjk3Z0yrnxZw1DGw1j9w1fZFy3K3yDWFWf
        Jr4xXr4YkF1kXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5C8owACs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add support for alternative signature formats through the newly introduced
user asymmetric key signatures. The corresponding API is invoked if the
signature type is not PKEY_ID_PKCS7. If the signature type is
PKEY_ID_PKCS7, nothing changes, the existing API is still invoked.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_modsig.c | 79 +++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 3e7bee30080..7c96cb2613a 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -12,11 +12,14 @@
 #include <linux/module_signature.h>
 #include <keys/asymmetric-type.h>
 #include <crypto/pkcs7.h>
+#include <crypto/uasym_keys_sigs.h>
 
 #include "ima.h"
 
 struct modsig {
 	struct pkcs7_message *pkcs7_msg;
+	struct uasym_sig_message *uasym_sig;
+	u8 id_type;
 
 	enum hash_algo hash_algo;
 
@@ -28,8 +31,8 @@ struct modsig {
 	 * This is what will go to the measurement list if the template requires
 	 * storing the signature.
 	 */
-	int raw_pkcs7_len;
-	u8 raw_pkcs7[];
+	int raw_sig_len;
+	u8 raw_sig[];
 };
 
 /*
@@ -57,27 +60,43 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	buf_len -= marker_len;
 	sig = (const struct module_signature *)(p - sizeof(*sig));
 
-	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
-	if (rc)
-		return rc;
+	if (sig->id_type == PKEY_ID_PKCS7) {
+		rc = mod_check_sig(sig, buf_len, func_tokens[func]);
+		if (rc)
+			return rc;
+	} else {
+		/* Same as mod_check_sig() but skipping the id_type check. */
+		if (sig->algo != 0 ||
+		    sig->hash != 0 ||
+		    sig->signer_len != 0 ||
+		    sig->key_id_len != 0 ||
+		    sig->__pad[0] != 0 ||
+		    sig->__pad[1] != 0 ||
+		    sig->__pad[2] != 0)
+			return -EBADMSG;
+	}
 
 	sig_len = be32_to_cpu(sig->sig_len);
 	buf_len -= sig_len + sizeof(*sig);
 
-	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
+	/* Allocate sig_len additional bytes to hold the raw sig data. */
 	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
 	if (!hdr)
 		return -ENOMEM;
 
-	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
-	if (IS_ERR(hdr->pkcs7_msg)) {
-		rc = PTR_ERR(hdr->pkcs7_msg);
+	if (sig->id_type == PKEY_ID_PKCS7)
+		hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
+	else
+		hdr->uasym_sig = uasym_sig_parse_message(buf + buf_len, sig_len);
+
+	if (IS_ERR(hdr->pkcs7_msg) || IS_ERR(hdr->uasym_sig)) {
 		kfree(hdr);
 		return rc;
 	}
 
-	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-	hdr->raw_pkcs7_len = sig_len;
+	memcpy(hdr->raw_sig, buf + buf_len, sig_len);
+	hdr->raw_sig_len = sig_len;
+	hdr->id_type = sig->id_type;
 
 	/* We don't know the hash algorithm yet. */
 	hdr->hash_algo = HASH_ALGO__LAST;
@@ -105,21 +124,38 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 	 * Provide the file contents (minus the appended sig) so that the PKCS7
 	 * code can calculate the file hash.
 	 */
-	size -= modsig->raw_pkcs7_len + strlen(MODULE_SIG_STRING) +
+	size -= modsig->raw_sig_len + strlen(MODULE_SIG_STRING) +
 		sizeof(struct module_signature);
-	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
+	if (modsig->id_type == PKEY_ID_PKCS7)
+		rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
+	else
+		rc = uasym_sig_supply_detached_data(modsig->uasym_sig, buf,
+						    size);
 	if (rc)
 		return;
 
 	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
-			      &modsig->digest_size, &modsig->hash_algo);
+	if (modsig->id_type == PKEY_ID_PKCS7)
+		rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
+				      &modsig->digest_size, &modsig->hash_algo);
+	else
+		rc = uasym_sig_get_digest(modsig->uasym_sig, &modsig->digest,
+					  &modsig->digest_size,
+					  &modsig->hash_algo);
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
 {
-	return verify_pkcs7_message_sig(NULL, 0, modsig->pkcs7_msg, keyring,
-					VERIFYING_MODULE_SIGNATURE, NULL, NULL);
+	if (modsig->id_type == PKEY_ID_PKCS7)
+		return verify_pkcs7_message_sig(NULL, 0, modsig->pkcs7_msg,
+						keyring,
+						VERIFYING_MODULE_SIGNATURE,
+						NULL, NULL);
+	else
+		return verify_uasym_sig_message(NULL, 0, modsig->uasym_sig,
+						keyring,
+						VERIFYING_MODULE_SIGNATURE,
+						NULL, NULL);
 }
 
 int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
@@ -135,8 +171,8 @@ int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
 		       u32 *data_len)
 {
-	*data = &modsig->raw_pkcs7;
-	*data_len = modsig->raw_pkcs7_len;
+	*data = &modsig->raw_sig;
+	*data_len = modsig->raw_sig_len;
 
 	return 0;
 }
@@ -146,6 +182,9 @@ void ima_free_modsig(struct modsig *modsig)
 	if (!modsig)
 		return;
 
-	pkcs7_free_message(modsig->pkcs7_msg);
+	if (modsig->id_type == PKEY_ID_PKCS7)
+		pkcs7_free_message(modsig->pkcs7_msg);
+	else
+		uasym_sig_free_message(modsig->uasym_sig);
 	kfree(modsig);
 }
-- 
2.34.1

