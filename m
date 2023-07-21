Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBF75C3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGUJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGUJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:59:38 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133B30D4;
        Fri, 21 Jul 2023 02:59:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 80D8924E28E;
        Fri, 21 Jul 2023 17:59:26 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:59:26 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:59:25 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1] usb: cdns3: Add PHY mode switch to usb2 PHY
Date:   Fri, 21 Jul 2023 17:59:23 +0800
Message-ID: <20230721095923.20445-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns3 just set PHY mode switch for USB3.0 PHY.
If USB 2.0 PHY contains PHY mode switch setting,
USB 2.0 PHY mode function can't be called.
So add PHY mode switch function for USB 2.0 PHY.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/drd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index d00ff98dffab..04b6d12f2b9a 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -196,6 +196,7 @@ int cdns_drd_host_on(struct cdns *cdns)
 	if (ret)
 		dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
 
+	phy_set_mode(cdns->usb2_phy, PHY_MODE_USB_HOST);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_HOST);
 	return ret;
 }
@@ -216,6 +217,7 @@ void cdns_drd_host_off(struct cdns *cdns)
 	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
 				  !(val & OTGSTATE_HOST_STATE_MASK),
 				  1, 2000000);
+	phy_set_mode(cdns->usb2_phy, PHY_MODE_INVALID);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
 }
 
@@ -248,6 +250,7 @@ int cdns_drd_gadget_on(struct cdns *cdns)
 		return ret;
 	}
 
+	phy_set_mode(cdns->usb2_phy, PHY_MODE_USB_DEVICE);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
 	return 0;
 }
@@ -273,6 +276,7 @@ void cdns_drd_gadget_off(struct cdns *cdns)
 	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
 				  !(val & OTGSTATE_DEV_STATE_MASK),
 				  1, 2000000);
+	phy_set_mode(cdns->usb2_phy, PHY_MODE_INVALID);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
 }
 EXPORT_SYMBOL_GPL(cdns_drd_gadget_off);
-- 
2.17.1

