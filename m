Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73877FB620
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbjK1Jnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjK1Jnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:43:37 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7BBE;
        Tue, 28 Nov 2023 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=GjQ22P+oFYyA7vy5m4Ea/60ju9n2QPtg1X1479aEht8=; b=W3O6YEh3bTw4DKC7ZJpbBcYyxv
        2tZrbqjlwRBSgE2O0V1e3GyIqb2yO/2ZNytCSoyjS6hsyLg64u3cx0MCkbgFtpeA2YdZMh70AJ/xO
        3JgVY3HJkLpjy6c2OCM859TWMTzanLEcTi/XiqrGYvcecY6mmcoGns7fY+haIc7sOTYn/5djyGtoo
        opiandhH6j42aDImRc2Qys4osvdAU7TKADQukEwSOdKCKWN1yeiXeYu9u4Dr4aFCdrN3W1tvlq2Af
        t6dGhWSGWQUj5uK0F3tsVUDXTHMJPGvvUPZd5zQOul4nDGhShtnB6DuFWAp6abjkIN9yjWjKNyBRH
        UECpp/Iw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r7ud2-008PbT-17;
        Tue, 28 Nov 2023 10:43:40 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 28 Nov 2023 10:43:33 +0100
Subject: [PATCH 2/2] serial: msm: Use OPP table for DVFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-serial-msm-dvfs-v1-2-4f290d20a4be@kernkonzept.com>
References: <20231128-serial-msm-dvfs-v1-0-4f290d20a4be@kernkonzept.com>
In-Reply-To: <20231128-serial-msm-dvfs-v1-0-4f290d20a4be@kernkonzept.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the OPP table from the device tree and use dev_pm_opp_set_rate()
instead of clk_set_rate() to allow making performance state votes
specified in the OPP table (e.g. for power domains and interconnects).

Without an OPP table in the device tree this will behave just as before
this patch.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/tty/serial/msm_serial.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7fc8f0b16aef..e24204ad35de 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1131,7 +1132,7 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	uart_port_unlock_irqrestore(port, flags);
 
 	entry = msm_find_best_baud(port, baud, &rate);
-	clk_set_rate(msm_port->clk, rate);
+	dev_pm_opp_set_rate(port->dev, rate);
 	baud = rate / 16 / entry->divisor;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1186,6 +1187,7 @@ static void msm_init_clock(struct uart_port *port)
 {
 	struct msm_port *msm_port = to_msm_port(port);
 
+	dev_pm_opp_set_rate(port->dev, port->uartclk);
 	clk_prepare_enable(msm_port->clk);
 	clk_prepare_enable(msm_port->pclk);
 	msm_serial_set_mnd_regs(port);
@@ -1239,6 +1241,7 @@ static int msm_startup(struct uart_port *port)
 
 	clk_disable_unprepare(msm_port->pclk);
 	clk_disable_unprepare(msm_port->clk);
+	dev_pm_opp_set_rate(port->dev, 0);
 
 	return ret;
 }
@@ -1254,6 +1257,7 @@ static void msm_shutdown(struct uart_port *port)
 		msm_release_dma(msm_port);
 
 	clk_disable_unprepare(msm_port->clk);
+	dev_pm_opp_set_rate(port->dev, 0);
 
 	free_irq(port->irq, port);
 }
@@ -1419,11 +1423,13 @@ static void msm_power(struct uart_port *port, unsigned int state,
 
 	switch (state) {
 	case 0:
+		dev_pm_opp_set_rate(port->dev, port->uartclk);
 		clk_prepare_enable(msm_port->clk);
 		clk_prepare_enable(msm_port->pclk);
 		break;
 	case 3:
 		clk_disable_unprepare(msm_port->clk);
+		dev_pm_opp_set_rate(port->dev, 0);
 		clk_disable_unprepare(msm_port->pclk);
 		break;
 	default:
@@ -1789,7 +1795,7 @@ static int msm_serial_probe(struct platform_device *pdev)
 	struct resource *resource;
 	struct uart_port *port;
 	const struct of_device_id *id;
-	int irq, line;
+	int irq, line, ret;
 
 	if (pdev->dev.of_node)
 		line = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -1824,6 +1830,15 @@ static int msm_serial_probe(struct platform_device *pdev)
 			return PTR_ERR(msm_port->pclk);
 	}
 
+	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	if (ret)
+		return ret;
+
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&pdev->dev, ret, "invalid OPP table\n");
+
 	port->uartclk = clk_get_rate(msm_port->clk);
 	dev_info(&pdev->dev, "uartclk = %d\n", port->uartclk);
 

-- 
2.39.2

