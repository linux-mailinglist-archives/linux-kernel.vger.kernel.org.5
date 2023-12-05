Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4C804DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjLEJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjLEJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FF98
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce52ff23dfso1385509b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768523; x=1702373323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpHLj7NQfO6jzj2DVP1oEzxWGoW4RlpyCrCS4XZ8hCc=;
        b=boBgfahys3sZbla1/wE0lX0OPHsU4MLrk8cqrYV4qdiAH7UECfQ2c0iaV5YAL9lTUL
         heoGbOVna3qU3Bs1exejbBpDUAdmNtrH6w+30wQ2ekI+nr0k7QJIzgbBBmk/lKtDH75q
         ekwJQN48o6ngBAOnLysSqz2wXayVfPLjdgyDb7qZE8AhAaTqHpHb8lJU8Tydc7LrCxt4
         o8SIRvRaXEc5QtcpMdO8o6zK+Tl1WRp/4KaPb2Eeqr0bslDMIZYnNfotkoHUnVJeV1fi
         zea1o4X7c4nT8itQVosnOxxcGJaWPvLA7q2RK2Ju2EJ2cogKstN7yNEHZ6FlwYqG9GST
         26/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768523; x=1702373323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpHLj7NQfO6jzj2DVP1oEzxWGoW4RlpyCrCS4XZ8hCc=;
        b=LbgyfI1dccHBGAuN4ellWUUXnAnvlqezMvPFT5kEBurz6YhhCpNadLSOi0grC3phso
         X8DmfgzWsyfLXddBh47gghQU4osFf3poVnCayEXPPw1FkjdrRhvIwsmFwQCLXJfJYU9k
         HvlBH+1BcBfCHwcgGfICDKleJqnebF7OWRwcrLPuiMKzJ7jODfEfq+a0Tf9Q7qm543ZV
         gehUTGGNj5Z5sXebRczHcionnEjm2RyBTq6mn8FKCrcG2K9bhMgPIPtQtw7NScMHkuvg
         wS7bR6p6nChVdpP46FHuAPbU73BtegdXrvnn8iizrQrV1tdKFbMoBvJcXFttD9asE87v
         PFuQ==
X-Gm-Message-State: AOJu0YxV4y9gOfy3GtvJomLzZ9g1VKfkzcTuBTSz2sRneqCildloj7Rl
        dj+VuKsU59MtCzAKg96MQTXMBA==
X-Google-Smtp-Source: AGHT+IGY0NY3ybh3om/5hWy7Ani6NczpENwtpaIYA9yfajIuLqU+A3UHYPcDQwB4PBylDh4SLpLfZg==
X-Received: by 2002:a05:6a00:4387:b0:6ce:2731:47bd with SMTP id bt7-20020a056a00438700b006ce273147bdmr1068195pfb.29.1701768523368;
        Tue, 05 Dec 2023 01:28:43 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:43 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 09/12] RISC-V: crypto: add Zvknhb accelerated SHA384/512 implementations
Date:   Tue,  5 Dec 2023 17:27:58 +0800
Message-Id: <20231205092801.1335-10-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SHA384 and 512 implementations using Zvknhb vector crypto extension
from OpenSSL(openssl/openssl#21923).

Co-developed-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v3:
 - Use `SYM_TYPED_FUNC_START` for sha512 indirect-call asm symbol.
 - Use asm mnemonics for the instructions in RVV 1.0 extension.

Changelog v2:
 - Do not turn on kconfig `SHA512_RISCV64` option by default.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Rename sha512-riscv64-zvkb-zvknhb to sha512-riscv64-zvknhb-zvkb.
 - Reorder structure sha512_algs members initialization in the order
   declared.
---
 arch/riscv/crypto/Kconfig                     |  11 +
 arch/riscv/crypto/Makefile                    |   7 +
 arch/riscv/crypto/sha512-riscv64-glue.c       | 139 +++++++++
 .../crypto/sha512-riscv64-zvknhb-zvkb.pl      | 265 ++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index d31af9190717..ad0b08a13c9a 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -55,4 +55,15 @@ config CRYPTO_SHA256_RISCV64
 	  - Zvknha or Zvknhb vector crypto extensions
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SHA512_RISCV64
+	tristate "Hash functions: SHA-384 and SHA-512"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_SHA512
+	help
+	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using:
+	  - Zvknhb vector crypto extension
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index e9d7717ec943..8aabef950ad3 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -15,6 +15,9 @@ ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
 
+obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
+sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -33,8 +36,12 @@ $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 $(obj)/sha256-riscv64-zvknha_or_zvknhb-zvkb.S: $(src)/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/sha512-riscv64-zvknhb-zvkb.S: $(src)/sha512-riscv64-zvknhb-zvkb.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha_or_zvknhb-zvkb.S
+clean-files += sha512-riscv64-zvknhb-zvkb.S
diff --git a/arch/riscv/crypto/sha512-riscv64-glue.c b/arch/riscv/crypto/sha512-riscv64-glue.c
new file mode 100644
index 000000000000..3dd8e1c9d402
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-glue.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA512 implementation for RISC-V 64
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha512_base.h>
+
+/*
+ * sha512 using zvkb and zvknhb vector crypto extension
+ *
+ * This asm function will just take the first 512-bit as the sha512 state from
+ * the pointer to `struct sha512_state`.
+ */
+asmlinkage void sha512_block_data_order_zvkb_zvknhb(struct sha512_state *digest,
+						    const u8 *data,
+						    int num_blks);
+
+static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	int ret = 0;
+
+	/*
+	 * Make sure struct sha512_state begins directly with the SHA512
+	 * 512-bit internal state, as this is what the asm function expect.
+	 */
+	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		ret = sha512_base_do_update(
+			desc, data, len, sha512_block_data_order_zvkb_zvknhb);
+		kernel_vector_end();
+	} else {
+		ret = crypto_sha512_update(desc, data, len);
+	}
+
+	return ret;
+}
+
+static int riscv64_sha512_finup(struct shash_desc *desc, const u8 *data,
+				unsigned int len, u8 *out)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sha512_base_do_update(
+				desc, data, len,
+				sha512_block_data_order_zvkb_zvknhb);
+		sha512_base_do_finalize(desc,
+					sha512_block_data_order_zvkb_zvknhb);
+		kernel_vector_end();
+
+		return sha512_base_finish(desc, out);
+	}
+
+	return crypto_sha512_finup(desc, data, len, out);
+}
+
+static int riscv64_sha512_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha512_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sha512_algs[] = {
+	{
+		.init = sha512_base_init,
+		.update = riscv64_sha512_update,
+		.final = riscv64_sha512_final,
+		.finup = riscv64_sha512_finup,
+		.descsize = sizeof(struct sha512_state),
+		.digestsize = SHA512_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA512_BLOCK_SIZE,
+			.cra_priority = 150,
+			.cra_name = "sha512",
+			.cra_driver_name = "sha512-riscv64-zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	},
+	{
+		.init = sha384_base_init,
+		.update = riscv64_sha512_update,
+		.final = riscv64_sha512_final,
+		.finup = riscv64_sha512_finup,
+		.descsize = sizeof(struct sha512_state),
+		.digestsize = SHA384_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA384_BLOCK_SIZE,
+			.cra_priority = 150,
+			.cra_name = "sha384",
+			.cra_driver_name = "sha384-riscv64-zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+static inline bool check_sha512_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKNHB) &&
+	       riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_sha512_mod_init(void)
+{
+	if (check_sha512_ext())
+		return crypto_register_shashes(sha512_algs,
+					       ARRAY_SIZE(sha512_algs));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sha512_mod_fini(void)
+{
+	crypto_unregister_shashes(sha512_algs, ARRAY_SIZE(sha512_algs));
+}
+
+module_init(riscv64_sha512_mod_init);
+module_exit(riscv64_sha512_mod_fini);
+
+MODULE_DESCRIPTION("SHA-512 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sha384");
+MODULE_ALIAS_CRYPTO("sha512");
diff --git a/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl b/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl
new file mode 100644
index 000000000000..1635b382b523
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl
@@ -0,0 +1,265 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+# Copyright (c) 2023, Phoebe Chen <phoebe.chen@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+# - RISC-V Vector SHA-2 Secure Hash extension ('Zvknhb')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+#include <linux/cfi_types.h>
+
+.text
+___
+
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+my $K512 = "K512";
+
+# Function arguments
+my ($H, $INP, $LEN, $KT, $H2, $INDEX_PATTERN) = ("a0", "a1", "a2", "a3", "t3", "t4");
+
+################################################################################
+# void sha512_block_data_order_zvkb_zvknhb(void *c, const void *p, size_t len)
+$code .= <<___;
+SYM_TYPED_FUNC_START(sha512_block_data_order_zvkb_zvknhb)
+    vsetivli zero, 4, e64, m2, ta, ma
+
+    # H is stored as {a,b,c,d},{e,f,g,h}, but we need {f,e,b,a},{h,g,d,c}
+    # The dst vtype is e64m2 and the index vtype is e8mf4.
+    # We use index-load with the following index pattern at v1.
+    #   i8 index:
+    #     40, 32, 8, 0
+    # Instead of setting the i8 index, we could use a single 32bit
+    # little-endian value to cover the 4xi8 index.
+    #   i32 value:
+    #     0x 00 08 20 28
+    li $INDEX_PATTERN, 0x00082028
+    vsetivli zero, 1, e32, m1, ta, ma
+    vmv.v.x $V1, $INDEX_PATTERN
+
+    addi $H2, $H, 16
+
+    # Use index-load to get {f,e,b,a},{h,g,d,c}
+    vsetivli zero, 4, e64, m2, ta, ma
+    vluxei8.v $V22, ($H), $V1
+    vluxei8.v $V24, ($H2), $V1
+
+    # Setup v0 mask for the vmerge to replace the first word (idx==0) in key-scheduling.
+    # The AVL is 4 in SHA, so we could use a single e8(8 element masking) for masking.
+    vsetivli zero, 1, e8, m1, ta, ma
+    vmv.v.i $V0, 0x01
+
+    vsetivli zero, 4, e64, m2, ta, ma
+
+L_round_loop:
+    # Load round constants K512
+    la $KT, $K512
+
+    # Decrement length by 1
+    addi $LEN, $LEN, -1
+
+    # Keep the current state as we need it later: H' = H+{a',b',c',...,h'}.
+    vmv.v.v $V26, $V22
+    vmv.v.v $V28, $V24
+
+    # Load the 1024-bits of the message block in v10-v16 and perform the endian
+    # swap.
+    vle64.v $V10, ($INP)
+    @{[vrev8_v $V10, $V10]}
+    addi $INP, $INP, 32
+    vle64.v $V12, ($INP)
+    @{[vrev8_v $V12, $V12]}
+    addi $INP, $INP, 32
+    vle64.v $V14, ($INP)
+    @{[vrev8_v $V14, $V14]}
+    addi $INP, $INP, 32
+    vle64.v $V16, ($INP)
+    @{[vrev8_v $V16, $V16]}
+    addi $INP, $INP, 32
+
+    .rept 4
+    # Quad-round 0 (+0, v10->v12->v14->v16)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V10
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+    vmerge.vvm $V18, $V14, $V12, $V0
+    @{[vsha2ms_vv $V10, $V18, $V16]}
+
+    # Quad-round 1 (+1, v12->v14->v16->v10)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V12
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+    vmerge.vvm $V18, $V16, $V14, $V0
+    @{[vsha2ms_vv $V12, $V18, $V10]}
+
+    # Quad-round 2 (+2, v14->v16->v10->v12)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V14
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+    vmerge.vvm $V18, $V10, $V16, $V0
+    @{[vsha2ms_vv $V14, $V18, $V12]}
+
+    # Quad-round 3 (+3, v16->v10->v12->v14)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V16
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+    vmerge.vvm $V18, $V12, $V10, $V0
+    @{[vsha2ms_vv $V16, $V18, $V14]}
+    .endr
+
+    # Quad-round 16 (+0, v10->v12->v14->v16)
+    # Note that we stop generating new message schedule words (Wt, v10-16)
+    # as we already generated all the words we end up consuming (i.e., W[79:76]).
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V10
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+
+    # Quad-round 17 (+1, v12->v14->v16->v10)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V12
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+
+    # Quad-round 18 (+2, v14->v16->v10->v12)
+    vle64.v $V20, ($KT)
+    addi $KT, $KT, 32
+    vadd.vv $V18, $V20, $V14
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+
+    # Quad-round 19 (+3, v16->v10->v12->v14)
+    vle64.v $V20, ($KT)
+    # No t1 increment needed.
+    vadd.vv $V18, $V20, $V16
+    @{[vsha2cl_vv $V24, $V22, $V18]}
+    @{[vsha2ch_vv $V22, $V24, $V18]}
+
+    # H' = H+{a',b',c',...,h'}
+    vadd.vv $V22, $V26, $V22
+    vadd.vv $V24, $V28, $V24
+    bnez $LEN, L_round_loop
+
+    # Store {f,e,b,a},{h,g,d,c} back to {a,b,c,d},{e,f,g,h}.
+    vsuxei8.v $V22, ($H), $V1
+    vsuxei8.v $V24, ($H2), $V1
+
+    ret
+SYM_FUNC_END(sha512_block_data_order_zvkb_zvknhb)
+
+.p2align 3
+.type $K512,\@object
+$K512:
+    .dword 0x428a2f98d728ae22, 0x7137449123ef65cd
+    .dword 0xb5c0fbcfec4d3b2f, 0xe9b5dba58189dbbc
+    .dword 0x3956c25bf348b538, 0x59f111f1b605d019
+    .dword 0x923f82a4af194f9b, 0xab1c5ed5da6d8118
+    .dword 0xd807aa98a3030242, 0x12835b0145706fbe
+    .dword 0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2
+    .dword 0x72be5d74f27b896f, 0x80deb1fe3b1696b1
+    .dword 0x9bdc06a725c71235, 0xc19bf174cf692694
+    .dword 0xe49b69c19ef14ad2, 0xefbe4786384f25e3
+    .dword 0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65
+    .dword 0x2de92c6f592b0275, 0x4a7484aa6ea6e483
+    .dword 0x5cb0a9dcbd41fbd4, 0x76f988da831153b5
+    .dword 0x983e5152ee66dfab, 0xa831c66d2db43210
+    .dword 0xb00327c898fb213f, 0xbf597fc7beef0ee4
+    .dword 0xc6e00bf33da88fc2, 0xd5a79147930aa725
+    .dword 0x06ca6351e003826f, 0x142929670a0e6e70
+    .dword 0x27b70a8546d22ffc, 0x2e1b21385c26c926
+    .dword 0x4d2c6dfc5ac42aed, 0x53380d139d95b3df
+    .dword 0x650a73548baf63de, 0x766a0abb3c77b2a8
+    .dword 0x81c2c92e47edaee6, 0x92722c851482353b
+    .dword 0xa2bfe8a14cf10364, 0xa81a664bbc423001
+    .dword 0xc24b8b70d0f89791, 0xc76c51a30654be30
+    .dword 0xd192e819d6ef5218, 0xd69906245565a910
+    .dword 0xf40e35855771202a, 0x106aa07032bbd1b8
+    .dword 0x19a4c116b8d2d0c8, 0x1e376c085141ab53
+    .dword 0x2748774cdf8eeb99, 0x34b0bcb5e19b48a8
+    .dword 0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb
+    .dword 0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3
+    .dword 0x748f82ee5defb2fc, 0x78a5636f43172f60
+    .dword 0x84c87814a1f0ab72, 0x8cc702081a6439ec
+    .dword 0x90befffa23631e28, 0xa4506cebde82bde9
+    .dword 0xbef9a3f7b2c67915, 0xc67178f2e372532b
+    .dword 0xca273eceea26619c, 0xd186b8c721c0c207
+    .dword 0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178
+    .dword 0x06f067aa72176fba, 0x0a637dc5a2c898a6
+    .dword 0x113f9804bef90dae, 0x1b710b35131c471b
+    .dword 0x28db77f523047d84, 0x32caab7b40c72493
+    .dword 0x3c9ebe0a15c9bebc, 0x431d67c49c100d4c
+    .dword 0x4cc5d4becb3e42b6, 0x597f299cfc657e2a
+    .dword 0x5fcb6fab3ad6faec, 0x6c44198c4a475817
+.size $K512,.-$K512
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

