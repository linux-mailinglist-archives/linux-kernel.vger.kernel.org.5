Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4B7F1953
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjKTRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKTRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:17 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760AD8;
        Mon, 20 Nov 2023 09:06:12 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5666E000F;
        Mon, 20 Nov 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N+JeDCct2n4pgXnrJDil9hLa2D4hq87laHaGCbNG30=;
        b=elgohwiwWAZjxzqdb9A7uBO0ZwHANO1eYP4fdo/kWWYKEUkfmfWsVYsvVXRm1okOGrovnI
        z5ol2gOy7Bb5WApNszNoJLqthfBDIiDrPdxSUlipiqJqaJRQVPrYOTlP96oi5VYddLJc8E
        II3HhYNB1jq39Gnv6Qxh1Y8RP0ftX28Bdvfwbj8R2Jd2aN+aMLldFHwwXB5mzpIY08Kzj5
        5U0jSMEsTHfEfCDvbrD+qY3TjtzCOVMRW/VcBo/6SY8XjGxHFWFteOlkrIpOlerf0CJzLF
        btqfyQGYF/sH44FpSXLniiTdnVcENmVeaV8jSwnnH7A1sdmtGmr64cqHHAUYXg==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 20 Nov 2023 18:06:05 +0100
Subject: [PATCH v2 5/7] usb: cdns3: add quirk to platform data for
 reset-on-resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231120-j7200-usb-suspend-v2-5-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Thomas Petazzoni thomas.petazzoni"@bootlin.com,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cdns3 host role does not care about reset-on-resume. xHCI however
reconfigures itself in silence rather than printing a warning about a
resume error. Related warning example:

  [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit

Allow passing a CDNS3_RESET_ON_RESUME quirk flag from cdns3 pdata down
to xHCI pdata. The goal is to allow signaling about reset-on-resume
behavior from platform wrapper drivers.

When used, remote wakeup is not expected to work.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/core.h | 1 +
 drivers/usb/cdns3/host.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 81a9c9d6be08..7487067ba23f 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_RESET_ON_RESUME		BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 6164fc4c96a4..28c4d1deb231 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -91,6 +91,9 @@ static int __cdns_host_init(struct cdns *cdns)
 	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
 		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
+	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_RESET_ON_RESUME))
+		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME;
+
 	ret = platform_device_add_data(xhci, cdns->xhci_plat_data,
 			sizeof(struct xhci_plat_priv));
 	if (ret)

-- 
2.42.0

