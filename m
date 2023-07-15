Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8A7545F3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGOBEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGOBE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:27 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5373AAD;
        Fri, 14 Jul 2023 18:04:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657800"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:25 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C4D6140C4DA2;
        Sat, 15 Jul 2023 10:04:22 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 03/10] spi: rzv2m-csi: Rework CSI_CKS_MAX definition
Date:   Sat, 15 Jul 2023 02:04:00 +0100
Message-Id: <20230715010407.1751715-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate
the serial clock (output from master), with CSI_CLKSEL_CKS ranging from
0x1 (that means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided
by 32766). CSI_CKS_MAX is used for referring to the setting
corresponding to the maximum frequency divider.
Value 0x3FFF for CSI_CKS_MAX doesn't really means much to the reader
without an explanation and a more readable definition.

Add a comment with a meaningful description and also replace value
0x3FFF with the corresponding GENMASK, to make it very clear what the
macro means.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 3931045a85eb..621774949bde 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -65,7 +65,12 @@
 #define CSI_FIFO_SIZE_BYTES	32
 #define CSI_FIFO_HALF_SIZE	16
 #define CSI_EN_DIS_TIMEOUT_US	100
-#define CSI_CKS_MAX		0x3FFF
+/*
+ * Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate the
+ * serial clock (output from master), with CSI_CLKSEL_CKS ranging from 0x1 (that
+ * means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided by 32766).
+ */
+#define CSI_CKS_MAX		GENMASK(13, 0)
 
 #define UNDERRUN_ERROR		BIT(0)
 #define OVERFLOW_ERROR		BIT(1)
-- 
2.34.1

