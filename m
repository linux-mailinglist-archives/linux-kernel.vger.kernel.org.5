Return-Path: <linux-kernel+bounces-68874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DE85812E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5361F28C40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362F133436;
	Fri, 16 Feb 2024 15:26:25 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BC1350C0;
	Fri, 16 Feb 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097185; cv=none; b=Mk9pi9HMKUFE8Sx+K7L7ZRauvukAHjJTR/naWF3nFw/X3usprdcjLI/JzUVmF87kO5vEDKIxJ9Esl0CwT9bRtnvQFJh6bVQsl04Z0jElGVdilonv3cphZVQ3QhuicIUXsQCMN4aLhfmDU5JLYS7J7JNQDtcDsRKItStyUHZ7Ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097185; c=relaxed/simple;
	bh=wDRrVItlMgBFAtEOauo1qK60I52wT/Rx/468pjENbkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnoPNvnEg5AUSZimrmvh326ZY61jH8zgfiXkCBdSTv0b9QJ2S9VEmKJVxgTi5AZOZsYqAbL6SF97RPSYLX2yO4q77ZNlhvbUBx06uxgXJYI+s3lwnAR6HPvtLRNk6bBsc846NYM7bDCr8l8bUrvK9Ds6KNUcdxZOygPtmL7YQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbwP30gdfz9yBkV;
	Fri, 16 Feb 2024 23:11:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C388A140E02;
	Fri, 16 Feb 2024 23:26:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S6;
	Fri, 16 Feb 2024 16:26:14 +0100 (CET)
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
Subject: [RFC 4/8] PGPLIB: Basic packet parser
Date: Fri, 16 Feb 2024 16:24:31 +0100
Message-Id: <20240216152435.1575-5-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW7GF43Ar48trWxZr47urg_yoWDGw4fpa
	48CryrKa1UGwn2krWfAr17W3srCr48ZFyagayFvw1Yy39FgwnYgrZFkF18Ka48KF4DJ3yS
	krs0gFyY93WqqrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: David Howells <dhowells@redhat.com>

Provide a simple parser that extracts the packets from a PGP packet blob
and passes the desirous ones to the given processor function:

	struct pgp_parse_context {
		u64 types_of_interest;
		int (*process_packet)(struct pgp_parse_context *context,
				      enum pgp_packet_tag type,
				      u8 headerlen,
				      const u8 *data,
				      size_t datalen);
	};

	int pgp_parse_packets(const u8 *data, size_t datalen,
			      struct pgp_parse_context *ctx);

This is configured on with CONFIG_PGP_LIBRARY.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig       |   6 +
 crypto/asymmetric_keys/Makefile      |  16 ++
 crypto/asymmetric_keys/pgp_library.c | 272 +++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h      |  33 ++++
 4 files changed, 327 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgplib.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 59ec726b7c77..ebe9dc88d975 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -86,4 +86,10 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 	depends on X509_CERTIFICATE_PARSER
 
+config PGP_LIBRARY
+	tristate "PGP parsing library"
+	help
+	  This option enables a library that provides a number of simple
+	  utility functions for parsing PGP (RFC 4880) packet-based messages.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 1a273d6df3eb..f7e5ee59857f 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -77,3 +77,19 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# TPM private key parsing
+#
+obj-$(CONFIG_TPM_KEY_PARSER) += tpm_key_parser.o
+tpm_key_parser-y := \
+	tpm.asn1.o \
+	tpm_parser.o
+
+$(obj)/tpm_parser.o: $(obj)/tpm.asn1.h
+$(obj)/tpm.asn1.o: $(obj)/tpm.asn1.c $(obj)/tpm.asn1.h
+
+#
+# PGP handling
+#
+obj-$(CONFIG_PGP_LIBRARY) += pgp_library.o
diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
new file mode 100644
index 000000000000..d2c3149983d5
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PGP packet parser (RFC 4880)
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "PGPL: "fmt
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "pgplib.h"
+
+MODULE_LICENSE("GPL");
+
+const char *const pgp_hash_algorithms[PGP_HASH__LAST] = {
+	[PGP_HASH_MD5]			= "md5",
+	[PGP_HASH_SHA1]			= "sha1",
+	[PGP_HASH_RIPE_MD_160]		= "rmd160",
+	[PGP_HASH_SHA256]		= "sha256",
+	[PGP_HASH_SHA384]		= "sha384",
+	[PGP_HASH_SHA512]		= "sha512",
+	[PGP_HASH_SHA224]		= "sha224",
+};
+EXPORT_SYMBOL_GPL(pgp_hash_algorithms);
+
+/**
+ * pgp_parse_packet_header - Parse a PGP packet header
+ * @_data: Start of the PGP packet (updated to PGP packet data)
+ * @_datalen: Amount of data remaining in buffer (decreased)
+ * @_type: Where the packet type will be returned
+ * @_headerlen: Where the header length will be returned
+ *
+ * Parse a set of PGP packet header [RFC 4880: 4.2].
+ *
+ * Return: packet data size on success; non-zero on error.  If successful,
+ * *_data and *_datalen will have been updated and *_headerlen will be set to
+ * hold the length of the packet header.
+ */
+static ssize_t pgp_parse_packet_header(const u8 **_data, size_t *_datalen,
+				       enum pgp_packet_tag *_type,
+				       u8 *_headerlen)
+{
+	enum pgp_packet_tag type;
+	const u8 *data = *_data;
+	size_t size, datalen = *_datalen;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 2)
+		goto short_packet;
+
+	pr_devel("pkthdr %02x, %02x\n", data[0], data[1]);
+
+	type = *data++;
+	datalen--;
+	if (!(type & 0x80)) {
+		pr_debug("Packet type does not have MSB set\n");
+		return -EBADMSG;
+	}
+	type &= ~0x80;
+
+	if (type & 0x40) {
+		/* New packet length format */
+		type &= ~0x40;
+		pr_devel("new format: t=%u\n", type);
+		switch (data[0]) {
+		case 0x00 ... 0xbf:
+			/* One-byte length */
+			size = data[0];
+			data++;
+			datalen--;
+			*_headerlen = 2;
+			break;
+		case 0xc0 ... 0xdf:
+			/* Two-byte length */
+			if (datalen < 2)
+				goto short_packet;
+			size = (data[0] - 192) * 256;
+			size += data[1] + 192;
+			data += 2;
+			datalen -= 2;
+			*_headerlen = 3;
+			break;
+		case 0xff:
+			/* Five-byte length */
+			if (datalen < 5)
+				goto short_packet;
+			size =  data[1] << 24;
+			size |= data[2] << 16;
+			size |= data[3] << 8;
+			size |= data[4];
+			data += 5;
+			datalen -= 5;
+			*_headerlen = 6;
+			break;
+		default:
+			pr_debug("Partial body length packet not supported\n");
+			return -EBADMSG;
+		}
+	} else {
+		/* Old packet length format */
+		u8 length_type = type & 0x03;
+
+		type >>= 2;
+		pr_devel("old format: t=%u lt=%u\n", type, length_type);
+
+		switch (length_type) {
+		case 0:
+			/* One-byte length */
+			size = data[0];
+			data++;
+			datalen--;
+			*_headerlen = 2;
+			break;
+		case 1:
+			/* Two-byte length */
+			if (datalen < 2)
+				goto short_packet;
+			size  = data[0] << 8;
+			size |= data[1];
+			data += 2;
+			datalen -= 2;
+			*_headerlen = 3;
+			break;
+		case 2:
+			/* Four-byte length */
+			if (datalen < 4)
+				goto short_packet;
+			size  = data[0] << 24;
+			size |= data[1] << 16;
+			size |= data[2] << 8;
+			size |= data[3];
+			data += 4;
+			datalen -= 4;
+			*_headerlen = 5;
+			break;
+		default:
+			pr_debug("Indefinite length packet not supported\n");
+			return -EBADMSG;
+		}
+	}
+
+	pr_devel("datalen=%zu size=%zu\n", datalen, size);
+	if (datalen < size)
+		goto short_packet;
+	if (size > INT_MAX)
+		goto too_big;
+
+	*_data = data;
+	*_datalen = datalen;
+	*_type = type;
+	pr_devel("Found packet type=%u size=%zd\n", type, size);
+	return size;
+
+short_packet:
+	pr_debug("Attempt to parse short packet\n");
+	return -EBADMSG;
+too_big:
+	pr_debug("Signature subpacket size >2G\n");
+	return -EMSGSIZE;
+}
+
+/**
+ * pgp_parse_packets - Parse a set of PGP packets
+ * @data: Data to be parsed (updated)
+ * @datalen: Amount of data (updated)
+ * @ctx: Parsing context
+ *
+ * Parse a set of PGP packets [RFC 4880: 4].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise
+ */
+int pgp_parse_packets(const u8 *data, size_t datalen,
+		      struct pgp_parse_context *ctx)
+{
+	enum pgp_packet_tag type;
+	ssize_t pktlen;
+	u8 headerlen;
+	int ret;
+
+	while (datalen > 2) {
+		pktlen = pgp_parse_packet_header(&data, &datalen, &type,
+						 &headerlen);
+		if (pktlen < 0)
+			return pktlen;
+
+		if ((ctx->types_of_interest >> type) & 1) {
+			ret = ctx->process_packet(ctx, type, headerlen,
+						  data, pktlen);
+			if (ret < 0)
+				return ret;
+		}
+		data += pktlen;
+		datalen -= pktlen;
+	}
+
+	if (datalen != 0) {
+		pr_debug("Excess octets in packet stream\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_packets);
+
+/**
+ * pgp_parse_public_key - Parse the common part of a PGP pubkey packet
+ * @_data: Content of packet (updated)
+ * @_datalen: Length of packet remaining (updated)
+ * @pk: Public key data
+ *
+ * Parse the common data struct for a PGP pubkey packet [RFC 4880: 5.5.2].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise
+ */
+int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
+			 struct pgp_parse_pubkey *pk)
+{
+	const u8 *data = *_data;
+	size_t datalen = *_datalen;
+	unsigned int tmp;
+
+	if (datalen < 12) {
+		pr_debug("Public key packet too short\n");
+		return -EBADMSG;
+	}
+
+	pk->version = *data++;
+	switch (pk->version) {
+	case PGP_KEY_VERSION_2:
+	case PGP_KEY_VERSION_3:
+	case PGP_KEY_VERSION_4:
+		break;
+	default:
+		pr_debug("Public key packet with unhandled version %d\n",
+			   pk->version);
+		return -EBADMSG;
+	}
+
+	tmp  = *data++ << 24;
+	tmp |= *data++ << 16;
+	tmp |= *data++ << 8;
+	tmp |= *data++;
+	pk->creation_time = tmp;
+	if (pk->version == PGP_KEY_VERSION_4) {
+		pk->expires_at = 0; /* Have to get it from the selfsignature */
+	} else {
+		unsigned short ndays;
+
+		ndays  = *data++ << 8;
+		ndays |= *data++;
+		if (ndays)
+			pk->expires_at = pk->creation_time + ndays * 86400UL;
+		else
+			pk->expires_at = 0;
+		datalen -= 2;
+	}
+
+	pk->pubkey_algo = *data++;
+	datalen -= 6;
+
+	pr_devel("%x,%x,%lx,%lx\n",
+		 pk->version, pk->pubkey_algo, pk->creation_time,
+		 pk->expires_at);
+
+	*_data = data;
+	*_datalen = datalen;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_public_key);
diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgplib.h
new file mode 100644
index 000000000000..d82b84179433
--- /dev/null
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP library definitions (RFC 4880)
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "pgp.h"
+
+/*
+ * PGP library packet parser
+ */
+struct pgp_parse_context {
+	u64 types_of_interest;
+	int (*process_packet)(struct pgp_parse_context *context,
+			      enum pgp_packet_tag type,
+			      u8 headerlen,
+			      const u8 *data,
+			      size_t datalen);
+};
+
+extern int pgp_parse_packets(const u8 *data, size_t datalen,
+			     struct pgp_parse_context *ctx);
+
+struct pgp_parse_pubkey {
+	enum pgp_key_version version : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	__kernel_old_time_t creation_time;
+	__kernel_old_time_t expires_at;
+};
+
+extern int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
+				struct pgp_parse_pubkey *pk);
-- 
2.34.1


