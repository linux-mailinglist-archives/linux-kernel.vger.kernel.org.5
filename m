Return-Path: <linux-kernel+bounces-32265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94B835937
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E91F21831
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94F1C2E;
	Mon, 22 Jan 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cUQW0vck"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068901370;
	Mon, 22 Jan 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705888932; cv=fail; b=Hk17bD3a+NLVTWmoEqP8JLR98t77MK1Zt8RSfUUITMFbHb4XJo29fkwgIkAQkvC/aCejGsLhjFQXLYYqtjRLiOWy/93lI4lILBhYLe0pSx1IE5nJe1J0a7vbaGwg1XLmvsn3X7B5hQPCw8B0s0fTpWRzDzk/6MrBrd0KG4xVwis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705888932; c=relaxed/simple;
	bh=II/Nyr/1eP6qNKE4rXAAIQwFbjQffQtZWC9T/vtKA9Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hjobbWqm+/wZtEHXqoXGJYZfn0pExP3f7kqGkYis7IwPVnZ358SlWuILQzUlLXCgKotuMMMR0EImUFZzqXEZ1bf/bG+S7wscXYsbZUSmZM4q28pEAp57KFFvwPzcfdcrVIn75roaVlRKRwN4WacHiys77i4GD7gvFE7edOyIXSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cUQW0vck; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6XmohNfTvjp3OygreYjGk5J2SGsl9q3b8O8gopd5XtF1WcutGijJD0e9ZaxIpiIHZ33g4wmhLCMEECcZl/24dCesSFsga+kfbHLZlXR4WLhBdM4vAMXwenQugFwgcP02zEoc6MPRaO6nvaYF4S3Uj1fyQ5vhby4eEHf4lXpt4S+t9oCplfPn/wPiAvAleSEDKlT2GUuLi9lp1iLr45KnuJQWUpT0GgdXsXEjy9XMRtaSoHq7iAmNn0nc9rcEFy9tHE8cPZn2kst+utlOIuED7jvH/ia7zbP531n6XKlVXbLVCIKn6laRDxmhxQ6advARpGN3Cjz/aExafmLkzOJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyXVc7+3aROnhgoot1OO2b1vDywWeF70xngmEd9C1B4=;
 b=X5mVfwZwIxMaeIx7eJqJKm8XRiw8bXKPKHwPzGBAVMPNly3OANkpd7hJpwdxNwnDrHmwDX1O+azmxySma4WrNWzQU7EX7Y0lispq3LDGqeQSPnKLTsCRzw1HVlwpJyZKNbHT8fbgWd+RBztmdBmHzlRKQTC0CyUgCV2oA97gb3l8iZVvdlNsAaYyU+FK4Er40PXIC9vdyY2hBf0QLw53ci11GS9JsYij6c7vc7VyddYG3YaiBsSlKybNIWNZmkus7qoDp0ks4bX/O4ouIeRtSpr/t1etGmOm2gY+AgQJ/wYOLb0SulwWjwKd6nhKRboMwZIsl8+nro+Os+sOwHumKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyXVc7+3aROnhgoot1OO2b1vDywWeF70xngmEd9C1B4=;
 b=cUQW0vck5qTnMUlIpZMxyVOgh+z64YAyRrj738PmguVFM4DhyvzxM86beVYTyNNnG/KDgUZdBRFU+kQyo8pjT+FEZ1Gn8TrsIvEKveoRQp6nEcp3qiHoc9t01xBtSOZJAFqe06O6wxFOl8Hu6fHuEci7qVClU0SAkhQZicb4Pwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:02:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:02:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 10:06:24 +0800
Subject: [PATCH 1/3] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v1-1-81413f655210@nxp.com>
References: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705889191; l=1057;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+jhwR2EG+nHEcJ8e150pa2lWQby/VDRQaC5dU9oyVRQ=;
 b=slApX5bwIN+mhk/EL7YhJCyNByIJemxffHRiSVy3V03wd3PJx/TOTkdEr9SB+Qww8YlM4MHmT
 mLQYZyMsmZaDYagz8VLotxTIltsDNfcyDoA9GWo6vgyJ0ZPvDs9m4vD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: c27bd164-d9d4-4671-84bc-08dc1aee22bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	spXaC85muwU9OEMcbW+39AkM3XsJuOAC3uHx0pcI8jo9KMqkKbPGWqJ7N7aDswho1nvDnexw2h8lML4iuJRw2ksQmIdM9+TwDVHPLFCCaokUBsH9ZxH6ywDFNbITCoMPs367SAm/UN0fs/MNZFjRY24bAKOMW29f6niv2Dc9lPFNO0cQsaM/BaUvwL3O05GWsdnaXampXFRcwn6JhXPWvRjmxOzjntIEMYZkk21ZZGk1Ix9+uqL3DxegoNK6IOi30gxb2pPTgQHc6k+jMOhb+tcKRGK6dFCApvYwyNg+5Lm4OvAod+Ur6lnY4mqMBQ6OhqEXlXoSQeIQTAasTMLOoJ3L4llU3rCWabVQx/P+4Erx6OG83CsuRpCDq88Jw7hgo5WsFvCR95+AA2YkIVvYP7//1Z0rYBWy2p4usNZRtCa3SjFIm2sf9b69LR3Nz2FQoWCPfOMGxtRTM9uw6rntfhb66ES3g5Oc0WVYVzUlbfIifdM5C38mAnpLQQKXXegLxwtvqkB+89ylHkjvg4XioGW6R9JdIGKxeWczks2Km0ILDcKg/JybhEMjGiA/oNNFo3etwYWgZYSJ5tpUaIl22c1gIZHl/czNa269EtJlyrAUkUqvESHYTYhPncPeEzA8or7yJU64gW+cpB2ClarZzcrVwYK27JCuFHYu59nwBoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(83380400001)(478600001)(5660300002)(7416002)(15650500001)(4744005)(2906002)(41300700001)(6486002)(110136005)(8936002)(4326008)(66556008)(66476007)(316002)(66946007)(8676002)(921011)(36756003)(38100700002)(86362001)(38350700005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VURpKytPcXNFYXROd0ljSDFvM2pQbmZ0aXE3WE1PUE9VME9KeU5xbkhvM0tN?=
 =?utf-8?B?WDcvWkhycDlaSzVYcWJ5SmVtTjVZeE5DZEdldDZPSThEMXJQNTcwRHhuKzA0?=
 =?utf-8?B?Z29CSllKSktPaUd4WWcxcTJLb0hBS2RZTUlDZnZ4b0x3MEF6dXlrVUpJMHhk?=
 =?utf-8?B?TXVUR2pYdGlhNWtsSnZ6NVhHVy8yUzAwWWVVbDZUY0hOOEVOeHpvang2VzBF?=
 =?utf-8?B?SHFYVXkwZUMzZDhHbHIwbjBmRHNlNi8xTGFmSmdRRnVWRGRNSEM4ZjIzQ2wv?=
 =?utf-8?B?WFJoMFY4WVA2WmtWR0dNTHQvRTBVUGFxMmpDeDFRMjl1WTR0VW4xRllFdFMz?=
 =?utf-8?B?cHhXdllRQjBJT3A3Q2pmR1hhQ2dSSGZINmErMVJZZDVHdXl2bnZBS3lJbk82?=
 =?utf-8?B?MGhFSDI4YnhFeVNYbFVDa3p2V2wrSTJLUTN3WHQyb280alN5NU5ENVl1b2k1?=
 =?utf-8?B?M2ZMU25iR0RzVHNlQjJnNUZOaFlpeFBwaXhuUXlhbUZScmFQZC9nUUlFdXUv?=
 =?utf-8?B?Rm5zeExkcVFUeEJZUG5CMWlPWlEzSmNuSjZweDFLOWlWNE9IcXYrVDdVc2tE?=
 =?utf-8?B?UjhYN0ZaQ3BGMVdoV2xuUjJpKzJmdW5TdzVZRDdXaFJCbDJnSDdaamowUTZx?=
 =?utf-8?B?UXY2cFE2b0dlYis2d25qWklOT2RPWlBjbkora2dlVnV2ODZVa090aXUwL0N0?=
 =?utf-8?B?SHpvY1NKRC95bDM1bkwyV0dKd205ZE11eEVrZmRNVW5jZlV6TVhybWVDakpX?=
 =?utf-8?B?WFV0SHc4TjNpMWphSnV6L2l6ZXg4NG4xSy9MazhSbXJxS1JqUDZJazB3M3RT?=
 =?utf-8?B?UHBSTGdnbXRvcFBrTG9sZW41MVdnNnpJNlU3UXBzTUdpMmdOL2ZycC9DVSsr?=
 =?utf-8?B?eWN3YVk2QkhMUWNjcjVRbHN6NWlUODJWNUt0eDlGR21uc3IzdVZoNkk3YlZK?=
 =?utf-8?B?MWpieW9uNDZ1bXZYcG5CV3JhQk0zTWxBSEZqbDg3ck05SGlCdVhBdjRNbEtR?=
 =?utf-8?B?eUZNaTlrTGxpeEpBUzBMUjlUWVFTWFJteWMxSVVLOUkvVDlzaWhVUWZKUCsv?=
 =?utf-8?B?djJFSUFpMHprUEcxVkppS1QybWJHQjJGb0gwdkpPbStKaTBRZlRVY1J4bEZ5?=
 =?utf-8?B?dDNYM3JkVW9HYVA0WXFQSjNQdlBPNlNtUG8zcW9nd0E3aGw4RzExYnFPa1d0?=
 =?utf-8?B?aVZXWlhFTnVKNGovMTFQWlozd1p3b1F3SmhCMXR3cFZTWUZTa2t6eXFNVVFu?=
 =?utf-8?B?VGUvNWEvL29ITHUyNVVyVHpDbWRQMWYrYUNPZ2djWTJyL1NsaGptUjlnbHYy?=
 =?utf-8?B?SU1OOWxWUno0WityTnlPTldIMWpKSElnRjBwTmw0OGxMcitPNlB3TkhRVVRk?=
 =?utf-8?B?VmxxeTVOWVcrc1hVYitqeTd1Ui95RjQxOTU2OE5aa3BlYVd5TEdjeGhyLzN5?=
 =?utf-8?B?bGlCdWcwRE9kQ1loejkwM3BqT0lhWmxxS1l5V21YQVl5K0xadFZJOEg5bUV4?=
 =?utf-8?B?RjRWdXNSQ0Z5bVQwU0R5SnkySy96OERicUl6Uk5qSW9MTnFreVlqVWYwTGMy?=
 =?utf-8?B?ZHBKd3lnY2E0V2V4ME5PT081ODIweXRxN0hJemphWDJvZVFTTnNUL1JxcDFy?=
 =?utf-8?B?UU9KTzVYMW1ubEo5cnUwYktDckNINGQ3OU9qaElTNXVvUkFKcEErNC9pQUxY?=
 =?utf-8?B?YkdBcjQxTEV5ZlpBekFiZmgxWnY1N2JCaGd0U3NCRXdpUCs0bm9pQkhCVDJ6?=
 =?utf-8?B?VStFMG9pQkpXcVhhd0pubkczTTNwQkp1SkxValFlMFg2MXhDaGNkVERDRGtY?=
 =?utf-8?B?ZXJjc3dIMUFNTVFidTZ2SlJvUlg4L2FmYU5iYk1ncTF2Rk11MGRHSlFhcXZh?=
 =?utf-8?B?emhRZHRSdUVlbDVzZkVyR2R5V2M4YTlBL0xiWWR3bWJSZjkzTnJXOGdKQmht?=
 =?utf-8?B?U251dHBiWDVNdG1rNXkwbCtGdlM2Y2xZTzE5eVYwVjY0c2xVREZaOWR0c1Bt?=
 =?utf-8?B?M1dJZzFkUldRMXFJK1UxdThKQU5ZeTgzcittT0phdnRpOTFXTk9FMXBKbDc5?=
 =?utf-8?B?RFd6ZFZJL1d1L3dVSXJmS0IzK0lwOThpaUZ6NytIaXpzeTRzSUk5WjBkUk1p?=
 =?utf-8?Q?HRL7rasQMAzmRCB8Bu/K7Wldp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27bd164-d9d4-4671-84bc-08dc1aee22bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 02:02:06.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCzSCM/VdympH1GCoMUq+9e0iTl4rrfCI+JOhUR9cdqUDvVXT/9NXl5y8dPAUBstWND2J5tF+w/8F1bNyeCsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..24e3d8dbc34a 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,10 +29,14 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
-          - const: fsl,imx93-mu
+          - enum:
+              - fsl,imx93-mu
+              - fsl,imx95-mu
           - const: fsl,imx8ulp-mu
       - items:
           - enum:

-- 
2.37.1


