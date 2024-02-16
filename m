Return-Path: <linux-kernel+bounces-68876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A02858132
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983A9281778
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F0135A7F;
	Fri, 16 Feb 2024 15:26:53 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE2135A72;
	Fri, 16 Feb 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097212; cv=none; b=qx0ACPNA2ZODnr42qRjLcOBqlRC5M/++L96EqKfKtl4trrb2P5YMTGIS/NZlfdqhMPa2nOf3c1qBdEKeLFav+QEAGYl2zfiVR7fA254p/anLbu3s7KlLykX5EE+ru1MZMjN3mxc3EeU3ZzD4cb1nAi5vzjCupMp8pPs4JSBhYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097212; c=relaxed/simple;
	bh=vX8bdfkhJXIidlLH/j/4oK9ZgQH2R8GvtkPECNYgHJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZ2cZHlwLf1IXywbXNYyRfjm3ks/IG+28bePnnCyIe2DsAzThxdTsp+LKUaJyYtNh/6oXhIZOmsQ5TeJ7djUepvnbO+HgDYTN6ZSyF4J/Sya0CUTteO0CI1lUS+KBOamsstdVU/EYjG8d0cNElc2KIQ8QuxvKuRulR2fHr5i/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TbwPX4pSqz9ybvJ;
	Fri, 16 Feb 2024 23:11:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A816D140631;
	Fri, 16 Feb 2024 23:26:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S8;
	Fri, 16 Feb 2024 16:26:46 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	David Howells <dhowells@redhat.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [RFC 6/8] KEYS: PGP data parser
Date: Fri, 16 Feb 2024 16:24:33 +0100
Message-Id: <20240216152435.1575-7-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216152435.1575-1-petrtesarik@huaweicloud.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S8
X-Coremail-Antispam: 1UD129KBjvAXoW3KrW7XryfCry3AF1xJFy8Grg_yoW8GrW7Wo
	Z7Wr4rJw4rWr47Ca1rWr1fu39Iv3WrCa4rZws5WanrZ3WvvFyUKan8Ca18X3y3tr10kw15
	Zw1Iqa43Xa4Utry5n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOa7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
	6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: David Howells <dhowells@redhat.com>

Implement a PGP data parser for the crypto key type to use when
instantiating a key.

This parser attempts to parse the instantiation data as a PGP packet
sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
algorithm key or subkey from it.

If it finds such a key, it will set up a public_key subtype payload with
appropriate handler routines (RSA) and attach it to the key.

Thanks to Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> for pointing
out some errors.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig          |  11 +
 crypto/asymmetric_keys/Makefile         |   4 +
 crypto/asymmetric_keys/pgp_parser.h     |  18 +
 crypto/asymmetric_keys/pgp_public_key.c | 416 ++++++++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_parser.h
 create mode 100644 crypto/asymmetric_keys/pgp_public_key.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index ebe9dc88d975..ebde5ef5d65f 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -92,4 +92,15 @@ config PGP_LIBRARY
 	  This option enables a library that provides a number of simple
 	  utility functions for parsing PGP (RFC 4880) packet-based messages.
 
+config PGP_KEY_PARSER
+	tristate "PGP key parser"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select PGP_LIBRARY
+	select MD5 # V3 fingerprint generation
+	select SHA1 # V4 fingerprint generation
+	help
+	  This option provides support for parsing PGP (RFC 4880) format blobs
+	  for key data and provides the ability to instantiate a crypto key
+	  from a public key packet found inside the blob.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index f7e5ee59857f..36a27cf2daff 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -93,3 +93,7 @@ $(obj)/tpm.asn1.o: $(obj)/tpm.asn1.c $(obj)/tpm.asn1.h
 # PGP handling
 #
 obj-$(CONFIG_PGP_LIBRARY) += pgp_library.o
+
+obj-$(CONFIG_PGP_KEY_PARSER) += pgp_key_parser.o
+pgp_key_parser-y := \
+	pgp_public_key.o
diff --git a/crypto/asymmetric_keys/pgp_parser.h b/crypto/asymmetric_keys/pgp_parser.h
new file mode 100644
index 000000000000..1a560ce32415
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_parser.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP crypto data parser internal definitions
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "pgplib.h"
+
+#define kenter(FMT, ...) \
+	pr_devel("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_devel("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
+
+/*
+ * pgp_public_key.c
+ */
+extern const char *pgp_to_public_key_algo[PGP_PUBKEY__LAST];
diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
new file mode 100644
index 000000000000..0529c8ce2d43
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Instantiate a public key crypto key from PGP format data [RFC 4880]
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "PGP: "fmt
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mpi.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/hash.h>
+#include <crypto/public_key.h>
+
+#include "pgp_parser.h"
+
+#define MAX_MPI 5
+#define KEYCTL_SUPPORTS_ENCDEC \
+	(KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_DECRYPT)
+#define KEYCTL_SUPPORTS_SIGVER (KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY)
+
+MODULE_LICENSE("GPL");
+
+const char *pgp_to_public_key_algo[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= "rsa",
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= "rsa",
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= "rsa",
+	[PGP_PUBKEY_ELGAMAL]		= NULL,
+	[PGP_PUBKEY_DSA]		= NULL,
+};
+
+static const int pgp_key_algo_p_num_mpi[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= 2,
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= 2,
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= 2,
+	[PGP_PUBKEY_ELGAMAL]		= 3,
+	[PGP_PUBKEY_DSA]		= 4,
+};
+
+static const u8 pgp_public_key_capabilities[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= KEYCTL_SUPPORTS_ENCDEC |
+					  KEYCTL_SUPPORTS_SIGVER,
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= KEYCTL_SUPPORTS_ENCDEC,
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= KEYCTL_SUPPORTS_SIGVER,
+	[PGP_PUBKEY_ELGAMAL]		= 0,
+	[PGP_PUBKEY_DSA]		= 0,
+};
+
+struct pgp_key_data_parse_context {
+	struct pgp_parse_context pgp;
+	u8 key[1024];
+	size_t keylen;
+	u8 keyid_buf[1024];
+	size_t keyid_buf_len;
+	char user_id[512];
+	size_t user_id_len;
+	const char *algo;
+	u8 raw_fingerprint[HASH_MAX_DIGESTSIZE];
+	size_t raw_fingerprint_len;
+	unsigned int version;
+};
+
+static inline void write_keyid_buf_char(struct pgp_key_data_parse_context *ctx,
+					uint8_t ch)
+{
+	memcpy(&ctx->keyid_buf[ctx->keyid_buf_len++], &ch, 1);
+}
+
+/*
+ * Build buffer to calculate the public key ID (RFC4880 12.2)
+ */
+static int pgp_build_pkey_keyid_buf(struct pgp_key_data_parse_context *ctx,
+				    struct pgp_parse_pubkey *pgp)
+{
+	unsigned int nb[MAX_MPI];
+	unsigned int nn[MAX_MPI];
+	unsigned int n;
+	size_t keylen = ctx->keylen;
+	u8 *key_ptr = ctx->key;
+	u8 *pp[MAX_MPI];
+	u32 a32;
+	int npkey = pgp_key_algo_p_num_mpi[pgp->pubkey_algo];
+	int i, ret;
+
+	kenter("");
+
+	n = (pgp->version < PGP_KEY_VERSION_4) ? 8 : 6;
+	for (i = 0; i < npkey; i++) {
+		ret = mpi_key_length(key_ptr, keylen, nb + i, nn + i);
+		if (ret < 0) {
+			kleave(" = %d", ret);
+			return ret;
+		}
+
+		if (keylen < 2 + nn[i])
+			break;
+
+		pp[i] = key_ptr + 2;
+		key_ptr += 2 + nn[i];
+		keylen -= 2 + nn[i];
+		n += 2 + nn[i];
+	}
+
+	if (keylen != 0) {
+		pr_debug("excess %zu\n", keylen);
+		kleave(" = -EBADMSG");
+		return -EBADMSG;
+	}
+
+	write_keyid_buf_char(ctx, 0x99);	/* ctb */
+	write_keyid_buf_char(ctx, n >> 8);	/* 16-bit header length */
+	write_keyid_buf_char(ctx, n);
+
+	write_keyid_buf_char(ctx, pgp->version);
+
+	a32 = pgp->creation_time;
+	write_keyid_buf_char(ctx, a32 >> 24);
+	write_keyid_buf_char(ctx, a32 >> 16);
+	write_keyid_buf_char(ctx, a32 >> 8);
+	write_keyid_buf_char(ctx, a32 >> 0);
+
+	if (pgp->version < PGP_KEY_VERSION_4) {
+		u16 a16;
+
+		if (pgp->expires_at)
+			a16 = (pgp->expires_at - pgp->creation_time) / 86400UL;
+		else
+			a16 = 0;
+		write_keyid_buf_char(ctx, a16 >> 8);
+		write_keyid_buf_char(ctx, a16 >> 0);
+	}
+
+	write_keyid_buf_char(ctx, pgp->pubkey_algo);
+
+	for (i = 0; i < npkey; i++) {
+		write_keyid_buf_char(ctx, nb[i] >> 8);
+		write_keyid_buf_char(ctx, nb[i]);
+		memcpy(&ctx->keyid_buf[ctx->keyid_buf_len], pp[i], nn[i]);
+		ctx->keyid_buf_len += nn[i];
+	}
+
+	kleave(" = 0");
+	return 0;
+}
+
+/*
+ * Extract a public key or public subkey from the PGP stream.
+ */
+static int pgp_process_public_key(struct pgp_parse_context *context,
+				  enum pgp_packet_tag type,
+				  u8 headerlen,
+				  const u8 *data,
+				  size_t datalen)
+{
+	struct pgp_key_data_parse_context *ctx =
+		container_of(context, struct pgp_key_data_parse_context, pgp);
+	struct pgp_parse_pubkey pgp;
+	u8 capabilities;
+	int ret;
+
+	kenter(",%u,%u,,%zu", type, headerlen, datalen);
+
+	if (type == PGP_PKT_USER_ID) {
+		if (!ctx->user_id_len) {
+			if (ctx->user_id_len > sizeof(ctx->user_id)) {
+				kleave(" = -E2BIG");
+				return -E2BIG;
+			}
+
+			memcpy(ctx->user_id, data, datalen);
+			ctx->user_id_len = datalen;
+		}
+		kleave(" = 0 [user ID]");
+		return 0;
+	}
+
+	if (ctx->keyid_buf_len) {
+		kleave(" = -EBADMSG");
+		return -EBADMSG;
+	}
+
+	ret = pgp_parse_public_key(&data, &datalen, &pgp);
+	if (ret < 0) {
+		kleave(" = %d", ret);
+		return ret;
+	}
+
+	ctx->version = pgp.version;
+
+	if (pgp.pubkey_algo < PGP_PUBKEY__LAST)
+		ctx->algo = pgp_to_public_key_algo[pgp.pubkey_algo];
+
+	if (!ctx->algo) {
+		pr_debug("Unsupported public key algorithm %u\n",
+			 pgp.pubkey_algo);
+		kleave(" = -ENOPKG");
+		return -ENOPKG;
+	}
+
+	/*
+	 * It's the public half of a key, so that only gives us encrypt and
+	 * verify capabilities.
+	 */
+	capabilities = pgp_public_key_capabilities[pgp.pubkey_algo] &
+		       (KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_VERIFY);
+	/*
+	 * Capabilities are not stored anymore in the public key, store only
+	 * those that allow signature verification.
+	 */
+	if (!(capabilities & KEYCTL_SUPPORTS_VERIFY)) {
+		pr_debug("Public key cannot be used for verification\n");
+		kleave(" = -ENOPKG");
+		return -ENOPKG;
+	}
+
+	if (datalen > sizeof(ctx->key)) {
+		kleave(" = -E2BIG");
+		return -E2BIG;
+	}
+
+	memcpy(ctx->key, data, datalen);
+	ctx->keylen = datalen;
+
+	ret = pgp_build_pkey_keyid_buf(ctx, &pgp);
+
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Calculate the public key ID fingerprint
+ */
+static int pgp_generate_fingerprint(struct pgp_key_data_parse_context *ctx)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *digest;
+	char fingerprint[HASH_MAX_DIGESTSIZE * 2 + 1] = { 0 };
+	size_t offset;
+	int ret;
+
+	ret = -ENOMEM;
+	tfm = crypto_alloc_shash(ctx->version < PGP_KEY_VERSION_4 ?
+				 "md5" : "sha1", 0, 0);
+	if (!tfm)
+		goto cleanup;
+
+	digest = kmalloc(sizeof(*digest) + crypto_shash_descsize(tfm),
+			 GFP_KERNEL);
+	if (!digest)
+		goto cleanup_tfm;
+
+	digest->tfm = tfm;
+	crypto_shash_set_flags(digest->tfm, CRYPTO_TFM_REQ_MAY_SLEEP);
+	ret = crypto_shash_init(digest);
+	if (ret < 0)
+		goto cleanup_hash;
+
+	crypto_shash_update(digest, ctx->keyid_buf, ctx->keyid_buf_len);
+
+	ctx->raw_fingerprint_len = crypto_shash_digestsize(tfm);
+
+	ret = crypto_shash_final(digest, ctx->raw_fingerprint);
+	if (ret < 0)
+		goto cleanup_hash;
+
+	offset = ctx->raw_fingerprint_len - 8;
+	pr_debug("offset %lu/%lu\n", offset, ctx->raw_fingerprint_len);
+
+	bin2hex(fingerprint, ctx->raw_fingerprint, ctx->raw_fingerprint_len);
+	pr_debug("fingerprint %s\n", fingerprint);
+
+	ret = 0;
+cleanup_hash:
+	kfree(digest);
+cleanup_tfm:
+	crypto_free_shash(tfm);
+cleanup:
+	return ret;
+}
+
+static struct asymmetric_key_ids *pgp_key_generate_id(
+					struct pgp_key_data_parse_context *ctx)
+{
+	struct asymmetric_key_ids *kids;
+	struct asymmetric_key_id *kid;
+
+	kids = kzalloc(sizeof(struct asymmetric_key_ids), GFP_KERNEL);
+	if (!kids)
+		return kids;
+
+	kid = asymmetric_key_generate_id(ctx->raw_fingerprint,
+					 ctx->raw_fingerprint_len, NULL, 0);
+	if (IS_ERR(kid))
+		goto error;
+
+	kids->id[0] = kid;
+	kids->id[1] = kmemdup(kid, sizeof(*kid) + ctx->raw_fingerprint_len,
+			      GFP_KERNEL);
+	if (!kids->id[1])
+		goto error;
+
+	return kids;
+error:
+	kfree(kids->id[0]);
+	kfree(kids);
+
+	return NULL;
+}
+
+/*
+ * Attempt to parse the instantiation data blob for a key as a PGP packet
+ * message holding a key.
+ */
+static int pgp_key_parse(struct key_preparsed_payload *prep)
+{
+	struct pgp_key_data_parse_context *ctx;
+	struct public_key *pub = NULL;
+	int ret;
+
+	kenter("");
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		kleave(" = -ENOMEM");
+		return -ENOMEM;
+	}
+
+	ctx->pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY) |
+				     (1 << PGP_PKT_USER_ID);
+	ctx->pgp.process_packet = pgp_process_public_key;
+
+	ret = pgp_parse_packets(prep->data, prep->datalen, &ctx->pgp);
+	if (ret < 0)
+		goto error;
+
+	ret = pgp_generate_fingerprint(ctx);
+	if (ret < 0)
+		goto error;
+
+	pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
+	if (!pub) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	pub->key = kmemdup(ctx->key, ctx->keylen, GFP_KERNEL);
+	if (!pub->key) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	pub->keylen = ctx->keylen;
+	pub->id_type = "PGP";
+	pub->pkey_algo = ctx->algo;
+
+	if (ctx->user_id && ctx->user_id_len > 0) {
+		/*
+		 * Propose a description for the key (user ID without the
+		 * comment).
+		 */
+		size_t ulen = ctx->user_id_len;
+
+		if (ulen > 255 - 9)
+			ulen = 255 - 9;
+		prep->description = kmalloc(ulen + 1 + 8 + 1, GFP_KERNEL);
+		ret = -ENOMEM;
+		if (!prep->description)
+			goto error;
+		memcpy(prep->description, ctx->user_id, ulen);
+		prep->description[ulen] = ' ';
+		bin2hex(prep->description + ulen + 1,
+			ctx->raw_fingerprint + ctx->raw_fingerprint_len - 4, 4);
+		prep->description[ulen + 9] = '\0';
+		pr_debug("desc '%s'\n", prep->description);
+	}
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = pgp_key_generate_id(ctx);
+	prep->payload.data[asym_crypto] = pub;
+	prep->quotalen = 100;
+	kfree(ctx);
+	return 0;
+
+error:
+	public_key_free(pub);
+	kfree(ctx);
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static struct asymmetric_key_parser pgp_key_parser = {
+	.owner		= THIS_MODULE,
+	.name		= "pgp",
+	.parse		= pgp_key_parse,
+};
+
+/*
+ * Module stuff
+ */
+static int __init pgp_key_init(void)
+{
+	return register_asymmetric_key_parser(&pgp_key_parser);
+}
+
+static void __exit pgp_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&pgp_key_parser);
+}
+
+module_init(pgp_key_init);
+module_exit(pgp_key_exit);
-- 
2.34.1


