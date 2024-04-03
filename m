Return-Path: <linux-kernel+bounces-129202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3A8966E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F271F26EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC76EB40;
	Wed,  3 Apr 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QfAK6B14"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C476CDD0;
	Wed,  3 Apr 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130113; cv=fail; b=QrMQPxJfxHlDob3qyxG5Z2RDPJ3bTeLiVbhs8j0o4V5HcAvNhWgJ6odMg0ovcbGe/68q9aih2z5gBi8XC1aPvt0YZ4qL9bW2xvP1kcgrnWPSJRNaY7lnxRgynid9bb4VsGij3W8EEsDSzDCVtmL6hohaHkSCBdfOKY9jhwSKC9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130113; c=relaxed/simple;
	bh=881NHA0BtZ4tqqs8t1lsBhG7teepmihRPDHe9zK8s40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKlhKuSl/f32+5KUGwoZrw9oaL+T5/L8MjrNqxXdYB54KSFgpOxYAxDyg8veMIFldGgx4DGJeuNXbq74hDBv/IL9Lj2xApAcDY1ET/An5VagPPs5sO7JyPks56A5P5izj6nzjnZVjOCQcbqj3mGvDS0e+aKb+vYKZoJwqJBW2Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QfAK6B14; arc=fail smtp.client-ip=40.92.52.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkhnbDOvamyfh/KgcJuQHWuZPw2iX291vBaoPdGndu8EONVYjlxc73U/1SMaqYlXazfEAMdyr/QvLlI7xYb9DfjbY0R80be4XtFFp2o8g2RNc+1VC2Z7UqqklcA6cMTPoN+DrcSUAIRRjnTepIKk4puDGMR4FNAbbZE+AOM9h0//iz+KeJRGyxwye4i56QDCB3oB50YFK+UK8VTTEVUqIP3e+kaA4XOQY4RketvGPLGn1tCq2w3x4/DtFvCeklDdz7EA7a0GC6McPooVG6Yj+PgRJ4szWCBtFLu03nh/iWxgeWJidb3wq+oNfYY/9dR4hLaYZyVaagb/MMgadnKqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFXfiz9azTt7Z3i5D/gU09G7v3vILofamOdAmxTAR/E=;
 b=njcAnwmLVgs8it16lMnv/o88VjFURiWU6CtS7R550WiHoh3livobiQ4BuVJeKoT8DPp368WCvhxSuGHOee7c9RAjQ5yiH0HqT2b6XtJekCieHJnAKkWzEoR8Jxn+B5wvdFMg1CxoVyd4qMlNqBm+fCx28lOm6I9k9Tb2CJIPy/2zLyXQNUz7MgFu6FzZf313pheIDI3ezhyz42bYRfAvbwztcKXeXEetUPTwp15e9gMq6PXtRzmTE4UHaixbinmDOF2bK20wWBQw/Kb4EsBgUOhPwPSYd5Hjoo9GI4MOmxQyqbWEpnu9IiCWTY4CYwEcyhaieZdXGHh0l7jamR71bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFXfiz9azTt7Z3i5D/gU09G7v3vILofamOdAmxTAR/E=;
 b=QfAK6B14WFdQsOmbQbYfMfJXi7anqeVpVil0IMFZx4PYfEPqk033IwNLy3S9bJVkJBnAIWvJ77JP5ZP0TudLi17Shcnv2fq7WWWwwCe1XnZwxZqyncIseT8OGcQ1n3X2bOKwB7GsIheir+QoaaKYM5GUFzKvoWCgyqXl6LDwNNEl84sueLoR+a8aFqKb9O5ANzxoMS8BLldUME2otbdS370+D+NnD+m1jHFQeolOPhk4jg93mG7L7ZNmpwzQ0xFd9bIKUKQpbXlmhr9C3pPZpcnfDiQngPl08CIAhlXkmTm8qSa8a543gpGokTTC7M5lih/LLZZLrAuyHWn3roCgcA==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 3 Apr
 2024 07:41:45 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:41:45 +0000
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
Subject: [PATCH v4 3/3] serial: 8250_pnp: Support configurable reg shift property
Date: Wed,  3 Apr 2024 15:41:30 +0800
Message-ID:
 <PSAPR06MB495296BC1D96B42A60F7C230C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403074130.93811-1-albanhuang@outlook.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
Content-Type: text/plain
X-TMN: [FPqZb0N4COyFaxYzvNsV6coGt0IBgkb5]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240403074130.93811-4-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: d3321387-4c5d-4c4f-d2a4-08dc53b18329
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rbgFUzx9J5/F8hyf/2jHdhnqZno0S7BEsCH5HTug81mY84o3DmsKzRdmfe77WaYPtiIGb9Smh3GKXwI+ZeoB5U2ie3DGrxlq3ZJG83/y9OKTnxO6/b1FT+VaEcL2gAGb/bVFCDRNBWl/rPcDOBQqgSGwinHZuuHldHPB+p45pMjKcXfbT+vkjupvunovJwXnPlFryxr5fG9gF2/rNk0sTTwvM+23ibnYhb1TgToCaVWzTjBDHRZDoyNA5rKUCbDSj7QDNMDP5NwAmk5y/XoDkQaUJc6DqNHmCKlQPVsUDtqDSOp8DVhkUW03PbX1tZ/rPHI27gP3mmprPRQWa/QZUeYoiRRu9fsUrVMzn4RJrPUB8sS4l0J5634y3f1jFOsepcuVoF6s848q1AwR/UGFm0MY77ktovIK0YwJCAYh2cK4Of61Dx/JCX//Pn2XixuDv8UxtpEU6xNzGamW7otsWwZPsqz+wMssec3UvjFJPeWtPEerxRLWjshD/rqQVLmv1NpoU7yxyamlHZYAlWYzfrwX1+UkDwKaK1qVBiVyfPTEXtfwHKxtid2QJwstSkMQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XIHDq6aJbCzNLiWR81YwDxQffoNB1HQhcGi3WYbYRCBiVgajhduS5+DZ91xa?=
 =?us-ascii?Q?5jWW9qX1HIuteewb4oB2BIWZGqS6GSIPeEhcFXup0q50NCnWY7wVXISc4hMN?=
 =?us-ascii?Q?uXGmsItTG6x+VY22ym7t9jX9Y3RrqVwZv/Nl8/pJcuSWDK42VCmL4qKv6B+X?=
 =?us-ascii?Q?DKYNmScO74ksu25Vwmbr8hufIeCh4IhSpyDKX5T6pV/5M17RjX6dds46QDdo?=
 =?us-ascii?Q?a50B39j6JtiFs7afPd/rHrFVNXlceAGV7WxTR3XyY0JutS9q2yiaE2Tpj9ym?=
 =?us-ascii?Q?/H/sOZs+jtssiDWTjAMlaIeyovLrNyCOt4A6SQLS519L22f9kq+UhxwgU+KN?=
 =?us-ascii?Q?BBesRbmCUBPRuXi9deD97TwJcTQZUj8NEbESSVSj3cVCcUaaB+7zle4vp5DG?=
 =?us-ascii?Q?8kLxhz5G++/Ar9yjGwQ2bR1cZXUbasHama1l1LCKBnsPk80szI/aE84/2FpH?=
 =?us-ascii?Q?lhqNthQcW17OzoVNapi9ziK7np0YV6aI5/Qk9TLJmIM5SdjmgHklN/8/7WeL?=
 =?us-ascii?Q?ks3iQzms4slDTlj/nMg/yJlONI33T0ifB9bUDR+jCAe2O4jxySW4xORPU/gU?=
 =?us-ascii?Q?LShFDlh6knYTkkLXlUyL10SN7f7GMTNKW2x5supnvbEpiVs9duenaXsASEUq?=
 =?us-ascii?Q?KQw9vTfyhpaeSjrhNPZpKL7fmKxYFk7VnuWNVrWoIWpjGGOmTfZcIk8bD7mx?=
 =?us-ascii?Q?/Jy4b9pHT//srOmC1tpQ0zzVVrP7SzexQybV+PeRfKHGvscDDlUTLqohNn/Y?=
 =?us-ascii?Q?rGPkZGYJBNdxlTV3BC+o2YtRJfttVjaio0Yuny46mznfnEJ6od0X46/qmMdV?=
 =?us-ascii?Q?r5/EHBJRQRkoJQo4qkXEzJ2LonpP+ttcPhH7q1339oYTZ3VgoLCeOg34xolR?=
 =?us-ascii?Q?gjaj5E924xqtZNLV4CoYjIa/h2JsQaBXIvRfbaXz/jLJgumQ62ugsZPqRuwY?=
 =?us-ascii?Q?j73PTtaFTxrx0VW4z2ZU21OLAo3rep84Dp5esS2Iy/KEoGc7VxxbgcDQp38N?=
 =?us-ascii?Q?445xsl8ULkC1LfI9Uos/cSP6+j9QJ2vO/pF9CIrpMY7uemziow82Pabenxi7?=
 =?us-ascii?Q?WsVfMmTLzmvKOuW/RPo6BU6GaIwe5BtaQJX+nqBXaFGXhtBYRPQugKGjCDgo?=
 =?us-ascii?Q?yG23uZm7C1NZyVSX7cl064yJ0okrgYHX9B5rruJpyoVYOgH9uMRnHTh9pHwj?=
 =?us-ascii?Q?YuQz1GtdDQxfC7+YEak39wstH+VeRfRSkUUiHIAZX6etKBB9LibBRfkLHf8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3321387-4c5d-4c4f-d2a4-08dc53b18329
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:41:45.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v3 -> v4: dependent on two pre patches: "pnp: Add dev_is_pnp() macro" and
          "serial: 8250_port: Add support of pnp irq to  __uart_read_properties()",
          the iotype is reserved, the mapsize is initialized, fix the UPF_SHARE_IRQ
	  flag, check for IRQ being absent
v2 -> v3: switch to use uart_read_port_properties(), change "Signed-off-by" to "Reviewed-by" and "Tested-by"
v1 -> v2: change the names after "Signed off by" to the real names

 drivers/tty/serial/8250/8250_pnp.c | 36 ++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..292cb8e84b37 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -435,6 +435,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, line, flags = dev_id->driver_data;
+	unsigned char iotype;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -443,25 +444,31 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
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
+		uart.port.mapsize = pnp_mem_end(dev, 0) - pnp_mem_start(dev, 0);
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
+
+	ret = uart_read_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	uart.port.iotype = iotype;
 
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
@@ -471,9 +478,14 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
 		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
-	uart.port.dev = &dev->dev;
+	else
+		uart.port.flags &= ~UPF_SHARE_IRQ;
+
+
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %#lx, mem %#llx, size %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
+		 (unsigned long long)uart.port.mapsize, uart.port.irq, uart.port.iotype);
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.17.1


