Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C97E00E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKCKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKCKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:22:52 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6DD7;
        Fri,  3 Nov 2023 03:22:48 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 85D3E2071C;
        Fri,  3 Nov 2023 11:22:44 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] USB: dwc3: only call usb_phy_set_suspend in suspend/resume
Date:   Fri,  3 Nov 2023 11:22:36 +0100
Message-Id: <20231103102236.13656-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Currently we have the following two call chains:
dwc3_probe -> dwc3_core_init -> dwc3_phy_init -> usb_phy_init
dwc3_probe -> dwc3_core_init -> dwc3_phy_power_on -> usb_phy_set_suspend

If we look at phy-generic we see the following calls:
usb_gen_phy_init -> regulator_enable
usb_gen_phy_init -> clk_prepare_enable

If we call usb_phy_set_suspend we call the following in phy-generic:
nop_set_suspend -> clk_prepare_enable
and we sent a patch to also call:
nop_set_suspend -> regulator_enable

Because clk_prepare_enable and regulator_enable do reference counting we
increased the reference counter of the clock and regulator to two. If we
want to put the system into suspend we only decrease the reference
counters by one and therefore the clock and regulator stay on.

This change fixes it by not calling usb_phy_set_suspend in
dwc3_phy_power_on but only in dwc3_suspend_common.

Fixes: 8ba007a971bb ("usb: dwc3: core: enable the USB2 and USB3 phy in probe")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/dwc3/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..fae24a9c480d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -770,12 +770,9 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 {
 	int ret;
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err_suspend_usb3_phy;
+		return ret;
 
 	ret = phy_power_on(dwc->usb3_generic_phy);
 	if (ret < 0)
@@ -785,9 +782,6 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
 err_power_off_usb2_phy:
 	phy_power_off(dwc->usb2_generic_phy);
-err_suspend_usb3_phy:
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
 
 	return ret;
 }
@@ -796,9 +790,6 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 {
 	phy_power_off(dwc->usb3_generic_phy);
 	phy_power_off(dwc->usb2_generic_phy);
-
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
 }
 
 static int dwc3_clk_enable(struct dwc3 *dwc)
@@ -2018,6 +2009,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+
 	return 0;
 }
 
@@ -2027,6 +2021,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 	int		ret;
 	u32		reg;
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		ret = dwc3_core_init_for_resume(dwc);
-- 
2.25.1

