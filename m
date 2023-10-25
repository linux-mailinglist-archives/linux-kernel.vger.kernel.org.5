Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC69A7D736A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbjJYSiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjJYSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F226D4E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso5370a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259048; x=1698863848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFhsyXyqq7vflrUvLHWxOLv+JErs0KUA8a4MpjUfb6k=;
        b=Iy0i9U8iuY45MTcsowiH9w/BygERagIoWqpA3o/ALY9Wep+AvQCNMp0SLNyi4MVLIP
         Xs8TXaMoPvwDPfO5YM742+EIE6Nt1NqRAdnOq3/ErwBX3P0xg2WMQxeJg5p34nNRS3iI
         v3hMClCj3Y9ggxE0MItkOekJwBkhk9asIMMYQT8ciz57aos7PAMhBcINabBqoNi+ebYB
         nDXhSwSjn7sLDAMU3+1/Hu48wI+HC3m/AFRt6YiFmGGfitt0SiDB4pVbnS6zLCmD11ca
         VA47odCHTM+Gn5vMsDwN4UUyL4mvC2VjwLJE+dSa5pDrnhp/q79QjSLMR/4H2ACLR/ZS
         NhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259048; x=1698863848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFhsyXyqq7vflrUvLHWxOLv+JErs0KUA8a4MpjUfb6k=;
        b=OvsvZDgywxIwh4CjKBP36Kh2sp25/XhzTgaLnC6on9DPBpeHwwdu2Jkg+50TPlsCfw
         myPftTdxa7eyiFlf8qUarLXJQ8wacBBVBnoOgBuL5eRxWkN3MsnRjNPZqOvo2tgtyuuf
         SnqL0+fo6YS1TdVrTpGCkvOZ8/JSaBi1g1YRwwxjfB5SQAFv9OIUdq9vGmLrXNRb46Mk
         NPV0A5mskg+Du4pzsO65hiO3TcvR2X4UPpMsqd7TcHyb4igh0YtEeeh9InsCaUqAPEF3
         hcMzQ5RIRCNhuxLqczZnOA/2YIntPF2gXBLnx0L4pdKnEA3nRxNXwDZgJbPoBd0taSOM
         KhEg==
X-Gm-Message-State: AOJu0YwyO23OBeNu/5wzRHilDrn4tVhpdjCAwwQhP62zzzH4o4bsaMaB
        /1my1NtdvZ/1sfq4ced3aMwyPg==
X-Google-Smtp-Source: AGHT+IEOlkCWlpWa0D8YyaNcxzwVuxyDQKs6Eh/An49WnNeVSvp6OxIlA5f8xkM1IDNcrtptMmj01g==
X-Received: by 2002:a17:90a:1a15:b0:27d:b22b:fb89 with SMTP id 21-20020a17090a1a1500b0027db22bfb89mr12033741pjk.35.1698259048196;
        Wed, 25 Oct 2023 11:37:28 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:27 -0700 (PDT)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ebiggers@kernel.org, ardb@kernel.org,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 08/12] RISC-V: crypto: add Zvknha/b accelerated SHA224/256 implementations
Date:   Thu, 26 Oct 2023 02:36:40 +0800
Message-Id: <20231025183644.8735-9-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SHA224 and 256 implementations using Zvknha or Zvknhb vector crypto
extensions from OpenSSL(openssl/openssl#21923).

Co-developed-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/crypto/Kconfig                     |  13 +
 arch/riscv/crypto/Makefile                    |   7 +
 arch/riscv/crypto/sha256-riscv64-glue.c       | 140 ++++++++
 .../sha256-riscv64-zvkb-zvknha_or_zvknhb.pl   | 318 ++++++++++++++++++
 4 files changed, 478 insertions(+)
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 00be7177eb1e..dbc86592063a 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -49,4 +49,17 @@ config CRYPTO_GHASH_RISCV64
 	  Architecture: riscv64 using:
 	  - Zvkg vector crypto extension
 
+config CRYPTO_SHA256_RISCV64
+	default y if RISCV_ISA_V
+	tristate "Hash functions: SHA-224 and SHA-256"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_HASH
+	select CRYPTO_SHA256
+	help
+	  SHA-256 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using:
+	  - Zvkb vector crypto extension
+	  - Zvknha or Zvknhb vector crypto extensions
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 532316cc1758..49577fb72cca 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -12,6 +12,9 @@ aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvbb-zvkg-zvkne
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvkb-zvknha_or_zvknhb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -27,7 +30,11 @@ $(obj)/aes-riscv64-zvkb-zvkned.S: $(src)/aes-riscv64-zvkb-zvkned.pl
 $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 	$(call cmd,perlasm)
 
+$(obj)/sha256-riscv64-zvkb-zvknha_or_zvknhb.S: $(src)/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvbb-zvkg-zvkned.S
 clean-files += aes-riscv64-zvkb-zvkned.S
 clean-files += ghash-riscv64-zvkg.S
+clean-files += sha256-riscv64-zvkb-zvknha_or_zvknhb.S
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
new file mode 100644
index 000000000000..35acfb6e4b2d
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-glue.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA256 implementation for RISC-V 64
+ *
+ * Copyright (C) 2022 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha256_base.h>
+
+/*
+ * sha256 using zvkb and zvknha/b vector crypto extension
+ *
+ * This asm function will just take the first 256-bit as the sha256 state from
+ * the pointer to `struct sha256_state`.
+ */
+void sha256_block_data_order_zvkb_zvknha_or_zvknhb(struct sha256_state *digest,
+						   const u8 *data,
+						   int num_blks);
+
+static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	int ret = 0;
+
+	/*
+	 * Make sure struct sha256_state begins directly with the SHA256
+	 * 256-bit internal state, as this is what the asm function expect.
+	 */
+	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		ret = sha256_base_do_update(
+			desc, data, len,
+			sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		kernel_vector_end();
+	} else {
+		ret = crypto_sha256_update(desc, data, len);
+	}
+
+	return ret;
+}
+
+static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
+				unsigned int len, u8 *out)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sha256_base_do_update(
+				desc, data, len,
+				sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		sha256_base_do_finalize(
+			desc, sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		kernel_vector_end();
+
+		return sha256_base_finish(desc, out);
+	}
+
+	return crypto_sha256_finup(desc, data, len, out);
+}
+
+static int riscv64_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha256_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sha256_alg[] = {
+	{
+		.digestsize = SHA256_DIGEST_SIZE,
+		.init = sha256_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.descsize = sizeof(struct sha256_state),
+		.base.cra_name = "sha256",
+		.base.cra_driver_name = "sha256-riscv64-zvkb-zvknha_or_zvknhb",
+		.base.cra_priority = 150,
+		.base.cra_blocksize = SHA256_BLOCK_SIZE,
+		.base.cra_module = THIS_MODULE,
+	},
+	{
+		.digestsize = SHA224_DIGEST_SIZE,
+		.init = sha224_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.descsize = sizeof(struct sha256_state),
+		.base.cra_name = "sha224",
+		.base.cra_driver_name = "sha224-riscv64-zvkb-zvknha_or_zvknhb",
+		.base.cra_priority = 150,
+		.base.cra_blocksize = SHA224_BLOCK_SIZE,
+		.base.cra_module = THIS_MODULE,
+	}
+};
+
+static inline bool check_sha256_ext(void)
+{
+	/*
+	 * From the spec:
+	 * The Zvknhb ext supports both SHA-256 and SHA-512 and Zvknha only
+	 * supports SHA-256.
+	 */
+	return (riscv_isa_extension_available(NULL, ZVKNHA) ||
+		riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	       riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_sha256_mod_init(void)
+{
+	if (check_sha256_ext())
+		return crypto_register_shashes(sha256_alg,
+					       ARRAY_SIZE(sha256_alg));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sha256_mod_fini(void)
+{
+	if (check_sha256_ext())
+		crypto_unregister_shashes(sha256_alg, ARRAY_SIZE(sha256_alg));
+}
+
+module_init(riscv64_sha256_mod_init);
+module_exit(riscv64_sha256_mod_fini);
+
+MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
+MODULE_AUTHOR("Andy Polyakov <appro@openssl.org>");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sha224");
+MODULE_ALIAS_CRYPTO("sha256");
diff --git a/arch/riscv/crypto/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl b/arch/riscv/crypto/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl
new file mode 100644
index 000000000000..51b2d9d4f8f1
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl
@@ -0,0 +1,318 @@
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
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+# - RISC-V Vector SHA-2 Secure Hash extension ('Zvknha' or 'Zvknhb')
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
+.text
+___
+
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+my $K256 = "K256";
+
+# Function arguments
+my ($H, $INP, $LEN, $KT, $H2, $INDEX_PATTERN) = ("a0", "a1", "a2", "a3", "t3", "t4");
+
+sub sha_256_load_constant {
+    my $code=<<___;
+    la $KT, $K256 # Load round constants K256
+    @{[vle32_v $V10, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V11, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V12, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V13, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V14, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V16, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V17, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V18, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V19, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V20, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V21, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V22, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V23, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V24, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V25, $KT]}
+___
+
+    return $code;
+}
+
+################################################################################
+# void sha256_block_data_order_zvkb_zvknha_or_zvknhb(void *c, const void *p, size_t len)
+$code .= <<___;
+.p2align 2
+.globl sha256_block_data_order_zvkb_zvknha_or_zvknhb
+.type   sha256_block_data_order_zvkb_zvknha_or_zvknhb,\@function
+sha256_block_data_order_zvkb_zvknha_or_zvknhb:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[sha_256_load_constant]}
+
+    # H is stored as {a,b,c,d},{e,f,g,h}, but we need {f,e,b,a},{h,g,d,c}
+    # The dst vtype is e32m1 and the index vtype is e8mf4.
+    # We use index-load with the following index pattern at v26.
+    #   i8 index:
+    #     20, 16, 4, 0
+    # Instead of setting the i8 index, we could use a single 32bit
+    # little-endian value to cover the 4xi8 index.
+    #   i32 value:
+    #     0x 00 04 10 14
+    li $INDEX_PATTERN, 0x00041014
+    @{[vsetivli "zero", 1, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_x $V26, $INDEX_PATTERN]}
+
+    addi $H2, $H, 8
+
+    # Use index-load to get {f,e,b,a},{h,g,d,c}
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vluxei8_v $V6, $H, $V26]}
+    @{[vluxei8_v $V7, $H2, $V26]}
+
+    # Setup v0 mask for the vmerge to replace the first word (idx==0) in key-scheduling.
+    # The AVL is 4 in SHA, so we could use a single e8(8 element masking) for masking.
+    @{[vsetivli "zero", 1, "e8", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V0, 0x01]}
+
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+L_round_loop:
+    # Decrement length by 1
+    add $LEN, $LEN, -1
+
+    # Keep the current state as we need it later: H' = H+{a',b',c',...,h'}.
+    @{[vmv_v_v $V30, $V6]}
+    @{[vmv_v_v $V31, $V7]}
+
+    # Load the 512-bits of the message block in v1-v4 and perform
+    # an endian swap on each 4 bytes element.
+    @{[vle32_v $V1, $INP]}
+    @{[vrev8_v $V1, $V1]}
+    add $INP, $INP, 16
+    @{[vle32_v $V2, $INP]}
+    @{[vrev8_v $V2, $V2]}
+    add $INP, $INP, 16
+    @{[vle32_v $V3, $INP]}
+    @{[vrev8_v $V3, $V3]}
+    add $INP, $INP, 16
+    @{[vle32_v $V4, $INP]}
+    @{[vrev8_v $V4, $V4]}
+    add $INP, $INP, 16
+
+    # Quad-round 0 (+0, Wt from oldest to newest in v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V10, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[19:16]
+
+    # Quad-round 1 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V11, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[23:20]
+
+    # Quad-round 2 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V12, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[27:24]
+
+    # Quad-round 3 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V13, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[31:28]
+
+    # Quad-round 4 (+0, v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V14, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[35:32]
+
+    # Quad-round 5 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V15, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[39:36]
+
+    # Quad-round 6 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V16, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[43:40]
+
+    # Quad-round 7 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V17, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[47:44]
+
+    # Quad-round 8 (+0, v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V18, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[51:48]
+
+    # Quad-round 9 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V19, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[55:52]
+
+    # Quad-round 10 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V20, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[59:56]
+
+    # Quad-round 11 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V21, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[63:60]
+
+    # Quad-round 12 (+0, v1->v2->v3->v4)
+    # Note that we stop generating new message schedule words (Wt, v1-13)
+    # as we already generated all the words we end up consuming (i.e., W[63:60]).
+    @{[vadd_vv $V5, $V22, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 13 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V23, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 14 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V24, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 15 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V25, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # H' = H+{a',b',c',...,h'}
+    @{[vadd_vv $V6, $V30, $V6]}
+    @{[vadd_vv $V7, $V31, $V7]}
+    bnez $LEN, L_round_loop
+
+    # Store {f,e,b,a},{h,g,d,c} back to {a,b,c,d},{e,f,g,h}.
+    @{[vsuxei8_v $V6, $H, $V26]}
+    @{[vsuxei8_v $V7, $H2, $V26]}
+
+    ret
+.size sha256_block_data_order_zvkb_zvknha_or_zvknhb,.-sha256_block_data_order_zvkb_zvknha_or_zvknhb
+
+.p2align 2
+.type $K256,\@object
+$K256:
+    .word 0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5
+    .word 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5
+    .word 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3
+    .word 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174
+    .word 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc
+    .word 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da
+    .word 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7
+    .word 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967
+    .word 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13
+    .word 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85
+    .word 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3
+    .word 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070
+    .word 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5
+    .word 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3
+    .word 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208
+    .word 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
+.size $K256,.-$K256
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

