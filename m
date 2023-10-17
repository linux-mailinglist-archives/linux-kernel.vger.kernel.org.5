Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C07CC430
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjJQNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbjJQNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2CFB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40651b22977so10009645e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548528; x=1698153328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+qm4/TAsuUsyMqC2dQJYqFkQNRJUQO9ctbV40HqJn4=;
        b=hQ514CwH0j42gvOkXJfV+YAZbhqW7kjsV9RECUZUP+oI1JkQycrLDGBvFzd5MGy8F9
         ecN99295TqslqXvJC4+wacqzfNiUZVD/5Q0sxcL9TeXPgxg+37uxPh6N3XeIda6JNoBp
         YILa4zkGZwrhOAJrpkn3JW/VIe4Z0MBgw03PsOcQh94UiSVLQk7vPnpFuB7CTCKW/X62
         tbq+lASiK7NjIPf4uvm4PmFbKZpIgP1q/up77n3mFeW1lFElM3xpwQtZHq7ABS+aI4Pk
         HBnyj4k348yRUQKj8JapMOe5keRP9su+pzfkpRp+jSUcQCIpfcaKyBKKf984fb3trUYn
         uSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548528; x=1698153328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+qm4/TAsuUsyMqC2dQJYqFkQNRJUQO9ctbV40HqJn4=;
        b=aqfS4sPq7xl6JiadM1S1/BGPUiNIEvxP5eiBCVd69LL/95jHM496M2cg+ogIL/lpO2
         zNz5TlEmGpXKnVJZRBeDiAEZp46l7EogUR+imPJklK5dei9XCsxutZYLYFdSCl5vJ46m
         rRxx+IzjeFxbMWpl4yZl6DorPspBIjxG5s3tTEpV/cvSt9nX6rHbJKJgPkL9Q4bnSqD7
         0DOT0OLxK9PuG3gQq78jbOgT30W/88nHElOlSAmWjFiDCQEK4mmZhA08vd4f5csNKJfQ
         AHUL+aOIeHvMoWv2RuJ8A30Vg+JfUbzwNOH3R2ylJPjuKIbjs9aaALQugHEklikYLWAO
         stpQ==
X-Gm-Message-State: AOJu0YyM9JFjjjxoZmgxbUMxhMaB4FvrsA6Q1PXbLL12EBLPTvEVx4Yi
        idA58AKkGp0UNVKPuBM+Adj2sA==
X-Google-Smtp-Source: AGHT+IFwvpP6te3nte1X3kpkcIZvEv7NTNdwIhPdz7lcem9dtQZwsDEgtR+7PS/ddcn3SDkn023Ubg==
X-Received: by 2002:a05:600c:210b:b0:405:4721:800 with SMTP id u11-20020a05600c210b00b0040547210800mr1657967wml.1.1697548528573;
        Tue, 17 Oct 2023 06:15:28 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:28 -0700 (PDT)
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
Subject: [PATCH v2 02/19] riscv: add ISA extension parsing for scalar crypto
Date:   Tue, 17 Oct 2023 15:14:39 +0200
Message-ID: <20231017131456.2053396-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
and the new dedicated extension properties

Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Evan Green <evan@rivosinc.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h |  13 +++++
 arch/riscv/kernel/cpufeature.c | 103 ++++++++++++++++++++++++++-------
 2 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..ab80d822c847 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,17 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZBC		43
+#define RISCV_ISA_EXT_ZBKB		44
+#define RISCV_ISA_EXT_ZBKC		45
+#define RISCV_ISA_EXT_ZBKX		46
+#define RISCV_ISA_EXT_ZKND		47
+#define RISCV_ISA_EXT_ZKNE		48
+#define RISCV_ISA_EXT_ZKNH		49
+#define RISCV_ISA_EXT_ZKR		50
+#define RISCV_ISA_EXT_ZKSED		51
+#define RISCV_ISA_EXT_ZKSH		52
+#define RISCV_ISA_EXT_ZKT		53
 
 #define RISCV_ISA_EXT_MAX		64
 
@@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
 	const char *property;
+	const unsigned int *bundle_ids;
+	const unsigned int bundle_size;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..d3682fdfd9f1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -111,6 +111,39 @@ static bool riscv_isa_extension_check(int id)
 	.id = _id,				\
 }
 
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) {	\
+	.name = #_name,					\
+	.property = #_name,				\
+	.bundle_ids = _bundled_exts,			\
+	.bundle_size = ARRAY_SIZE(_bundled_exts)	\
+}
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
@@ -173,7 +206,21 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
@@ -185,6 +232,26 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
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
+		if (ext->bundle_size) {
+			for (int i = 0; i < ext->bundle_size; i++) {
+				if (riscv_isa_extension_check(ext->bundle_ids[i]))
+					set_bit(ext->bundle_ids[i], isainfo->isa);
+			}
+		} else if (riscv_isa_extension_check(ext->id)) {
+			set_bit(ext->id, isainfo->isa);
+		}
+	}
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
 					  unsigned long *isa2hwcap, const char *isa)
 {
@@ -316,14 +383,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
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
@@ -335,10 +394,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
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
 
@@ -437,18 +494,24 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		}
 
 		for (int i = 0; i < riscv_isa_ext_count; i++) {
-			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     riscv_isa_ext[i].property) < 0)
-				continue;
+			const struct riscv_isa_ext_data ext = riscv_isa_ext[i];
 
-			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
+			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+						     ext.property) < 0)
 				continue;
 
-			/* Only single letter extensions get set in hwcap */
-			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
-				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
-
-			set_bit(riscv_isa_ext[i].id, isainfo->isa);
+			if (ext.bundle_size) {
+				for (int j = 0; j < ext.bundle_size; j++) {
+					if (riscv_isa_extension_check(ext.bundle_ids[i]))
+						set_bit(ext.bundle_ids[j], isainfo->isa);
+				}
+			} else if (riscv_isa_extension_check(ext.id)) {
+				set_bit(ext.id, isainfo->isa);
+
+				/* Only single letter extensions get set in hwcap */
+				if (strnlen(riscv_isa_ext[i].name, 2) == 1)
+					this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
+			}
 		}
 
 		of_node_put(cpu_node);
-- 
2.42.0

