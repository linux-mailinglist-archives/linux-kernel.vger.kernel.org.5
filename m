Return-Path: <linux-kernel+bounces-159643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEC8B3181
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E14B23227
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3729513A41C;
	Fri, 26 Apr 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="tcOiAYDh"
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11010000.outbound.protection.outlook.com [52.101.154.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2F42040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117187; cv=fail; b=VYZSukV0LNl956qt8+EBl2/wzLIqLo5y9fa70yDY4ukbQBoSiCNJ2S+jqQHx/yDYy21DbQBs//+ykwFaLckAnQzQaxMZKNTmosLQtzXhE7Jf0unfqaJNXnOW0nOEXhSXugPMQbZ3J5H1wDE/zdrkl+kj1pALS1ih43BofILakfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117187; c=relaxed/simple;
	bh=GF0QeMqYatuAayku34IMzLTUWgsmdKBDcpxaYT725OE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NJILA0m9QNxnThsbjTUSlEGisFtv3aBnrejTXLbOMRJc32Tf/2ySqTPP3aPMaRtlgu4zxZY6LrY5GrA7ntzN2DTYio3meDgQ77Ep/jPUEqVp5HKPhJR2IyU5Tj0jqq0YZhJ/pH0QQDs4j4tzdPSJqFTk4xvS7q/1wVuMhuq0vBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=tcOiAYDh; arc=fail smtp.client-ip=52.101.154.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwnDRvWY4aI/douMrPHdPijCD5DJnzsyG7vfa/26aPvhLPcdSoBMLeegVNOclyuD5jZ+AF5kI+hPdLRz+74sV52l+0JVGcawJjbZEcT8Q7dBtfH5SHHVYAvMqvmOkd4f+WpLZ7uwCoAgzd3ciDP1NL34F5tFLDwIQ39loFT3csvaT8HBKjqwTgvpuxWLqqBE/g+E46t3Bojt59GotfNbRNTQbEIDgaq5kkGRhpsiy/wosaMpn0HWf34pxDn38uQ0nWKpzEmy+Z6SEAkSKiEMOy443tKITRzMBsJ74nOT9AFPcY/FpwcJM4bm4IH8+MQVUCwEqKIyl5afegv/GviMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzkkPuee2T82cp/0qZR4rnsEcY0YlFdyeSlonUHYzfE=;
 b=fwuJybmGtPZtGH/Gc726osqsSL5JMGurRMiOnuiqzll4NjQyUWCEtTR/eXSi/5AvfqPr7QJbFjiCX+i1jgrhFDfa3CjWqymTuFXiSYiSsyrlq0b7UwG/eRkpN8YfYHsO4GPNo6PThhpKSc/a0Psq6s8HwycNFh5p8LRhmhXm6XOMDu2/pRweFv+g2vHQ9Jmna+egOoncDwEWsmVfhbotvD8oFjqM2cL0CTia3eGLbqvA45KkIRwvxxSGl19NaRju3X8GpBW5rRU1Ets6JPzrZ0s6qrQ3D9WgohqR7o+z3kER9nKd9wsKYCoiVo8t4pgrRWkNpGVF0hMxUYIndfKdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzkkPuee2T82cp/0qZR4rnsEcY0YlFdyeSlonUHYzfE=;
 b=tcOiAYDhJZxbaCikW/ozS0lC2Mu+okjKbO/TvPdyPkc+Td2NXjve/fPetaAtL7TiB3gjYyPa3A8tdT/rGoyw91m/vQr0DISLHZow9TnVhVv+ZOWDtAnMJom/srE60u2stO5inNP7dB2W71/v1PoNn+pGmArsD5hlwqChycNgRP5CJuD6r6fLbdg6ga9E9GQzbHW73gskGlBKBDvHrQn1a2P2Cwy4JfPnXYldHK9ecQfHsKU5FlfoHeiOisgMs/PBIDgnqt2/+lfD4WvojFU2VmeBek7I6xSsCsJD5jmUDGnvLafcQCMBaARH/N1dqMmmnOqKg7uwNOeDgG+vBQsqBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by PU4P216MB1356.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Fri, 26 Apr
 2024 07:39:42 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:39:42 +0000
From: KR Kim <kr.kim@skyhighmemory.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: kr.kim@skyhighmemory.com,
	mika.westerberg@linux.intel.com,
	michael@walle.cc,
	tudor.ambarus@linaro.org,
	acelan.kao@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	moh.sardi@skyhighmemory.com,
	zhi.feng@skyhighmemory.com,
	changsub.shim@skyhighmemory.com
Subject:
Date: Fri, 26 Apr 2024 16:39:28 +0900
Message-Id: <20240426073928.331321-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0091.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::6)
 To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|PU4P216MB1356:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e687af-3af9-4365-d836-08dc65c4090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJr8mKdmlUGYtuXSOABOGLg3SfVL1aHNEoRswJ+xjG45Rc5lusjGZyCRKc6q?=
 =?us-ascii?Q?8hfLUSc5h8zNey+D3XFam8etR8+RtLtHBxGkgtySN+P3ThwuHCzd0Yd46+Ni?=
 =?us-ascii?Q?D2vEmbLs2Qn5lTnnDDlL54zsdACiLLn4VFK728YtQeTIjs0H/OvcfR4q4Ge+?=
 =?us-ascii?Q?qqnhCuEB1b1MOXLJwsb4Vozv8u+IOC6tVlMBVTpEHUI2/N/F7vo+YSet5Gr+?=
 =?us-ascii?Q?nuAFK/IA3B/fuavm9JfPN5dLugTG4N2lxLBN/ZhI2S7lb7ku/OyVCO+37G7N?=
 =?us-ascii?Q?S9crzNY/n7zLod/DlnIj1qlAMuyz8utOnPj36qwAX8aixJkW+BsWgQqNjWJi?=
 =?us-ascii?Q?9rmMndOAHH5qwIIVFADV4TzDvn6dSohJj5GyRD4QJAqPQNYQd0FYzpxRP/hI?=
 =?us-ascii?Q?oHXlO2X7SN3qfe0mnOksxomAoB85Kaxabb6GyU5kXCuA63uyjla07pfm8HiA?=
 =?us-ascii?Q?nQcE+HBIi0hbv0a8Vu68EbL5HVpQt4dVbiOgTpWur49G/zB3AztMYX8Vi+3i?=
 =?us-ascii?Q?dL3aSXIVOSWPmA7H8rqEUvy2YrHx7WBNUrDTzmfis7ao95JWm//ykYeuujs9?=
 =?us-ascii?Q?ltu4O7D+9WG02jMrtSQCOdwaK71lPNuf8mDcNUbiZLKwIyXWV9zBK6UYvk/W?=
 =?us-ascii?Q?vV0vz1XcyQaO9Gs+6xjR7glsb+fPQOKsIr6sxBuEQqf+HaXQKlTnWTR3SVkN?=
 =?us-ascii?Q?CggezAjWJ6RoEvh7K7SrnLtXMH4uDCAEoiNHkWHcYdQaz9tqXK6pixK7jYbs?=
 =?us-ascii?Q?CK+JJ5Fcj4dHiYYEsEEjwNV412aU4d9dXvo5ejOt1Qx9bqj29oQ5peSswGIL?=
 =?us-ascii?Q?gyt3UOPr1wwF7auXQbxoiVruNXy6DdOyMnGuWkGaVYshwDjZHQ/oiNIuI5ki?=
 =?us-ascii?Q?rI058Qbusn35U5RPuDGBDRMTrioupuO5LutiLYnW1PgeKXXkzx8qTHG4SJnj?=
 =?us-ascii?Q?U0fpgzZRsqJw11dk+FUbWU6p+oUJ2OrJDpGvWkej7mFwPnIWZgn6+YkZxe7b?=
 =?us-ascii?Q?AVSDvClCsCcViTQ3L6n3D0of1zASeueGtqVsB8JXDauGOudFcTvcwyaLR1NH?=
 =?us-ascii?Q?YEBA3plNRobW0zfhKHt031ejKOW+IFEic1us22iuC7pW2EeESXSRui1yesPQ?=
 =?us-ascii?Q?NHIYAcH6bTDhnXKauzpqdbTEkQqWR9MJaCf3PBH7wy94J5T9chsxlElPCq6P?=
 =?us-ascii?Q?nABsLlBUViRjS+GnHk/aCs3MFOTDkYgiFe6Gqeas6XNqV5wettxfIn6JCId/?=
 =?us-ascii?Q?TAVXsnjo262vVZLlhiaLp6Y7K77TQ56w9bmYtFKcUhjy4TLJyeI1gdghe125?=
 =?us-ascii?Q?evRWItPesWnOA9BazuCC0HseCnG2iMO1QlGjIwtru8jK8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aX7rGcZyFKk21/wINU6gUJ+PYl4ruTYsZAKsNxrFrVq6gN7mqH1l1WvTTpSc?=
 =?us-ascii?Q?/OgwIGHlb7kYNF/MBgOVz+Va/c5ucRVHUekWQYRTWRKRK69pMP0ViriVKIUB?=
 =?us-ascii?Q?LmypiXLV92xy1GWo9yfCdNo4qy5ep+OCYBYkZG7765jGtoYc8sVZHTzQqJRO?=
 =?us-ascii?Q?r4Lgre0HvxDhQLkVIKIoU8Fuz+eYEYk2WdIAE9/eGeFX3DvoXolEQBc5vX08?=
 =?us-ascii?Q?NMRKhdRLGPNvj645S4iMEyanDe8loImyGyJnYndHSoeSq+mW6A7W31XxwecL?=
 =?us-ascii?Q?F4lDlE3V1kZf6gwlRd/eY6rocvBGdy7neaArKCar0Npo7TgIh5uDA2LdK4qP?=
 =?us-ascii?Q?SLJOpDaI0eJBa2PyZw+RZd0ENZ/jV3tQl5QFqfLfao80oHK6sIrUAfDS+t+a?=
 =?us-ascii?Q?F+dju5HkPcCkwFw0UoKqCXWJjP9I2MNipHVY8VpA3cRTiLwndjmM+nl6PvuT?=
 =?us-ascii?Q?+W9R70j0z/Aw0MPUHBK+2vLU4Ysff66uJ/oI6tyi03u3oBFgVKlJHvzkm/Eb?=
 =?us-ascii?Q?k8k+9K/iFndfGHfcGffZmizoQRjBjsC6sQmElmAOSGiey/qGUWaKLNqiiRLm?=
 =?us-ascii?Q?NEWy9o8O1hyNqXseskdzOOelMeZa8IG9o/88ieQ1yFmO31x1WgGJ9gBTVpIB?=
 =?us-ascii?Q?LDTF5qIAOXzJcWpXaBzqqRdG7W7R0dLZhT7VkfpZoxzxGSA1AYGqVJcU9KZ5?=
 =?us-ascii?Q?svnNI2YDZ0BCFE1wEZcp9tuEWhmJIDWKmAyaVlMtw6LgwKWSRB8xYbpMLFIp?=
 =?us-ascii?Q?SfRhJgiIiT9fhuuOwad54CCpZVVrHgmy2gjGEk1Pkvbzyf8Sjae7aYstB8HT?=
 =?us-ascii?Q?ahUD0gpUyQWo0YzM7HEdQi/8nLYSw5mWFrIDcIE0YimDFkobvaRDAEd21Ykp?=
 =?us-ascii?Q?WuAEIRXyP88YpUXl0K6XwN2YGRIqsvDLfQr1NMPYeZG/nvchzSwO2p5z1cmK?=
 =?us-ascii?Q?k6Qv3p7f8QoNh0LVQiiXyW1+s+PGdxzZ78jB0khkAVTsMa001CGyzVSC8UYo?=
 =?us-ascii?Q?9YnQkxjIS8wDG0m86qF4+N28iL3GpbbpLSHKJOe5k8/z/Da/oLHd0EF/lNr3?=
 =?us-ascii?Q?++OINxzfwSnnYAm8nLCctEFHoAJ2+cjkvK9W2pCwfhtXL2kdKPLjKNPlWiSb?=
 =?us-ascii?Q?vV6ROJ8WHnIMWJtJRVt1hdtWUmDMoQqAMdaQuMWDH1AUxl8/dRh20x+mExcB?=
 =?us-ascii?Q?HsnxDSqoV10NhBewldebRdDqPIWo/QoItibtRHwNhOQMpgb03GbGLDSQaqss?=
 =?us-ascii?Q?XpINgK4JOlvvG8gnR0MrPml2TIooCktHDYXod12UhF2GAW8W5cQxDFjeX5wY?=
 =?us-ascii?Q?ST1qusiTWnitONkQX7PvIxYt5cr0UWO8VFW2zGQRNGv8nDY2WEEN8NyhwTWE?=
 =?us-ascii?Q?dQtCSUxeOa4vijLJ2rQF0Wn57sF1YxLhp8hoGkBPRO7CiXMBy+Yfv+wywL46?=
 =?us-ascii?Q?bq3okGaVVoJQ3qLgPrmXMBXurJ87qJv70WYr2aaMzM+MhmsNQPes0jKW6lhk?=
 =?us-ascii?Q?MUCsrCZIHWjbFblySqOKbaPNM5DBYT8OZpfCDAAwbMJYVo6MNs0vaRGifVk6?=
 =?us-ascii?Q?P/Sd3KhP+Y4NwyhudmqF1uXDmzNlCggzA819tBrZpT+IRyBoIDard/7ChXvH?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e687af-3af9-4365-d836-08dc65c4090b
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:39:42.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSN4QWECVB4VxIAxpy6O7vzPnn+l3VnpdCXlX/6jBA6Oqg9EqkWlM71mtqsOQg80NlwruqTwmRRkAfsQhAc/UcDBmIV8CQ7gJ48mbZgGHrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1356

Subject: [PATCH] SPI Nand patch code of SkyHigh Memory
From: KR Kim <kr.kim@skyhighmemory.com>
Date: Fri, 26 Apr 2024 15:53:22 +0900
From 2b46394628957f31d2a239c80f67c2f8b24c3c32 Mon Sep 17 00:00:00 2001

The following list shows the additional features that are required to support Skyhighmemory S35ML0xG3 SPI Nand:

    [Always ECC On]
       Always keep the ECC On during Bad Block Marking and Bad Block Checking
       1. The on-die ECC feature is totally transparent to the host. The ECC parity bits used for this feature do not occupy the NAND spare areas.
       2. The host is free to have its own ECC engine by using the spare areas that have standard size. 
       3. We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. This patch has been tested thoroughly on Linux. 

    [Change ECC Status information]
       This patch changes the ECC status information as follows to maintain compatibility.
	00 (normal)                               
	01(1-2 errors corrected)          
	10(3-6 errors corrected)          
	11(uncorrectable)
---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |  14 +++-
 drivers/mtd/nand/spi/skyhigh.c | 145 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   3 +
 4 files changed, 162 insertions(+), 2 deletions(-)
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
index e0b6715e5dfe..d09b2bd05284
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -196,6 +196,17 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 static int spinand_ecc_enable(struct spinand_device *spinand,
 			      bool enable)
 {
+	/* 
+	 * SkyHigh Memory : always ECC on 
+	 * The on-die ECC feature is totally transparent to the host. 
+	 * The ECC parity bits used for this feature do not occupy the NAND spare areas.
+	 * The host is free to have its own ECC engine by using the spare areas that have standard size. 
+	 * We provide this patch to enable users who have limited ECC capabilities on the host side to use the NAND flash. 
+	 * This patch has been tested thoroughly on Linux. 
+	 */
+	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
+		return 0;
+
 	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
@@ -561,7 +572,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
 			    NULL);
 }
 
-static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
+int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 {
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
@@ -945,6 +956,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
+	&skyhigh_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
new file mode 100644
index 000000000000..f001357b4d85
--- /dev/null
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -0,0 +1,145 @@
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
+	/* SkyHigh's ecc parity is stored in the internal hidden area */
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
+		return -EINVAL;
+	}
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
+	return spinand_lock_block(spinand, SKYHIGH_CONFIG_PROTECT_EN);
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
index 5c19ead60499..2856eff28bea
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
+int spinand_lock_block(struct spinand_device *spinand, u8 lock);	/* SHM */
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.34.1


