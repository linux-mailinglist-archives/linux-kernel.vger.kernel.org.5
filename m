Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12175B2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGTPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjGTPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:35:25 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF82270E;
        Thu, 20 Jul 2023 08:35:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6Gd85ZWmz9xGXP;
        Thu, 20 Jul 2023 23:22:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S6;
        Thu, 20 Jul 2023 16:34:34 +0100 (CET)
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
Subject: [RFC][PATCH v3 4/9] KEYS: asymmetric: Introduce the user asymmetric key parser
Date:   Thu, 20 Jul 2023 17:32:40 +0200
Message-Id: <20230720153247.3755856-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S6
X-Coremail-Antispam: 1UD129KBjvAXoWfJrWDXr4rXFyxWFy7Xr13Jwb_yoW8Jr18Jo
        Zagr45Jw4fWw4qkan5uF17Ar4DZ345GF4fZ3y3uF1UZan0v34UKr4rCayxCFWfAw1UKwnY
        9ryxJa4aqw4Utw15n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYK7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4y-2AAAsY
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new parser for user asymmetric keys, in TLV format. User space
tools are expected to convert keys from their original format to the TLV
format.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig            |  13 ++
 crypto/asymmetric_keys/Makefile           |   6 +
 crypto/asymmetric_keys/asymmetric_type.c  |   3 +-
 crypto/asymmetric_keys/uasym_key_parser.c | 240 ++++++++++++++++++++++
 crypto/asymmetric_keys/uasym_parser.h     |  26 +++
 include/keys/asymmetric-type.h            |   1 +
 include/uapi/linux/uasym_parser.h         |  50 +++++
 7 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/uasym_key_parser.c
 create mode 100644 crypto/asymmetric_keys/uasym_parser.h
 create mode 100644 include/uapi/linux/uasym_parser.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1ef3b46d6f6..4a5f66511d4 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -85,4 +85,17 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 
+config UASYM_KEYS_SIGS
+	tristate "User asymmetric keys and signatures"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO_PUB_KEY_INFO
+	select TLV_PARSER
+	help
+	  This option enables user asymmetric keys and signatures. They are
+	  keys and signatures converted in user space from their native
+	  format (e.g. PGP), to the TLV format (Type-Length-Value) understood
+	  by the kernel.
+
+	  Key and signature-specific fields are defined in the UAPI interface,
+	  so that user space converters can reference them.
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 0d1fa1b692c..5ba30cca09e 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -76,3 +76,9 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# User asymmetric keys and signatures
+#
+obj-$(CONFIG_UASYM_KEYS_SIGS) += uasym_keys_sigs.o
+uasym_keys_sigs-y := uasym_key_parser.o
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a5da8ccd353..53d0fc26eac 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -430,7 +430,7 @@ static int asymmetric_key_preparse(struct key_preparsed_payload *prep)
 /*
  * Clean up the key ID list
  */
-static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
+void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 {
 	int i;
 
@@ -440,6 +440,7 @@ static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 		kfree(kids);
 	}
 }
+EXPORT_SYMBOL_GPL(asymmetric_key_free_kids);
 
 /*
  * Clean up the preparse data
diff --git a/crypto/asymmetric_keys/uasym_key_parser.c b/crypto/asymmetric_keys/uasym_key_parser.c
new file mode 100644
index 00000000000..36a5faa2706
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_key_parser.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user asymmetric key parser.
+ */
+
+#define pr_fmt(fmt) "UASYM KEY: "fmt
+#include <linux/module.h>
+#include <linux/tlv_parser.h>
+#include <crypto/public_key.h>
+#include <crypto/pub_key_info.h>
+
+#include "uasym_parser.h"
+
+const char *data_types_str[] = {
+	FOR_EACH_DATA_TYPE(GENERATE_STRING)
+};
+
+const char *fields_str[] = {
+	FOR_EACH_FIELD(GENERATE_STRING)
+};
+
+static int parse_key_pub(struct public_key *pub, enum fields field,
+			 const u8 *field_data, u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	pub->key = kmemdup(field_data, field_data_len, GFP_KERNEL);
+	if (!pub->key) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pub->keylen = field_data_len;
+	pr_debug("Key length in bytes: %d\n", pub->keylen);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+int parse_key_algo(const char **pkey_algo, enum fields field,
+		   const u8 *field_data, u64 field_data_len)
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
+	if (algo >= PKEY_ALGO__LAST) {
+		pr_debug("Unexpected public key algo %u\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	*pkey_algo = pub_key_algo_name[algo];
+	pr_debug("Public key algo: %s\n", *pkey_algo);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+int parse_key_kid(struct asymmetric_key_id **id, enum fields field,
+		  const u8 *field_data, u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	*id = asymmetric_key_generate_id(field_data, field_data_len, NULL, 0);
+	if (!*id) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pr_debug("Key/auth identifier: %*phN\n", (*id)->len, (*id)->data);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_key_desc(struct key_preparsed_payload *prep, enum fields field,
+			  const u8 *field_data, u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (field_data[field_data_len - 1] != '\0') {
+		pr_err("Non-terminated string\n");
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	prep->description = kstrndup(field_data, field_data_len, GFP_KERNEL);
+	if (!prep->description) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pr_debug("Key description: %s\n", prep->description);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+struct callback_struct {
+	struct public_key *pub;
+	struct asymmetric_key_ids *kids;
+	struct key_preparsed_payload *prep;
+};
+
+static int key_callback(void *callback_data, u64 field, const u8 *field_data,
+			u64 field_data_len)
+{
+	struct callback_struct *cb_s = (struct callback_struct *)callback_data;
+	struct asymmetric_key_id **id;
+	int ret;
+
+	switch (field) {
+	case KEY_PUB:
+		ret = parse_key_pub(cb_s->pub, field, field_data,
+				    field_data_len);
+		break;
+	case KEY_ALGO:
+		ret = parse_key_algo(&cb_s->pub->pkey_algo, field, field_data,
+				     field_data_len);
+		break;
+	case KEY_KID0:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[0];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_KID1:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[1];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_KID2:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[2];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_DESC:
+		ret = parse_key_desc(cb_s->prep, field, field_data,
+				     field_data_len);
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
+static int uasym_key_parse(struct key_preparsed_payload *prep)
+{
+	struct callback_struct cb_s;
+	int ret;
+
+	kenter("");
+
+	cb_s.pub = kzalloc(sizeof(*cb_s.pub), GFP_KERNEL);
+	if (!cb_s.pub) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cb_s.pub->id_type = "UASYM_KEY";
+
+	cb_s.kids = kzalloc(sizeof(*cb_s.kids), GFP_KERNEL);
+	if (!cb_s.kids) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cb_s.prep = prep;
+
+	ret = tlv_parse(TYPE_KEY, key_callback, &cb_s, prep->data,
+			prep->datalen, data_types_str, TYPE__LAST, fields_str,
+			FIELD__LAST);
+	if (ret < 0)
+		goto out;
+
+	if (!cb_s.pub->key || !cb_s.pub->pkey_algo ||
+	    (!cb_s.kids->id[0] && !cb_s.kids->id[1] && !cb_s.kids->id[2])) {
+		pr_debug("Incomplete data\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = cb_s.kids;
+	prep->payload.data[asym_crypto] = cb_s.pub;
+	prep->quotalen = 100;
+out:
+	kleave(" = %d", ret);
+
+	if (ret < 0) {
+		public_key_free(cb_s.pub);
+		asymmetric_key_free_kids(cb_s.kids);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct asymmetric_key_parser uasym_key_parser = {
+	.owner = THIS_MODULE,
+	.name = "uasym_key",
+	.parse = uasym_key_parse
+};
+
+static int __init uasym_key_init(void)
+{
+	return register_asymmetric_key_parser(&uasym_key_parser);
+}
+
+static void __exit uasym_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&uasym_key_parser);
+}
+
+module_init(uasym_key_init);
+module_exit(uasym_key_exit);
+MODULE_LICENSE("GPL");
diff --git a/crypto/asymmetric_keys/uasym_parser.h b/crypto/asymmetric_keys/uasym_parser.h
new file mode 100644
index 00000000000..cd8bc934d38
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_parser.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of user asymmetric keys and signatures.
+ */
+
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+
+#include <uapi/linux/uasym_parser.h>
+
+#define kenter(FMT, ...) \
+	pr_debug("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_debug("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
+
+extern const char *data_types_str[];
+extern const char *fields_str[];
+
+int parse_key_algo(const char **pkey_algo, enum fields field,
+		   const u8 *field_data, u64 field_data_len);
+int parse_key_kid(struct asymmetric_key_id **id, enum fields field,
+		  const u8 *field_data, u64 field_data_len);
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 69a13e1e5b2..acbb8c805f6 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -66,6 +66,7 @@ extern struct asymmetric_key_id *asymmetric_key_generate_id(const void *val_1,
 							    size_t len_1,
 							    const void *val_2,
 							    size_t len_2);
+void asymmetric_key_free_kids(struct asymmetric_key_ids *kids);
 static inline
 const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
 {
diff --git a/include/uapi/linux/uasym_parser.h b/include/uapi/linux/uasym_parser.h
new file mode 100644
index 00000000000..25c2995b3d4
--- /dev/null
+++ b/include/uapi/linux/uasym_parser.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user space interface for user asymmetric keys and signatures.
+ */
+
+#ifndef _UAPI_LINUX_UASYM_PARSER_H
+#define _UAPI_LINUX_UASYM_PARSER_H
+
+#include <linux/types.h>
+#include <linux/pub_key_info.h>
+
+#define FOR_EACH_DATA_TYPE(DATA_TYPE) \
+	DATA_TYPE(TYPE_KEY) \
+	DATA_TYPE(TYPE__LAST)
+
+#define FOR_EACH_FIELD(FIELD) \
+	FIELD(KEY_PUB) \
+	FIELD(KEY_ALGO) \
+	FIELD(KEY_KID0) \
+	FIELD(KEY_KID1) \
+	FIELD(KEY_KID2) \
+	FIELD(KEY_DESC) \
+	FIELD(FIELD__LAST)
+
+#define GENERATE_ENUM(ENUM) ENUM,
+#define GENERATE_STRING(STRING) #STRING,
+
+/**
+ * enum data_types - Type of data to parse
+ *
+ * Enumerates the type of data to parse.
+ */
+enum data_types {
+	FOR_EACH_DATA_TYPE(GENERATE_ENUM)
+};
+
+/**
+ * enum fields - Data fields
+ *
+ * Enumerates the data fields. Some belongs to keys, some to signatures.
+ */
+enum fields {
+	FOR_EACH_FIELD(GENERATE_ENUM)
+};
+
+#endif /* _UAPI_LINUX_UASYM_PARSER_H */
-- 
2.34.1

