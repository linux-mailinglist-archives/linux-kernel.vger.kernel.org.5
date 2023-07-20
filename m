Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31F375B2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjGTPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjGTPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:35:54 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58E272B;
        Thu, 20 Jul 2023 08:35:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6Ggm1jDQz9v7g2;
        Thu, 20 Jul 2023 23:24:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S8;
        Thu, 20 Jul 2023 16:34:58 +0100 (CET)
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
Subject: [RFC][PATCH v3 6/9] verification: Add verify_uasym_signature() and verify_uasym_sig_message()
Date:   Thu, 20 Jul 2023 17:32:42 +0200
Message-Id: <20230720153247.3755856-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8CrW3Wr1rurykAF43ZFb_yoWxKF4xpF
        9Yqr1rZF98Awn3Aa47Ka1I9w1fWrn5Jw17KasFy3WfZFnYq3ZrGrs0gF1YqrW5C348GFWj
        9r9FvFW3KanxAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5C8oAAAs8
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

Introduce verify_uasym_signature() and verify_uasym_sig_message(), to
verify user asymmetric key signatures from detached data. It aims to be
used by kernel subsystems wishing to verify the authenticity of system
data, with system-defined keyrings as trust anchor.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 125 +++++++++++++++++++++++++++++++++++
 include/linux/verification.h |  46 +++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb..dbee2e5b732 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,6 +16,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <crypto/uasym_keys_sigs.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -339,6 +340,130 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_UASYM_KEYS_SIGS
+/**
+ * verify_uasym_sig_message - Verify a user asym key signature on system data
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @uasym_sig: The signature context
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the user asymmetric key signature of the supplied system data,
+ * against a key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_uasym_sig_message(const void *data, size_t len,
+			     struct uasym_sig_message *uasym_sig,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx,
+						 const void *data, size_t len,
+						 size_t asn1hdrlen),
+			     void *ctx)
+{
+	int ret;
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && uasym_sig_supply_detached_data(uasym_sig, data, len)) {
+		pr_err("Failed to supply data for user asymmetric key signature\n");
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	if (!trusted_keys) {
+		trusted_keys = builtin_trusted_keys;
+	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+		trusted_keys = secondary_trusted_keys;
+#else
+		trusted_keys = builtin_trusted_keys;
+#endif
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+		trusted_keys = platform_trusted_keys;
+#else
+		trusted_keys = NULL;
+#endif
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("Platform keyring is not available\n");
+			goto error;
+		}
+	}
+
+	ret = uasym_sig_verify_message(uasym_sig, trusted_keys);
+	if (ret < 0)
+		goto error;
+
+	if (view_content) {
+		size_t sig_data_len;
+
+		ret = uasym_sig_get_content_data(uasym_sig, &data, &len,
+						 &sig_data_len);
+		if (ret < 0) {
+			if (ret == -ENODATA)
+				pr_devel("User asymmetric key signature does not contain data\n");
+			goto error;
+		}
+
+		ret = view_content(ctx, data, len, sig_data_len);
+		kfree(data);
+	}
+error:
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_uasym_sig_message);
+
+/**
+ * verify_uasym_signature - Verify a user asym key signature on system data
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @raw_uasym_sig: The raw signature
+ * @raw_uasym_sig_len: The size of @raw_uasym_sig
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the user asymmetric key signature of the supplied system data,
+ * against a key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_uasym_signature(const void *data, size_t len,
+			   const void *raw_uasym_sig, size_t raw_uasym_sig_len,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx,
+					       const void *data, size_t len,
+					       size_t asn1hdrlen),
+			   void *ctx)
+{
+	struct uasym_sig_message *uasym_sig;
+	int ret;
+
+	uasym_sig = uasym_sig_parse_message(raw_uasym_sig, raw_uasym_sig_len);
+	if (IS_ERR(uasym_sig))
+		return PTR_ERR(uasym_sig);
+
+	ret = verify_uasym_sig_message(data, len, uasym_sig, trusted_keys, usage,
+				       view_content, ctx);
+
+	uasym_sig_free_message(uasym_sig);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_uasym_signature);
+#endif /* CONFIG_UASYM_KEYS_SIGS */
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
diff --git a/include/linux/verification.h b/include/linux/verification.h
index f34e50ebcf6..9e8deea7755 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -43,6 +43,7 @@ extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
 
 struct key;
 struct pkcs7_message;
+struct uasym_sig_message;
 
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
@@ -62,6 +63,51 @@ extern int verify_pkcs7_message_sig(const void *data, size_t len,
 							size_t asn1hdrlen),
 				    void *ctx);
 
+#ifdef CONFIG_UASYM_KEYS_SIGS
+int verify_uasym_sig_message(const void *data, size_t len,
+			     struct uasym_sig_message *uasym_sig,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx, const void *data,
+						 size_t len, size_t asn1hdrlen),
+			     void *ctx);
+int verify_uasym_signature(const void *data, size_t len,
+			   const void *raw_uasym_sig,
+			   size_t raw_uasym_sig_len,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx, const void *data,
+					       size_t len, size_t asn1hdrlen),
+			   void *ctx);
+#else
+static inline int verify_uasym_sig_message(const void *data, size_t len,
+					   struct uasym_sig_message *uasym_sig,
+					   struct key *trusted_keys,
+					   enum key_being_used_for usage,
+					   int (*view_content)(void *ctx,
+							const void *data,
+							size_t len,
+							size_t asn1hdrlen),
+					   void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int verify_uasym_signature(const void *data, size_t len,
+					 const void *raw_uasym_sig,
+					 size_t raw_uasym_sig_len,
+					 struct key *trusted_keys,
+					 enum key_being_used_for usage,
+					 int (*view_content)(void *ctx,
+							     const void *data,
+							     size_t len,
+							     size_t asn1hdrlen),
+					 void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_UASYM_KEYS_SIGS */
+
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   struct key *trusted_keys,
-- 
2.34.1

