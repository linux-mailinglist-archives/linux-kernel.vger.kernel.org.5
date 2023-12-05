Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B8804DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjLEJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjLEJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4D10C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:37 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5be30d543c4so2022980a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768516; x=1702373316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqgLdIh7ZFE1gYel11FicvzVIx+QwNFkbGHDaWfBExY=;
        b=Ey9WceovH49bjHFMTOwUGvcCuVxYE8f+h17eKA2scnzxW7X0XredgNdBalfvjO0ldD
         xTYAXs46DwIgoFX5I0x+qTnUbG9XHKXiCuzygZALwC4qIo9Rh0m/iwRXzbujPyC5HVQD
         NmJM58uW44pmSm3pjrs2hUibDVqJ1hYb3/OPtIQxEAWHsftJy+mAtyjhppOWKKHPicDX
         SkpD8c9dsN+JieRShsRhlRO7DoA81sfgywO2oyTdllvPEWds29fcEO/IXfDPN+y54W5S
         7iZdFQnCsfv2iCX2gVRyqzsIjg3bv8Prmzrmshmd5mGVJIw1i87nN6+94hYJcEz/Z1sh
         oGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768516; x=1702373316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqgLdIh7ZFE1gYel11FicvzVIx+QwNFkbGHDaWfBExY=;
        b=SDbM1P9XWyNDtdL5iMvPPjYBukjgFU0eImw82VhYBUgyY6pinIA8PlJlLXVPVSTprd
         2tqq1my8CbKb7pVpZf9EDMUgxRaFiyEE8/6lQmj8tek7U7epsQ9v2aYo3NqyE5rZA0is
         E7apA9fz/uldNVMAWaUUgHH5KfC+NmVbogn1vCxsLA0qPvasixItUSK+FxgJ0d59ejL4
         JNZ+C9BftfpQduXnJOUt7Y2pLOV72PR64bwwnFWQWjc1yds8O+GSrxmT17DlM+jwVF94
         8hsPaOhpcEh14LOX7XBuLSrhQIsmtvWlf+vSZbltr5OOcP8azm6YAygJDGiIXf3nmT7E
         w4tg==
X-Gm-Message-State: AOJu0Yxrp1wPq49+N05cntOKzao5BwmF/KMduFZav4R2Ys29tleTdW0Q
        +/iRfBlUXOiMJwXSj68gHzub9Q==
X-Google-Smtp-Source: AGHT+IFq0drciTkZXIld809/gA8+vG+lQq4S7/UbBc5Z5Plazz8vtmMWy6JN/F/D8ld5FPtdHnAdww==
X-Received: by 2002:a05:6a20:c906:b0:187:a4df:4e57 with SMTP id gx6-20020a056a20c90600b00187a4df4e57mr4180155pzb.20.1701768516597;
        Tue, 05 Dec 2023 01:28:36 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:36 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 07/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
Date:   Tue,  5 Dec 2023 17:27:56 +0800
Message-Id: <20231205092801.1335-8-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a gcm hash implementation using the Zvkg extension from OpenSSL
(openssl/openssl#21923).

The perlasm here is different from the original implementation in OpenSSL.
The OpenSSL assumes that the H is stored in little-endian. Thus, it needs
to convert the H to big-endian for Zvkg instructions. In kernel, we have
the big-endian H directly. There is no need for endian conversion.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v3:
 - Use asm mnemonics for the instructions in RVV 1.0 extension.

Changelog v2:
 - Do not turn on kconfig `GHASH_RISCV64` option by default.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Update the ghash fallback path in ghash_blocks().
 - Rename structure riscv64_ghash_context to riscv64_ghash_tfm_ctx.
 - Fold ghash_update_zvkg() and ghash_final_zvkg().
 - Reorder structure riscv64_ghash_alg_zvkg members initialization in the
   order declared.
---
 arch/riscv/crypto/Kconfig               |  10 ++
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/ghash-riscv64-glue.c  | 175 ++++++++++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl | 100 ++++++++++++++
 4 files changed, 292 insertions(+)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 9d991ddda289..6863f01a2ab0 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -34,4 +34,14 @@ config CRYPTO_AES_BLOCK_RISCV64
 	  - Zvkb vector crypto extension (CTR/XTS)
 	  - Zvkg vector crypto extension (XTS)
 
+config CRYPTO_GHASH_RISCV64
+	tristate "Hash functions: GHASH"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_GCM
+	help
+	  GCM GHASH function (NIST SP 800-38D)
+
+	  Architecture: riscv64 using:
+	  - Zvkg vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 9574b009762f..94a7f8eaa8a7 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,6 +9,9 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
+obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
+ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -21,6 +24,10 @@ $(obj)/aes-riscv64-zvkned-zvbb-zvkg.S: $(src)/aes-riscv64-zvkned-zvbb-zvkg.pl
 $(obj)/aes-riscv64-zvkned-zvkb.S: $(src)/aes-riscv64-zvkned-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
+clean-files += ghash-riscv64-zvkg.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
new file mode 100644
index 000000000000..b01ab5714677
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V optimized GHASH routines
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
+#include <crypto/ghash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/* ghash using zvkg vector crypto extension */
+asmlinkage void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp,
+				     size_t len);
+
+struct riscv64_ghash_tfm_ctx {
+	be128 key;
+};
+
+struct riscv64_ghash_desc_ctx {
+	be128 shash;
+	u8 buffer[GHASH_BLOCK_SIZE];
+	u32 bytes;
+};
+
+static inline void ghash_blocks(const struct riscv64_ghash_tfm_ctx *tctx,
+				struct riscv64_ghash_desc_ctx *dctx,
+				const u8 *src, size_t srclen)
+{
+	/* The srclen is nonzero and a multiple of 16. */
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		gcm_ghash_rv64i_zvkg(&dctx->shash, &tctx->key, src, srclen);
+		kernel_vector_end();
+	} else {
+		do {
+			crypto_xor((u8 *)&dctx->shash, src, GHASH_BLOCK_SIZE);
+			gf128mul_lle(&dctx->shash, &tctx->key);
+			srclen -= GHASH_BLOCK_SIZE;
+			src += GHASH_BLOCK_SIZE;
+		} while (srclen);
+	}
+}
+
+static int ghash_init(struct shash_desc *desc)
+{
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	*dctx = (struct riscv64_ghash_desc_ctx){};
+
+	return 0;
+}
+
+static int ghash_update_zvkg(struct shash_desc *desc, const u8 *src,
+			     unsigned int srclen)
+{
+	size_t len;
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (dctx->bytes) {
+		if (dctx->bytes + srclen < GHASH_BLOCK_SIZE) {
+			memcpy(dctx->buffer + dctx->bytes, src, srclen);
+			dctx->bytes += srclen;
+			return 0;
+		}
+		memcpy(dctx->buffer + dctx->bytes, src,
+		       GHASH_BLOCK_SIZE - dctx->bytes);
+
+		ghash_blocks(tctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE);
+
+		src += GHASH_BLOCK_SIZE - dctx->bytes;
+		srclen -= GHASH_BLOCK_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_BLOCK_SIZE - 1);
+
+	if (len) {
+		ghash_blocks(tctx, dctx, src, len);
+		src += len;
+		srclen -= len;
+	}
+
+	if (srclen) {
+		memcpy(dctx->buffer, src, srclen);
+		dctx->bytes = srclen;
+	}
+
+	return 0;
+}
+
+static int ghash_final_zvkg(struct shash_desc *desc, u8 *out)
+{
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+	int i;
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
+			dctx->buffer[i] = 0;
+
+		ghash_blocks(tctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE);
+	}
+
+	memcpy(out, &dctx->shash, GHASH_DIGEST_SIZE);
+
+	return 0;
+}
+
+static int ghash_setkey(struct crypto_shash *tfm, const u8 *key,
+			unsigned int keylen)
+{
+	struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen != GHASH_BLOCK_SIZE)
+		return -EINVAL;
+
+	memcpy(&tctx->key, key, GHASH_BLOCK_SIZE);
+
+	return 0;
+}
+
+static struct shash_alg riscv64_ghash_alg_zvkg = {
+	.init = ghash_init,
+	.update = ghash_update_zvkg,
+	.final = ghash_final_zvkg,
+	.setkey = ghash_setkey,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx),
+	.digestsize = GHASH_DIGEST_SIZE,
+	.base = {
+		.cra_blocksize = GHASH_BLOCK_SIZE,
+		.cra_ctxsize = sizeof(struct riscv64_ghash_tfm_ctx),
+		.cra_priority = 303,
+		.cra_name = "ghash",
+		.cra_driver_name = "ghash-riscv64-zvkg",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static inline bool check_ghash_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKG) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_ghash_mod_init(void)
+{
+	if (check_ghash_ext())
+		return crypto_register_shash(&riscv64_ghash_alg_zvkg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_ghash_mod_fini(void)
+{
+	crypto_unregister_shash(&riscv64_ghash_alg_zvkg);
+}
+
+module_init(riscv64_ghash_mod_init);
+module_exit(riscv64_ghash_mod_fini);
+
+MODULE_DESCRIPTION("GCM GHASH (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.pl b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
new file mode 100644
index 000000000000..a414d77554d2
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
@@ -0,0 +1,100 @@
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
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
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
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector GCM/GMAC extension ('Zvkg')
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
+###############################################################################
+# void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp, size_t len)
+#
+# input: Xi: current hash value
+#        H: hash key
+#        inp: pointer to input data
+#        len: length of input data in bytes (multiple of block size)
+# output: Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$H,$inp,$len) = ("a0","a1","a2","a3");
+my ($vXi,$vH,$vinp,$Vzero) = ("v1","v2","v3","v4");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zvkg
+.type gcm_ghash_rv64i_zvkg,\@function
+gcm_ghash_rv64i_zvkg:
+    vsetivli zero, 4, e32, m1, ta, ma
+    vle32.v $vH, ($H)
+    vle32.v $vXi, ($Xi)
+
+Lstep:
+    vle32.v $vinp, ($inp)
+    add $inp, $inp, 16
+    add $len, $len, -16
+    @{[vghsh_vv $vXi, $vH, $vinp]}
+    bnez $len, Lstep
+
+    vse32.v $vXi, ($Xi)
+    ret
+
+.size gcm_ghash_rv64i_zvkg,.-gcm_ghash_rv64i_zvkg
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

