Return-Path: <linux-kernel+bounces-122385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F288F608
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C201F27757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9D36AEC;
	Thu, 28 Mar 2024 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z+OCcGhR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2100.outbound.protection.outlook.com [40.92.53.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FC10A1A;
	Thu, 28 Mar 2024 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711597544; cv=fail; b=F3sSyPiy7ShA5L3RV6yyl2HFE+7NjmtG8ZRFnB3RU9CEJMnQjG1iVsasZWZYj2XwOCBrs1ctDQf15Oo+AXM+lNcD88XJwGr5weuhfh3rhsZzCfoZ1lyPzgJB3HGq/5bm2j6t727Xxy/KMmsEavhgX7Pfh21+7aFg5NrMBSMO0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711597544; c=relaxed/simple;
	bh=IZPw23lu4jUX7uVbBnRl/6RsttZkafcU+sXhbwlttZY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WV680ZSMQmOdN6VrRJJs+zous7Pnwbp71jwi8V1eLxwf7xWPtxQtXEwt0tT7BjyO2ek2gLAR2LENhB2D5CEPMkc7FVZbQ9MbYAqrDxQ7sU0R0z0TxxHoxVj7IlNiGH4/M6kVsMTBpE5qkVnQo+J4oU9WkBqazA8VxgszQgCi42I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z+OCcGhR; arc=fail smtp.client-ip=40.92.53.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocTZjWLewp2LVGhPkMyfZjmKCcw+uwsV/fiVUA3j7O7YEhrbh3A6PBD9mVOyvMCap0QhrZCU5mG3jldpc2gRN+kN9IASWpFsGTznBxac9zUaJ/640fAXs0lYNZjNT6iMwvW7a+lk+1ctP1KDdjPBcpOQyToJ5v3KVYaSeE4m+85bzHVw45OVE1ipBCQyUpoubwzZJDY6cDJy1SOn+J9dv7/x5B6w7zimSBCyYzEyInsd1Q7eYxKkBx/tmynRPGTPYtimQrWR/VYASFwbq307gSVb1xss73od48m3lLCM4UshgdPw9QIZ3jNYY9CDG3Y+fUdpkzEVE1KNqm+aCSmWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNsZ4n8XXW7sNxGaujszT6kznVhwG/J/IPGIoJAeZMk=;
 b=GpZXCeFrzjTF9W3KIobTd6O8vaFEBjXJXsTdWvwcsZfbK5cchKjin0NBrU/bT2Nezh/qRG9rrYM20UbWRXURCIsUsO41QuUaE/UEKC76e13JHlDK9c/R6mZZgy9UQo1l7XKQmYU30Ke4aLmzFsnrL53aMZcQZJDMVl7NgmG7fenjgl2+kSohd+eOrG4YuxLx9jKbEp9vcyIhiw9yZaNlHBPz7d1B1Gp9l4as4fGbdEATjfODVP64HKqkbHz8E640bEYEiit8eT9m8gzMaB8Es4xIkhDNvn0Yy6cQ2pMl9gO2HMZgRAkcQdlmQpIcVQtkPttxIqRVwIWFE+S4IesGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNsZ4n8XXW7sNxGaujszT6kznVhwG/J/IPGIoJAeZMk=;
 b=Z+OCcGhRnFnk9MWQUC4dNGxhDeLqhIDaJcODZTw8UU7y11cKYNW5hj9TsdOGo7y9CsqclUqQJ2/GzoRRPAoEMwT+7frE036O+cg5NKXfiPqOflyqsYrgdo54HG12kuFjtWU0gMS+wznjc9cPVq14uq4JkYFalxn3Yrcufx8DgyDpo7KkECu0UBgTIvxiA/L+P8Lr88ve/HbduLDQ3WjfJAXLRaiWgGIV6po5b926kBdhG7tvSO8BvXF3686wldqJvx+DLKDBGjs0IP1hZEAAAzAv+i7mYmwPRWn2u8c5jIVGfHAlLIb2Owmg8KiGDXYDNknN5deCF19yDLCaRCUcdg==
Received: from SG2PR06MB4953.apcprd06.prod.outlook.com (2603:1096:4:17c::13)
 by KL1PR06MB7009.apcprd06.prod.outlook.com (2603:1096:820:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:45:38 +0000
Received: from SG2PR06MB4953.apcprd06.prod.outlook.com
 ([fe80::bdea:96b0:398:97d]) by SG2PR06MB4953.apcprd06.prod.outlook.com
 ([fe80::bdea:96b0:398:97d%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 03:45:37 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v3] serial: 8250_pnp: Support configurable reg shift property
Date: Thu, 28 Mar 2024 11:45:29 +0800
Message-ID:
 <SG2PR06MB4953D0E0A40FDAC34FF130C8C93B2@SG2PR06MB4953.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [rR5/VevygyKCu/kC2kAjcl4A5/HnvCeP]
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SG2PR06MB4953.apcprd06.prod.outlook.com (2603:1096:4:17c::13)
X-Microsoft-Original-Message-ID:
 <20240328034529.96748-1-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4953:EE_|KL1PR06MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6d801f-a003-4a63-ff86-08dc4ed987f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WeouQVmtPdHCmR8Mhlx5g4MItMiTHXnrYr9/Zpt/NTrjsXmUZX/0UM3SzrO8pU2miguvA1SUJya71bBp35GDcN6tY5cRCmYRs0EKGFFT0kqw9BwIo7Vrvv0zrg+9LUsOWPZaM6Mh/JenR1zr3v3PqMuCDy3Jvnu6xWai4i3NnzPIYUiKd0QLRcA5oBdS/K/t95Gw2m/8CuwF6h7M2BL0DnUDUxcRAUjBLSp/+PdbRTM550AhQrLIxijQN9DQ4Rl2xsRF8YHN1ULSmOFN/QfXuX67zJ7rPu9QkMhi/2h/LR3skjbldk40KuvOYfpqs5XlPVApWyul+Mu+bGNqA7BAxmloPvGq6qSI8t+UjAr/I9j6U3JFiVg+jEjg4x7YGIU21oogTnCruNH7emf5uFWqpvLXdtnKUFiuBvx7OHDDgf1qDvGXjv0rgs1IRBMKjb9zGo+e9M9RtmdOfNSN9s4FqoUEZeTA4l04Oo7qpa4Pkfl9zxbbgT9YxHr7Xn7l0+BIKfJP0DUV7HxEiOLGveo5uy4yBIKz65SCzlGl6M/MxwU0AvTMwAlvpn1+cPxHUIuf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvYEn/AcuDmPwma7A1qQbkLcCm0xcH/Qgol9x5ffyf2sUnjoCcyt0HfCT37j?=
 =?us-ascii?Q?KRYEna6ImgqrHrJ+HScaJdne6MvhRtyHzXyKFWcIKO76W2nzDsYvdSqulZGN?=
 =?us-ascii?Q?t8eTx2Z+n+YF8tMXL2GsryTL+Knr4Qy5eeRRqAoOMcbRI3OQo9jylfZFnWfi?=
 =?us-ascii?Q?mLEyPb4tee01zaimobobmjtMh2iAj1SD3cJKpkpBNhjzuZhhjojys43f8S/H?=
 =?us-ascii?Q?y/dAqvzp3zETp6DQdoqVOThLHcXO+A4cEldWjQ8XBoAfiiZ0Kz/FBihAoojQ?=
 =?us-ascii?Q?g+7R98eNgtsiKFYRtGd7zxFxDkDF37c77UHeryvuDVnYPm1xZKwHF2PqDdFf?=
 =?us-ascii?Q?b2jVKKkQLdPJEBjT2Ygwl9DpSkul8jsjgEARxulWD8dLdWeBeMX4HgQpBQD+?=
 =?us-ascii?Q?333KwHkKpLPeZ04/0KkhFqawRREX8dk9Fo6XbEOH7W5l15vWn+RXuFHyzaO8?=
 =?us-ascii?Q?lyMZRFXRLFeeRyq90p1Az3LglmECQPi7XekImQZSF5Uz0WIA80Q+FmmmuhaA?=
 =?us-ascii?Q?gKG2S0WV+MJi3VShEYFiJqECF/GrClFT/CgORm1NVyTGOe8NpRIlF73lDdQA?=
 =?us-ascii?Q?LdiNPl15c2XdUG9RJ4VBgX7HF4JLm5sO9sppQtr0QNWT4Z0fB01wxnvkswej?=
 =?us-ascii?Q?A4hk6r6WsnieVcJOn59h2DI+qLyU6hQIXuytV5UNqWGCVQvVGGa0k2C+4oW2?=
 =?us-ascii?Q?SQHwYRNQwBN2uqC6OFD30SbGaJmFFon/T+p3ZBwBmKQ+uz0U9wjI+bioxM9k?=
 =?us-ascii?Q?MASuo4HgS40LpC7wPjWz0ExyzGN8f+FF8oRc4XNh6rWqn5ZBJPOnMd5yhSiA?=
 =?us-ascii?Q?zllidveB8hGtWiBWHAKXi9MAKcCDuxg9drggr7Mn8I/8dHq9xeW8aSvgphhw?=
 =?us-ascii?Q?dGwvVgw+pEBOiOqbtfe7oxyhmscZOL7KxvDvpusjU5HFZAEwA1sWDrgCQeSi?=
 =?us-ascii?Q?yBpkwkvhqIYUt36jTTRTQj755sPn65So5YtCE2/BF7SEK0HhHnUAtj+faTTe?=
 =?us-ascii?Q?rlRR8OrjavDRL67rkcbiwIeYBJawNEqaKXsLOcGG6aLfS4um5lfw0reyPJhE?=
 =?us-ascii?Q?ELv1MnWYOl3mR+l5qR/KS6E+ZeSoG7p+YrwYMwOIh59Bwoy3w+PCXUycz32X?=
 =?us-ascii?Q?bYo48Vj8PzU+ETpF8XoL6tAumq+gOHwg+BJlde6R2XY/lzuawhr4srS8LH+n?=
 =?us-ascii?Q?Vj7FhDIhkkAXUaLTM9soZrsaGSPW3FYDHyLnjosfIkNcCK1bFU5v3W1OZY8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d801f-a003-4a63-ff86-08dc4ed987f9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4953.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:45:37.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7009

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v2 -> v3: switch to use uart_read_port_properties(), change "Signed-off-by" to "Reviewed-by" and "Tested-by".
v1 -> v2: change the names after "Signed off by" to the real names

 drivers/tty/serial/8250/8250_pnp.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..aafddede783a 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -443,25 +443,22 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
-		uart.port.iotype = UPIO_PORT;
 	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
-		uart.port.iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
 		uart.port.mapbase = pnp_mem_start(dev, 0);
-		uart.port.iotype = UPIO_MEM;
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
+	if (ret < 0)
+		return ret;
 
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
@@ -469,11 +466,11 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
-		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
-	uart.port.dev = &dev->dev;
+
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
+		 uart.port.irq, uart.port.iotype);
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.17.1


