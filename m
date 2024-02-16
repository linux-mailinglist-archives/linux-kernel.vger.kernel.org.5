Return-Path: <linux-kernel+bounces-68875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C1858130
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F921C2213D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DD135A4E;
	Fri, 16 Feb 2024 15:26:47 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8E135416;
	Fri, 16 Feb 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097206; cv=none; b=pFtBbk9u9CiIxknchSJxqV6oFNVD82/jlqR9EX+iIw8ClHfWDewdixcSCZSmLMHzHsJL1gBkPz6QbJF+OHPiCMoGE/+xtBODWHl/J72jlKCcp/KiCrTCHkVds8lnHCrzN1XZbwFSvFsVWjjWkuNDJ3MygC9Wvw7bpXDFrVe1Qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097206; c=relaxed/simple;
	bh=Oz2/9YzU5D10pdbzfEmKDaUKj6akAqmbwAHuQa67quY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkBk2UqMnzDbUiAYmN6OhVO+VkXuksEBixtBCUi2X6xgExJUYXEA3frFhyuxMQi/gbqEAwClMzBHyUD6hoPQ5+H6y/JUFN0OMjm0XC7AeyIhtABog7W1XE6PKtZVEu2OokrYUHiSuytCpMnuXY7TP4Swfu4Yc9fJoiEgEewI/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbwPS2mTGz9yKXQ;
	Fri, 16 Feb 2024 23:11:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3B634140661;
	Fri, 16 Feb 2024 23:26:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S7;
	Fri, 16 Feb 2024 16:26:30 +0100 (CET)
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
Subject: [RFC 5/8] PGPLIB: Signature parser
Date: Fri, 16 Feb 2024 16:24:32 +0100
Message-Id: <20240216152435.1575-6-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8tryruF45Cw1rAF47urg_yoWDGry3pa
	40y34ftrWUG3ZavrW8Ar47X3y5Cr40y347Ka9Yq3WYy39agrn8ZrWvkFyFkFZ8t3WkX3yx
	CrZ8ta98ur4kZw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: David Howells <dhowells@redhat.com>

Provide some PGP signature parsing helpers:

 (1) A function to parse V4 signature subpackets and pass the desired ones
     to a processor function:

	int pgp_parse_sig_subpkts(const u8 *data, size_t datalen,
				  struct pgp_parse_sig_context *ctx);

 (2) A function to parse out basic signature parameters from any PGP
     signature such that the algorithms and public key can be selected:

	int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
				 struct pgp_sig_parameters *p);

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp_library.c | 284 +++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h      |  25 +++
 2 files changed, 309 insertions(+)

diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
index d2c3149983d5..de4a748db9be 100644
--- a/crypto/asymmetric_keys/pgp_library.c
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -270,3 +270,287 @@ int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pgp_parse_public_key);
+
+/**
+ * pgp_parse_sig_subpkt_header - Parse a PGP V4 signature subpacket header
+ * @_data: Start of the subpacket (updated to subpacket data)
+ * @_datalen: Amount of data remaining in buffer (decreased)
+ * @_type: Where the subpacket type will be returned
+ *
+ * Parse a PGP V4 signature subpacket header [RFC 4880: 5.2.3.1].
+ *
+ * Return: packet data size on success; non-zero on error.  If successful,
+ * *_data and *_datalen will have been updated and *_headerlen will be set to
+ * hold the length of the packet header.
+ */
+static ssize_t pgp_parse_sig_subpkt_header(const u8 **_data, size_t *_datalen,
+					   enum pgp_sig_subpkt_type *_type)
+{
+	enum pgp_sig_subpkt_type type;
+	const u8 *data = *_data;
+	size_t size, datalen = *_datalen;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 2)
+		goto short_subpacket;
+
+	pr_devel("subpkt hdr %02x, %02x\n", data[0], data[1]);
+
+	switch (data[0]) {
+	case 0x00 ... 0xbf:
+		/* One-byte length */
+		size = data[0];
+		data++;
+		datalen--;
+		break;
+	case 0xc0 ... 0xfe:
+		/* Two-byte length */
+		if (datalen < 3)
+			goto short_subpacket;
+		size = (data[0] - 192) * 256;
+		size += data[1] + 192;
+		data += 2;
+		datalen -= 2;
+		break;
+	case 0xff:
+		if (datalen < 6)
+			goto short_subpacket;
+		size  = data[1] << 24;
+		size |= data[2] << 16;
+		size |= data[3] << 8;
+		size |= data[4];
+		data += 5;
+		datalen -= 5;
+		break;
+	}
+
+	/* The type octet is included in the size */
+	pr_devel("datalen=%zu size=%zu\n", datalen, size);
+	if (datalen < size)
+		goto short_subpacket;
+	if (size == 0)
+		goto very_short_subpacket;
+	if (size > INT_MAX)
+		goto too_big;
+
+	type = *data++ & ~PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK;
+	datalen--;
+	size--;
+
+	*_data = data;
+	*_datalen = datalen;
+	*_type = type;
+	pr_devel("Found subpkt type=%u size=%zd\n", type, size);
+	return size;
+
+very_short_subpacket:
+	pr_debug("Signature subpacket size can't be zero\n");
+	return -EBADMSG;
+short_subpacket:
+	pr_debug("Attempt to parse short signature subpacket\n");
+	return -EBADMSG;
+too_big:
+	pr_debug("Signature subpacket size >2G\n");
+	return -EMSGSIZE;
+}
+
+/**
+ * pgp_parse_sig_subpkts - Parse a set of PGP V4 signatute subpackets
+ * @data: Data to be parsed (updated)
+ * @datalen: Amount of data (updated)
+ * @ctx: Parsing context
+ *
+ * Parse a set of PGP signature subpackets [RFC 4880: 5.2.3].
+ *
+ * Return: 0 on successful parsing, an error value otherwise
+ */
+static int pgp_parse_sig_subpkts(const u8 *data, size_t datalen,
+				 struct pgp_parse_sig_context *ctx)
+{
+	enum pgp_sig_subpkt_type type;
+	ssize_t pktlen;
+	int ret;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	while (datalen > 2) {
+		pktlen = pgp_parse_sig_subpkt_header(&data, &datalen, &type);
+		if (pktlen < 0)
+			return pktlen;
+		if (test_bit(type, ctx->types_of_interest)) {
+			ret = ctx->process_packet(ctx, type, data, pktlen);
+			if (ret < 0)
+				return ret;
+		}
+		data += pktlen;
+		datalen -= pktlen;
+	}
+
+	if (datalen != 0) {
+		pr_debug("Excess octets in signature subpacket stream\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+struct pgp_parse_sig_params_ctx {
+	struct pgp_parse_sig_context base;
+	struct pgp_sig_parameters *params;
+	bool got_the_issuer;
+};
+
+/*
+ * Process a V4 signature subpacket.
+ */
+static int pgp_process_sig_params_subpkt(struct pgp_parse_sig_context *context,
+					 enum pgp_sig_subpkt_type type,
+					 const u8 *data,
+					 size_t datalen)
+{
+	struct pgp_parse_sig_params_ctx *ctx =
+		container_of(context, struct pgp_parse_sig_params_ctx, base);
+
+	if (ctx->got_the_issuer) {
+		pr_debug("V4 signature packet has multiple issuers\n");
+		return -EBADMSG;
+	}
+
+	if (datalen != 8) {
+		pr_debug("V4 signature issuer subpkt not 8 long (%zu)\n",
+			   datalen);
+		return -EBADMSG;
+	}
+
+	memcpy(&ctx->params->issuer, data, 8);
+	ctx->got_the_issuer = true;
+	return 0;
+}
+
+/**
+ * pgp_parse_sig_params - Parse basic parameters from a PGP signature packet
+ * @_data: Content of packet (updated)
+ * @_datalen: Length of packet remaining (updated)
+ * @p: The basic parameters
+ *
+ * Parse the basic parameters from a PGP signature packet [RFC 4880: 5.2] that
+ * are needed to start off a signature verification operation.  The only ones
+ * actually necessary are the signature type (which affects how the data is
+ * transformed) and the hash algorithm.
+ *
+ * We also extract the public key algorithm and the issuer's key ID as we'll
+ * need those to determine if we actually have the public key available.  If
+ * not, then we can't verify the signature anyway.
+ *
+ * Return: 0 if successful or a negative error code.  *_data and *_datalen are
+ * updated to point to the 16-bit subset of the hash value and the set of MPIs.
+ */
+int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
+			 struct pgp_sig_parameters *p)
+{
+	const u8 *data = *_data;
+	size_t datalen = *_datalen;
+	int ret;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 1)
+		return -EBADMSG;
+	p->version = *data;
+
+	if (p->version == PGP_SIG_VERSION_3) {
+		const struct pgp_signature_v3_packet *v3 = (const void *)data;
+
+		if (datalen < sizeof(*v3)) {
+			pr_debug("Short V3 signature packet\n");
+			return -EBADMSG;
+		}
+		datalen -= sizeof(*v3);
+		data += sizeof(*v3);
+
+		/* V3 has everything we need in the header */
+		p->signature_type = v3->hashed.signature_type;
+		memcpy(&p->issuer, &v3->issuer, 8);
+		p->pubkey_algo = v3->pubkey_algo;
+		p->hash_algo = v3->hash_algo;
+
+	} else if (p->version == PGP_SIG_VERSION_4) {
+		const struct pgp_signature_v4_packet *v4 = (const void *)data;
+		struct pgp_parse_sig_params_ctx ctx = {
+			.base.process_packet = pgp_process_sig_params_subpkt,
+			.params = p,
+			.got_the_issuer = false,
+		};
+		size_t subdatalen;
+
+		if (datalen < sizeof(*v4) + 2 + 2 + 2) {
+			pr_debug("Short V4 signature packet\n");
+			return -EBADMSG;
+		}
+		datalen -= sizeof(*v4);
+		data += sizeof(*v4);
+
+		/* V4 has most things in the header... */
+		p->signature_type = v4->signature_type;
+		p->pubkey_algo = v4->pubkey_algo;
+		p->hash_algo = v4->hash_algo;
+
+		/*
+		 * ... but we have to get the key ID from the subpackets, of
+		 * which there are two sets.
+		 */
+		__set_bit(PGP_SIG_ISSUER, ctx.base.types_of_interest);
+
+		subdatalen  = *data++ << 8;
+		subdatalen |= *data++;
+		datalen -= 2;
+		if (subdatalen) {
+			/* Hashed subpackets */
+			pr_devel("hashed data: %zu (after %zu)\n",
+				 subdatalen, sizeof(*v4));
+			if (subdatalen > datalen + 2 + 2) {
+				pr_debug("Short V4 signature packet [hdata]\n");
+				return -EBADMSG;
+			}
+			ret = pgp_parse_sig_subpkts(data, subdatalen,
+						    &ctx.base);
+			if (ret < 0)
+				return ret;
+			data += subdatalen;
+			datalen -= subdatalen;
+		}
+
+		subdatalen  = *data++ << 8;
+		subdatalen |= *data++;
+		datalen -= 2;
+		if (subdatalen) {
+			/* Unhashed subpackets */
+			pr_devel("unhashed data: %zu\n", subdatalen);
+			if (subdatalen > datalen + 2) {
+				pr_debug("Short V4 signature packet [udata]\n");
+				return -EBADMSG;
+			}
+			ret = pgp_parse_sig_subpkts(data, subdatalen,
+						    &ctx.base);
+			if (ret < 0)
+				return ret;
+			data += subdatalen;
+			datalen -= subdatalen;
+		}
+
+		if (!ctx.got_the_issuer) {
+			pr_debug("V4 signature packet lacks issuer\n");
+			return -EBADMSG;
+		}
+	} else {
+		pr_debug("Signature packet with unhandled version %d\n",
+			 p->version);
+		return -EBADMSG;
+	}
+
+	*_data = data;
+	*_datalen = datalen;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_sig_params);
diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgplib.h
index d82b84179433..967e2853186d 100644
--- a/crypto/asymmetric_keys/pgplib.h
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -31,3 +31,28 @@ struct pgp_parse_pubkey {
 
 extern int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
 				struct pgp_parse_pubkey *pk);
+
+struct pgp_parse_sig_context {
+	unsigned long types_of_interest[128 / BITS_PER_LONG];
+	int (*process_packet)(struct pgp_parse_sig_context *context,
+			      enum pgp_sig_subpkt_type type,
+			      const u8 *data,
+			      size_t datalen);
+};
+
+extern int pgp_parse_sig_packets(const u8 *data, size_t datalen,
+				 struct pgp_parse_sig_context *ctx);
+
+struct pgp_sig_parameters {
+	enum pgp_signature_version version : 8;
+	enum pgp_signature_type signature_type : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+	union {
+		struct pgp_key_ID issuer;
+		__be32 issuer32[2];
+	};
+};
+
+extern int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
+				struct pgp_sig_parameters *p);
-- 
2.34.1


