Return-Path: <linux-kernel+bounces-129383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B68969E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57281F27002
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03FD6FE36;
	Wed,  3 Apr 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nb9yAlSu"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2109.outbound.protection.outlook.com [40.107.8.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABB6EB69;
	Wed,  3 Apr 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135058; cv=fail; b=uR6InT0p+CREUmem2VyrCofDNSRXMeI3YYEbEvi0E+W3xWHGaMmXHpU2AxjiNZbSUdWuDctl+sedpfcKbXp81PpkbPEwvxTMQjBi0ET463aBFOQi5zV0K1xBtxWBwYOvd+icv5KByGvtpZ8+pgyzvCGb89CV2z3lOfvMRdgXSeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135058; c=relaxed/simple;
	bh=kSWU2B2k9TLmEhQ2EdXgxYLL7Y3Rab+325P4T/G7Tyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PIKAXLbwhvRBcsMwiGaDWCx6raRWndBrvxYuGTLFRs55Vx9t3zGzdneFM6JGVOa2jymeSGv0L7fHf1jg1dkOybwUNJSgCTsKv8SGw7vVXuSkRYE/KjhiHffhEQhxzgeus848zdzkgAjZJddt/cOzDYT6omKRBGyWXDuxHUmOrWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nb9yAlSu; arc=fail smtp.client-ip=40.107.8.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGEopfzNh/WnQrOVCc/CfWRKUhmRl2LUpN+wo6YAE08oLRrLQKmGnXEuQKKI3n3kfLo0s2AXfpl7pvSbXzhd8+qUHLehzGAQUiZZayELj2683sQD971YBzV16vjWZKjU2StkrJuqG7NESe/YJeoW4V1pXfF0kf+Eevkumaz/EgvfyE7NIk8Hx9eDL+N9N0L2iko2oDs6PtJCoB+AJLJdGDEmR7rmrOQy3XIMBJA8ubSNl2alQGElq1f29HaYcxCoE0r0XtAMVF733ZMgRGv/bVrmt18o6/eBhpygepNU5MUyyRjJLvTTmyxMNtJ0fjij/gjfcMBKoxJh2f6TUH8iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsKZBXwdac0E0Tn12CnHmZ1v1cnr5OKdaa4uaYp1T/c=;
 b=jl0B60Hzz/HkM0RYnKUkgJ/ZD/5OiAETWHQkourQXuzeOdYRKXEqoyGkIimDi4/aVQKsIrbvgsLsRlyf9NFWSRRdvRHL73bZ9YE4CS+dTiEvktLPNbPN7G+Gewv/z4OYjOUoaW3XJJ4HaP8kiIBhlgAVg5SLzGrZWaSgD/e64eC6gaqqlQQHjQAtYtlckeiMJYqD5vwbyLTdLDbIl1DftrBsObfDhbr+VVpQVeQObalZ2pHm85mJM0yf83pYxhMMDtkM/zAuo5TTpK0oH5MXmf/aR8BUeD9oe1bLC3dbfe4tzZsKZAIOtq1QspCPbpAEWVULeB1EFDjVkDbTuTc5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsKZBXwdac0E0Tn12CnHmZ1v1cnr5OKdaa4uaYp1T/c=;
 b=Nb9yAlSuNca/m7XV9TxOXIZTuDjHY+zBg+xhz2uLgQB+ywh9AcNXs0bDdDOLv29g/NrbUkfE/ybYEeX783mprvGrwQpH+zIMdf4oskonGG3f2zgVi5GIiDn/DNfskATVs9Gcq1yX1xFCf00h/t89uirXcSW+MCMprg/vVUdVt0o=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:12 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:12 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/7] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Wed,  3 Apr 2024 17:04:32 +0800
Message-Id: <20240403090438.583326-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e/TKm4cw/FsfxcEHTBXz7lvXdZ2bp+R2Td8SRipCPHq0EExIXTnBWEwbDePLDpjE2I8qh0xedbWpuAqD1J+N2uRh3ZKCWYeaPOKHLFBVZ/5qpBz361AZZDuVq31H1+tuIdbgG3jZqsbAs60xdvxBr2rajC2YhRd1746hvAG5fr8J/TuHHKC5UtgyZuKfttDdPIQdbu6w1+m+LwKSnotGfGWm3EkPxyK5mJ/AsZYX8fND7UbYEBai1pHQGujqRYtwexLvabBFpNx3kl6RyYVWqK2UOYN+XlgSQVXfQz29DcoVbNjI8IVYn6XYrCtkC7wmvzqyx24DvO4rOYwHC+CixHxiIJZ+0uDoohKO/kghesXEUHkw+8qoGDiOpTbV42EffzPl/b2ZRIbDKzWce3ff0DgQWkRX0wMEERaCD7JSlfbZed2DQat8siWOZm5KNhBYwFvmmPOrfe0HvfAQ5rrohJKjrIh1Q2CjnaBb92wVQfq+kz8PguvQ7kBuHpuGkQxSbEAWw2k/+y06ypgT9h9rx1Ogh+i7C6NXDDtV1fQrS9KHr2VJURc5mMTgmIfH1fsaXVyI1HWEPkkgivnu92SZqFqqk/VnzVNz33C5dMBvONIEcxchRTRlRuW5vvGWvxpu73z4J6DrWnlCpP5jMEhYsabZ8S58vi0z1IglWUI+Qgb6gs8/LakhWMuhBTQHrVpQz0FJCRwtM78pLngYsTsvISOVujo4YR8f4tRVmtgzDI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VipmhiTfbvrpPVsxestmxVlA+6AJmZ6XI98Dj79Tj0d/M5r0IFcKzjurDIIO?=
 =?us-ascii?Q?40aEnS5e3gLeSv3Sc6hw6mGE3dOKfd4S6+h1ofylDIvBydgXY9kJm4QQK+qT?=
 =?us-ascii?Q?KK2YedoWBstbIJl92Ym2TkzPiCc5aIrZf314LBsfmAIy3K9aPQVT+1C/U71f?=
 =?us-ascii?Q?cLNCsGEoPhPCg4w80gLVJdBf9tuQWSTjWmN1iVOlMO8DtwzWTcO6SWe9fBFv?=
 =?us-ascii?Q?RNltFJcFE+slSGngGG2Hm12LsR4jSo0kvbibpthXugncd/1PAfx83xrcjyJE?=
 =?us-ascii?Q?NN1ivvXE/PvSp7A2AT1cXlnf9F55rTcaO9SsZWyEvI3XGMM2uYUfgZNQ/VaU?=
 =?us-ascii?Q?ygPTID39hxZA2DBJJhcl4m9HK2Y+1WacyYbVNeabCBClYz6O0TxiTkgWtNHz?=
 =?us-ascii?Q?bcp+NU8injk1qkpfa84saF+NSB1k5eBe0FfJaVI+w+6O7AzAs3pYLS1HLGbJ?=
 =?us-ascii?Q?XR9h8O6fhGn8FeWifV/pCHPPKXcegr7e72qzpJXnGYlzHlSiliRVjMQALiP2?=
 =?us-ascii?Q?g/DpJIeCIQ2pXhkc3GaIY8Pq3GNgEIyEJ91PE0orG9aSsnWmIb5pnwbWS22J?=
 =?us-ascii?Q?lKoes1mXcTpBAfrEI8QTKyVdNCG2EDklw4a5nnIBmGZVPjAaagYb3prLvmvQ?=
 =?us-ascii?Q?V1drA5YafPgtYxTaXGZp80KtiYJbCEKGFxb3c6VRk5V0oAejTslaLEVti/3H?=
 =?us-ascii?Q?mQzCt0mo+K6qKJ+gsdhhgo3EpwWqQ6ro1xSyELiK3TnlFGplg6loHTdyVgUb?=
 =?us-ascii?Q?OLp/AQd3UT39ChVzsxtjhqmc7kA3C52y5BRwIh+AuIBnP/qs1myU0Rp4esGm?=
 =?us-ascii?Q?TEnszUWyvTuk8607n3BYlrd68XKytRhJbp2Y9IH64uGTvm/qAlxWoq9NQdbt?=
 =?us-ascii?Q?EJYPo9yBQauO4/GA3LlDUx/Pz3qMoVB08ayit9LZtShhHtl62W6eEA3ud+QO?=
 =?us-ascii?Q?XprFS5lraDBpdoy8mX72D3uF/ayS4pSvgC4oR2uFTfcBqRIHSkJU8eM8GrIe?=
 =?us-ascii?Q?Jx2KZQtAVG4Eex/n7R/qZ/Plmq6z9SYnTYmiYxIWnagNbny4UucQfhAH83VY?=
 =?us-ascii?Q?cFDXuJ2gRSErep4U/6Ju3wRvXRKIf62onzHKVqcmDG58HLKAlLkXUJ5anA9a?=
 =?us-ascii?Q?6HeIeBvjYlGJ9EibclB5rNSugGQrQaeAx9cgywH04TThYSjCHmFGjIJjsTai?=
 =?us-ascii?Q?xyPKLdFQCxiej5+pTKoHRrUKUfNeYgZ9NGclUtJ/9zWTyNVl4Qw7tVS0Pnq5?=
 =?us-ascii?Q?SIWoriB3nfKVKON6QLdHii5SwZAx+OvC2NieMV6t9Wc87T4bxFfsmd5iFieN?=
 =?us-ascii?Q?wBzwqiUNUtvIS3Hh09H4YVB23U4JIjmjsO5QRfB6SP5oQBk3rh+e70a/3BiG?=
 =?us-ascii?Q?wcRpfftoRCHygRnyDLIsoOl88Sb4IxKBkAKgdmRiKOE2ajGo+08t8th652jo?=
 =?us-ascii?Q?2ur0I6d8e+ugNfWBiDKjWnI6b0y+o/lyN0QsDQX1Uv3dg19BbOidw1pMG0kF?=
 =?us-ascii?Q?itXi+CQddF+IJV42y4fltlxCTjAhoMvSV/Pa5gWQOGfcThe+Cd/U9HDAJKvd?=
 =?us-ascii?Q?v9OTmWn4vw2h1fwUPT1sYpooOsPgYwN7bwN95juj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ae9148-b9df-45c2-ae35-08dc53bd0786
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:12.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq5DSWbgQnDibwq9wqz2cVgBqMh9bvUG1nXQVEauXFulSnj8Y4TPRbxJxACRoIjonsKXZz0dYPmBuO3HSQbfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442

Add "fsl,imx8ulp-usbmisc" compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - new patch due to missed this little one
Changes in v4:
 - no changes
Changes in v5:
 - add Acked-by tag
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 2d3589d284b2..0a6e7ac1b37e 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -33,6 +33,7 @@ properties:
               - fsl,imx7ulp-usbmisc
               - fsl,imx8mm-usbmisc
               - fsl,imx8mn-usbmisc
+              - fsl,imx8ulp-usbmisc
           - const: fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
-- 
2.34.1


