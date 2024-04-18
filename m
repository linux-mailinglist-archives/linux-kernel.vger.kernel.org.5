Return-Path: <linux-kernel+bounces-150508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965A8AA044
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C578B281972
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415817AD6C;
	Thu, 18 Apr 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Grhm+FAc"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987317A92C;
	Thu, 18 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458242; cv=fail; b=dIWlICt3xXAYB4BylblI5H7mEwkV36hdu52tk7fbGRj5d4GX/5vpVdktdxnqiXVn/RPHaInHgAZaq3X5m+KK5aPePAJlfbfTQx/b5qJSxkLIrSOeMT+arX9UxLplhPv6hIWEDIAAgu+HzBGixef/i2LNDCDuB3xuv8L5XDL1apE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458242; c=relaxed/simple;
	bh=xiMO/Ji0IC9v7XmNUVwztxAaRwExSid8UswlKxDY+jg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bKe4bpXPpjwNjb+uLosgW6N7y+WVmXu77J3STNHKCOejW7dxtbUMqqsEkYLe0wz0OI4APh1i0x1YG5PtKhwvneJbLTA3Fobcy3DWmTBkt4iMz17RH3jXJ2XeeJenBna2wW0+SVtbJ0F5OicmTXYqGp2COHciuxo65sLPwVGkvzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Grhm+FAc; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRvY6AQm4plJ4DSmQ4d+ulasl1kiFw1EFWglrC57jv0p5Op1LX0HRGZh1MfVZDekK4rzDA+CdUwh0HVTdbsotsvNfws+9C7yDhafh2YA1SY+BHdEV+qDk1tRhSd6VvSipDBphOiqgow7AWbrDVXAq5RmBAtEnjPXJcU4Gc/Jz4PkUhZ6v3dKz71YP1bBSdLPE0xGEoyRYT9kiPBjXE8mBLB/QCOK9UOI6ShE9ghFSZ2tfL87r9xW88IA3YNScsolmE9pPxYeifiSO5U2BhONC8S681Gjlt/aZhkTpEVry+HUnn9EtuE94P4Y5QFe9pl3g5OAk0+DiimOLFL4IGferg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh9mD345GDepD1HhDQYYhPpBSP0niF67H/a2uoE2Q8c=;
 b=kcu4HwY5FWxeD11ySsm8gaXMKjT9V6FcGZ2sgV8Z8UrHJmVE6m6o6Z/c2n5WvBZZMF3N3ch53wtx4h3lren43JiRKK3FJGXuzBTBntiSonOpbbSaRCI+OJgkTc+XyMGUd/0syC7sWoWhYENiz90Xt3RGm4NFA0H+/JDxC2PotacUouBSfZcKx7mpYeTX27p91+ZQuBjSZOAblY1Q7UkpbM4j3HwUsZGaEJYvaq5amdQpoJo9ZgHwhb1mgj3SF7WeswEkKpNaEFse0uutFC3oozaPvloj+8eUhTLIQd+P65PQ6Uh8SVxFIqzw/OWWMDijQlyESX2Np2zDKtZu8lyLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh9mD345GDepD1HhDQYYhPpBSP0niF67H/a2uoE2Q8c=;
 b=Grhm+FAcGnqgX9iQSnrhavGncA3H4pSEU39mUeVVR8iJT77p7WlOv+Czf2KtwRNsd4T46gE1B0r+G8lDmcYWayR9Gs0m35jOp+ODGd/n+bqdJdrZPCnAjfxcbuWGL/vFI7qIAukJi5Y+2w6cldXGBFjw6mqOaCmVUkvia8ES5H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:43 -0400
Subject: [PATCH v2 08/10] arm64: dts: imx8qm-mek: add lsio mu5 and mu6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-8-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=641;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xiMO/Ji0IC9v7XmNUVwztxAaRwExSid8UswlKxDY+jg=;
 b=jbGW1XDrQc/osjag7a0UDRy1LLKOYwlF8UvK6Y7b3UfdZgubN0ICsIRSNLmzZo5LxTSFeX6nU
 x5LGklhKjtIBcGsmmzcaMOf/AFxeuVOBApznXqOb/xTF+cV4bEKmg9u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 69121acd-0056-4ee6-1efe-08dc5fc5d0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgHkN1Dhw+iJUg3m06Q9EZqxJbFACsDIrVMTUpHLXIr+I7MfOGtWWie/l2jDcwbzsHz/JTw8L64lbrQoJgbsph1LvT9rAnBVEvYxujAIvX9KpmHBX0TG037odrhQCbJo/dCAdiMCo1E5hgaTx1GcYxHu1PQQTSWKntRYJ8WGaFZYpzGSVzXNHfKPVBoS5y5vMWyCRX0n7dgsnnKU1B1L3u3F3YbL+IT6rRrNZX9V5ydizWa6kV/iE4j48MBzPE/GlZRm/DKUdRTMmPDxdCoER6bWXpRz7WK9gyp1JpsW5F+0lhrk5YyCPzdFWIPKcu0qV4ssm1KIZ98Bu324h5fT/pwC28s6IS9nLUmRxSiS8on+m+ZhX+pVNybMAn72/ndCnOsNsWOOJ25dbGonuxxeKRuCSTuPH/K8kQkxvPrOPz79VNyt63njgPBa6gTOXFNcRjGxf4J8m27GLZq3GmcZHjQ5wa9son5iGtIQ3Y0PGo15RscwLELFAiu16xrPKVdLIEKmyzS2rI4MRD4HWOlNnX9IRPpt9N4Qb97+LWczbJgPiUdMP4LxwSJxMwA3+wNVKsq6ywSNR1xrqRdGsSku/YtEIRp7tI3fT2DWJtKwzBXTga05cOAvufuqgORh28gyTxc1vIwMH9sTDaYCEdHKK4AxBJ3sVtOYeyAygcEKQ3FyQTYJR9rqCvU4VTotI/0qsdQmTH60suuxlEWyFSDRzeafGLBcBtipDY057guSllE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckp1RHo0OVlreFlTNnZDTVNBbWlzdUIvMmQwQXE3b1Vzdzc3aFh6eWVSM1pR?=
 =?utf-8?B?QkJjRU9LSFFpNTJVRXlnYjRHa2RrMHV0MjYzbVE1TmZmNzlqSWJJVGdiRzR0?=
 =?utf-8?B?YTlweEJVL1NsNW14alAvYUN4YkpmaXphYkJlU1VOKzNhSzJpWmtHMC9VeWdT?=
 =?utf-8?B?SEVkMzBYODZ4N0R4SDJCZ2drdEphTk15UGo5SVVxaW9JVnFucFBlckYvb1hm?=
 =?utf-8?B?RFF2dGZkWjByeURoV3FpeDJMWEdCZmFLckpkKzRLbDg5WlJOOXprK1VsVGRD?=
 =?utf-8?B?UjRlOFZYR0EvNlRXMGZ0S0ZlLzNITDhXVDFyYkUwbTZROHU1em9JKy9TWWFF?=
 =?utf-8?B?TVRvYndpSjYvRzlmK3NXNktQb1VNMFdVczNINFFFRURqcnRyRnc5bXpPUWxI?=
 =?utf-8?B?VWhhMzBGWVpkSkppTjNOaU9ZQmllV2RXeDFqaUFDQTVqdFA0KzJieXBDSkoy?=
 =?utf-8?B?ekZtUHdTanN0L0NVM0g5SlVsblNjSzFjN2g2VW5GaEtiQkpCeTNuaUpjYllZ?=
 =?utf-8?B?d2RMYXFiM3pQc3lvb01vMkpDaHFobnQ1bXAvamkyTzZZeXFSTzN5UDRLdGdC?=
 =?utf-8?B?MmFIRisvSmJUbnltc29ka1lmdzR5VURWWUI5SnlIQ29Lemt3M3poRXVWanU1?=
 =?utf-8?B?Yk9ZemhPWE82SkwrVHYwRW4wSVBhSzEvQTkxdjJRSXNRMGI2VmV0R1NkRTM1?=
 =?utf-8?B?VlB4QmwrTnZuNThxS2lhV0N1SmYzRDBqNHZsU25JNWFuUVNZNkM1dHhHcE1z?=
 =?utf-8?B?RmxtMmtoOHdBWW5ob3JFQkNSQWx4QWRLUDhNYVlMdXVTUnd0NmVHS1hPMmxo?=
 =?utf-8?B?MHhvSFkxSFZrdFZzeFNrZHVFazRUZUlJUVFxTFBsWXZnQWR0NEd4RWd4dVRM?=
 =?utf-8?B?bDdRNEFKTmVKNTVXaERTTitNZll6eFpMd2FQQTNjQ0hWRTUvNmJUK2ZDVGN3?=
 =?utf-8?B?SzRUbW00WUExYUxDelpMcUtJbWVnaWNuNEYzcGwxTk1MRkMva1pxK04xbGQx?=
 =?utf-8?B?VHN6MHY1QmMwMXZhZnZqRndCa3VSVE42eVJBR0Z1dWkyUXBGcTdMSE5UbUt2?=
 =?utf-8?B?YTFaT25nQnhkbmhrdE4yYTFuVXdkY01mM3JwOTBMTUM2Mkd4akhUb2pndk5Z?=
 =?utf-8?B?VEdQSlNBdFBqVTh6cnl4R2Nma2w4anlYNk1CZUZ4dml3QUpWT29pU2lKazYy?=
 =?utf-8?B?MnFwQUFMM0pGTWJPNDVaSGhSdWNPVjU4MWRHODRVbkNHdkgyT2o3c2doU0pF?=
 =?utf-8?B?N0p0Z3d0WFdIbU5ZYmN3QnpqSEY2bDRTZEdlTmIrbDQ1UC9IcGlpYWRlQkZR?=
 =?utf-8?B?OTJBeHlpdWlEMGhqak5WMFJRajJSc282Uk1lTUU2YzA4U29QS0N6bGNpSTJv?=
 =?utf-8?B?LzQrdmcyKzBtOXVBZUMwb1VsaEJIaGdCTlZkckdmL2Ivc2NoOXFqc2pjT1Ja?=
 =?utf-8?B?ZGE3SXdPQlg4VXBNL2dqY3lrQzc5RHAwamFtK0dpSGZsWkc2VnVNc045c2RV?=
 =?utf-8?B?K29SaTdNZGMxNjhIRmFXNzZ2TjU4UWhVdFZLOWJ6RkcrOG5WM1JrMVVDejF1?=
 =?utf-8?B?NG8reERQTnd4RVF3M1hnNnl0TXVjYnYzY1pIanlySm43WHh0WVNJenljNTJj?=
 =?utf-8?B?SlhGSS9yZEthbzFNbGp0WklQR0ZiSHVOb1Q0OU12TVliQ2RIa1gvcHJMeDJ1?=
 =?utf-8?B?ZFpqaUl5a2RoYXgwWVpNTy83UXMxWWxaRHM4cXdyMWVBVDIzcmtSejlQcVB0?=
 =?utf-8?B?NHdIem0ydW1yQ01aL1ppOWFYUHp6OC9GNDhyeUxRaFo3VUtNM3krWC9EWWhN?=
 =?utf-8?B?elRkd3BXME5WWDVGQ1NCVnU2bjZiWWZRWXpiQnErYkE1UnBvOHlGVzJyWms4?=
 =?utf-8?B?N0RuZUx2NnYrTXdjZmF6ZG95RkVpQnFKVStybkdwdis3c010am44OW9mZVFy?=
 =?utf-8?B?Rm5ibUNGb3lDOTJnaW91TXZZNDEwbFJHVGZNSmRCT0NQNWdSNWYwVTJoZHB3?=
 =?utf-8?B?SjNOSkFaZmxqVW5BTGk5citjeWFvY1lwQ2JoK0tzbVVER3J4TUt2SnJRWjdx?=
 =?utf-8?B?cURKelJIVDE4Yzhac0lzaWNjdzhIQTl3VkhIKzAwME1IcUhlUURhLzMwVSt5?=
 =?utf-8?Q?CUafQy6ZhIG3ZUcfLZSbKiBme?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69121acd-0056-4ee6-1efe-08dc5fc5d0d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:19.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tix/zZSKGpxCYiQNlDl9GXrRUkdO/woN8NUyM/XP7eUnfh2ZO5gJ31hkrXY7D8gmTPIg9B3RdZHmqdGjiMpZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add lsio mu5 and mu6.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 068bb77ed08aa..c8b24c46c30a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -260,6 +260,14 @@ &sai7 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
+&lsio_mu6 {
+	status = "okay";
+};
+
 &cm41_i2c {
 	#address-cells = <1>;
 	#size-cells = <0>;

-- 
2.34.1


