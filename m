Return-Path: <linux-kernel+bounces-74278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200885D1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EDD2871E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCF3BB23;
	Wed, 21 Feb 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PckTq1hP"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654D31758;
	Wed, 21 Feb 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502568; cv=fail; b=WNpLInpq1TuHar+7z1Evxl4H+XWSvJSBfzhnJm1PjwHaz4ecNUPGnV7esviSZoZsc7w7w6rShP5XQed3X8Qzr/dsSYX1KUw0DaewBZnqb4xK6DqUhQUVHEY0APm7SyQFSKXdKbmRn12LCY3Hx7sNzZA7s+1bTDaNoaGJnEEHt8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502568; c=relaxed/simple;
	bh=u5hInCalo+svZbvVshuo29Y82jX6K6IDHvvu3d6rIuw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NSar8QaEXzCkaytPBsqj3ecL5o/FDz2xRcwgVFqzxL5GFT/DW3rI4T8TNp2bKZocxQLRDT/V3o2hi3jvY5zj5GU466zp5YJ/n5iTwhmIymGT4jrfr0mw+CMEn563olPXhumuRV5a/cWsLRJE8A4CX46kxfhPEQeTFxemSlZwPhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PckTq1hP; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt3Lyn05GywDlIMph7a0Q6UmkLAACulLFXzcypK1KUCZKhoR+AUTwSnHc85faTi52QACptAoRM2C0cjrc7I8Ldj5sDqZ1YG9+WeV9frtoDyXQoUcjpMfX3E9XMHmDi4+441sLQUSaL2dBDYEodCXYRwUwm5JCd+qMwpflx8OWCLo+u+gxwz6DZOPLUJRlaIBcS2RLs/RjlO/hPwZ5p6TSgoFBPnCrxWPbQcGeGbyYZnLPNauhc9TSawMpdfCyWHpmJdvf4pulLBJ9xtqgP/1EuBrbh5shGdPsRfsa0IHnD2bLjO0vZjnEyKHRbR6hUZuK4haHB26P1sGRi6Bn3tWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJOtsv9vOHwn13dtC/HFOhSMqFabrrOR9Mj6iUBep/c=;
 b=SUFDu0suoK0eMGmguDS4t8jrqzIuabdSE/rjXY4mdPepvu6VSn0sl/5hB/vdVv+3QHE+Sx8056qM43HT/9UX3AV07KNcD1WyaYAVb9EaT/IPHTIiN9nY3aPqvLUeVvO9/s+QkPSQYOCautZFxJjQVePNM7XnUEzttOsZ6JGr9lBMjgoef1O6vO+V4pYm3CSZBm0Rw7Sz3w8PWBi4ugjFjioR4yYAL7Y5BQFCi9TLg23r7Qhaf/nkfDpbEtiqybflHlT9m2iCFJCRD4m9qVGYrLbSpBlkbTvHABu1KPgMwt5/gu5Gz7Q/tC/r/uXh9RUD0RUbjM17cW9sbYCtp4sCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJOtsv9vOHwn13dtC/HFOhSMqFabrrOR9Mj6iUBep/c=;
 b=PckTq1hPMZNesVoz3/0wlNaXXI63s6vGXpkjWwkuCWGgPvMdCBgsfceK/NxGlq+8sTLiFvf0sG1r6PgE6rMSBoRXtYE7c0ne3BIFGTb6AXEGXR0tZxceye9NucZ9kt5UgZYoCXeMTRw8L5lj2ujk8Nv57srs0zq4hQoOBR00iZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:02:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:02:43 +0000
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
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v6 1/9] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Wed, 21 Feb 2024 16:02:30 +0800
Message-Id: <20240221080238.1615536-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 209f0cb4-4506-469c-3323-08dc32b37b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OxnKTRbSu8R9710Xcy0+q9z9FlPoBlfy4tfyKuZKsUAeZn2NXgbvPBaPNanvGTl2/CCj2r0PGucmtKi/wxhQUVG8qcuW7ggs55qzDyNNTi+b3dRRZvnct70YBl2R76YC1Mb3dlILXMooTLS5yqYfvbaI6g6CXkoiJ7WRfFew9COrZCYnwL2Iu//M/bUbAJmWkeR2C21V7SufRNCFgTJlgt2aoJJ2oQkLgV5iw9kab1rCy+KABED40iOzBRiFobx0Co0PcAjo6ZzZJjhrt/rBB3F5JLcI6awbt2Wnlotvk4VgtoJHlwEYM3npYNTtQpQqePb9ZxsNxxfVa6cCvTGhB5StVu4NupkWGNeDEU8s9VFa2q9zSG7BC4ueTDpAieu86TA5sgY50fcd5L1IC8/nxbNCggxzdZfLr6/zAxAzC6shDhH6hzfiA/ncbgbeNf0xGNCMB5+aswQA+maI+xzgtfsJhHTBEvfVZ+plePk/n5tEjhnKxduwa9KDc5uxkigSWTh0UVc3oNZ0OrDH5y8QN3arqotoYr62F3HkVzdBm9mvBEFUp81ZKDaxR+j5/29EEDkjsQ6zuaRbw+aDLbcTLI41ozNO/qrmIdZbvNRodONKw45QAnDAP/thSZwv2fzv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wt9E5eEwfqy+ccILvEaqnFgNMUHD2xkX1izeCesX1crTQ0hvcCZ+zkKo5YC+?=
 =?us-ascii?Q?kcqLewX+MKpPGzCo1h0PWyNK36b7ho9IQARH1MfAEKgWFer9lonoMc+FEZWn?=
 =?us-ascii?Q?FSpO0v0mPYy2sOB2SZWg6FfrAYglqMegmZ9bHF5jvnZVzcMGPU68R57w4TcF?=
 =?us-ascii?Q?hXR0rhuZx560eOE2JjUBPl0dikAX/Gki6mdGFBr1iP6/R57ZcHHe4uZsCYTa?=
 =?us-ascii?Q?Fmdy5pTAMFdbN/VpBvf1JzJOunVMU5MuWWjpYmCNYCEkCUOwz9W+iuDXin6h?=
 =?us-ascii?Q?9+xuHG0Ogfx1oDJL8UD68kzn4TAkcR8zMgArSFemwy+OVg0uB0dpE5GF4tzt?=
 =?us-ascii?Q?u+bAKH1j3wll3r4FRO/oposjhPGPnOUtovzb26DPl16rnOLzgU08zCZhZbHs?=
 =?us-ascii?Q?NZ/apJPP3SnST8TSRTUmUNa4iTJu+PpHPmIljE1FtnlA/OUlkdNmo2ODvkba?=
 =?us-ascii?Q?TWNPntg1IrMDEzrLKPmk/Z9uCNPoiyO+Jjbj+aHvdxEFvxrgaSa7MnxEAnob?=
 =?us-ascii?Q?UU7G6jwfUZZdcM41KvHOzjzV1hyplw5hfsoRioXHEv87xVS6NT2xfsetRz+W?=
 =?us-ascii?Q?zdQV6suPQBXRmUBB+WDCMJ2dH0D8CijlezSOwgxrS+DpLHjHq9Tv8t70hpsz?=
 =?us-ascii?Q?iAt9gawK5g+MrcI4ISN+TVQYzrRwfG4im21ka4Q5MbI+Nu0yS1c6G+DmHZiy?=
 =?us-ascii?Q?6LuYMG3XYut9egJhlCn7q+QBwi1GDMkF8qAZj4iFon2bzc5DzcRf3pHDPqMD?=
 =?us-ascii?Q?/JIy2AwL5FWw50QpFz9s+wCqWvZlXlXmMHk6QoUBSwz1//BiaW9JDfFSjQYj?=
 =?us-ascii?Q?PlG5n4NXnC9c9EO/SM38g5yx1xWUtjtJCgMiTnD8eFT4DoKpjnfvLKHadfsB?=
 =?us-ascii?Q?5IzI7O9uc9ULWYrJVDPhg+d/AyYp1qqhnJHiy1wMUvJaje/8CQFcaYMfJRoc?=
 =?us-ascii?Q?T08JQWnwpeym0oy68+1Y0aT7Jye33B2Qmv3N+1mfT4N9jpuD61t2nJC08/FA?=
 =?us-ascii?Q?RgD/fCWF9T2ETdb8hzR4pAOfJWaOHNs8F5KKeYWRdzkw4tWisgWPSwCCEPaH?=
 =?us-ascii?Q?/H05KUG+WF3YCcTT++0qLBldnG4Uptjf6WasPZsqy5ks36+tjkSGzVu8V0Ma?=
 =?us-ascii?Q?q6l43zzoi+X1MpleezkG0R3vU1vvcxsttT21AdSQEetiCYSNFtpAsTWz+TTn?=
 =?us-ascii?Q?y62jVHC0lEBTXi2eX08U+bw7IiaeQOtYMqG/p+0e0e1S4qxCk608KZT4jupL?=
 =?us-ascii?Q?MydoWexjZk5ca0s+ch41InJJ6tX/+8kTU9g+0T/R9WhmPe5Xtd0vctA318T3?=
 =?us-ascii?Q?3/Wy29mqRBFjjqDMp5PP1lfsioMXuSenax8V1NOsguIKIa2OU2+3fPiOmWz4?=
 =?us-ascii?Q?DZksKHRSohSOzGxr51+uXbwDHqdr9k5dzUjiSzXqyje3ZoFkIo0HJJ3lbsMj?=
 =?us-ascii?Q?2l+7Efx75onJiJoZjyMlUTQQ4v/PqdeRXIiAl/jc8tnmpfeR8UrwNT1ov6iR?=
 =?us-ascii?Q?fKs81YqB0zLiBHNtbZ+nG7bgKVF74m2hWrBHiUg+iP69o+wxw1dDunKggQK5?=
 =?us-ascii?Q?5CfWrNbD3OoXe7oTLOoUYE2VzZzzzOXbOG07jSEx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f0cb4-4506-469c-3323-08dc32b37b57
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:02:43.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht/dqpQLoKDrjSQODumBFyDlhSHOanU7MgwNlOPh9Mv4DrQQzatpp7S2tW2qngwaarciXKe0PHpSh2zv+Lkd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

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


