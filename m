Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64C875B2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGTPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGTPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:35:39 -0400
Received: from frasgout13.his.huawei.com (ecs-14-137-139-46.compute.hwclouds-dns.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F6D2711;
        Thu, 20 Jul 2023 08:35:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R6GgZ2n3xz9xyNS;
        Thu, 20 Jul 2023 23:24:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S7;
        Thu, 20 Jul 2023 16:34:46 +0100 (CET)
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
Subject: [RFC][PATCH v3 5/9] KEYS: asymmetric: Introduce the user asymmetric key signature parser
Date:   Thu, 20 Jul 2023 17:32:41 +0200
Message-Id: <20230720153247.3755856-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S7
X-Coremail-Antispam: 1UD129KBjvAXoW3tryfuw13WryUuw1fKr1kGrg_yoW8CFWUWo
        Z3Wr45Ca1Fqr1qkF43G3WkCw48ZrWDJFWUAw43W3ZFq3Wjq34UKF48Ca47uFWfXw1UGrWf
        AF18Ja4xJ3yIqwn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYK7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5C8nwAAsD
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

Introduce a parser for user asymmetric key signatures, in TLV format. User
space tools are expected to convert signatures from their original format
in the TLV format.

Also, add the API to perform signature verification of system data,
introduced in a later patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                               |   1 +
 crypto/asymmetric_keys/Kconfig            |   1 +
 crypto/asymmetric_keys/Makefile           |   3 +-
 crypto/asymmetric_keys/uasym_sig_parser.c | 497 ++++++++++++++++++++++
 include/crypto/uasym_keys_sigs.h          |  72 ++++
 include/uapi/linux/uasym_parser.h         |   9 +
 6 files changed, 582 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/uasym_sig_parser.c
 create mode 100644 include/crypto/uasym_keys_sigs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 220463b2e51..d3af1e179b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3143,6 +3143,7 @@ F:	Documentation/crypto/asymmetric-keys.rst
 F:	crypto/asymmetric_keys/
 F:	include/crypto/pkcs7.h
 F:	include/crypto/public_key.h
+F:	include/crypto/uasym_sig.h
 F:	include/linux/verification.h
 
 ASYNCHRONOUS TRANSFERS/TRANSFORMS (IOAT) API
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 4a5f66511d4..d9d82cada0a 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -89,6 +89,7 @@ config UASYM_KEYS_SIGS
 	tristate "User asymmetric keys and signatures"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select CRYPTO_PUB_KEY_INFO
+	select CRYPTO_SIG_ENC_INFO
 	select TLV_PARSER
 	help
 	  This option enables user asymmetric keys and signatures. They are
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 5ba30cca09e..191b7fe8359 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -81,4 +81,5 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 # User asymmetric keys and signatures
 #
 obj-$(CONFIG_UASYM_KEYS_SIGS) += uasym_keys_sigs.o
-uasym_keys_sigs-y := uasym_key_parser.o
+uasym_keys_sigs-y := uasym_key_parser.o \
+		     uasym_sig_parser.o
diff --git a/crypto/asymmetric_keys/uasym_sig_parser.c b/crypto/asymmetric_keys/uasym_sig_parser.c
new file mode 100644
index 00000000000..97fa1381a78
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_sig_parser.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Authors:
+ *   David Howells <dhowells@redhat.com>
+ *   Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user asymmetric key signature parser.
+ */
+
+#define pr_fmt(fmt) "UASYM SIG: "fmt
+#include <linux/module.h>
+#include <linux/tlv_parser.h>
+#include <crypto/public_key.h>
+#include <crypto/uasym_keys_sigs.h>
+#include <crypto/pub_key_info.h>
+#include <crypto/sig_enc_info.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+#include "uasym_parser.h"
+
+struct uasym_sig_message {
+	struct public_key_signature *sig;
+	size_t data_len;
+	const void *data;
+	size_t sig_data_len;
+	const void *sig_data;
+};
+
+static int parse_sig_s(struct public_key_signature *sig, enum fields field,
+		       const u8 *field_data, u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	sig->s = kmemdup(field_data, field_data_len, GFP_KERNEL);
+	if (!sig->s) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sig->s_size = field_data_len;
+	pr_debug("Signature length: %d\n", sig->s_size);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_sig_hash_algo_size(struct public_key_signature *sig,
+				    enum fields field, const u8 *field_data,
+				    u64 field_data_len)
+{
+	u8 algo;
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (field_data_len != sizeof(u8)) {
+		pr_debug("Unexpected data length %llu, expected %lu\n",
+			 field_data_len, sizeof(u8));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	algo = *field_data;
+
+	if (algo >= HASH_ALGO__LAST) {
+		pr_debug("Unexpected hash algo %u\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	sig->hash_algo = hash_algo_name[algo];
+	sig->digest_size = hash_digest_size[algo];
+	pr_debug("Hash algo: %s, digest length: %d\n", sig->hash_algo,
+		 sig->digest_size);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_sig_enc(struct public_key_signature *sig, enum fields field,
+			 const u8 *field_data, u64 field_data_len)
+{
+	u8 enc;
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (field_data_len != sizeof(u8)) {
+		pr_debug("Unexpected data length %llu, expected %lu\n",
+			 field_data_len, sizeof(u8));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	enc = *field_data;
+
+	if (enc >= SIG_ENC__LAST) {
+		pr_debug("Unexpected encoding %u\n", enc);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	sig->encoding = sig_enc_name[enc];
+	pr_debug("Signature encoding: %s\n", sig->encoding);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_sig_data_end(struct uasym_sig_message *uasym_sig,
+			      enum fields field, const u8 *field_data,
+			      u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	uasym_sig->sig_data = kmemdup(field_data, field_data_len, GFP_KERNEL);
+	if (!uasym_sig->sig_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	uasym_sig->sig_data_len = field_data_len;
+	pr_debug("Signature data length appended at the end: %ld\n",
+		 uasym_sig->sig_data_len);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int sig_callback(void *callback_data, u64 field, const u8 *field_data,
+			u64 field_data_len)
+{
+	struct uasym_sig_message *uasym_sig;
+	struct public_key_signature *sig;
+	struct asymmetric_key_id **id;
+	int ret;
+
+	uasym_sig = (struct uasym_sig_message *)callback_data;
+	sig = uasym_sig->sig;
+
+	switch (field) {
+	case SIG_S:
+		ret = parse_sig_s(sig, field, field_data, field_data_len);
+		break;
+	case SIG_KEY_ALGO:
+		ret = parse_key_algo(&sig->pkey_algo, field, field_data,
+				     field_data_len);
+		break;
+	case SIG_HASH_ALGO:
+		ret = parse_sig_hash_algo_size(sig, field, field_data,
+					       field_data_len);
+		break;
+	case SIG_ENC:
+		ret = parse_sig_enc(sig, field, field_data, field_data_len);
+		break;
+	case SIG_KID0:
+		id = (struct asymmetric_key_id **)&sig->auth_ids[0];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case SIG_KID1:
+		id = (struct asymmetric_key_id **)&sig->auth_ids[1];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case SIG_KID2:
+		id = (struct asymmetric_key_id **)&sig->auth_ids[2];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case SIG_DATA_END:
+		ret = parse_sig_data_end(uasym_sig, field, field_data,
+					 field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %llu\n", field);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * uasym_sig_parse_message - Parse a user asymmetric key signature
+ * @sig_data: Signature blob
+ * @sig_len: Length of signature blob
+ *
+ * Parse a user asymmetric key signature and initialize the signature context.
+ *
+ * Return: A uasym_sig_message structure on success, an error pointer on error.
+ */
+struct uasym_sig_message *uasym_sig_parse_message(const u8 *sig_data,
+						  size_t sig_len)
+{
+	struct uasym_sig_message *uasym_sig = NULL;
+	struct public_key_signature *sig;
+	int ret = -EBADMSG;
+
+	kenter("");
+
+	uasym_sig = kzalloc(sizeof(*uasym_sig), GFP_KERNEL);
+	if (!uasym_sig) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sig = kzalloc(sizeof(*sig), GFP_KERNEL);
+	if (!sig) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	uasym_sig->sig = sig;
+
+	ret = tlv_parse(TYPE_SIG, sig_callback, uasym_sig, sig_data, sig_len,
+			data_types_str, TYPE__LAST, fields_str, FIELD__LAST);
+	if (ret < 0)
+		goto out;
+
+	if (!sig->s || !sig->pkey_algo || !sig->hash_algo || !sig->encoding ||
+	    (!sig->auth_ids[0] && !sig->auth_ids[1] && !sig->auth_ids[2])) {
+		pr_debug("Incomplete data\n");
+		ret = -ENOENT;
+		goto out;
+	}
+out:
+	if (ret < 0) {
+		uasym_sig_free_message(uasym_sig);
+		uasym_sig = ERR_PTR(ret);
+		kleave(" = ERR_PTR(%d)", ret);
+	}
+
+	kleave(" = PTR(uasym_sig)");
+	return uasym_sig;
+}
+EXPORT_SYMBOL_GPL(uasym_sig_parse_message);
+
+/**
+ * uasym_sig_supply_detached_data - Supply data to verify a user asym key sig
+ * @uasym_sig: The signature context
+ * @data: The data to be verified
+ * @data_len: The amount of data
+ *
+ * Supply the detached data needed to verify a user asymmetric key signature.
+ * Note that no attempt to retain/pin the data is made. That is left to the
+ * caller. The data will not be modified by uasym_sig_verify_message() and will
+ * not be freed when the signature context is freed.
+ *
+ * Return: Zero on success, -EINVAL if data are already supplied.
+ */
+int uasym_sig_supply_detached_data(struct uasym_sig_message *uasym_sig,
+				   const void *data, size_t data_len)
+{
+	if (uasym_sig->data) {
+		pr_debug("Data already supplied\n");
+		return -EINVAL;
+	}
+
+	uasym_sig->data = data;
+	uasym_sig->data_len = data_len;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uasym_sig_supply_detached_data);
+
+/**
+ * uasym_sig_get_content_data - Get access to content data and additional data
+ * @uasym_sig: The signature context
+ * @_data: Place to return a pointer to the data (updated)
+ * @_data_len: Place to return the data length (updated)
+ * @_headerlen: Size of the additional data (updated)
+ *
+ * Get access to the data associated to the user asymmetric key signature.
+ * This includes the content data eventually supplied by the caller of the user
+ * asymmetric key signatures API, and the additional data resulting from the
+ * signature parsing, appended at the end (more orderings can be supported
+ * in the future).
+ *
+ * Data is allocated, to concatenate together the two data sources, and must be
+ * freed by the caller. It is presented in a way that is suitable for
+ * calculating the digest for verifying the signature.
+ *
+ * Return: Zero if the data and additional data can be provided,
+ *         a negative value on error.
+ */
+int uasym_sig_get_content_data(struct uasym_sig_message *uasym_sig,
+			       const void **_data, size_t *_data_len,
+			       size_t *_headerlen)
+{
+	void *data;
+
+	if (!uasym_sig->data)
+		return -ENODATA;
+
+	if (!_data)
+		goto skip_data;
+
+	data = kmalloc(uasym_sig->data_len + uasym_sig->sig_data_len,
+		       GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(data, uasym_sig->data, uasym_sig->data_len);
+	memcpy(data + uasym_sig->data_len, uasym_sig->sig_data,
+	       uasym_sig->sig_data_len);
+	*_data = data;
+skip_data:
+	if (_data_len)
+		*_data_len = uasym_sig->data_len + uasym_sig->sig_data_len;
+	if (_headerlen)
+		*_headerlen = uasym_sig->data_len;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uasym_sig_get_content_data);
+
+static int uasym_sig_digest(struct uasym_sig_message *uasym_sig)
+{
+	struct public_key_signature *sig = uasym_sig->sig;
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	size_t desc_size;
+	int ret;
+
+	/* The digest was calculated already. */
+	if (sig->digest)
+		return 0;
+
+	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	if (IS_ERR(tfm))
+		return (PTR_ERR(tfm) == -ENOENT) ? -ENOPKG : PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+
+	ret = -ENOMEM;
+	sig->digest = kmalloc(sig->digest_size, GFP_KERNEL);
+	if (!sig->digest)
+		goto error_no_desc;
+
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc)
+		goto error_no_desc;
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update(desc, uasym_sig->data, uasym_sig->data_len);
+	if (ret < 0)
+		goto error;
+
+	if (uasym_sig->sig_data_len) {
+		ret = crypto_shash_update(desc, uasym_sig->sig_data,
+					  uasym_sig->sig_data_len);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = crypto_shash_final(desc, sig->digest);
+error:
+	kfree(desc);
+error_no_desc:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+/**
+ * uasym_sig_get_digest - Obtain the digest and algorithm of the data to verify
+ * @uasym_sig: The signature context
+ * @digest: The buffer the digest is written to
+ * @digest_len: The length of @digest
+ * @hash_algo: The algorithm the digest is calculated with
+ *
+ * Calculate the digest of data to verify with the user asymmetric key
+ * signature, if not calculated already. Pass the pointer of the digest from
+ * the public_key_signature structure, the length and the algorithm to the
+ * caller.
+ *
+ * Return: Zero on success, a negative value otherwise.
+ */
+int uasym_sig_get_digest(struct uasym_sig_message *uasym_sig, const u8 **digest,
+			 u32 *digest_len, enum hash_algo *hash_algo)
+{
+	struct public_key_signature *sig = uasym_sig->sig;
+	int i, ret;
+
+	ret = uasym_sig_digest(uasym_sig);
+	if (ret)
+		return ret;
+
+	*digest = sig->digest;
+	*digest_len = sig->digest_size;
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, sig->hash_algo);
+	if (i >= 0)
+		*hash_algo = i;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uasym_sig_get_digest);
+
+static struct key *get_key(struct uasym_sig_message *uasym_sig,
+			   struct key *keyring)
+{
+	struct public_key_signature *sig = uasym_sig->sig;
+	struct key *key;
+
+	key = find_asymmetric_key(keyring, sig->auth_ids[0], sig->auth_ids[1],
+				  sig->auth_ids[2], false);
+	if (IS_ERR(key)) {
+		pr_debug("Public key not found (%*phN, %*phN, %*phN)\n",
+			 sig->auth_ids[0] ? sig->auth_ids[0]->len : 0,
+			 sig->auth_ids[0] ? sig->auth_ids[0]->data : NULL,
+			 sig->auth_ids[1] ? sig->auth_ids[1]->len : 0,
+			 sig->auth_ids[1] ? sig->auth_ids[1]->data : NULL,
+			 sig->auth_ids[2] ? sig->auth_ids[2]->len : 0,
+			 sig->auth_ids[2] ? sig->auth_ids[2]->data : NULL);
+
+		switch (PTR_ERR(key)) {
+			/* Hide some search errors */
+		case -EACCES:
+		case -ENOTDIR:
+		case -EAGAIN:
+			return ERR_PTR(-ENOKEY);
+		default:
+			return ERR_CAST(key);
+		}
+	}
+
+	return key;
+}
+
+/**
+ * uasym_sig_verify_message - Verify the user asymmetric key signature
+ * @uasym_sig: The signature context
+ * @keyring: Keyring containing the key for signature verification
+ *
+ * Calculate the digest, search the key for signature verification, and verify
+ * the signature.
+ *
+ * Return: Zero if the signature is valid, a negative value otherwise.
+ */
+int uasym_sig_verify_message(struct uasym_sig_message *uasym_sig,
+			     struct key *keyring)
+{
+	const struct public_key *pub;
+	struct key *key;
+	int ret;
+
+	ret = uasym_sig_digest(uasym_sig);
+	if (ret < 0)
+		return ret;
+
+	key = get_key(uasym_sig, keyring);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	pub = key->payload.data[asym_crypto];
+
+	if (strcmp(pub->pkey_algo, uasym_sig->sig->pkey_algo) != 0 &&
+	    (strncmp(pub->pkey_algo, "ecdsa-", 6) != 0 ||
+	     strcmp(uasym_sig->sig->pkey_algo, "ecdsa") != 0)) {
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	ret = verify_signature(key, uasym_sig->sig);
+out:
+	key_put(key);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(uasym_sig_verify_message);
+
+/**
+ * uasym_sig_free_message - Free the memory allocated
+ * @uasym_sig: The signature context
+ *
+ * Free the memory allocated for the verification of the user asymmetric key
+ * signature.
+ */
+void uasym_sig_free_message(struct uasym_sig_message *uasym_sig)
+{
+	if (!uasym_sig)
+		return;
+
+	kfree(uasym_sig->sig_data);
+	public_key_signature_free(uasym_sig->sig);
+	kfree(uasym_sig);
+}
+EXPORT_SYMBOL_GPL(uasym_sig_free_message);
diff --git a/include/crypto/uasym_keys_sigs.h b/include/crypto/uasym_keys_sigs.h
new file mode 100644
index 00000000000..ac5bce6d081
--- /dev/null
+++ b/include/crypto/uasym_keys_sigs.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of the user asymmetric keys and signatures parser.
+ */
+
+#ifndef _CRYPTO_UASYM_KEYS_SIGS_H
+#define _CRYPTO_UASYM_KEYS_SIGS_H
+
+#include <linux/hash_info.h>
+#include <crypto/public_key.h>
+
+struct key;
+struct uasym_sig_message;
+
+#ifdef CONFIG_UASYM_KEYS_SIGS
+struct uasym_sig_message *uasym_sig_parse_message(const u8 *sig_data,
+						  size_t sig_len);
+int uasym_sig_supply_detached_data(struct uasym_sig_message *uasym_sig,
+				   const void *data, size_t data_len);
+int uasym_sig_get_content_data(struct uasym_sig_message *uasym_sig,
+			       const void **_data, size_t *_data_len,
+			       size_t *_headerlen);
+int uasym_sig_get_digest(struct uasym_sig_message *uasym_sig, const u8 **buf,
+			 u32 *len, enum hash_algo *hash_algo);
+int uasym_sig_verify_message(struct uasym_sig_message *uasym_sig,
+			     struct key *keyring);
+void uasym_sig_free_message(struct uasym_sig_message *uasym_sig);
+#else
+static inline struct uasym_sig_message *
+uasym_sig_parse_message(const u8 *sig_data, size_t sig_len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int
+uasym_sig_supply_detached_data(struct uasym_sig_message *uasym_sig,
+			       const void *data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+uasym_sig_get_content_data(struct uasym_sig_message *uasym_sig,
+			   const void **_data, size_t *_data_len,
+			   size_t *_headerlen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int uasym_sig_get_digest(struct uasym_sig_message *uasym_sig,
+				       const u8 **buf, u32 *len,
+				       enum hash_algo *hash_algo)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int uasym_sig_verify_message(struct uasym_sig_message *uasym_sig,
+					   struct key *keyring)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void uasym_sig_free_message(struct uasym_sig_message *uasym_sig)
+{
+}
+
+#endif /* CONFIG_UASYM_KEYS_SIGS */
+#endif /* _CRYPTO_UASYM_KEYS_SIGS_H */
diff --git a/include/uapi/linux/uasym_parser.h b/include/uapi/linux/uasym_parser.h
index 25c2995b3d4..d1bc823d954 100644
--- a/include/uapi/linux/uasym_parser.h
+++ b/include/uapi/linux/uasym_parser.h
@@ -15,6 +15,7 @@
 
 #define FOR_EACH_DATA_TYPE(DATA_TYPE) \
 	DATA_TYPE(TYPE_KEY) \
+	DATA_TYPE(TYPE_SIG) \
 	DATA_TYPE(TYPE__LAST)
 
 #define FOR_EACH_FIELD(FIELD) \
@@ -24,6 +25,14 @@
 	FIELD(KEY_KID1) \
 	FIELD(KEY_KID2) \
 	FIELD(KEY_DESC) \
+	FIELD(SIG_S) \
+	FIELD(SIG_KEY_ALGO) \
+	FIELD(SIG_HASH_ALGO) \
+	FIELD(SIG_ENC) \
+	FIELD(SIG_KID0) \
+	FIELD(SIG_KID1) \
+	FIELD(SIG_KID2) \
+	FIELD(SIG_DATA_END) \
 	FIELD(FIELD__LAST)
 
 #define GENERATE_ENUM(ENUM) ENUM,
-- 
2.34.1

