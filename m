Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814480C40F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjLKJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjLKJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:12:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B210C;
        Mon, 11 Dec 2023 01:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4F2jtw5ndVaS6hC6rnqpKa4292ALB3l4urhShtf536vWQ0QyUxyYagY454r4hw3YMJ82OnXc+K1U1LdnH12eH5zToawaZ9fctbZfiIs5k5V/pghjmIsE6o3Ah5mZH4jot7oKvpbQgZj4NCJ3mmm29AHJV98rtk5a1v/cSfw49PDtubN/EXqON5oDjzhqt0Cid6uGhQu7/q6Ko7va30VIJETkXXvnuvl9xoSJWyEq3zfczvCPGy7OHrRC8eg5V1JuWtaye9/ve41B5FULborebnqRFWxiRrkROTo4la/yv+kwCWrqpvote6EBnnzIwcoMbjrZX8XF+B71SrKwDw4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SUcRX89jcKxcSo7DiskllTP1IizGiCndEw7LlJWnk4=;
 b=oLHHJqQDSiI9r8Tj2KFDOmeqJgrBepFsQU19J60bCKayqDclodR7VoVEGNMwIIRN56G0DIOjLHp+VVcvOe8jCMO7J9fCp3/pqcpA91eggP6ke2K+0Lrh60jhElE4b941xoJVSMKwIdVgmKCW2mQc0iIYBPInlunLcjhVJFDb2407GyOA+s2gvJ66k5nBiY21ZVivCxrIOWqfHbcX/pIb+/8Lj8jBvHITVdbUc9YgNZxkJsnH+9m53vwFmZ47eRURb0vZGDKljCdLvPf0AsXTRCxGxXvy8f1eqG+qsOMhTRTGddbCU0jajRYSnLhnqXl2WjFfaFoS9mPjWL0Rt/VfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SUcRX89jcKxcSo7DiskllTP1IizGiCndEw7LlJWnk4=;
 b=yjEjImDeQ0pfFjj/Cjncv8CDz1SPvI/sgpwG0pHp+T2sf1yBUlXNkSoG/WJn0ujKV8wkNnJdb54jTidbIGrJ2rrej/GvY3hUBmEaZMl5FJQ4YUnS8bHqzqhSBEksxiMWB9ZPFkL0YPjT/ZLLYIwXKi7IH7+jPkcFdxa5oDQ0o7k=
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:12:30 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::ee) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 09:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 09:12:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 03:12:28 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 03:12:28 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 03:12:24 -0600
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
Subject: [PATCH V4 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date:   Mon, 11 Dec 2023 14:41:59 +0530
Message-ID: <20231211091159.58564-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211091159.58564-1-manikanta.guntupalli@amd.com>
References: <20231211091159.58564-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7c4a53-c79e-4ff4-1d82-08dbfa294d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmqMEjYU8Fczc+R/yJoXpfzfqCydwri5bRCdSqLQp/dK6fszi2r67nQrNyCqZA8QIPIRClDILkf/7LSurGLfSNO3AoTXUVK8iGu7/c9sbfwEPgehQ+Qtb9UAmYKhoTvN8jq3excgpCYdtfj89IrmmS87A7gcC7OlK069xYimTRgfLHnEqc3vhE2tid/DfpMS1ov9GrWZpXHOo4JTGfMv8I1qKXl0P049ENMLSrWpICnMrckM50LrESGkG+QUgpMTvsqG9HgMhGLETrsyOL+8kgaMR+/ZaTtM9MR3livpAhkhcY2bhxjZuChtYS/Hginv/LFHvGlUav4WYgq2o6EFIJULsLBrV08wcDAE1/UsFNZyvgT/3gD86LsYA3hU5qOFiRiht8GNFmFOpVjmSI+wwaCFRI4d5S+NpnpW1FGWu5Yu+NlO+WCKuiHFUApR/7P3E/77UqCD1aC46Id8j2rybbhxfmmvd7iDwMu02ZMxAJNdUgO+IPRXawNeX0HLO9h70EztlS0xxUqFOA1LLmevlzA2FnUIeLx+umk+tF3lBiJFApeuFMfkgwgHFhfWLXPCdmSEEQgoxzDkBpbrpFfL7zmEcQjlNg/kg+AwCMfUNmure9g2zblv+L0sR2HGVNEDlowxyMWP9USQE3NWHFN3wGB9KGyROgdCUJ7gI8FpYH5vKlvH40AMWhpGBctFdOVtWHQzP4d23yFmm8DT61PHNp/EdRg7c/6YlSx9qgHZn2RxfEhXSCUDp7mLCBFM29JMOkgGjR+S6BuzgeMYNKW1z8d2k+BT0l1eXmdvwWVLBFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(26005)(1076003)(2616005)(336012)(426003)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(44832011)(41300700001)(2906002)(4326008)(30864003)(478600001)(8676002)(8936002)(70206006)(70586007)(316002)(110136005)(54906003)(82740400003)(81166007)(86362001)(356005)(36756003)(921008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:12:29.5105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7c4a53-c79e-4ff4-1d82-08dbfa294d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/tty/serial/xilinx_uartps.c | 214 +++++++++++++++++++++++++++--
 1 file changed, 205 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f7fc2de8778d..e7f2c43fabd3 100644
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

