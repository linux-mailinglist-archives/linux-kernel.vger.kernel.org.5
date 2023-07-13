Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297D7520DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjGMMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGMMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:12:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87E1FEA;
        Thu, 13 Jul 2023 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689250354; x=1720786354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9j52FthJZNa9Xc0YEIj+5Oie+v4CQc4EqZA27meU8go=;
  b=s6EZEkJ7Jmyh+stjmzUm/Kk2gKHpCKz23rtEh6QEe4OLcF/b5xLAUjNH
   5J7ObTBstkD2c/n7qLI7KLZtHXH4v2kmNtk5E+u4tiJJ9JywyDXZ98KZr
   iwRLP1j13AgthxNm9uDElZeCPIBIBRWl/5PmRgRoTbQ+i6f2OBtEqhlXH
   AXQIOMWNiXZo4nDvBs7kL+55gXRJih7E8l7konqjuVqaohOPgX9Je5CCO
   2AYUK4/X80Z13Ye59rTyu1JnAQqDMoxyv69KANf6lphueNqS7ch9zz3wA
   eZtwNubkpnYef5iu+y3i4zI9KWbZNH0GvNTCsmHGiWFn5izYGyp7llyAv
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="222827123"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 05:12:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 05:12:32 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 05:12:30 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v5 01/11] RISC-V: Provide a more helpful error message on invalid ISA strings
Date:   Thu, 13 Jul 2023 13:10:59 +0100
Message-ID: <20230713-endless-spearhead-62a5a4b149bd@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713-target-much-8ac624e90df8@wendy>
References: <20230713-target-much-8ac624e90df8@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9vL9UTnWKFum0JN16SUa6SYVYB7LNXsYDcHCgjUs78g=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnrX15Z31TaJ2s3lzevTmmnneHM8n8OFz29fLJ2NilFflF6 0dTfUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIk0JjMyTJq7/uiLtIVfulw33u7gdz Y+9vaU1blLHYKHuE7xSXvnTmb4X/TmkU8MT8yU/W7nJs9b/fe2mNCBZYz5vOtP82QxR3kJsAIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Right now we provide a somewhat unhelpful error message on systems with
invalid error messages, something along the lines of

	CPU with hartid=0 is not available
	------------[ cut here ]------------
	kernel BUG at arch/riscv/kernel/smpboot.c:174!
	Kernel BUG [#1]
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00096-ge0097d2c62d5-dirty #1
	Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
	epc : of_parse_and_init_cpus+0x16c/0x16e
	 ra : of_parse_and_init_cpus+0x9a/0x16e
	epc : ffffffff80c04e0a ra : ffffffff80c04d38 sp : ffffffff81603e20
	 gp : ffffffff8182d658 tp : ffffffff81613f80 t0 : 000000000000006e
	 t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffff81603e80
	 s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000000000
	 a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
	 a5 : 0000000000001fff a6 : 0000000000001fff a7 : ffffffff816148b0
	 s2 : 0000000000000001 s3 : ffffffff81492a4c s4 : ffffffff81a4b090
	 s5 : ffffffff81506030 s6 : 0000000000000040 s7 : 0000000000000000
	 s8 : 00000000bfb6f046 s9 : 0000000000000001 s10: 0000000000000000
	 s11: 00000000bf389700 t3 : 0000000000000000 t4 : 0000000000000000
	 t5 : ffffffff824dd188 t6 : ffffffff824dd187
	status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
	[<ffffffff80c04e0a>] of_parse_and_init_cpus+0x16c/0x16e
	[<ffffffff80c04c96>] setup_smp+0x1e/0x26
	[<ffffffff80c03ffe>] setup_arch+0x6e/0xb2
	[<ffffffff80c00384>] start_kernel+0x72/0x400
	Code: 80e7 4a00 a603 0009 b795 1097 ffe5 80e7 92c0 9002 (9002) 715d
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: Fatal exception in interrupt

Add a warning for the cases where the ISA string isn't valid.  It's still
above the BUG_ON cut, but hopefully it's at least a bit easier for users.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..3af2d214ce21 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -66,11 +66,15 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 		return -ENODEV;
 	}
 
-	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32ima", 7))
+	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32ima", 7)) {
+		pr_warn("CPU with hartid=%lu does not support rv32ima", *hart);
 		return -ENODEV;
+	}
 
-	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64ima", 7))
+	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64ima", 7)) {
+		pr_warn("CPU with hartid=%lu does not support rv64ima", *hart);
 		return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.40.1

