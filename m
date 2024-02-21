Return-Path: <linux-kernel+bounces-75596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5485EBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CB71C216D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C91128817;
	Wed, 21 Feb 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sEQRinXi"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E9127B68;
	Wed, 21 Feb 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553734; cv=fail; b=o6YF0G7OgfS5EmClyPW1/FUwicuM1XcENTIFNxqN6i3vTIlA87RHR3NQcaryOsnEr0lVP3xj2elwygjjCRdZNLxt9az4nED4T+RcdzYXqyiaqUaYc8TwbHMhOfrT+zsB6jrKMjh5Lt1Ky4EnFPk50B7Ua4MdbOfN38O0q8FLKa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553734; c=relaxed/simple;
	bh=rTcJPfGNgLi4woPPelCmZ9Fcf0eBGIYvGfJi4i5DxME=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MxZ3NOOXIShLB9sN27IKRgb6u4E3SBVNcxxpl2HXRu3viyU7Ict0ru7Vn2hOhXE4MLXrLt3yHxhR6EcsRYKOEHVtf9pDnGNdAdL4KOS9cJfKuU5F5h4TgdZXxMGJwb1zV4JaBMUiXUkdzAtsIyPV5OqBdl3H1eIRAr66YplQHQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sEQRinXi; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNZc4KXFstf+T9pDwrrHLNyk8ZitYh3y5yBmHf8F2t1/H45KxzqJouKUQaZ1Tb183ffHIESMdHM/IgiLDXBmfKcUPhW+fLugpl3wxUBZA6MUzkFk4jAU+29//NCpgZelqCEmD5WjvDGchfSt8aDnLzGBvfxxuHvy5WzwEnpEXGX9lqtKb0Uf+qgZtz/QF/FdhTfu4/2He4lwiw4uCsVllvdXicqwIrX1JuC+awDhas1UDzO6Qb7DS4wnu3xOAci5e+BnwJ3uJzGXo1pBXCtGCffDljwupkRM6FQpnur18Wd89LVml4DC3YGNdz9OBACjNh5aiHlY32BLWIG2+Wmcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYjfspc+aXbCX0iUA3GKMGrEXak94P53eMq/pDZX/GM=;
 b=FGcXK6j6KBzlm7+WdSTxBJ5FK/cqyAG1SpOfI039kY4VzLFmxCgmfbgnhtFWV8SgJj7zIuX48KHkHOy76O095LHQK6ETdPNcCXbcwT1VFW/9Tl90PD+rhtwcSsYbcAtvhD7jaK1apMnwz+qSbVesDL+v9PfN0IXQ0JGQPE50xPPjZ252bx42yh0H8GreOTzZElmgAzx01RkienLYRXnUjqnxdd/bw619JtI45dEqQp4l4qUpqvFRWnvf3fw/0RuRt6okVb0NuqDJU8ZZIc4zOqipAHoGZWbAbEsLtFdxt/6SLsXiaR4rCevl4+LfcCwJJavSmtoxy4KHeZ1n+2Cp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYjfspc+aXbCX0iUA3GKMGrEXak94P53eMq/pDZX/GM=;
 b=sEQRinXiKSelrSvQaLoJgL1ArkEIYFTsCfPgxqsncjARbky5qZCKYH5Q0jKeoKv2fK5U4JCwg5zVwY7TfeM92zZyTFqL+gF7WTyQCRg4mN5+mKxvzEuft1auPAKPTDzl8jedUApede9f4pds33/tCfmZQmkGnjhJ+6Yr0euXUHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Wed, 21 Feb
 2024 22:15:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 22:15:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] ARM: dts: ls1021a: Enable usb3-lpm-capable for usb3 node
Date: Wed, 21 Feb 2024 17:15:09 -0500
Message-Id: <20240221221510.3762096-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bac5110-2f54-422a-33d1-08dc332a9cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HKs8Q6gOyW+epDF7gMgI4mGptV60p9ZMxxqVCUdEh835uIne0K0R3F3ZzD0yzMzM+8x93BpciqAQrnCvOg/VveQq79jLcF1j6Gf6i/UuifSy6ilER54ayywNVbdBeQIwHIHmGv3FURvN5k3uuYsvsuxj+pWZ6O7MjV+i1Sangj2XDzGzQ3R2QZLdkk1yCKnF1D8emOgfmCmTe+5KvDEFCYYsEa+5OxjqLzrC1ok//w2/gPVVeCGx3AMYsfwYH6Gc2gVB5jgsjTkpO7mbdNNIcZT/5MGtDFK0z6qCmlTbZx1SyHwv05xSZ4fu8v3ZoGX5dp8uQpp1W0K7xlkTPyV0bjF35xHAx8v4brYBQPCHO7I2yaAmsh2ug3VMmyX15T8UDg3DiQLFBOdtDn8c99urpu8P9k/yHX4ZzyahS0rJsiXQ64dNpMObF7qxZ2EInTw6h75X6Ptn2WAlh53tRPTY/e8FHimIzMKJLHvj+TtFCRq+GmWWbJ9YfBCMklObYnLzPUnS/dVgZia4uq9Ax/BWEO0lmN7NlSjD/aSsCykl7cuGkD46WtfAYAlZqvcyS+waIh+3Ak/r8NX+WWitCc7Lvb+WeMMug+7fy1B57B248wcJbRLAeiso5MYoL2PmwQ3A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21k2t8pHrjhtxWI+2Q4K3Fw6kXcBsy2/r6Q3HqjXbuDPPR0nFle/2/yWz++u?=
 =?us-ascii?Q?SotYfV9ameSBIj62zKdLdWT7BNIPvFTWv3HWRXDZRbRvvt6Y5pAcWXu7fnp8?=
 =?us-ascii?Q?NBO1058lGQclgK5POpFuLJeoog+hfwvDZBWkgjEJMfc9LxJXPejF0dgmsiku?=
 =?us-ascii?Q?BJ2x/r8g+HnM1N8gpb6Ht7/iU1UuT3thfux10otraPG/dgKONJG782tkkh3m?=
 =?us-ascii?Q?uJnNvq9sJD6v88P/qruwvULDVD0tA2QjBKAjgIoMU5RuQm4eOxDbLtstVfnO?=
 =?us-ascii?Q?0GlzcLTCBdED2GbfxjA0n12edSnI2sECEVcaxNdgTp4TZ+1eXjD46iTZdzn8?=
 =?us-ascii?Q?LuzOT9EFOEc9D4k+jUq4m1pKi397XtaKRFARoZUT8/e3QCxYK9/g7obkZE9F?=
 =?us-ascii?Q?3a/go+lSsxV2uMWiVMh5pN9wYvwLQYy4t9jqi0N2NezBpfE3MNMPEc7EeV3t?=
 =?us-ascii?Q?HPsnXgh9Yd4CIHt1PDK3hTKf6C4X/hvBeRE0x6rR0ohHiLv5/RrhT4/OLvth?=
 =?us-ascii?Q?8d6wZW0+84LAPGLQ2M80cEP887Bj0OkDjFP19rp7jPkY2/W0DhLI4M0iEM5k?=
 =?us-ascii?Q?BnMIFAX1JMW21Y4Mp69OdIsHzIYkgVD4xNFPiN/1uOgl4oyCaIrCBVcf3hoL?=
 =?us-ascii?Q?sXtkT64RhphyPhT2sAWS5hIIWkHbJvOqnFMxXNoD3lxt3lYhup52YmS7uyFc?=
 =?us-ascii?Q?d2LyYBDTVDUS3gqG8aRNJFRCUIL7LpYcgK7DR6NLPhYf7ZurAavMsVZknBpZ?=
 =?us-ascii?Q?m/+e+a6EQCF7+8gZfKkGxT9uxDB2ZFpQn4tKc5z3Aeni9Nifo3W+djrdj3kE?=
 =?us-ascii?Q?abxoKgWMCJjFAU9/Y8/3K51Aq+GrJMKzv/TEfgBhIQH8ra2RL/A2VXSxumiI?=
 =?us-ascii?Q?3jfIUlu0XueR1sJ8RAxEvE3UJ+BC5jkuIbP+qzlTesWH/F80DM1HIPPvb0Ds?=
 =?us-ascii?Q?rEa0K0VpDsuzk7DhSjPSK3RDCueDRkJv2en+CT5XDWqQEkWGIUTz3hpL9vIc?=
 =?us-ascii?Q?QEbyzfJ5d4Wf310mbgkTuABWfuvY0KCi4/hgGhyyhtVF454JsEcEQGMGS4xM?=
 =?us-ascii?Q?+saqE9qEr3BZDJ+2ey5uUC4hgX+/X28+PiTPYSrkoToRVzjXnsa0D7HBF1Nn?=
 =?us-ascii?Q?kPIC+tq+XpEPh3HTyIS7cR7zxaKzr3ZV7myVSSh1xc3HniZOj0mDEbulPhGg?=
 =?us-ascii?Q?fjvEZA0l6MkpvcmmES8UOI4x4hs1bA0fjlAviGLwhYRg8OAPRMubKGDJgHo7?=
 =?us-ascii?Q?xKkj4n3FqocZFPzBjp4Y9FNn2vdoBeDmGC9EScvHD6ybx9y67VRqC3t2iGig?=
 =?us-ascii?Q?3FoYmeSS9qe1RMKtprf1D4ju/SvtNRLVwdBiJ9ax/gJ9YRakg28LNqiu7knI?=
 =?us-ascii?Q?QbbuRM4vaVnruaBBZMs2ACnuL6NrvcjC4KLr51kPI00kdeegTpsois7at9ZE?=
 =?us-ascii?Q?cSv/t+OMiaVEYNELD/GrPvjf3Cxrc9884x1ZQgGzFU8DkPB9L4VOxycK2TcR?=
 =?us-ascii?Q?6eYtIysXiW4wkVE1EEA0egWFERBzCpcFmmpMTPrXjTlRrjc+j4JmxBZM3f4q?=
 =?us-ascii?Q?75DnknF/cjuyhJV4y2vz/7U8+jPeKqJMuh7xJ1Jx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac5110-2f54-422a-33d1-08dc332a9cc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:15:29.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFm8cIs1rm67EFqcpoEf6WnufaSYSSqpOnzDcYYuAa2ISac1CvmNRbIQarrH0C4z/c8VRNtS4dgD/eteMHICpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867

From: Li Yang <leoyang.li@nxp.com>

Enable USB3 HW LPM feature.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 95e2057d9213c..e86998ca77d6e 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -808,6 +808,7 @@ usb3: usb@3100000 {
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			usb3-lpm-capable;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			snps,host-vbus-glitches;
 		};
-- 
2.34.1


