Return-Path: <linux-kernel+bounces-168344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171578BB706
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9E1C24259
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775744CDE0;
	Fri,  3 May 2024 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LCQNZO3H"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B54824AC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774633; cv=none; b=i26SlQvl6fE8E4hcmRGD/0Ujw8v552R1csFDrpIdnkh5SbL5RglApRxD62qlC+3wAkKHzzAiBytLXJ6FlEGCuBqIgO1gLYVNuwSjsd7tFVlvLUymfUjNw//91NPPr04c7mirUKvnSeq/zx74wGCS5N2fDcStx/S7tXzY05sLjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774633; c=relaxed/simple;
	bh=UN9euo6tmA4lZN0yrzzT/2yT1Q5aGhR2qOSjFmblmcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJZaI49V3YCkWpvnNvI0+z+Kr26mC6AaUf9/iXlYBH2dv0Kfe9wVVaNN8ca4oht4XCSnIu40G+sy6xi7o4fLfcJdCqGZyqDvFrn6SmPgC75DL91xdXO7o7Ul2sD5jAS4eZPyy/9Qd4WJW5b/pE0UXAAfq1v7BniEQEdBL1jIUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LCQNZO3H; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so1544321fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714774629; x=1715379429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYgJucBWcBFFpUyC+MXvUnpM2o5I+5vueQelq0cH798=;
        b=LCQNZO3HGMo18bHnIY0HTIUCIUVYAmR5HNvtXORM7sFqgSDgWXrybDTDgcMTkT+kpZ
         jkzOXXhHgqtoVz5XL35rKz45pPV6Fp0gNwDLX5SPPicBRCTUyIARd8c+tpQ4+e/UwQ05
         9E6OeOg/lvZALq0fvr4blX2HJoyqYa5aCe+L9WTPQz0FITAoXe6wE4S4/W9ibQ6g5e3M
         3+YaWM0hpcguWpbgrBFRj5lLXAPGxcYNhEI2slWcJf95a9zt3XzQHQmAnHuEjYyMkGKf
         +ybTMfrGFCIt3yyaaVSMZ9+nQ4wm2kJN3e91ooaYirAmA3MphGKxBozmEyDmVocbQZBS
         ZAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714774629; x=1715379429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYgJucBWcBFFpUyC+MXvUnpM2o5I+5vueQelq0cH798=;
        b=h00AFBig1kWlTr7G1S8wILbYlz4bCtKSGf84AISkKmIfv8mwNIxTQbLhyWmfsGhTFC
         Xau36t+HYUq5doTQZi/71UR8duF21rhq7cvLuJGYccMFPkK49SLqvZuCkINag/sAR/5/
         UBhmGF4Q0H8ElTYlLdpsBY2vEwt8TU9dajJLxwWewhM22X1K0iMOiMiTzjAtCHelHxaL
         VXS9apZe+60jzYRdcn0RNnhg6BRYw+OlyC2bae6kmchKjCy2fo4o9vvc11B91L1kpEfy
         Lsq9l80MNwmtNgMg1Tor6sawhiJpjbilMWSLqIG4t53lLG2jfOOTWvNy3MII4irQpAff
         wMcg==
X-Forwarded-Encrypted: i=1; AJvYcCWM/J3CnMtvIzyBAvb7aAVIGBZmJXypNQm1FmaYOufZ5Qss6n8LGQZFK8wKhg1ulWnKPBxnV1SU0lMqaKBAi3XK4e2s6PXNX79LYRvb
X-Gm-Message-State: AOJu0YwzSZZmWF3cG/urcmJFnHEjHq13T1Py2pf2GmNeJ8k0ipeluUHO
	RGpNr7OpaKIA9TUdGG4oXbvr2k1QJRgLjWHOoHP+No4nsMhO2V/7+qL16Em31YE=
X-Google-Smtp-Source: AGHT+IEp0UPzP5sNmxt3R0vEedKs9ER85aRDmXSl6Z/CL7L+7zQh9VI7fjuHnIp7TR4/Qejz+RIVMQ==
X-Received: by 2002:a2e:9611:0:b0:2d8:713c:8313 with SMTP id v17-20020a2e9611000000b002d8713c8313mr2190015ljh.45.1714774628932;
        Fri, 03 May 2024 15:17:08 -0700 (PDT)
Received: from localhost.localdomain ([104.28.200.6])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm10873368wms.5.2024.05.03.15.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 May 2024 15:17:08 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [RFC PATCH 2/2] KEYS: implement derived keys
Date: Fri,  3 May 2024 23:16:34 +0100
Message-Id: <20240503221634.44274-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240503221634.44274-1-ignat@cloudflare.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Derived keys are similar to user keys, but their payload is derived from the
primary TPM seed and some metadata of the requesting process. This way every
application can get a unique secret/key, which is cryptographically bound to
the TPM without the need to provide the key material externally (unlike trusted
keys). Also, the whole key derivation process is deterministic, so as long as
the TPM is available, applications can always recover their keys, which may
allow for easier key management on stateless systems.

In this implementation the following factors will be used as a key derivation
factor:
  * requested key length
  * requesting process effective user id
  * either the application executable path or the application integrity
    metadata (if available)

Key length is used so requests for keys with different sizes result in keys
with different cryptographic material.

User id is mixed, so different users get different keys even when executing the
same binary. Additionally this is useful for derived keys based on path
derivation parameter: without this an unprivileged user can create a user and a
mount namespace, put an executable to a normally privileged location (like
/usr/sbin) and recover the key for some system tool.

If an application chooses to use its path as a key derivation factor, this key
will be implicitly available for any executable located at the path. For
example, a service under /usr/sbin/sshd would always be able to recover its key
regardless of its version or implementation, but if the binary is moved
elsewhere, the key would be different.

If the application chooses to use integrity metadata as a key derivation factor,
the resulting key would be cryptographically bound to this metadata. In practice
this means that a particular binary executable will always have access to its
key regardless where it is executed from. However, if the executable code
changes, the key would change as well.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 security/keys/Kconfig                   |  16 ++
 security/keys/Makefile                  |   1 +
 security/keys/derived-keys/Makefile     |   8 +
 security/keys/derived-keys/derived.c    | 226 +++++++++++++++++++++
 security/keys/derived-keys/derived.h    |   4 +
 security/keys/derived-keys/tpm2_shash.c | 257 ++++++++++++++++++++++++
 6 files changed, 512 insertions(+)
 create mode 100644 security/keys/derived-keys/Makefile
 create mode 100644 security/keys/derived-keys/derived.c
 create mode 100644 security/keys/derived-keys/derived.h
 create mode 100644 security/keys/derived-keys/tpm2_shash.c

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index abb03a1b2a5c..62da9bff5f20 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -112,6 +112,22 @@ config USER_DECRYPTED_DATA
 
 	  If you are unsure as to whether this is required, answer N.
 
+config DERIVED_KEYS
+	tristate "DERIVED KEYS"
+	depends on KEYS
+	depends on TCG_TPM
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_KDF800108_CTR
+	help
+	  This option provides support for deriving keys from a trust source
+	  in the kernel. Derived keys are instantiated using a KDF with a seed
+	  from a trust source, so are unique per system/trust source. These keys
+	  can always be recovered as long as the trust source is available.
+
+	  If you are unsure as to whether this is required, answer N.
+
 config KEY_DH_OPERATIONS
        bool "Diffie-Hellman operations on retained keys"
        depends on KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..84456cc5cc14 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 obj-$(CONFIG_BIG_KEYS) += big_key.o
 obj-$(CONFIG_TRUSTED_KEYS) += trusted-keys/
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
+obj-$(CONFIG_DERIVED_KEYS) += derived-keys/
diff --git a/security/keys/derived-keys/Makefile b/security/keys/derived-keys/Makefile
new file mode 100644
index 000000000000..5b85c16b6878
--- /dev/null
+++ b/security/keys/derived-keys/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for derived keys
+#
+
+obj-$(CONFIG_DERIVED_KEYS) += derived-keys.o
+derived-keys-y += derived.o
+derived-keys-y += tpm2_shash.o
diff --git a/security/keys/derived-keys/derived.c b/security/keys/derived-keys/derived.c
new file mode 100644
index 000000000000..8b28c1dbde2e
--- /dev/null
+++ b/security/keys/derived-keys/derived.c
@@ -0,0 +1,226 @@
+#include <linux/module.h>
+#include <linux/key-type.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/parser.h>
+#include <keys/user-type.h>
+#include <crypto/kdf_sp800108.h>
+#include <keys/request_key_auth-type.h>
+
+#include "derived.h"
+#include "../../integrity/ima/ima.h"
+
+#define MIN_KEY_SIZE 1
+#define MAX_KEY_SIZE 1024
+
+enum { Opt_path, Opt_exe_csum, Opt_err };
+
+static const match_table_t kdf_tokens = {
+	{ Opt_path, "path" },
+	{ Opt_exe_csum, "csum" },
+	{ Opt_err, NULL }
+};
+
+static int get_current_exe_path(char *buf, size_t buf_len, char **path)
+{
+	struct file *exe_file = get_task_exe_file(current);
+	if (!exe_file)
+		return -EFAULT;
+
+	*path = file_path(exe_file, buf, buf_len);
+	fput(exe_file);
+
+	return IS_ERR(*path) ? PTR_ERR(*path) : 0;
+}
+
+#ifdef CONFIG_IMA
+static struct ima_digest_data *get_currect_exe_integrity(void)
+{
+	struct ima_iint_cache *iint;
+	struct file *exe_file = get_task_exe_file(current);
+	if (!exe_file)
+		return NULL;
+
+	iint = ima_iint_find(file_inode(exe_file));
+	fput(exe_file);
+
+	return iint ? iint->ima_hash : NULL;
+}
+#endif
+
+static int tpm2_kdf_generate(int kdf_mix, u8 *out, size_t out_len)
+{
+	int ret;
+	struct kvec kbuf_iov[4];
+	char *path;
+	kuid_t euid = current_euid();
+
+	struct crypto_shash *tpm2_hash = crypto_alloc_shash(
+		TPM2_HASH_IMPL_NAME, CRYPTO_ALG_INTERNAL, CRYPTO_ALG_INTERNAL);
+	if (IS_ERR(tpm2_hash))
+		return PTR_ERR(tpm2_hash);
+
+	kbuf_iov[0].iov_base = &out_len;
+	kbuf_iov[0].iov_len = sizeof(u32);
+
+	kbuf_iov[1].iov_base = &euid;
+	kbuf_iov[1].iov_len = sizeof(euid);
+
+	switch (kdf_mix) {
+	case Opt_path:
+		kbuf_iov[2].iov_base = "path";
+		kbuf_iov[2].iov_len = sizeof("path");
+
+		path = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!path) {
+			ret = -ENOMEM;
+			goto free_hash;
+		}
+
+		ret = get_current_exe_path(path, PATH_MAX,
+					   (char **)&kbuf_iov[3].iov_base);
+		if (ret) {
+			kfree(path);
+			goto free_hash;
+		}
+
+		kbuf_iov[3].iov_len = strlen(kbuf_iov[3].iov_base);
+		break;
+#ifdef CONFIG_IMA
+	case Opt_exe_csum:
+		kbuf_iov[2].iov_base = "csum";
+		kbuf_iov[2].iov_len = sizeof("csum");
+
+		struct ima_digest_data *digest = get_currect_exe_integrity();
+		if (!digest) {
+			ret = -EOPNOTSUPP;
+			goto free_hash;
+		}
+
+		kbuf_iov[3].iov_base = digest->digest;
+		kbuf_iov[3].iov_len = digest->length;
+		break;
+#endif
+	}
+
+	ret = crypto_kdf108_ctr_generate(tpm2_hash, kbuf_iov,
+					 ARRAY_SIZE(kbuf_iov), out, out_len);
+	switch (kdf_mix) {
+	case Opt_path:
+		kfree(path);
+	}
+
+free_hash:
+	crypto_free_shash(tpm2_hash);
+	return ret;
+}
+
+static int derived_preparse(struct key_preparsed_payload *prep)
+{
+	int ret;
+	char *opts, *cur, *opt;
+	int kdf_mix;
+	unsigned long keylen;
+	substring_t args[MAX_OPT_ARGS];
+	struct user_key_payload *upayload;
+	size_t optslen = prep->datalen;
+
+	if (!prep->data || !prep->datalen)
+		return -EINVAL;
+
+	opts = cur = kmalloc(optslen + 1, GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	opts[optslen] = 0;
+	memcpy(opts, prep->data, optslen);
+
+	opt = strsep(&cur, " \t");
+	if (!opt) {
+		ret = -EINVAL;
+		goto free_opts;
+	}
+
+	ret = kstrtoul(opts, 10, &keylen);
+	if (ret)
+		goto free_opts;
+
+	if (keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE) {
+		ret = -EINVAL;
+		goto free_opts;
+	}
+
+	if (!cur) {
+		ret = -EINVAL;
+		goto free_opts;
+	}
+
+	kdf_mix = match_token(cur, kdf_tokens, args);
+	switch (kdf_mix) {
+#ifndef CONFIG_IMA
+	case Opt_exe_csum:
+		ret = -EOPNOTSUPP;
+		goto free_opts;
+#endif
+	case Opt_err:
+		ret = -EINVAL;
+		goto free_opts;
+	}
+
+	upayload = kmalloc(sizeof(*upayload) + keylen, GFP_KERNEL);
+	if (!upayload) {
+		ret = -ENOMEM;
+		goto free_opts;
+	}
+
+	ret = tpm2_kdf_generate(kdf_mix, upayload->data, keylen);
+	if (ret)
+		goto free_payload;
+
+	prep->quotalen = keylen;
+	prep->payload.data[0] = upayload;
+	upayload->datalen = keylen;
+	goto free_opts;
+
+free_payload:
+	kfree(upayload);
+free_opts:
+	kfree(opts);
+	return ret;
+}
+
+static struct key_type key_type_derived = {
+	.name = "derived",
+	.preparse = derived_preparse,
+	.free_preparse = user_free_preparse,
+	.instantiate = generic_key_instantiate,
+	.revoke = user_revoke,
+	.destroy = user_destroy,
+	.describe = user_describe,
+	.read = user_read,
+};
+
+static int __init init_derived(void)
+{
+	int ret;
+
+	ret = register_tpm2_shash();
+	if (ret)
+		return ret;
+
+	ret = register_key_type(&key_type_derived);
+	if (ret)
+		unregister_tpm2_shash();
+
+	return ret;
+}
+
+static void __exit cleanup_derived(void)
+{
+	unregister_key_type(&key_type_derived);
+	unregister_tpm2_shash();
+}
+
+late_initcall(init_derived);
+module_exit(cleanup_derived);
+
+MODULE_LICENSE("GPL");
diff --git a/security/keys/derived-keys/derived.h b/security/keys/derived-keys/derived.h
new file mode 100644
index 000000000000..6f2910fb7afa
--- /dev/null
+++ b/security/keys/derived-keys/derived.h
@@ -0,0 +1,4 @@
+#define TPM2_HASH_IMPL_NAME "tpm2-hmac-internal"
+
+int register_tpm2_shash(void);
+void unregister_tpm2_shash(void);
diff --git a/security/keys/derived-keys/tpm2_shash.c b/security/keys/derived-keys/tpm2_shash.c
new file mode 100644
index 000000000000..79b7fecd7753
--- /dev/null
+++ b/security/keys/derived-keys/tpm2_shash.c
@@ -0,0 +1,257 @@
+#include "derived.h"
+#include <linux/tpm.h>
+#include <linux/tpm_command.h>
+
+#include <crypto/internal/hash.h>
+#include <crypto/sha2.h>
+
+/* create hierarchy with a custom unique value */
+#define TPM2_KERNEL_HIERARCHY "kernel"
+
+static struct tpm_chip *chip = NULL;
+
+static int tpm2_hash_init(struct shash_desc *desc)
+{
+	struct tpm_buf *buf = shash_desc_ctx(desc);
+	int ret = tpm_buf_init(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_HASH);
+	if (ret)
+		return ret;
+
+	/* provisional size value for data size to be hashed */
+	tpm_buf_append_u16(buf, 0);
+
+	return 0;
+}
+
+static int tpm2_hash_update(struct shash_desc *desc, const u8 *data,
+			    unsigned int len)
+{
+	struct tpm_buf *buf = shash_desc_ctx(desc);
+
+	tpm_buf_append(buf, data, len);
+
+	if (buf->flags & TPM_BUF_OVERFLOW) {
+		tpm_buf_destroy(buf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline void tpm2_buf_append_null_auth(struct tpm_buf *buf)
+{
+	tpm_buf_append_u32(buf, 9);
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	tpm_buf_append_u16(buf, 0); /* nonce len */
+	tpm_buf_append_u8(buf, 0); /* attributes */
+	tpm_buf_append_u16(buf, 0); /* hmac len */
+}
+
+static int tpm2_hmac_create_primary(u32 *handle)
+{
+	struct tpm_buf buf;
+
+	int ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	if (ret)
+		return ret;
+
+	/* owner hierarchy */
+	tpm_buf_append_u32(&buf, TPM2_RH_OWNER);
+
+	tpm2_buf_append_null_auth(&buf);
+
+	/* tpm2 sensitive */
+	tpm_buf_append_u16(&buf, 4);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* tpm2 public */
+	tpm_buf_append_u16(&buf, 16 + sizeof(TPM2_KERNEL_HIERARCHY) - 1);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+	tpm_buf_append_u32(&buf, TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT |
+					 TPM2_OA_SENSITIVE_DATA_ORIGIN |
+					 TPM2_OA_USER_WITH_AUTH |
+					 TPM2_OA_RESTRICTED |
+					 TPM2_OA_SIGN); /* attr */
+	tpm_buf_append_u16(&buf, 0); /* auth policy */
+	tpm_buf_append_u16(&buf, TPM_ALG_HMAC);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+	tpm_buf_append_u16(&buf,
+			   sizeof(TPM2_KERNEL_HIERARCHY) - 1); /* unique len */
+	tpm_buf_append(&buf, TPM2_KERNEL_HIERARCHY,
+		       sizeof(TPM2_KERNEL_HIERARCHY) - 1); /* unique */
+
+	/* outside info */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* pcr selection */
+	tpm_buf_append_u32(&buf, 0);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	ret = tpm_transmit_cmd(chip, &buf, 4,
+			       "create primary kernel hmac hierarchy");
+	if (ret < 0)
+		goto free_buf;
+
+	if (ret > 0) {
+		ret = tpm2_rc_value(ret) == TPM2_RC_OBJECT_MEMORY ? -ENOMEM :
+								    -EPERM;
+		goto free_buf;
+	}
+
+	*handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
+
+free_buf:
+	tpm_buf_destroy(&buf);
+	return ret;
+}
+
+static int tpm2_sign(u32 handle, const u8 *tpm2b_digest, size_t digest_len,
+		     const u8 *ticket, size_t ticket_len, u8 *out)
+{
+	struct tpm_buf buf;
+
+	int ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_SIGN);
+	if (ret)
+		return ret;
+
+	/* signing key handle */
+	tpm_buf_append_u32(&buf, handle);
+
+	tpm2_buf_append_null_auth(&buf);
+
+	/* digest to sign */
+	tpm_buf_append(&buf, tpm2b_digest, digest_len);
+
+	/* sig scheme */
+	tpm_buf_append_u16(&buf, TPM_ALG_HMAC);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	/* validation (needed for restricted keys) */
+	tpm_buf_append(&buf, ticket, ticket_len);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	ret = tpm_transmit_cmd(chip, &buf, 4 + 2 + 2 + SHA256_DIGEST_SIZE,
+			       "sign data");
+	if (ret < 0)
+		goto free_buf;
+
+	if (ret > 0) {
+		ret = tpm2_rc_value(ret) == TPM2_RC_OBJECT_MEMORY ? -ENOMEM :
+								    -EPERM;
+		goto free_buf;
+	}
+
+	/* check resp len */
+	if (be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]) !=
+	    2 + 2 + SHA256_DIGEST_SIZE) {
+		ret = -EFAULT;
+		goto free_buf;
+	}
+
+	memcpy(out, &buf.data[TPM_HEADER_SIZE + 4 + 2 + 2], SHA256_DIGEST_SIZE);
+	memzero_explicit(&buf.data[TPM_HEADER_SIZE + 4 + 2 + 2],
+			 SHA256_DIGEST_SIZE);
+
+free_buf:
+	tpm_buf_destroy(&buf);
+	return ret;
+}
+
+static int tpm2_hash_final(struct shash_desc *desc, u8 *out)
+{
+	u32 handle;
+	int ret;
+	size_t digest_len;
+	struct tpm_buf *buf = shash_desc_ctx(desc);
+
+	/* adjust the input data length */
+	*((__be16 *)&buf->data[TPM_HEADER_SIZE]) =
+		cpu_to_be16(tpm_buf_length(buf) - TPM_HEADER_SIZE - 2);
+
+	tpm_buf_append_u16(buf, TPM_ALG_SHA256);
+	tpm_buf_append_u32(buf, TPM2_RH_OWNER);
+
+	if (buf->flags & TPM_BUF_OVERFLOW) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		goto free_buf;
+
+	ret = tpm_transmit_cmd(chip, buf, 2 + SHA256_DIGEST_SIZE, "hash data");
+	if (ret < 0)
+		goto put_ops;
+
+	if (ret > 0) {
+		ret = -EPERM;
+		goto put_ops;
+	}
+
+	ret = tpm2_hmac_create_primary(&handle);
+	if (ret)
+		goto put_ops;
+
+	digest_len = be16_to_cpup((__be16 *)&buf->data[TPM_HEADER_SIZE]) + 2;
+	ret = tpm2_sign(handle, &buf->data[TPM_HEADER_SIZE], digest_len,
+			&buf->data[TPM_HEADER_SIZE + digest_len],
+			tpm_buf_length(buf) - TPM_HEADER_SIZE - digest_len,
+			out);
+
+	tpm2_flush_context(chip, handle);
+
+put_ops:
+	tpm_put_ops(chip);
+free_buf:
+	tpm_buf_destroy(buf);
+	return ret;
+}
+
+static struct shash_alg alg = {
+	.digestsize = SHA256_DIGEST_SIZE,
+	.init = tpm2_hash_init,
+	.update = tpm2_hash_update,
+	.final = tpm2_hash_final,
+	.descsize = sizeof(struct tpm_buf),
+	.base = {
+		.cra_name = "sha256",
+		.cra_driver_name = TPM2_HASH_IMPL_NAME,
+		.cra_priority = 0,
+		.cra_blocksize = SHA256_BLOCK_SIZE,
+		.cra_flags = CRYPTO_ALG_INTERNAL,
+		.cra_module = THIS_MODULE,
+	}
+};
+
+int register_tpm2_shash(void)
+{
+	int ret;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	ret = crypto_register_shash(&alg);
+	if (ret)
+		put_device(&chip->dev);
+
+	return ret;
+}
+
+void unregister_tpm2_shash(void)
+{
+	crypto_unregister_shash(&alg);
+	if (chip)
+		put_device(&chip->dev);
+}
-- 
2.39.2


