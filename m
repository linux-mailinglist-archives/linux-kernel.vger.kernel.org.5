Return-Path: <linux-kernel+bounces-49939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D08471CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E451728DCC0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5757145B0F;
	Fri,  2 Feb 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="O+FK+oC3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2095.outbound.protection.outlook.com [40.107.22.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088314534D;
	Fri,  2 Feb 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883748; cv=fail; b=ZtNMxO/ru9WT7PPPRdGR6BPnoApJZKPMGFANepJVe4flyfit+UvF++8TjDstHn/1U4PPJrzwjBNIKG71PoKZk9c41gISL9fjTOT70r73PPAfytkcZu2ldum2uy1mwFtZBf1BEnqP8A2g7lMjriKQqbXIjqXWfp9bWszgMIrzvGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883748; c=relaxed/simple;
	bh=hMIKYwARHFl28aOlzWwWn5CF0EjqFkk4UQThGPqCf1Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HVbDgrgLlV6vI6kU4uRv6ECYyh1I6jctktbF47OPuWNCUoz54rp+xiU1f65GpmX+iKRt2BGP1u/4b7BLcfzrZUB/M8e+47KIDwih1im1kPeSrHBHtE89ro6iKzdK5QOT0YWkQATpo0L52J5q0g5kKUWRA+646EW2JTXqazZI8CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=O+FK+oC3; arc=fail smtp.client-ip=40.107.22.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbx3bXk2sQYZfPn/kDN8IXJRxdEKsq8oEZSAU0oaN5NhbQxjsMmRcEtt7+KCCR+t05huuqQjjspTbCy9zkiIxzNFTRpE2BQKhg0ifN5Q1WnRqXEIFQU+NsOedeDAIyi15mR9WAXD58+MOPNUAQSqnWLUQhIiqlKCx8H/0jx/2PasovQqCRkzXSVrVjocPgMQOqQrOAD17kW3TeCleTBmfa+NHaGRvXyEYgMr7vyzEJt5fPQnERATLf1SHwuCYu524x3nVrab9iipQZPYRNsPKD3xVFDCA1JwACEEI8XJu1m+0OPNfzmdzmMCkkISkaUxyKuz+3nohuuqq8h3iwjk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=iY3WU5P6EFsYfbZfpcTnd0V6x0+5gfuK6cWHCMu52cuuD7Z9IISiTmy1B2mBWxNIF08y47Yhs0doSIWp5dUn8mFdMoylO7NCKtjC0ilRp120+2F2zO+zy7o6SHZYWKvKy3ZjIeQ/yzaa6Rszac1qjd66xUrwJZPK60S2SXe2I3rdgCy85UkBOKTGpM2xInYwtP5ReaJMV3UJznplcDVZmJ9JA8ZJiL0otvE1IClw/IO7sWkMdSUJhzus5I3UUDb3f81ry0rit7gXsjX2Yfs2Sod9LQpQfS0IjsOWDj6JGbfxfiuQd3XVnfdKD95YGd3HZYdL596ixOxLRN6HjsU0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=O+FK+oC34r/RDo8lFkFYdfBR93lHEiQBVKctXcQe/wYPB1KS4lotmN2IcmwRrGLjfS6SzmQtg4qlREHReB1HNjdycjez7G+xK/yTWhxNm46vnAFQLXY5kJ1KwMTIz++FdpgtlVAnColtYX9XstcR0iOlZSyj48fzASkt4FHrLdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:22:24 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:22:24 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 15:22:19 +0100
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v3-3-2f44023d50e9@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Suman Anna <s-anna@ti.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a9f311-adfa-47e8-c555-08dc23fa5ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vYbIZXzYac8GuJoBhA4o0ovutt5xhnjYrSPeGPQVjGcmfZWkHG6v4WQLFyQVV2ehAMjepxeE/CUe9U31oIvstQ88y1lsccus53y3280RR/3y6+aTCnGVIqlKB3qOxtvos0EhLQKTiUHINm1UytpWLYVWxvgzxDOb+JaSl24YEDHilkGNaPwgVzLj4zhjb+j3clNAy9/mFjpJdYNdjppDuAxs8bJm0ysi++HUtF/rCgkNUFZxPkSU0ynVuHAQGUBQ/Gfjq/jcTsJ9B7XhpvPmUstUBurmFzwGrR8ctVFV4Kupt/mV7DZ4pRL3CXOt+RV7fTj4WGAUh37iUBvHoU78hG1Peb8jFpwkprIwVNJFwWSjaTP7zIJ5YwavTco3+wL/FoKWmLKSrsVldQDqH129z94WZDWh/4a2qvrnWnGW4KxRkwZDxomRg4fTYIHhUV8+IxD9a0zQJYzfAA0GwyCwvyfPxtRkNmuGiHNEywSyBc0NLDy/D52PASmmPjFz1vkCF1nE6YeZPFioq8IACOZtensul+XEJR6zu52P/aSyfnaHVDLxmcK9WyoCtEHy+zfbTJbLq9h5iw16HFGZPkCFGOjQpQRsLkCsFZQAQfzxMYEqokuJcb0d4EtO97j4vrOK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39840400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6512007)(38100700002)(41300700001)(8936002)(6666004)(36756003)(8676002)(6506007)(2616005)(52116002)(26005)(7416002)(2906002)(5660300002)(54906003)(6486002)(66946007)(316002)(66476007)(66556008)(4326008)(110136005)(478600001)(86362001)(83380400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0t1eFVUc0xpMjF1ejl0d2pRYXo5SmoxdmNvYTluSy92L1REOHhuR3pUakw5?=
 =?utf-8?B?blE5Tk5pNmpFMWVwc0ttdHMvcjZvSUV0NVgwQVA1Y2xmN0grQy9VbVR0U0VZ?=
 =?utf-8?B?Ty8vcDdQV29DMXI3L2ozSnBGaTI5WTRrWXNLQlRML2FrMDVxVWVhTFpBM0Vq?=
 =?utf-8?B?QWJObXZRRUFPU0d0RHgwWEtEd0t1NUpSTm9FbEpGUjgxajI1enlDREFkbkZI?=
 =?utf-8?B?VjdRNVJ3SlNSYkszQ29WVmZzL2xSVzJFREgzZUJxUE1McFQwZkovcXBnNmZN?=
 =?utf-8?B?dVVVbUFDQy85a0N5K0xBeVBJMFhJRzY5bTJOcytpRVFlOXo0WUNqYmNDdzZ3?=
 =?utf-8?B?RlNScFJBbk9oYkdhQlFVRUVLVFlKWVFYMm1TUE55MHJkY04zVmk4YXErU0Qv?=
 =?utf-8?B?Vng1Q1liY2Z2SmhwSXJOaVV3TmVwVXhZL29SclpZSHNLM0JwUDBISWdVR2hI?=
 =?utf-8?B?c3l1SHJPYTFaNWtqRnNGMTA1YWVOWDh4eHVLVHIwYnFEYnFpNm4rODRFWWQw?=
 =?utf-8?B?aGphU0t4RTA5VXNDWjREYXc1RHlRY0RrdU5JM3ZoQmtiU3R2SllwaHZkT2Jn?=
 =?utf-8?B?cXp4MytGSjlXMkl4NEExbG1rUFZyY3ZVUTFuRW0wSDY2STMzcWF2YVRDMlNQ?=
 =?utf-8?B?YkJTaHhrZHhIbkFuVUJlKytsTElDTUVLakt3T0ZERkl3RGN6UzlFRCtaWmZz?=
 =?utf-8?B?Q0svbHgxWm5RZmZseG5DR3VUb2pxNndDeXJuNEVYRlhXUE9mckFydFBMejZB?=
 =?utf-8?B?ZVkrcERycGlpWWlRODZlZVBpNG9QNHdUeHJLLzVVR3oyUXJSUy9sSGJDcW4w?=
 =?utf-8?B?SWdZdmU0cFNwZmJybVBBRkgvU2FWV3JjVkVVOWVjZ25sUTlBcVJJU2NlSHlu?=
 =?utf-8?B?YmF0blJ3SjNtS0pWcXVRbFZuQUVaTDRrMmh5VThuTGRlYkU5NlVFU2ZydE5Y?=
 =?utf-8?B?YnNmTktoMVhsUFV0N2FSeVFPV1VlTnEwL2FxRnhmUnM0NGh3WEdwSDVZVzgy?=
 =?utf-8?B?R2FFNms0bkhzdlFSdXZHa1BUeUM4ZFMyYjZhNnB1OGhJOWxnWThOeVhGV3B6?=
 =?utf-8?B?R0JOYnRtSVdkL3R0aVhlM2s0czdFd0xmTjNjdyt2MklrQytvWlA3bjNvbFow?=
 =?utf-8?B?MGtCQmkyRkdlbTJVQTVEOWtFN0RJcnZ6YTBSZkR0Yzlad0tHUmtQRTliNzhG?=
 =?utf-8?B?WitnRTZrd1FDbm9kVXdBYmdCVGV5bUsvSElwR1lFbTFSVWpnQjBxV1pOUytu?=
 =?utf-8?B?ZnBQOUlMQk9nVm0wd3YvcVpQVWREZXVncVFUalZSWlRIdnd0c3pPVyt4dnU1?=
 =?utf-8?B?MlNjUnJCY21iY2dMY3ByaDh0ZERQN2twVmo3UzBQWXVvbVBsWUFYRkdSUEtP?=
 =?utf-8?B?b3NHYTR3Qmh5RlhHaHV3aWJLeVhqdmtHZGU2YUllM3pNNklVUmppU1Y4M3FV?=
 =?utf-8?B?QUtaaUdIVy9rOTFtckJlTjE4Ny9UZFpVUmRJZkhyMkRhbW5sZ0d5MjhMRDJh?=
 =?utf-8?B?WlNSWlJVdVUyRWJ1VmhEOWVDSWZlYzNRK2NtVVFXKzYxQVl5NjE2UVVoRXFH?=
 =?utf-8?B?emFZTXAwbUNFOWRPVFJEUkIyeTFnVnp0RmFWeFVZSllmRHY3WDRuNVF3TlZh?=
 =?utf-8?B?ZHhEY1pYbzU3M2xOREFuMmNsWnAyekNLTkYreFVFR1ZvTHhqN00wd3B5VzdW?=
 =?utf-8?B?NkpVQmJUc2FydGFwb01iTlZTdkFoMG00YkdqbEJpTS9aY3E2TFNTd2NnY1lC?=
 =?utf-8?B?MjFRVHlqeVZjQmVaUkxSaTZIeUdKa3dsZjg5Z24rR3JURHZuc2tHbHNsbENV?=
 =?utf-8?B?d2lncjRtNlJQK0FTYWNmNzlzRTFCRzl2ZEdjT254c09uUm45YWJXL1Q0eFRy?=
 =?utf-8?B?WDV0NFNQTENnK3RYQ0xOTnVmRHVHUjVzcEttNTQzUVNaa2xycWY4U0tZYk9v?=
 =?utf-8?B?K1d4azJnWlljaVZqOUgrZ3VQVURoUlh1NmxXZXJZNVlPQ1FXTzdrUHljWlJM?=
 =?utf-8?B?SkxpajBZeWNabWM5L3JXdUZMZU04SGg5YlFNdkExSUFIYURuNkh4UUQxYnhN?=
 =?utf-8?B?QkxvMU5uaFVwOUhqakpmWk5wYXIwOXBTMzhSTndFS2JhSy84MGNBYVJaSFZa?=
 =?utf-8?Q?6tH6kt9S4cXbQ1dRwcYmkHKQb?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a9f311-adfa-47e8-c555-08dc23fa5ff3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:22:23.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM17LH4IFrBBa+SrEKBq7kUlvNJntwFukBtMZzkQmXEOEuftOrpWYqFFS9aKT3JCE1vmRVntewd0KxEqpn3zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093

From: Suman Anna <s-anna@ti.com>

The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
derived from either of the IP instance's ICSSG_IEP_GCLK or from another
internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
instances. The IEP clock is currently configured to be derived
indirectly from the ICSSG_ICLK running at 250 MHz.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0be642bc1b86..8130ee02a3d9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1232,6 +1232,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1373,6 +1385,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;

-- 
2.35.3


