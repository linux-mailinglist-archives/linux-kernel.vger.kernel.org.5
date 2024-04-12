Return-Path: <linux-kernel+bounces-142240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FF8A2965
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3682857C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC23218B;
	Fri, 12 Apr 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fYCs6FVs"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2010.outbound.protection.outlook.com [40.92.41.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4814A29;
	Fri, 12 Apr 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910811; cv=fail; b=i1t3R54uYJWk9lzX+kUoVnQnVXLdwiRvPJwIlD13LhH8I2Oc6qLJafGM4oeaKRn0w7GyvjcN4OyfHK9ovKrRLFjkGvXIEXKy05FO0gfVxpBAr//b1n0hOznqWkbASJGIuWaPEKOmWmDgcVYmMHHKEjAlZgFn9yidLfJDTpA32Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910811; c=relaxed/simple;
	bh=W4k3ZLKDfQx1l1lm1cLvEJdSqpmKzfqYcUiEYe+ZAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KJMz5wJjFptWtc9UlWMzFZfV5WuWGuWop7h3ZpkviB+SwpX3jAuo4ghdDdrlj41asbe6LYXnFxhhhWb/xnqhNBYmbS35GFOb8DgOPXFIoOjKpaVc72+7w1xbIKV886iTy/jndWmhXC8vc7aBhR6zuvWGjICz6CekF6/xnqhr0c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fYCs6FVs; arc=fail smtp.client-ip=40.92.41.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRMgSzrfwC/07wSOjPd00dzpmTn1ULqrb8qJ3kvgMhweTDG0RSiUJYIKrHHEkJYrzS0Gk8eAFpWpKST3MSgPE+hUpBgApxaF9M7zqirIjKEzGqPw03cM69Mu3dCRj1zdZ5f9CHyVWgVoGDwo52dl1+66r1/DWlQDlWwL41uOZi9Mv/OCzM82YH4vXdrf7qbStw6FICiTGXKfPKIaVVZbJdCAGvzaBo0wsy+Q6Z63TWaPRsH5z70K35UkeOGdAoGNHPZ4BKgh4OskB5WoS+OS99EhK6y7iQ6eJ0+PPjhQJ+ni28LrGAXR9y/n/5V7Dpj3GFh8QuYio57D163u0YwlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtHSEUGCH79iUT5Aaq5qKJXkljIrlqHD4rVX42/o3/k=;
 b=d/wY9M8Y9C70aj08XCXKyJ25lwWHBE+PEH1YwNWZK26Jx9P/i5rEVa/DRKzDYmj41KoM4uykDzMJayvki55sWyrxmGhFCYE7SR5dxmiOmfdRYXPBrINR8v5Qd0deJv3CkwsZho3YQNforW/VK8p9fFaq02r83czCXR3v9c3fM6EsKH2n5h2nlvwmykC1B66OU7KPVHpkMOEHF/+w4+83v/SEo8jOxgazQYpw38UaqZFKTf1LHt9SLFDYzGD+WS84GsyeQtcZNlvqy0jRiu9k4cwsQGZ1X05iHnvT6ywVp2/yL3IHwU9mfF/ZKqduhlrntqCsx9P52rrAipGIwWVEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtHSEUGCH79iUT5Aaq5qKJXkljIrlqHD4rVX42/o3/k=;
 b=fYCs6FVsjpqSHHBtLVQCob7ZYXYp0eD4f9Fn+273eo4nG8/+kDVR8xVnOC/4OYD0rvdbRjTbRuXp+q+lGOZJLd1uGhH16AdI603jdBMCqXENVppHyNAFGS+XJoBflS4P6wYWF3k4Gg9KKKbCuvfuQBtmvAnMkDUL1AjHG2b33XFu9WIp7ZXK7g8yiZipEGY7eRRVwJ0x1G0BFBXHk3ugUgrzqPyDCxnBf/8bSPoTR43pLx3Cq2GuTPt8K8/buc6OP1FSEdzNjq3sWtRYS00n8GNkTr4a+SGHI7UAWy9WXTjvrJGNSjcCa2MszUgjkwmvCLeFa8dflo3l5ymr0uCiCA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7513.namprd20.prod.outlook.com (2603:10b6:408:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:33:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 08:33:27 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: cv18xx: add DMA controller
Date: Fri, 12 Apr 2024 16:33:32 +0800
Message-ID:
 <IA1PR20MB4953BD73E12B8A1CDBD9E1A3BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Ea2B8I6C1t0aLQq2y2Mzmx7qL+B02L1VY674SNTnB0U=]
X-ClientProxiedBy: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412083333.199699-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dd3939-35dd-4f8e-7d51-08dc5acb3924
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6dwCndRGyVtehtsFBRNGEbPzSGrbhdRyftSqiHWwGQVPZ7pvLQJby2IFc5yYyuIKx8YPrtU4ICf2TpQh9QyvikNeAzjNwgu3Gh0deEpVMXCBTgYsQ8dcKEGEBghRESnZDSGZ6L6bdP2AkqqOQ55NoWCQ4mrFg95HSHqsTjwPxXRRhhLUVUt4d1T3LnekNk1uhmPJd3C0E0SN61KolIhWBovlGZ03BBQEexBlWeAgcQOijuL8uCsVKvyFn1kkNTB3rqgbPvhotelfLpCEHbzNka2LEdS0VxMoWAULVHwnoxo8lf8rOArRXbd8GsG1SgJQoqTt5/Yu41nnC8qNS+8SbchosFWXbD5duKMWk+kD1J4WqVURAF3RBWUOG4y6B2gMOruLHvwYWKTc1f1b6k9AmlpwlahKuspsHgopRa2K0PNyD088zkGNd7+8rgycEO/J1Ril5W8lEHnCDRgjYLSQlAUHe/Cz3n6AyozFV8Cki+9VnFioUsDZi1pGCnF5ulx0GbHKAvILIF+QoQorXyaHq/p9UJyAyeG6cOm536/J5WYlisIA8izUFpj4/3EHtrnsqI5d4HNowZKsvHHHuqnjqKCP5dc/n077oGD/7LtpE+IN6JNa1O5lhYgMzE0nn3TuWqUHls/fyXJ/S5dG96CwHkofKMW93w1sEUEuQwvRn3P0D16tnXv+rM9WbPm5+nEdqlUk6OXwPjlmhRFhTa+NVFXKKIv31CJaaTAeNE+Of14Xl7J+IBkxynAS1MVfUVe0Hc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wYzYWSrooDebptw/Jb+R9fGOCyM/mlfaga+zZXNYLfJM6PmIWhug+e7kirekONyZmTaxjX6ITbwwA5ytL9vhEiWn7dtWFZfhiRD2TtJGD3WiAjvrv6kMjMCdjKl/N2JqKGcUXVLpLlwc9jW9kMD942abTLblbQOPEYrnyVOf7QSesiBILcqcBetxRSBtMFIeJPsfD9kdf7SpCtVCFBK4n385uNmWwpjTDVpZsXyvwk2MFTysJXOn/wws2JyZ90KtFmZmgVpRogKCzOfiBKrSzq/L+aNUXXkHc5yywvVbK3e9zV9RzgYLP7II2s0YRN+RLS4lIb1LboVfCpIDfuvkXuxVn5amA0PoNZnKmd9pQfpftII7slWQIvxfPVG6pNKltWGOfmGcUNLaTmRAAxEODUoglYn3/4i/qB660TwiQNWlfDd3trRwMSf8L3FEKIFMdG7Ye5sXilOAu/LvngSTtBk6mwDyT4Teum/lbNHIjQw0RJ8Ttv4LiKXh15UPOfmk6LVccG35Ap/kpSnzZGmXxwdpx/7DV0cXbXhO2XARlRmyQGW3bzTalILJQfiFy0FvqSR1Pm0es1ryFIA7IuxCqLPkIKCleNO6HzXR/+rwWw6/FcNId+e/ES9TGcJddapn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNS+TRrmjLoH1mdTowEbZPAbiFVetUWKwWcbY1UdwGfhcqJp3Yp2F67OeQCT?=
 =?us-ascii?Q?TIlmZJhFG/mDTPL3hiH991oSDXIlbTIfavmkta3ltQT+gqeuZe6RnMbkufMR?=
 =?us-ascii?Q?DHUOyFinTeek16DS9Xg7ngCFsvYomkiju9yl2cSE6qrh2iAcQV2guOPRtjTq?=
 =?us-ascii?Q?lqIcKpCmRpxrtoyEz4Tzpaj1M5Va6YYryzMZJWK/6W/W5s7kjyn/YjFbxcdR?=
 =?us-ascii?Q?J8afSVsw5elSRJ/1C4miMDd9/LsDnIiw5yQe9P0OnkUH+LbaH6xeQ2hVv6+V?=
 =?us-ascii?Q?9bjhDWeQeUw3lHfUZ3uOAYZhtKUyyysJcXoZ0Br7rmQiQP64ALbGBq3gX4NG?=
 =?us-ascii?Q?0IEh2zCnAa1SaZ/WzVi0kJXnq6JPXtchX+rs5A2YhGlGL++HG7Ozmpg93ujs?=
 =?us-ascii?Q?fwcihAbAKudO+AlVBy0YKpl9UoFmwZo4Bx/MsJaOTjxGJAJP7ursNg8VHs2A?=
 =?us-ascii?Q?BXQ5Hgsokp+o5aVfZe5iNe/vzIdp4ncaE8vTGYkvvRI9wk7G3TBhJtlgqeV5?=
 =?us-ascii?Q?oJRxQ4f7Tv5FdyjJVlbrENjFOJ6hSUr70/QJPU2EsPw8NNAILsByATKWYE6J?=
 =?us-ascii?Q?3y1Veb7yRCwllOm4O9Xdf4HDldBRucsY61dveUvUX5l//fhrrnVkbZlFNFlh?=
 =?us-ascii?Q?agA+gKq0fIbyGqNWgiwHOkAedYZyI6KlIBw/sb5QhYpf3azbNfm30Dpf6UnY?=
 =?us-ascii?Q?pWb5XVR7Vu3ubgn2hp2ChvXTx6N5UlqMOCkSHo1pGL0hm4EDHMTpwVJPcnlc?=
 =?us-ascii?Q?dy3VHOXUQAvX1niJwksvqdo7BH02Mt5MW0jKI3pyUqPR2VacsdCwjrBJtaRI?=
 =?us-ascii?Q?m5NoYeZ9CnG0EDP9LG4YPxjbP3CUayKafqzdVeFEGPcVOgVIadQWEZhWQIZj?=
 =?us-ascii?Q?oEerAdxzdga/la22vXlpv2BTEN6TDo1iqg2QR0oAqIeF9iWRvwKtfvxrtF8s?=
 =?us-ascii?Q?6S4xSbedzY1DGR69bBh5b9AgvK2BESIk6kY3l0ObI6balxAbl/0Aq+EScPAx?=
 =?us-ascii?Q?TqeRN1N0vrroQ295w7HL/qnnGJ/WK4mBiUTQawkC81XgRXfcx0q70Ozwyktb?=
 =?us-ascii?Q?rItOxUvbR4DqkB+/BQDsEVNM6/9syz4UNfWTIssxcMyhDdnbU3dh0sLp8KU8?=
 =?us-ascii?Q?1vAd8gkbc7nHNalMBMwJFc/2kNuO6I+GJBulZtzJ4iHRt8kwAHm/aAF3tZO5?=
 =?us-ascii?Q?F4TGJ+5o0/HMOf7mLpPiqTwk7LC/3c8p5VH6pWMdO3Cy9SUXsmFAU3SH5B5B?=
 =?us-ascii?Q?R0k7Rzh9GVfRbf70IFZQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dd3939-35dd-4f8e-7d51-08dc5acb3924
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:33:26.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7513

Add DMA controller dt node for CV18XX/SG200x.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index b726871e6af8..7d96c4ddc1e6 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -195,6 +195,22 @@ uart4: serial@41c0000 {
 			status = "disabled";
 		};

+		dmac: dma-controller@4330000 {
+			compatible = "snps,axi-dma-1.01a";
+			reg = <0x04330000 0x1000>;
+			interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
+			clock-names = "core-clk", "cfgr-clk";
+			#dma-cells = <1>;
+			dma-channels = <8>;
+			snps,block-size = <1024 1024 1024 1024
+					   1024 1024 1024 1024>;
+			snps,priority = <0 1 2 3 4 5 6 7>;
+			snps,dma-masters = <2>;
+			snps,data-width = <4>;
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
--
2.44.0


