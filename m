Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432B7C7823
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442873AbjJLUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442704AbjJLUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:51:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6139D;
        Thu, 12 Oct 2023 13:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF++oSjpprVdxV7NOLI8JYhveSHLzEu5kWBZUXlNrhWMbhq26t/9VVtTyvUaHZq+jxEzyT3IGYgHwHBgIDOsZTpRXm28Jk9eCFNp3vdj9yo7kXPmNNmvjg8f7ETvUgX+RUYdY3K1MwWbYHcRYN/BpG+pLD2HhGM49yhVnIytxjYHXgp/MsnuQMOxcx0dGNW+AcjaOgZ5lcvXtTkRTvNKzdw+hWecwdXJanj7TU+V9AATBXdrPEBREkwYg7XFCw6EuV/8ZlqXPINGcpM87TP6wORIccgc7WTFKD04yxZSLnPllgk+1rY6uOzMdbOf4SVJTSVNpeZbQQqdhGQFWh7wMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRhsWdYrPQ4MWMECzkOCqTvivMfhxcrP2ejNMTfkT8U=;
 b=dR7dSjxEeZBMJaEZHkPVy2YV3wi7C9Q1CG6jOVIEuHh2oTtqrX9q9+49cmxYrTcVPu/lo/dqz8A5CePTeMFJDbPRol3H7anZy1MtPMwudhrkkYuDUNj3QdC7+ehH606C7994csH6kp8OMsDPyRYrK2rzrIQAMyyUp2UefyU56kCuJO3zxwmFe6sIMtgbDiFJlFnYnnV+vy22FZybalDYSRlAUYLqb6L52loeeqQ2I0S6i2GwJVOZOeYEVVO0GbyjSDZTQ8eJLTmxcKoxnCAb3tCH2f3KIdBaqf9TeJlPWf+z29XVzyWqDkBlzMXaz7mO0nUV8eGlVjIX6tKghnzpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRhsWdYrPQ4MWMECzkOCqTvivMfhxcrP2ejNMTfkT8U=;
 b=ecp2/Fm2htEevUfa1/NzzgUAwPiMCJuICbsxw9bj2YtsIFaJrJxDNMMK8VHTwH3GuAejT/JgHkq2ZDu1ZHMGxojeXnb/kEzZX3sEFwPb+xFEKVEEj9K/8nlbELOsr7mPr/h2cfIQLHcf32DzaNZVnpF4lxvzVTWjEob78fDsu8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM6PR04MB6608.namprd04.prod.outlook.com (2603:10b6:5:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30; Thu, 12 Oct
 2023 20:51:41 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::3205:e23b:425e:a57]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::3205:e23b:425e:a57%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 20:51:41 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 tty-next 2/2] serial: 8250: add driver for NI UARTs
Date:   Thu, 12 Oct 2023 15:51:11 -0500
Message-Id: <20231012205112.112261-3-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231012205112.112261-1-brenda.streiff@ni.com>
References: <20231012205112.112261-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM6PR04MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 5794610b-5765-4550-51be-08dbcb65099e
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOJHvIYIfiVQIPZzkbjfkZYS2vUbsFFDg5o4Cye+m8We6o3nHW9IA0I3BhaQDB9rS2b/L3T2VEqNGiAU+O4HQDWglC1gF0xztPDkEZ0MLGjOi5NPkqs+itCEwdc/eXfFWiSxh433cspxGCeIRDN1s9bM6t6UDjItv7QeOnvx67F54pqxBUhiLpQa0BoqyYFg/eNdUMmRj5R08Z5rK7BnkbI+M182Ew9hbV1wQkR+l8C46BDCn6mUYiArJW/zgBZiH/sySDRx0mgkQ8R/l4sZgDO61zQaYeNyWKZ5ENLqC1LKMRKn4g5PbQcz+EJx7wnQ7yyABHQVmSFzXta+ev/M3dxBlae3zfz1WIrQStg5A+s+6RTZ8ajrcJJfna53LqN0QOG58qri1+jvTeX+dx9y7qEBrg3uzfSeu8QrTUEhq716b5uKmTulaTC6ru0u8OENJdlFH76W/7bcAVrKaBWfxKW5UKFScmlydRtlYVabX46h8mEuSnEOjVOhTTQH00w7CGqgu8TsRwnzApslj3RdoIgdZj6Ryd8Ke5TCJRXkwDz5T8NW18t2Yi21nF2vAcGXQnZjo1j2vc3oOIHleS9mjdbA0lrGKwpnvX5Sr6gB9nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(109986022)(1800799009)(451199024)(26005)(6506007)(44832011)(36756003)(316002)(83380400001)(66476007)(54906003)(66556008)(66946007)(2616005)(38100700002)(1076003)(86362001)(6486002)(478600001)(2906002)(6666004)(6512007)(5660300002)(8936002)(8676002)(4326008)(30864003)(41300700001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QbxiPk7xxi1NLwynInqiYWwyAz7FksCD0xh/4RSSgNSRKjjzvtI4rRy1sTC2?=
 =?us-ascii?Q?wp1qnqc5+gXbgR+zGVjaVLZ1Q1s/SMx1todcnSC3clCa0HdI8TZQgo3KXr+o?=
 =?us-ascii?Q?rhl4hWw1b1/wD/QAXkq5/hbu12rA2HOtB+0jGoAPTXcCJIN27EXYD5ITiU/o?=
 =?us-ascii?Q?twGFpuoN7+r/wniUECVkIkbTdQDsqJcghLGbNgVdDnxrM73swPQfZLh9eRU1?=
 =?us-ascii?Q?QRhOKirOn7mcvfvKNfrB6oBBQFzBLw77XHdZfopr07lI7xg2nNblHtJ7vcaz?=
 =?us-ascii?Q?MHIHvNhISoQLQFNJDJf5mV3n2Dm5BLHytHeTQacWQfuwS6vY+CNIjZ+z+vMx?=
 =?us-ascii?Q?F9d9BLM9m+MybUfivE5SE9XqZGgrVX0gsuRLV67UTL9ule7GJDtw48rzHTfZ?=
 =?us-ascii?Q?y8PRPnQrl1okCeIhMBe94oDx3WXkKTWrRsN21cSmnzs0FxhSmjFXB6gz0ktr?=
 =?us-ascii?Q?1CKTnoF+kxj44IDj45XbBTWMgSiukf2o5DtezqZalpTPid0TQJrs5fOjPG4J?=
 =?us-ascii?Q?NZJA7zi294/+whJQFe1mEteseggc6iZrp/Om43Bp/2128g79lXxBlZEwadT3?=
 =?us-ascii?Q?M0uit/0iv5Hn54SlXqG8bY2f64P101+zxGjY23Ie7HFXrET400QYslX1CUeQ?=
 =?us-ascii?Q?tAS6Fuxvh+j4fQocQWgdjlYZnrGVDTGLDOLO0zItWSCaECPLJoU5MeckGor/?=
 =?us-ascii?Q?9Bd4gXhM4RRgqFCqWHkzRhdGLiMh1GV43nAtt0fm0kaSCetxf8iELs4d7oY2?=
 =?us-ascii?Q?NPhphKl7P0IO99FBxDI9CCkRaXvMe83PZQOfX+a0HbQXDF13S2bq7STMKITB?=
 =?us-ascii?Q?yMJQNXfrKgZcZ0NfsB1ezEUVva2+5wnHxofF/qlG9Hz2idMUqgJ4quoK3jB6?=
 =?us-ascii?Q?ciLxN+T6LsaLK0YVEZ7+cehnCIQu+J+Ppl+EMX6foEm8v1Dh5Osg8L7o4eor?=
 =?us-ascii?Q?7uZScoE78qxclxontM+EHb2Y+Tf3uqNwwUvHrU7OOdxQLos0nXLvtUbaCaMI?=
 =?us-ascii?Q?jyknk/BO4UvNaRpcZco6hNgx921Rm6xww18uKNmnOt1fVRzNMIO5K/9xdPsq?=
 =?us-ascii?Q?9qZ3S0Uz8+qIbY0bcXGAqNOLj8wEgC0J/HMClRQd5W2oUHhwRmZcCd84v3jE?=
 =?us-ascii?Q?BBOJ9hCf5x7SNEwKIPbV0+knC6H1GSo8p8fpCX1kjR7TZUPWzRGp035AeSb5?=
 =?us-ascii?Q?PSqkLEqRUCgF/c04ZXDbuzmSg+Vq4IoeRPLFW/jNFPW+TdG9gIJ2Qebi59A4?=
 =?us-ascii?Q?J86nDEDWY/GbwUZB4kYOdhWwoeIjh954+vuO8SnsTQDGrIJqwRM8htfJliPf?=
 =?us-ascii?Q?kShLlGBYuhSQUgerigwjFMRVezM+3CUnw8FYcVNhIW9UeNkmZl3HJ2HnSzVu?=
 =?us-ascii?Q?967/KnlLLToxc0dkBOY3r9SqQLhFPUeipNOUiOup3CzbCRtFJ9uYE1WuJx6B?=
 =?us-ascii?Q?AnAVVaM+g1dqv1JtT6pI2tpf/ZYrbXpotSnxgsCyo9tlsLOCyhYz8UJzY3WH?=
 =?us-ascii?Q?+iiIIVreYNwaxERcZFOUFJD4XJ+qELJEz20eenV0JvnizxF54DIUhduQob31?=
 =?us-ascii?Q?iWFBLPiekjX3UYBEj/qvihPN8ukNYaaDEhJWAKVY?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5794610b-5765-4550-51be-08dbcb65099e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 20:51:41.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bg0ICp3hA96lfSfI0SPa0S5Erl+KYfedM3MJOa4ZjQpHdEiWP9f8WPpOkgfYm/LBHIGqcx473+a8NXamf9MMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The National Instruments (NI) 16550 is a 16550-like UART with larger
FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
patch adds a driver that can operate this UART, which is used for
onboard serial ports in several NI embedded controller designs.

Portions of this driver were originally written by Jaeden Amero and
Karthik Manamcheri, with extensive cleanups and refactors since.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Jason Smith <jason.smith@ni.com>
---
 MAINTAINERS                       |   7 +
 drivers/tty/serial/8250/8250_ni.c | 478 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |  13 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 499 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..fa52de23f0a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14664,6 +14664,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
 F:	drivers/mtd/nand/
 F:	include/linux/mtd/*nand*.h
 
+NATIONAL INSTRUMENTS SERIAL DRIVER
+M:	Brenda Streiff <brenda.streiff@ni.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/ni,ni16550.yaml
+F:	drivers/tty/serial/8250/8250_ni.c
+
 NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
new file mode 100644
index 000000000000..fd1e15156a32
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NI 16550 UART Driver
+ *
+ * The National Instruments (NI) 16550 is a UART that is compatible with the
+ * TL16C550C and OX16C950B register interfaces, but has additional functions
+ * for RS-485 transceiver control. This driver implements support for the
+ * additional functionality on top of the standard serial8250 core.
+ *
+ * Copyright 2012-2023 National Instruments Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/clk.h>
+
+#include "8250.h"
+
+/* Extra bits in UART_ACR */
+#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
+
+/* TFS - TX FIFO Size */
+#define NI16550_TFS_OFFSET	0x0C
+/* RFS - RX FIFO Size */
+#define NI16550_RFS_OFFSET	0x0D
+
+/* PMR - Port Mode Register */
+#define NI16550_PMR_OFFSET	0x0E
+/* PMR[1:0] - Port Capabilities */
+#define NI16550_PMR_CAP_MASK			GENMASK(1, 0)
+#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
+#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
+#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
+#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */
+/* PMR[4] - Interface Mode */
+#define NI16550_PMR_MODE_MASK			GENMASK(4, 4)
+#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
+#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */
+
+/* PCR - Port Control Register */
+/*
+ * Wire Mode      | Tx enabled?          | Rx enabled?
+ * ---------------|----------------------|--------------------------
+ * PCR_RS422      | Always               | Always
+ * PCR_ECHO_RS485 | When DTR asserted    | Always
+ * PCR_DTR_RS485  | When DTR asserted    | Disabled when TX enabled
+ * PCR_AUTO_RS485 | When data in TX FIFO | Disabled when TX enabled
+ */
+#define NI16550_PCR_OFFSET	0x0F
+#define NI16550_PCR_RS422			0x00
+#define NI16550_PCR_ECHO_RS485			0x01
+#define NI16550_PCR_DTR_RS485			0x02
+#define NI16550_PCR_AUTO_RS485			0x03
+#define NI16550_PCR_WIRE_MODE_MASK		GENMASK(1, 0)
+#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
+#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
+
+/* flags for ni16550_device_info */
+#define NI_HAS_PMR		BIT(0)
+
+struct ni16550_device_info {
+	u32 uartclk;
+	u8 prescaler;
+	u8 flags;
+};
+
+struct ni16550_data {
+	int line;
+	struct clk *clk;
+};
+
+static int ni16550_enable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_disable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_rs485_config(struct uart_port *port,
+				struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = container_of(port, struct uart_8250_port, port);
+	u8 pcr;
+
+	pcr = serial_in(up, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* RS-485 */
+		dev_dbg(port->dev, "2-wire Auto\n");
+		pcr |= NI16550_PCR_AUTO_RS485;
+		up->acr |= NI16550_ACR_AUTO_DTR_EN;
+	} else {
+		/* RS-422 */
+		dev_dbg(port->dev, "4-wire\n");
+		pcr |= NI16550_PCR_RS422;
+		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
+	}
+
+	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
+	serial_out(up, NI16550_PCR_OFFSET, pcr);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return 0;
+}
+
+static bool is_pmr_rs232_mode(struct uart_8250_port *up)
+{
+	u8 pmr = serial_in(up, NI16550_PMR_OFFSET);
+	u8 pmr_mode = pmr & NI16550_PMR_MODE_MASK;
+	u8 pmr_cap = pmr & NI16550_PMR_CAP_MASK;
+
+	/*
+	 * If the PMR is not implemented, then by default NI UARTs are
+	 * connected to RS-485 transceivers
+	 */
+	if (pmr_cap == NI16550_PMR_NOT_IMPL)
+		return false;
+
+	if (pmr_cap == NI16550_PMR_CAP_DUAL)
+		/*
+		 * If the port is dual-mode capable, then read the mode bit
+		 * to know the current mode
+		 */
+		return pmr_mode == NI16550_PMR_MODE_RS232;
+	/*
+	 * If it is not dual-mode capable, then decide based on the
+	 * capability
+	 */
+	return pmr_cap == NI16550_PMR_CAP_RS232;
+}
+
+static void ni16550_config_prescaler(struct uart_8250_port *up,
+				     u8 prescaler)
+{
+	/*
+	 * Page in the Enhanced Mode Registers
+	 * Sets EFR[4] for Enhanced Mode.
+	 */
+	u8 lcr_value;
+	u8 efr_value;
+
+	lcr_value = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr_value = serial_in(up, UART_EFR);
+	efr_value |= UART_EFR_ECB;
+
+	serial_out(up, UART_EFR, efr_value);
+
+	/* Page out the Enhanced Mode Registers */
+	serial_out(up, UART_LCR, lcr_value);
+
+	/* Set prescaler to CPR register. */
+	serial_out(up, UART_SCR, UART_CPR);
+	serial_out(up, UART_ICR, prescaler);
+}
+
+static const struct serial_rs485 ni16550_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	/*
+	 * delay_rts_* and RX_DURING_TX are not supported.
+	 *
+	 * RTS_{ON,AFTER}_SEND are supported, but ignored; the transceiver
+	 * is connected in only one way and we don't need userspace to tell
+	 * us, but want to retain compatibility with applications that do.
+	 */
+};
+
+static void ni16550_rs485_setup(struct uart_port *port)
+{
+	port->rs485_config = ni16550_rs485_config;
+	port->rs485_supported = ni16550_rs485_supported;
+	/*
+	 * The hardware comes up by default in 2-wire auto mode and we
+	 * set the flags to represent that
+	 */
+	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+}
+
+static int ni16550_port_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	return ni16550_enable_transceivers(port);
+}
+
+static void ni16550_port_shutdown(struct uart_port *port)
+{
+	ni16550_disable_transceivers(port);
+
+	serial8250_do_shutdown(port);
+}
+
+static int ni16550_get_regs(struct platform_device *pdev,
+			    struct uart_port *port)
+{
+	struct resource *regs;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		port->iotype = UPIO_PORT;
+		port->iobase = regs->start;
+
+		return 0;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (regs) {
+		port->iotype = UPIO_MEM;
+		port->mapbase = regs->start;
+		port->mapsize = resource_size(regs);
+		port->flags |= UPF_IOREMAP;
+
+		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
+					     port->mapsize);
+		if (!port->membase)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	dev_err(&pdev->dev, "no registers defined\n");
+	return -EINVAL;
+}
+
+static u8 ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
+{
+	/*
+	 * Very old implementations don't have the TFS or RFS registers
+	 * defined, so we may read all-0s or all-1s. For such devices,
+	 * assume a FIFO size of 128.
+	 */
+	u8 value = serial_in(uart, reg);
+
+	if (value == 0x00 || value == 0xFF)
+		return 128;
+
+	return value;
+}
+
+static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	up->mcr |= UART_MCR_CLKSEL;
+	serial8250_do_set_mctrl(port, mctrl);
+}
+
+static int ni16550_probe(struct platform_device *pdev)
+{
+	const struct ni16550_device_info *info;
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = {};
+	unsigned int prescaler = 0;
+	struct ni16550_data *data;
+	const char *portmode;
+	int txfifosz, rxfifosz;
+	int rs232_property;
+	int ret;
+	int irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&uart.port.lock);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = ni16550_get_regs(pdev, &uart.port);
+	if (ret < 0)
+		return ret;
+
+	/* early setup so that serial_in()/serial_out() work */
+	serial8250_set_defaults(&uart);
+
+	info = device_get_match_data(dev);
+
+	uart.port.dev		= dev;
+	uart.port.irq		= irq;
+	uart.port.irqflags	= IRQF_SHARED;
+	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.startup	= ni16550_port_startup;
+	uart.port.shutdown	= ni16550_port_shutdown;
+
+	/*
+	 * Hardware instantiation of FIFO sizes are held in registers.
+	 */
+	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
+	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
+
+	dev_dbg(dev, "NI 16550 has TX FIFO size %d, RX FIFO size %d\n",
+		txfifosz, rxfifosz);
+
+	uart.port.type		= PORT_16550A;
+	uart.port.fifosize	= txfifosz;
+	uart.tx_loadsz		= txfifosz;
+	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
+	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
+
+	/*
+	 * Declaration of the base clock frequency can come from one of:
+	 * - static declaration in this driver (for older ACPI IDs)
+	 * - a "clock-frquency" ACPI or OF device property
+	 * - an associated OF clock definition
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	if (device_property_read_u32(dev, "clock-frequency",
+				     &uart.port.uartclk)) {
+		data->clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (data->clk)
+			uart.port.uartclk = clk_get_rate(data->clk);
+	}
+
+	if (!uart.port.uartclk) {
+		dev_err(dev, "unable to determine clock frequency!\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (info->prescaler)
+		prescaler = info->prescaler;
+	device_property_read_u32(dev, "clock-prescaler", &prescaler);
+
+	if (prescaler != 0) {
+		uart.port.set_mctrl = ni16550_set_mctrl;
+		ni16550_config_prescaler(&uart, (u8)prescaler);
+	}
+
+	/*
+	 * The determination of whether or not this is an RS-485 or RS-232 port
+	 * can come from a device property (if present), or it can come from
+	 * the PMR (if present), and otherwise we're solely an RS-485 port.
+	 *
+	 * This is a device-specific property, and thus has a vendor-prefixed
+	 * "ni,serial-port-mode" form as a devicetree binding. However, there
+	 * are old devices in the field using "transceiver" as an ACPI device
+	 * property, so we have to check for that as well.
+	 */
+	if (!device_property_read_string(dev, "ni,serial-port-mode", &portmode) ||
+	    !device_property_read_string(dev, "transceiver", &portmode)) {
+		rs232_property = strncmp(portmode, "RS-232", 6) == 0;
+
+		dev_dbg(dev, "port is in %s mode (via device property)",
+			rs232_property ? "RS-232" : "RS-485");
+	} else if (info->flags & NI_HAS_PMR) {
+		rs232_property = is_pmr_rs232_mode(&uart);
+
+		dev_dbg(dev, "port is in %s mode (via PMR)",
+			rs232_property ? "RS-232" : "RS-485");
+	} else {
+		rs232_property = 0;
+
+		dev_dbg(dev, "port is fixed as RS-485");
+	}
+
+	if (!rs232_property) {
+		/*
+		 * Neither the 'transceiver' property nor the PMR indicate
+		 * that this is an RS-232 port, so it must be an RS-485 one.
+		 */
+		ni16550_rs485_setup(&uart.port);
+	}
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		goto err;
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	clk_disable_unprepare(data->clk);
+	return ret;
+}
+
+static int ni16550_remove(struct platform_device *pdev)
+{
+	struct ni16550_data *data = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(data->clk);
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static const struct ni16550_device_info ni16550_default = { };
+
+static const struct of_device_id ni16550_of_match[] = {
+	{ .compatible = "ni,ni16550", .data = &ni16550_default },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ni16550_of_match);
+
+/* NI 16550 RS-485 Interface */
+static const struct ni16550_device_info nic7750 = {
+	.uartclk = 33333333,
+};
+
+/* NI CVS-145x RS-485 Interface */
+static const struct ni16550_device_info nic7772 = {
+	.uartclk = 1843200,
+	.flags = NI_HAS_PMR,
+};
+
+/* NI cRIO-904x RS-485 Interface */
+static const struct ni16550_device_info nic792b = {
+	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
+	.uartclk = 22222222,
+	.prescaler = 0x09,
+};
+
+/* NI sbRIO 96x8 RS-232/485 Interfaces */
+static const struct ni16550_device_info nic7a69 = {
+	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
+	.uartclk = 29629629,
+	.prescaler = 0x09,
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ni16550_acpi_match[] = {
+	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
+	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
+	{ "NIC792B",	(kernel_ulong_t)&nic792b },
+	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
+#endif
+
+static struct platform_driver ni16550_driver = {
+	.driver = {
+		.name = "ni16550",
+		.of_match_table = ni16550_of_match,
+		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
+	},
+	.probe = ni16550_probe,
+	.remove = ni16550_remove,
+};
+
+module_platform_driver(ni16550_driver);
+
+MODULE_AUTHOR("Jaeden Amero <jaeden.amero@ni.com>");
+MODULE_AUTHOR("Karthik Manamcheri <karthik.manamcheri@ni.com>");
+MODULE_DESCRIPTION("NI 16550 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d91924cb9b21..ec9ba0e0af2a 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -567,6 +567,19 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_NI
+	tristate "NI 16550 based serial port"
+	depends on SERIAL_8250
+	depends on (X86 && ACPI) || (ARCH_ZYNQ && OF) || COMPILE_TEST
+	help
+	  This driver supports the integrated serial ports on National
+	  Instruments (NI) controller hardware. This is required for all NI
+	  controller models with onboard RS-485 or dual-mode RS-485/RS-232
+	  ports.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_ni.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index ea2e81f58eac..002256fd152e 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
+obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
-- 
2.30.2

