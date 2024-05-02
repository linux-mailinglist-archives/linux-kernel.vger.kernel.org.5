Return-Path: <linux-kernel+bounces-166099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A314F8B962F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA1F1C2161A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A65383AE;
	Thu,  2 May 2024 08:11:40 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2119.outbound.protection.partner.outlook.cn [139.219.17.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BB33CFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637499; cv=fail; b=GuNPdGPEgYuURiJjFNR2NtmcxHJRve2VeQKjrGT6Q+aa48+nVlXdD+QW4sfNTWp2ZMl0jti6luFUCGmAQl4VrdJN9HyNQC4vWACCtws7Ox+cVdLNelrW+dPvhakNU7QL1KXOtcdW4sG9w/ruRU009/rFDtDFtrCGvLuk1Ped74w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637499; c=relaxed/simple;
	bh=0EF2OfMSd3zhffEVxIn4rVybIqzYkNP7QiVu+qEPigw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcO8RQAGNT2VhKWYbPR0REL2AdME3nyD1463kJDopcFxNJYMDe6HKaV3A82Uqbas7hhGFyv0n2Zm5znj1UreOj63j9pMtDAyScIqheDYaj6Peitpftt2lTKKawIAKMid6XY1tNWjAi2p7hnt5HlIpMzYzObkPPMQ/rYP2+0l++c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUL1eQuq/H7y0SguxyvNRxbWLFCsQf0uYDNc09fnyZnGgDJ93gZI3amFrBrt90iK7OD9IhE1p06WDKIA4zXtMSdX3PuFGyqI8jN32RefyHFDiTQ5awF0JYIOHha3v7A1BRPkR9rDc7cuCgv6t7ORZhg2Y0CtZh305FyPWQkl0yhRz+kPiXf4f1rw59lVvNROPO90vKalE+cYR4gFKjfI20QJZk7DExdzMT0L2trpCoHnm1bDiwzF/50pj+OZaHxu6amobQ0g62QHwi5VVuRFc7xc/6wHujLvo+sxiJS+0gKeSuTL5bJkTr/y2BGyQ5DRekvRPmEJtDZWLuQ9iuGPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTJWlMRmnsObQMaH5Hz84zRT2q5FDRkA9QHrkw+hAKk=;
 b=QwocxQNIF6A0nYByBEgwc1KJiC/0RIQ+tfwt/chRfGeb7sQ14poN4FPifQdQ4q3dWQQLWrxGlKs/F8xCX6mSvNT9uwn1V1928hqvet6/uZ2igAjny94gzuyonzqwUbWCWYSSId8NvEi56LXlYfVq8iZ+36G3tXe4PfWHJzFgnbw6CeXvPSqUK6q0QnWT/Ht1meFbX4iLPWb5t9ZMdpR/YQwDfj/bugqJ3am/uCtW40Gwq7tRJGcxuIAB+xq9sPDr7l8B+8kAbNPv5V1UfiDmf8+4EqMba7yR4TLVs9RXqTHigfM6fwKeh6I97zNXzek/g5JWZcvjZ1htjYvnYRwXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Thu, 2 May
 2024 07:38:07 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 07:38:07 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: rafael.j.wysocki@intel.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	sunilvl@ventanamicro.com,
	jeeheng.sia@starfivetech.com,
	aou@eecs.berkeley.edu,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: [PATCH v2 1/1] RISC-V: ACPI: Enable SPCR table for console output on RISC-V
Date: Thu,  2 May 2024 00:37:51 -0700
Message-Id: <20240502073751.102093-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
References: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::16) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae3b41f-67ff-4da5-8b48-08dc6a7acec9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDIerNr7jdMz5gyYAf/OyrBP5lNZ6xTJM6bP+chFPiHPyfbbjdrvJO+HuM3MhmdlXDm1TGWicnxiPKl9acps1OSaxrQKLQfi/CHHA4+ADlBOe+34jD1sza3eNAyshJG0y0/MdxvX6QhBwliAvdzB9W7Ki19/gN6XdWs+2WjdFqJxdAjPZPED8p4j187xcbsdTCE5YA6Jv3QqnZlrIeRMEPqCiSCncH3LbzFnTot05A48XXfHqUGJkiaCHu0HqgUQIK5s5jEarg3kkwN8CS3vwuIFQYp/8riSUH42901jdBiL48bflt5AdxG0rnwYM5hAiva5WxGdt03BES48dc7DiDVCYcF4zXBw/1FbOJhAMvxVLgHCHXGwo78EVpBHWYLwtgAG024Ucr+0FfeN1Zo8iFWGXsfdOiguuoHuWR8ewaDs7lyv8ltVR4EtchhOshjL2tRYLjfT0JgrcKYvGgtx7lMfLWwHqty2CktZmjZJwmbzbuJev/ab/PwoxgLVkB7OGXrCAQtqUsdSa8+PSDNZmX7vTiFVqb8nIc7Jvh4eNDz/DF+Lc5M6cr5fLLp8JJvTmAXah6O/+lXIR7S4qK3vblEymg1JIPkppl8GsOKZezUeX5FS10y96EAl5sylOD84
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oj5Ht9mzBe4p/qJDzxVcf7aV9Ja/FNjlv0wucuAFNxaNkRzgksXkXpcz/s1i?=
 =?us-ascii?Q?krluqGPl8uPrKUC/6/s3s01+ksd+r3sIENDBa5rC+qEy1lP7YksVUFcCdtum?=
 =?us-ascii?Q?hFbzzbyKhnR0LMUL9d7jxLaXV320LDmsVyvWn7WOiUChKLpFCwoC+em172jh?=
 =?us-ascii?Q?sL+uSRobHQg/A8qUt6EbeQDtLdCmHeiRliFUV1Mr97ds5g4hPhGXyjrOWB5d?=
 =?us-ascii?Q?YIUBto2O9D13eLgyaZT1cJY1eIlazayj2jZuGh6LYDUq3XpNLa43j9A7QASl?=
 =?us-ascii?Q?b9RAn7L4Y7NvtWN84hNg4puqjNvBDkYn0J5AN+1m5Zid7MadEhI8STNaMPd6?=
 =?us-ascii?Q?OLxUBSN8hlEiwCvhHnuJUEVph8db7aRNBQqbQCW5F8SoLUbeMwHBJLP7jnj3?=
 =?us-ascii?Q?3Su0W6q7nZimocl2uB6JMhH4isVLW/fK3no5NvI/+PB8XhGoZ99h/4Vy/qwd?=
 =?us-ascii?Q?x/bR1qLdDd2CxwI7Ryr29djm+7Bg0E8OsWCiERInN/oCjbkDZwonW1xRktYK?=
 =?us-ascii?Q?bCaxjMwWv1GvOTiFkM6vNjJAHVOlWqeQ64rK+mFfohGysbH+9evMq6F8WQCx?=
 =?us-ascii?Q?SLjAA3yWr6NW08OmI3graY9TNK5kzWEznS+3OgytRUEIXKvy02YmWUWP7s7z?=
 =?us-ascii?Q?AtP0BurJMMgpgdendzq1MVq+krvkoifdHkk/Is8lgrlwc5KYVggldfXOYNpu?=
 =?us-ascii?Q?V4M8Ot3rg4NaVmKskcYRYgYN9b2trTvjB2x7MMVPP/u6VAe1MSk7SMB5oPiO?=
 =?us-ascii?Q?bNdlsu7pVSKMGB0gl1aSqtkE5DVVsGRSi1Wg9gyglgkowflJieq1rDykiYaA?=
 =?us-ascii?Q?e+JQByTxoqQ5PGr2fjBSZokthAAm7h6KttxxbQZ0zEPJlKqAOcZ3uGuGXOot?=
 =?us-ascii?Q?YACCSRByKpdBpvbkiFIt8/p6zaPljiq3lL7/sdhgEfyqdGuRUSxWu0qNLA4G?=
 =?us-ascii?Q?AYvCGD8McfRYb6+C6pftsnzcyG5HdZaY0MyZxfu+1drKgocmL8wPSCxwEXNL?=
 =?us-ascii?Q?t91AK41fUD8vNATUyvI6Jk+5kWIa2FBF15AEbQK+pJdHBAJc6jzZlKP4Vn+2?=
 =?us-ascii?Q?jBIgkFvuOQlrrqICi3QCMN1Y51QckFPBd0DSqALrQ1gEnT+xiSPGojWWaKy9?=
 =?us-ascii?Q?8mG1/QYXLi9hzyEKVxZpA5EgHCFWuV1sggKWCPU5Lv1o4/W5PBRA/8O6E2Vg?=
 =?us-ascii?Q?Q81Ic/TBzXSeePamgxr+vWa9oWKu0kQX04gIVuY4aTbxKUlV7+bA7wYGajyS?=
 =?us-ascii?Q?nISPVrQYT+KZ/kVsMYeq0XbJEG2KLBqE2N+5HV6+fHOI3ueWsxxS8eiiI1MW?=
 =?us-ascii?Q?6n+BRGrd004yHVQu3Mywg5s5842A18B6bQS2iRe6WHfxHoka94eqwaexfngu?=
 =?us-ascii?Q?KOJPBQgZYjfda3xzM6yx6ftRNc0OI69O6PPkGnHCj95HfbH59OOK6wNsMqwT?=
 =?us-ascii?Q?tFM3byvfnQmKN8t+VaXjtxHaz1tC0h+pL73YoP3LlYvfTcQwAdFCctqxtNJV?=
 =?us-ascii?Q?YDEwo6Y1k5YXmy9xWjvIUOU0CCoYpVQjvOQYRpuQ/CpeEQgvCV41n03ShC+2?=
 =?us-ascii?Q?B3QHhK0oZADSr/6ZhKm7godE4AOht8qVg6C0V/r9kcz6NycK2wOBjOaZJi0q?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae3b41f-67ff-4da5-8b48-08dc6a7acec9
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:38:06.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijq5IA4ncsG8pAH2+mFqy8WzVIHskk1CSbPUb4HS/OPvdQF455uDcWk62FpPGil2liaGk838nSuzNmmK2exa/2nzhu6rGi4qA1fi1CaUhNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1087

The ACPI SPCR code has been used to enable console output for ARM64 and
X86. The same code can be reused for RISC-V. Furthermore, SPCR table is
mandated for headless system as outlined in the RISC-V BRS
Specification, chapter 6.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 arch/riscv/Kconfig       |  1 +
 arch/riscv/kernel/acpi.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..ff2e270bbe01 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..43a12c00ae8b 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -17,7 +17,9 @@
 #include <linux/efi.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 #include <linux/pci.h>
+#include <linux/serial_core.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -131,7 +133,7 @@ void __init acpi_boot_table_init(void)
 	if (param_acpi_off ||
 	    (!param_acpi_on && !param_acpi_force &&
 	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
-		return;
+		goto done;
 
 	/*
 	 * ACPI is disabled at this point. Enable it in order to parse
@@ -151,6 +153,14 @@ void __init acpi_boot_table_init(void)
 		if (!param_acpi_force)
 			disable_acpi();
 	}
+
+done:
+	if (acpi_disabled) {
+		if (earlycon_acpi_spcr_enable)
+			early_init_dt_scan_chosen_stdout();
+	} else {
+		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+	}
 }
 
 static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
-- 
2.34.1


