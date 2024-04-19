Return-Path: <linux-kernel+bounces-151397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E98AAE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA94C1C20E91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666485C66;
	Fri, 19 Apr 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D81wAphW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1780022;
	Fri, 19 Apr 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528384; cv=fail; b=dGrYA/aYD8KzDyT/3u/bfyzYD1p4UTmoq481lM3e4Px+qRlk2lLG6V2Hls4f1fn2Q8X8DtIKd2o45RiqampEmvblbh/+aFdkpqKQORwH9R2VD58Q0DBWd418+pyaVBp3CqKBaNSkdwPF4UrKw0Ne//5VZxXM15PSrkOCqI/1R+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528384; c=relaxed/simple;
	bh=PcwAG5reM9yUVzMXPsaMN+AYVL8KznVJiNHR9pZdBWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nallpeD451QbpRVn38g6tM8TOuHU6o7Amc57+9gxVS6Vrm3/rYuQndjSUCtfZJin/gXqLX/Sx5b9f0fle85tHNCcoWmCvpKVqHN0RX8yhrQ+6D4OIujcrhJQNBKB9Me+Z30NewnLkFKF44EfPkB1Mckm6YYRFxpS4zCS23iExhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D81wAphW; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7nCuQHaPbsrbYePDmf/qe0dbRcR0692vQrkmeI8J/qS9G3+Qz0sqNnl4Na1ETFuf6mu4okMMiIkX9QH3q4fL2fH9iuLqZPIBk6HmHSF0GLv6hU3vPtDwG2dNHKba4LTxLvX28RPb9bJ9Sz1a2wtnadm3P150fFBJwhMpjtHiK88Jjded6G4RrwnyJ692i0SY5C85fiDmbxB6YW2DaWguTWA4lsf1hLG/Vz2g3PHMIy+vGqll2KJDZBLSWoKNrL4Z4/qNWxxuk4b4uY9F2xzQ+tBffTc0bvPLZcR1QhUB3o+2VOkSDmmDPt+jil5PN+Bu7LWZqI6XkGDD8ikstSW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUqaiAEvgmCLTbWL3GZlxUe4kuRWcvogV8TWvuOySqM=;
 b=eGMM6RzmE48IkX77at7n2qatwbK3WKlgWj5xUNuI2jpsZUvyagVk1lfJD9DXFBNmtyDT1cPfQq+J17zdqeuklHeYMiRxhNZ2EKbRLFdoRLC62YOUGmZIGIbUar/4g8NR5B1JFkRd0XjLsyhrs4nIi5WX0kwD+TqsUwmC4m/s60Ddgx9g9WvOZK3wkoXpNSB4hxmQeAnvlgq1EA5olhVYeyr4dQ3ed8jGmrEh67AwEMwWC/Whc3MA7WliPy1X501AaNZa4Hz4/tIktlHahWxnUAJrrfpYhFYJCfpqMs6asgQqig3Xih+5bMvqIX5tVZOlIqqgh3NokuxgJVeq/wWIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUqaiAEvgmCLTbWL3GZlxUe4kuRWcvogV8TWvuOySqM=;
 b=D81wAphWT1Lw8IaSBRerIM/mswx70tM+P4ivNtNULo+6DtngUD2H13KRZuoAOEaVc6w16JeNRgiubDfCGH6hS1fGQzQopU2Efpa8xmWzvXsTSbZLH+NNTtDgeyGMUWYY4Zfc6FUNwQSB6Dd+Yi/gpF0ACdL3YwZWPsyKKZfqCvE=
Received: from PH7P220CA0092.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::28)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 12:06:20 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::43) by PH7P220CA0092.outlook.office365.com
 (2603:10b6:510:32d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 12:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 12:06:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 07:06:15 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Apr 2024 07:06:10 -0500
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
Subject: [PATCH 3/3] tty: serial: uartps: Add support for uartps controller reset
Date: Fri, 19 Apr 2024 17:35:31 +0530
Message-ID: <20240419120531.3775919-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
References: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5ee15e-3a4c-4a17-c602-08dc60691fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rcsD2hO8HsDYjzugygjbpGPCl1b32iLyBe5gOg2dQwtwWEH0KeYES60JWMNrj8+dOUisvEm5c/W/5k9WeWm9pH2nAX8qzRk8Tz7/JYF5OgP7+BXieUh875cUILfdTz/lTFH19uRQ2/X1u/+ifAV/n7lpmQRAhqBOySAYpbO+FGG1Zt5vNnQzom8NRL5u+ZtQIQKjySGN/XXbgDeVr4dkA2Ijge7UwMcp1a+tZUHQqhYuAJQubLgxCi020mA0xgKIFIOe4Q3bzv/NmWlS7lbPOwoLLPDWLrVPtC4v9o9A9tTZYzxQGuZ0AtoIkemuGJg/Xbi7SMoUJZwvjg8c5Am+rl+hx193ssOaXoHSkjqDAjINw98E3guw3h6k0MCmPVS7DX8iM6n/Z2xno0nQDLdZYeWeZwvW+kQ/CvSLdJ73xOwbAt0zk8UZ3siLQ75vMvBE5dK2x4Qra/k5wLVJkydajV2puc7BPm2aOuLLb0RUJYFTEiKanizsKHkalNop/w9j5g0zJG5vuxef8j+eYjPJpoSEE48esPwLxdoUqH8eW0J16EFAbiUbXy1DcEgtrL6D5stf1G4yQqZoimaujpWC5LdgCZWM3nz3oLaJ8uaC9iJrDQHDWvaiQ6vkaM/18iagCfXstuUiJtpasFeyGhRKc7j88JivE4ybPMGyahaGIQDokKdGI77hR66WIPuxZb8YR4+GPboA0pn0EHbi5ckDpWvmDk4PirUjlA6tmUSFvAzm37cghV4qkf2WKGs/MN0XlFE7rF8jCsK6TQBuNcvyHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400014)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 12:06:19.9713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ee15e-3a4c-4a17-c602-08dc60691fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

Add support for an optional reset for the uartps controller using
the reset driver. If the uartps node contains the "resets" property,
then cdns_uart_startup performs uartps controller non-pulse out of reset
and reset in exit path.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 drivers/tty/serial/xilinx_uartps.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index de3487206bcb..e45d6993ba05 100644
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
@@ -948,6 +951,12 @@ static int cdns_uart_startup(struct uart_port *port)
 
 	is_brk_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
 
+	if (cdns_uart->rstc) {
+		ret = reset_control_deassert(cdns_uart->rstc);
+		if (ret)
+			return ret;
+	}
+
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable the TX and RX */
@@ -1721,6 +1730,13 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1881,6 +1897,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
 	if (console_port == port)
 		console_port = NULL;
 #endif
+	reset_control_assert(cdns_uart_data->rstc);
 
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-- 
2.25.1


