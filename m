Return-Path: <linux-kernel+bounces-40437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B783E01B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BCA1F2575F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76322219F6;
	Fri, 26 Jan 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="EiBOgBfK"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C77210E9;
	Fri, 26 Jan 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290130; cv=fail; b=Nhjp8WLvTzKRUuYAMB0sln9TTkhemnGVpMC1LabJzIFFYrj5H4D1rUfGMRaCiGFEfUnWFOEAQdmP2ahQpFx/ATlxJwRUVKQ043Evm35cEY+VbIAawL4BmKBJVrzqxCfjeHP+Oh4Cy1I65nV7W+pYiJuT0+CJ9Td4EZ7p9sk+nIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290130; c=relaxed/simple;
	bh=L1LBo3EmHljy0N4wo6uS24KfxGyxhrOe9FDDZAXSSXY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G5ZsmaNRGXodVmggBPxhT1oAGvCRlKVcB5zyCD+D8a9ykUYtKNTpJnRAOVgdMzZpkndotEExPqIlyHbq5PTcUmLl0FEDmK9gczq7fAMPkY8RLkjrntpDT7VSZCDtdEn7yJa92qhF09ro4lsOjo/UL+9nZd9xhmEe1MiXGQ2zGGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=EiBOgBfK; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrUKs2Evl1EOoStGT/WME1ENJui4K+Czo5huJOL2dY9z2+UBbtpXHZzUu5pZC8LWm1B+9vQt3y9MyHS46HGu2x36jFobwA8kWZna7hsiZR1caggBmDbgHhZ/mqWbpV3ZpZkEARrIML2D4suZr4UWPD+IGCq1ef4zN8IAu4yxPm9Fqn/ORFFNNHvavapGwL1xhClH/tmM1z5wUIv7cl2pcGmbWHmw4NwQFZV+A4cTIHYFabBM/tnAJWwRl73DziaCt4aopwEG5SXhA/hXX6xPcEz97KZggLiTBm18E2oCgqo6p9931oRJt4ZRTxTLA6SFrI89mjV7cZNjqJXW4DiUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Avz5e+3EBr62BuVXgj6UPnkpZs3MvAqOK/jqvWr25w=;
 b=SU4c9vNuZKVQ1kzXTtfCA+fi3uSGgTVcCY9dPPMYVmvnc41vpuDfiWUDr3axiv2KuWkxffnnkr6IQ56zlurM1NC02sr6e29FZlLYmsMMDNqpeH4bEebQSv9YtsAaFxHdR/zI2B/qAbXJH2fj64gLYOkDBhheQIazos3wR5exjobq/r63ZxlsWMTJT8qLudTuzeSPcd6HNwgRmup3SEhleBlwYqlD1VZVQRUYdZQ2SPpT/3njYsJdzezindqxb3q/8Q2jODCqNRAun/wQ2au3OGBZJg400oENGAdSquQlKD2y1JVrxx351nsvXciVlqa44mTBnFDOYVvOhWnbyHNzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Avz5e+3EBr62BuVXgj6UPnkpZs3MvAqOK/jqvWr25w=;
 b=EiBOgBfKe/PJdG8uguasjkjWvIxrYp7QHgnbIgkLyAofUB5DC2H3hoxHUnlBKOUWCOCJWxICzMQP8pp808v1TfCpiAtvWjCuIXAr1DYrgQU+kbQHb7TdEhlgZ9227j8dYYR0J1dxjTnTNF9Cw+Z0CKRIW/QPlygVPzEQie3sq2G1eGtRqrSSz82V1Tvj0a7qBQGL1IQXg/gD0hODy/FamFThrAeqksld5c3eFQCGPOGvwSLbluehPhz5Y7kyy3XXbKKcNpxi++rs4GTKjWWHzuf8cV989xzestpEJhbOCMrRSR8RwIa7z62Df5FnM1S57cZ52tPuqPJWs3Zhv5u5UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:28:39 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:28:39 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 18:27:47 +0100
Subject: [PATCH v5 6/6] arm64: dts: rockchip: px30-ringneck-haikou: add
 rs485 support on uart5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v5-6-5d934eda05ca@theobroma-systems.com>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: d10bcd99-afe3-4ea2-52b6-08dc1e943a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mLOZa+bqNQZDXsnsyT5nqNR+6+QLkE2EmvKR2TwAQvPhqQuwUXzgVCGo/D6EPxjmokrTNSDzPow9gYxSOjC7wkco6tnyvfiGH7CwbzOME4C+oTY2isDMoKiUEbvSYaVCgBTMmIhZH556nsblQhWiFb02LeaEy3EztCpJ2h96zCU0yaSm7+C33NhnUNet3Yuv4Ufb+l9rN6kSxXo7v+47z6+i4Bs44MlbnWRUPZsEgR4M3GHQ/gwkyLISz/zYPhrPSsgQ4jwrAwSoTk4NI6AlYaHgYo+BJbsdpnRmBSTyYgJU6BT2EaaqzMT4Nb/aBL8A3LqL9V/nUSwjq9TNpeV8FYqwJgLOs96baj5YhsiFm6VPuGOBXw2Wjif4CXh/Ber55pE3AVoZmz8ecr10cljUKBr0D6peTnxAa5KWXj70UzH3t4G7HzpAoULsG3LqMC8gCdJhpQwegzM3ueSv5JIcT8trw0OYugPJTAQG/8Lg1QTkc2hI6SCr8zFXdUtlB9E47FTKHaczB2dwL/lvpjvCyTsZdO7kt2kZ+f0KTPjpKGm0gZe1GQw+uFDl5hpjKJimre2CR5R+4Ah1XQmxQ/hxIB77tKt0cvzDIvtgMsRhHBQ1dh5CzOFIf1oYeXdaEGLa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(83380400001)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnhUalJSZ3p5NjV3WWF6RFJWaFpsMWJOenByRmtkVXVvNHBFY2FjcWF2ampJ?=
 =?utf-8?B?YWlJcEdHZVBrSy9GdGpwOElpTDJKV0VRbUthbVRtV3dnL0JZLzVjZ1lBeURE?=
 =?utf-8?B?a2lPMnoxZ2ZobHVzcEVidlMwdUc3R2VLZDdSdERHS25vTUZrZjlzcFZGdWpT?=
 =?utf-8?B?b0RMM2lGbFdWUDArbTlrRDRNS2U4dlkydm03TEhVRXdzY3NudGIwOURESGVX?=
 =?utf-8?B?S1hORExMNUNRcThoU3haQUlRL2hwTWhTcGFmWVF1d29xcWQwVkgrelZQN3JU?=
 =?utf-8?B?SzZVRUVobG9MTTdsajAwN2xDSkRCNjJXYlYyOXI5ZXFDSkkzckJOZUNPK1FK?=
 =?utf-8?B?WGhSeC9JdTZkazZtTG4vbTM3ZTlLMTBudUNMNm5RYkRhOTdZektoUXpHZWFw?=
 =?utf-8?B?SmR5QmNibUpmeC9NOUlNdm8zbGlOUWVKeWc1dEZZYVgwa1dqZGl4VGZhSStC?=
 =?utf-8?B?RVJGVTJzRzFDaUtrNHIzNDBWTEc1N1JEeDRaaElDbmdRZFgyKzZZcGJxVmQ2?=
 =?utf-8?B?cm93R1p3ekxIcURSUEZvaWE1VUd5aFExV1dONWRoWjZTOG56MG1ONk55dXkw?=
 =?utf-8?B?QUxTN0huYUFFYm5CcnVzK0I3cVVacFBJTENjRjhzYVRUVERtMHVMMVMvMnEr?=
 =?utf-8?B?ZGlzbVFoNGxNdnN5TGVjQkphems4eWxJRVBoc2oxSzZkSDYzamNCWDNoMzJE?=
 =?utf-8?B?TDM1MTFndHJ3ODRpNlpwWk5rcmcwWjRRa25GcU1zMXR1b2x0M0R0K2NFS21i?=
 =?utf-8?B?MXJkZVFCR2laTXdaMjVISEFsYWNUeWpSTnh2NXF0YTJYNHZSRitRZXphQWJL?=
 =?utf-8?B?MVlsWFB2bkpZc3pxUWkySFJ2UndvRkxGQ0FZSTI3bDFuMXl4WGpOK3RtcjAw?=
 =?utf-8?B?eG1tN2VldHBITVdTYW94YkdaTkFXc0lqR094WUx2ZVRlOGdXdmdFeVpaTjd2?=
 =?utf-8?B?YzN5azZwd2VPaXBITGNwMkRPOTZzZzJHQVNvNkNRMG8vaktreVpHQnozcnFs?=
 =?utf-8?B?akZ2RHluZlA4TnRkY1VwRDJEYUsvdEpHaWhLN1U0d1R4aStzQkdpNFZCRy8r?=
 =?utf-8?B?SG9oTklTdzhXVmtNNFY2UDNzSTZHZ3cwVGF0MkRmZFJZajFyL3pydHQ0aHdm?=
 =?utf-8?B?dlB4RThodDd1bm4vUzUwVjlsL3VycFk0ck1XSzdKRGluSU5ERUEydUF2NGli?=
 =?utf-8?B?QmNuaVRMY0hETXJwM3FhVE1wbXZtUE1iTTZCYUpkclkyZ1JiOVBEVVAxcmox?=
 =?utf-8?B?NHdlR0EvNmFXQjg5WWNocXgwcUo1c2hSMnV2RWVKRWN3Wm9ad3Z6ajBDVXRy?=
 =?utf-8?B?dS8yUU9ZaElPWVFqcDNyeHlFQ01lNUl2eGl2UGo1aFluQVZuckRIeVNVbGdG?=
 =?utf-8?B?OGJaQ0M5SUhuSFRLY0RtL200SWZzQ3RYVEd3TDhuVWx5bEswMURZdDNZVWU0?=
 =?utf-8?B?R3pJdk82bnZBUi9FZHA3dFluUnhsbzgxU0lWOWp4VWk5bWVmTkpySmRqa1lr?=
 =?utf-8?B?dmJjR1BOZWpiNjc0UmVhR2tKQmoxWUpsWmlJQkl0SkEzQnpxbW9MZHBHVmFw?=
 =?utf-8?B?RWpNSTJLeVFuRnF4a2hMTlJDWVFEK2pxSC9UaS9penNQRnM3WFRpVlQ1bzNn?=
 =?utf-8?B?WStUbXMxWG5zTXU4MVFxUmF0ZWRDYTRHaXcxQmZkUk9CK0Q1Zlk1cjB6NGJF?=
 =?utf-8?B?bHhTZWllNWMrcTFDalhaQWVrV0N1TDhvOWg1VmZ6Qi9xbWZ0MHJwR3R0Qy8v?=
 =?utf-8?B?NGtsK2w3THBRZWN2RFQ2QktPRDNaNTZkY0dPMFFIc2pZMWVXNXNNampHZlN1?=
 =?utf-8?B?WWJSV0VHeWk5QnErYVExZklSamJvUy9UNUt5ZFpJbUgreDlwUnFnVXBoUFdP?=
 =?utf-8?B?by9JVy9SUC9wbFJTYks0UFFtTU54bGNzN3pndGVRMlpnM1lPb3h1Q2lzeHR1?=
 =?utf-8?B?UnFXaGRLeDBFVnBkS1E4L2RLUmFnQlRkZC9SVGMxZW9ZN0xvbVBYQlpkVE1O?=
 =?utf-8?B?VVRYVW9odkZxcmNHYmtxNFZrcFZZcTd6K1MwV3EvbTBxaWFaU3d2c0VKU3Vr?=
 =?utf-8?B?M0pZQTZqZ20yUUdvZFJ5MGI2emQxQi9oeVNNMnlIcXdRdGdienFPUEZ2Qm1r?=
 =?utf-8?B?TmEranlWMkwzSkIrcWpsU25DOHlEVkU0MXZFaGpxajNKejkxc1hVTXBVbkgr?=
 =?utf-8?Q?k3HvNP+obD6Sl0fYSttUD30=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10bcd99-afe3-4ea2-52b6-08dc1e943a9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:36.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM0XNXV4kW2jJyzuqY0Wo5PbZbEWS7COw9VbfGS+OSfsRy+zwLdhH7rl9WB7rfYN5yeD7IV/3zbdd4newnrixiExlu87DX/X/3FJs4dv6004xpuA4VN1mDI4rnoioQys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart5 using ioctl, DE/RE are both connected to GPIO0_B5 which is the
RTS signal for uart5. Which means GPIO0_B5 is implemented as rs485
rx-enable gpio.

In full-duplex mode (em485 is disabled), DE is connected to GPIO0_B5 and
RE is grounded (active). This requires rx-enable gpio to be inactive to
enable DE as well.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 16798eb77077..369a6518a487 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -227,6 +227,8 @@ &uart0 {
 
 &uart5 {
 	pinctrl-0 = <&uart5_xfer>;
+	rs485-rx-enable-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
+	rs485-rx-enable-inactive-when-rs485-disabled;
 	status = "okay";
 };
 

-- 
2.34.1


