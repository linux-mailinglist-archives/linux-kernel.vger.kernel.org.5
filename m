Return-Path: <linux-kernel+bounces-38319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4936983BDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB787283F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B91BF5C;
	Thu, 25 Jan 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="krZy4pmQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2094.outbound.protection.outlook.com [40.92.18.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B21C6AB;
	Thu, 25 Jan 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175993; cv=fail; b=in3jVYQnN62MOJlr15H4ykFw2mnc+lCGBovdtjJSbO6h5FwLjXVp5/MOlC61cVbso37Re5XKMir7ESX7lyjmGAvkxGAYygiweAU4+cqnC45L0mSrO0w7H41Dl6hTSK/CqkageRag8G1sLq2B1hIpJVaz5AObbA6NwAblaZGladk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175993; c=relaxed/simple;
	bh=XyPrv35XYrRVBnvqjcHCv+6Mcj82XvXv/4/9CbDXnLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UALEXucqd/eVKMQt8P9n+ZdDRLtIkL3cTmUDJirQihqUlqNEZnCv+RV6rgcs2FLCXG4Oka1+VW5siQkzqAZcAlVozJM7EHRT5VfD6kzH8MR8XyUYc1JoDFC3szgOgDWQgawYHJuQPMB3H2LlrBk8PmaIlA7oiB4Pig7kaaTK/YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=krZy4pmQ; arc=fail smtp.client-ip=40.92.18.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzHRbrGoT590sPns9sd23pQ5z9Jcp4gQ4BDhtH0yC7pUKj0yI1ctQhWqf5ndPlwDJi17lpHTOZOgEv6yblWTX3ftdEytAD6f7/OwZeHpjbTn2xF11al/KR60entOosb+FST028ARLSnMg0hkIbeFIF0Ym/sD3jwF7lBQDhW45BR2VmaXvx1ndhnkXqfEBVhOtlU1ADJPZW59JcQqeegr8oT9esn3wwoQkJMCfiP6rqFvfeCjkZ+/g/VSYXj4MkMKnYZaBItnngI8anZ4yBbDkhlF5aMWWXpckEmCvtMjrAPry0UCsHfQI9q0uwZEnXDfe3lHz4U+JTcUO2PPrlh7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvhMhEr1gG2rZCRANSeO9n2GaX3aIe/oAFZU9L/doX8=;
 b=Vi95e/z+aTBYUzycTWooCnVmW7u3NeIjpfN0pf/UGQEis4UikXDuWs28YJnJpPz1p4xpwyP5NmVkOOYrQPay3YNreEshKINWP6SCvD3b7FGe2I9KnmACcBN5LAsNUd/Cm9Ruop/0Nos60STFTlAJTvXkg5IWlz5L8LPsKzi3PgjykyNp40rBjseYiWbXpzSeWfCoh+uu7/tU8kBUCOsAvJ82YN1T3XJHQaT5dRXnVdwxtL5UfO/J6jijTZM/KG0+xUZxuTSCXW9x3VBtqHUGBVPqWzZAg6n6ti9oQzLHZ/k2L/+xGJfuRQoPyRwZjUHK76eRcJPWCIEgTItYvQVZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvhMhEr1gG2rZCRANSeO9n2GaX3aIe/oAFZU9L/doX8=;
 b=krZy4pmQtayOMw3krIy0L8Fz+eCySTTFYHL0fwBikA+A4xb+HZPKhf+5w+YjRFhnoraFGhPqItK3A72D7h+aPVqsx162q+5WvmcALdYr0sArQAuW2UOYm02V9tvWZzFmbPyeB3oA52aUL04JMn4IoA4AxEVBVOChmLd4lHJjpw96YE6ymf2K8ckqO1gdNC0NP7Ltg6YXT5zheWnOmfPDYAkBBfC0AUTBU1S69EGR9jmmwmamrbRl+aJUOepmpm0PpeI4TwlEjUk7f5cQgYDKNUuhMeOR5ECTGqglYaiPtX3oeRLaaQouQNmFQL0/uAcuO3tWwkeWg7EiZOI+ki9ljA==
Received: from DM6PR20MB2316.namprd20.prod.outlook.com (2603:10b6:5:1a8::28)
 by SA1PR20MB4275.namprd20.prod.outlook.com (2603:10b6:806:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Thu, 25 Jan
 2024 09:46:29 +0000
Received: from DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::eada:a454:b624:1459]) by DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::eada:a454:b624:1459%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 09:46:29 +0000
From: AnnanLiu <annan.liu.xdu@outlook.com>
To: chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AnnanLiu <annan.liu.xdu@outlook.com>
Subject: [PATCH v2] riscv: dts: sophgo: add timer dt node for CV1800
Date: Thu, 25 Jan 2024 17:46:23 +0800
Message-ID:
 <DM6PR20MB23167ABF18C1F004A5710D4FAB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8dmQ79MD5VeY/5T3aa1ZPSLy+/pgmXnGWCBBYxXktng=]
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To DM6PR20MB2316.namprd20.prod.outlook.com
 (2603:10b6:5:1a8::28)
X-Microsoft-Original-Message-ID:
 <20240125094623.27188-1-annan.liu.xdu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR20MB2316:EE_|SA1PR20MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 189da528-fd9b-4ce6-b13a-08dc1d8a8159
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZnl7OK+GjNZx76AODbk0dt+LKWMRPEIDUGU2sukGk3bH82ehqnde3qe9cpdmb3XB7DvY/pfM+yDftnEo3M0GC1iWcNKrNzPSCKS1a8MLn39lTclUQ3/2IcOB5OmkiTsIIU7R9c9r6y6ZKAouj5GfenLbEP8N1BSvAgRvY6+HUaj+gaujtz5CRTFv4qlXRXHOaRspmnA7cToXLx/8hCwRT/PFFZ2CpO/Lov5TxIorpVHpiAbBxWd1ADcdtC57AMzqCnivi/vVNfShAg8mz6o76Z30sWscguGfvEZrSk/LbEACnwkoLcFS4RGcbJSx7p2OfsfyRpFJcJtUbKd8OgWKgHwZNY0YML+bTfBObxdD5wpagNNlZoasgrV1raKY4ZP2wGI+k6kUPZBTsvoCBJ0f8DCpoVxFml0am9mhM+u1Lsv8ICnNIa499x9S4KY1k7XSGIfZwonr3Fw2vmG6gvIzMq53pn5i0CGcYMtd/FasjqLvqpveHANAc/rQFY6tCEXG1InITLcZyC9z0aLmzwTfNotsh70+KTp1gBezDXh5/C8ndF5H6WlDxZr0we+6yxFbAw1YRJDwHrS4vA5CHY0ixz6ZGyyJHWdzs/iQPHe/GyeeN1dZVzfEE6a0JX5r0MxGnRS39MqWH6g9XTUD2Gy4PTbfh2Qy1T6aZAEK1aNDqXLQkj9QCNDIEd8C9qVT38/X8TlvyYicC4ShQSm7Jv/nY7JW7kPPGcfNh6FI7fXbWjLJCvBVxPdvUzaauli35uu9mVWJUIroG5PkRhxJ1zYBukLHy7eu/7jm3lgrmq/Jj8EGDwjDxe7Aeqx
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ucm7QRgwI7Gu22cXbTdDghDKORct0FfKzsDC1HlG4ztU06eUaaHw9SNcFWlYwS+T88XJZ2a8jce8TdMuT7rXI7EOJ5UD+rrSXFc+EjK2FGYO05blS2sTbg69RDg3WjjYwNruPLp7wOcKb4zyQTQpnBdRdCZM5mmOzV69MwQm11PY0HntiEsEPChzOKcFcdU6/oX18k7yX0qEbjr/TPETewlaXyi0MfSvHfVlVEdfDJfQ35jBmfxf/z3xwvxei5Udl0ilpX/f/Y2ylzvQd8fSOeZXUYMcH7mMgH/ZaZHFjrTJLYmEmYe5xFkhBBIAXtN3ABSuu50llkQ1ONb70ozWi009Z1JUHr2MDWO6eX/JUuNaXPhc2E6fFNYrI4te6xEpoTrsuvZrYQdxIgO3nietrcKaCKl3gv6BSdVaEQgViUO7+FwSgyw47pA0ibV6hhCpNZxTv6jvl2lvd2PWIm/TVQ0C8DBsImYeo1Okc4he/Cg6KAU1xRqlV2/jrUfABfnsLW+wpISkwXjuKR3POnRzj/zk5Vu80R5p54hypnVuD5Ka/TtEyxdBL9XY2+XzxmBxPOKri+hptbH+J9106NPyjrLPmhAgCowy5hwpT0rlQuq9EGuAYbSK3fC38fZqH2OcHzLIq9CaMuzSFlYp8jnEpqE27JSQb/5dPU93ZOTpI6I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Gg3clQr9nB5amSEQdYmqNOdYFJ5lPOQ0+SmtekMo+C4jzVrl8ZjLM/868Ub?=
 =?us-ascii?Q?hrf5yUH2ziVTI0AG4gZW1PRaclI+iK+C2t8ELKYZ4o7b2YWlr7YgRVhw9qhk?=
 =?us-ascii?Q?r/mjsz9NhQMlVTR1iebpv4N4YGXvJMOE4URmuT4S/96JWUERf3Eh15IpLI6g?=
 =?us-ascii?Q?gJU3ZXYTH7R/0PIedQwgqxnwviBBWWp5D+vXm7VrIm/nJeI+pPYouhXjB0F3?=
 =?us-ascii?Q?yJIikzgpdgmxQkQg0+9+Zz+1PF7Qk1oENU1OA6tovDBYLpARFnmnj8eQcFR+?=
 =?us-ascii?Q?z1cg0l9s4pW9Ngb3uevpuF+Z5eI+jBcteJT0CYcvZ0tTHDow1YB46RphhtCn?=
 =?us-ascii?Q?9mbZ0zoxiEnzWHCKIltA4BvAlg0HAPnr1C6or1QksTpkjtTuQxTg62q2dISF?=
 =?us-ascii?Q?gEXteDFZTp9Na5eeD/JDvQHVUDGIzU+Uwh6RRKo8NgVU/PwihgiggNpqnZ0V?=
 =?us-ascii?Q?zCjn0LkGILI+fpCv3kak1P3HZ5pAK5rAn81JWEPxbNAjmDMEhCXsNcsYWpa+?=
 =?us-ascii?Q?Z/tnd7rm5aUp/D8RFKzcGyzWsjgWi3ecqGlQ7/wB3uKLF4mrj8p7Jra2KDW6?=
 =?us-ascii?Q?+29zJ7fk4AuW8Nqe8WTOH9ia5PAloajDbRIXeZ7tIzZzJJXUZOMv1podAgCb?=
 =?us-ascii?Q?3ldHFcp0kNG7MFHCnjpWUSL0N+ax/goKMhDwk8jXRaZMzmz+8Wh/ERxNB7tQ?=
 =?us-ascii?Q?3gQcuPCjaVoqxYx70qMhkBa5X6TsxGU22vkesHJ71WP1Uo/jW99MhtwdeGJ1?=
 =?us-ascii?Q?lkjSOxMicdL04d7t1/nvY2TxgtN8ZGWn9yTrFjXrPiLdyeIiBqn9m1s7/J5d?=
 =?us-ascii?Q?KLADYWlZxV/BAOb00Sji1emNtJJ/WEhARFf8ocYo8fD0jwoo5oEw0n/g3Hp/?=
 =?us-ascii?Q?cZCM11MXslsix4dAq3V/6bMFm783+nJv0Bv84i74P47jHn9wJKgndumCFl/R?=
 =?us-ascii?Q?30QozcXKVWzxf08loDuP6Xd+OJX71mph5ftzVwdsfnsAfsdWPEvISmHXSiXn?=
 =?us-ascii?Q?bDeUtq+fbCqgSk9KZKLstOaPa0SysxHCt503N1rSYn9iLtfFmogC6QY0uwGd?=
 =?us-ascii?Q?KzBVvFSd3t/0I/ZXied0kd6+U08I53ABv8hZ1iA4jIoxwkRw1NgcDw5PilmM?=
 =?us-ascii?Q?euugj468PDJhCJuLNRkeyPJhZ0nRYHa7TpLqJRMtSuNbiGA3OQ2empof8zMi?=
 =?us-ascii?Q?nsA2dtCJjapXUevDIY3Ng91CmHwmAcsqFHe1+w62T2KOWZZcxq7TT6GxxJw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189da528-fd9b-4ce6-b13a-08dc1d8a8159
X-MS-Exchange-CrossTenant-AuthSource: DM6PR20MB2316.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:46:29.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4275

Add the timer device tree node to CV1800 SoC.

Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
---
This patch depends on the clk driver and reset driver.
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reset driver link:
https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

Changes since v1:
- Change the status of the timer from disabled to okay.
v1 link:
https://lore.kernel.org/all/DM6PR20MB23167E08FCA546D6C1899CB1AB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/

 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index aec6401a467b..aef7970af2b8 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -113,6 +114,78 @@ plic: interrupt-controller@70000000 {
 			riscv,ndev = <101>;
 		};
 
+		timer0: timer@030a0000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0000 0x14>;
+			interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER0>;
+			status = "okay";
+		};
+
+		timer1: timer@030a0014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0014 0x14>;
+			interrupts = <80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER1>;
+			status = "disabled";
+		};
+
+		timer2: timer@030a0028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0028 0x14>;
+			interrupts = <81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER2>;
+			status = "disabled";
+		};
+
+		timer3: timer@030a003c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a003c 0x14>;
+			interrupts = <82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER3>;
+			status = "disabled";
+		};
+
+		timer4: timer@030a0050 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0050 0x14>;
+			interrupts = <83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER4>;
+			status = "disabled";
+		};
+
+		timer5: timer@30a0064 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0064 0x14>;
+			interrupts = <84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER5>;
+			status = "disabled";
+		};
+
+		timer6: timer@030a0078 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0078 0x14>;
+			interrupts = <85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER6>;
+			status = "disabled";
+		};
+
+		timer7: timer@030a008c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a008c 0x14>;
+			interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER7>;
+			status = "disabled";
+		};
+
 		clint: timer@74000000 {
 			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 			reg = <0x74000000 0x10000>;
-- 
2.34.1


