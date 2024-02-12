Return-Path: <linux-kernel+bounces-62121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1288851BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AD41C2151F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1A3F9D7;
	Mon, 12 Feb 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hz40hF1H"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507F46436;
	Mon, 12 Feb 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759517; cv=fail; b=kZ7D4kd4/m4w4Sr8YFiqj0Chtb+2nc+ljm8hk1q6nVYc+tpWP5M9/prmG3nx9loxsy3pzavq/9YaAKB/FKD4kwCmM87lqZGCSaL9g/Uk6r2YeyyQzdeNe53P1qg0u1ZiF1QpPaJq6UAvT+mj3AwOddB7x5On7be19BWo1w4XhEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759517; c=relaxed/simple;
	bh=ph9SmBrIBTf6R2xbWGu/syxdAkOOkeOxs2zCuKm/0u0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Lt/Ci4stq3Cs+K1mjwMHWn6GgFU73idX2MXCmQXitCQeQz/ic0iZkE1X6Cq7YxgStepojYfw8vBWxOA5BIfhT5FhS5d/afj9HpvWIzXRkHW/XXZPdwBvWoi1aZkPCpEToOi7WSNcfvTP0U0hmvVW3rSKwJ4ikPQe+1QW4izM94s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hz40hF1H; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD6Q2S0ptnEeMsJkbavuwcniF2PU/ScEnBrz9VahK/iH9vNH3xPFzP12l16KBQqFErLvzkX28JK0wQ1rxon+Sl+NI1r4wHa1OKHwlkLR5HaGIBWri3T/3LkQw2H9K33GkoM9dCKXZ8f51G+PMxvRaVqNnbPIgHK74kOn0byA40L5Q/XDXBXRRXR9HND84keE9DUDAysC5W2DGaho+b9ynD2axcZ5d5OGEBz/Ggdsz7OYDZq+c5LSJqpVVdRaZOisvM1QldrG1cgyNyx0DqYriMGH0FRIqzaTtikLQw3Dx6kVHmWjABDUWm3CHHdpJjxyB/vq1yBW9F6Y+S6YaOqXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M49RPVQDRuY+V2FKFZi99jgURfuAsNCh4dhWzC7A7ko=;
 b=gDGiMuDrrz1Qa3c5TatNeVHGD+r9IeWI3mi9dnD/s/u43z+nv2fICmAMGftx57gMKq3nxiWxqBeD1/AVjKuxYpxiRp8St5J6UHeu7ZBdqkQQ9Cqlu8Z/64qYZmWfyPwVyKDzoRDu8R7jWSqC/hRTU3aSLPrlhDnf0g36ny66VgC1mQ8ycg8ml7QeLi6mWTIZmv/EeGpYow9KsXIE4GoLYFExX9/wD9eglfzDA2mOkryf3jpRrCzVO+Go/PfWIyus58B97mwBGsdNYy3odqQicw5CMngFE7okl3EzRIKfKI1hvDKr7HhgX98OVjgguf4yvMvPgUEq4ps6Te5Hmd6H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M49RPVQDRuY+V2FKFZi99jgURfuAsNCh4dhWzC7A7ko=;
 b=hz40hF1HNoX8Gjolcz9OwiuQN8Jyyh24unmY94On98UhwLEaYRJQyX4hLPA2vfo63jfAXx2fQzhDTybX6lMzzTCoFMHHn6SnmXHwbx+4f7wuTNnUaGLDyCoAeAw7bUSCVFhHwLChwtSJSilMGzMuagzcZVd5QV5kmoqQTVqe51E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:22 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:22 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:14 +0100
Subject: [PATCH v6 7/7] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-7-b59edb2bc8c3@solid-run.com>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
In-Reply-To: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Eugene Zaikonnikov <ez@norophonic.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: e4310427-08ae-4d48-93d2-08dc2bf16897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qdq6OPuVv9mRpcEz7jVlQkS1ER2wmNY6wmWkXjOMqf8NTaSUJ/lP0AxQXXnoevSTmd095HD70fHRkJFSeWMvV9qriJbQg6U4kQHWHaIIbDOaO9KNL9gYRVkwICHdY3qBBssIw/ljBqBQ/HIkd6KQrE6vQ4tawQeXB1BpmtJjV3sqOzBAE/2+ohHV81QGs/tTuFmwRy3Z1w+3SQVPsrTEDb5ZaZMEJ21IPAt46Y+j/IRJgT9xrfuJ4lXCcFdE1/av1QvxHvy7N7Xj7qzFMNK1r93LMDXg3SOKCY7x+d0fNL6r070Jg63WTAdycrz+oJCRIkEAmFJiCaO9qRwBynfwYR/Q2jbNJOUo2rGSgHfDTjdChtR2yxubfdxCEkvdGRvJvavgjzaV8pTmtcVNfNvWYodzTjdsYw7m/MwTAtpTZQh7zuDnLDIgdfD37R2muwgO8ivj/JInrAJ+bXNKfnxiSNPwJ3dBwKP2o7d9Zg8ot1IbI7iw2U9AQb/+f+fwmCnYooNAvzOLQQgGVt17pXbcojplLSLea/OqX3IAwo0hsWRUcbFq018dTRwM77mSJHFTZ0VcwDFfWSYwNBJJH+YMVhvCmUGRtdkw1LpZCcSVy0Awynl/VZrF7p6zZXm/l9EW3HiJO0HSvBIkJn7rajHYZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(107886003)(38100700002)(86362001)(83380400001)(110136005)(54906003)(52116002)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEU4SjdPaDdjWk55MVZxcnVUb1FrUUhvZXRnTWVHRThTbFllZEdzc0tUTHJu?=
 =?utf-8?B?Mm94R08zWlc5TVArQkhGaW1IUmlWWC9GZThyc0ZPQzI2cUtQVlZ2bXFOTXZG?=
 =?utf-8?B?NFdiQ2dUL0FKRDdpQm5VZXlhS3pTcnYzNE1IeEpiVFJMdXpNVkZEekdSRlpl?=
 =?utf-8?B?NFJGRFBZRkZ6anFubW1pUFU2dS9FKzEyOXVYNVJtcEt2RHEvV2hJT2NQN1Vm?=
 =?utf-8?B?cHFMWFV3c29udUFMMzlxQzYzZnpXK0JRTGpyK2VkNExPWEt0U1NXVUhiWC91?=
 =?utf-8?B?NHpNOEkwYVpzUXlBK2x1ODVONXd1ZURZTVkwRXlTVUtJSVNaRzJpUDVVODVs?=
 =?utf-8?B?a0xVek1KRUFDeW1adStvK3V6bnp4UHFEUWxDUG0zZ2xKV21oNGFKMzFvVGtH?=
 =?utf-8?B?NmdodmwzaHcwaHBaalByeTJXL1VPY29HUE5EV1hkSHN3eEJlOUVuZEt1bGlL?=
 =?utf-8?B?V2JGN25IbFg2bkVvS1F2VDNXN0JXVE1BVlJjLzhGK29pRGhZMGlNSndhUkpv?=
 =?utf-8?B?bWFQMTB2eVdwSnBJb1VRS0IwTEdlYUR5TFU2Q0x6ZndLUjFOZHlOd05SUWQ0?=
 =?utf-8?B?TktGSG5HN2pXdFZxdGdkOUYzMmdvaVRmbGZXV0FMVUN2cGI3STdoZlVQNlpX?=
 =?utf-8?B?MS8yVzlVdGYwZm85c3pQOXlZSEdwbEJmeSs0aWorOXFKcjQyTm9DNkttc01T?=
 =?utf-8?B?RVZ1VVFOaHBpbG1tUUdqMHh5QlREMnc5SUI0ZzlBSDloR3dEbmdEYXhzTGhC?=
 =?utf-8?B?R0g2eWJJK1FjS2RmQWw0eWtyRlJIcXlacDN2b1IvL1lpN0lOM2ZCUGlpdzEv?=
 =?utf-8?B?YkI1eFNWVlhpNkFDV0huQmR2Qi9wcTlmVU9wQ3BpYzFSL28yWW1DdjR1THFl?=
 =?utf-8?B?TnV5WUp1RlRSNU1ici9rZktSSmZ6UGtITUxRTGhXQXRqajViN2o2ai91ZlNY?=
 =?utf-8?B?VnZleFJIYzJPeUx4RlN3SHBKNFhKL3Y4SGpoVkdxbFY0bnVJYzE4NXByM1I4?=
 =?utf-8?B?bGVkOXNEczFWcGdDai9WVjR4YkcyL0hTNG1CNUpKTXh0WUx3UDZUbzNIS3RL?=
 =?utf-8?B?V1lBcEVwaTdKbnBCL1RQWC9IenpMREd2VlptbnRvQkc2aTlQTjR3WWNXT2ky?=
 =?utf-8?B?MmJndW5mbjRPK0FrNENFK1d5N1huRzJzYnNTZWpxYXZmNzZUZWxHQVRFMG0v?=
 =?utf-8?B?SGNyWUk2WldUajNjc0EvS3UxcytkUE5qTE45ZkRBS3VwZEl0MjJrWmZMQzVD?=
 =?utf-8?B?bFgxWE5USkp0Q2RZRGtUT0RZbU5PbUVhV0IwV002YmxKSVBJK2FPY1EwdGJl?=
 =?utf-8?B?RzhHY2tpRldXVzRoR3h0UzllWFZOQTZhUUJsWXA1MWxSKzQ4K0tBbC9FWWdU?=
 =?utf-8?B?ZnduckY3YWZxSUNXQ3IvbTNzRzIrMEFFVEFBZW4vbTV0aS9VZVVoM1RLOTdG?=
 =?utf-8?B?K1c4cm1LN2pmQ0wxMWNOZERDdWE2MUViaVVSaVdkdW5EbWFJbjh3VEIzeTFq?=
 =?utf-8?B?YW1oeU9jeVFFVmMzenJ5U1R4RW4xL3JXeTYwaGVTSHQ3dERMK00rSlpBcHlT?=
 =?utf-8?B?L3p3M2lOWUxVVHdGcUZWTnJiL3h2dDYrWmM1b2RmYytMTlllOFNYaTd4WHp5?=
 =?utf-8?B?Z2FTQVBobTZLZlhHYjE3Ulg3MDZYUGVrSHl2N2NaVWxiekdLVjFuOSsxcnJz?=
 =?utf-8?B?YzFvbmxXRXA2akpmeHFxT043ZmpOTWVaQkxEZ2oyNm9yK1lHb2FkdWVzNnhj?=
 =?utf-8?B?OGRhUnhhNjJBbTJpUEtpNHBMbzBoRm9wa3NhRUxnMHR0RFhsOUsxamNRUGQw?=
 =?utf-8?B?SkhtNVFJRmIwRURpSDZuOFlXNVI0bXZFVm9EaTNOZzBVVmw3QU9Od2I1WnRq?=
 =?utf-8?B?blBzMVI5cUVsS2haaXBDMlNXYUl1N3ZUNXdHMjU1VTdURlk3dm5SM1FEaVc3?=
 =?utf-8?B?NjU1RUtwVWJWWS9HWGRKWHlZSC8zMFJEN1VhdFhXV2tQeG03ZWIxSGxaNzUy?=
 =?utf-8?B?UmpJOHQyTXRIc2Nha2JHVCs0aW5BY3c1U21xTXd6TU8wa0VMd3VKODA5YTdP?=
 =?utf-8?B?Y3RYVFVBV09VMHY3bGFvY2dKb0dMVkZZZy94MHFOUnJzYkJiNGFhaUh6ejl2?=
 =?utf-8?Q?05kYBD0nKLv2DqoNVuwTp4TtL?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4310427-08ae-4d48-93d2-08dc2bf16897
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:22.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARQsICIY9HsFYbr8Vt1cvKtoecpSsTCO2L8pgJHXyJKMd3kODcOQFGXfT50xFsPjoGYTOZP5oTeg57vxoIlplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
The single SerDes lane of the SoC can be routed to either M1 pci-e
signals, or M2 usb-3 signals by a gpio-controlled mux.

Add overlays for each configuration.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  6 +++
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  | 45 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  | 44 +++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bd73ce06acba..cd12720638c7 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -37,8 +37,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
+k3-am642-hummingboard-t-pcie-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-pcie.dtbo
+k3-am642-hummingboard-t-usb3-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
new file mode 100644
index 000000000000..bd9a5caf20da
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable PCI-E.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_pins>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes_mux {
+	idle-state = <1>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
new file mode 100644
index 000000000000..ffcc3bd3c7bc
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes_mux {
+	idle-state = <0>;
+};
+
+&usbss0 {
+	/delete-property/ ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	phys = <&serdes0_link>;
+	phy-names = "cdns3,usb3-phy";
+};

-- 
2.35.3


