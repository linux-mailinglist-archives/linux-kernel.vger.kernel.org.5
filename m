Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC57D735A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJYShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjJYSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:36:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E45DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:36:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-584a761b301so71167a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259015; x=1698863815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MeoxSvV9LV2U+gpMh6CC2wXStEN6WTZDI/w5L7HPlVc=;
        b=d69maL/8QW+dkKV5fM+y9P9f/aFJHeoBonfDoUS9BeL0bblCh6gNheYaG7m4lZszJh
         O14KGc8cV71WRc31Hu9JjP8dhMnn+DtoUKbOUUg6h+BMCecQen8iWSsKO6UnnBc7V7mN
         rwW0/QIxddv4wYH7emaO6bjYU4xYPUY2irEcrr/DdlbnC5gjFBAlT+8Y1xQa2W+L/VGC
         OiilhfzKsu3lIo2zBccgILsM0f6rmj8clBfy0Dm/FFfWtLKh7jxzpQ58T5s+uUcZovg4
         yyOJXCpv4p56MYHvhx2ge/jRP+ewdTo6tAV8vN6WS1D7ak7nvO9M4RJEL5iwk5HQl8Lj
         U7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259015; x=1698863815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeoxSvV9LV2U+gpMh6CC2wXStEN6WTZDI/w5L7HPlVc=;
        b=mH4LLskMfae7qCvACLeHk/PdUpAdn04BH/a/XeDNv7yTqCHae37uAmunyn0kjJtjhh
         Fa+v0nF9IXS8OAQ5JlvAmdpIRZqsDTmZg1dpPi5WqOmSxJ74Fj+O2S4RRDSlDGPHtZNC
         03K9SdVOKznyCrLpCysaJRUAsczPijPvnS0wydbqim+7gWDfwZ81EZdCvLjVzA7ReNzx
         K8rLv6Zz2lSzKMBfjDptDfidtsJYI35ON23+8gj/svvRRMVNw7v557QIhbb9mdD/d1Zn
         eDem5AaQ47CiLs1vhIYHqXDdfyP3QjYFIrC2EGu1jBWHbElwKXb66hvmvIqh0/ngQKDs
         qjww==
X-Gm-Message-State: AOJu0YyaTBxOSTsvPBz3tvZ9yGYhxzZNwy8D/LIpvZRRLoDUxYVaZcS7
        DLftsUpv/SbwNiuHck3CLCRcRw==
X-Google-Smtp-Source: AGHT+IFfd/y0Uqk6Sja7NmgNAKBqvxI3L0l/mRT4fBC9syHwD+hKKysPTBLuWSSVBYm0Fq+qEbn5ZA==
X-Received: by 2002:a17:90a:7066:b0:27d:4d98:6812 with SMTP id f93-20020a17090a706600b0027d4d986812mr16981848pjk.38.1698259015482;
        Wed, 25 Oct 2023 11:36:55 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:36:54 -0700 (PDT)
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
Subject: [PATCH 00/12] RISC-V: provide some accelerated cryptography implementations using vector extensions
Date:   Thu, 26 Oct 2023 02:36:32 +0800
Message-Id: <20231025183644.8735-1-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
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
The perl-asm scripts generate the opcodes into `.S` files instead of asm
mnemonics. The reason for using opcodes is because the assembler hasn't
supported the vector-crypto extensions yet.

All changes pass the kernel run-time crypto self tests and the extra tests
with vector-crypto-enabled qemu.
Link: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg08822.html

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
Link: https://github.com/JerryShih/linux/tree/dev/jerrys/vector-crypto-upstream

[1]
Link: https://github.com/riscv/riscv-crypto/blob/56ed7952d13eb5bdff92e2b522404668952f416d/doc/vector/riscv-crypto-spec-vector.adoc
[2]
Link: https://github.com/openssl/openssl/pull/21923

Heiko Stuebner (2):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: hook new crypto subdir into build-system

Jerry Shih (10):
  RISC-V: crypto: add OpenSSL perl module for vector instructions
  RISC-V: crypto: add Zvkned accelerated AES implementation
  crypto: scatterwalk - Add scatterwalk_next() to get the next
    scatterlist in scatter_walk
  RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvknha/b accelerated SHA224/256 implementations
  RISC-V: crypto: add Zvknhb accelerated SHA384/512 implementations
  RISC-V: crypto: add Zvksed accelerated SM4 implementation
  RISC-V: crypto: add Zvksh accelerated SM3 implementation
  RISC-V: crypto: add Zvkb accelerated ChaCha20 implementation

 arch/riscv/Kbuild                             |    1 +
 arch/riscv/crypto/Kconfig                     |  122 ++
 arch/riscv/crypto/Makefile                    |   68 +
 .../crypto/aes-riscv64-block-mode-glue.c      |  486 +++++++
 arch/riscv/crypto/aes-riscv64-glue.c          |  163 +++
 arch/riscv/crypto/aes-riscv64-glue.h          |   28 +
 .../crypto/aes-riscv64-zvbb-zvkg-zvkned.pl    |  944 +++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkb-zvkned.pl  |  416 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl       | 1198 +++++++++++++++++
 arch/riscv/crypto/chacha-riscv64-glue.c       |  120 ++
 arch/riscv/crypto/chacha-riscv64-zvkb.pl      |  322 +++++
 arch/riscv/crypto/ghash-riscv64-glue.c        |  191 +++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl       |  100 ++
 arch/riscv/crypto/riscv.pm                    |  828 ++++++++++++
 arch/riscv/crypto/sha256-riscv64-glue.c       |  140 ++
 .../sha256-riscv64-zvkb-zvknha_or_zvknhb.pl   |  318 +++++
 arch/riscv/crypto/sha512-riscv64-glue.c       |  133 ++
 .../crypto/sha512-riscv64-zvkb-zvknhb.pl      |  266 ++++
 arch/riscv/crypto/sm3-riscv64-glue.c          |  121 ++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl        |  230 ++++
 arch/riscv/crypto/sm4-riscv64-glue.c          |  120 ++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl       |  268 ++++
 arch/riscv/include/asm/vector.h               |   11 +
 crypto/Kconfig                                |    3 +
 include/crypto/scatterwalk.h                  |    9 +-
 25 files changed, 6604 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvbb-zvkg-zvkned.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkb-zvkned.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/riscv.pm
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvkb-zvknha_or_zvknhb.pl
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvkb-zvknhb.pl
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl

--
2.28.0

