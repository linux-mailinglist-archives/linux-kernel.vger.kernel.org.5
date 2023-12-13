Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A011811247
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379107AbjLMNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379156AbjLMNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8310A;
        Wed, 13 Dec 2023 05:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmNRtL+dBEh9ZTtnmZEGMvXJt5qrP/wttLS97izRe5pd1cSGNOjDdsWTxDzhqJv4JfdonaM3DGdO/isTrwNJLiillAdVRkNdE7yCO5Zm2To+xXQCVv8b6k3dCQAsCMlfRR3v6N5GpbmFcvfiz0JcmndkevaLGaQMemjLJeiBkXVj4Agul7X451UVO+8Jzkruuax98d2QyaIUrNRU3eqiYqgvwlnINM+PP34TNiQdXp/QxQuJSsMcTRKvIzoBtC6HSEh8+GUnjgf0veDhyGSCneAPy1AniUSsXVeeGys86d6JrAHTcDyrdMfe82cfBDLDceKcsPxN3fC8eIPzZtZDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfipSkX2ShXVH2nLxMrS4KxI3KEEX1macjPlZrRk+rs=;
 b=JGb41g+44l8wukCFQj0m9kQW7EgXq6ZznBDmaZUNtt7OOXW+fEzqkko3u57MP3yt2dx4N+dQVsxuKqvyUra24Ow/pz+jTPMyWQYP6XcqnJjL28auQ34JE57SQhwyhhV2G4OYqGxx+QyVuwdSVrtBxAeWDJjOfJRZ4qvShfu9sp5Als4fO7YipY+rBcc0jHZ4MqEKPkHKk6D2ClP0nOEoL70gp066tWlyv+0Q1DnrP6R6Ods34XBq0VfErAz8jhXF36OuSn0L5/T2QFPJgB56SfWusaN1MfcaPnZ3pIV5F3oLrRo8SgyDDiNT5T7R68H+EkAPBOx5t8Mxvfm+e76ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfipSkX2ShXVH2nLxMrS4KxI3KEEX1macjPlZrRk+rs=;
 b=4/4JaJIv4lJtUF3sJaUlsfJCQVFyrAxAX4ljI0ebxZwxgMbKZikYTNuoLuAq+zsPTXp4yLdWUIaJLdcY3MhRN/GUKfDITVOrhJUUzNq0UppqpXIPm/ozKsFDD4ZzCHYGnDJjD1CQM44XXi4/xhTpLTc5DjDfK/V+1DYzmvx+McU=
Received: from CY5PR15CA0225.namprd15.prod.outlook.com (2603:10b6:930:88::26)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 13:00:48 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::ea) by CY5PR15CA0225.outlook.office365.com
 (2603:10b6:930:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:00:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:00:46 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:00:42 -0600
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
Subject: [PATCH V5 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date:   Wed, 13 Dec 2023 18:30:23 +0530
Message-ID: <20231213130023.606486-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: a530651e-1f2d-4e48-00fa-08dbfbdb86b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3w/iD92pMfky6vAsH3lIslIajPFsDarxMlO5EB9ujseVcYZo9Wi7E8dDBpUe7ckqgf0irgRvQ/lRIB6Nyw1u7SF5RPN6kPmxj2R+0nBi3BT9Zwz+s86e7KkoxijPek4ofnHuuyqTme5N47/pAnZClM4qKH4RNg0lukOUOM+5kpB/jB6OF2t0iiwhkpamijK4k7JIla2xEj8nYyrPMx3B3xdKqIUFGIFAerZBrJQmQ4m4pfEf4tPdzm5x4MxA+RGAYDyb+LJZxG649ZomGr44GUMOojMN+pmze1YoNIm+u3FY7EiPwPmOf9tYRcGRaFNS2G5B+N1a3cBmoa36aqpn0/z9gDuUsqCrJ98FmkEFhzNRwDBUpGz0i2L242byVTG3jn5Krvg8GwmzI5u/GSbV9yGVEuh/u9Az+M6gpVsQF3EcNaHSuN3nIfR4ib7ftihq/gAObc+16x6R37apyC+k5hAmL7ijMHUbw9qQ1Nw7A//xGJVUFhdrbeB5u1MATYMPFo3nu5pOxv2aaf7GQtJa+6amfBDedO5i1zg3CLUUh6/zChC4UxNQFBLxB5eP/bu5ePq7EO3g0Kk2phjqgX55DVGxIRhW2C04/wF4RplR4pIpJgZtcqfnuuEWE8gfXwoLAQ1OeJmob2Gq+FppLcdMoOrmNkwYXXo/wMdsYUMwpNAXD1URuSLmbBkwTyV1scz9mDtHzEa6pio4iGEpcmF5B0K9/4q52HNt32RPcz/eRwpOhyKaKtmRR28Yq5UzYVmhAlAoyh4SmZu978bqJgXAadRBZ4c6OJSdXTY4t8VarWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(426003)(40460700003)(336012)(83380400001)(26005)(1076003)(2616005)(36860700001)(44832011)(47076005)(8936002)(5660300002)(4326008)(41300700001)(7416002)(2906002)(8676002)(6666004)(316002)(30864003)(478600001)(54906003)(70206006)(110136005)(70586007)(36756003)(86362001)(356005)(81166007)(921008)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:00:47.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a530651e-1f2d-4e48-00fa-08dbfbdb86b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rs485 support to uartps driver. Use either rts-gpios or RTS
to control RS485 phy as driver or a receiver.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.
Move cdns_uart_tx_empty function to avoid prototype statement.
Remove assignment of struct serial_rs485 to port->rs485 as
serial core performs that.
Switch to native RTS in non GPIO case.
Handle rs485 during stop tx.
Remove explicit calls to configure gpio direction and value,
as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument.
Update implementation to support configuration of GPIO/RTS value
based on user configuration of SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx.

Changes for V4:
Create separate patch for cdns_uart_tx_empty relocation.
Call cdns_rs485_rx_setup() before uart_add_one_port() in probe.
Update gpio descriptor name to gpiod_rts.
Instead of cdns_rs485_config_gpio_rts_high() and
cdns_rs485_config_gpio_rts_low() functions for RTS/GPIO value
configuration implement cdns_rts_gpio_enable().
Disable auto rts and call cdns_uart_stop_tx() from cdns_rs485_config.
Use timer instead of mdelay for delay_rts_before_send and delay_rts_after_send.
Update cdns_uart_set_mctrl to support GPIO/RTS.

Changes for V5:
None.
---
 drivers/tty/serial/xilinx_uartps.c | 214 +++++++++++++++++++++++++++--
 1 file changed, 205 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index aafcc2179e0e..3e1045896812 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -22,7 +22,9 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
-#include <linux/iopoll.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -193,6 +195,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod_rts:		Pointer to the gpio descriptor
+ * @rs485_tx_started:	RS485 tx state
+ * @timer:		Timer for tx and rx
+ * @stop_tx_timer:	Timer for stop tx
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +209,22 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod_rts;
+	bool			rs485_tx_started;
+	struct timer_list	timer;
+	struct timer_list	stop_tx_timer;
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
 
@@ -305,6 +323,55 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_rts_gpio_enable - Configure RTS/GPIO to high/low
+ * @cdns_uart: Handle to the cdns_uart
+ * @enable: Value to be set to RTS/GPIO
+ */
+static void cdns_rts_gpio_enable(struct cdns_uart *cdns_uart, bool enable)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod_rts) {
+		gpiod_set_value(cdns_uart->gpiod_rts, enable);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		if (enable)
+			val &= ~CDNS_UART_MODEMCR_RTS;
+		else
+			val |= CDNS_UART_MODEMCR_RTS;
+		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
+	}
+}
+
+/**
+ * cdns_rs485_tx_setup - Tx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
+{
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
+		cdns_rts_gpio_enable(cdns_uart, 1);
+	else
+		cdns_rts_gpio_enable(cdns_uart, 0);
+
+	cdns_uart->rs485_tx_started = true;
+}
+
+/**
+ * cdns_rs485_rx_setup - Rx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
+{
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		cdns_rts_gpio_enable(cdns_uart, 1);
+	else
+		cdns_rts_gpio_enable(cdns_uart, 0);
+
+	cdns_uart->rs485_tx_started = false;
+}
+
 /**
  * cdns_uart_tx_empty -  Check whether TX is empty
  * @port: Handle to the uart port structure
@@ -579,6 +646,42 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 }
 #endif
 
+/**
+ * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_rx_callback(struct timer_list *t)
+{
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
+
+	/*
+	 * Default Rx should be setup, because Rx signaling path
+	 * need to enable to receive data.
+	 */
+	cdns_rs485_rx_setup(cdns_uart);
+}
+
+/**
+ * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_tx_callback(struct timer_list *t)
+{
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
+
+	cdns_uart_handle_tx(cdns_uart->port);
+
+	/* Enable the TX Empty interrupt */
+	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
+
+	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
+	    uart_tx_stopped(cdns_uart->port)) {
+		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);
+		mod_timer(&cdns_uart->timer, jiffies +
+			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
+	}
+}
+
 /**
  * cdns_uart_start_tx -  Start transmitting bytes
  * @port: Handle to the uart port structure
@@ -586,6 +689,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -604,10 +708,40 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
-	cdns_uart_handle_tx(port);
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart->rs485_tx_started) {
+			timer_setup(&cdns_uart->timer,
+				    cdns_rs485_tx_callback, 0);
+			cdns_rs485_tx_setup(cdns_uart);
+			mod_timer(&cdns_uart->timer, jiffies +
+				  msecs_to_jiffies(port->rs485.delay_rts_before_send));
+		} else {
+			if (!timer_pending(&cdns_uart->timer))
+				mod_timer(&cdns_uart->timer, jiffies);
+		}
+	} else {
+		cdns_uart_handle_tx(port);
 
-	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
+		/* Enable the TX Empty interrupt */
+		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
+	}
+}
+
+/**
+ * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_stop_tx_callback(struct timer_list *t)
+{
+	unsigned int regval;
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, stop_tx_timer);
+
+	cdns_rs485_rx_setup(cdns_uart);
+
+	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
+	regval |= CDNS_UART_CR_TX_DIS;
+	/* Disable the transmitter */
+	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
 }
 
 /**
@@ -617,11 +751,19 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
 
-	regval = readl(port->membase + CDNS_UART_CR);
-	regval |= CDNS_UART_CR_TX_DIS;
-	/* Disable the transmitter */
-	writel(regval, port->membase + CDNS_UART_CR);
+	if ((cdns_uart->port->rs485.flags & SER_RS485_ENABLED) &&
+	    !timer_pending(&cdns_uart->stop_tx_timer) &&
+	    cdns_uart->rs485_tx_started) {
+		mod_timer(&cdns_uart->stop_tx_timer, jiffies +
+			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
+	} else {
+		regval = readl(port->membase + CDNS_UART_CR);
+		regval |= CDNS_UART_CR_TX_DIS;
+		/* Disable the transmitter */
+		writel(regval, port->membase + CDNS_UART_CR);
+	}
 }
 
 /**
@@ -829,6 +971,12 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		timer_setup(&cdns_uart->stop_tx_timer,
+			    cdns_rs485_stop_tx_callback, 0);
+		cdns_rs485_rx_setup(cdns_uart);
+	}
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -888,6 +1036,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -903,6 +1052,11 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		del_timer_sync(&cdns_uart->timer);
+		del_timer_sync(&cdns_uart->stop_tx_timer);
+	}
 }
 
 /**
@@ -1032,7 +1186,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
 	if (mctrl & TIOCM_RTS)
-		val |= CDNS_UART_MODEMCR_RTS;
+		cdns_rts_gpio_enable(cdns_uart_data, 1);
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
@@ -1455,6 +1609,31 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
+	u32 val;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+		/* Make sure auto RTS is disabled */
+		val = readl(port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_FCM;
+		writel(val, port->membase + CDNS_UART_MODEMCR);
+		/* Disable transmitter and make Rx setup*/
+		cdns_uart_stop_tx(port);
+	}
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1597,9 +1776,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
+	cdns_uart_data->gpiod_rts = devm_gpiod_get_optional(&pdev->dev, "rts",
+							    GPIOD_OUT_LOW);
+	if (IS_ERR(cdns_uart_data->gpiod_rts)) {
+		rc = PTR_ERR(cdns_uart_data->gpiod_rts);
+		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
+		goto err_out_clk_notifier;
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
@@ -1618,6 +1811,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 	}
 #endif
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1646,6 +1841,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1

