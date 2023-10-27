Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E137D9825
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjJ0MaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0MaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:30:10 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4891BE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:30:05 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A27522077F;
        Fri, 27 Oct 2023 14:30:00 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] usb: phy: generic: add suspend support for regulator
Date:   Fri, 27 Oct 2023 14:29:55 +0200
Message-Id: <20231027122955.22123-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Disable the vcc regulator on suspend and enable it on resume.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/phy/phy-generic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 770081b828a4..9ab50f26db60 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -46,15 +46,21 @@ EXPORT_SYMBOL_GPL(usb_phy_generic_unregister);
 static int nop_set_suspend(struct usb_phy *x, int suspend)
 {
 	struct usb_phy_generic *nop = dev_get_drvdata(x->dev);
+	int ret = 0;
 
-	if (!IS_ERR(nop->clk)) {
-		if (suspend)
+	if (suspend) {
+		if (!IS_ERR(nop->clk))
 			clk_disable_unprepare(nop->clk);
-		else
+		if (!IS_ERR(nop->vcc) && !device_may_wakeup(x->dev))
+			ret = regulator_disable(nop->vcc);
+	} else {
+		if (!IS_ERR(nop->vcc) && !device_may_wakeup(x->dev))
+			ret = regulator_enable(nop->vcc);
+		if (!IS_ERR(nop->clk))
 			clk_prepare_enable(nop->clk);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void nop_reset(struct usb_phy_generic *nop)
-- 
2.25.1

