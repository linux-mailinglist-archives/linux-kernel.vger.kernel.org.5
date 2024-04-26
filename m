Return-Path: <linux-kernel+bounces-160460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6335C8B3DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8841A1C229E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40016133F;
	Fri, 26 Apr 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Ds/oHJZt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB815CD59;
	Fri, 26 Apr 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152134; cv=fail; b=NYAnW1g8nyhpGxpLDDm5z3gZl2pTXALguj4SEZgWVTRoEYHD9WL8cWDwh90vF07199si7Np97U6OLUwAnRXAPx2I781G52EhdG4ctDiDfWc/JQ+7n2if14ifZDJ7xspK/1fBaMr008U2G/doUkXM6EsjGE+2m8QJr8wjzHsKOVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152134; c=relaxed/simple;
	bh=YUPZTOnQV3UhXfDHWcDzIFk1hzxeHmfD7FrLSC23170=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBQdaet3i7jwjgaJzQalpp1hpkpXYXvuX4JHqvM7X/CC4fBh/V4EzCYvygIvv2QHJtf9uhAHFOFl3MmjPBa2YwFysfb4Q+HC75kOBHCIHrzVnn47N+DYmtwuu+cJTfhbVKYr9p2VC8KAtszQp4Zyb08IdWQS+ZbVjShIrJEpbGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Ds/oHJZt; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ8iRL/VAcAuPrDrJ3FIz031PrpU6xrmU8UMv7ySW5eYKLXIa08GVh7vIiRo2hBeQQu2ZvKFCHs5fAAXrx8Yl7IteyFX4jCaE/RC9MP6hlxYxcZHlQy3nuaSmpoArg8bpK9UyWIoWEW9p2HhmWx3WaRUWxt4V61e1/ygjwDfRSQsRhYqEJwLexhYKIjhee2CXdkwpRT+BvNXZW1pCOyIQQzpz6FeiXVIfZR27ixOBwAM0kMu8xkgW3cuj1NR7Tmny3e4++GiRkHvKdIjLkNtRAOF8YeaCnunNTyfxq/NFuKVQ+GvQPvZioXKOBby8iTFox/N9MPdp4abs+7j5GhUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suSZXZAzww3weC55/oUa/oPgclzjWr1ewCrdev7fjNM=;
 b=QB4mdNgRUR0FWrIR9AWn4tIDQMmj7hOTBt3MpM531CDTZrkusBdQoMRVnAuv/1AmrLBLgFOlWheYXrbQspXQ5k1cdh7gMzcWbF1FsCYlKQGNVx+0iup54TXIQ7lWuit3yc5i6UVs9BE/xgBKLMI8rCugcK9xjo79iA/Q0w6yZk2tnoygQ+hTgJBMoNIJ4Kzj6EvIStvhKPVoLpKFoO7clWUunwids0efPTIsk7LAWBgBLscix+bs9xpTBc7u9E16u1IKwETmXQYUNWg/y3BXD/bfBoZT8lZctutQyo4AnPbLHXtdO+YzzGQDyZIRCjyY3hLsBKE1RZt8VlnmS72EbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suSZXZAzww3weC55/oUa/oPgclzjWr1ewCrdev7fjNM=;
 b=Ds/oHJZtyr2TddyFgLwsJakdYbaMITQbZn/exuvXrGB1IiLdCX/Ih2sQsPKyCbzzvHKNztsmU8vUX++6CkDHyZzV9VXiy3tcy8QQom+9M+KguNj0Ieht8tzRpqlr2RAKRJRZR8R9CqNEvE06mVABcM8s3+1aawQejO0jjw33cg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SN7PR22MB3786.namprd22.prod.outlook.com (2603:10b6:806:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 17:22:09 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 17:22:09 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	j-keerthy@ti.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 2/2] arm64: dts: ti: phycore-am64: Add PMIC
Date: Fri, 26 Apr 2024 10:21:55 -0700
Message-Id: <20240426172155.10860-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426172155.10860-1-nmorrisson@phytec.com>
References: <20240426172155.10860-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SN7PR22MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbcb59b-43f3-4e19-1161-08dc66156643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLp5vZqjQQtxEoSNFwVIaxBq6LrqxfoT/4vs33+PYmUCiMgdYcCYXPrxFXYO?=
 =?us-ascii?Q?9ttmyQ1y0LH1JsKXRY7V193IiUyp6oOvF4p7oQda5Ky5H4x8q595Yrwfy3fz?=
 =?us-ascii?Q?ZhkRRJkDnvjIksPzMkPBB1bnFBdGCANK33KYOex0tYEUzWYsh5sQsSu4P4GI?=
 =?us-ascii?Q?cH4yKjlCg19DNavxuRmpF+MxfW7F5zfNgRpBdyvt8C80Feq/Vv8AvkuoeGmG?=
 =?us-ascii?Q?y2Saf5+t26cPM88JlDc+v8gM1rs37cq8BYBaaZDwVooCNJelPo8nekaNMNOP?=
 =?us-ascii?Q?4Atv/EA/AV3tJujq2UHvkfYYzCh22hDAMty+012Y47b0Fp6EDbEeUUkKFez1?=
 =?us-ascii?Q?SNyZto9zMTe7i2A1zG5szG1DnBvlyobiOzKIjWLBkLfZePM2SusINuphDyIl?=
 =?us-ascii?Q?JfmDasVV+BwjcgPfEaqkf28IXcHb70aSHCDkE2p6ESlnbgUKRY0la2TL8tvV?=
 =?us-ascii?Q?gHNiuQd8KkIITOEMckKE4HqNThHfMUJ18vKN3TD7fJJNMrwySz5A86wrwKo0?=
 =?us-ascii?Q?W/aDk8YbcdyHjPSru1yQFGcmAiN/EsfTpX5Z9W+Shfp26CJyFTUAcmQiDWlB?=
 =?us-ascii?Q?cElC7Udd368f0xDXhoFOrYziqXE7b7L/DpA31zne775Lk+6Heq5OONOzm7Sy?=
 =?us-ascii?Q?hbR7ZXYgQwepszDlt0PVgV6h02Y7bGY1GawaqKF6G9xAJSP4fiVJJB7EyNiZ?=
 =?us-ascii?Q?2WQO/FE7ZrRdlDeWBEZNMrl7IAosHCF1HBf1K3zm8dpkEN0/hOXot4Tg3BNY?=
 =?us-ascii?Q?8POqRPbff/zCfCI4QKRJDinVrAcy6O+W3EI3rbjVSm8jwSSrFwg1r0xWO7Vh?=
 =?us-ascii?Q?Af05urn/1QFgdJjeXkvnB1IwaKgbuqrpJ4tee7TmeXeDilaxoICQZ1kcIZgl?=
 =?us-ascii?Q?tAmqre89BGy/yLD3+UqHzNL3IsXK0fV/JAhT10WClAyCdb52ui76hRq46QCs?=
 =?us-ascii?Q?PM6OzWoL+JchNR4/hXS2n//68Iwddrf+UCaD8rvuZAVl0mOtrgiF3jjFjrwp?=
 =?us-ascii?Q?z1mBxSJ28A0I3Fnyf9qPWf+4pHu7p4F6gwGdb/pJZauixAnVjbqMKWBZylj6?=
 =?us-ascii?Q?Urk2KnrROKhAYoXR9/wv7Wu/ZgggkB1zUk3wOcMsUJ5R82EYvD5Qc6/gTQkF?=
 =?us-ascii?Q?ISueIiXSl6Fygw9AzwX8ERme4WBt+VNL2g8eyPtIphK0Q6NqzYFGZgQvhm20?=
 =?us-ascii?Q?0bLHgIa9mDJ6RUn6+Tvh4db7haUOdpydsVk0slHchyN5i9JIKNwpKK9lN0oi?=
 =?us-ascii?Q?AOD0UOkuKv2/1Z0h8YkAbd5kZhnBBeXpETY31CfCpy5AyhKgl+IszTfGKliH?=
 =?us-ascii?Q?T9/WBidaoaIZvYxjUvBVmIFGZFC8DcmduJm1hXS8TxhJBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kavRPTQIfuEZXOzQzRSNgA25u8W+dIcBzEet1Wp9BQOkdAuNRE6ezpJFVlOs?=
 =?us-ascii?Q?Nf/nFA5DpxCukXVOlyfrBKHWt1pvn5MSkzOh98hnGyOa/IV483sLcSEAJVwM?=
 =?us-ascii?Q?Tpwe+V7X9h6OPTuPuj3HPiOhuLHVCezPzRcOnD6/eSIk2RRoFqrcsggGRQZG?=
 =?us-ascii?Q?T9nNDHNtE3Kutgf3sC787JxLgwGDkuZe9grVZe0cMJiyn5Cg+Sl4kEcMIKDn?=
 =?us-ascii?Q?S7WNZN8VyYHiRF2NrYwZeNT3Q+VJmTzUGd25AkyTnWMjUzJaPnn/BNmg1Fo4?=
 =?us-ascii?Q?UbWclAsrtDZWWQyEmTrvGKq1z5a0DiNW0Ap0Vb649ji9x3Ci0nmUxhyPSAmZ?=
 =?us-ascii?Q?AkcVMYPCTg+Yimjj5N5niyNcgNNnoq9FyfljvtYpsOLHOcOVz0JndBOdgCKI?=
 =?us-ascii?Q?W+Oie9RJTKmdjmGuUSqnvlhgPvaCZXujqE6jR6PMgrTtVBpFbOmJvbr3iSzJ?=
 =?us-ascii?Q?KZnnVdgTPQSDkB4WaCMusYVl1WuE1lttGH1vALXjPLowwcvPED+gyWQ+SLLe?=
 =?us-ascii?Q?hNfuz0ymBXzi/b4h0UTTEsmwA5wftkmqgCPKFhCLimvSak/XuRFQiqKtwe84?=
 =?us-ascii?Q?c3rJRBaWJqt+w0DfioyUHXSUEvmSp9M7DHZ2PT3rLbMAQuVXPK1sY4KrYJ+1?=
 =?us-ascii?Q?O0sBjMVriaWIc9lDUN/8DFlUGNyvQ4nRJpw6UF46OEDE/ZhSGPWSiI8E/lqY?=
 =?us-ascii?Q?scs5CnkJCRYH19QOtzGTYrCqMemW55X3pzHHILC+GRbxUgi1FfI1eK2fJOBo?=
 =?us-ascii?Q?zLylK/b1pAd/kwHg2JP5AxjjWsXMymXBRii2kR373B5AmD8UE4rJTXZ7Gk+1?=
 =?us-ascii?Q?+MfJA1QX//I+dKu/Zl4C7z2F0fUftcNO85VeYwpd+Q24m/M+PMOr1c5c4vfA?=
 =?us-ascii?Q?U3KzVeBLZgPf0HUQaLRYBk0AWYvXaOQZ+IZUPq3Un4txyYBAMwQsECrcvsre?=
 =?us-ascii?Q?L7ikuZgmPuJGG7AaNjOHZOBKnDlHy3RvPFMlx5Mfm6Vf42RE6UnhXuhaThgS?=
 =?us-ascii?Q?qldltPHe2O1PzTW/FZ9SMkdO34MaaPfPW9Ngqg/kI9HHAQyKpzEqfRwWI3Ij?=
 =?us-ascii?Q?0EMV0p1W5H6rE1VyhdAjvCdDU80Lx0yobl0Kqs8hISepdtqGCqwrffa5ibLP?=
 =?us-ascii?Q?Sh0tnMlP/zWhDmX3sv/XRWa3yvFPZcWUzwYrQRXfmh1PUX7JBaZV84VxqsOs?=
 =?us-ascii?Q?mOEkRtvwIjASWp0SC6Qs1ZjfdXCYr2l5cWcVK8q71k9n+KLzwplQ5WlvQ0cK?=
 =?us-ascii?Q?p8PS5LTbBDHZ9L30QgE03F54TxCKcq2UBzCbLqNj+GirM8DrAJP1mjHs0q2F?=
 =?us-ascii?Q?miA8WRZiZns8tT/fcWPC3AAOaYFnM9JCJmn6SBcC1dUErtiT0/b68A/9xSuH?=
 =?us-ascii?Q?HzEVIpTkvLGJYWR+mwZTYLjsyQu6Xy2nv6tSsr6uM0fYRYZETY5lrVkg5Ie0?=
 =?us-ascii?Q?X0yenDeTtoNz10AiIQbflMk/+jS7f9UcY5Sgpy5KdbDB23qbcI+ze2KKmhLr?=
 =?us-ascii?Q?YNKg2wELsZAs7hsPnEAg7KHKxSFtozQ8MP4mz1JzT9zmmxtZ1bnysOIn9xjO?=
 =?us-ascii?Q?7voOKcxxPB2zlysey9Pvx9X5AYrinhLIZO9yS7AS?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbcb59b-43f3-4e19-1161-08dc66156643
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:22:07.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+MnLkAvN19s4vziZCqbMRFhWsohdf/ydo4/9nS/jpKD1GsU0MRokUjVouynFgIZJxp0N8MlTCZOea5ZmnJvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB3786

Add a PMIC node to the phycore-am64 device tree.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 125e507966fb..2c3b20ddfb8b 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -265,6 +265,50 @@ i2c_som_rtc: rtc@52 {
 		interrupts = <70 IRQ_TYPE_EDGE_FALLING>;
 		wakeup-source;
 	};
+
+	pmic@61 {
+		compatible = "ti,lp8733";
+		reg = <0x61>;
+
+		buck0-in-supply = <&vcc_5v0_som>;
+		buck1-in-supply = <&vcc_5v0_som>;
+		ldo0-in-supply = <&vdd_3v3>;
+		ldo1-in-supply = <&vdd_3v3>;
+
+		regulators {
+			vdd_core: buck0 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_3v3: buck1 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_1v8_ldo0: ldo0 {
+				regulator-name = "VDD_1V8_LDO0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdda_1v8: ldo1 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
 };
 
 &main_r5fss0_core0 {
-- 
2.25.1


