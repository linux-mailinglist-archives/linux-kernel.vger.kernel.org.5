Return-Path: <linux-kernel+bounces-98544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8B877BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BFC1F210EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDC715E9C;
	Mon, 11 Mar 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RiU98U12"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611614293;
	Mon, 11 Mar 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146411; cv=fail; b=S7KOzxlgRcgIBa5Lk/RPGSdlXZ9+JtDVOfEujgGLa2ZR7yey3DEwHu7ue2bzWmoDXbCAZDXXW7ynVMYR/ahOKnexuxzNzwd/g/fFHD+TvicLZWz11dLhYp+/TEKM1pq+9PIRkvEKkL4WLN9TtHaOpFA5Ceq1rOEdQ1iKwno01wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146411; c=relaxed/simple;
	bh=u3orziolZ6LUY9cwo/+1TmMnxSIpDEfCDdn39AJ8NB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VX+oGhKiQAfXtlF5rAWyNaKwAFp2YUo49Ia85XC5EViK606Tbj1BflDM9Gg5EJQrVOefZWWq9k5ta2sOAg2ZstqtxEkcP0J/Rg5n/H2qiJTXHcfRJUFmOayq2kfpJ72+x0NeBjE65IbrDeHtj8k4t/bVG9DKBhNq5plNT23cbV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RiU98U12; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irqYOsN34hTvNlIoX1j+hJm0UydPF2hk1ZWC7gZfGzvqz2Tb39qhRpaIm4f3g2vaqT2Y6pB/mmE82G3A9zHc4f+Oo+NHdia4y01mpnVZOhcua07G8Sy5DNNiUp39JyEmrBIdOcwFucQTXAr9tuR7XSSvJlhQtk7jPRbYZDkPZURSuH1KRHN0HTnbN0OpDJmFWFc2x0sFZ8QvPzfpBIekV5fNSWGt/EUbxZUAgCt/BIJHoAbvJDawCT44Dutqkkz8gl/ePAVQRAB6Etu47y0Rk32C22ak93BwmFegdJXjmFD1az+BhtBX68Ygr8lWQOPYEZYV0Tthn5v/LDK0xgRLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2/+JmhFRdOeTaCCQm+5ArR6oM2DdW3XV+LPqaAwh6s=;
 b=NW1NcSvUG6rHpViB1g7heCWYIkD1JVnjFa4bSPkvjoRTbji/f/EZ9oUjVjHlhnNm7NTBJ27gvG14bg8twUbUf4q+7A3GCyUW/XqJRrpJS077FAxdEg0u3Zyoy6CUZkA08IQlh4iXo3HASkCjH5E27FOcCg9D5hch1sqSVk70+XO1SpmcC7GhjmuoiBRDXTSk4tAskX5/hN9eAM/tgwsENeGVMsVJaMX1F/8PMSxDi+HIDEe/909Mt2X8rkEoefZNQhtXNgU+ljPQFWQoM/OeOE2flcq7VhuQq99vKCiGq1PvSA/CFMoZAz/Xe3Yd+eq6tullq0dX0wbqjpeSghAuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2/+JmhFRdOeTaCCQm+5ArR6oM2DdW3XV+LPqaAwh6s=;
 b=RiU98U12zyZnF+Cgzsr+YQfxBvLp/Nz23U0DPgR/Hruz/VQFidbeg1hgcrZLtTVhZLiyZ2UzI3NReTrIFDPbb68CvtuU11gWDW+smEp+3OYKOYCaLnIhkNp1z3BWoaz8WPUw1f/3yPPsh+vJbbVzXL98444f/tsU7bbZSjh54Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 08:40:06 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 08:40:06 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 1/3] regulator: dt-bindings: pca9450: add pca9451a support
Date: Mon, 11 Mar 2024 16:47:55 +0800
Message-Id: <20240311084758.377889-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311084758.377889-1-joy.zou@nxp.com>
References: <20240311084758.377889-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dd9613-e6f1-4745-6c7f-08dc41a6da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B93PhsYoBy2hyLEfY1D9a+KWiXZCEGwgxU5NFgKAHrQBt2ze6kyocXANbiGKQ07QH+/ERPyhwNJc8pedZnPiPmlr+qYlElu1Y89W6cv+Bj2jTzQ1dfuzW6HuxTPRttrJMKRls1mcBY+C8sBHtLM00pirEPkUh+4j7yEapTaOCpJYDF3dKeeY/RpBtP8DMemZB0dXUYVbD2WgH1xfMo0ezhyeWC3CyVZ4tbyEV30wzRtytzZc58vaFK9sPJpeQE6SsWJKVgiFdVRv9/XshFEuZLDpUTQ3S5S7hMaic+OCiDRg6p6L4s7+h8JLCrk3lDcq7CpkaWdb97O4f3VDelDF5LBbidBLq2zAP0HzFlRxyCFXdQVvJ+sehITNpNXoDo/Uvmf4Oj+O8r7QyuJOOdw/r5CRUGqJjquWNyckCtKsu7UCA/+xm6Q3UHvwvdtD8CaUM7RJZFzR+pJQdvwVRVlccJU/ZnRTngh1Av1amUlQukRZlR/JeLK04B+zCrnsDTJtDwmfZGkzx9q/T7iaqxueGloS3Y6ylCSIvXH9omRBSo3MWViYkzrtHUCn/DjaAJdkV0ZtrkwWXGYUR8jwdMIfF84IK7Rx4BLJNsLs6J4pLMTuXPuand3hHsIT0JnAEnpFtj9cAZ1wI4tlSvBNqFrxx9rXO/1o7XxscriN0Z9t7tQyHRRRuihjfZmPrkUk/6I0LNLT2w/CeYH4BkXn7RfIBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x3i6XrE+BnSZ1h+pJgmTl5ymMuvIEPJRx1w96d7cTTCXT/TNvWGG4lPT8JKn?=
 =?us-ascii?Q?81N9/IqLH6Yphw9AvOKoNzBzh4tBQ9LQuZh7luuBIfiHkP0QZ1LaRO1tGRb9?=
 =?us-ascii?Q?QSXi6Hhb4q9AfXwBC7rJuzejLNvYyGVWhAiJ4TU8fdC1MITDEN/6lUm8pJPE?=
 =?us-ascii?Q?Ldq/kJ8CVjwpgPhnpr5fwUbtUIYF9g1wQz77dyLaArVY3mk4NPADEVM1Sqnc?=
 =?us-ascii?Q?hs4pcV/XIpsPZ/um1CNbjkKVN+YK8qr5FcfpgFUHSek0Bjb57MNzFvpbQItp?=
 =?us-ascii?Q?zRe3yfcPWA3zwjjGbI1eMpoRSSsab1K8DSYD6RQqWoYyaINrqAofCBkrjV96?=
 =?us-ascii?Q?vp7KUkfl6HoGrkReHrhjhxpM6qtHZntiKsgVLGXDcBc9d+mMCJKfnUpOBnC7?=
 =?us-ascii?Q?mrrvM0K3SdgNp5+Ff4dEpWKM9MfmMlhvSsiGQ2P3lTxLAp7AGje5YQyo9D9C?=
 =?us-ascii?Q?S0IGDTOTvUs0RD+16IhIYb6R7KzPWvT1umDSrP8qT2s2AFQEI8xvGgkxtrzp?=
 =?us-ascii?Q?ePE1mnHNdq5KrwGeaEh0lfdiZ+hOb80UdgPVs9VGAeJQw0RLvFyXfzvCxDIC?=
 =?us-ascii?Q?BW4alRIyGtkcwmREeqGSj6MRKVbNmSsA/3Z2CYzjkS16SN2JO2rcPEWcMmoN?=
 =?us-ascii?Q?c5GxiFjOYZUCRtu0xOKiqNimXy+iL3i5Wu0UCoeJuYmCZ8Cld48ITvVnOdnR?=
 =?us-ascii?Q?BDOXeHymC6YUYXXmdOGlz542ywT86uqlYWDF5zoaVVbLXoMSsm3vYmkEPUPe?=
 =?us-ascii?Q?4op1H1y6QL5jE239lndK6EP+ITLQjbYHxupa09ZtWn8MdLUew45E7VB+uNZt?=
 =?us-ascii?Q?fIqtLXbsll+NY8IsjPfO7rBR1Y88kJnHSXVNow1Bnrq1BgcD5J1AqX0iJUVU?=
 =?us-ascii?Q?zRulDfgm7XdjCnC3xFgqsU0UBDaw0Tjr0U5DGOuDayb4BuupW34fHKmo1Prk?=
 =?us-ascii?Q?sFWRDg5lSvJI0c15xvQ0ztOdvpQKDaN+4q+ydjwUw/nY7AIxFHWirVpvT0X2?=
 =?us-ascii?Q?PR1LXPiZHx186FjE+jEjaLR804AWEKANk/udOvkYMlJQ1AfaMH52tB/8Qzy/?=
 =?us-ascii?Q?Q00OmoNvJnXuXC9ePnhNDe2TDNSTUvJdWU5f77qMW6XOwBZJTSkNzs9yWvmg?=
 =?us-ascii?Q?tcK66TK5rPGW0EzR4cFjC1Q9uxP6txXJadhAsem2By8tVgwI9Zh6CpjSi2A1?=
 =?us-ascii?Q?h2tVuxjO2Y9lKTnfAfhMn7v09EAl2JwESPI7lB6KBYfg3ZwjIVGQsnW+Gpth?=
 =?us-ascii?Q?pa0u5p8XfATI7ZXLVCBO/UN+EXKIHBW3yGxn+HUfKxhzjL3F9C80yMBBtweM?=
 =?us-ascii?Q?S/Iwgchar2QSxKMS9bYNi2hZzll40RPROu+yprH2ayQEmGSwDH8cLy/P/Ks/?=
 =?us-ascii?Q?cZIiU6PlII88wmp5Mp4HoACUomCJx2t8bMii+XECf/VJ4vLDCQIQEosw4X+6?=
 =?us-ascii?Q?Ucl/hxWxvc+XJB9LRB2stpD1AFWTzSrRcATel0PQxfTVSHp4pRpeb/z1MHqR?=
 =?us-ascii?Q?dnqM+ncMiI5DvO88S8QoD6kkDWyfEtXkLyplQJwaDIuVhhp8F7vxA2pewgxj?=
 =?us-ascii?Q?ltR/6+gvbuzB+wE66bSAa8FkKjS6PO54Aq2jOdLQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd9613-e6f1-4745-6c7f-08dc41a6da57
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:40:06.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8cvLB7JT/edctWqmR8IWA87Wj6zEhs4w6YkuAD/IKyiWlafprXH1DEu8mxm/+rZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602

Update pca9450 bindings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
changes in v2:
1. adjust the subject prefix sequence.
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e9774..849bfa50bdba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -28,6 +28,7 @@ properties:
       - nxp,pca9450a
       - nxp,pca9450b
       - nxp,pca9450c
+      - nxp,pca9451a
 
   reg:
     maxItems: 1
-- 
2.37.1


