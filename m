Return-Path: <linux-kernel+bounces-36073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5300839B20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0681C217E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170474F61D;
	Tue, 23 Jan 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UvAn8f8I"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FF2C682;
	Tue, 23 Jan 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045196; cv=fail; b=QD2BSdeht2v91c9Bw57RyutbnY8izsS5u6LyV16MtQybR64ArLueeeFYa0p59hZEvhAwErFPYYVacwd9e/JnvmNVS6aUCNo1lyJyhVgyViSDSFPlWeIJu7kw1Abl6QkoN7a4lRHXLTyhjWZBWsm2dPB9a7t76raGe3owgMbkNQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045196; c=relaxed/simple;
	bh=23Zrugn41ufadFybEsxMIRXjfH4sZn99V7/xL4FkvrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvpYTS0o225RBuV4PHv6BykTT9fxbhroEn9l7/u+I8/3waPqH3U0XnuoY0oyNQ2knURMeoGPqcYT5XRmYRKf0EysV6nHZ8CQ0GVSjXiu/tsq3Q20i9FJRvcHWuILnx4u5+aFyeF82cCO3Qo8Lksv2f8zuuv6Y9T/U0ml73ljkro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UvAn8f8I; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T69GJWJg1xru00SrS6f1XE6wo5elZSg7ViT/pXEoe3CCan14qdptq4SVDdjk8e1hBwnY2PAll9HtncW0MI4fHY6SyEBMXpCQe2jUAHEsCVMjoJ9zcneQjcH04OjfzvGtRV4aXx4c9KC9RGH6ZKs7qzz27V31W6TAqn3NxGi6yEA2xZkfoLDOEI9+5OWqgZW6f1wwFaxsPUlHSaBDM8ygpin8GFWVo98zxxiMIqflHmr9Oz1WTQ44NUOXU/Z5/GovmBMgi1ZXazsa95V+MtMjvKzMb9T6ldmoxwI4dPxdV0kCy4/F/jSKJbjSU1DIXYwOHE4o/RZ4gqSLuAHAcEDPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elXeixqm9OIPId/PL+W1dlakQnATLdA4uJRwdF4nyGo=;
 b=bpkRRUXdIPNTZd0fpjFgPqEXn9uBJKAGpKnZw/KW1AwLjQvPvPsUVv4Z2Q8jD/B5NC52s4wulErjt6pWvR81YNEHx8tZz1kvJZg7yERrnUajGA4nf2fGMQ5kvwMIPyAfKTTPbUqgRzOm/qIyHU+rGsSqy1qrG0ncRCS2E5OfSPUbRipqiXiwl9TJZL6MJIPSfpe+zoLABm1i8X+EYwo1PtGl3L6yujbtZiQ4bHLMI2G3KoD4a1j1IpfTZJzg1taSZMmLPvtJYi4BrT9WMoShrTlqNwGJp/IAWrg2Spbcy7f9IRyQm9uopNjR3tgNEL7fND+DoqBaK4+mZS+N0ltSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elXeixqm9OIPId/PL+W1dlakQnATLdA4uJRwdF4nyGo=;
 b=UvAn8f8I/Zmfhh3ds0iNniAkRlh/+kCrW1pLeRLV/8AUB10X+kgJiVu20SteOQbeDlInDYV1vdOZ0o+OLlg5NVUYNCg0rxKVj0V+3qqwBPblDPqbsST7ZMncXQjAq2UW5iMtCkIHJNjnBg8yM3vxxjECWvgeisaXBfGTlccrM1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7616.eurprd04.prod.outlook.com (2603:10a6:102:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 21:26:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:26:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v3 6/8] i3c: target: func: add tty driver
Date: Tue, 23 Jan 2024 16:25:47 -0500
Message-Id: <20240123212549.3858137-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123212549.3858137-1-Frank.Li@nxp.com>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbfef97-1982-4835-9c5f-08dc1c59f75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7nnzeL1M/8n2c6Ra3VxY8/FhaPpPZhJh2EWKYepi29FYC0dDaayyCqcQcqS1X1Y594cFWclHBWcGTpCYW8XjheYOXt0cHlC56fraqrRlKEWJbfZOQtrHNu9QzOpW+77VwOM0RjFNsaIjzAryMHjoKBxtFWapIyp9R4aGF2uxcowr5CqrFLHgflyA2sYspwbU796ONrIVoUjl7v46QdoLwrrigLB5evmVbSRGAVl8j0lxJdcB45FkUFBTatdzf94Y9ulPIfNKsyLCzG5hwGOyfvO7IkfihRfUveVnv8nqQ2Oty/cltoxx1Cnr+tQ9TPT08HslIZRkf74E/v4ukNR2hgyExbo+QdoPOEDYlib2OxCVp9xb44lyyjpx6091YjF4ei4DwhQiJ+bsYVV360QwUUfXe2+xja2+RoPq20RjLggGWCPPyHfvyy5MMmZqCWaEJSc8sDOoltBfd2SHALWgoNyzL2viLtCqxgPDUJgrYIw8RhKkmTs2Wkf5nu5Pxk8UGqaQYpAkddhGjg4p0/M8kLDRd3N4hMjjLxWXOyiMwiwAj8uoEvLdZpHvLtCf1uOFswcZQU3PYDsq8wRNfWNsIjiQmoF6APlXl/MYwYq9ArYEjwNe0cy960HjDINuAieY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(26005)(2616005)(478600001)(52116002)(6666004)(6506007)(6512007)(83380400001)(5660300002)(30864003)(7416002)(41300700001)(2906002)(6486002)(4326008)(8676002)(37006003)(34206002)(66946007)(66476007)(66556008)(316002)(8936002)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pluSCLrgV46YIZTDkgezmr/iiXEDg6Iuq06D+wbFBLEq1jDhVoux63P53wb5?=
 =?us-ascii?Q?HOQRdrJWmAIEd+NCiwxLMu5O1SNlr/W3Way34BnBkO7IRG/LP1CF5S6r32eu?=
 =?us-ascii?Q?3OhP1X7+LlsFOGO1yxicH7uyzbuHj0XUzGIUZjZaZjSp3kFlJ6B9hT/Lj5Uo?=
 =?us-ascii?Q?uNrgr0yHiBsoqr1ySE49w/MQlS9TtCQNHt/gbST+UW0QmZXNLoAkMCGZD7C9?=
 =?us-ascii?Q?E+HeKBcLpvYfVMwE9/yF+TqKe/OezNlEZzYN9TGuXs01X2gm4WJ93T83SSvl?=
 =?us-ascii?Q?sAijYQOFFR82/034Fcvn/6udOAh79B/Xz3Pw0a5l6+/7oTLcbT22Ow6uHbOo?=
 =?us-ascii?Q?DYcLe5OMoxbg9sqZcSJ1kKm2n9TouQ/cGqoKrB+c+Da77Bya8dIqgSpyAi7r?=
 =?us-ascii?Q?JRfOGVn9cfzc842jTq7J+uXN2/8QHZpTRnorWP9vnVgfp/0uP8FCDFxdOc5B?=
 =?us-ascii?Q?s7YO3I7A1YBiugOk+fs2/B0g4qxSWNksMU8F/yepY4v+G9vmvh1cCqTvVDN5?=
 =?us-ascii?Q?SmWFlW0fbCtZdoFpcW4/zkYj2idkK/CLlprth8FDsFhcHHbX+vzlSXDLg2Kr?=
 =?us-ascii?Q?xDlgw7/ZdVxKKCPua8ib9CTsyIhSY8u9/kAVLPQNroq1wsEQiHUhRP+oUjWl?=
 =?us-ascii?Q?KSvDCMonLfcvzYX78mu5ZwYYRV6gFCcR4+RRW/s1MNLrxCyuia77DClgfQ2G?=
 =?us-ascii?Q?Kg327LKYjQCi41WuoBPHYeeUKsD0feVuhL4WDAHWfFt2ceWPcXVBFZId4FK/?=
 =?us-ascii?Q?EhKozM+03Rp6WsN5Fwh0Hc85r2+Gx56lUqK1ejbupPil8IhZM9b+ga7FF1Os?=
 =?us-ascii?Q?2pg2l83byGNt1dpE7lCl4bTHLWWaABfX8o0pLyjBBR3VNcyq4Xc/ZARSipKx?=
 =?us-ascii?Q?K2qDa+CZoH3V18dVGf654QtiLDwPvpp2KSmWoDX90+0ORVTOfNavSA0B9/rL?=
 =?us-ascii?Q?MQimmWCsM9jJAkM245PH4coneSlLV6BnJ2UM5vP/obyXpSuUgCLD6Nn6QJbH?=
 =?us-ascii?Q?8a6v6AuGOCUaQWDhz23jr1R59FOx4mGty+YB/i5w2uuYH+KURNtb0BR1Bv6t?=
 =?us-ascii?Q?62Ob4SWqi+Sb/2PXqsN2VtBZE3zKPac65CYiVUa8YVA4MhIcm1XUK2KIcktJ?=
 =?us-ascii?Q?rHUsmkB8H23307sonM6bRNY4Muw/MVq9btPa+R0ge3qvOX0uijKqDVXb2emw?=
 =?us-ascii?Q?ObBCUgtRalYVHoUDMoCPg4KOvv/fBeEtEG9btQzQQsyhgsOgd3pAhJ1iOr+U?=
 =?us-ascii?Q?AKt/9sgGZ9NZC4AdnanJydGosju6ibfqtCjwyPVhtWtjuO6baW7PZUKOYETs?=
 =?us-ascii?Q?nase3y69R75nxtnPftmQnjytsuJs6hMhBPedUPXqimbNQRMvhG+xKS3J7x7n?=
 =?us-ascii?Q?ngnSWDOXr1hwMk9eRQgpKtdR5klMHAYyV97PkR4pTxai86SJQM1nZOYH8P3N?=
 =?us-ascii?Q?0fQMlHECentsDv6PWduIusopv/sK99WD9iIR5Rq5BoQDVxQqTqksPweHDAkY?=
 =?us-ascii?Q?mn3LDbQCJRby6hxo0LLHl3RT3NKe+QqwD+uYY/TYPs2qESAd9hc2VFHtaxm/?=
 =?us-ascii?Q?4NHzhNeMlkvEujsauzeldSJkhy88FEpkthGGOS+1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbfef97-1982-4835-9c5f-08dc1c59f75f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:26:30.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohc+K/JKgVUW9FUxFRB4PyVNoeEjdgH1bIkHabvJAmfU6ek39ZMopb+UxkMW9LuVX40wwGX/Q6qAnViv0qWNFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7616

Add tty over I3C target function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig       |   3 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 475 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d59a7eb83d13a..fca808cda87b3 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -48,3 +48,6 @@ config I3C_TARGET_CONFIGFS
 	  the target function and used to bind the function with a target
 	  controller.
 
+if I3C_TARGET
+source "drivers/i3c/func/Kconfig"
+endif # I3C_TARGET
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index c275aeae8970c..11f026d6876fe 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C_TARGET)                += target.o
 obj-$(CONFIG_I3C_TARGET_CONFIGFS)       += i3c-cfs.o
 obj-$(CONFIG_I3C)		+= master/
+obj-$(CONFIG_I3C_TARGET)	+= func/
diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
new file mode 100644
index 0000000000000..7115129eb7d5a
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_TARGET_FUNC_TTY
+	tristate "I3C target tty driver"
+	depends on I3C_TARGET
+	help
+	  I3C Target TTY Function Driver.
+
+	  General TTY over I3C target controller function drivers.
diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
new file mode 100644
index 0000000000000..16b3b9301496b
--- /dev/null
+++ b/drivers/i3c/func/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_I3C_TARGET_FUNC_TTY)              += tty.o
diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
new file mode 100644
index 0000000000000..bad99c08be0ac
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/i3c/target.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+
+#define I3C_TX_NOEMPTY		BIT(0)
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_IBI_TX		BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	struct i3c_target_func *i3cdev;
+	struct completion txcomplete;
+	spinlock_t xlock;
+	void *buffer;
+	struct work_struct work;
+	u16 status;
+	struct i3c_request *req;
+};
+
+static void i3c_target_tty_rx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	tty_insert_flip_string(&port->port, req->buf, req->actual);
+	tty_flip_buffer_push(&port->port);
+
+	req->actual = 0;
+	req->status = 0;
+	i3c_target_ctrl_queue(req, GFP_KERNEL);
+}
+
+static void i3c_target_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *sport = req->context;
+	unsigned long flags;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	kfifo_dma_out_finish(&sport->port.xmit_fifo, req->actual);
+	sport->req = NULL;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		complete(&sport->txcomplete);
+	else
+		queue_work(system_unbound_wq, &sport->work);
+
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	i3c_target_ctrl_free_request(req);
+}
+
+static void i3c_target_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct i3c_request *req = sport->req;
+	struct scatterlist sg[1];
+	unsigned int nents;
+	u8 ibi;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		return;
+
+	if (!req) {
+		req = i3c_target_ctrl_alloc_request(sport->i3cdev->ctrl, GFP_KERNEL);
+		if (!req)
+			return;
+
+		sg_init_table(sg, ARRAY_SIZE(sg));
+		nents = kfifo_dma_out_prepare(&sport->port.xmit_fifo, sg, ARRAY_SIZE(sg),
+					      UART_XMIT_SIZE);
+		if (!nents)
+			goto err;
+
+		req->length = sg->length;
+		req->buf =  sg_virt(sg);
+
+		req->complete = i3c_target_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err;
+
+		sport->req = req;
+	}
+
+	ibi = I3C_TTY_IBI_TX;
+	i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+
+	return;
+
+err:
+	i3c_target_ctrl_free_request(req);
+}
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	const struct i3c_target_ctrl_features *feature;
+	struct i3c_target_func *func = sport->i3cdev;
+	struct i3c_request *req;
+	int rxfifo_size;
+	int offset = 0;
+	int ret;
+
+	feature = i3c_target_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret)
+		return ret;
+
+	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->buffer)
+		goto err_alloc_rx_buf;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = I3C_TTY_TRANS_SIZE;
+
+	do {
+		req = i3c_target_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+		if (!req)
+			goto err_alloc_req;
+
+		req->buf = (void *) (sport->buffer + offset);
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_target_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err_alloc_req;
+	} while (req && (offset + rxfifo_size) < UART_XMIT_SIZE);
+
+	reinit_completion(&sport->txcomplete);
+
+	return 0;
+
+err_alloc_req:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	free_page((unsigned long)sport->buffer);
+err_alloc_rx_buf:
+	tty_port_free_xmit_buf(port);
+	return -ENOMEM;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, false);
+
+	tty_port_free_xmit_buf(port);
+	free_page((unsigned long)sport->buffer);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	idr_remove(&i3c_tty_minors, sport->minor);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static int i3c_target_tty_bind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	int minor;
+	int ret;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	if (i3c_target_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failure set i3c config\n");
+		return -EINVAL;
+	}
+
+	spin_lock_init(&sport->xlock);
+	init_completion(&sport->txcomplete);
+
+	ret = minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+
+	if (minor < 0)
+		goto err_idr_alloc;
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &func->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_register_port;
+	}
+
+	sport->minor = minor;
+	ret = i3c_target_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+err_register_port:
+	idr_remove(&i3c_tty_minors, sport->minor);
+err_idr_alloc:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_target_tty_unbind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_disable(func->ctrl);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 1);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+
+	free_page((unsigned long)sport->buffer);
+}
+
+static struct i3c_target_func_ops i3c_func_ops = {
+	.bind   = i3c_target_tty_bind,
+	.unbind = i3c_target_tty_unbind,
+};
+
+static int i3c_tty_probe(struct i3c_target_func *func)
+{
+	struct device *dev = &func->dev;
+	struct ttyi3c_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = func;
+	dev_set_drvdata(&func->dev, port);
+
+	INIT_WORK(&port->work, i3c_target_tty_i3c_work);
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status | I3C_TX_NOEMPTY);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->work);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_put(&sport->port.xmit_fifo, ch);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (!kfifo_is_empty(&sport->port.xmit_fifo))
+		queue_work(system_unbound_wq, &sport->work);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return kfifo_avail(&sport->port.xmit_fifo);
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_port_activate(&sport->port, tty);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+	int ret;
+
+	tty->driver_data = sport;
+
+	if (!i3c_target_ctrl_get_addr(sport->i3cdev->ctrl)) {
+		dev_dbg(&sport->i3cdev->dev, "No target addr assigned, try hotjoin");
+		ret = i3c_target_ctrl_hotjoin(sport->i3cdev->ctrl);
+		if (ret) {
+			dev_err(&sport->i3cdev->dev, "Hotjoin failure, check connection");
+			return ret;
+		}
+	}
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	int val;
+	int ret;
+	u8 ibi = I3C_TTY_IBI_TX;
+	int retry = 100;
+
+	if (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		do {
+			ret = wait_for_completion_timeout(&sport->txcomplete, timeout / 100);
+			if (ret)
+				break;
+			i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+		} while (retry--);
+
+		reinit_completion(&sport->txcomplete);
+	}
+
+	read_poll_timeout(i3c_target_ctrl_fifo_status, val, !val, 100, timeout, false,
+			  sport->i3cdev->ctrl, true);
+
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & (~I3C_TX_NOEMPTY));
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.open = i3c_open,
+	.close = i3c_close,
+	.write = i3c_write,
+	.put_char = i3c_put_char,
+	.flush_chars = i3c_flush_chars,
+	.write_room = i3c_write_room,
+	.throttle = i3c_throttle,
+	.unthrottle = i3c_unthrottle,
+	.wait_until_sent = i3c_wait_until_sent,
+};
+
+DECLARE_I3C_TARGET_FUNC(tty, i3c_tty_probe, NULL, &i3c_func_ops);
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(
+		I3C_TTY_MINORS, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttySI3C", i3c_tty_driver->name = "ttySI3C",
+	i3c_tty_driver->minor_start = 0,
+	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	i3c_tty_driver->init_termios = tty_std_termios;
+	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
+					       CLOCAL;
+	i3c_tty_driver->init_termios.c_lflag = 0;
+
+	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
+
+	ret = tty_register_driver(i3c_tty_driver);
+	if (ret)
+		goto err_register_tty_driver;
+
+	ret = i3c_target_func_register_driver(&ttyi3c_func);
+	if (ret)
+		goto err_register_i3c_driver;
+
+	return 0;
+
+err_register_i3c_driver:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_register_tty_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_target_func_unregister_driver(&ttyi3c_func);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.34.1


