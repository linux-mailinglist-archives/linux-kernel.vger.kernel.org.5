Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE2179D076
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjILL5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjILL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:57:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B610D0;
        Tue, 12 Sep 2023 04:57:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1FC433C8;
        Tue, 12 Sep 2023 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694519862;
        bh=VHyiwl+Hwh6t7EN/GwQGLxr4lMrIG6rMBB4761ubg3k=;
        h=From:To:Cc:Subject:Date:From;
        b=aN/nxvG0zabDFDOHbb1qLdZ+vM/ZOP6rqkV/6vjJURcJLhYMWxD33rjkPu3s19PIR
         13hLYBe8HXXdEj2u2b2Wl25bY7fldAThGf7ehaGORo/nflRUxCzQ/7WLbKGaKFUg5s
         qOyXj8VvjQGvVFKLA4DV6pheW13M/SQqAfZenmpe/uXzK+/w7geY5hDm2xJlDWVgC7
         HPiNPgTUvgBO4prGSMpuo58Gfs8+2sel6YbOBm3inzybGSrPdvREcBTynrMXxIXyL/
         gAWgTlMeVKgBVb2NLgj4VojA725MgTvbxRdYziRSdxTKxcSsT7U/+LRRLsp+Smftw3
         eJnedR//4hnYw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
Date:   Tue, 12 Sep 2023 13:57:22 +0200
Message-Id: <20230912115728.172982-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Hi,

This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
AVX-512-to-RISC-V translation patch appended.

I've tagged it as RFC, since Andy's series is still not in-tree yet.

It's a first step towards a Vector aided Wireguard! ;-)


Cheers,
Björn

[1] https://lore.kernel.org/linux-riscv/20230721112855.1006-1-andy.chiu@sifive.com/

Andy Chiu (3):
  riscv: sched: defer restoring Vector context for user
  riscv: vector: do not pass task_struct into
    riscv_v_vstate_{save,restore}()
  riscv: vector: allow kernel-mode Vector with preemption

Björn Töpel (1):
  riscv: Add BLAKE2s V implementation

Greentime Hu (2):
  riscv: Add support for kernel mode vector
  riscv: Add vector extension XOR implementation

 arch/riscv/Kbuild                      |   2 +-
 arch/riscv/Kconfig                     |  10 ++
 arch/riscv/crypto/Kconfig              |  16 +++
 arch/riscv/crypto/Makefile             |   6 +
 arch/riscv/crypto/blake2s-glue.c       |  39 ++++++
 arch/riscv/crypto/blake2s-v.S          | 164 +++++++++++++++++++++++++
 arch/riscv/include/asm/entry-common.h  |  13 ++
 arch/riscv/include/asm/processor.h     |   2 +
 arch/riscv/include/asm/simd.h          |  52 ++++++++
 arch/riscv/include/asm/thread_info.h   |   6 +
 arch/riscv/include/asm/vector.h        |  50 ++++++--
 arch/riscv/include/asm/xor.h           |  82 +++++++++++++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/asm-offsets.c        |   2 +
 arch/riscv/kernel/entry.S              |  45 +++++++
 arch/riscv/kernel/kernel_mode_vector.c | 146 ++++++++++++++++++++++
 arch/riscv/kernel/process.c            |  10 +-
 arch/riscv/kernel/ptrace.c             |   2 +-
 arch/riscv/kernel/signal.c             |   4 +-
 arch/riscv/kernel/vector.c             |   5 +-
 arch/riscv/lib/Makefile                |   1 +
 arch/riscv/lib/xor.S                   |  81 ++++++++++++
 crypto/Kconfig                         |   3 +
 drivers/net/Kconfig                    |   1 +
 24 files changed, 725 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/blake2s-glue.c
 create mode 100644 arch/riscv/crypto/blake2s-v.S
 create mode 100644 arch/riscv/include/asm/simd.h
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/lib/xor.S


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.39.2

