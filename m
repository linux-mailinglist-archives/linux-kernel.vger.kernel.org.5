Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB37E3A73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKGK40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjKGK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C78D71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c519eab81fso10207631fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354564; x=1699959364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=884mjVBUf/B5xVe7Mn+vWmHn9PLqi2rVnCfcoQ9sUfs=;
        b=bYdOzr/EuQEJquBgHwf/rkMrDMUQn3h7l9IT/ZRd7I64tY0Mx/NJ2APmFIUPrkn7ex
         Os4cQdideQ8X1DBU+TpAE2ibVM4rdkCd+6L8e9MSlCuy2+wD7GiOk7qUi9ZsCgtFyVKD
         XGr+KhOyl3L1w9V57hhoCu8wik35kM7kXuCIPK6G99rEIe/+7mF5IbxVZDC2dys4IPAN
         IdfNZ3V23Fr7B8anAtzKuzgB3ROxYCg8LXI4xRYMjAZleKKd7t9OJhU8cV9Kr5mtwYeS
         dsVip9L3AomT9Ue9T2TXOId0TEaIHjQi6ngKabCb880jLLNPkISD8j0Vd1yMNb7fBmxp
         hAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354564; x=1699959364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=884mjVBUf/B5xVe7Mn+vWmHn9PLqi2rVnCfcoQ9sUfs=;
        b=f8hEufqxpO1jVDkegeMMdF/LDo7zhnLqUvuP8z+Wo15NvMQBEyXyMmBrmeCnAkeFVl
         bt471sfNDjjjxB+Co46bx/3fPn5Slju6LZLMv611dw4fZzwbodQrmoDr+rtanftZNGWt
         tgt84ymOsv7D5TUNa65beaGx3G/17rPU1xVaW9Rfe5+IxSrXfB2IUVB9I5m/rfc32s5i
         I60e+4OmldgdjKUIdMyfBTsro3okUuj79LAXVqw0uGnRau1xEkKR62kRYliDmAkvZGJj
         Ip3rJG1ija/eUoG0l0QSSRegZtLr4/UsQlqN88lZPi1FmXwk4WzKMbV3I6DdJ5gFStl7
         KrWw==
X-Gm-Message-State: AOJu0Ywv0IC0kjeYaQJYgEJoZZ9+WgZNuTK21KiHEckSBLWgM1JfTaP5
        /alBErC8H3bmVEVofqr7/KfRVQ==
X-Google-Smtp-Source: AGHT+IHXvy/dIISU7g85YMpjpEsVNYZwgjK7rpkPblu9B0vYp48kVxXXr9Iu/Jk+bQRG62RXowl+sg==
X-Received: by 2002:a2e:7a19:0:b0:2c0:196c:e38f with SMTP id v25-20020a2e7a19000000b002c0196ce38fmr23575551ljc.1.1699354564263;
        Tue, 07 Nov 2023 02:56:04 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:03 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 03/20] riscv: add ISA extension parsing for scalar crypto
Date:   Tue,  7 Nov 2023 11:55:39 +0100
Message-ID: <20231107105556.517187-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evan@rivosinc.com>

The Scalar Crypto specification defines Zk as a shorthand for the
Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
which are all shorthands for various other extensions. The detailed
breakdown can be found in their dt-binding entries.

Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
"zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt.
For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
should generate the following cpuinfo output:
"rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zkt"

riscv_isa_ext_data grows a pair of new members, to permit setting the
relevant bits for "bundled" extensions, both while parsing the ISA string
and the new dedicated extension properties.

Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Evan Green <evan@rivosinc.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h |  16 ++++-
 arch/riscv/kernel/cpufeature.c | 115 ++++++++++++++++++++++++++-------
 2 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 6fc51c1b34cf..69cc659cf65e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -60,8 +60,20 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_ZICOND		44
+#define RISCV_ISA_EXT_ZBC		45
+#define RISCV_ISA_EXT_ZBKB		46
+#define RISCV_ISA_EXT_ZBKC		47
+#define RISCV_ISA_EXT_ZBKX		48
+#define RISCV_ISA_EXT_ZKND		49
+#define RISCV_ISA_EXT_ZKNE		50
+#define RISCV_ISA_EXT_ZKNH		51
+#define RISCV_ISA_EXT_ZKR		52
+#define RISCV_ISA_EXT_ZKSED		53
+#define RISCV_ISA_EXT_ZKSH		54
+#define RISCV_ISA_EXT_ZKT		55
 
 #define RISCV_ISA_EXT_MAX		64
+#define RISCV_ISA_EXT_INVALID		U32_MAX
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
@@ -79,6 +91,8 @@ struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
 	const char *property;
+	const unsigned int *subset_ext_ids;
+	const unsigned int subset_ext_size;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
@@ -89,7 +103,7 @@ unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
 #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
 
-bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
+bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
 #define riscv_isa_extension_available(isa_bitmap, ext)	\
 	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e3803822ab5a..0d78791288da 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(riscv_isa_extension_base);
  *
  * NOTE: If isa_bitmap is NULL then Host ISA bitmap will be used.
  */
-bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
+bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit)
 {
 	const unsigned long *bmap = (isa_bitmap) ? isa_bitmap : riscv_isa;
 
@@ -100,17 +100,53 @@ static bool riscv_isa_extension_check(int id)
 			return false;
 		}
 		return true;
+	case RISCV_ISA_EXT_INVALID:
+		return false;
 	}
 
 	return true;
 }
 
-#define __RISCV_ISA_EXT_DATA(_name, _id) {	\
-	.name = #_name,				\
-	.property = #_name,			\
-	.id = _id,				\
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
+	.name = #_name,								\
+	.property = #_name,							\
+	.id = _id,								\
+	.subset_ext_ids = _subset_exts,						\
+	.subset_ext_size = _subset_exts_size					\
 }
 
+#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
+
+/* Used to declare pure "lasso" extension (Zk for instance) */
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
+
+static const unsigned int riscv_zk_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKR,
+	RISCV_ISA_EXT_ZKT,
+};
+
+static const unsigned int riscv_zkn_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKNH,
+};
+
+static const unsigned int riscv_zks_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZKSED,
+	RISCV_ISA_EXT_ZKSH
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -174,7 +210,21 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
@@ -187,6 +237,27 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
 
+static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const char *name,
+				 const char *name_end, struct riscv_isainfo *isainfo)
+{
+	if ((name_end - name == strlen(ext->name)) &&
+	     !strncasecmp(name, ext->name, name_end - name)) {
+		/*
+		 * If this is a bundle, enable all the ISA extensions that
+		 * comprise the bundle.
+		 */
+		if (ext->subset_ext_size) {
+			for (int i = 0; i < ext->subset_ext_size; i++) {
+				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					set_bit(ext->subset_ext_ids[i], isainfo->isa);
+			}
+		}
+
+		if (riscv_isa_extension_check(ext->id))
+			set_bit(ext->id, isainfo->isa);
+	}
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
 					  unsigned long *isa2hwcap, const char *isa)
 {
@@ -318,14 +389,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 		if (*isa == '_')
 			++isa;
 
-#define SET_ISA_EXT_MAP(name, bit)						\
-		do {								\
-			if ((ext_end - ext == strlen(name)) &&			\
-			     !strncasecmp(ext, name, strlen(name)) &&		\
-			     riscv_isa_extension_check(bit))			\
-				set_bit(bit, isainfo->isa);			\
-		} while (false)							\
-
 		if (unlikely(ext_err))
 			continue;
 		if (!ext_long) {
@@ -337,10 +400,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			}
 		} else {
 			for (int i = 0; i < riscv_isa_ext_count; i++)
-				SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
-						riscv_isa_ext[i].id);
+				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
 		}
-#undef SET_ISA_EXT_MAP
 	}
 }
 
@@ -439,18 +500,26 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		}
 
 		for (int i = 0; i < riscv_isa_ext_count; i++) {
+			const struct riscv_isa_ext_data ext = riscv_isa_ext[i];
+
 			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     riscv_isa_ext[i].property) < 0)
+						     ext.property) < 0)
 				continue;
 
-			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
-				continue;
+			if (ext.subset_ext_size) {
+				for (int j = 0; j < ext.subset_ext_size; j++) {
+					if (riscv_isa_extension_check(ext.subset_ext_ids[i]))
+						set_bit(ext.subset_ext_ids[j], isainfo->isa);
+				}
+			}
 
-			/* Only single letter extensions get set in hwcap */
-			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
-				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
+			if (riscv_isa_extension_check(ext.id)) {
+				set_bit(ext.id, isainfo->isa);
 
-			set_bit(riscv_isa_ext[i].id, isainfo->isa);
+				/* Only single letter extensions get set in hwcap */
+				if (strnlen(riscv_isa_ext[i].name, 2) == 1)
+					this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
+			}
 		}
 
 		of_node_put(cpu_node);
-- 
2.42.0

