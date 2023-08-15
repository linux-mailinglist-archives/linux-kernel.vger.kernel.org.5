Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0377CF22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbjHOP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjHOP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:20 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D4A9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:18 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by laurent.telenet-ops.be with bizsmtp
        id ZrUF2A00845ualL01rUFq5; Tue, 15 Aug 2023 17:28:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qVvxo-000j7s-Sp;
        Tue, 15 Aug 2023 17:28:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qVvxv-005ckC-6V;
        Tue, 15 Aug 2023 17:28:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley Chang <stanley_chang@realtek.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
Date:   Tue, 15 Aug 2023 17:28:13 +0200
Message-Id: <2892527cac9af6fa8f5e7b8daeffd7d4351fde68.1692113167.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek SoC USB2 and USB3 PHY Transceivers are only present on
Realtek Digital Home Center (DHC) RTD series SoCs.  Hence add a
dependency on ARCH_REALTEK, to prevent asking the user about these
drivers when configuring a kernel without Realtek SoC support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/realtek/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig
index 650e20ed69af41d2..75ac7e7c31aec6f2 100644
--- a/drivers/phy/realtek/Kconfig
+++ b/drivers/phy/realtek/Kconfig
@@ -2,6 +2,9 @@
 #
 # Phy drivers for Realtek platforms
 #
+
+if ARCH_REALTEK || COMPILE_TEST
+
 config PHY_RTK_RTD_USB2PHY
 	tristate "Realtek RTD USB2 PHY Transceiver Driver"
 	depends on USB_SUPPORT
@@ -25,3 +28,5 @@ config PHY_RTK_RTD_USB3PHY
 	  The DHC (digital home center) RTD series SoCs used the Synopsys
 	  DWC3 USB IP. This driver will do the PHY initialization
 	  of the parameters.
+
+endif # ARCH_REALTEK || COMPILE_TEST
-- 
2.34.1

