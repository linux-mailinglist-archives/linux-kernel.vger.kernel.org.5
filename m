Return-Path: <linux-kernel+bounces-102777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3387B72E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DB1282A61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533E8C07;
	Thu, 14 Mar 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d09Hvd4e"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19011003.outbound.protection.outlook.com [52.103.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4E3234;
	Thu, 14 Mar 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392361; cv=fail; b=M1yxrXe48g2LSCgLVQRUH1yo6saE5yoJiCTqgQtNzjkfrU5NKEMgxgbonpx2AGdZk9qONshS6ab4m5kZEDyvarZydL7FqOjRqBQqwuIyjEgXpIAb7BjFdkvKb20vRHrbz/Ttdfwuarp0mWpSvlJ5YTAmVdedVa3tiKEtkcp7Pc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392361; c=relaxed/simple;
	bh=dqo8rpc+eJlypZjwwroscuPZllnWWY8eqDT/X2uD/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o33J9K8dv9oETuLZa01UxBrcYrGm3aqaGOlHr75xKF+X1f/iZets3tj9YTgUpcWgrLvRVMWhPC6dPtnf+nnf2y1f6tBCDQDLcsm/vqOHdkuOfzUFEa/fjIB2X50rsduoeHAatNDCIb17+XhUhqIaP4NTLXnnWAqxoVTtpCsFLHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d09Hvd4e; arc=fail smtp.client-ip=52.103.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOMbysl3m7+dcrJFg+E5q0DgBa0QylmM3OzEIlF7fuQyLkmILcycLs+MEfo77uu0gy8YNG7+lg2L+wEMml9qHpP9t7J7sW5paimOOm0XDm819nFpnZzNpLyejxrUMBABvFMl+jMCf3jB1vH18ICUfXa8ecjqqSmpj6kdNNHcs2AGN4KLFJKRSmiIFCLqC0W6HucVUbm37x5GKlb02tzq3p7B29ca8+YMEmqP+apgnzt02jIYNrlK+fe36brRErU2Fd18twHv/T3J+Nn5vPVLbaeJLP+ecKRcixjXrrE1e76m7QrmEVsQg5nZkiIG/lMcIMcX+jer/zXBTqRLxjXW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poC3kvfIgSBt190X28S5i/6XPrr++Q9iHCeSLpF/KFI=;
 b=HxoBzq6bbowC15Nj04UA7RWNwxpAkJO2Bg1Hs1L3A2v2vwtumLTd63YjGeV+wY7moQ3fkAYDwK3WTE6heGxP/3R85IOKZhkpn7jMFR/ySnp3VNQIC/doGGYK09Y7NBHwgJsxQ/RBxkQyDGWmAfEG0NhTGC4Pa0KFfvvTCFYWrNH0jg0PF+MdmyaAtJyaion2B3b5suTcvjTv5MJJ6rlUlruTATZb0bVrXc5f7TCqdp9nAxkUlAc9QyLDere3GFkzB3mmXDvVnaNJnVd+5fiRodh7uEbmoFMcb3Arq788b+wdsMYeWuBNk7JIfv8FEdg+TAUMTN5bB9f12FsG3vUFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poC3kvfIgSBt190X28S5i/6XPrr++Q9iHCeSLpF/KFI=;
 b=d09Hvd4eLKcN9iMMbtgPP5SifmJ1zbDH1QNCFSKT8sIQpHFhcHnI7OVLTyCBlpwTerRWlo00Q8OgD9M6tpKipx65yUCg/t/NpZBmabKBxFhmCixUg7V58fPcfirar10EN+fxjgfIor0vrraMfblsOZrPBP4x+4A0yVfcEd7U5uHEHXxyVxarjZVqkLKRpYNZOiK4UOPNIzGiEl++RAxmQdq7ZYuD+hvakNDVG8O+dlk+H5/1Jz7P4Hyb5OZ8ljUEMeNbsJ0D+l3y8ku04iTs7k6ZpzG08d/np5SWYeLieXTibOWj+hXa52YQ+SBN257MZJ7v7D+1Sw8qvuqktSfijw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 04:59:16 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d125:453b:b7b:e90b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d125:453b:b7b:e90b%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:59:16 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: setup: fix detect_memory_region() function
Date: Thu, 14 Mar 2024 12:56:46 +0800
Message-ID:
 <TYAP286MB0315E609C476B86E22700626BC292@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KS2YiHBNAd0FpgvOxlN9vQ6MjYwldyfVS0T4hzFzxtM=]
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID:
 <20240314045646.14824-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a46f2d4-2a41-490a-4a0c-08dc43e37fe1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y/UON2jP9EXLXwURU5M86YXQFS6o0tNQMzg4heUnmudB2HONNnNU41/8uzO9dEJMNZME5TxdC3ymqfopOVE4p5sEGJqyH8uAXdTiiiGTmlSGUqchmVpSomNpIYyccAC3OFpWu2E3NOyur8G49dZvi4/uWZrICVerjnyhPQhLaGI0EI0z6QxngDII1QQ8lhEbwdFX9syVm8wAK+ibleF6+NL6yuFs3TE8cgGxN/9wSt9dj1y3fu+ESmjLQFomg10lXEfwqyYc22BcT9vv8wzrqTgigOQ/1QDztSc13uj8R3kRkaGCHI3vWDIiC6gFGXdZn2GlEGrrl9o+JKFi3+JLc+UKO4Ox/zeJ0PcZzfiMxUIPitV+9WOC0WTm44gkEG6b/suHvN+I0qQCDZQ8wK/l7H76Xc+WQVlThyglsCbtxnLfQq76m34QFXwYJlSuK0KnkHmkk9fRnxHoKVVSwruh6MaPNazBIWDKSZ2X+cPcn/syOnpd1Cq0xvXNooowlSDIizeFs95SoGmcmRaDD6kC1s7MZfup9/NpgtlvwK1dQEFlZ3bdwYogNLCrPjBovomkB1mCT4SYKfh9Oc5eR9dBvZWgOEDRYh+VhZq2cuRegMscGzHWV7alMQPQupF8zAqP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z71bNVLsdFeOpSqEcdbnr45cuNp6D4NISCmrPA5lABVmJ8vkoeiW8jc+a2DX?=
 =?us-ascii?Q?F3B0hTyQDa2zniXID0yjmaTF79a78BIMpSUgORFnNBK1VYAs24HjO2Qnr+uz?=
 =?us-ascii?Q?faNN62j6nbPsWDuNaRDc3XxX0wclRBU61js5qNFTthEFpg6CWUSfwrQcpVF6?=
 =?us-ascii?Q?06n8RgxmpJTChS1DXCGK05sN8BTn02se8ej4bJ8VVl6nNEfC87maVWha/uov?=
 =?us-ascii?Q?yfig6uyk9fv9gXdUvsBfEDjB5EgH3LtoDK8xmDCV0wHHONSe4bFZ9FVs/xia?=
 =?us-ascii?Q?mafWi+bdZMQdi83Fm8TSGllcMJCP2TNlW7GV3uHxYb3K5AFSW3NGkKSGSF3z?=
 =?us-ascii?Q?kgQq0JTQN9MbwhEZ4JFm4eRV8ienLuZPD0MAVU0ZwZihPiEingZxgk96iuKK?=
 =?us-ascii?Q?VxDtqE0TR/JoOxK3Jn+sNfG3s647j21HFYK/m5AKAH97JdPNrIxBpJm6/Q9Z?=
 =?us-ascii?Q?/bTvqQfDziynJzo5WxLPtVKJRnY8WgFUCQjLZptHc6mLgQ6cUebDcEj4ip2T?=
 =?us-ascii?Q?AmzdRYDwBPYG29USNWHL1zpGzxRpNaCmoMY1deeOVPZxQbL9OQYBF0K6pcZd?=
 =?us-ascii?Q?9/fzzp6ccp2qEn1Dxk1EFkzhBx+5EMzrWIqCQHR2IuwMXr/9glUxtv0kT4zs?=
 =?us-ascii?Q?xFTOPAVOLYTrUqctzhLMk/6E6qItuMCtSB5cTGqcUeiIBkNsAXIp9d6AGmMN?=
 =?us-ascii?Q?X5Qzk2RwVjsxVOHfze93trZpygT3EC0lWVx9XQWpsdlHRjaouy8rnGQrPPmX?=
 =?us-ascii?Q?+Xtn3WUhnxWHKc3gcdw6OZXgdYX4XcgW8GonZPLqgKcbMcYnIrZNGjJrKyxG?=
 =?us-ascii?Q?acsMU2JMmepo9BRRR2VEfAkMZRmbsz5YdOqbO3PDwYsHtoWQTjMaKH3ZfwQn?=
 =?us-ascii?Q?WigqiVOS4KiRvuoA6hLKnRWtzkKYFvZr0SA8UAAPciNaasj8tDf+OmQVrWI3?=
 =?us-ascii?Q?avvB1dSTFFKCK/tGfSzSmkT9rA18r5Br+IdGSa7v5A2sRVHrwhYl3k2rd7Vn?=
 =?us-ascii?Q?dDImti0rWNsu1uotkJ2Gf723HcOl0KbkRhhUiTIw9DwbOTvse3Z7+SuaRqJU?=
 =?us-ascii?Q?dZnxIuggZCaok/VGfnH001AQ8e52+p63i1Z4HgPmLRYJVH6asquyBDwMuuYs?=
 =?us-ascii?Q?EKpy5+4y672t4lln4Ug741+4ClocZ/8QERwiecFaeOHvGfXt1qfL99d1hJ2+?=
 =?us-ascii?Q?Q0Ef6CnTXxQwH8c+Lm9MduOlQBIFQk2Q/cAW/7DyUne9pIzqwIYycz27mdmw?=
 =?us-ascii?Q?h06+Gn5wbwPZ5PIVgOwg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a46f2d4-2a41-490a-4a0c-08dc43e37fe1
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 04:59:16.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2335

1. Do not use memcmp() on unallocated memory, as the new introduced
   fortify dynamic object size check[1] will report unexpected result.
2. Use a fixed pattern instead of a random function pointer as the
   magic value.
3. Flip magic value and double check it.

[1] 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when available")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/kernel/setup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9c30de151..354458fa9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -46,6 +46,8 @@
 #include <asm/prom.h>
 #include <asm/fw/fw.h>
 
+#define MIPS_MEM_TEST_PATTERN		0xaa5555aa
+
 #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
 char __section(".appended_dtb") __appended_dtb[0x100000];
 #endif /* CONFIG_MIPS_ELF_APPENDED_DTB */
@@ -86,7 +88,7 @@ static struct resource bss_resource = { .name = "Kernel bss", };
 unsigned long __kaslr_offset __ro_after_init;
 EXPORT_SYMBOL(__kaslr_offset);
 
-static void *detect_magic __initdata = detect_memory_region;
+static u32 detect_magic __initdata;
 
 #ifdef CONFIG_MIPS_AUTO_PFN_OFFSET
 unsigned long ARCH_PFN_OFFSET;
@@ -95,12 +97,16 @@ EXPORT_SYMBOL(ARCH_PFN_OFFSET);
 
 void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_addr_t sz_max)
 {
-	void *dm = &detect_magic;
+	void *dm = (void *)KSEG1ADDR(&detect_magic);
 	phys_addr_t size;
 
 	for (size = sz_min; size < sz_max; size <<= 1) {
-		if (!memcmp(dm, dm + size, sizeof(detect_magic)))
-			break;
+		__raw_writel(MIPS_MEM_TEST_PATTERN, dm);
+		if (__raw_readl(dm) == __raw_readl(dm + size)) {
+			__raw_writel(~MIPS_MEM_TEST_PATTERN, dm);
+			if (__raw_readl(dm) == __raw_readl(dm + size))
+				break;
+		}
 	}
 
 	pr_debug("Memory: %lluMB of RAM detected at 0x%llx (min: %lluMB, max: %lluMB)\n",
-- 
2.44.0


