Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69FC7FF147
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbjK3OHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjK3OHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:34 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D710F2;
        Thu, 30 Nov 2023 06:07:39 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 084854000C;
        Thu, 30 Nov 2023 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701353258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sPV5HLoRY51KAmBzr1P1nmrX5oNWMM/Fl0J4fOzMcw=;
        b=dmPnnFHnMQC+V9BPhSHgfl5r2gTpn3MzFkurvB/l9sipbC71rbO8QbXABTv5omqPMsZn/N
        EJSGM4gpHL2MrNuLwykHRcEbXZ+vSiCj+XY/+wYHDbjlB10Nj2+cGDRN/MfRzbAmF91vVe
        yM8cXo1QdSfwfybH3eAl2r7+cqWubdG9C5F69dutwmVnjqD8FYQ2w4bsWtbvmgTLVrlkD3
        ElsUmKCHY7lrxDz97XLBOVmB2fhBcEE7xWfkLxXXOj2f7x3Pgv+gJJU7CcAStbQTjBVgIB
        30sgYFK7aj/qbYvTFkVMV8LqMuwuOBLFrG0w22w+g6FxbQkOKTnO9frOnjn35Q==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 30 Nov 2023 15:07:21 +0100
Subject: [PATCH v5 9/9] tty: serial: amba-pl011: factor QDF2400 SoC erratum
 44 out of probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-9-6566703a04b5@bootlin.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index fe910c5f3489..d50e3c14b0e4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2869,6 +2869,22 @@ static int pl011_resume(struct device *dev)
 
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
@@ -2904,13 +2920,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
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
2.43.0

