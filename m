Return-Path: <linux-kernel+bounces-125609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B190892995
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7901F225A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF33C2F;
	Sat, 30 Mar 2024 06:55:37 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6914364;
	Sat, 30 Mar 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711781737; cv=none; b=ByTSKybcW8apf6AvyOzilfzvNpEEMsrWPr9sDowI0NaENU3oOrA+TDWf4Hb6I78k7GbuWwDxMA0J700G/KiBzFlrBBAitbaNDcXvzfilQlHJNtebWbgoSJ1DsdJvLd2xc5NGQFIZ51tNt2xlRq4oOy+LA4KgBWA4utzVSqJPoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711781737; c=relaxed/simple;
	bh=lgxNegEMuoGAxpcbZuwjYmX2F4822MXbSCEL5wyAOSw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XrV5OZp66q80vkTzvqjiFyDZNyhP2CNpocqJKbIF1YIr/p+HO4/+T6vMaY5J3pq4Nh/1h3e3gfqXleYJexyV5hIJs0XyJ4aIM2lYnPP8FIWu+zDvqASWaNs3nHA8rqdu6dYwY3tR8oja8vTJpnj9wzwyJhYtJ7XDGhE0h5xuDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAHBlJatwdm8XRqEA--.40313S2;
	Sat, 30 Mar 2024 14:55:22 +0800 (CST)
Received: from phytium.com.cn (unknown [39.144.82.86])
	by mail (Coremail) with SMTP id AQAAfwA3ggFWtwdm+0MAAA--.219S3;
	Sat, 30 Mar 2024 14:55:20 +0800 (CST)
From: Zhang Yiqun <zhangyiqun@phytium.com.cn>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	corbet@lwn.net
Cc: keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Yiqun <zhangyiqun@phytium.com.cn>
Subject: [PATCH] KEYS: Add ECDH support
Date: Sat, 30 Mar 2024 14:55:06 +0800
Message-Id: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:AQAAfwA3ggFWtwdm+0MAAA--.219S3
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhangyiqun
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZFW5XF1xuF1UXw4DJF4rGrg_yoW8AF47Ao
	WxW3sxXw1vkryUWF4rGrykGrsxZa9akF45Ars3Xw4DZ3Wjva4UKw17J3y7Xa15WF4Skr1r
	Z392q34xtr4Dt39xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch is to introduce ECDH into keyctl syscall for
userspace usage, containing public key generation and
shared secret computation.

It is mainly based on dh code, so it has the same condition
to the input which only user keys is supported. The output
result is storing into the buffer with the provided length.

Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
---
 Documentation/security/keys/core.rst |  62 ++++++
 include/linux/compat.h               |   4 +
 include/uapi/linux/keyctl.h          |  11 +
 security/keys/Kconfig                |  12 +
 security/keys/Makefile               |   2 +
 security/keys/compat_ecdh.c          |  50 +++++
 security/keys/ecdh.c                 | 318 +++++++++++++++++++++++++++
 security/keys/internal.h             |  44 ++++
 security/keys/keyctl.c               |  10 +
 9 files changed, 513 insertions(+)
 create mode 100644 security/keys/compat_ecdh.c
 create mode 100644 security/keys/ecdh.c

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..9749466a3c95 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -884,6 +884,68 @@ The keyctl syscall functions are:
      and either the buffer length or the OtherInfo length exceeds the
      allowed length.
 
+  *  Compute a elliptic curve Diffie-Hellman shared secret::
+
+	long keyctl(KEYCTL_ECDH_COMPUTE, struct keyctl_ecdh_params *params,
+		    char *buffer, size_t buflen,
+		    struct keyctl_curve_params *curve);
+
+     The params struct contains serial numbers for two keys::
+
+	 - The local private key
+	 - The shared public key
+
+     The value computed is::
+
+	result = private EC-MUTIPLY public
+
+     The buffer length must be at least the length of the prime, or zero.
+
+     If the buffer length is nonzero, the length of the result is
+     returned when it is successfully calculated and copied in to the
+     buffer. When the buffer length is zero, the minimum required
+     buffer length is returned.
+
+     The curve parameter struct keyctl_curve_params is as follows:
+
+	 - ``char *curvename`` specifies the curve parameter used in
+	   the following computation.
+
+     This function will return error EOPNOTSUPP if the key type is not
+     supported, error ENOKEY if the key could not be found, or error
+     EACCES if the key is not readable by the caller.
+
+  *  Generate a elliptic curve Diffie-Hellman shared public key::
+
+	long keyctl(KEYCTL_ECDH_GENPUBKEY,
+		    struct keyctl_ecdh_params *params,
+		    char *buffer, size_t buflen,
+		    struct keyctl_curve_params *curve);
+
+     The params struct contains serial numbers for one keys::
+
+	 - The local private key
+
+     The value computed is::
+
+	result = private EC-MUTIPLY G
+
+     The buffer length must be at least the length of the prime, or zero.
+
+     If the buffer length is nonzero, the length of the result is
+     returned when it is successfully calculated and copied in to the
+     buffer. When the buffer length is zero, the minimum required
+     buffer length is returned.
+
+     The curve parameter struct keyctl_curve_params is as follows:
+
+	 - ``char *curvename`` specifies the curve parameter used in
+	   the following computation.
+
+     This function will return error EOPNOTSUPP if the key type is not
+     supported, error ENOKEY if the key could not be found, or error
+     EACCES if the key is not readable by the caller.
+
 
   *  Restrict keyring linkage::
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 233f61ec8afc..1f989ef5c9e1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -411,6 +411,10 @@ struct compat_keyctl_kdf_params {
 	__u32 __spare[8];
 };
 
+struct compat_keyctl_curve_params {
+	compat_uptr_t curvename;
+};
+
 struct compat_stat;
 struct compat_statfs;
 struct compat_statfs64;
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 4c8884eea808..77b5d9d837a2 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -70,6 +70,8 @@
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
 #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
 #define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes */
+#define KEYCTL_ECDH_COMPUTE		33	/* Compute EC Diffie-Hellman values */
+#define KEYCTL_ECDH_GENPUBKEY		34	/* Generate EC Diffie-Hellman public keys */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -90,6 +92,15 @@ struct keyctl_kdf_params {
 	__u32 __spare[8];
 };
 
+struct keyctl_ecdh_params {
+	__s32 priv;
+	__s32 pub;
+};
+
+struct keyctl_curve_params {
+	char __user *curvename;
+};
+
 #define KEYCTL_SUPPORTS_ENCRYPT		0x01
 #define KEYCTL_SUPPORTS_DECRYPT		0x02
 #define KEYCTL_SUPPORTS_SIGN		0x04
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index abb03a1b2a5c..b36be8d8d501 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -125,6 +125,18 @@ config KEY_DH_OPERATIONS
 
 	 If you are unsure as to whether this is required, answer N.
 
+config KEY_ECDH_OPERATIONS
+       bool "Elliptic Curve Diffie-Hellman operations on retained keys"
+       depends on KEYS
+       select CRYPTO
+       select CRYPTO_ECDH
+       help
+	 This option provides support for calculating Elliptic Curve
+	 Diffie-Hellman public keys and shared secrets using values
+	 stored as keys in the kernel.
+
+	 If you are unsure as to whether this is required, answer N.
+
 config KEY_NOTIFICATIONS
 	bool "Provide key/keyring change notifications"
 	depends on KEYS && WATCH_QUEUE
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..590fc4724f37 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -17,11 +17,13 @@ obj-y := \
 	request_key_auth.o \
 	user_defined.o
 compat-obj-$(CONFIG_KEY_DH_OPERATIONS) += compat_dh.o
+compat-obj-$(CONFIG_KEY_ECDH_OPERATIONS) += compat_ecdh.o
 obj-$(CONFIG_COMPAT) += compat.o $(compat-obj-y)
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSCTL) += sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
 obj-$(CONFIG_KEY_DH_OPERATIONS) += dh.o
+obj-$(CONFIG_KEY_ECDH_OPERATIONS) += ecdh.o
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 
 #
diff --git a/security/keys/compat_ecdh.c b/security/keys/compat_ecdh.c
new file mode 100644
index 000000000000..040d2a1c5548
--- /dev/null
+++ b/security/keys/compat_ecdh.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* 32-bit compatibility syscall for 64-bit systems for ECDH operations
+ *
+ * Copyright (C) 2024 Zhang Yiqun <zhangyiqun@phytium.com.cn>
+ */
+
+#include <linux/uaccess.h>
+
+#include "internal.h"
+
+/*
+ * Perform the ECDH computation or ECDH based key derivation.
+ *
+ * If successful, 0 will be returned.
+ */
+long compat_keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
+				char __user *buffer, size_t buflen,
+				struct compat_keyctl_curve_params __user *curve)
+{
+	struct keyctl_curve_params curvecopy;
+	struct compat_keyctl_curve_params compat_curvecopy;
+
+	if (!curve)
+		return -EINVAL;
+
+	if (copy_from_user(&compat_curvecopy, curve, sizeof(compat_curvecopy)) != 0)
+		return -EFAULT;
+
+	curvecopy.curvename = compat_ptr(compat_curvecopy.curvename);
+
+	return keyctl_ecdh_compute(params, buffer, buflen, &curvecopy);
+}
+
+long compat_keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *params,
+				  char __user *buffer, size_t buflen,
+				  struct compat_keyctl_curve_params __user *curve)
+{
+	struct keyctl_curve_params curvecopy;
+	struct compat_keyctl_curve_params compat_curvecopy;
+
+	if (!curve)
+		return -EINVAL;
+
+	if (copy_from_user(&compat_curvecopy, curve, sizeof(compat_curvecopy)) != 0)
+		return -EFAULT;
+
+	curvecopy.curvename = compat_ptr(compat_curvecopy.curvename);
+
+	return keyctl_ecdh_genpubkey(params, buffer, buflen, &curvecopy);
+}
diff --git a/security/keys/ecdh.c b/security/keys/ecdh.c
new file mode 100644
index 000000000000..5e5be22b920c
--- /dev/null
+++ b/security/keys/ecdh.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Crypto operations using stored keys
+ *
+ * Copyright (c) 2024 Zhang Yiqun <zhangyiqun@phytium.com.cn>
+ */
+
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/scatterlist.h>
+#include <linux/crypto.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+#include <crypto/ecdh.h>
+#include <keys/user-type.h>
+#include "internal.h"
+
+static ssize_t ecdh_data_from_key(key_serial_t keyid, char **data)
+{
+	struct key *key;
+	key_ref_t key_ref;
+	long status;
+	ssize_t ret;
+
+	key_ref = lookup_user_key(keyid, 0, KEY_NEED_READ);
+	if (IS_ERR(key_ref)) {
+		ret = -ENOKEY;
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	ret = -EOPNOTSUPP;
+	if (key->type == &key_type_user) {
+		down_read(&key->sem);
+		status = key_validate(key);
+		if (status == 0) {
+			const struct user_key_payload *payload;
+			uint8_t *duplicate;
+
+			payload = user_key_payload_locked(key);
+
+			duplicate = kmemdup(payload->data, payload->datalen,
+					    GFP_KERNEL);
+			if (duplicate) {
+				*data = duplicate;
+				ret = payload->datalen;
+			} else {
+				ret = -ENOMEM;
+			}
+		}
+		up_read(&key->sem);
+	}
+
+	key_put(key);
+error:
+	return ret;
+}
+
+static void ecdh_free_data(struct ecdh *ecdh)
+{
+	kfree_sensitive(ecdh->key);
+}
+
+long keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
+		       char __user *buffer, size_t buflen,
+		       struct keyctl_curve_params __user *curve)
+{
+	long ret;
+	ssize_t dlen;
+	int secretlen;
+	int outlen;
+	struct keyctl_ecdh_params pcopy;
+	struct ecdh ecdh_inputs;
+	struct scatterlist insg;
+	struct scatterlist outsg;
+	DECLARE_CRYPTO_WAIT(compl);
+	struct crypto_kpp *tfm;
+	struct kpp_request *req;
+	uint8_t *secret;
+	uint8_t *outbuf;
+	char *dhname;
+
+	if (!params || (!buffer && buflen) || !curve) {
+		ret = -EINVAL;
+		goto out1;
+	}
+
+	if (copy_from_user(&pcopy, params, sizeof(pcopy)) != 0) {
+		ret = -EFAULT;
+		goto out1;
+	}
+
+	memset(&ecdh_inputs, 0, sizeof(ecdh_inputs));
+
+	dlen = ecdh_data_from_key(pcopy.priv, &ecdh_inputs.key);
+	if (dlen < 0) {
+		ret = dlen;
+		goto out1;
+	}
+	ecdh_inputs.key_size = dlen;
+
+	secretlen = crypto_ecdh_key_len(&ecdh_inputs);
+	secret = kmalloc(secretlen, GFP_KERNEL);
+	if (!secret) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	ret = crypto_ecdh_encode_key(secret, secretlen, &ecdh_inputs);
+	if (ret)
+		goto out3;
+
+	dhname = strndup_user(curve->curvename, CRYPTO_MAX_ALG_NAME);
+
+	tfm = crypto_alloc_kpp(dhname, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out3;
+	}
+
+	kfree(dhname);
+
+	ret = crypto_kpp_set_secret(tfm, secret, secretlen);
+	if (ret)
+		goto out4;
+
+	outlen = crypto_kpp_maxsize(tfm);
+
+	if (buflen == 0) {
+		ret = outlen;
+		goto out4;
+	} else if (outlen > buflen) {
+		ret = -EOVERFLOW;
+		goto out4;
+	}
+
+	outbuf = kzalloc(outlen, GFP_KERNEL);
+	if (!outbuf) {
+		ret = -ENOMEM;
+		goto out4;
+	}
+
+	dlen = ecdh_data_from_key(pcopy.pub, (char **)&outbuf);
+	if (dlen != outlen) {
+		ret = dlen;
+		goto out5;
+	}
+
+	sg_init_one(&insg, outbuf, outlen);
+	sg_init_one(&outsg, outbuf, outlen/2);
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out5;
+	}
+
+	kpp_request_set_input(req, &insg, outlen);
+	kpp_request_set_output(req, &outsg, outlen/2);
+	init_completion(&compl.completion);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				 CRYPTO_TFM_REQ_MAY_SLEEP,
+				 crypto_req_done, &compl);
+
+	/*
+	 * For DH, generate_public_key and generate_shared_secret are
+	 * the same calculation
+	 */
+	ret = crypto_kpp_compute_shared_secret(req);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&compl.completion);
+		ret = compl.err;
+		if (ret)
+			goto out6;
+	}
+
+	if (copy_to_user(buffer, outbuf, req->dst_len) == 0)
+		ret = req->dst_len;
+	else
+		ret = -EFAULT;
+
+out6:
+	kpp_request_free(req);
+out5:
+	kfree_sensitive(outbuf);
+out4:
+	crypto_free_kpp(tfm);
+out3:
+	kfree_sensitive(secret);
+out2:
+	ecdh_free_data(&ecdh_inputs);
+out1:
+	return ret;
+}
+
+long keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *params,
+		       char __user *buffer, size_t buflen,
+		       struct keyctl_curve_params __user *curve)
+{
+	long ret;
+	ssize_t dlen;
+	int secretlen;
+	int outlen;
+	struct keyctl_ecdh_params pcopy;
+	struct ecdh ecdh_inputs;
+	struct scatterlist outsg;
+	DECLARE_CRYPTO_WAIT(compl);
+	struct crypto_kpp *tfm;
+	struct kpp_request *req;
+	uint8_t *secret;
+	uint8_t *outbuf;
+	char *dhname;
+
+	if (!params || (!buffer && buflen)) {
+		ret = -EINVAL;
+		goto out1;
+	}
+
+	if (copy_from_user(&pcopy, params, sizeof(pcopy)) != 0) {
+		ret = -EFAULT;
+		goto out1;
+	}
+
+	memset(&ecdh_inputs, 0, sizeof(ecdh_inputs));
+
+	dlen = ecdh_data_from_key(pcopy.priv, &ecdh_inputs.key);
+	if (dlen < 0) {
+		ret = dlen;
+		goto out1;
+	}
+	ecdh_inputs.key_size = dlen;
+
+	secretlen = crypto_ecdh_key_len(&ecdh_inputs);
+	secret = kmalloc(secretlen, GFP_KERNEL);
+	if (!secret) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	ret = crypto_ecdh_encode_key(secret, secretlen, &ecdh_inputs);
+	if (ret)
+		goto out3;
+
+	dhname = strndup_user(curve->curvename, CRYPTO_MAX_ALG_NAME);
+
+	tfm = crypto_alloc_kpp(dhname, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out3;
+	}
+
+	kfree(dhname);
+
+	ret = crypto_kpp_set_secret(tfm, secret, secretlen);
+	if (ret)
+		goto out4;
+
+	outlen = crypto_kpp_maxsize(tfm);
+
+	if (buflen == 0) {
+		ret = outlen;
+		goto out4;
+	} else if (outlen > buflen) {
+		ret = -EOVERFLOW;
+		goto out4;
+	}
+
+	outbuf = kzalloc(outlen, GFP_KERNEL);
+	if (!outbuf) {
+		ret = -ENOMEM;
+		goto out4;
+	}
+
+	sg_init_one(&outsg, outbuf, outlen);
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out5;
+	}
+
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, &outsg, outlen);
+	init_completion(&compl.completion);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				 CRYPTO_TFM_REQ_MAY_SLEEP,
+				 crypto_req_done, &compl);
+
+	/*
+	 * For DH, generate_public_key and generate_shared_secret are
+	 * the same calculation
+	 */
+	ret = crypto_kpp_generate_public_key(req);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&compl.completion);
+		ret = compl.err;
+		if (ret)
+			goto out6;
+	}
+
+	if (copy_to_user(buffer, outbuf, req->dst_len) == 0)
+		ret = req->dst_len;
+	else
+		ret = -EFAULT;
+
+out6:
+	kpp_request_free(req);
+out5:
+	kfree_sensitive(outbuf);
+out4:
+	crypto_free_kpp(tfm);
+out3:
+	kfree_sensitive(secret);
+out2:
+	ecdh_free_data(&ecdh_inputs);
+out1:
+	return ret;
+}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 2cffa6dc8255..165523e29b52 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -306,6 +306,50 @@ static inline long compat_keyctl_dh_compute(
 #endif
 #endif
 
+#ifdef CONFIG_KEY_ECDH_OPERATIONS
+extern long keyctl_ecdh_compute(struct keyctl_ecdh_params __user *param,
+			      char __user *buffer, size_t buflen,
+			      struct keyctl_curve_params __user *curve);
+extern long keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *param,
+			      char __user *buffer, size_t buflen,
+			      struct keyctl_curve_params __user *curve);
+#ifdef CONFIG_COMPAT
+extern long compat_keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
+				char __user *buffer, size_t buflen,
+				struct compat_keyctl_curve_params __user *curve);
+extern long compat_keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *params,
+				char __user *buffer, size_t buflen,
+				struct compat_keyctl_curve_params __user *curve);
+#endif
+#else
+static inline long keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
+				     char __user *buffer, size_t buflen,
+				     struct keyctl_curve_params __user *kdf)
+{
+	return -EOPNOTSUPP;
+}
+static inline long keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *params,
+				     char __user *buffer, size_t buflen,
+				     struct keyctl_curve_params __user *kdf)
+{
+	return -EOPNOTSUPP;
+}
+#ifdef CONFIG_COMPAT
+long compat_keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
+				char __user *buffer, size_t buflen,
+				struct compat_keyctl_curve_params __user *curve)
+{
+	return -EOPNOTSUPP;
+}
+long compat_keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *params,
+				char __user *buffer, size_t buflen,
+				struct compat_keyctl_curve_params __user *curve)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif
+
 #ifdef CONFIG_ASYMMETRIC_KEY_TYPE
 extern long keyctl_pkey_query(key_serial_t,
 			      const char __user *,
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10ba439968f7..e690c130386a 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -2019,6 +2019,16 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case KEYCTL_WATCH_KEY:
 		return keyctl_watch_key((key_serial_t)arg2, (int)arg3, (int)arg4);
 
+	case KEYCTL_ECDH_COMPUTE:
+		return keyctl_ecdh_compute((struct keyctl_ecdh_params __user *) arg2,
+					 (char __user *) arg3, (size_t) arg4,
+					 (struct keyctl_curve_params __user *) arg5);
+
+	case KEYCTL_ECDH_GENPUBKEY:
+		return keyctl_ecdh_genpubkey((struct keyctl_ecdh_params __user *) arg2,
+					 (char __user *) arg3, (size_t) arg4,
+					 (struct keyctl_curve_params __user *) arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.17.1


