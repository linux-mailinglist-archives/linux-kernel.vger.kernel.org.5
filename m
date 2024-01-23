Return-Path: <linux-kernel+bounces-34761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18D838739
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB2C28A29D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6050263;
	Tue, 23 Jan 2024 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxKdiY74"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76052F6A;
	Tue, 23 Jan 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990658; cv=fail; b=PBydNs9IeQebgg/i1rvWPRq4WMnqW99R6DKL+b1pa0kcEG98BjlAlnn2PNZjebGpgtTmWIBTCHfwkfwXi7y9UKPMJHur39RhO1kIHcKtPI7q+STExf6flCCB7/q7PtoKFSOinR+OsHsIy/m9W1CdT6r7rXxa0/UyvOYv3Rj0MSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990658; c=relaxed/simple;
	bh=A6gcw71CArgQGX/cLhejV1QkRLog6yL+Pwy/sQaLjBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeDm/tOG2IZanqq6746ERNDAIQxALy5dHISSQVLQvFrQK4YqpBCfOfIKRCAV3LDzjKXCdOC8GLVI6MvZLSHph+aJqrjG2MzSCDZJpnZTTVC6RE83ocLW2nxuSe7l77u95pVqrHj6C/aQfFzcFrX3DX4jxUg0LLIRTyB8aSFwj6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxKdiY74; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSWtskojJHRA4aMARKvuRivkl1o+mVsixhAME0Gi/+jriE3uGxOj+EmHEMCiK+v0OcY5ssQmV4LOWUhNEALfuhCRF97O3HuVBowCZDm/j9v7W9yTmquhrdLUsybQEr6MvPaB7Ik0obkOd+0lT3d2mknmu6cFYGxBUn/UamU7u3kcQmkv40K9m7ZMl6CxmZgatMxJELPklEqQGNLxE3O5yClOwTpIxYnYonUbmj71wBD1oi9/2eESCPOKp1V7yTvs1VYeVs5k5CbIbAEYElqbKcgIsgFf0wqenhjIlLh+nxdssRWkUhSp88pK24Ou8EYjersBaSAWlJXj67VrlGqQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC+x9Uk66SEaJHdc7BpxV6ux9AJfrEFkC6iOAG6YEZk=;
 b=i3Of/DEgyfYHckYrs0G+TyFPVkVA4fn6xOR9DLDZuND162aU8gPS2UX9p2kK5iMElWEBQ0yblxDiwIPdMSA3Q2NZMEw1BUvFlSpApoO7OtXDRFF8zix+K3Ys18/3H6dNiXy7pfS6k6ZPYAj5OcDqeSIclr9ocdLQQlZlm0o0Ec1L1aFySTPWyU8xgs9bOSQbmFZkW6xaIRvb9CFRL5+6zM69t956NJVs9hoTRycpVmQxGgbBaNbPQ+CjlfSJJ0o83/WihRX9OvlrZQArUDFilZhRNlsBrNMZvQIzdMhQ8ow7yAYFlcOPUecoLZ59hDuS9shPEdt3eMiShalEYVi2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC+x9Uk66SEaJHdc7BpxV6ux9AJfrEFkC6iOAG6YEZk=;
 b=uxKdiY74JzthWkFhHUre6fgNsUjaktm/WDZ5zTL3GQXUE0EAN+mXGiHBXWn1ZGU4m3B/Xv2E+aMNIKOiiDeAMQ769Q9eu6UhSPN08YUhZcdw6Q14x67Wq5cPVXbI5ENonyLA19/AlzpAKwxq3Qsc1Mq9ZsMLYP6Ek+BpSBIKdVU=
Received: from BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) by CYXPR12MB9338.namprd12.prod.outlook.com
 (2603:10b6:930:e5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 06:17:32 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::b4) by BL0PR1501CA0023.outlook.office365.com
 (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Tue, 23 Jan 2024 06:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 06:17:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:31 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 23 Jan 2024 00:17:27 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V10 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date: Tue, 23 Jan 2024 11:46:55 +0530
Message-ID: <20240123061655.2150946-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123061655.2150946-1-manikanta.guntupalli@amd.com>
References: <20240123061655.2150946-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6273f4-da07-44cc-0a4f-08dc1bdafbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TveVJ/jgk+wJJA2cJcbzDGE5/satlE8iaJa8rxII4B1pR0xgvzCkk7d1EQ5SirVOR6wFRFwvQc3D5JhPTMHOyQMiIpkVqgjUiEEW/NeidXnUtyE5l3kzOG+32kbDwUa2vSRIE2gqxwh2AsFQefLOjfER+NrK8Tu0oMTGDfP2vd5+PA7avPOpulSEeAeyj5k+0sI5Z+j7huCOdguBwLWmHM6MsuW8sggc7ZUkT76jzNYSoxH/5jkgHwo2FKVYNGG3pjq5sB0Fn1C+qFzq4mhG9A9X08Fu4SNwyzw5pxm9WQ9x+Y2tCPDYwLtH4qFsjnOZ58oQMBU/kfR6fNOHZ7dMbOfk30+xbAcoq1J5RUIdarjIe/NN94PGPpA/BeenRVFb9zyPv+wasqtjskqOzu5LETcMsrjhWTfNK1gQn3vQ+UWg3W3ZscM70f//yjpeNwimTfpcb3VoCezU3Tv6fvxE1s5cEAt5CctprRHfYcigMQFMbaYWF7adKL9PeFhBxrfN+47UmF9qkwZ6bETIngiCdwdrP7A197cyd4qeancNrvBYxPsrRD5zB8EK4JywMxONT5H/a3QzlY/allq2aTKRbYSsEJbq5oy57jgpkp8eW/OntC41G7nAIwJBvj2aDy3pwR0fTj32ASkvcM5OXZS3K4u5pFmYva/4/6BrRpqudzNk6nnu8dZZRfMvLQ79A7HyItfbvcHriovEXtUC0Ca0YztQCNj4vi//zMLj4KG4VEXyvax5R8aDOMH7tIJpOh9AJHxvdPyXofCOvrQM0ZoKey0YFdICXGFd4J+Jk8dujwU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(921011)(36756003)(86362001)(356005)(81166007)(82740400003)(41300700001)(47076005)(2616005)(1076003)(426003)(336012)(26005)(30864003)(2906002)(36860700001)(478600001)(70206006)(110136005)(316002)(70586007)(54906003)(6666004)(44832011)(4326008)(7416002)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:17:31.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6273f4-da07-44cc-0a4f-08dc1bdafbb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

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

Changes for V6:
Disable the TX and RX in cdns_rs485_config() when rs485 disabled.
Hold lock for cdns_uart_handle_tx() in cdns_rs485_tx_callback().

Changes for V7:
None.

Changes for V8:
Use hrtimer instead of timer list.
Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
Add cdns_calc_after_tx_delay() to calculate required delay after tx.
Add hrtimer setup in cdns_rs485_config().
Move enable TX Empty interrupt and rs485 rx callback scheduling part to
cdns_uart_handle_tx().

Changes for V9:
Remove stop tx timer.
Remove hrtimer_cancel() call from cdns_uart_start_tx().
Handle gpio case separately in cdns_uart_set_mctrl().
Move hrtimer_cancel() call from below to above in cdns_uart_shutdown().

Changes for V10:
None.
---
 drivers/tty/serial/xilinx_uartps.c | 200 ++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 765a6e174052..5f48ec37cb25 100644
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
@@ -193,6 +195,9 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod_rts:		Pointer to the gpio descriptor
+ * @rs485_tx_started:	RS485 tx state
+ * @tx_timer:		Timer for tx
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +208,21 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod_rts;
+	bool			rs485_tx_started;
+	struct hrtimer		tx_timer;
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
 
@@ -305,6 +321,55 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
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
+			val |= CDNS_UART_MODEMCR_RTS;
+		else
+			val &= ~CDNS_UART_MODEMCR_RTS;
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
+	bool enable;
+
+	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND;
+	cdns_rts_gpio_enable(cdns_uart, enable);
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
+	bool enable;
+
+	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND;
+	cdns_rts_gpio_enable(cdns_uart, enable);
+
+	cdns_uart->rs485_tx_started = false;
+}
+
 /**
  * cdns_uart_tx_empty -  Check whether TX is empty
  * @port: Handle to the uart port structure
@@ -320,6 +385,37 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
 }
 
+/**
+ * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
+ * @t: Handle to the hrtimer structure
+ */
+static enum hrtimer_restart cdns_rs485_rx_callback(struct hrtimer *t)
+{
+	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, tx_timer);
+
+	/*
+	 * Default Rx should be setup, because Rx signaling path
+	 * need to enable to receive data.
+	 */
+	cdns_rs485_rx_setup(cdns_uart);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * cdns_calc_after_tx_delay - calculate delay required for after tx.
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static u64 cdns_calc_after_tx_delay(struct cdns_uart *cdns_uart)
+{
+	/*
+	 * Frame time + stop bit time + rs485.delay_rts_after_send
+	 */
+	return cdns_uart->port->frame_time
+	       + DIV_ROUND_UP(cdns_uart->port->frame_time, 7)
+	       + (u64)cdns_uart->port->rs485.delay_rts_after_send * NSEC_PER_MSEC;
+}
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be transmitted.
  * @dev_id: Id of the UART port
@@ -328,6 +424,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
@@ -348,6 +445,16 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+	/* Enable the TX Empty interrupt */
+	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
+	    (uart_circ_empty(xmit) || uart_tx_stopped(port))) {
+		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+		hrtimer_start(&cdns_uart->tx_timer,
+			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
+	}
 }
 
 /**
@@ -580,6 +687,21 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 }
 #endif
 
+/**
+ * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
+ * @t: Handle to the hrtimer structure
+ */
+static enum hrtimer_restart cdns_rs485_tx_callback(struct hrtimer *t)
+{
+	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, tx_timer);
+
+	uart_port_lock(cdns_uart->port);
+	cdns_uart_handle_tx(cdns_uart->port);
+	uart_port_unlock(cdns_uart->port);
+
+	return HRTIMER_NORESTART;
+}
+
 /**
  * cdns_uart_start_tx -  Start transmitting bytes
  * @port: Handle to the uart port structure
@@ -587,6 +709,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -606,10 +729,16 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	/* Clear the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart->rs485_tx_started) {
+			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			cdns_rs485_tx_setup(cdns_uart);
+			return hrtimer_start(&cdns_uart->tx_timer,
+					     ms_to_ktime(port->rs485.delay_rts_before_send),
+					     HRTIMER_MODE_REL);
+		}
+	}
 	cdns_uart_handle_tx(port);
-
-	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 }
 
 /**
@@ -619,6 +748,10 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
 
 	regval = readl(port->membase + CDNS_UART_CR);
 	regval |= CDNS_UART_CR_TX_DIS;
@@ -831,6 +964,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -890,6 +1026,10 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		hrtimer_cancel(&cdns_uart->tx_timer);
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -1035,6 +1175,8 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	if (mctrl & TIOCM_RTS)
 		val |= CDNS_UART_MODEMCR_RTS;
+	if (cdns_uart_data->gpiod_rts)
+		gpiod_set_value(cdns_uart_data->gpiod_rts, !(mctrl & TIOCM_RTS));
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
@@ -1457,6 +1599,39 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+		/* Make sure auto RTS is disabled */
+		val = readl(port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_FCM;
+		writel(val, port->membase + CDNS_UART_MODEMCR);
+
+		/* Timer setup */
+		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+
+		/* Disable transmitter and make Rx setup*/
+		cdns_uart_stop_tx(port);
+	} else {
+		hrtimer_cancel(&cdns_uart->tx_timer);
+	}
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1599,9 +1774,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1620,6 +1809,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 	}
 #endif
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1648,6 +1839,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1


