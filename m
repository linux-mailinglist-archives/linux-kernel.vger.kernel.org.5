Return-Path: <linux-kernel+bounces-68873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B285812C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2810B240DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772C1350FC;
	Fri, 16 Feb 2024 15:26:13 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE61350C0;
	Fri, 16 Feb 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097173; cv=none; b=jEeEkDxspcbB/DBdLr4Zi3JGcbZNoImJrGKrucwLB5KKT91RO609Ev1Iz8xztvciENZNS03yRMdJlXzABpdZvfMQQpZiJdAGzKP9M02/GAy6m+YkZvFnS7fht1hyU9Ts75WeK+AjCJnQXV47spM3ljTp6QHvDfgtuPxHsE5j/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097173; c=relaxed/simple;
	bh=D2P1yAQ0Z4GYC0IevJCC6fp7n/FzZgFoYgFfIMUNd38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F43+nt3slHGrXCJ+5uCI7PatXH15ECnC6I0AO3mSRTe6j/xrcrP8ora/PBVDMaClKjTF3N27nFfTCiGL5yWoxKFU89lHfp9k9OEGtv0RaW0T3FfhnGEdbF3QFwUxf7Gy/7Jc0nD6QWRv868RzoAZLJLwAwNuPky72iOVXEKW0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbwNp38jTz9yBkY;
	Fri, 16 Feb 2024 23:10:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 65CB014064F;
	Fri, 16 Feb 2024 23:25:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S5;
	Fri, 16 Feb 2024 16:25:57 +0100 (CET)
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
Subject: [RFC 3/8] PGPLIB: PGP definitions (RFC 4880)
Date: Fri, 16 Feb 2024 16:24:30 +0100
Message-Id: <20240216152435.1575-4-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5Zw1UurW3XFWUur4fAFb_yoW7Kw1Upr
	s5Gr95XFyDt343tr4Sqr42va4fJrsrAr1kGrn7tw15t3Z8WryIg34ktr1kXan3Ga98J3yY
	kFW5Arn3Cwn0y37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: David Howells <dhowells@redhat.com>

Provide some useful PGP definitions from RFC 4880.  These describe details
of public key crypto as used by crypto keys for things like signature
verification.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp.h | 206 +++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp.h

diff --git a/crypto/asymmetric_keys/pgp.h b/crypto/asymmetric_keys/pgp.h
new file mode 100644
index 000000000000..5eb4f4222090
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP definitions (RFC 4880)
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/types.h>
+
+struct pgp_key_ID {
+	u8 id[8];
+} __packed;
+
+struct pgp_time {
+	u8 time[4];
+} __packed;
+
+/*
+ * PGP public-key algorithm identifiers [RFC4880: 9.1]
+ */
+enum pgp_pubkey_algo {
+	PGP_PUBKEY_RSA_ENC_OR_SIG	= 1,
+	PGP_PUBKEY_RSA_ENC_ONLY		= 2,
+	PGP_PUBKEY_RSA_SIG_ONLY		= 3,
+	PGP_PUBKEY_ELGAMAL		= 16,
+	PGP_PUBKEY_DSA			= 17,
+	PGP_PUBKEY__LAST
+};
+
+/*
+ * PGP symmetric-key algorithm identifiers [RFC4880: 9.2]
+ */
+enum pgp_symkey_algo {
+	PGP_SYMKEY_PLAINTEXT		= 0,
+	PGP_SYMKEY_IDEA			= 1,
+	PGP_SYMKEY_3DES			= 2,
+	PGP_SYMKEY_CAST5		= 3,
+	PGP_SYMKEY_BLOWFISH		= 4,
+	PGP_SYMKEY_AES_128KEY		= 7,
+	PGP_SYMKEY_AES_192KEY		= 8,
+	PGP_SYMKEY_AES_256KEY		= 9,
+	PGP_SYMKEY_TWOFISH_256KEY	= 10,
+};
+
+/*
+ * PGP compression algorithm identifiers [RFC4880: 9.3]
+ */
+enum pgp_compr_algo {
+	PGP_COMPR_UNCOMPRESSED		= 0,
+	PGP_COMPR_ZIP			= 1,
+	PGP_COMPR_ZLIB			= 2,
+	PGP_COMPR_BZIP2			= 3,
+};
+
+/*
+ * PGP hash algorithm identifiers [RFC4880: 9.4]
+ */
+enum pgp_hash_algo {
+	PGP_HASH_MD5			= 1,
+	PGP_HASH_SHA1			= 2,
+	PGP_HASH_RIPE_MD_160		= 3,
+	PGP_HASH_SHA256			= 8,
+	PGP_HASH_SHA384			= 9,
+	PGP_HASH_SHA512			= 10,
+	PGP_HASH_SHA224			= 11,
+	PGP_HASH__LAST
+};
+
+extern const char *const pgp_hash_algorithms[PGP_HASH__LAST];
+
+/*
+ * PGP packet type tags [RFC4880: 4.3].
+ */
+enum pgp_packet_tag {
+	PGP_PKT_RESERVED		= 0,
+	PGP_PKT_PUBKEY_ENC_SESSION_KEY	= 1,
+	PGP_PKT_SIGNATURE		= 2,
+	PGP_PKT_SYMKEY_ENC_SESSION_KEY	= 3,
+	PGP_PKT_ONEPASS_SIGNATURE	= 4,
+	PGP_PKT_SECRET_KEY		= 5,
+	PGP_PKT_PUBLIC_KEY		= 6,
+	PGP_PKT_SECRET_SUBKEY		= 7,
+	PGP_PKT_COMPRESSED_DATA		= 8,
+	PGP_PKT_SYM_ENC_DATA		= 9,
+	PGP_PKT_MARKER			= 10,
+	PGP_PKT_LITERAL_DATA		= 11,
+	PGP_PKT_TRUST			= 12,
+	PGP_PKT_USER_ID			= 13,
+	PGP_PKT_PUBLIC_SUBKEY		= 14,
+	PGP_PKT_USER_ATTRIBUTE		= 17,
+	PGP_PKT_SYM_ENC_AND_INTEG_DATA	= 18,
+	PGP_PKT_MODIFY_DETECT_CODE	= 19,
+	PGP_PKT_PRIVATE_0		= 60,
+	PGP_PKT_PRIVATE_3		= 63,
+	PGP_PKT__HIGHEST		= 63
+};
+
+/*
+ * Signature (tag 2) packet [RFC4880: 5.2].
+ */
+enum pgp_signature_version {
+	PGP_SIG_VERSION_3			= 3,
+	PGP_SIG_VERSION_4			= 4,
+};
+
+enum pgp_signature_type {
+	PGP_SIG_BINARY_DOCUMENT_SIG		= 0x00,
+	PGP_SIG_CANONICAL_TEXT_DOCUMENT_SIG	= 0x01,
+	PGP_SIG_STANDALONE_SIG			= 0x02,
+	PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY	= 0x10,
+	PGP_SIG_PERSONAL_CERT_OF_UID_PUBKEY	= 0x11,
+	PGP_SIG_CASUAL_CERT_OF_UID_PUBKEY	= 0x12,
+	PGP_SIG_POSTITIVE_CERT_OF_UID_PUBKEY	= 0x13,
+	PGP_SIG_SUBKEY_BINDING_SIG		= 0x18,
+	PGP_SIG_PRIMARY_KEY_BINDING_SIG		= 0x19,
+	PGP_SIG_DIRECTLY_ON_KEY			= 0x1F,
+	PGP_SIG_KEY_REVOCATION_SIG		= 0x20,
+	PGP_SIG_SUBKEY_REVOCATION_SIG		= 0x28,
+	PGP_SIG_CERT_REVOCATION_SIG		= 0x30,
+	PGP_SIG_TIMESTAMP_SIG			= 0x40,
+	PGP_SIG_THIRD_PARTY_CONFIRM_SIG		= 0x50,
+};
+
+struct pgp_signature_v3_packet {
+	enum pgp_signature_version version : 8; /* == PGP_SIG_VERSION_3 */
+	u8	length_of_hashed;	/* == 5 */
+	struct {
+		enum pgp_signature_type signature_type : 8;
+		struct pgp_time	creation_time;
+	} __packed hashed;
+	struct pgp_key_ID issuer;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+} __packed;
+
+struct pgp_signature_v4_packet {
+	enum pgp_signature_version version : 8;	/* == PGP_SIG_VERSION_4 */
+	enum pgp_signature_type signature_type : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+} __packed;
+
+/*
+ * V4 signature subpacket types [RFC4880: 5.2.3.1].
+ */
+enum pgp_sig_subpkt_type {
+	PGP_SIG_CREATION_TIME			= 2,
+	PGP_SIG_EXPIRATION_TIME			= 3,
+	PGP_SIG_EXPORTABLE_CERT			= 4,
+	PGP_SIG_TRUST_SIG			= 5,
+	PGP_SIG_REGEXP				= 6,
+	PGP_SIG_REVOCABLE			= 7,
+	PGP_SIG_KEY_EXPIRATION_TIME		= 9,
+	PGP_SIG_PREF_SYM_ALGO			= 11,
+	PGP_SIG_REVOCATION_KEY			= 12,
+	PGP_SIG_ISSUER				= 16,
+	PGP_SIG_NOTATION_DATA			= 20,
+	PGP_SIG_PREF_HASH_ALGO			= 21,
+	PGP_SIG_PREF_COMPR_ALGO			= 22,
+	PGP_SIG_KEY_SERVER_PREFS		= 23,
+	PGP_SIG_PREF_KEY_SERVER			= 24,
+	PGP_SIG_PRIMARY_USER_ID			= 25,
+	PGP_SIG_POLICY_URI			= 26,
+	PGP_SIG_KEY_FLAGS			= 27,
+	PGP_SIG_SIGNERS_USER_ID			= 28,
+	PGP_SIG_REASON_FOR_REVOCATION		= 29,
+	PGP_SIG_FEATURES			= 30,
+	PGP_SIG_TARGET				= 31,
+	PGP_SIG_EMBEDDED_SIG			= 32,
+	PGP_SIG__LAST
+};
+
+#define PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK	0x80
+
+/*
+ * Key (tag 5, 6, 7 and 14) packet
+ */
+enum pgp_key_version {
+	PGP_KEY_VERSION_2			= 2,
+	PGP_KEY_VERSION_3			= 3,
+	PGP_KEY_VERSION_4			= 4,
+};
+
+struct pgp_key_v3_packet {
+	enum pgp_key_version version : 8;
+	struct pgp_time	creation_time;
+	u8 expiry[2];			/* 0 or time in days till expiry */
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	u8 key_material[0];
+} __packed;
+
+struct pgp_key_v4_packet {
+	enum pgp_key_version version : 8;
+	struct pgp_time	creation_time;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	u8 key_material[0];
+} __packed;
+
+/*
+ * Literal Data (tag 11) packet
+ */
+enum pgp_literal_data_format {
+	PGP_LIT_FORMAT_BINARY			= 0x62,
+	PGP_LIT_FORMAT_TEXT			= 0x74,
+	PGP_LIT_FORMAT_TEXT_UTF8		= 0x75,
+};
-- 
2.34.1


