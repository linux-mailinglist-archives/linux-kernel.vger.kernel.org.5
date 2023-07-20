Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2294C75B2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGTPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGTPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:36:05 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D692D75;
        Thu, 20 Jul 2023 08:35:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6Gh01dHcz9xqxP;
        Thu, 20 Jul 2023 23:24:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S9;
        Thu, 20 Jul 2023 16:35:10 +0100 (CET)
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
Subject: [RFC][PATCH v3 7/9] KEYS: asymmetric: Preload user asymmetric keys from a keyring blob
Date:   Thu, 20 Jul 2023 17:32:43 +0200
Message-Id: <20230720153247.3755856-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S9
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13Xr1fAFWxCw4Dury5CFg_yoW7XF4rpa
        yrCrWrtFZ0ywn7C34FkF1Igw13CrW093y5Ka4Skw1Yv34qqF4kGrWIgr1rKry5Jr1kKayf
        Z34q9w4UCr1ktrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4y-3QAAsd
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

Provide a function to load user asymmetric keys from a keyring blob to the
keyring supplied:

        int preload_uasym_keys(const u8 *data, size_t data_len,
                               struct key *keyring);

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Makefile            |   3 +-
 crypto/asymmetric_keys/uasym_key_preload.c | 102 +++++++++++++++++++++
 include/crypto/uasym_keys_sigs.h           |   9 ++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/uasym_key_preload.c

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 191b7fe8359..ffc6c7d6e65 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -82,4 +82,5 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 #
 obj-$(CONFIG_UASYM_KEYS_SIGS) += uasym_keys_sigs.o
 uasym_keys_sigs-y := uasym_key_parser.o \
-		     uasym_sig_parser.o
+		     uasym_sig_parser.o \
+		     uasym_key_preload.o
diff --git a/crypto/asymmetric_keys/uasym_key_preload.c b/crypto/asymmetric_keys/uasym_key_preload.c
new file mode 100644
index 00000000000..039dbf64378
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_key_preload.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Authors:
+ *   David Howells <dhowells@redhat.com>
+ *   Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Load user asymmetric keys from a keyring blob.
+ */
+
+#define pr_fmt(fmt) "UASYM PRELOAD: "fmt
+#include <linux/module.h>
+#include <linux/key.h>
+#include <linux/err.h>
+#include <linux/tlv_parser.h>
+
+#include "uasym_parser.h"
+
+/**
+ * create_uasym_key - Create a user asymmetric key
+ * @data_start: Where the user asymmetric key starts in the blob
+ * @data_end: Where the user asymmetric key ends in the blob
+ * @keyring: The keyring to add the new key to
+ *
+ * Create a user asymmetric key from the supplied buffer.
+ */
+static void __init create_uasym_key(const u8 *data_start, const u8 *data_end,
+				    struct key *keyring)
+{
+	key_ref_t key;
+
+	key = key_create_or_update(make_key_ref(keyring, 1), "asymmetric", NULL,
+				   data_start, data_end - data_start,
+				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				    KEY_USR_VIEW | KEY_USR_READ),
+				   KEY_ALLOC_NOT_IN_QUOTA |
+				   KEY_ALLOC_BUILT_IN |
+				   KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(key)) {
+		pr_notice("Ignoring user asymmetric key, error: %ld\n",
+			  PTR_ERR(key));
+		return;
+	}
+
+	pr_notice("Loaded user asymmetric key '%s'\n",
+		  key_ref_to_ptr(key)->description);
+
+	key_ref_put(key);
+}
+
+/**
+ * preload_uasym_keys - Load user asymmetric keys from a keyring blob
+ * @data: The keyring blob containing the user asymmetric keys
+ * @data_len: The size of the @data blob
+ * @keyring: The keyring to add the new keys to
+ *
+ * Preload a pack of user asymmetric keys from a keyring blob.
+ *
+ * The callers should override the current creds if they want the keys to be
+ * owned by someone other than the current process's owner. Keys will not be
+ * accounted towards the owner's quota.
+ *
+ * This function may only be called whilst the kernel is booting.
+ *
+ * Return: Zero on success, a negative value otherwise.
+ */
+int __init preload_uasym_keys(const u8 *data, size_t data_len,
+			      struct key *keyring)
+{
+	const u8 *data_ptr = data, *data_end = data + data_len;
+	u64 data_type;
+	u64 num_fields;
+	u64 total_len;
+	int ret;
+
+	kenter("");
+
+	while (data_ptr < data_end) {
+		ret = tlv_parse_hdr(&data_ptr, &data_len, &data_type,
+				    &num_fields, &total_len, data_types_str,
+				    TYPE__LAST);
+		if (ret < 0) {
+			pr_notice("Unable to parse keyring blob, ret: %d\n",
+				  ret);
+			return ret;
+		}
+
+		if (data_type != TYPE_KEY) {
+			data_ptr += total_len;
+			continue;
+		}
+
+		create_uasym_key(data_ptr - sizeof(struct tlv_hdr),
+				 data_ptr + total_len, keyring);
+
+		data_ptr += total_len;
+	}
+
+	return 0;
+}
diff --git a/include/crypto/uasym_keys_sigs.h b/include/crypto/uasym_keys_sigs.h
index ac5bce6d081..a227d6d082e 100644
--- a/include/crypto/uasym_keys_sigs.h
+++ b/include/crypto/uasym_keys_sigs.h
@@ -29,6 +29,9 @@ int uasym_sig_get_digest(struct uasym_sig_message *uasym_sig, const u8 **buf,
 int uasym_sig_verify_message(struct uasym_sig_message *uasym_sig,
 			     struct key *keyring);
 void uasym_sig_free_message(struct uasym_sig_message *uasym_sig);
+
+int __init preload_uasym_keys(const u8 *data, size_t data_len,
+			      struct key *keyring);
 #else
 static inline struct uasym_sig_message *
 uasym_sig_parse_message(const u8 *sig_data, size_t sig_len)
@@ -68,5 +71,11 @@ static inline void uasym_sig_free_message(struct uasym_sig_message *uasym_sig)
 {
 }
 
+static inline int __init preload_uasym_keys(const u8 *data, size_t data_len,
+					    struct key *keyring)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_UASYM_KEYS_SIGS */
 #endif /* _CRYPTO_UASYM_KEYS_SIGS_H */
-- 
2.34.1

