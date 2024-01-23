Return-Path: <linux-kernel+bounces-34760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F09838736
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0931C22069
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C415024F;
	Tue, 23 Jan 2024 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0BKmP9Ez"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291D50247;
	Tue, 23 Jan 2024 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990650; cv=fail; b=YM56wa5YtEC+rbAqCE402S3jgaRMaF43AvqrarmOzTo/fX+lV7hodJcechroj7b5qOpCnQtwzWcs65vv6ZiGJoi3t1IlO1QbKlJ3Yd+bESfSmQwmpPVuk0e4fgnt9DZpHpzGoz/T1+8cw/yUhv5tKDpjroWczMEHmE+Ax878ycQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990650; c=relaxed/simple;
	bh=iLllN38A9Ho1pUyaBYuafSlrP5bxci1bWnQavZP65iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZB/Q66XxuJoFfS/1Ou/hwX5/XbUXpF3R0OxbKuIXUIIha6P8LRl3jq3SGijEaI2GMoYU5VVh4ZbXP6WBQybuEulRqzpTi2UOP4mXpueEty+PDan+knmZKYrMnlqNaduttf8+h9R1iKFwxKJQFtq6fA2jnClrjgoJibPrmFPCsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0BKmP9Ez; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi4Qqq38yCASxk0JA1EmwUu7SYsJL7fcuE+Op4Dk4BzVnB3i7vo0QzPofGgLTe1l/vDWPHDhAGUOgDmmHwdgFgQMYpDxIcGJeYzT+6LUgIA2DgbWqhheAV1qr0Gw7EOK6A2/LHR8BP7DdH5wgwBSu7GZXo6PKQWD7s0iXQgV5qQ9FKcYuB31gNCY87BAeu8zPFB2vxJmNTtGZCTeJwJJ8cJjSf7Lr6BGRlwlN+1Sq7mDk2Vmsd8dsR9SqKOBqwWEmm8ddKhoGlyDAbFVGoesS6To2WKYTVHd4dnR6NAkfRWhA5L626Cd+JBupBHu/LRenc+RQOy/QCHFjmOmoglwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGU38bnXCgfXXub3Tv0N7b/JbzNTdynfBOMq95PvQiA=;
 b=HHrvPcHMY1MWxD7rJOmhkLi9Tk8xapxyvpQvcUKLEkorqQqmBNgxRAF2y1G5IuQx4iA/b0bzvVk6HNLfbxLz9pHLXDNnfoEK9bj5ibTnVCWIx41Hkg3Z+Ctzf+/31U9Aq2Smo2pXOC/ElfMsSi9FCKh98WUIoLeMRcIdCWORWR6+eM6+21uyMQINkLZcj+52QgAGBXwzMU1A/bG163LJFaGW6LhwUsJCNelBxsYyrotyFP9+ZEgAmKhtG8hKqt3hzRSkBCP4C6wg/sCAbNsldPOAh10AgukuOP5bq4Bl/3NzpUwLjnSWOED6ZJOLka8S5GdejEguW5oFDtvZspCsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGU38bnXCgfXXub3Tv0N7b/JbzNTdynfBOMq95PvQiA=;
 b=0BKmP9Ez29np/mcmFCXMVTTEpHcKRRhN28hpCwNdCft5dpP8rQC7aCXP8FrPSU/TnEufZDkUfDR16UYy6ecrCZZLcMHjwFcRb6ATvNn70Wh8FlaG4E0yTSLB0L6hmS1cmrnT7eTlXd923EjR+FMoGAXjqVnGVyuaYfPBrw3vyT0=
Received: from MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 06:17:25 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::18) by MN2PR01CA0045.outlook.office365.com
 (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 06:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 06:17:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:24 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 23 Jan 2024 00:17:20 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V10 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date: Tue, 23 Jan 2024 11:46:54 +0530
Message-ID: <20240123061655.2150946-3-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: a192fd4e-db17-4451-58a4-08dc1bdaf7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWS0Ax4GxFx8hfI4Q5a195b4xYsWIvL2TCYIj5AlDfKrcuu6P84buE6Ns+Ml8jv7Ff+5doP0QHJmcF+Wqwz+rSPq8Gss8rErKZV1RumUFSVwB2LO8P5t3pRMPD16WU6dy69/rA2kZgNy9nqAT3et5qvYT6vcQmT1CplyI8L4XFzw8ZMxXuFfBCwrXvEWwgg0QTgFiWwYfjbNEvq+UO6813bJAgfo2gZfIImczxUfBEq/MAs6xTdDATBEqU01OF+W433LWfv4mDbyxSNyoeF/SnIR6D6r7rm5EwpRJAPmNLQxUPaCDoPh/W4Kb0mcQgRJy3hTG9PIv/vsFhE4t97On7BeINSwqEannPrYRSFyO3iSYDVhPrv32xrs/eGljoBVOGM2lQcij14MzgHsCAM1PTPzTXaY7gj8oKOuz55YvipGfXQ5EU+zOUaxhFCNuzfyzRbCCndAyZFT7zDSYr4v6ZQw7bSSHJLgQ3cmWaT15NEeQ6iAJ40pgnTRYInxPhNmxubqT8X2IOmbU3KG/sm9j8ypV7CfCXMxO95LV+oAvsYTwlcw/AVNPEr30x39MzNpigRyBoIZytay+p/kazsHWQdF7dwOi/GsFQ+GmpFeUGCcpjCC39SL4vEiei5Ejpb3b72XuOHt7/kUQtgpdGXjDNE4jgqYPcqto6gOnTnsRO/TEb2oJvZvHXYGhzZPoLiT9Zb8QV3MTCgz65t389/pV5MpTPjA/0ZLjDYOo7wZaT2zZr5XP0wF/BkNSusL3Yjt1F+ae+BYNu7ivG6Rh9pFMPdbNyn/xur9axGFRVe5xfU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(478600001)(921011)(40480700001)(40460700003)(6666004)(426003)(83380400001)(336012)(1076003)(82740400003)(5660300002)(44832011)(4326008)(8676002)(8936002)(47076005)(7416002)(2906002)(26005)(36860700001)(86362001)(41300700001)(36756003)(316002)(2616005)(81166007)(70586007)(54906003)(70206006)(356005)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:17:25.5908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a192fd4e-db17-4451-58a4-08dc1bdaf7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

Relocate cdns_uart_tx_empty function to avoid prototype statement in
rs485 changes.
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V4:
This patch introduced in V4.

Changes for V5:
None.

Changes for V6:
None.

Changes for V7:
None.

Changes for V8:
None.

Changes for V9:
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().
Update description of cdns_uart_handle_tx() and add clear TX Empty interrupt
comment cdns_uart_start_tx().

Changes for V10:
Add disable the TX Empty interrupt comment in cdns_uart_handle_tx().
---
 drivers/tty/serial/xilinx_uartps.c | 36 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 920762d7b4a4..765a6e174052 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -306,7 +306,22 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 }
 
 /**
- * cdns_uart_handle_tx - Handle the bytes to be Txed.
+ * cdns_uart_tx_empty -  Check whether TX is empty
+ * @port: Handle to the uart port structure
+ *
+ * Return: TIOCSER_TEMT on success, 0 otherwise
+ */
+static unsigned int cdns_uart_tx_empty(struct uart_port *port)
+{
+	unsigned int status;
+
+	status = readl(port->membase + CDNS_UART_SR);
+	status &= (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
+	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
+}
+
+/**
+ * cdns_uart_handle_tx - Handle the bytes to be transmitted.
  * @dev_id: Id of the UART port
  * Return: None
  */
@@ -316,7 +331,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		/* Disable the TX Empty interrupt */
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
 		return;
 	}
@@ -587,6 +603,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
+	/* Clear the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
 	cdns_uart_handle_tx(port);
@@ -626,21 +643,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 	writel(regval, port->membase + CDNS_UART_CR);
 }
 
-/**
- * cdns_uart_tx_empty -  Check whether TX is empty
- * @port: Handle to the uart port structure
- *
- * Return: TIOCSER_TEMT on success, 0 otherwise
- */
-static unsigned int cdns_uart_tx_empty(struct uart_port *port)
-{
-	unsigned int status;
-
-	status = readl(port->membase + CDNS_UART_SR) &
-		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
-	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
-}
-
 /**
  * cdns_uart_break_ctl - Based on the input ctl we have to start or stop
  *			transmitting char breaks
-- 
2.25.1


