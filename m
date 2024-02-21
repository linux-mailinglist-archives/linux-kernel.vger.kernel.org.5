Return-Path: <linux-kernel+bounces-74166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EB85D0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85A5280B83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5463A1B1;
	Wed, 21 Feb 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XsZYRgHg"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7482AEF1;
	Wed, 21 Feb 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498300; cv=fail; b=MvKAStJw7oBM5ZLFj31FtGqmvCSMYus+/rjPmSnEJCWphit3SioHvKGMKpYF5w79xTKzk8CRL4kvyRKeX3KdBQe7new8TUx5xdDMzyeyWqCqIZUnXB83DZ79+JQeHRkXGVpz2YkiRCSg+ChTSNOkm/AmniG8ufR7X+gDr3c5gVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498300; c=relaxed/simple;
	bh=u5hInCalo+svZbvVshuo29Y82jX6K6IDHvvu3d6rIuw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TyHWu5A7Ubwa8YZ7JI7cDa0MAcv8aco4d0viR/3UWjQpZj3PyzTYzBWtsvcaPM8sS0o6d9UX/Xb0JmpofWZC1Xw58DEOrxvFue6DCpxb2NJ4Fj+jMvK0Qa8fAg4+ZDkc+l+IOMDxwRHUwDZGe7e3K1e70NOmvFu3imxuUZt8x18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XsZYRgHg; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNqsKwhRe/degU/P1CoMKna4hrvqjphQrijrpJJMKp+olFBvCnIyEp3MAk3WAZIPYimPgIKgnp/9fonOQ7mlaPHe8z+5vx6qEnMB6eRLYXtaj+TGxaLPPjwrwBOtiabYXJNKollapJQ/xL59H7EwYMl6L3ep8QpztBTyrG9eZGfh+dlpFQLkDX/BAQ9equ5RlqmVSMNTuKTVBFNn5Bmb28U8FkoHctLideiopbFdqV/r/FbK/yL96LcNrWXKiTUQx1Gjl3Mgm8wKk1mUKsPEbBgPl8pV1b4Os3oKhSCAl3NIs8zkYuwtMNKh66xuWzFpf0rSEjCZyUC50WlSTozOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJOtsv9vOHwn13dtC/HFOhSMqFabrrOR9Mj6iUBep/c=;
 b=R/pJjM5HjGjYjtJ5yLUpsXonDF65yvLX3VYx6pnnlsAMXNbB1/LhHuUZsHEKswcYuz3SyN3+YYAM4uzxKOH4jkklESBHthUpC7/p2cIl1XiLBeW4EjpH4kP/fwOaUuIZV8jy9lRG0dBxpM1a3G+0JQH2Iir5KfSJtTBiJWKHrhlU3wzoJomEKmk6mBd3/ESafGC4eewKVCbv+HK5vgZdusi8u/R4n6+N8l9rOInAVIBgHfxNX9nwj6Hj62EOt5EVxsk6Ddt8jje3C87KpSEdDKwyE7pZ/dNhLvvAZwQOn9J9Y18b77FzenHnGqny9av9QlbzzYsmIChCtxeQnSetNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJOtsv9vOHwn13dtC/HFOhSMqFabrrOR9Mj6iUBep/c=;
 b=XsZYRgHg+85QHLY0vkfVNOTwVbCgqB4aF1l8BPyYQnpKrzBfFd5to2NhyuDiXzCh37CYNBDaOqWxVZmFvTxsSVAyJTAnhe9vAjHCxh01Kf/8huwXjofOx/qcRzJYjbmMorSebjTiVLQ+K43yiUXa/qRWaooSi+5pZcAjDY3orq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:35 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:35 +0000
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
Subject: [PATCH v6 1/9] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Wed, 21 Feb 2024 22:58:38 +0800
Message-Id: <20240221145846.1611627-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 443e9679-f7ec-459b-519e-08dc32a98b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z/3I3AmyLOUdSf1eIR5zT6g2fX7dxABU/yF16AhsUFW3EpTfJr2PEynabDCoEvuWs9/TNpDcLSYu5JgbiLCwpncZyQYS2RYxv7U3w+5Ma0bkc/LA4MLrca7HkJZdoL2E5NJ8O9IEq2R1zyPHYeYFIM8ostsdth5ZF/O0QWTQFvbxtuv2mODUcSIZStPrge9szcxTewDsDj374lvb9jOQEVlgsTUHvrPq022RRAZvuI9x/8/xtpgz2x9BvxwMTv84VfxLz7VLMmmM1DGSsMrsIHhzGE4U4Ri8I1tZEnpGxhH8bXDR5lxhuX5gFtK4aj1OHm7OLLsfjRDumFbegbqHHhSx2wegm2xrXJ0nHB86Ign3aUkatbaMXmkPINkoatj/FSR4s90zbLuS9hW/7HkXbLKAQ+z33nVatHcXg4cgYID63+dKK576XVJgKExhHjGOl21cTz6ARgmIyxv6TsYCOUGJp17tmhbGsbFfySzcuwi3yTVJXrj3uqGt4DSFCN8IHBBZmOS9DlkKfvjN7SY/mKGKeJrx7qF48lpz0mfjmZX4NkdMJB2YFnk2fX+eErBAQjQu/BAkhuO4ir2xgtQqaEKopK4biWNvG5BCKAG/mt/Qfh+U03Ewa6hyZgbR3XL6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxZse7tj8d1x1JAtvyVbWHX5KXvn6uBcDp/w77Z3kZhbqwEhRQZavEQTXoet?=
 =?us-ascii?Q?d3jxPbBGg+HNdPCGgN+iXdD0Hq32EGdorUxVrJW0YU1Ay7PFOlAficrTQfgS?=
 =?us-ascii?Q?WW0RNhxXrI2KAvZ0K5gHPHvEQ4VJ6YmKYwWEyxH0+D7YZw93TjB4Lq7Z7J+B?=
 =?us-ascii?Q?fw6SBsf+diOpST2Xvb0zbbjvy1ZlzMu8/8vO/TOHigba+TkvU7KCcSWsvxve?=
 =?us-ascii?Q?xy/RSDJt0zKriYRO8wfyRlwFy9T7iM4uQYpfYxfkbndU7m6AnuhG2ZbxD+wg?=
 =?us-ascii?Q?vi+OSVXrB3fMWPj1oijyBUKeQTQI5rvU9W1YtTn275I7AvMqoMDPuSeuflxQ?=
 =?us-ascii?Q?lYMDL2ijWpSmsagW1RMemMUTJ2aR63Dkjf0aSFQZH0EwTLTyPur3L11ZLztH?=
 =?us-ascii?Q?EyxQKEE9yL7YPEKvNfNmP5EdFGKu9m4SDJqoBLmQpBogrVYmCyPPc9Air3Nb?=
 =?us-ascii?Q?hsdHSlIXVhiPFMCseT1z8JShNba+97lpkDET5Jnp88fCwXiOsPUsp+215ZNH?=
 =?us-ascii?Q?L5TYwVo6gZwlQq/PcaCT2a3zHb0FTswTY5IoroWOep7KbA0+ra0NYKjiVEhL?=
 =?us-ascii?Q?l83Kn+5VmTfT6UaKkL37goKcYYiTDmlwDjvT3lOL15Vuo/8KvRp7Dw1VHqPn?=
 =?us-ascii?Q?zzTFWzE1bqFHVCmiF4MUyDTxsiwLisHu23njyJ/tW6r3H//up0yYXsD9PMy7?=
 =?us-ascii?Q?ey/lCBt9h6YBEE/OcaEtc9NDLPmy1fogcsW+sOlbXASxkMEVz16qasqy7HE5?=
 =?us-ascii?Q?bXbdEy5THR5HMJSiRJefPvy0d5PAMTD4H2qP5twAbZ3P5EHjYmYZ9/OZCjtk?=
 =?us-ascii?Q?sZa7BXaEkc3KYUYA8pC4Rcb2egHYik4F7qzLCywlRssYGaZmSrl9UVmEbf3C?=
 =?us-ascii?Q?buHQmzMEbMVi9AYaiRNnEsVrYNZyJbXx9b682AFQqUtvtrCuWq660GFqEdDx?=
 =?us-ascii?Q?UlY1XilmA3pgKrkAb6ENPQyBeiBHG62NrZYjYJV2fL9s4COIyWt2SShsr41Q?=
 =?us-ascii?Q?jyIhhFofkU5b3QMtMs/b+sjPf3AT8RkhhEJEQdqwYw8qr3y8W1UdslRNFrgb?=
 =?us-ascii?Q?fSqCpjLjeGk1wRw8tGLvoocdMxcmxS+2S93Zyu49U/jbudRRwPGiuwkPWRTA?=
 =?us-ascii?Q?AaDqmLVoHypWh7L6UYxAKYtWHTLJzhg1KmmeLgLtIq14Gy7QgN0fsgqJCIqB?=
 =?us-ascii?Q?9VEHzmgBHVrtw4r+WinV0T8apopvIe5J4aSyS1/fkz+dK+oKhJbirw+O4BOm?=
 =?us-ascii?Q?2NS1+b0eyi+dkU/UvMSOTto7NSluKXHLPPr/Gura5o3wWAPZGEjKNUxfHRIF?=
 =?us-ascii?Q?IfQfcumgIErJCgqpHqcWkN3VOhQOgcVUNrp2RAIh4m6gcOfQ4yLiF5c2jWGx?=
 =?us-ascii?Q?YCSjMe9BLnX7WQFuN4aH1II/kv+vpI9ivUM7trzRiCBRG3u+0EDVB1DFxGw6?=
 =?us-ascii?Q?QByDHy2W5dFeCIAbUYllpOWDFsmyhXe02+7vmyukoSOd4/pkrKGAahtUR/6a?=
 =?us-ascii?Q?9IEV9x0fZ1i5iAw2Fl4d66jw7DsNayiunr50pwc3uhkbFwOgfkEMZLZ6jQtH?=
 =?us-ascii?Q?285d7PVIMzw97E5+9Blmb+oiNa62yztdLrdIuhTc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443e9679-f7ec-459b-519e-08dc32a98b64
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:35.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuTbbTwjPcZvez+VC1qkFvFT/G6jywdKro5itVFQctVYOu+OnB2Jr4IQS47wY36Auo+hLrDDOq1cDAYd+UJyeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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


