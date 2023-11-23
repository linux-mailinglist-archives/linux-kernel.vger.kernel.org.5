Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139917F6099
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjKWNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345564AbjKWNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:43 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78CD49;
        Thu, 23 Nov 2023 05:42:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58A5D20007;
        Thu, 23 Nov 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVBDCS1NTDb3ab3cFjXMUr783QzZPSiK8Mrwk5FgGVk=;
        b=NRAK1wIgVmhdjMNjKWvEyu+zXOcx+/cQ7TRdPSsMRujvRiMpre+IHWlYH70bj1OWEgfWuf
        LX7cwaRXkncLiZLjfknzSmBQMlgBjoS7RlPWuqtR24GKk2rxnCTa2YPtyjNjnQLgVKBsDy
        UP4p14COSaKs8f98niq3z+XvevTn1a7/PPguFX7hoBsoTKVjn5F6tN0DHuDd96J6ax1HX9
        mkIS25+RS6I973GJVb2bDd+tyrIwqoASaTc3HB6mOr2r+qOHBWqug+w5gLJs6rA4VcGRMY
        G43ylCTHCeq/R9IAtcnY8fdbtzouQE09xgUB89woDmAd+/iqUlEjZwTOhjizOA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 23 Nov 2023 14:42:44 +0100
Subject: [PATCH v4 6/6] tty: serial: amba-pl011: factor QDF2400 SoC erratum
 44 out of probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-mbly-uart-v4-6-7f913a74ff89@bootlin.com>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this platform, different vendor data is used. That requires a
compile-time check as we access (1) a global boolean & (2) our local
vendor data. Both symbols are accessible only when
CONFIG_ACPI_SPCR_TABLE is enabled.

Factor the vendor data overriding to a separate function that is empty
when CONFIG_ACPI_SPCR_TABLE is not defined.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4185d6fd243b..f42f4a94c239 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2874,6 +2874,22 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{
+	if (!qdf2400_e44_present)
+		return;
+
+	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
+	uap->vendor = &vendor_qdt_qdf2400_e44;
+}
+#else
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{ /* empty */ }
+#endif
+
 static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
@@ -2909,13 +2925,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return ret;
 	uap->port.irq	= ret;
 
-#ifdef CONFIG_ACPI_SPCR_TABLE
-	if (qdf2400_e44_present) {
-		dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
-		uap->vendor = &vendor_qdt_qdf2400_e44;
-	} else
-#endif
-		uap->vendor = &vendor_sbsa;
+	uap->vendor = &vendor_sbsa;
+	qpdf2400_erratum44_workaround(&pdev->dev, uap);
 
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;

-- 
2.42.0

