Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453367E8EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjKLGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjKLGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:18:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7B4EC5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5733CC433CD;
        Sun, 12 Nov 2023 06:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769874;
        bh=i54fNqJU7sp4UXlnwp+YcKfJLY+fhfGViunXjtd8s+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYK86b7k9E9ZF7LvDQjIBzOpnNCn2Tujmh+DY478+1v491siLxIcYO0XXQgtr9EVD
         YkEwCIQ4bhW7o/fcNbcZb/CyIbKvZVeIM0ZLvKgqSNz4mE/hbpOofOpaq6KIteEm2E
         NDE1JUNUwoUxAErCY+HvrykIdHI4hC1y1H7uBvjC/mftXKkKthQD4PY0PVlpMSh0Fm
         cBcLqp+5nzEVrOpEydk2FAcQcTNNnk1nFA7kKzCu1WTF+KacRCT6G0Lar9mOQr9EnD
         l8PhPryyGvgqTaJ/BJl4gFTdKbC3Ci7jYtE4dnIr6q2i9ZItvDNaYcZH7K7ew3DzqS
         7DQjQWfnd13tQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 24/38] riscv: s64ilp32: Add TImode (128 int) support
Date:   Sun, 12 Nov 2023 01:15:00 -0500
Message-Id: <20231112061514.2306187-25-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The s64ilp32 uses 64bit compiler, so it could support “Tetra
Integer” mode, which represents a sixteen-byte (128) integer.

It's the first 32BIT linux support TImode :)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig      | 1 +
 arch/riscv/lib/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0fc03aa076e6..a45e31ef3b2c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -339,6 +339,7 @@ config ARCH_RV64I
 config ARCH_RV64ILP32
 	bool "RV64ILP32"
 	depends on NONPORTABLE
+	select ARCH_SUPPORTS_INT128 if !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0)
 	select 32BIT
 	select MMU
 	select VDSO64ILP32
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..68af463795e1 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -9,5 +9,6 @@ lib-y			+= strncmp.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
+lib-$(CONFIG_ARCH_RV64ILP32) += tishift.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-- 
2.36.1

