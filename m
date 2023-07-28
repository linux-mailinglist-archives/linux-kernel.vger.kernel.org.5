Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD20976765F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjG1TbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjG1TbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:31:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1162D5D;
        Fri, 28 Jul 2023 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690572659; x=1722108659;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGaMlBipNmPfGhHLAGsqi0OkKPmtkBtlrURLdYIcgyI=;
  b=SsAtewQNkZTLC6BNFnMjtP+oG0dOXfVgcpMbt1f0Xiqe5PiyX9aKJx9C
   W8A0Vcm2OGT6/5tXZ+W2ZJZNkorBHulpWH21N/juniDomxpVx0G/hGVpA
   jTz0dvK6Y4imeUUqzJloENqW/GpDzfn4fkK2Nmj+3O8iaFGE1W4ACHlN1
   ulP4bMcWpOc7HLO4tamX3gdhPNpuLYEWZG3KrduR5JqSnemvK1367dY+M
   Wx8SSgdpJjx8amlZIkdsLnitUAVxvTmYSKcVp8vWbkz+rMkuUwMZAoGiq
   UKtqXIqQPvITyanL29Kmtbou0VfvtgT+hx/LkLqWXSwdohvjomuFGaipC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348958854"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348958854"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="797529634"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="797529634"
Received: from cheehong-laptop.gar.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.158.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:30:58 -0700
Subject: [PATCH 1/4] keys: Introduce tsm keys
From:   Dan Williams <dan.j.williams@intel.com>
To:     dhowells@redhat.com
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:30:58 -0700
Message-ID: <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the common operations of a TSM (Trusted Security Module) is to
provide a way for a TVM (confidential computing guest execution
environment) to take a measurement of its run state and use that with a
key-exchange protocol to establish a shared secret with a third-party /
remote attestation agent. The concept is common across TSMs, but the
implementations are unfortunately vendor specific. While the industry
grapples with a common definition of this attestation format [1], Linux
need not make this problem worse by defining a new ABI per TSM that
wants to perform a similar operation. The current momentum has been to
invent new ioctl-ABI per TSM per function which at best is an abdication
of the kernel's responsibility to make common infrastructure concepts
share common ABI.

The proposal, targeted to conceptually work with TDX, SEV, COVE if not
more, is to define a new key type that produces a TSM common blob format
and moves the vendor specificity inside that envelope. The common Linux
definition is:

    "<hex encoded pubkey> <blob descriptor> <hex encoded attestation blob>"

This approach later allows for the standardization of the attestation
blob format without needing to change the Linux ABI. TSM specific
options are encoded in the frontend request format where the options
like SEV:vmpl (privilege level) can be specified and TSMs that do not
support them can decide to ignore them or fail if they are specified.
For now, "privlevel=" and "format=" are the only implemented options.

Example of establishing a tsm key and dumping the provider-specific
report:

    dd if=/dev/urandom of=pubkey bs=1 count=64
    keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u
    keyctl print 280877394 | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump -C

Now, this patch ends up being a fairly simple custom-key format because
most of the follow-on work that happens after publishing a TSM-wrapped
public-key is performed by userspace. The TSM key is just one step in
establishing a shared secret that can be used to unlock other keys. For
example a user-key could be populated with the resulting shared secret
and that could be used as a master-key for an encrypted-key
(security/keys/encrypted-keys/encrypted.c).

While the discussion that led to this proposal hinted at a new
trusted-key (security/keys/trusted-keys/trusted_core.c) type rooted in
the TSM [2], more work is needed to fetch a secret from the TSM
directly. The trusted-key core expects a pre-established secure channel
to seal and unseal secrets locally. For that reason a "tsm" flavor
trusted-key is saved for follow on work. That will likely starting as a
wrapper around SNP_GET_DERIVED_KEY.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Link: http://lore.kernel.org/r/CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuEkpnehB5U7D_yw@mail.gmail.com [2]
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/keys/tsm.h     |   71 ++++++++++++
 security/keys/Kconfig  |   12 ++
 security/keys/Makefile |    1 
 security/keys/tsm.c    |  282 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 include/keys/tsm.h
 create mode 100644 security/keys/tsm.c

diff --git a/include/keys/tsm.h b/include/keys/tsm.h
new file mode 100644
index 000000000000..61a81017d8f5
--- /dev/null
+++ b/include/keys/tsm.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TSM_H
+#define __TSM_H
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+/*
+ * @TSM_DATA_MAX: a reasonable max with enough space for known attestation
+ * report formats. This mirrors the trusted/encrypted key blob max size.
+ */
+#define TSM_DATA_MAX 32767
+#define TSM_PUBKEY_MAX 64
+#define TSM_FORMAT_MAX 16
+
+/**
+ * DOC: TSM Keys
+ *
+ * Trusted Security Module Keys are a common provider of blobs that
+ * facilitate key-exchange between a TVM (confidential computing guest)
+ * and an attestation service. A TSM key combines a user-defined blob
+ * (likely a public-key for a key-exchance protocol) with a signed
+ * attestation report. That combined blob is then used to obtain
+ * secrets provided by an agent that can validate the attestation
+ * report.
+ *
+ * A full implementation uses a tsm key to, for example, establish a
+ * shared secret and then use that communication channel to instantiate
+ * other keys. The expectation is that the requester of the tsm key
+ * knows a priori the key-exchange protocol associated with the
+ * 'pubkey'.
+ *
+ * The attestation report format is TSM provider specific, when / if a
+ * standard materializes it is only a change to the auth_blob_desc
+ * member of 'struct tsm_key_payload', to convey that common format.
+ */
+
+/**
+ * struct tsm_key_payload - generic payload for vendor TSM blobs
+ * @privlevel: optional privilege level to associate with @pubkey
+ * @pubkey_len: how much of @pubkey is valid
+ * @pubkey: the public key-exchange blob to include in the attestation report
+ * @auth_blob_desc: base ascii descriptor of @auth_blob
+ * @auth_blob_format: for TSMs with multiple formats, extend @auth_blob_desc
+ * @auth_blob_len: TSM provider length of the array it publishes in @auth_blob
+ * @auth_blob: TSM specific attestation report blob
+ */
+struct tsm_key_payload {
+	int privlevel;
+	size_t pubkey_len;
+	u8 pubkey[TSM_PUBKEY_MAX];
+	const char *auth_blob_desc;
+	char auth_blob_format[TSM_FORMAT_MAX];
+	size_t auth_blob_len;
+	u8 *auth_blob;
+};
+
+/*
+ * arch specific ops, only one is expected to be registered at a time
+ * i.e. only one of SEV, TDX, COVE, etc.
+ */
+struct tsm_key_ops {
+	const char *name;
+	struct module *module;
+	int (*auth_new)(struct tsm_key_payload *t, void *provider_data);
+};
+
+int register_tsm_provider(const struct tsm_key_ops *ops, void *provider_data);
+void unregister_tsm_provider(const struct tsm_key_ops *ops);
+
+#endif /* __TSM_H */
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index abb03a1b2a5c..f530cbd876fc 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -133,3 +133,15 @@ config KEY_NOTIFICATIONS
 	  on keys and keyrings on which the caller has View permission.
 	  This makes use of pipes to handle the notification buffer and
 	  provides KEYCTL_WATCH_KEY to enable/disable watches.
+
+config TSM_KEYS
+	tristate "TSM-based (Confidential Computing) keys"
+	help
+	  TSM (Trusted Security Module) key support arranges to convey a blob to
+	  a confidentiality and integrity protected virtual machine / guest
+	  (TVM). The blob instantiation flow involves submitting the measurement
+	  report of a TVM, obtained from the platform TSM, to a remote
+	  attestation service that only provides the key if the report passes
+	  validation. The report format is vendor specific and the validation is
+	  user policy, so this feature requires a /etc/request-key.conf handler
+	  for communicating with the remote attestation provider.
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..96972a4815d5 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 # Key types
 #
 obj-$(CONFIG_BIG_KEYS) += big_key.o
+obj-$(CONFIG_TSM_KEYS) += tsm.o
 obj-$(CONFIG_TRUSTED_KEYS) += trusted-keys/
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
diff --git a/security/keys/tsm.c b/security/keys/tsm.c
new file mode 100644
index 000000000000..d9532319f819
--- /dev/null
+++ b/security/keys/tsm.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/err.h>
+#include <linux/uuid.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/parser.h>
+#include <linux/cleanup.h>
+#include <linux/key-type.h>
+
+#include <keys/tsm.h>
+#include <keys/user-type.h>
+
+static struct tsm_provider {
+	const struct tsm_key_ops *ops;
+	void *data;
+} provider;
+static DECLARE_RWSEM(tsm_key_rwsem);
+
+static const struct tsm_key_ops *get_ops(void)
+{
+	down_read(&tsm_key_rwsem);
+	return provider.ops;
+}
+
+static void *get_data(void)
+{
+	lockdep_assert_held(&tsm_key_rwsem);
+	return provider.data;
+}
+
+static void put_ops(void)
+{
+	up_read(&tsm_key_rwsem);
+}
+
+int register_tsm_provider(const struct tsm_key_ops *ops,
+			  void *provider_data)
+{
+	const struct tsm_key_ops *conflict;
+	int rc;
+
+	down_write(&tsm_key_rwsem);
+	conflict = provider.ops;
+	if (conflict) {
+		pr_err("\"%s\" ops already registered\n", conflict->name);
+		rc = -EEXIST;
+		goto out;
+	}
+	try_module_get(ops->module);
+	provider.ops = ops;
+	provider.data = provider_data;
+	rc = 0;
+out:
+	up_write(&tsm_key_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(register_tsm_provider);
+
+void unregister_tsm_provider(const struct tsm_key_ops *ops)
+{
+	down_write(&tsm_key_rwsem);
+	provider.ops = NULL;
+	provider.data = NULL;
+	module_put(ops->module);
+	up_write(&tsm_key_rwsem);
+}
+EXPORT_SYMBOL_GPL(unregister_tsm_provider);
+
+enum {
+	Opt_err,
+	Opt_auth,
+	Opt_format,
+	Opt_privlevel,
+};
+
+static const match_table_t tsm_tokens = {
+	{ Opt_auth, "auth" },
+	{ Opt_privlevel, "privlevel=%s" },
+	{ Opt_format, "format=%s" },
+	{ Opt_err, NULL },
+};
+
+/*
+ * tsm_parse - parse the tsm request data
+ *
+ * input format: "auth <hex pubkey data> [options]"
+ *
+ * Checks for options and parses a hex blob of data to be wrapped by the
+ * TSM attestation format.
+ *
+ * options:
+ *     privlevel= integer for selecting the privelege level of the
+ *                request, if the platform TSM supports that concept. To
+ *                date only SEV accepts this option. Default 0.
+ *     format=    string modifier for the format, if the platform TSM
+ *                supports multiple formats. To date only SEV accepts an
+ *                "extended" argument. Default "".
+ *
+ * On success returns 0, otherwise -EINVAL.
+ */
+static int tsm_parse(char *input, struct tsm_key_payload *t)
+{
+	substring_t args[MAX_OPT_ARGS];
+	unsigned long optmask = 0;
+	unsigned int privlevel;
+	int token, rc;
+	char *p;
+
+	/* all tsm keys must start with "auth" as a placeholder command */
+	p = strsep(&input, " \t");
+	if (!p)
+		return -EINVAL;
+	token = match_token(p, tsm_tokens, args);
+	switch (token) {
+	case Opt_auth:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* next is the pubkey hex blob */
+	p = strsep(&input, " \t");
+	if (!p)
+		return -EINVAL;
+	t->pubkey_len = strlen(p) / 2;
+	if (t->pubkey_len > TSM_PUBKEY_MAX)
+		return -EINVAL;
+	rc = hex2bin(t->pubkey, p, t->pubkey_len);
+	if (rc < 0)
+		return -EINVAL;
+
+	/* last is zero or more options */
+	while ((p = strsep(&input, " \t"))) {
+		if (*p == '\0' || *p == ' ' || *p == '\t')
+			continue;
+		token = match_token(p, tsm_tokens, args);
+		/* each option can appear only once */
+		if (test_and_set_bit(token, &optmask))
+			return -EINVAL;
+		switch (token) {
+		case Opt_privlevel:
+			rc = kstrtouint(args[0].from, 16, &privlevel);
+			if (rc)
+				return rc;
+			t->privlevel = privlevel;
+			break;
+		case Opt_format:
+			if (strlen(args[0].from) >= TSM_FORMAT_MAX)
+				return -EINVAL;
+			strscpy(t->auth_blob_format, args[0].from,
+				TSM_FORMAT_MAX);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int tsm_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	size_t datalen = prep->datalen;
+	const struct tsm_key_ops *ops;
+	int rc;
+
+	if (datalen <= 0 || datalen > TSM_DATA_MAX || !prep->data)
+		return -EINVAL;
+
+	char *datablob __free(kfree) =
+		kmemdup_nul(prep->data, datalen, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+
+	struct tsm_key_payload *t __free(kfree) =
+		kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	rc = tsm_parse(datablob, t);
+	if (rc < 0)
+		return rc;
+
+	ops = get_ops();
+	if (ops)
+		rc = ops->auth_new(t, get_data());
+	else
+		rc = -ENXIO;
+	put_ops();
+
+	if (rc)
+		return rc;
+
+	rc = key_payload_reserve(key, sizeof(*t) + t->auth_blob_len);
+	if (rc) {
+		kvfree(t->auth_blob);
+		return rc;
+	}
+
+	rcu_assign_keypointer(key, t);
+	no_free_ptr(t);
+	return 0;
+}
+
+/*
+ * tsm_read - format and copy out the tsm auth record
+ *
+ * The resulting datablob format is:
+ * <pubkey blob> <auth blob desc[:format]> <auth blob>
+ *
+ * On success, return to userspace the size of the formatted payload.
+ */
+static long tsm_read(const struct key *key, char *buffer, size_t buflen)
+{
+	size_t asciiblob_len, desc_len;
+	struct tsm_key_payload *t;
+	char *buf, *format = NULL;
+	const int nr_spaces = 2;
+
+	t = dereference_key_locked(key);
+
+	desc_len = strlen(t->auth_blob_desc);
+	if (t->auth_blob_format[0]) {
+		format = &t->auth_blob_format[0];
+		desc_len += strlen(format) + 1;
+	}
+
+	asciiblob_len =
+		t->pubkey_len * 2 + desc_len + t->auth_blob_len * 2 + nr_spaces;
+
+	if (!buffer || buflen < asciiblob_len)
+		return asciiblob_len;
+
+	buf = bin2hex(buffer, t->pubkey, t->pubkey_len);
+	if (format)
+		buf += sprintf(buf, " %s:%s ", t->auth_blob_desc, format);
+	else
+		buf += sprintf(buf, " %s ", t->auth_blob_desc);
+	buf = bin2hex(buf, t->auth_blob, t->auth_blob_len);
+
+	/* sanity check for future changes to this function */
+	WARN_ON_ONCE(buf - buffer != asciiblob_len);
+
+	return asciiblob_len;
+}
+
+static void tsm_destroy(struct key *key)
+{
+	struct tsm_key_payload *t = key->payload.data[0];
+
+	kvfree(t->auth_blob);
+	kfree(t);
+}
+
+static struct key_type key_type_tsm = {
+	.name = "tsm",
+	.instantiate = tsm_instantiate,
+	.destroy = tsm_destroy,
+	.describe = user_describe,
+	.read = tsm_read,
+};
+
+static int __init tsm_key_init(void)
+{
+	return register_key_type(&key_type_tsm);
+}
+module_init(tsm_key_init);
+
+static void __exit tsm_key_exit(void)
+{
+	unregister_key_type(&key_type_tsm);
+}
+module_exit(tsm_key_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports as Key payloads");

