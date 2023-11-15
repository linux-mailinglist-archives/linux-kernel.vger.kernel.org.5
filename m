Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5457EC3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjKONbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbjKONbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:31:43 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928AA1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:31:40 -0800 (PST)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 28D2141931;
        Wed, 15 Nov 2023 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700055098;
        bh=XwKM1F4f+w/q5mNwykREvbpkU3Yv+IFVmQo+ZNBoOAM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=HvmmC4WVKC7O3shLJjN5g8UvEDDBuDvWnEKZcKmLF3lJmf5bT1yQ1odFlv8bKnFZk
         um1GAljq/pK1B/oYV0G19jOW0ZP4jr5hIdmc7iifGVY/3THEiZDztDR8x+pwe6oN35
         H1Pw2OLrUKbbjDDw8Sl+hdTwBVIz9NvkwUnPKra9ILtGx15w2iQq8cYxl7aYBpuGVi
         sSz5CNKE16cTtPxSPyNFxDtCRSEiFgNb3lGjTod4mTOpmhRCnX5RoyjjQNz2D0LD4K
         Z0YnyZ+TKnTjTn/M2cu1mdNtGp0qWAYDzEC14NtYEIkGrdKhtDkKbKSllWUaL8jkWl
         xpVTYZSdzpCrQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tty/serial: RISC-V SBI earlycon via DBCN extension
Date:   Wed, 15 Nov 2023 14:31:27 +0100
Message-Id: <20231115133127.107575-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up to now an SBI based early console was limited to SBI version 0.1.
With the DBCN SBI extension we can provide an early console on systems that
have a recent SBI implementation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/sbi.c    | 14 ++++++++++++++
 drivers/tty/serial/Kconfig |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5a62ed1da453..6e1644a95bb7 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -195,6 +195,20 @@ static void sbi_set_power_off(void)
 	pm_power_off = sbi_shutdown;
 }
 #else
+
+/**
+ * sbi_console_putchar() - Writes given character to the console device.
+ * @ch: The data to be written to the console.
+ *
+ * Return: None
+ */
+void sbi_console_putchar(int ch)
+{
+	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
+		  ch, 0, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_console_putchar);
+
 static void __sbi_set_timer_v01(uint64_t stime_value)
 {
 	pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..454c2a612389 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -87,7 +87,6 @@ config SERIAL_EARLYCON_SEMIHOST
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
-	depends on RISCV_SBI_V01
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-- 
2.40.1

