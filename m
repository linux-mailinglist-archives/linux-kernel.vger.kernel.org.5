Return-Path: <linux-kernel+bounces-94993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E98747E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9AC1F228FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D81BDF4;
	Thu,  7 Mar 2024 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="r5ScxiOG"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2050.outbound.protection.outlook.com [40.107.129.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D51BC56
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791669; cv=fail; b=Jj4LGh3AxR/bPRRErvmB+9XR4dIDv7QJsV2Z+onVTz35MMVcn/QH7LZGazyUffv7So5PAUMRFr22q/UJcHVForkvR2mW6h3KJnLCr6NJUaNeZKNsD6BWJJkVI6va+qEf5D2dqCEZKV5o0LyvLWezU21Kgx5HOiSqYum+p3NqEII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791669; c=relaxed/simple;
	bh=D7nKzAivMPZjHYlUbkHnOZQo37gfTKN4oQsYMXBU+AI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SCcOsdFqgE3822XMHEVL3Ytl6ZcEwduZgU6FNH4+7CAToKovyDpnhM0/KIzWlDcF6wHlCSGO51WjqiP+lLky7/5ZV2i/RjdPefb6KVG2fbonuB2OqSqIFqSOZH9Tv1GNF9vHYpyKqLv4CnQaZn9MiNLsdmVPtFll6FK6ovDy53w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=r5ScxiOG; arc=fail smtp.client-ip=40.107.129.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcz7FSW2UyGjNit/jg71qt/H9oahpZ8AL2+xZLEwxtuhV1iaSp+JpilCfLvhZSeYq+jwgHE6JXyfb57zpzm4M+EZM4DH9Ataw7zEg7s50WR0jprda2qodahFsUEw0euLJkINmqxBua4E4ueTKhcuL37cvev3lBkxp87oygKq5gK9ifC0OADABS8MuOuNPjl7n5ylU3x9JFNrb0EjwAWvR0Qos7zQP5gUQ1a6UacTc+rjIgpi+vPxTBfQXV6LLvmWshgcaa8HKbcYBUOmmpt8OloMf6NgjfYCa4tZnsL05LOzQUBBhR2nj/yfghQzWSRHq6x70ULYuodE50i33CuApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r40ZYECq7ig4QT1XxTnAglAn1yiQU+U3ekqsIycGcfo=;
 b=SLMFOlPFtPwZwL5aokl67G/EYEf23O/AxoAGT05LcOCufepeRdRt6dW7MTY4iXnv7tJtlERBjNquVdKArWHf9psbwO4kl603E4F1yzckWbKx9pq3Z8/NfiN5UmNc7qkpvMov9ES6xofVqvuJ1eL4mOizQjIMb8GQoDxmMUxh/5Iy9aRWHR5LBfQwsoRPvhdFKF7zKZrxxktxdYZAU4v6G2KIaKJfocUiAKOz7fQHZwNxlQyLuN0KvQHBJNmmcmSbO/41GYT9eO9uvW9ks9XFDZN/Yfm01vEQctHoONwew4X8QK49F9QVZNmq4S4IzVEKFUCfAkjVSZJDQ2M65JtJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r40ZYECq7ig4QT1XxTnAglAn1yiQU+U3ekqsIycGcfo=;
 b=r5ScxiOGGGy7xvClGuQymMmgw0zKgdi1sAa3Bbd2d23M7y8WMrWk0ADKDc7F9m8SNG7y0gd2S5lw8Jk0Z07w0fkocjkzGUWcLzm32GBdZV8Et+eCZyc4Gv+bpA1gJQEsyArAe45XC1ZwQ7T1di4KwVZ9maaAz+cqvA1DWXuZWIFLdHihNoYTLq88uoWqTMaRKLHQo5eHyrUzUEI+B27eU7Mrp5Om/6BF8nrHwoDpzKGbQyjRlgutM3BCnH3Fahk5AmaZUik9/4/BHvCL3u2bI+nviQmd4cW8YjAMEPDg55byjwBttCokSnvIa62FEB2ufNRiiiTfgmHsd4ewcV0kAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by SE1P216MB1512.KORP216.PROD.OUTLOOK.COM (2603:1096:101:28::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 06:07:43 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::6bad:dd98:cdca:c48d]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::6bad:dd98:cdca:c48d%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 06:07:43 +0000
From: KR Kim <kr.kim@skyhighmemory.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	mmkurbanov@salutedevices.com,
	ddrokosov@sberdevices.ru,
	gch981213@gmail.com
Cc: kr.kim@skyhighmemory.com,
	michael@walle.cc,
	broonie@kernel.org,
	mika.westerberg@linux.intel.com,
	acelan.kao@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	moh.sardi@skyhighmemory.com,
	changsub.shim@skyhighmemory.com
Subject:
Date: Thu,  7 Mar 2024 15:07:29 +0900
Message-Id: <20240307060729.565350-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0156.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::7) To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|SE1P216MB1512:EE_
X-MS-Office365-Filtering-Correlation-Id: b47f1769-1eda-4914-4424-08dc3e6ce6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	frCoiDm8NbQehBf1rIDH5XLMou5suy7LxPh3TCUkM+AZ9cM6FLF3fJttwT38PtPZoBMRqwsKhkjKFIsaxT2a7KbWzPfpRTXjB6SDfymygzHAni7Zmh2eFI9XLTRwt79QovSoYgAukt/y1828+fhROwwaGpFlFFF5qNUhIzG9YF6kdFo/tVdspHXadzv3VsKs/i4gDimNKXw5vWMx+bDUdazJGx3V5bQzi6O6O+tB5vbwg83qZYF9refizuVAyNJqOUXMAyQJH/3bJ9lvUU6P0GPUbIwaOkM6TCmIBDSosWxqJNol2pxDYxbViKsVBxH1cixWK9cJS3qP/X7LOM/hlXvKbH/sErGEjBn4yQowK61G+tyY9XDVSjR0dGtRfX+O1DXrvM6tPTXqxzo5r/ScrPV7vC8PUBa44hwJA7khmCxBnmNlwv6+I/gvcnMEriTt6rsDctcJKtz2uue8YtxYCofJ39W+4aV2rDsoUNeZMnEbop9ngCOsilslis96PQKdpbDX6lpwEFw6mAned+NXWIfnjJMcZM0ZJx/NsMjX2LrniUoZDqJrBVtf/kDpEzr0gfpd1mN9CrH5cqiI1i4rjyb6kzWdEXiGQhGRwFHrRcWLtrFb3OlX3MFRzrlvUFXZzBlxmqv4K73Al4BfDcL83CvFnF0hLgUtXiABpacdtlZPpWGwnm2HA0k7IqCCK0Q/ropQBJRAn83Ojlxk6aP4hlXbX+JmxZ9gpTqysff0CGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSpB/zd/ptmCc9aB0TpBiLDeSEJ/xu7L5LxAAxE+SdNIo7VlvYFzaH9/ItDg?=
 =?us-ascii?Q?A7mX4MaHk8gJR5ekHBmQh8DQBaBJrZ07k3d9oOH7isXgJ3emCxzuYNXiaOjj?=
 =?us-ascii?Q?hadIH0dxcES4LNO7TYEOw7ZuBezVlhHfNiKJ6ytDPj/meXeLHfgjWcTWoJFP?=
 =?us-ascii?Q?F0Gpf4Goq35iGuU80hXyCL+Hr2O5RxrEiQt0g/maTTgi3NXoBQkEx5eKPx1l?=
 =?us-ascii?Q?/lxZCi8Xa6jtyywhW8kYB+yaoyhpMiA+90V7wZDum8zafeCyTf4sVYUvJdhT?=
 =?us-ascii?Q?CU5AO1TKD+E7kgodwnZyG3zN/qUcdod8pJw3MjWXMTMGTa3iOuCHWTO6djWG?=
 =?us-ascii?Q?u2QY2U266Kd3eVurpZc1zmQsZE6N1XVb9lrvgrmrDl87RrM7yAbImfqTYq+W?=
 =?us-ascii?Q?loYWSO7EXTs2mY7rXuCNaEl9p+3cly2Ed5gI7PsFGk7566mYBNfkygYKb23b?=
 =?us-ascii?Q?8MyWQA4UzsUsMmxEOolXzEiM5F02C1lHljbhrwGQQZu6TmM4wgeocCJBZPUK?=
 =?us-ascii?Q?BmgNLh1mKK1G29oEmuWzOic0tGb6rgQ/ZCmQhJgO2ZyWTZsieZkj1I/G/FYZ?=
 =?us-ascii?Q?3/kD3RgxnERqO0hgCD9qRykkEpvqOuhpHY/JSFwwJjOFcFYvHrcO+cPs4S9e?=
 =?us-ascii?Q?xMYbBkODt/APm+CUGixU8nxhPM8UUYR6Xy1ekqxLCdDOMtIikLbmRL3ZDNMl?=
 =?us-ascii?Q?YUN1i9lGhq0aNpSRLlG32+fhvQj+MDwZZNAzkMm2bfYAQQdp+NoLvwoScX9q?=
 =?us-ascii?Q?VgORGDkoNkmRgC8y91TAonj8XNZk8OyUah/GQmntKDs1/f9yPfUphwY9POGA?=
 =?us-ascii?Q?k9p9P2iUq0rSCfiaYKItUPorPoPcMlnIlsDPr0utTuuj/tiSjfjZXfn5zTb0?=
 =?us-ascii?Q?jDGgI8K3Jvq1xYZ4D6g17L3leTu7Fs8l1i8sp9F8v1ADK/eFZLSvAluKJc0H?=
 =?us-ascii?Q?crxLFjEZYcF6uug+o/i2M7B3CLNdWFfRvW5KE+JbwhGOapMMkJgkXE7KOW6y?=
 =?us-ascii?Q?K/HjMwfroWkLI+4fjFR4dKecJ/mBTw7VH2AfzQtaXhQSO+ChAs7+bHlwsJLd?=
 =?us-ascii?Q?e6VF9y4JR8z2ROFx7hyjItTkQISjWrbexpbVWI/OaRe4ZDvWz/n5EZIO5bpj?=
 =?us-ascii?Q?I7ByZm54/fkrFfILn/oNbAqJUwBCW2y9midg5bToMxZ5q4U50DwGKSTVPAz0?=
 =?us-ascii?Q?+06RyTa+YXJY8EsfA2k4cur5eINFPMMqJe02rIIUxI7T76bYoj0LaMFRkds4?=
 =?us-ascii?Q?x1xh6jmTWdQ+HlLXlP2uCxOKsDdDtpTUGX4ja1lNK3uB68MyFr6643Qj2IAm?=
 =?us-ascii?Q?FxR2LirVHO8AlUlvNm/7TT0w6UDIzz4l+cvkcARWZbFmdekPUoKS+yhoU4JO?=
 =?us-ascii?Q?Ag3kusPAWE9j6prGYPTFdAfCKwsLPqiNwLGMIIkv1JU2hnKNFoQWuCGJ4Hdc?=
 =?us-ascii?Q?peB7+xzwYcM7iuVh9SeGQi3Hl6YYQXyNRk+JkR7hHh5d4h+dvhk5KDalwA5K?=
 =?us-ascii?Q?mBrWNvblCcqPCXo4zXX9H+Jb82vKsvY5572WJ6EDzRETu7+57CgFjoRqezf+?=
 =?us-ascii?Q?Ws9jK1QtCVSTN0LOheLf3/ZrswEmksVuNZGXXruRzx86IvMp2XK6SgpA14Xz?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47f1769-1eda-4914-4424-08dc3e6ce6eb
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 06:07:43.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCXYbM0CYKXNf1XJ+X+vtwP7WolPtg/86cukRTIefvUpLqdvl5WuuJRNsIwQWXCl7VjRh7ep0lUIYH8ckUus3IxPtNqFNRDOGiE1ATwK7lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1512

Feat: Add SkyHigh Memory Patch code

Add SPI Nand Patch code of SkyHigh Memory
- Add company dependent code with 'skyhigh.c'
- Insert into 'core.c' so that 'always ECC on'

commit 6061b97a830af8cb5fd0917e833e779451f9046a (HEAD -> master)
Author: KR Kim <kr.kim@skyhighmemory.com>
Date:   Thu Mar 7 13:24:11 2024 +0900

    SPI Nand Patch code of SkyHigh Momory

    Signed-off-by: KR Kim <kr.kim@skyhighmemory.com>

From 6061b97a830af8cb5fd0917e833e779451f9046a Mon Sep 17 00:00:00 2001
From: KR Kim <kr.kim@skyhighmemory.com>
Date: Thu, 7 Mar 2024 13:24:11 +0900
Subject: [PATCH] SPI Nand Patch code of SkyHigh Memory

---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |   7 +-
 drivers/mtd/nand/spi/skyhigh.c | 155 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   3 +
 4 files changed, 165 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/mtd/nand/spi/Makefile
 mode change 100644 => 100755 drivers/mtd/nand/spi/core.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c
 mode change 100644 => 100755 include/linux/mtd/spinand.h

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
old mode 100644
new mode 100755
index 19cc77288ebb..1e61ab21893a
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
old mode 100644
new mode 100755
index e0b6715e5dfe..e3f0a7544ba4
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -196,6 +196,10 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 static int spinand_ecc_enable(struct spinand_device *spinand,
 			      bool enable)
 {
+	/* SHM : always ECC enable */
+	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
+		return 0;
+
 	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
@@ -945,6 +949,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
+	&skyhigh_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
new file mode 100644
index 000000000000..92e7572094ff
--- /dev/null
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 SkyHigh Memory Limited
+ *
+ * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_SKYHIGH		0x01
+
+#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
+#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
+#define SKYHIGH_STATUS_ECC_UNCOR_ERROR  	(3 << 4)
+
+#define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* SkyHigh's ecc parity is stored in the internal hidden area and is not needed for them. */
+	region->length = 0;
+	region->offset = mtd->oobsize;
+
+	return 0;
+}
+
+static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->length = mtd->oobsize - 2;
+	region->offset = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout = {
+	.ecc = skyhigh_spinand_ooblayout_ecc,
+	.free = skyhigh_spinand_ooblayout_free,
+};
+
+static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
+				  u8 status)
+{
+	/* SHM
+	 * 00 : No bit-flip
+	 * 01 : 1-2 errors corrected
+	 * 10 : 3-6 errors corrected         
+	 * 11 : uncorrectable
+	 */
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
+		return 2;
+
+ 	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
+		return 6; 
+
+ 	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info skyhigh_spinand_table[] = {
+	SPINAND_INFO("S35ML01G301",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML01G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML02G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML04G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_ON_DIE_ECC_MANDATORY,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+		     		     skyhigh_spinand_ecc_get_status)),
+};
+
+static int skyhigh_spinand_init(struct spinand_device *spinand)
+{
+	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
+				    SKYHIGH_CONFIG_PROTECT_EN);
+}
+
+static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops = {
+	.init = skyhigh_spinand_init,
+ };
+
+const struct spinand_manufacturer skyhigh_spinand_manufacturer = {
+	.id = SPINAND_MFR_SKYHIGH,
+	.name = "SkyHigh",
+	.chips = skyhigh_spinand_table,
+	.nchips = ARRAY_SIZE(skyhigh_spinand_table),
+	.ops = &skyhigh_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
old mode 100644
new mode 100755
index badb4c1ac079..0e135076df24
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -268,6 +268,7 @@ extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
+extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
@@ -312,6 +313,7 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_ON_DIE_ECC_MANDATORY	BIT(2)	/* SHM */
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
@@ -518,5 +520,6 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.34.1


