Return-Path: <linux-kernel+bounces-134759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0289B679
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1DB1F2235E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF0F503;
	Mon,  8 Apr 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MwwzkUxy"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268E79EA;
	Mon,  8 Apr 2024 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547410; cv=fail; b=bRb6hIdjZcbBNB31EDLt0IE60ps23+iL4Jo8zk3oJoX6Ywx7wHmFI7XNc6dyz5FVLrwS9K4yXfGc0qXKX9ky6stxhDVX2FC9X8/W6e7jWfbDTctgKFhlYAiQ6N7NxxyXOAFydgF7coKKY6qxNpO7RTRoAYFIfKFkmPgzY6cxQL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547410; c=relaxed/simple;
	bh=WhbR4GTxOSKcl1KYo4+lWZjSx6OC3WMaT/3ec8NLZUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmvImImAE3AaC1n+s+qXDJ6d0P19mt4OQmbV7lYzUYFM2RL1k3bZDtR0wn4F8Ml0ZSpXIcF73uZSz5CoPNh3PagSosgGM3UFYS4+Bv1WxHgstktecrf7/8v2f+uqyCwbx5BbO1fOAcLhvsZo+sXh/igN/d9f4t2Z8pjxh/NcxPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MwwzkUxy; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE9U1XgvbcbjQGSOW08hOKIBu/BCO8RNUK+e1f41PSrK+DsbqRvoVrpP4eMI2dfV/Bnvem6hO7svf0ciK+gfw9A+r2z6uBSzFDF3ZwvnZPk6ggClSuwkU/De2Hjinsnur3QsULn9XNvakjNL7q0HPjx/yh9uL+H/cHhW7bMXS8skEJQXjhxnf6YTNuCkVIXz2kTNS9DcvShwjEY4XWOeBs8YguWpM6ljk+wdd594UnxDo2O1hxMZivh6+2fuX3pu0SesYHOt9s974t+VBo2/PGvpV0laH1Kzj8O7FXTf9Cjx82ZM+Matg/s/adXTZyVpsO0IIh6y2TxLZLbi+/51hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdW0SNkOjR1tcmS6Pv0SI6X7idRxLDKR79Uz6pF5wxA=;
 b=cnrWqnxBJZ/bp0dyCRqdaxdYvqnSkT1WwKnzH0QinF4U0wKZd4tos/T6lhQ6RElM7Pi1LsNT5jCDhIzsLwE6r1+Qy0p1LqPxHDfmX+2HJUGq+IH05AkDOkjLE5ghpbBWHrac+r7BK+peB6cIe3uxfZs7ffk3F0W9ob+5Y75pDf46fc5ZA59NPbXCdmEEBPab/yu9f3FadPOm9b06mi8ZunxhfpgBqNDNXfqO3Im30WEseMKJXVZY9kxCrqhRUuR4e1ulW+ahw5LdRSb7vldYJRHZetWZ4wJoKr3zExSACirnen+ZOnpXisYC5SjqGgBrEg9gYvxKoM5zWLEAY5knLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdW0SNkOjR1tcmS6Pv0SI6X7idRxLDKR79Uz6pF5wxA=;
 b=MwwzkUxy37s0gDaZ8cg9af9LhUyamhT7QwnWjVbbjJXAUNGzUXbMxr2vnX9Iku5/0gL+PPd1tTw3ou6Ur9xsOT3qtKCYQC92OXECUxTzBDJGljgGqQ5Bx+IKAs9Ot9CapUtGeyFd5EllYHlnJPXEICyYqjHxsHNQGMLRIIuQsdRlbUkJZwNhas1WoGquMsTShFoj4pxcUz+i3PmNF1S5HbIfb3VrN0Yf07oDcBpc8TuH0psefqxohqI8RA0k50v2XJbwhKDDI63Nx1ZpqPhrf1h7cF59mE50gR59WsTPLfA7hPanlPe26xXjqCKBz/S4EvxHyqD65o7zyfXhsj1c3Q==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:36:42 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 03:36:42 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v5 3/3] serial: 8250_pnp: Support configurable reg shift property
Date: Mon,  8 Apr 2024 11:36:24 +0800
Message-ID:
 <PSAPR06MB4952D617B802206B51758C32C9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712472167.git.albanhuang@tencent.com>
References: <cover.1712472167.git.albanhuang@tencent.com>
Content-Type: text/plain
X-TMN: [VZJPVSEk6YzzcUEqQvyxglAmKWwm8DNf]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <3049b47a51fb403d6b1e97e63fcae70e1a810963.1712472167.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|KL1PR06MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0da03a-2628-418b-d662-08dc577d1b2f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BwoO+chS6dOQ9T/J09lzEj+AhTOrOpJ7lx0C8CjVvoCOhIRq+7unyXoipgBdVDEfxSfBN+S/GloKBArGSKrwvhM4JPiNPfMxPX9IZMd2Aft9fwuw31IRo6qPNQE5VlJEGsb8svKp2IVhf0rIcct8rQgGQhScfzzlNgMuCC2QUSQCdvvGWM10YvOR5YLl3O/hIuUjyKCABZk62tWTTfv7DIn8JUJE8gFjy9gz1X4e7xZ05l8xQvFYgvt8sLrWHdNv83O9TNHQiHzqmrY7jmw+fK/guoSg+oXxX8W/tVaADnIvYFHa2XCabKleq3aFz0N+RohR5KDpot+3B0YO8H/7ndRRySxbD8v6sZHNW2Y6yrFUghK0WMRYWHRN1Qbx7MdlpStr9jirRP7xV4WpWQahGLOU9LLOQDwmnabI8ZYKCnDIAUUMMfRragHuxpip8KcH7eIMi4yZcI9K2pkWjx8mnY5pmk7Pl4K0lgGVeSqval9OCjyTAakw1fNqELtupzIz6J9BoJ3509kVRwaAhdPHot58+EsXeHStfU9j75EEFE+5LtizXwtq1S3erFUi+Ohs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnsQhB5BSm5LxjZHdoQYhrBxf9DKPEvMulBmSXs7uW95X58ZRMz1E/sObU33?=
 =?us-ascii?Q?XxzZzl1szv4fMTWjtCi7Sordl06gIaeOH57QYx8qCYTUE6W7r0TuCNxEf4G7?=
 =?us-ascii?Q?2OR6GhwWqN87buyewn/yg4lMXJcyDw34h+hgzIJpvTgs1ywiXSaDlWzYbvqz?=
 =?us-ascii?Q?9+4wfspgFZgxLhYBhha+ZIL1DwtrYpT0Xu66u5D0NM6pjEbL4LNLo43OJC2S?=
 =?us-ascii?Q?yo/obDu4hrBVdAuuBfoB4xAUsG61nvScVKdBb4rptNYoFCl/p9GY6NoXIl/+?=
 =?us-ascii?Q?gvJxrHKoY2mlXxGTwvukV/rn/A/1Vj6bMt0B4kcV8rQl6LAxC/QrXYP4Dq6T?=
 =?us-ascii?Q?kABVd1FBW8wppdqeM/Bunaq6GjWxIMkc+lm8VPINuvSUofwAlHp8xgHa647D?=
 =?us-ascii?Q?LJN0b4NJTvZHssfB9eMmSIQm69K1ydY1ZDs2/Qdf/cNCwEdN0wtMJAtT/Wec?=
 =?us-ascii?Q?dtZKJwILe/My882W18ZvDfe8c12SYJ0ThRZPkETRQfCWiLSdQi4p/UcW5pim?=
 =?us-ascii?Q?Z89Xqv3B9BthQEv3EtjzoqTyb+dO7G8cTSBJjuKqM1dfd9JRRR8+es1m2QX+?=
 =?us-ascii?Q?t4FWT/RbmwTMXXEfm4vOTVPfj22BISA69a+b1kLoWYNVTX2jaF0zBaMCtHMV?=
 =?us-ascii?Q?mVupFJY/ELmPI7NoyBOSBWmtVylYNDNkFxGECNKbhZm+uXNMOK0wFDeIdTcM?=
 =?us-ascii?Q?VkRkVnNvJutC/d+MfmqRCPGy+zxmg0DSJKW8/UqZnw5LIAzFpCZIk0S9Zc9T?=
 =?us-ascii?Q?sLFGWazqRAOslt29bhO+oDcfaOZjYnpC7XL4IYROK4ZKh9pwY/PSPkH4+kMC?=
 =?us-ascii?Q?/jlAv7pTMjBKwSA7vXt00TOabbooSK/5NWyJA8xyrMTEp6X16I29lncqsiR5?=
 =?us-ascii?Q?qdlIWrB3/4P1HN8OieoqMnBLrvECBFqNfpT9A4dcnHJs6ScnQwhMJZMogqxj?=
 =?us-ascii?Q?1QEP+GM1WSqXdUQWt84gtrSYyz2vY4uRbYuZ+r7nzvQTafjaLepMCg3HLd5T?=
 =?us-ascii?Q?reCpcNDx4RPTnZJjXTdHWXiFUVQxavvTbPKGlOirKmxKyWUVZRFYZ1uz90AP?=
 =?us-ascii?Q?JB73r/XILWDUizDVzU70wmo/INqU3OBI3n8BVIxeMmtygPQ6qJJTbru+JdvX?=
 =?us-ascii?Q?jB/LWcWPhkDZQoLlQ4x7WYJaLIvIOSJV8NVNbImCkYuGJCm+hiLJGZEaw3M8?=
 =?us-ascii?Q?427Osj+SE4YBtBDcPTj/IlzX0mj8tI7+oeeVxcw2mEuWDknN9BGi5M02TvA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0da03a-2628-418b-d662-08dc577d1b2f
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:36:42.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v4 -> v5: modify to obtain the value of mapsize through the pnp_mem_len function,
          add annotations for the iotype variable, delete excess uart.port.flags operation
v3 -> v4: dependent on two pre patches: "pnp: Add dev_is_pnp() macro" and
          "serial: 8250_port: Add support of pnp irq to  __uart_read_properties()",
          the iotype is reserved, the mapsize is initialized, fix the UPF_SHARE_IRQ
	  flag, check for IRQ being absent
v2 -> v3: switch to use uart_read_port_properties(), change "Signed-off-by" to "Reviewed-by" and "Tested-by"
v1 -> v2: change the names after "Signed off by" to the real names

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..8f72a7de1d1d 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -435,6 +435,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, line, flags = dev_id->driver_data;
+	unsigned char iotype;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -443,37 +444,46 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
 		uart.port.mapbase = pnp_mem_start(dev, 0);
-		uart.port.iotype = UPIO_MEM;
+		uart.port.mapsize = pnp_mem_len(dev, 0);
+		iotype = UPIO_MEM;
 		uart.port.flags = UPF_IOREMAP;
 	} else
 		return -ENODEV;
 
-	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
-		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
-		 uart.port.irq, uart.port.iotype);
+	uart.port.uartclk = 1843200;
+	uart.port.dev = &dev->dev;
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+
+	ret = uart_read_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	/*
+	 * The previous call may not set iotype correctly when reg-io-width
+	 * property is absent and it doesn't support IO port resource.
+	 */
+	uart.port.iotype = iotype;
 
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
 		uart.port.type = PORT_8250_CIR;
 	}
 
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
-		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
-	uart.port.dev = &dev->dev;
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %#lx, mem %#llx, size %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
+		 (unsigned long long)uart.port.mapsize, uart.port.irq, uart.port.iotype);
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.17.1


