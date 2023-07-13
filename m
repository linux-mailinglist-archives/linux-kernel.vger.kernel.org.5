Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D217520F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjGMMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjGMMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:13:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D32D5D;
        Thu, 13 Jul 2023 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689250386; x=1720786386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+4fXO0Mgsbn0oR0/2jnJO0XttLzGYmDlCcJv+2evZU=;
  b=HfgstqKetTGJcLb9H5JXMXEoXw4R//EZeG35lcnFuPOlsFCrqrzrzrFo
   L7LSODLuv8HbzRfv2cN96IK1wAnWjbeIkFzl3bfKoX2l2rw2qUjyxK/xd
   xC/qWYl/QyGldVnMsFXb6tgc8X9N1pRldZjafCqdOhmwzyV5BCkkJcoSA
   fl/cFtvMqlvT250sjVaVw5Cxsw3k08X9aouNURA+Ux+9PCOSbpNhgsGSC
   m0L4vFDP2Mx1MejghT5LL80emVs31FnEJbOdIrxRxtiWQSSnTgLZiwsBB
   nuT+0taDTxpomQAatKOkrNZk44mqu1CmqOJjHmZaFNikxJKyehjB0n+Bc
   w==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="222827224"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 05:12:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 05:12:59 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 05:12:56 -0700
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/11] RISC-V: try new extension properties in of_early_processor_hartid()
Date:   Thu, 13 Jul 2023 13:11:08 +0100
Message-ID: <20230713-tablet-jimmy-987fea0eb2e1@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713-target-much-8ac624e90df8@wendy>
References: <20230713-target-much-8ac624e90df8@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6+4fXO0Mgsbn0oR0/2jnJO0XttLzGYmDlCcJv+2evZU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnrX153cfflPHBz0UmfZbfXnZ8ederSpwdfJ5Rt15rJHcD1 6BBbZUcpC4MYB4OsmCJL4u2+Fqn1f1x2OPe8hZnDygQyhIGLUwAm4uDC8Icjzz4gRHyrkfuVnMw7Vf Oel83TOVxSNFmipDzYIXfdln2MDJ3LM7UsfU69OnxeLkRzXY6ViE7YW1frzPLMq9c2iWb+4AEA
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

To fully deprecate the kernel's use of "riscv,isa",
of_early_processor_hartid() needs to first try using the new properties,
before falling back to "riscv,isa".

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
- Add some printouts to explain what went wrong while parsing harts,
  so that if none are found there's at least a hint before we hit a
  BUG()
---
 arch/riscv/kernel/cpu.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4f1f12f34b63..28d5af21f544 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -61,8 +61,35 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 		return -ENODEV;
 	}
 
+	if (of_property_read_string(node, "riscv,isa-base", &isa))
+		goto old_interface;
+
+	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32i", 5)) {
+		pr_warn("CPU with hartid=%lu does not support rv32i", *hart);
+		return -ENODEV;
+	}
+
+	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64i", 5)) {
+		pr_warn("CPU with hartid=%lu does not support rv64i", *hart);
+		return -ENODEV;
+	}
+
+	if (!of_property_present(node, "riscv,isa-extensions"))
+		return -ENODEV;
+
+	if (of_property_match_string(node, "riscv,isa-extensions", "i") < 0 ||
+	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0 ||
+	    of_property_match_string(node, "riscv,isa-extensions", "a") < 0) {
+		pr_warn("CPU with hartid=%lu does not support ima", *hart);
+		return -ENODEV;
+	}
+
+	return 0;
+
+old_interface:
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
+		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
+			*hart);
 		return -ENODEV;
 	}
 
-- 
2.40.1

