Return-Path: <linux-kernel+bounces-84001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFEE86A138
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518FE1C25034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B7150994;
	Tue, 27 Feb 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtNVoj2L"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8E14F987;
	Tue, 27 Feb 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067293; cv=fail; b=Wxmh1GJosXB5/ICaPDktR7zyWOkStTJDSy+YrQJR1kKrqbQyFjG9z3bkWPEOWCff616ga6yKFOeM22i52y9XXXHP+nogwYKga4nevC+vBEIIKC/e5V4dyvfH27Hscj0xiLUHhb/ia9luF8gfH3uDYXLD5MlB12U2PJ8lxcL9zs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067293; c=relaxed/simple;
	bh=Zr5TShgZiJta89p9a8K0vtH/7bUq8E+U8vmOaScyf2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YphTQEIf+69NJ8JBkmkGGZMU05DYXb5IGOVy8qJ9S7i6CZvZNYAFjUvriuj3ie+N0oQelaz4td6ZH5u49OJy+9EDgRqucNSk55T9aFZ/Zxph27wYbb6HNuJgxRHkiF18dupv9eqoT6JSI+dwGLStFhr6BjX0pKokmmT0okQRkpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CtNVoj2L; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CijGUOuSLBQMHcrutdLp+zZ3FgrJ3GO5wmsA6A6qC3YqAJHscqQghjRNAfCWXdHZ5UuWCwEUJmBe8zFMaICiRMTtvGr/GBEhNw8SkDVipWDZawp/Ps0XInmnzRYDWxDHvvTELqcwNTFuBoLS4sLO3+PJydAjRhh9Kz82+fzzvNneNn4cgtWSUuTFcONj4Vc5M0teipUbjWBZe5pX9tAWcJJfEVv8WCdWbeXLxS/P1xc2a5jzA3wj5/cgWV0tJqQyvAFAEPxsVbR5v+s3EkcViwMSclJvvYrMRvyxnehNk/iNXQWnoVCB5GVGMUVVk+RPBrWkEgH739MQWbIfTG46/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skl6lRl14Qap8DvLKPAl02WhkmMYsRwEI7aKW/j1Zs0=;
 b=CkU51d83z+fjJK1AYSGgzHsmFzk0pQ7gHd0pqdv7mgwuXXKmHduBHo4aELahyKbURpOC4O04iauO0LkvPV/v4MYTOH2OJdwmNAEhW81SgAxbyx9VhgA9hkMK11bSlHdAEQWGnaonFg6naWM7vZmBqBxqip+M3R2Nw/YstGpLaILokmg8aXvAs+wjXLN3B/VlmlQekfGKlsqcqqyv5hP2AP/lieK0+iL1nN/mH19c0TLJj6FG+mANanZGFrC+9FPCZoK04TBV0u8/76tGt8NmLlSYi90CGTXk3J1mOFMhIlr8t72Mrjqw+QdHgVWsmatG24xWmeLDl/7/t/X01wW/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Skl6lRl14Qap8DvLKPAl02WhkmMYsRwEI7aKW/j1Zs0=;
 b=CtNVoj2L5i1jswdph1PxBcKz2jl0l4bCq9jlob5f/5ZzDEvMyibwplS4lV+7bAhGNuCFZ1uKiB2uj6TnofoJyErkL4cwltI7BDI6xoNRYqUXPEgQZmIcwYJIZ/MY4LjZACUc4JYC0aDa8c+bDiyzVdajTlEZT3qxgDY8Ov/he0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 20:54:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:54:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 15:54:11 -0500
Subject: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
In-Reply-To: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709067274; l=938;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Zr5TShgZiJta89p9a8K0vtH/7bUq8E+U8vmOaScyf2Y=;
 b=qIXIkvEEJLjFUSIph/s/46TFmrsyD/KLjyWjM4PJmRf2Vyl289vaOgNzHPiuBHbmfTg0qGcDj
 e7H9niyHM6BD09znC+9Uh4hdkE57zYwDhJAjntmyg3Zh5CGA4K5kf0B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: f33a30f6-16a2-47b1-61d6-08dc37d65661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OzGT6JBfV9yAgaExqBQdvC4JtoRJqOsKKEPC+/tdXgeTjGOk6A5Ekf8o9zmVtosdF9Md0qvZArnWMiIenD7yjyae2MbDysCKRWI5R14xNhqZXhLfHHcR98YOufmYj3+HqOqGrY0vLg5L0GovQiwz8L+TGqJDE2QIFwjWcabMKqe/lOqd9HDx9ZbDsf1rQ+vPpSrle3t+4TSwpfAtbFIhAakEjniqkPjJQpWSN/tC59jzydtJORkTObYGSnL66H/+LioH7wfGiQB0UpJFy+N3U/PEFPEXDKjwt0utn+WbgUkDjxxuuBr05kmPkxEpxdRai0S7VCueXvxJt/qFIvADpcTlOqh5AsAQmSJI6Ct8XxPjgoJtaqVbI098/y7CRRnEB+hiJdvW6sKqqdCZIDrF7D1xSNjDXbytma4wTzqf3efT9ki5UTWEjWQtl5i+pR6+VlvYn4gBYKyUDGhNFeTXNpImuKwCrofaVt1tUbueGR270n7GRaB9lTVURaOnlYEp8LqYGmAxtFL6mW7KQjerOA3s0TAwCrBNCv6Bka5GazXmd3b+eFBOFA1KhwJNrEJ7NB6ym+JeGOaNun5s4haVVWdyXrY95kSt/322a7FVeMLAfnJuiTdjSutnWF80zectENq2x4uEtBWb6mHvIlgb2GTXFapJ6Nuz/flG2/8ALKBYBWsvKpma/axw6JICzOyQpQ2H2nOMGMbasp8spYfr+l4urIWMfZkk2e1SirFp3ec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUR4b3ZFZ2xjc1BhblBTSlJFTXR5ZGpEM09zd2RCMU9IZWRvcFA0a2VrUVRL?=
 =?utf-8?B?QUhGSEd6MjJ3bXVsM0xDYnowaEorL3FRemhESEtOTU8yTVU1eE1TcUtHN2VJ?=
 =?utf-8?B?RXQwY21nUXNJaUJuT3NVOGNOWmF0Szhic0xZQzZpVWIwOHh4bVBqSzVLM0Vu?=
 =?utf-8?B?emxNM2x0UW42UkQzbzlWYW1xTnQxOStoT3JxTUU4OFEwQmZtLzRqc2RzNjlz?=
 =?utf-8?B?Z0ZkaGhiMnR4T0lnM1NZaC9qMzZsSmsrOGMzRW9Ma3JlYXg3cWI5RjMxeUo3?=
 =?utf-8?B?bUt6UzR4Q1ZaMHBRTC9yWkhTakRYK0MwM0MvWklML2dDc2ZDL1Q1VWJkNEFn?=
 =?utf-8?B?dUZpS2FxTUdBbzBRSFBOM2ZBWFB1NFVpQjE0ZVFhMEw0T3lwY2g3V2VWVnVR?=
 =?utf-8?B?Uk84MHg1Zk9FdW40OWFSOGpHZU9ER1E5SVA0Q0RMUVJsRXdTajRrbW9xL0hU?=
 =?utf-8?B?L2p6dEs0V1gyZ3NSaCt3VkMyUmRHOTM5d3Y0MTI3YlAxZmx1dDRMSUVFeG5u?=
 =?utf-8?B?eDF1OUxrendRcXBmcFBLVjBBUVlkTmRiUkd2bW02M21VWi9XVTJNekFlaTlX?=
 =?utf-8?B?R0RPUVZmVTcvVnZmMW50MWVFOGNGSmpOUSttOUZOd1BZcmNEWjZXRjhGKzlQ?=
 =?utf-8?B?YitNeUdBdk9JSHV4VlZ2d29meTlSdW93UDdjMWljMXUxbmVEWlNOLzJ0T0pi?=
 =?utf-8?B?TlFlU0toTVR2Qk15OUN1TmZGdWllcFB2TjJObE9IV1ppMSttOW5HM1ViTnM0?=
 =?utf-8?B?clMrdU9zanl5cWRjcG1OdDVmaEZIY2dEcExZbTlUNjRHa0diNkpicjdxTi9k?=
 =?utf-8?B?ejRKUnJqcmgxbHp3MTBxUzRLMmplNGZRMlBiaDZiTnJ4dE1tNFU2YlpCMmRY?=
 =?utf-8?B?N1ZBVkJJMnJnRmZlNzE4NEl1TTJScjlRdUpRSDJLWTBYaVZXOWxSZ243eDRy?=
 =?utf-8?B?cUJrOU1keEdQL1Jibm9qQWtXUlFEcUxZeHlTci9BV3BLcWVxdEdLdzNaZ29U?=
 =?utf-8?B?eVBURUY2OXJzUGRQR1RaTlpWSlljRXdwUklpRUFJWlhaSGlIbFphVmxLa0dT?=
 =?utf-8?B?OWFWbXc2VGRndTRreWh6Uk1zeDJ4bXdvaytyL1hNWUVibjdTY2ZMbEZML0lT?=
 =?utf-8?B?aTNHZ2pUNE00ZUtLOVJLbEpXeXd0dlFReGozTWxWa0FqbGpEN1RRelltdnF2?=
 =?utf-8?B?cU1mWStkVktRNEVRb0VGUVNDVHE4bUtaRzRNdnA1eXoxenczSGFtZC9mTWZx?=
 =?utf-8?B?NGZXVlJpR04rSjVhWHhBWU9xemdCbDkzOG41ZVYwbjhodEVXOEN3RzR6Mkdk?=
 =?utf-8?B?VGw5bVhBQUxCVWk0Nmg1VDZEUi9RL1g3aXpON3dRU3V5ZHJmNmhETVd1S0Jo?=
 =?utf-8?B?NDlWcGdhVzUzSXBURm8vd1MxV3duTE9TRDRRaTVHaFZBdE1mUmE2ZkMwODd4?=
 =?utf-8?B?YTZVRDFxL1B1VGV4YXUwSkJ1Qk1DeUdvUjhaYTlZYTFlVEE1WlRDMU9lYVA3?=
 =?utf-8?B?OHV1aWhXNG42UVdCc09BY0pjcGlOMFRwOWZQSi9ab2V2K2d4Q0g3SUR3Qkg5?=
 =?utf-8?B?QXU1eW5kTGhmRm95ZTBOUFZwSUtGa1lrRFdnd2MzMm4wYXVSMGxsUFJ1NmZ6?=
 =?utf-8?B?YmI1SW5BWFhyVEhpN05aYUxOcXFVNGkzSWlVd29xcllVQmZlYzBPNzZkWTN4?=
 =?utf-8?B?Q09IclZjQTRKa3lBSVZUTjd6SlZISWV3cTF2dWNscnFuUkphUEpid2hrODU5?=
 =?utf-8?B?NkZkNllTZnJmNzBqeGp6OE0rMGNIOXAwK0MyOVVwOEdSUVh5bkVQVFd0UE96?=
 =?utf-8?B?ZVhqMi85NVh6TWlNYjFWam1LZXY0Mk5GUnlSQTJ1ZGdwbzdmT3VSR3JUZ3hW?=
 =?utf-8?B?T1JtQjFOazNyaUZWWlZyck1YOXJJZUN1NE41dTBYbll6cjdGSkNUMlM2UUo1?=
 =?utf-8?B?UUh5d3V2b0FsN2VkMXZwaHpVd3JCM2czQzl4bEJHL20zUE9vYUY1ajNuUTlw?=
 =?utf-8?B?L01lTE1JeW1iMHFuUkMycEJoZmtVdHk1d0FtdUJSVktzN0J4YWNYZS9HdUJL?=
 =?utf-8?B?ZnY3WjVZcVJ0dkxiTFltVWhmUjZhand2eklKNHQ0bStRUnZmSjVCaFcyQTNB?=
 =?utf-8?Q?hL9+BXpKjtcUS8Qv2vUNcuKjd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33a30f6-16a2-47b1-61d6-08dc37d65661
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:54:49.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpAZjjRLW1LUMRYnRNQ4BhRDIQWhJbmBJhENQg8DWaThtX0ErGJjMKUTLSVx7fJVQOqeuX5EurhbvvpOrzztMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

Some sai only connect one direction. So allow only "rx" or "tx" for
dma-names.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..0302752d58a2b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -86,10 +86,14 @@ properties:
       - description: DMA controller phandle and request line for TX
 
   dma-names:
-    minItems: 1
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: rx
+          - const: tx
+      - items:
+          - enum:
+              - rx
+              - tx
 
   interrupts:
     items:

-- 
2.34.1


