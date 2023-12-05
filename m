Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5721804DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjLEJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:06 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9AEB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce7632b032so122223b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768491; x=1702373291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rd23HIXPBgaDZXDkAseprGzRxEcVlS8PTF1LuBNK6w=;
        b=O4v4g3/XFo9JrU9ThqqlkTMfiH3RoqPJRJFWwRbGAJVUCRqaGBkOcbFHOpCFtgJNkP
         TCJd4PNOAjihsoeVXMzf0SRwOU+Z0NlcYepojqcNKw/hP6lWNp6XunJ89+PxQwq0Gwg8
         /URm7TR5m+BI0otuDaNDtZ8Sha4gKUQOV0K/nWgijXMS7I4zrfzsDG3XhNZnry73aHlN
         5M6lQar9XZj6hZMzEsce5XmdiES4wbvjRt0KDiqhw6QFJLsYlhoABFBmkiLItdJZdvfq
         qtwEAeUpNSjCM8GEWtAjERAMVmmAykkbPwynZOdEUJF5OTAExsWJwvLeB9eUdP0PLTLj
         sTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768491; x=1702373291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rd23HIXPBgaDZXDkAseprGzRxEcVlS8PTF1LuBNK6w=;
        b=VQ8RBHvsJAV0L74AyQNFBZxkVMI2c0t4oDAgnK8NGyENLhMe5KVto2NBxwHmzNRhYp
         NoiJRgeOZ/Yj1qUZ4zIT7NiMr7+FI58/RAZ4MuZ9wX0GVHithZ8fvjh9P1pWPgVgZ64t
         /Qz3jS0gxsp0Kmza7VjkA63nrWqp9wa73fGyITd++2pNqSy4aka49q84u1yiWmkvI2P0
         bQRV1+9+xozaLrtZqKSAY7cNEV1CPBrMGuRdmAwE8jVBaCjms5khQNPMCp6pwy2dRnkJ
         5NKiXU9Q/VN/OPS0V2XeIa9J55bRBd2p8CRR/NWgTJztwOlxAoL5gyA6tQvIuw5W7WgM
         8djQ==
X-Gm-Message-State: AOJu0Yz598+u6x6a4G5JCQsbgpbmGe6CsT7MIWqB0q9cGitX8Ohqrmoa
        PwrBlEuyDEqmA5DfhISQg3xMLQ==
X-Google-Smtp-Source: AGHT+IGX9BU16EUDKN3tl27q4H6gQY3VtfhkcX3BtLmMlpF+zcQOQIDBf/8sDBqQ20W/x6+iBuO48Q==
X-Received: by 2002:a05:6a00:400a:b0:6ce:720d:8d3f with SMTP id by10-20020a056a00400a00b006ce720d8d3fmr230306pfb.32.1701768491585;
        Tue, 05 Dec 2023 01:28:11 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:11 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography implementations using vector extensions
Date:   Tue,  5 Dec 2023 17:27:49 +0800
Message-Id: <20231205092801.1335-1-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
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

From: Jerry Shih <bignose1007@gmail.com>

This series provides cryptographic implementations using the vector crypto
extensions[1] including:
1. AES cipher
2. AES with CBC/CTR/ECB/XTS block modes
3. ChaCha20 stream cipher
4. GHASH for GCM
5. SHA-224/256 and SHA-384/512 hash
6. SM3 hash
7. SM4 cipher

This patch set is based on Heiko Stuebner's work at:
Link: https://lore.kernel.org/all/20230711153743.1970625-1-heiko@sntech.de/

The implementations reuse the perl-asm scripts from OpenSSL[2] with some
changes adapting for the kernel crypto framework.
The perl-asm scripts generate the RISC-V RVV 1.0 instructions and the
opcodes of the vector crypto instructions into `.S` files. We will replace
the vector crypto opcodes with asm mnemonics in the future. It needs lots
of extensions checking for toolchains.

All changes pass the kernel run-time crypto self tests and the extra tests
with vector-crypto-enabled qemu.
Link: https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00281.html

This series depend on:
1. kernel 6.6-rc7
Link: https://github.com/torvalds/linux/commit/05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
2. support kernel-mode vector
Link: https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/
3. vector crypto extensions detection
Link: https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@rivosinc.com/
4. fix the error message:
    alg: skcipher: skipping comparison tests for xts-aes-aesni because
    xts(ecb(aes-generic)) is unavailable
Link: https://lore.kernel.org/linux-crypto/20231009023116.266210-1-ebiggers@kernel.org/

Here is a branch on github applying with all dependent patches:
Link: https://github.com/JerryShih/linux/tree/dev/jerrys/vector-crypto-upstream-v3

[1]
Link: https://github.com/riscv/riscv-crypto/blob/56ed7952d13eb5bdff92e2b522404668952f416d/doc/vector/riscv-crypto-spec-vector.adoc
[2]
Link: https://github.com/openssl/openssl/pull/21923

Updated patches (on current order): 3, 4, 6, 7, 8, 9, 10, 11, 12
New patch: -
Unchanged patch: 1, 2, 5
Deleted patch: 6 in v2

Changelog v3:
 - Use asm mnemonics for the instructions in RVV 1.0 extension.
 - Use `SYM_TYPED_FUNC_START` for indirect-call asm symbols.
 - Update aes xts_crypt() implementation.
 - Update crypto function names with the prefix/suffix of `riscv64` or the
   specific extensions to avoid the collision with functions in `crypto/`
   or `lib/crypto/`.

Changelog v2:
 - Do not turn on the RISC-V accelerated crypto kconfig options by
   default.
 - Assume RISC-V vector extension could support unaligned access in
   kernel.
 - Turn to use simd skcipher interface for AES-CBC/CTR/ECB/XTS and
   Chacha20.
 - Rename crypto file and driver names to make the most important
   extension at first place.

Heiko Stuebner (2):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: hook new crypto subdir into build-system

Jerry Shih (10):
  RISC-V: crypto: add OpenSSL perl module for vector instructions
  RISC-V: crypto: add Zvkned accelerated AES implementation
  crypto: simd - Update `walksize` in simd skcipher
  RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvknha/b accelerated SHA224/256 implementations
  RISC-V: crypto: add Zvknhb accelerated SHA384/512 implementations
  RISC-V: crypto: add Zvksed accelerated SM4 implementation
  RISC-V: crypto: add Zvksh accelerated SM3 implementation
  RISC-V: crypto: add Zvkb accelerated ChaCha20 implementation

 arch/riscv/Kbuild                             |    1 +
 arch/riscv/crypto/Kconfig                     |  110 ++
 arch/riscv/crypto/Makefile                    |   68 +
 .../crypto/aes-riscv64-block-mode-glue.c      |  494 +++++++
 arch/riscv/crypto/aes-riscv64-glue.c          |  137 ++
 arch/riscv/crypto/aes-riscv64-glue.h          |   18 +
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.pl    |  949 +++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl  |  415 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl       | 1199 +++++++++++++++++
 arch/riscv/crypto/chacha-riscv64-glue.c       |  122 ++
 arch/riscv/crypto/chacha-riscv64-zvkb.pl      |  321 +++++
 arch/riscv/crypto/ghash-riscv64-glue.c        |  175 +++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl       |  100 ++
 arch/riscv/crypto/riscv.pm                    |  359 +++++
 arch/riscv/crypto/sha256-riscv64-glue.c       |  145 ++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.pl   |  317 +++++
 arch/riscv/crypto/sha512-riscv64-glue.c       |  139 ++
 .../crypto/sha512-riscv64-zvknhb-zvkb.pl      |  265 ++++
 arch/riscv/crypto/sm3-riscv64-glue.c          |  124 ++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl        |  227 ++++
 arch/riscv/crypto/sm4-riscv64-glue.c          |  121 ++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl       |  268 ++++
 arch/riscv/include/asm/vector.h               |   11 +
 crypto/Kconfig                                |    3 +
 crypto/cryptd.c                               |    1 +
 crypto/simd.c                                 |    1 +
 26 files changed, 6090 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/riscv.pm
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl

--
2.28.0

