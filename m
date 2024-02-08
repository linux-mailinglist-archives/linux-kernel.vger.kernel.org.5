Return-Path: <linux-kernel+bounces-58295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAE84E42B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5061C21073
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAF7D415;
	Thu,  8 Feb 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="g/HBttYr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F047CF1B;
	Thu,  8 Feb 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406872; cv=fail; b=s39weJ7vNhPIQczrC5zc8GVci3Atf643dbaEECet/42gl2EbWeytxHpCf2/C3PepmYmcQlDE9bXfpj/I7fc2rnUvhzLi0Ws1kgDY8P49M6ler2f6/fkCVb8XI4xFQB9SKDHUWMcrqYrWbc/zgO8m+S8NoxYvohGwBlHmQu3rfhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406872; c=relaxed/simple;
	bh=bpQeCPlj119oYEC2ul+re0q0sBVa6xiao3JVx3YSNj8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OY2KOr3yQtrgJKNcKGdnZlLOSrEFF4h6hDk11/HIEUklabnHLxADfoVcAdWxsH+h9nXZ18f+A1/Gij0c2j5qVzlngmtnC4xlOTui5rXd0X4WNW8LZlHvzKb1X52kMNZa61ak79+fMXV/S+y6pLUMxKAhfj1hhaZeBOfm1eOLTFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=g/HBttYr; arc=fail smtp.client-ip=40.107.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amdTxEO35Ol2fLY/v6EvxXiiOf8iEJFnf+X0S8Pkczq4Bihf48kPEmtuss+p9aWKBnVFdBsra0XnMm0cvei4jgpzbWf57M6KsiEypEYw+gjHxHgkq5aV4vA5FiT26QxiRiKr7qHckt9xvulpC2iLrzwoz8SARlK4eqK+7GW/uF3q8LVlrs7EhO524otTFn7WGTD7Ry8KK4IF84uKojoHLPRSXXjiAgUtdRXsfqfHJ4Aj5JVPoEpLySAuNfK8hZBmylgREGAX7OGC2J8OpG7k1XNsu9ek+Mk8ZhOh09e+iHTxslghtYwFw3wvYb02HCLYln07Mg0UhVdKOY95CObjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E73qvcYPt+w1rq3AgHdWgp3ZIRu84aG3pPkfSbiArU=;
 b=l5rBnmIJx+o4n/qyIlxzX95xp8G0tT0vwio39JNJxEvRp90rBxtR0qjJnVdtGigndV82vNRSd177E9lSafb06egYcQBc+wqLYveYiqlcEF7FwnB+MdcpyqJxpa7dfdUWDSkxnwbYzqRyf0uc6ZYQbOas/L28KMLcncRNxzX6lQRgCKfvWWUK0aEpZip0udAe+0Ga+ojFoLGk6QY1FWRZESN98HxuI1HKTbfZL0Jw1catmLDhalZlZpLjEnGN/wZJ0sPP/1ZZfCwNld0hyXW3OjRHf9wEJ+Y+ugDlEv7r6IOxeoihnAKLbvgWZ8GrX/+Tpi/IofLFIh3xVzfUWq7GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E73qvcYPt+w1rq3AgHdWgp3ZIRu84aG3pPkfSbiArU=;
 b=g/HBttYryVByc8G1QirxumJu6NUZNEURJGfSEcPNA+nAiFkZDn6NUFzbcW5KXYmc3C0WShoooTs0M1vQo0KwzThGJVdX775shOPp1oSkSj8+ZfRwWW0JdNBjuUj6vxdDfM9BDuweaaTJRuMRIGyoOul26cVjc3T7hQcSN8XZ7m38JKPYGigJOSKRMs243oys0ItLvIq27cxI3WiI6pd14jd/xe9pooMtoS1VyT780M2yBK6PVRj79oKdWTUFwlKM6M7rfq9zToHe/XDBzzvVRPTlKW/OlLm8+0GkloDIg8PmEscw8WJRLNASp1XnkkGmPXne429S1AjyxQPWg09s1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 15:41:00 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 15:41:00 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Thu, 08 Feb 2024 16:39:56 +0100
Subject: [PATCH v6 2/2] arm64: dts: rockchip: px30-ringneck-haikou: add
 rs485 support on uart5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-dev-rx-enable-v6-2-39e68e17a339@theobroma-systems.com>
References: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
In-Reply-To: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b44e0cb-4831-4156-a47b-08dc28bc593b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nDKLzK92bQqkAbydubnS1Pue1Mjw3JNk+m7qg4b0KSVFzvZLEk28SZsVg0AtoSkMonkEkpo+NaK/kVGgHGc4BTWXWzGG4wdl1GlrzwOPVo8lhherQ1QOjg6mu/rEITe1gTYEz/g8zLqdIisRoqTQ/kyKs+oEwQNflqFDCuF9XYms1o1RcR/fl6RKnbuEPZPpx4/TDvQ6gCMfbw5+IPAk+8DV0/4MR6d5xRUf9GQ+UKED970v2XIJk0W2v5roqWzjFraDTyG9SADHJ+0UmBL1t0Ax693drHumOI2RZUIYcjDAKJC25HD9UWtQq9heZ2lJCxHHt2QNc2LBoKWXGJoqqpZM0a/YakouF6UNx2N+oEbHxkQDHQuP9TOMlizLW9MVhY7lezCFvpVpKePZ05PaoaAIbs478oFN/UJb13OU0aamHxDJXRP8cHS8Dx8toz+SZTyAKgjEalJqT9zABBQ89BDsEIcFkJf9/CC/OmPzKZweD5E3ttbM4qEhinICnqYJ7TrEgE7kRY5FnhuYLzQWfpA0EexcaTENlPMq/tOOTSRPiY5pqhLZv0ADACAwIJbNsMuUHEGNnrwlNnUOBcswZhZyUreRpsiXg90HtQqSH4Goj/CHqR4yo1e5XQm79Dyj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(86362001)(2616005)(26005)(6486002)(44832011)(478600001)(5660300002)(2906002)(38350700005)(110136005)(66476007)(66556008)(316002)(66946007)(8936002)(4326008)(36756003)(6512007)(8676002)(6666004)(6506007)(52116002)(38100700002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXMvajRiU2ljenVIV2NyOE1GNmlKWTB4SkVqZXhnTGNEMG9tc2JzdnVEMTQ2?=
 =?utf-8?B?UjBzSWpGZDRSRHZpeVg2Qy9WK1Ayd2ZMMGxFZ0llSmVsOFYyaTNBelUxaXpY?=
 =?utf-8?B?K3lpSDJhd3BKNllpTnM2YVpBWURkOXkzTmhOamJsMGsyYVFNVFJmNU1id0Rq?=
 =?utf-8?B?SHc2STJTd1IxYW03QTNibWk2Y2R3TUxxRzU4YXcyU2pzbTloVlE5VGhJRndL?=
 =?utf-8?B?ZHNqZmdVRlJuS0w1QlNMYnh4RHovM09JZ3VxbXYzYnoyS1JUVmFwZzA2MHNR?=
 =?utf-8?B?K3NoMFlLTXJ3NlhRYUsxMTM0d2xsaWhJWkRhTjRmZGdjUVpaem9NU2pqNWJH?=
 =?utf-8?B?U3RQSndVS0psbUpPSXdiRjZlTEF0MUF1TlVxcnRTUS8yYU1ha1lzT2txM2o0?=
 =?utf-8?B?dW1tQ3ZpY0FCVmE5U3hYZ3ZYRVFpZFlnNm9GU1NMdEo2THMwT2NQWXZCZGJN?=
 =?utf-8?B?K1ZmM2JDcjIvempMMHkxWTYxNDNIN1A5b2RIci9qUmZSMTBuZWwyT29ObUdU?=
 =?utf-8?B?SUEzSW4zTi9HK0s2dDEwYWVIeUdCQ3pJemJSR0ZnQ2F1c3l3UldrejdyZjgr?=
 =?utf-8?B?UDNtL2FnVzhjS1YzOE5yM09vTGdFWnBOZktidHMvMnZ3YUhNZHVpUDk2ZVJ3?=
 =?utf-8?B?TUJGaTNSM0JwYUV2bHdsRUtUblJjc0ozWlVKSWFwcm5IMFYxMTNEeHNWRkpq?=
 =?utf-8?B?Nzh0WU9qTzRZSmRLR0Q4eEp5WG9GNmQzSHFvbk1FMlE5ZWxlQTB5SUJ3Z0VR?=
 =?utf-8?B?OWZjOHNXSjVONEpmNmN3Q3A2VE00dW9Da2dpWTlvTFJ4L2ZlbTBTZG5IWGJK?=
 =?utf-8?B?dUpNNzljdnZMR0Qza0g2K0hnYyt0Yy9tbmYxdHd0ZVY5TEVqMnJOS2FnSnFn?=
 =?utf-8?B?WXlFWFV2V2ZSbWpJT3oveUVPRzJMdW9hYkxkTjYrTUN1dngraUt5K1JUZ3BR?=
 =?utf-8?B?SVZSYVh0b3Nhd1U1WG5PZFVqU0tzdGVHRDdOcGltSlRKbk0vMUNvVStOUDVy?=
 =?utf-8?B?d0pvajdiYjU5NlJVSUYrUkg3RlVlMm91Q09kSGtSQThNOFR2cDBpdDRNcTdp?=
 =?utf-8?B?TWlzSUtWZHJYbXlmWlJCQVFsNlhSbVh2TDlmOWFLaHRiT2xBUzRFejdTWmxG?=
 =?utf-8?B?dExSNk1Ua2J5UTdwUWt0K2pNUnZjb2ZTdWJ4UXJraElJT1kvVWtEUUhQR3BO?=
 =?utf-8?B?U1Z2MVhlN1BXWkpFSWVGY1Vpby9ZLzBqaDZmSWZpaEJOMW5vVHZyV1pHeG5O?=
 =?utf-8?B?QjV6QjVnMjBuVHhJZ3VPcENaTWdQTkVlUWF6MUFTTnh6N2k3YWU1YVp3ZGpu?=
 =?utf-8?B?Nzd3eGQvYkpUMjRCL1NWeGo5WVRwZWJRRWdadmxEb3BFSnh5cUFFR2JHc3d1?=
 =?utf-8?B?S1djemY4cGtjU3JYNVcycVRodTJYUlRPNXdtRzBoYkZPM2o1WkEzeHZDUWVp?=
 =?utf-8?B?WkkwWUlaYjVnbU1TS2lJTG9wZEtiMTBXUTNyRkdma000Zlc0cmVxVEdYNGN6?=
 =?utf-8?B?L2h6MTczMEduVFE4THBFZ2NpeWhMS3kyUXB2WDlXbzhWeWE3Si9SMWxSc0ln?=
 =?utf-8?B?emJObzd2WHROTStVWC9heUxmMGk3OWZQcEFoMXZ1SFJURjBwbUl5U2RHSUZ3?=
 =?utf-8?B?d0s3WW5CWlF6UnFBR3Qya3lhM1Y3M0dpQmJFNElZWEpHRTZuWk1YaWFHY0FB?=
 =?utf-8?B?dUNuUHBnOUFYcWhweStWUS9JRXhodDZDY3RrbDJxeitjUXU5bVd3bWNnWmJn?=
 =?utf-8?B?K1dxT0ZVSGlLK3pLYkhyWCtEQ3UrdFRka0xBRkxNR0dTTm1jWndSb045Vm9r?=
 =?utf-8?B?Q0JoemtEcFUxR2JzaGVTZGhJaWYyVmVlU3FrOEVjYkoxUW5VYVd6azI4cjZ1?=
 =?utf-8?B?ak9PYVNtbkplWk9LZXRCajNrdDNuUnQ1aTJoeEpsdmh2UDZ3Q0tYZlpJS1hl?=
 =?utf-8?B?MFV5UGs4aURMZEcxSW9CZzlLS3R0M0hWUmFvSUgzckRROGV5aVpoQkk0YTJw?=
 =?utf-8?B?Y0gzR3czMGplVC9YUUN5T0hsVkpld1plQW1RNTlyMmxoMTlkbGJQdnZSZnlv?=
 =?utf-8?B?cFlaT3IzeDRpdTdSek9BRzNqc2dGMG5Ud3VjWmVzQmhuZXIvb2JNMGlER1Vh?=
 =?utf-8?B?cE1tcDd3SWpkN0NJM2pGUm94a3RENS9uUm9WSDNmeGY4MWdwUkxZcWV2WU9D?=
 =?utf-8?Q?n4YTno1jS/I13++p8/J5MEc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b44e0cb-4831-4156-a47b-08dc28bc593b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:40:59.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNthGxRdS4RFGHNByN5GvJdptv68quzWJQk3QImw9HfDttKAIT7lE/bhNt8JMXt/6jZdozJ9p9ai3uukSGgh9JdDDKYbRBT+Rll/jcUNtxvj1+l4oZyjw25+zb5EsJaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart5 using ioctl, DE/RE are both connected to GPIO0_B5 which is the
RTS signal for uart0. Implement GPIO0_B5 as rts-gpios with RTS_ON_SEND
option enabled (default) so that driver mode gets enabled while sending
(RTS high) and receiver mode gets enabled while not sending (RTS low).

In full-duplex mode (em485 is disabled), DE is connected to GPIO0_B5 and
RE is grounded (enabled). Since GPIO0_B5 is implemented as rts-gpios, the
driver mode gets enabled whenever we want to send something and RE is not
affected (always enabled) in this case by the state of RTS.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 16798eb77077..ae398acdcf45 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -227,6 +227,7 @@ &uart0 {
 
 &uart5 {
 	pinctrl-0 = <&uart5_xfer>;
+	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 

-- 
2.34.1


