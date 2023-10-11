Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BD7C578F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJKO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjJKO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:56:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65BCCC;
        Wed, 11 Oct 2023 07:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXpaY1H+dXkNTDhkQvqSTDZq0oQlOzv6XLQavhXJqAplIvi31Jmo23MOgV6mmmpQQa95YOoCLpLJTgQR1efQsVhBXvTtpkUiWRrMDUVXwpmBqLDT01/rr5EOb+kPMy8bwNSc1JG/dCZTgTQVD/XJuDgbamSKIuEOFZXejirqZJMLJH9kc0Jp2zssMuht55wwD2VB/C8t0i1lYETCb0P/pYoZ0tZug68NJRan8hCqmCZTaNXsIUq5fBfoSJLjCXmmc2mFy9dnv3oJoaFNCYPTYafHHkgtIYTI0QhMO51zvmX8wLou5fixAd9SEDcFINB+WB2vekLzK/l6wvn/CBj8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq5cBQQSH7PoaJB0g7H0j+OZDY4Ed8kKEMO/g5BkzFs=;
 b=MPXN9n+ZDj64z0vyvuB3XEiKVdrq4vVLySHLQNsk9NVuxsuznEc8SY6I+sw+EqQYUdbpmjbcBsirLgUpQUBv1F8oVDYScMeCQwBNajo5OVvxDYp++VhX2Ur8crraJ5VsLKPzj1ubDJ1x51ED586PdlFcaS/Ycv6yu+ufBaJMlT9A16fezfWVA2H2P1TwFUf75ZE4TYgp68uveDBcfpAtx9/iQexuP6cf7BbAKuJtnsuhJxPIPzQwM6GGKUw6rWlWAThaCBmIDmLxD/uossTlvuJAp3f+Glo4dGknZA1I0YnWROK2Y3K8a319KOJDqIt9CE9S2qeOmpJHQOL/Q3/Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq5cBQQSH7PoaJB0g7H0j+OZDY4Ed8kKEMO/g5BkzFs=;
 b=zcrzqvWrk1y+9ACz9YG7LnbKCN/nLO47M5Xg7lY3Kex4AL/bFCvWE6RGMWJI68Qcv1UMPoGLxjXDpTVb5CbBCWDitLVKuXr9qiO9oWhn9AWnIYdIcFjGzr5R4cWMRQQGRTWErsrWRlmWwsf8CEVY6Qb6A7vqU3e+bbP+8bWwJ4g=
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Wed, 11 Oct
 2023 14:56:51 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::bb) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Wed, 11 Oct 2023 14:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 14:56:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 09:56:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 09:56:24 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 11 Oct 2023 09:56:20 -0500
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2 2/2] tty: serial: uartps: Add rs485 support to uartps driver
Date:   Wed, 11 Oct 2023 20:26:02 +0530
Message-ID: <20231011145602.3619616-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fe1c8a-e2b2-49f9-0be6-08dbca6a4d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbiCi2tkWslAqYFb4J1Pa1qAD0jtaCGcMq7LxjinHnf5W6BdYUlJYwwsvC75UCxQtx6SEgb3QWWWt7ARhD1wSXtSVanW1xg+O1R/mi3dTiP39HIbwbiKXkEG+JqFe/TdsY/9HT5JSgzhem0CoTXctWTQK8uQv2pYLp9mfiLWAQA0h0sZMgTHg6QzJdIp/bvhp5N2hDFif8clfBjJHyed/Q6BLuHI6aaNHcsbR50ElqkV84Al9q3XLTb1EdYNPrLo8I+/nk/qyiOcFvUZMn+DPOSv0yGXgEjExyW5pLvb3fsUoxsIFsPAasWeVqCjQ5fHBbXXkwflYQED+Q/o1t7E9XmepUJj+42kkvSbiPZxzqFwydQfyRnomfOc16hIwWh7HV4smxFlts+tq7DzoQbu0fIGOWUKtLuhLdqXFs/fgt9xP5GfDhJv68+wAfa6efkJ52pUXEWU+u8w28VCQLXW/laCbeUIf3y2USBEd7+snk51s/xi+eI2dU6L5sOFX0ZtNSzMbqyzFtfyNUXgJm0iyoHYpJJcij+nFArpXXcZvKplgCQExI2NxNZSXfg94GriduvgQXYHC/RScO0eYB11njLyvsn4gtrLnEZvI/4YeeECblncwCi9Ek8PM1WePTqI45n+OD4QRqK7BXpVk9j+3x0X8yZxdQzk9Vt5bENBHMYVZCv64oJLyk4KJqpKFBMir5Iok4Z1xPJKeseM61E/jU3cnJJVQHm8q2p328cuqr/Fv7vEBfcrsIlOJrKQl0S7NGGzTnD0jY+JmXMCe/sPXw1dH2h3jsMOHI3bfV/Zm2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(336012)(26005)(1076003)(82740400003)(2616005)(921005)(356005)(81166007)(36756003)(110136005)(44832011)(8936002)(86362001)(8676002)(54906003)(70206006)(316002)(7416002)(41300700001)(70586007)(4326008)(426003)(6666004)(478600001)(2906002)(5660300002)(83380400001)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:56:51.3647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fe1c8a-e2b2-49f9-0be6-08dbca6a4d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RS485 half duplex configuration, DriverEnable and ReceiverEnable
shorted to each other, and at a time, any node acts as either a driver
or a receiver. Use either xlnx,phy-ctrl-gpios or RTS to control
RS485 phy as driver or a receiver.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.
---
 drivers/tty/serial/xilinx_uartps.c | 116 ++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8e521c69a959..abddcf1a8bf4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
+#include <linux/gpio.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -193,6 +194,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod:		Pointer to the gpio descriptor
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +205,19 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod;
 };
 struct cdns_platform_data {
 	u32 quirks;
 };
+
+struct serial_rs485 cdns_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb)
 
@@ -305,6 +316,42 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_rs485_tx_setup - Tx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod) {
+		gpiod_set_value(cdns_uart->gpiod, 1);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_RTS;
+		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
+	}
+}
+
+/**
+ * cdns_rs485_rx_setup - Rx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod) {
+		gpiod_set_value(cdns_uart->gpiod, 0);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		val |= CDNS_UART_MODEMCR_RTS;
+		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
+	}
+}
+
+static unsigned int cdns_uart_tx_empty(struct uart_port *port);
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -313,12 +360,20 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long time_out;
 	unsigned int numbytes;
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		cdns_rs485_tx_setup(cdns_uart);
+		if (cdns_uart->port->rs485.delay_rts_before_send)
+			mdelay(cdns_uart->port->rs485.delay_rts_before_send);
+	}
+
 	if (uart_circ_empty(xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
-		return;
+		goto rs485_rx_setup;
 	}
 
 	numbytes = port->fifosize;
@@ -332,6 +387,23 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+rs485_rx_setup:
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+		/* Wait for tx completion */
+		while ((cdns_uart_tx_empty(cdns_uart->port) != TIOCSER_TEMT) &&
+		       time_before(jiffies, time_out))
+			cpu_relax();
+
+		/*
+		 * Default Rx should be setup, because RX signaling path
+		 * need to enable to receive data.
+		 */
+		cdns_rs485_rx_setup(cdns_uart);
+		if (cdns_uart->port->rs485.delay_rts_after_send)
+			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
+	}
 }
 
 /**
@@ -829,6 +901,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -1455,6 +1530,25 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 /* Temporary variable for storing number of instances */
 static int instances;
 
+/**
+ * cdns_rs485_config - Called when an application calls TIOCSRS485 ioctl.
+ * @port: Pointer to the uart_port structure
+ * @termios: Pointer to the ktermios structure
+ * @rs485: Pointer to the serial_rs485 structure
+ *
+ * Return: 0
+ */
+static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
+			     struct serial_rs485 *rs485)
+{
+	port->rs485 = *rs485;
+
+	if (rs485->flags & SER_RS485_ENABLED)
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1597,9 +1691,28 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->private_data = cdns_uart_data;
 	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
 			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
+	port->rs485_config = cdns_rs485_config;
+	port->rs485_supported = cdns_rs485_supported;
 	cdns_uart_data->port = port;
 	platform_set_drvdata(pdev, port);
 
+	rc = uart_get_rs485_mode(port);
+	if (rc)
+		goto err_out_clk_notifier;
+
+	cdns_uart_data->gpiod = devm_gpiod_get_optional(&pdev->dev, "xlnx,phy-ctrl",
+							GPIOD_OUT_LOW);
+	if (IS_ERR(cdns_uart_data->gpiod)) {
+		rc = PTR_ERR(cdns_uart_data->gpiod);
+		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
+		goto err_out_clk_notifier;
+	}
+
+	if (cdns_uart_data->gpiod) {
+		gpiod_direction_output(cdns_uart_data->gpiod, GPIOD_OUT_LOW);
+		gpiod_set_value(cdns_uart_data->gpiod, 0);
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
@@ -1646,6 +1759,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1

