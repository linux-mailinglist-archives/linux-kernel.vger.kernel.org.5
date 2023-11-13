Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC067E9E99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKMO1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKMO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:07 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA4D6E;
        Mon, 13 Nov 2023 06:27:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F36D91C0006;
        Mon, 13 Nov 2023 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699885622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnUtq32WECjfa76r/drw3nv80tgUh5X0WPjXLzFlw28=;
        b=dkrLrBm0G6WnQIfo4v7EkNmhc1fxeqZv1l6opb3gjHwULojiv5p/NaJkGUcgKv6etaoTPi
        0ADc6WeA4CdTabdx64+7Gy6f75FiUnUNQLtLQseNQx/zupfA/EeObKE/1sR3HGVLTDLlHM
        Z7kk8kfQ1SjxnzJwKIPBztWSCscdZ887WmLlRhjPQw8cKbTzt9uJ1yImGdhxThhyNu2gcI
        mNkXD5ji2f8B+Vz9TPGfvS9qEzz+GHVuLlueiKEMLpXbzezYnSKIVFa21m+qkzSOiKy7Ic
        4YXN4WaS+eim3Llkje2kUE2pwefMyWZL7qdftfkh4ktna5b+quJLChPti4S6Ew==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 13 Nov 2023 15:26:59 +0100
Subject: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
In-Reply-To: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
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
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller is not being reconfigured at resume. Change resume to
redo hardware config if quirk CDNS3_RESET_ON_RESUME is active.

Platform data comes from the parent driver (eg cdns3-ti).

The quirk should be passed if the platform driver knows that the
controller might be in reset state at resume. We do NOT reconfigure the
hardware without this quirk to avoid losing state if we did a suspend
without reset.

If the quirk is on, we notify the xHCI subsystem that:

1. We reset on resume. It will therefore redo the xHC init & trigger
   such message as "root hub lost power or was reset" in dmesg.

2. It should disable/enable clocks on suspend/resume. This does not
   matter on our platform as xhci-plat does not get access to any clock
   but it would be the right thing to do if we indeed had such clocks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/core.h |  1 +
 drivers/usb/cdns3/host.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 6164fc4c96a4..a81019a7c8cc 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -88,6 +88,9 @@ static int __cdns_host_init(struct cdns *cdns)
 		goto err1;
 	}
 
+	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
+		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS;
+
 	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
 		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
@@ -124,6 +127,18 @@ static void cdns_host_exit(struct cdns *cdns)
 	cdns_drd_host_off(cdns);
 }
 
+static int cdns_host_suspend(struct cdns *cdns, bool do_wakeup)
+{
+	if (!do_wakeup)
+		cdns_drd_host_off(cdns);
+	return 0;
+}
+
+static int cdns_host_resume(struct cdns *cdns, bool hibernated)
+{
+	return cdns_drd_host_on(cdns);
+}
+
 int cdns_host_init(struct cdns *cdns)
 {
 	struct cdns_role_driver *rdrv;
@@ -137,6 +152,11 @@ int cdns_host_init(struct cdns *cdns)
 	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
 	rdrv->name	= "host";
 
+	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME) {
+		rdrv->suspend = cdns_host_suspend;
+		rdrv->resume = cdns_host_resume;
+	}
+
 	cdns->roles[USB_ROLE_HOST] = rdrv;
 
 	return 0;

-- 
2.41.0

