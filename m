Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA02797669
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjIGQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbjIGQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C515211C;
        Thu,  7 Sep 2023 09:01:04 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4B3F58050;
        Thu,  7 Sep 2023 05:54:52 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dhruva Gole <d-gole@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up
Date:   Thu,  7 Sep 2023 08:54:41 +0300
Message-ID: <20230907055441.19476-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uarts should be tagged with SYSC_QUIRK_SWSUP_SIDLE instead of
SYSC_QUIRK_SWSUP_SIDLE_ACT. The difference is that SYSC_QUIRK_SWSUP_SIDLE
is used to force idle target modules rather than block idle during usage.

The SYSC_QUIRK_SWSUP_SIDLE_ACT should disable autoidle and wake-up when
a target module is active, and configure autoidle and wake-up when a
target module is inactive. We are missing configuring the target module
on sysc_disable_module(), and missing toggling of the wake-up bit.

Let's fix the issue to allow uart wake-up to work.

Fixes: fb685f1c190e ("bus: ti-sysc: Handle swsup idle mode quirks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1097,6 +1097,11 @@ static int sysc_enable_module(struct device *dev)
 	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
 				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
 		best_mode = SYSC_IDLE_NO;
+
+		/* Clear WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg &= ~BIT(regbits->enwkup_shift);
 	} else {
 		best_mode = fls(ddata->cfg.sidlemodes) - 1;
 		if (best_mode > SYSC_IDLE_MASK) {
@@ -1224,6 +1229,13 @@ static int sysc_disable_module(struct device *dev)
 		}
 	}
 
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT) {
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
+	}
+
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
 	if (regbits->autoidle_shift >= 0 &&
@@ -1518,16 +1530,16 @@ struct sysc_revision_quirk {
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
-- 
2.41.0
