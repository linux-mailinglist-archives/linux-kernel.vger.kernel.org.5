Return-Path: <linux-kernel+bounces-158066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026298B1AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21BD1F23A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3A959177;
	Thu, 25 Apr 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4T1F0xgz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34269953;
	Thu, 25 Apr 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026284; cv=fail; b=UzR3ohrcroLxRrR7vqwBzz/fC4KnqGTUFRwyQR2QXtvGXOoqxTq4u7oUXSnHOblYF49IQPTYITQudajAeS0MJodRRXarAHNth/mjdFOImymZHFa8mnX7ZkLuz0rY2tTm0bnWMzIgOsWV/EGjlVMfJLgrE2gT8dm3FRxfn4+a68A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026284; c=relaxed/simple;
	bh=q2ZsezdHmQMCyh3lCbFu8SlVembUNtDQ7Ex5yGadCC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEvR54yq2ZepV9PZITIghRuF56BDNEMncx0d2JEsgfXQ2Ck6RxitxvoFpbPJVHjONU0MiNxyGiiPjdlqyh9EgjUDOHgT95mTkChAJNRh0ZFHiuTpYyhMAZTT1iAPEuLaG0YSi77WLeJ3J2sT1u7NJfvy1gjeo5AYtyPzWpwfMms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4T1F0xgz; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyT8s7f0xLvp5KV4CGi+14u+TaehucOOkJw54ObBTUfdBSiteIkGPVPqtKEpeJKsMt6vAQAK8CdbU7RCpkvSld4NJOPFv+zT5UWAPfK60VgCztqvvR5iXBMFXs5X33WYxtbU1FRO5mw0nXevVHB3tboeQnvlThXG9gP15CR2TrCnnR/86f/rF4Qvv2LKE35OXkbmRcvnDkizeZUzppyH+YAkMTurydewuxga4rrMQwywaH2ulU/Imi21+xnPMM2zMZsWGx1rHFwd1HeOlE+u1sZjOnc9GqVzToU7fdi37jYbI3sCRbAK+r4MJCvtYgE+eBF7IRc1vnV2hxqfy0p1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQs2L2CI9uPH+up8RUF4ejz9eYa1Q8vc+roo016PIak=;
 b=jiDLD+XOmX/FK6wy7KQQpNqJ6P1n3lgdJykzSB9xGITvcYg8qx4/XB5Q+i6utb/UiBWaSUPtHtVJgQmcy1IbfFVT4HcyTdNmrouGlvk6EEBwz0vBuxtEh4BE6XDDVkhw2qvdLLxFTyq+thldbgdYHt9eRmC9Gb+AEpaqbEeX00Vww1JA5JRvCRppzGLYEYqjCqr7B/G0NiA2e2sksUjBJ5+c3wIKUS6S5EAG237I8pMHsvy3KCzMmUh5OmFWG4uOcRCdevDG1FfqjfvCbHx3YYo0nNuYNvFgRaXfsSaTKrbMm92W8P3QQq4Ulum1uvVphZO2gZdGwkgBnIq4BXjYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQs2L2CI9uPH+up8RUF4ejz9eYa1Q8vc+roo016PIak=;
 b=4T1F0xgzAsyjpos9b5qipyzS4T1wcfYgxxOcnM6mYa9JxcT3abnyk3Aib87xxKwN9tA1YRfRkwY6xqcg/Lut8IuSGTWEKPBPumGPGKsETiolJnvZmOp1aptP1ySCO1gabyF9ICZHT9ZUwep07Rhb3O8PhHiBXyDj/qjDm1UZ7YQ=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:24:37 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d9) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 25 Apr 2024 06:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:24:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:35 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 01:24:29 -0500
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
Subject: [PATCH V3 3/3] tty: serial: uartps: Add support for uartps controller reset
Date: Thu, 25 Apr 2024 11:53:58 +0530
Message-ID: <20240425062358.1347684-4-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
References: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d94d5d-189f-4ff8-d28e-08dc64f061bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35BXcfmY9dWjAlXa5gB6Y44RBeDixyReRcHYAEk7i+wtA5xzy34HV1kDubbZ?=
 =?us-ascii?Q?5siG5Shusgz9cfr4xDOnWIysR6yNW9emLq5gDJ3nHAzM7FZ2sXy4K718eLNu?=
 =?us-ascii?Q?KJsGEgJlI/sGzOawpQAwEjrvfvmrKJBHbkdIHhtiZ5KZfFxh/oqbVr3dKNmr?=
 =?us-ascii?Q?xbEPH0pLnCxkhtaIu+bOvXqwMGIN5AiBDuG0YsgaCuH66uCyWNs51A55V8yp?=
 =?us-ascii?Q?O5p3aaR61PhwvVzkLk7+CksQKwZvZ0HSmnuuyQrpbQxlC8/FrFuQ/+qcPkSY?=
 =?us-ascii?Q?rvr0Ye+v+J/f5mrBxB+mRud3PcRlrTi5sbLjVutPSI4E9ljOOw4SWIwy/PXe?=
 =?us-ascii?Q?dEn7+zMpLP+ngOE45DYuCXG4Gk/MYlK824CFRp4T/xAeywJ/OA6NSj1HGO3j?=
 =?us-ascii?Q?jnfSiY0nL6llSh31V8YFZ7jVofsD805nR2NUn/Wxm7Le7b+4WWm/YGKnmAxh?=
 =?us-ascii?Q?qOZUdL6WQJpggoZRR5sFRmGr2WWUuMP72afEQG/7w9mJyt6/ebPfQQq6YMyy?=
 =?us-ascii?Q?YeFE6WTqMS59eM5k0lTbZgD9lJ94X6A2VsI/cClCRPOhtFNyEa5aL9U/DOqS?=
 =?us-ascii?Q?KSzEVm2zzZWAiVuT4ck0uQ6rz+nwaLbjfB7CZyEnpuBJs/+ZHADjCv5wPOZR?=
 =?us-ascii?Q?LtVNL0mmTDznU2JEOIMSqgXL4pzetyOx9Ub2zKBupdxgmUFB+xknIINJxl9A?=
 =?us-ascii?Q?vpjEKs68VycqamS9Nt+635jqw5w97rnofNEm09mEFKDjHIWSfYaZt/Zmf8zI?=
 =?us-ascii?Q?o9kox1ayRAISFrCUZer0VsEibugfoFLeERUdvsQJiHZZSBA2BBxrqxwA3mdZ?=
 =?us-ascii?Q?6iHdOYjFUitlj/HOFc/RFwULwekL4J3KFixEjolE8JwepELyzrRi7oFx4FEt?=
 =?us-ascii?Q?gOUP1yEaG9NlTIWDk/UlLReGb/zpIRJgidgQuFQSwlJmeWWITQyd7lGek4Z0?=
 =?us-ascii?Q?tq8cbRhPONsrl0pMUeWuM2o88eD75ryIoWNqVyicjyKI3CQp9EnuOyZXakS2?=
 =?us-ascii?Q?eCE+FNJkGa7UefPatFmgr1hK8B7zx3e9ypqhasfCFj27Hv5h9SFs9x1v9wV5?=
 =?us-ascii?Q?pLLXYLbRnsO9M7S0L+8813Imvo/gOYZ/SD1lfzh+TSXPOPaAK6IaxPDSA78y?=
 =?us-ascii?Q?bdyMjP9ODG8U/mZyLPndoIY98yeLj2e6gn/ghhTeTkBjQZGPOfmihrEfoTmP?=
 =?us-ascii?Q?OrAO7KTwh9ifd9/xBwc0xyYGJC+hlW25otQ2SG4Z1Mkwu4V/Y7qU6OoEjeBK?=
 =?us-ascii?Q?2RqP51TBaG9Bs9BT0dhhoVrCmXfdDzZEwmCH742ktXsuAmGxBzRyn1nzjBum?=
 =?us-ascii?Q?6zTk2h0j2wteiVIpt8Zf45o19bjxIPWGFUZxg6COOFjrHlDYZOEzg1F8BXEv?=
 =?us-ascii?Q?3NMQA2lXjwzOertC4IkpvV7jSU1g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:24:37.3211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d94d5d-189f-4ff8-d28e-08dc64f061bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934

Add support for an optional reset for the uartps controller using
the reset driver. If the uartps node contains the "resets" property,
then cdns_uart_startup performs uartps controller non-pulse out of reset
and reset in exit path.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Remove check for reset_control_deassert, as reset_control_deassert
function internally has NULL check.
Changes for V3:
None.
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


