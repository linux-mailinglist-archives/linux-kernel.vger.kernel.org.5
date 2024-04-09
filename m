Return-Path: <linux-kernel+bounces-136337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3889D2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1491C21FF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99979955;
	Tue,  9 Apr 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gifZftzj"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2115.outbound.protection.outlook.com [40.107.14.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2E1E498;
	Tue,  9 Apr 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646519; cv=fail; b=RT3JTn9U3h/0EhfLtW2s+t6oH1mdd5lbv/Kt6x2Jktkkh/I1z0onGQB2PKyKfur2eKtCfZwX4rIr4k/Jw6t1zVgi8j6k9p4inU1mQel0L0DpOEm7RWUJTP3KGAwQFbdjya8LS7JLR+VHDjN1QMhhJ/jJSKOKxeCuysr8zfUk9tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646519; c=relaxed/simple;
	bh=MWn+TGngE40D4QDDftNgFC7GGBrZm0mmxKbMjnBI8cM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SEE+s2vS8y0BfDE0YTzp7m+SZntrirLSSKm5Q0ArokJUzi3N56STYj84FICxCxaBAZ6Arw3y6vmPerTn8mgb7HdD35kjfRcz3AH9CTq4YKC++/qMvQ++BJRj6GD2drgck+1D79BR8IHVKyYR5HkAIRP7kHGxE8hh68nK0hFOWJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gifZftzj; arc=fail smtp.client-ip=40.107.14.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIius0vwrbtJq3KNPx6pANSdaXUsKGb7z/JSjB+f3NyMobtvCI6FOlFm+rjNOCUQ+p/xRnxC9a+2TCSEw3jbuFYIJWU3a0+MKDPJUKIMsFlRXtT2en80nHDH0K8e7Gx/l0j0coU6Hp+9i07p5MfkUMuJRLAjOGfZp/KIhYXHaXsVhTF5KkjYmVfeaP7RwqWaPNHGUuJGfex0NnkPZ288W5UKl9zJExwyHu/qmNEP5r3CjkYnS6pj0z9hyB9vrSIDqEzAjp7+WiFv1Cqx9WTz3bBeDJV9/l0jJMMiWBtVufv30eUaw6KfGr6W7glGwZKzb8ZOouraDzrF2SpKP1z1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLUGT+Z/E9VWaLbuM8AejZpn7Enmf7YsTnp5+dYKjw=;
 b=f7UIEUu6Nk8nvU4/UVi4JXx3p9eCTTMob0jjdoS8cgongUNf7FpJyUJXdXyOhsQ1BtCUNV/pIfpe7E7n0SNgCdnkpnMAecJok1D+2wAnIus6SemkP7ZB/AIzKZhZ/KFD0nCahWexDkP3d+ENVKRWaYtbmor/Eb8yQmogyfGeD+aVER+o4QZmqxomGgvoIzbVTKSfY+ECpTcHgXgdzqRV3KdWaxaM+oWM1gIFK2NZqrFxeZy4+EQBRIOSnfs/e27IJU9HbGSxnYx3erQ9F0LBNhTP/2pZj0Av/u9wRMtAnKyz9IqEkHxp+wxW10Ma3DAaBr2LpUYswo8BB0PHHdwAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppLUGT+Z/E9VWaLbuM8AejZpn7Enmf7YsTnp5+dYKjw=;
 b=gifZftzjgqfKArO+R3/02S89bRI/jqVnYBujvChBWMazn/nSItxRKjS7itIcI7JmosSorhu7ju1+ehpT+aec2k6eOSHlGw85kSeDHELk1PDqe7JIlPcPxZZUvRAyRAxPfIgV3fWIm+aCEZx/RjJ2YXr6kVTtul4++1QCniNinZU=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 07:08:34 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 07:08:34 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peng.fan@nxp.com,
	ping.bai@nxp.com,
	haibo.chen@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>,
	Varun Sethi <v.sethi@nxp.com>
Subject: [PATCH v3] arm64: dts: imx8ulp: add caam jr
Date: Tue,  9 Apr 2024 12:36:16 +0530
Message-Id: <20240409070616.3868152-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB7814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h64eUIbPi2kn/ODO1LAbSfXJHhldl5tov8tlHXf7YddM9CjAGV3RGDch2ZNMl5EtwGhwF1nW6VANZlZQ9w6+IepDeDJVYSWNe3YszVhS81MHzdvkQ1iBLogSUb5/9dZZIf8agIDMIUg/RcVe7NCbq1GPgEHoqZoITSM/JIP0y9FkL2GTGFOgc6LXPP5C9jeaqaraJv8mSKbHWVfIueUyi/uS/UnXoQu48Gzd1LzVdqosJCF5oUQxdon65pQlAusyvcZovDxIQL/rSrm0y6vHNzyaNWVEC/DRMhxKYJFg4vbaRRxA8fMQp7uXuPIr4MMYH1slvxt4tKN4Bh6ho4P+j+N5q+9cEw5r0tAgyNGhf/aQlR5GNuesT4lpdgnv1Zi/ph/Ha0con5GDU+bph+Uxptl5xiHB1q6nenxrFMU04hw41rhJYcdAl8glUfLzAEkto6pVqPapQO9Dp9dW0oT1gb3z0H3wz8SEFzqzrdfccdeAhzKDq5WpypcpcnQnxxZkjgi+Y3oFEDwhe60UwG/6c/Zmr+fT19TQwLUH8LVFkzUHmkntGjJgsyCitSkY2tpcf0KazzZy3+yNIl4WV8RJnyOEDPXyAQdPXaDG5iygSzJR3p/ysKmgACiuvbttc7vrDcDDxqobsNu52RRV2R0XV79oNmhSbZVrKVl5M3CqHwxGHghur4wvg9b/QCA79TX9GADCgDEtJXvsWkBtllQfYd4tc3VcsZmTD6HHBOPEoA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H60sx7Gxg/UDHf+dJFmnDuL8TsO/KDzDmmw+2DtwJnuRDAoUjkf1eQB2wJ5i?=
 =?us-ascii?Q?ArgvUcNcHLTwCMYmdgNiXy/i9sWB1TNIPIez0u/KvLli0DcqFeccs2vvIapT?=
 =?us-ascii?Q?Iriu4XckunpGAU0dMirMoRDcAPQSZLnmJW+6pWu8cVJZTKwPDveRKcNgy1mJ?=
 =?us-ascii?Q?peWnQbrsCJnnCjyNgfCWDHLbD5AqGHn67vf4iNZUsJmkI6ptPNiRAIbgpvR7?=
 =?us-ascii?Q?KathyKPwQhntUSGDkhmY+s9dH+xM1tHRfd8GcVJngWEtmtIbwkDS1wfhY9PG?=
 =?us-ascii?Q?zUuvcOyRMHvgzo5ktP/tMo1s+r0eap6I9+ouGrGuhdM5wk80ZLt2ldN4jcq1?=
 =?us-ascii?Q?2JU5MugVGCWNpjDHe2LL0wQvgBHXFq+BOMmmS+Qqrs/nBfstbLskqNa3vlCf?=
 =?us-ascii?Q?k1v/J6zrPoeSs7Ss/pnvf4BbL9DMkK7QoDn+p3v+JPCHYyOsOFrktPwABLvK?=
 =?us-ascii?Q?obcAEtN1smfxP3+dGh1NT4lcf0zeXJDg+uilR3m4tPLqTVEL1V8zlezYphsc?=
 =?us-ascii?Q?BBqBDyWvxAVDwOMEpOSsYek6UJ+YkvALUbPfpgXsi3tlRRE4bckDqFuKtJfG?=
 =?us-ascii?Q?ZuhBGkrOkDNrtouG8etZYDsiHM2kmBaoeJ/sKobSRcYhUlI3aCxTmuNDFAYa?=
 =?us-ascii?Q?0mxQRe6Se9y6a/xIpV9lzWNUPt74x1CfRceTrlNy8cj5qZUXKHY2fIc/icOg?=
 =?us-ascii?Q?LpOzfNDMAg55rwvnYMtgZwxSjNE8YJcky2BQpn+0BPGzG7EniQvaIkL5041g?=
 =?us-ascii?Q?8qgt+9rtSOe+WlGANJSMraMGFbo/YWxgYjRKszCDjbFAVZ84dgtTg7bDWuvV?=
 =?us-ascii?Q?Eskz3QlkArU0f9p+/UJrkX3xIqbDkLwurrRh3vhLWR/y3EZAX3b3ygfnJe1R?=
 =?us-ascii?Q?8uaWjD8wK8i8jXrS/1jcsthWEZBgLa9r+VdU7ZmY7XvvF1+KpuOOv3OLikEp?=
 =?us-ascii?Q?A+fGAxuekiq+aieHjE/Js+LP6KrQhaz0Ggb7woEfQIzbbtEJAxCx1vtNSKT0?=
 =?us-ascii?Q?BkZWgE/8uHeH+PEXP5qTF4kTHDgzIqJj3WVXaKovrCOxs26zzglKbIDCf/nN?=
 =?us-ascii?Q?WtC6RkrUEyBf3FK/BuqPlLZh8agxy+TB4cLX3Bil+TCp7YOUVJDUXqPZWKll?=
 =?us-ascii?Q?tPtj34tGns8FzEUlLQ1xOAuDaWMgoypOIUZxk4+bQGbh6H0y4xMuJ99vbD1o?=
 =?us-ascii?Q?Q70nm5W4fJN7UV6RItO0lLuEaR2/SYq9/iN1rj9XyUKTlZ8ztHO0IUwH3rfJ?=
 =?us-ascii?Q?G04ncodY8dXXgoYxa5AdeUbQI1Rq8yURFXIKQTFMyyt/49kFSIPhxqFsVQSm?=
 =?us-ascii?Q?I6nBFkfAsNWH2/rCiZg82R9V7oSf4VuLDqdEwXqzeP1GSmCQKU8rimJXFaGt?=
 =?us-ascii?Q?51CTuiDlfUeKEPOcVXw+EicQ6mhxXmUbxaNwVzd4pxPsQAq0gg5Mn7mdTqjp?=
 =?us-ascii?Q?E278iJ4KPeNbLNqas9iPYUuR2RSeKf10aszXvnM6nSuaKcGQam6Ya0dIcmJW?=
 =?us-ascii?Q?C8yiBMlM9LXzhtMb65SEKm3RP2YhjsSgw1lV6cI152jCSVRdLykm+YyW8crM?=
 =?us-ascii?Q?MvSQh8roqRVMPTV5jiE4GZR/sVndASxpjDKpIaQT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d449e6-7f56-415d-325d-08dc5863de6b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 07:08:34.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjWMzDxrrTBYUUr/G+oj4mYmlVn1FImEOcCZb2tTyUvnqkeZ7+7yIArQs+EEkMEcZ6A0z4dSxRYa2JNCWfuA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814

Add crypto node in device tree for:
- CAAM job-ring

Signed-off-by: Varun Sethi <v.sethi@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8a6596d5a581..946f2b68d16f 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -252,6 +252,38 @@ pcc3: clock-controller@292d0000 {
 				#reset-cells = <1>;
 			};
 
+			crypto: crypto@292e0000 {
+				compatible = "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x292e0000 0x10000>;
+				ranges = <0 0x292e0000 0x10000>;
+
+				sec_jr0: jr@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr@3000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x3000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr3: jr@4000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x4000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			tpm5: tpm@29340000 {
 				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
 				reg = <0x29340000 0x1000>;
-- 
2.34.1


