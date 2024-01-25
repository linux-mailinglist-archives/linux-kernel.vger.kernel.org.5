Return-Path: <linux-kernel+bounces-38476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F883C072
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C183B1F21B78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5C5F55D;
	Thu, 25 Jan 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ix+vlhrl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436545BFA;
	Thu, 25 Jan 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180741; cv=fail; b=WnSJaUrwIjAyLQ25K8wOz8a9mY9/G6Lp1OwmA0gjyHeX9w2dhxatmel174X/ClELU+wMJf2bf4oU+tietBAN5OeKOGttI24PDP7IwFe1RuV388bINK/o2slur9G6LQ5L5pix9/bSFVqkKtIRTGnZg8/OamPAYwJ5SBu8r0iOlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180741; c=relaxed/simple;
	bh=B8CbdzQuigSVHmYJpn9sHju4+pZqzmq/EzEwBZlhxks=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WfXeTDeI+lu8fT+Jx8gVOOeQLECDx6pSK+V4uImPpHQyiCNfqzBsciUVp3PUnrUoyYW85mB3Gsp6p14VSr1moHKefclEIEUajGlZqvCJYCY+y/EoELLjCuuSrSlN49rJMTIbYLU+BV07tSc3s1G1Kpl6Z+hyg7vyb8BVvov6N20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ix+vlhrl; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsGqZzEsMQ6b4U50KNqwbyRGNxEhTPxv3XsA/khdx8raoLMcN3S70pFd3pDIVplM9J244v4+Kg6sWO6cpB2ph055kUnUdiWFYTGT7U6nJgiddQkvhAM4zhjifmGNdYmq/lJpZhyObZhro7GWcHQQjZ/Vi5iXM+w4e2WkoMlbK/rrwMrbpveRGHGPxIHBfW+QKQclYRW95UzWyO+QYP8rJY239nJbimGFomT7AJBd0Ci02HUyFWFaZEUkB5GaLIVad3/5haHExBiut+79SVIitlw6xC4EJsEKkZJa+WM5oLLQzL3EHrcpxXSxqsukAPiS1x9iwhozHZytr5jmv8t8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d21s6puYPV21ZPiPfHbW09PbXzAEYFeEqQEeMC6XFUA=;
 b=egywIdqpiDhD1T34swqcJdVYUu91s4vhAMwZ+rDDOme5vN55XmqLFrds94B1WLi6Q5pWJeUvpc0D4LTyRF1jsl6yxYOUHQ6AadvN7TobViLdcO6sec6yZ1tXUQOSO9gVjm5pxbovcXlrBgoY3Akjj5SkHq+zfvsmU8TtxU+i0dl/dNxmlHJYxkL2LwvBp0OXDZ6e1NsqeIA4oDppJ/2tBNDdLQdmk1hF5UOQKKlgM4Ib6JSNbqOPcIzreafwMyZosEyXsNR9+4FcCCOa7F7UQ/zS2dpgn2Xibd1TMdBNqX2MC/DfEZq6omK/NV+wn9PkbhvWvs5wL94VudXaoM/o+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d21s6puYPV21ZPiPfHbW09PbXzAEYFeEqQEeMC6XFUA=;
 b=ix+vlhrlPt+bcNghk10kX34ev1/QEVmsxMPJAYnTcVozXqb+8OW/lq+ISM8I+TxU11RdCoP68ACz9tkx5eTdM/cdECKuzsOQ+FqKhjxvXahN06M4aDMjcJAQfXyh2vQ6SzCpdEaL+HwF0marhNj+JmbhJjpWAO4jnxzn2bCZCZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 11:05:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:05:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 19:09:47 +0800
Subject: [PATCH v2 1/3] dt-bindings: timer: nxp,sysctr-timer: support
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-sysctr-v2-1-7332470cd7ae@nxp.com>
References: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
In-Reply-To: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706180999; l=893;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=eOWUoZq6cbt5HpoeRdEI86Gf0YTn+DquGD02bwDCsp0=;
 b=BIoJJ51nDDjnxEMZ4fxfSf9qu+guxZ4Wuor6C6sM2+FEGPtXPooZKzpRYcsbNRGb6D04H/QKs
 NJXeH0FVGqFD16JS1TiH4n8c+3fiyJ7HbkV+WVWJnMm5cHko9UMNot4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: e35b56e5-f0b2-4921-f5d9-08dc1d958f49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/xsJYJBMIMzGOZtLKJllMpYFYYon8zEXEfAShNOmez5pBS6ExjjzC3bJHUB+UqAZ7SoGm7N+oosZDmWFgm9MqsHQd0xcK3vG5B6CYVbbF/5b1yOoBv0SkYfL4ndjcT5XUkJqrrRY7EGDKt0VgjCrWvP6UyRBbITl3GMwn0HzTePKUqFDCNKpvpqCxWGaUfHFIzF6MmJHZ+C6b5uhN2xX1+ddpj8tbI9n8tNX/ZQ4/CNyrn0gvrqMuEu9T79x+ztlcOCQcbmcq1aneVEgdjGZxf+4eRzZNu+s6d0qZZC6FIHTxmEhKTawsvlJo4nkqwDEkRQaukA5gH/9ZJhTC9hHfRLGrNE5J3yRVdMtxySVNFV4jxBvNDX6s41s03CiyyBmQQCex3J5vVtyUfVgGP+ZBsJVO3iI1x70wpfAeEHB9oSuBwRWkjjXzRRemAu9FbkVtzFqXzGdKqS4rMGOAY6kv80CAbcphB2sKP+Yo6VgP/JxjbKR2JkTkLOvmlx3sB/IIoik8z6UWAxHwrGO70YVTYSahAE/QRQaEGuqxDAAriXgYOoMqBWJn/dwyh5Y3DyuZ/5KE3377mwd79hE1wFyV6TWX2zfgwBiGVIJLcSoDxeNB01gZkYRMxhVbPNhHKQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(2906002)(4744005)(8936002)(110136005)(7416002)(66476007)(8676002)(5660300002)(66946007)(83380400001)(26005)(38350700005)(86362001)(36756003)(66556008)(316002)(921011)(52116002)(6486002)(9686003)(6512007)(6506007)(478600001)(6666004)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtQczd2OWxBRUlsRnJhUStjSjRCMkcra2U4NnJiVWVmTG9DTjJLT2ZQKy9r?=
 =?utf-8?B?QmxxWmhZMzMwRFBDMFRKUHZaTlVHUjQvTkc3OTZxVmFsMTBIUG9VZG94cERB?=
 =?utf-8?B?THRMK1l3Rlg0OEtWT09Jc2pvRnd2UGNIU3ZWRzBUc1U0Z0NQZXpjZklnaUI3?=
 =?utf-8?B?VXBadDhFanNlQ1I3MGt0M3BUVzNKK3d1c3FJbTlUMGd0ODlzekwxSTd5RUpp?=
 =?utf-8?B?YTBXYjlxeXEzbWZQSTlTbWlRcFBQeUtzejU0N1lDLzBxZEgvbVlQaWFGZnFy?=
 =?utf-8?B?ejA2OE5VQ21HTFBjUUpmd2w3NlRMbEIyZm9VaVFSVjZlZEY1bmYrMENITVds?=
 =?utf-8?B?eUNnaFdrK0Jab3VHWmdRM0lDRXppVDBWT3JSQ2htZUlYWVdwNkF6TXRpcFQ4?=
 =?utf-8?B?dlV2eTAwMnBLeklFR293TXFtWm9MMzB3ZklKZk5lSmZsNUhwMC9zRngvUitL?=
 =?utf-8?B?V0JlZ2h2MHhHaVlCUXpIakVyNURkaTN4VHZzbjdXTU9JamJ2ZzJIa0ZLTHhz?=
 =?utf-8?B?dzBBdGFMV3Ava003UHNtNFVWY3RrT2hXaWJOQ3FkeFk5TlBnMk5mRHhNVDgy?=
 =?utf-8?B?Ump0Wm5ldWZzTyttZ29rWUFEZm40UGpuVGpQejNZazNheENCQkZHOHdEZ1NC?=
 =?utf-8?B?aW5mQzR4ZkYrRXh6S3BUNEMzdWd3ZEFCYU83WVFJWCtqc1FucTg4U1Z3ZlFu?=
 =?utf-8?B?WnJ4czhoZHFRdVFUc2twak8xNnFVWGVENk9HdHM3U2p2VC8yV3JiNmZ3SlBo?=
 =?utf-8?B?VDlqRzlESVJTYW00VFQ2YTBFekl5VThBdThpcDk3a2tNRHhSQVN6UjIxN2Vl?=
 =?utf-8?B?OGdpdjlVY0dRN1NaZlZCbGZUeTJUYXMwL3RKNEJYQWVLSzNEOXlVekFpSk9C?=
 =?utf-8?B?ZFhsVFBKSktCM3ZOMFBJbVlpS2dlVXdvNTUvL25FcVBCZkpCWXkyZ0taL2hw?=
 =?utf-8?B?QzFEc2QycWl3dkJQZHpKVkNoSEUxTXFFOGI0cXFxMDlpWWhKclpTV3RIdVlk?=
 =?utf-8?B?czBLa1pwT2xyVUNZS01Kb0tMam1Ua0pNT2E2WkYyVWFjOUhWdlhZNXFFdXlL?=
 =?utf-8?B?T1oxb0FJWGdaNnlJbGRQbTV0LzQvVHJiZVVYSTJzakNnZ3JpR3dCL2xaYURs?=
 =?utf-8?B?MGJvZS81ckNVTWF5Y3FvK2N5aGpTQy82NG5Xdjh3bUdoVWdhL0FoZUJGTVBL?=
 =?utf-8?B?YktUdlozY2h3RnVoazNTbHkyVkpIM0hOa0FiNFd2Uk5FMnIvVVQ2MWRmUmhm?=
 =?utf-8?B?RnQ2L2Q0TFpmNXYrSDF5YlhxbTZTUkZ5UVFDTHlseVRyY05zdmZPZXNQTVZL?=
 =?utf-8?B?bitVd01WT1F4eWQ2cnplaDJlR2tkQ2d0N09VTEFKandjQmRIYWhWNGpvV1M5?=
 =?utf-8?B?SStwN1hXeWVXRmlZeElkYU5VNkQvNDJ0NjV0bzc2Sy94Uy8wZlJtOUZ2Z3NR?=
 =?utf-8?B?ZkdYVDJoQmlYd2krWFRNQjAwTnFrY1JReHpLZk9LVFpUSmxHT0JJTXA5cjFp?=
 =?utf-8?B?MExlRUFDY0NRR0ZIaDVsSTV0RU13dmJVK3JVVE1mSXJUTjRRZFlwT3d2c3Jl?=
 =?utf-8?B?czJOVVVmSlYxMFdUQ1QvWkFad09wUnpidEFDdHRJeTEvZUtwTlBhUDd3ZXkv?=
 =?utf-8?B?YzdmbVhENWdBcE9UZlFCMDdoNzJZM3BTWENsZ0RTUWpUNDJNZnZLcm9lOFdN?=
 =?utf-8?B?WldjaFNpeXdUaDRmTGlPeFVjSVJMOUhQU1FJRG9NMVA0VFpIQ0szUE5nVDJY?=
 =?utf-8?B?SXFQaGdEVDN2WHJuRVNJWVp6WnJaYjA2QXo2SHBKUHd5R0s3QmFoaXVNVjRX?=
 =?utf-8?B?enFDRkhVOVYvU1A0VW8zd2tDeHZqRnlvVkMvMHA2TnJ0NXRFTGlacDlOMFBU?=
 =?utf-8?B?QkR4c3Y0MEhPbklmTGk1VW1aZENpT2tRandiNUlHaENVVEhEZlNJYWZNSmgy?=
 =?utf-8?B?dGQ5YnhzcmQvelpGOXFacW5sMUdOS0MySmtWNDBtY1ZzTkpyNUlSTmNjNEFT?=
 =?utf-8?B?bGc1blBlUk81QnBYVVkvcE44R0p2SkJXVUc0MXBtSFQ0NTA0aGdYR2E0QXZW?=
 =?utf-8?B?WTJRT0s5d3FORnUyTWFMditkdVJ3UTRDemJWcm53RHl0UThBdTNhbHNXQ0Yy?=
 =?utf-8?Q?O29OEjudWMGvrKBTMHwWszFWn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35b56e5-f0b2-4921-f5d9-08dc1d958f49
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:05:37.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8tzZYAul/KoAws/aWQIx1A8yk9gy5jiUkWs7Ghgn7I8+mNfrgw/ZKEt/kx7gZW1elU5JLQAKpocso1dsTGzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 System counter module compatible string, the SCMI
firmware blocks access to control register, so should not
add "nxp,sysctr-timer" as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653dafab8..161c09d9e2c3 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,10 @@ description: |
 
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    items:
+      - enum:
+          - nxp,imx95-sysctr-timer
+          - nxp,sysctr-timer
 
   reg:
     maxItems: 1

-- 
2.37.1


