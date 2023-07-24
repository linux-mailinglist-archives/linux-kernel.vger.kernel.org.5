Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5280E75E845
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGXBjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjGXBir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95784211;
        Sun, 23 Jul 2023 18:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE90E60FB0;
        Mon, 24 Jul 2023 01:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A887C433CA;
        Mon, 24 Jul 2023 01:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162320;
        bh=l18T6ih/66Lpfqaa0yvhU+MebvBYFEkaazQXomWseq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJxyyQkG4/Hbbx8PjJgS0OSgpUu2nGMUtwkm2yfrRKQTpcZ0i+h0+S2hctMZNM6vU
         9uOa2exrMeEnjCh0xzGvOjhYiAFd/WKLhpDOVFFwsZw85KDrW5QrBoHso2gqjEnhAl
         6QuEHEc2PNE7kUBw5LhGdhQYTJRfHxeY+v+0DXsdnbXfkua7vcEzvxT/Tce7Os425D
         QKSFHTGRAFhZwVGWKBBjF4u4c5VVi4Rhh9RXMDBBi+4TuZ2mnD6KV6qicq7KMv8QBE
         iyNGKvMN9yWPnLyQ/7tlvaldNhBlYUkFNRgy/ZFaSkgv/BcJnAcHbKQMU5Lklj/KIf
         rUrM1jqDUMGcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Li Jun <jun.li@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 13/40] usb: chipidea: imx: turn off vbus comparator when suspend
Date:   Sun, 23 Jul 2023 21:31:13 -0400
Message-Id: <20230724013140.2327815-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 0ac37fbdad7087bbcbbe246a602c248ccfd954ea ]

As we use bvalid for vbus wakeup source, to save power when
suspend, turn off the vbus comparator for imx7d and imx8mm.

Below is this bit description from RM of iMX8MM
"VBUS Valid Comparator Enable:

This signal controls the USB OTG PHY VBUS Valid comparator which
indicates whether the voltage on the USB_OTG*_VBUS pin is below
the VBUS Valid threshold. The VBUS Valid threshold is nominally
4.75V on this USB PHY. The VBUS Valid threshold can be adjusted
using the USBNC_OTGn_PHY_CFG1[OTGTUNE0] bit field. Status of the
VBUS Valid comparator, when it is enabled, is reported on the
USBNC_OTGn_PHY_STATUS[VBUS_VLD] bit.
When OTGDISABLE0 (USBNC_USB_OTGx_PHY_CFG2[10])is set to 1'b0 and
DRVVBUS0 is set to 1'b1, the Bandgap circuitry and VBUS Valid
comparator are powered, even in Suspend or Sleep mode.
DRVVBUS0 should be reset to 1'b0 when the internal VBUS Valid comparator
is not required, to reduce quiescent current in Suspend or Sleep mode.
 - 0 The VBUS Valid comparator is disabled
  - 1 The VBUS Valid comparator is enabled"

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Message-ID: <20230517081907.3410465-2-xu.yang_2@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index c57c1a71a5132..0938e274ba3a8 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -152,6 +152,7 @@ struct usbmisc_ops {
 	int (*charger_detection)(struct imx_usbmisc_data *data);
 	/* It's called when system resume from usb power lost */
 	int (*power_lost_check)(struct imx_usbmisc_data *data);
+	void (*vbus_comparator_on)(struct imx_usbmisc_data *data, bool on);
 };
 
 struct imx_usbmisc {
@@ -875,6 +876,33 @@ static int imx7d_charger_detection(struct imx_usbmisc_data *data)
 	return ret;
 }
 
+static void usbmisc_imx7d_vbus_comparator_on(struct imx_usbmisc_data *data,
+					     bool on)
+{
+	unsigned long flags;
+	struct imx_usbmisc *usbmisc = dev_get_drvdata(data->dev);
+	u32 val;
+
+	if (data->hsic)
+		return;
+
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	/*
+	 * Disable VBUS valid comparator when in suspend mode,
+	 * when OTG is disabled and DRVVBUS0 is asserted case
+	 * the Bandgap circuitry and VBUS Valid comparator are
+	 * still powered, even in Suspend or Sleep mode.
+	 */
+	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	if (on)
+		val |= MX7D_USB_OTG_PHY_CFG2_DRVVBUS0;
+	else
+		val &= ~MX7D_USB_OTG_PHY_CFG2_DRVVBUS0;
+
+	writel(val, usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+}
+
 static int usbmisc_imx7ulp_init(struct imx_usbmisc_data *data)
 {
 	struct imx_usbmisc *usbmisc = dev_get_drvdata(data->dev);
@@ -1018,6 +1046,7 @@ static const struct usbmisc_ops imx7d_usbmisc_ops = {
 	.set_wakeup = usbmisc_imx7d_set_wakeup,
 	.charger_detection = imx7d_charger_detection,
 	.power_lost_check = usbmisc_imx7d_power_lost_check,
+	.vbus_comparator_on = usbmisc_imx7d_vbus_comparator_on,
 };
 
 static const struct usbmisc_ops imx7ulp_usbmisc_ops = {
@@ -1132,6 +1161,9 @@ int imx_usbmisc_suspend(struct imx_usbmisc_data *data, bool wakeup)
 
 	usbmisc = dev_get_drvdata(data->dev);
 
+	if (usbmisc->ops->vbus_comparator_on)
+		usbmisc->ops->vbus_comparator_on(data, false);
+
 	if (wakeup && usbmisc->ops->set_wakeup)
 		ret = usbmisc->ops->set_wakeup(data, true);
 	if (ret) {
@@ -1185,6 +1217,9 @@ int imx_usbmisc_resume(struct imx_usbmisc_data *data, bool wakeup)
 		goto hsic_set_clk_fail;
 	}
 
+	if (usbmisc->ops->vbus_comparator_on)
+		usbmisc->ops->vbus_comparator_on(data, true);
+
 	return 0;
 
 hsic_set_clk_fail:
-- 
2.39.2

