Return-Path: <linux-kernel+bounces-156800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469538B0856
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24111F237ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CF15AAAA;
	Wed, 24 Apr 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FaHY5AET"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8855142E62;
	Wed, 24 Apr 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958216; cv=fail; b=nUUa49uz2uAz4+4ec0XG+zUWLKYMEB8BwRFNt2lAyc1f9P05lCgzfQy3SjGlZqCoqbSrMALLnSX3y+kkvaCRgcV6iuVGYaX5lUw3pCnSLr3hk3DLlCu2WdHVahonuxwUwT4aTB6kVRbSduzpGsBUp7Ce7J1pBMdoZwhhFwm871w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958216; c=relaxed/simple;
	bh=nhlsSD1TnRSGFFmVClVNBV/tqyUBRUxWmT+gsABVk8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Etcw3PSB9x9J3fd/gcWRGXBKauyAdtqbfDY01MjQa12VqsQX+naru7B8mc8KpK+dgS+Tn37GDlc5gIex+ftMUfYwdfqedR7jpEd2GMf9Q4zOZLYwbpNRFBMIq1yyaKwh+fNA9zPWJHkcfEgUY6dqZSZvW9LOxFBiV6QO+mGsz+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FaHY5AET; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lieEsGdC0YMKO4ClhrHHuxJnEIbujFFqgmVYnltRv6wXFIr4nMO+srlE7/e4Nx3dr/yILchE4BtKMciIGAggHMvsgUMvBDQ+fDXZvHFjvhNxQ/8RHEYZHAB2jihm40HebiGa+D0vCs26xqfaie1klGXtPD5tfnHIOzehea4H0rqpAuCaGS4oiFNv/4fZVXBOcZ2J6oimcCTNXPrLFCNx8q33DaiB9tDL8o1c4MALzQjyh6ZOk97Kkx4oAT4rNqrEF5rmzyYb5JuKIvUdain5Di+QYL66MEfR0cb4a1f/YsyDfQpsOEJtLNpyOj/oVCPnVc2iaRaQZ+6JtHAAfpOp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41mm7Ynu02O+l4vOLQCaDhLiskSdxYA0WeiRpEEnxsw=;
 b=lMsCu+Zq3pLthbJgKEbLz95uRUAs2cART1X970PJroD3gUwyxTNyYEJ9JSTo7zTlM/BYBcFLz9BqTSeINWD8PKhOQppLJpWK4jOeSyamytiZmoaB13Bm2DpMPRvEeBMMDuYDZcAb3CmBglwcmwxiudKr/q77jtsTZ3N0DsbwTNUd9CVNyR+ph8ssR27Ci7XrH84hvM0G+5X8nVhe6oXUWpMMq+UG8AICotWSAc3vN9oLOcQTnGftTHdAA5ilufj9/uaT0SA4O9vwu7EHKMlkvv6HpUfwbDzieU6pufr9g9tbUNWjZY+L6HNS26zi4IAxd+SMU7ssQMelWvH3aqIBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41mm7Ynu02O+l4vOLQCaDhLiskSdxYA0WeiRpEEnxsw=;
 b=FaHY5AETZnPemk6t1a4chco7e39OYs1dzG3j9kiRnOkJ6tmjmbwaSPvtlIqQljjt1a4s4q6C4wr1nFXZ2RMyaqKgRNe91cVY83zg8hZdtU3EELTDjJM9U2BBA4NRgtScNZDpJYaYgeIWtZUUD0Ze+PiyxPBAjXGmiFoR8EPjCLg=
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 11:30:12 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::f4) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 11:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 11:30:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 06:30:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 04:30:07 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 06:30:02 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2 3/3] tty: serial: uartps: Add support for uartps controller reset
Date: Wed, 24 Apr 2024 16:59:33 +0530
Message-ID: <20240424112933.3528590-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
References: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8276e823-117a-4945-bbdc-08dc6451e6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|376005|82310400014|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?acIkmBbgM2OmqhAUMJv/QiEtfdb9l6heP5ehE+GKzzbpyoKecp1dqm8peivv?=
 =?us-ascii?Q?CU2CXtsOT+SDJoFmIekGBXIAYc9IHC9WZbIDBCvvdYpYL/H7u53dermIzfOl?=
 =?us-ascii?Q?01a3QL5T/2syzDg4zxvLHG3qPFW/I6bPJ95ffPuh0gqlF/xDHucW3Q4f3/TC?=
 =?us-ascii?Q?72EmiLUM38LvF+00Xy7xOfAhTXCYAljIV1XxIQy2fogfozUIDc0bqEvy2d54?=
 =?us-ascii?Q?KCLCvLL2cjmF+6jcFA83NZFGtm/vHEEI84uKnxbJNIjPSU5dY6Wp5U+gkUwE?=
 =?us-ascii?Q?WFwaYY8eiEYmIZeMpS8+76M8mgJ14s7Mk3+59cyCcJ7/5TSQFKpOwPac3odt?=
 =?us-ascii?Q?GYk2kMwCLKfqaXuNbh2jcTV+6zwEUmBGOTk8QWMYOjogvIsZCa3TLczBlVYF?=
 =?us-ascii?Q?9EKiUEW5KJjLxoEjWf4M5wNZLUSPkTmd33yBfijVdAwHSm0uLe93nY09Kh9Y?=
 =?us-ascii?Q?aBP+Ghk3nDcvBJ8BbZzjxez4YJgcxBDWSp3/vrEhwael8gRo3FLQERjo4z9y?=
 =?us-ascii?Q?dvLYydT3W8mXLffqzV6jZPLgyCVsQZzywMy6alcs/Z5LdplCMpCv+GNULgzY?=
 =?us-ascii?Q?7KIHCKUxdxIUt7smRRJvY2esxQ2VQdbgbmQmYyAeuAnrygHGCxJK7KG2jI9z?=
 =?us-ascii?Q?LZjr6/I3EFT05Jp/sEWk88qRpV6u3zcXjT/ytz8TO8TGp3v5QfrPQq3QJkeI?=
 =?us-ascii?Q?jEscm+MZH7mXnIXzyGEbTwQgtpgvv/UTSb1rsx2fZtYEQZ5vpZluVETe7F1s?=
 =?us-ascii?Q?7dRmg60F3wjpBiJQWujtaW/Lz2Oo6eOS1LifaF1nWP1US6y1DMQHjkMEq856?=
 =?us-ascii?Q?6o6EMwkwzq//mL6ZTb2Rms/EMqQb/9i6fr5HBLi8mFRubQIWRHhUTKWrbEp6?=
 =?us-ascii?Q?1Fqu/9DMR0xDChmy/xGqUPxy/ZD4HOO+NWd2OpM4psSqrvsawpAPG46c1qqe?=
 =?us-ascii?Q?YN8XolSDFw0a8C2efMeQJn9h0hOr6i+47MIi8vvW6p1sr9SyO1GAN8RntNtx?=
 =?us-ascii?Q?o6P7WjfgZKFW4MRKBTMHmFqsZZBnooOQefW/1oe9XLG8TKejx8TfE6BqGdeT?=
 =?us-ascii?Q?2teS2qs34JhZOM+aS64d1Fa8mVycRmLXCZNVaO4oLg2JADLb+8OfhrrcqyB9?=
 =?us-ascii?Q?olf05f26+ch99xL4BMWhRPdEh0521tQh1TqXtsVEPhfQKk8dQSbuTHdi9nur?=
 =?us-ascii?Q?MQr4EAws2zjvGxnU1jL6g+EUBMuS4gW6nwuXtF+JzyILo70pUyBD7ldyk9Hg?=
 =?us-ascii?Q?ajJhXwWruAAPP3OLoMSc7I0EERD+ajBz6dHBN2/h4lsSI3vibrIpIEO3udCe?=
 =?us-ascii?Q?c0x/hLs9vbf4eKmkBSUUHZhRe8fPKjfNeWn/0JZ2s5L+CbbWxAuPYgOioNE7?=
 =?us-ascii?Q?6qTl3L4IlgZk98ChGn6MSiA76N0x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400014)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:30:10.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8276e823-117a-4945-bbdc-08dc6451e6e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

Add support for an optional reset for the uartps controller using
the reset driver. If the uartps node contains the "resets" property,
then cdns_uart_startup performs uartps controller non-pulse out of reset
and reset in exit path.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Remove check for reset_control_deassert, as reset_control_deassert
function internally has NULL check
---
 drivers/tty/serial/xilinx_uartps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index de3487206bcb..2acfcea403ce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -198,6 +199,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @gpiod_rts:		Pointer to the gpio descriptor
  * @rs485_tx_started:	RS485 tx state
  * @tx_timer:		Timer for tx
+ * @rstc:		Pointer to the reset control
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -211,6 +213,7 @@ struct cdns_uart {
 	struct gpio_desc	*gpiod_rts;
 	bool			rs485_tx_started;
 	struct hrtimer		tx_timer;
+	struct reset_control	*rstc;
 };
 struct cdns_platform_data {
 	u32 quirks;
@@ -948,6 +951,10 @@ static int cdns_uart_startup(struct uart_port *port)
 
 	is_brk_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
 
+	ret = reset_control_deassert(cdns_uart->rstc);
+	if (ret)
+		return ret;
+
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable the TX and RX */
@@ -1721,6 +1728,13 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
 	}
 
+	cdns_uart_data->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(cdns_uart_data->rstc)) {
+		rc = PTR_ERR(cdns_uart_data->rstc);
+		dev_err_probe(&pdev->dev, rc, "Cannot get UART reset\n");
+		goto err_out_unregister_driver;
+	}
+
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
@@ -1881,6 +1895,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
 	if (console_port == port)
 		console_port = NULL;
 #endif
+	reset_control_assert(cdns_uart_data->rstc);
 
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-- 
2.25.1


