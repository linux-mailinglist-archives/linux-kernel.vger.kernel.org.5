Return-Path: <linux-kernel+bounces-83999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E986A134
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F31C24ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477014DFF8;
	Tue, 27 Feb 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNLZAZ0Q"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B914EFDF;
	Tue, 27 Feb 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067288; cv=fail; b=AVwySl7QA4TdVIhsY83ECGzvZ36kUnrYaDqQTbrf4ktHhDOGNo8IQGMeF3oHUQUQ8XSRNKkDO/4xuErq0woWwquGQRDHg2/Z9OFzrHtTtJ6EINSDGiPwQZV8ypFQcK/EdfvFGTB8qI1P+I1fkvgTVWHxGgNyJEcM3qC2Vlw/PYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067288; c=relaxed/simple;
	bh=s4HI8Ojwzn52qIyPEPjb/4Z6X7sx1GRcAmXZBXZtRgk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h5KPjm0yMf9itforfJB+aWdxjb1jQk5YgPxU325jIGBtDikklo8iOcTG6R0PkvxwnkXVwG352RYo1L13CMDBRytfJO+JOX8sJc0kxppuYgnELSorOgyn4vgOkQAMcYRvTsbIhnsU6AP9f0dPVbyuetYRDPV2rQKNQquoYpv2nZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VNLZAZ0Q; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deaC96hbpz4rmOZ/CblmafD++mw81d+EZrz2XJtRsjv0eA6vNzly/PEny4P6B3KQf9yPmdMKci3Py3mQYg/spjWFLPxhJPBj0XVgVcGiEitdNQINxhqzd8s9w8mL4fBaQ3rYOIk1wsZNNvFM+kWVgvX5XphPlcN3lasqLV8sq+zInaAWOignv2Q1ddNb2uyGcQjEpV4r5IF73FlTrTbwulMyFYG2i9DBCHhGx3gfn56XK41M6j/gHCGkiG46a6GZ2XyuMded0uKXwYjfh8SEW9Dq51hcSjYnP0XE2k95nBw7AbW5jC0f4cKJj9jWcWMEuPmIJJ9XkHKX+MDWs8K1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR4Ijr6u0JBCrc65UMDTrB7v8I/4+cDx6GnC09iiTMA=;
 b=i9DZSrt8XO1zC79NHN5UkuyY7jKX7k2NtFnFXB7A0ieGI6/HMcpgfDdEGE3G/mSUta+aEENna4A0fKCw/usFlrv6hhwGi5B1nfIL8Kil5QGx3IxmPdVUE6fpXsVWM9+QT58XT8stULIptLaKWXzBWX/dLGoFOHfxeXSI+veJDyhG1wF4UoH7+3i+gDPjDYV3vD0fTUcpj7YxBZRlPmzVj0xfB/chmBTCjAGhb/DLMuGbE9hCyQJ2iJxu2zPYx1ARm7jutkR47ewGwfubfYsKy5xxWhHctDpdDjtUQFyypJ+iw6Ddq/3jNrhtA+6/HQCpxP3kJwZUuZtSPo9njSYbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR4Ijr6u0JBCrc65UMDTrB7v8I/4+cDx6GnC09iiTMA=;
 b=VNLZAZ0QI4puhGf8yQ5+XAdSP7L/kY9E+bJkD1F0MLBwTk4XMa701fG/gabe014NHr7I3zCEiSBN0Z6/OEslHX4OrlZtjAW+z/baMYJbEuZbcotRCNuCaMdAc6sWKJZCX6AFEqA/2qq4Z0jaK42sMY+NjJJo+hJgWRT6Ob1HlPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 20:54:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:54:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 15:54:09 -0500
Subject: [PATCH v2 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-asrc_8qxp-v2-1-521bcc7eb1c0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709067274; l=1359;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s4HI8Ojwzn52qIyPEPjb/4Z6X7sx1GRcAmXZBXZtRgk=;
 b=5nKd8NwXkRdyZRyyj+LDIuJ0d8xJNhhygzkqkzbSMDUzL/aL08z0KBtWx3z0MsUeZ5zP5Ffde
 k0m7WwbA9DKAD8V6lKA65GADc7kYq+ko2otNPDkexobMDbFmwJ5glee
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
X-MS-Office365-Filtering-Correlation-Id: 927b9f15-7d95-4838-d22f-08dc37d651df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgmtbLHevvRI8Al2Nwzq34WXjU1TTzi/AYy6ujCPUBl3BHz8h08wE3b1G3VACNaMZNNresp4oGew3WgB76UNTYI7Vx1u1iJnsogbCQnmnTsRxyhHvUneK8kK+k5fxhz0DADCbyrDMc9a8X7dfZhpV7w3zMOobf2KpyfPDJtT7CHfLYUeSlDDMDLquH18GHRumoBCGu6HJ3Ao/E3YqrtqE/BTx87vhcL1QMaBcoGq9oLdGE7josqvnpDQ0w9w2kyHUBwdNzDh4iMHeBO97iv3F/Rhv7Ijd7aQGRs18bc6XaSqqXoUB9yOqS1NRO7RuCsXqsj4dMMa391APvDYQFY4u5iFeNzn8FiQmpHpXY/r/yLdTYuDhlPjiL97RyxVcaDEQYSlcsGpeyU7CE3NO3N5jt5DpWovgXmBElwlwmfUnM1cVotP0rAm/RI9O8myzowy+iS7HeYBgH9B2eT6ddCsDe/9qYAAsrXsQhvn+MN+pWL7zgdz8HKylD92vltyeVP90MzTdjIyj9JEVKwbcZL5wUAIurrARkCwuMps4igevokaeHUet59TxBU31e6y1k3iBVl8cExu2DB/cKuxmdd8kvHVhSvmSLiEcidLBusjJAyQEpMK/QeFKTtoO/s3BXJBbtVvLD+TAzgi2qHPflBbT/MPBcHP+6GUQgqmdT6KL/G34nUd59MT1FcxL4a//mSUOsESYtIum66yV7oiH7P3t64Lw3VFKJ8zVWwZsqyHB5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lqTmRuMXA0U01EclNjTm9xVEUyYmVWYlJURGFHVStOZm9FQXZ3amc2djFi?=
 =?utf-8?B?dnBwMUtpRmx0TGl2SXlDazBRUkhlRXB1UnEwcWQwTzlyczAySCt0NGtVdFVx?=
 =?utf-8?B?ZE5PMzd0YjZKeVcwZmRzaVdORzBldm1oQmZkZXN2cW5BMm8wNVFyMlR1MEM5?=
 =?utf-8?B?cjIvWEg0a0tXZzM1dnk5c1VRK2hFZ0ZqZXpRQkZ3clg2YURwdGVzTTN3Q1hO?=
 =?utf-8?B?MC83cDBjYjdpbFVtWXozaGo1LzZYenFBVUE3eXdYOGxVQTBMUFBRV2VSOGtD?=
 =?utf-8?B?L05PZ3lWbnRtMlVBN240SXg0RzU5SllWeEhhZ3A1aHJCVmFRM09oUGpZVXRS?=
 =?utf-8?B?c3FuYjlnMlM2VmdmcG5KaS9JWm0xcHNJR3A5eUluakRKRkRyVmRLbHdvYmp4?=
 =?utf-8?B?V1RGU1lTbk13NWdnNzdaZU1sZEpYUGpzR29XS0cwZjkvUGg3NXBrbXlJdXo5?=
 =?utf-8?B?d1RhY0VMYng2Y3FjaGZyN1V6OC9WZDFDNkozMTFEU1R5L1NCVFY0QkZHVGw5?=
 =?utf-8?B?dkl6QVluai8zTnFXVklTYTRZQ2QrMEJpSlVnT1YxYlExcnNDaEJhYk9WeTRv?=
 =?utf-8?B?SWFVRlFmV3BMNnl5dG0zYUxQY0NUWnNkMkdLRXNCdWJ2VVN4bjRyb2pYSExT?=
 =?utf-8?B?YnQxU0Y5Ly8va2pDSzFpQ2tDTzZ2ZVowdGZtWDg0QkFJOWNsL1FBUmljZEcx?=
 =?utf-8?B?WEh5R3hsbDdLRDRtTHJHaEswUmdIT3R4UStKSHBoL2tWOFRtVW1LWHo3V2U3?=
 =?utf-8?B?ckRVbkFSNitXS095c2Q2V2RVWkE5dUw5QkZydDJCaStaaXdUdGRlMStTUDlF?=
 =?utf-8?B?NkxoWmJZaFQyS2Z5bDQwOXY5cHNoUG0xRFh6YjhtbDNTa0Q4dmk3OVJBOFVn?=
 =?utf-8?B?Z3ZheGV1bTZqOSttL09lcHdVNitxbndIU2RvOWU5VFFNVG1FMzM2ZWpRR054?=
 =?utf-8?B?YnVVZWZLS3phNk5ZQ1lQaFhNaHpPSUpzaDFQMWJsWU5rZXJkOFBMNWJvOFpN?=
 =?utf-8?B?dWFESTJkZFVpemU0RkZuNnhRREM0d0pHMVJkZ1BHVmZGNWh3NHhUd0s3YkR0?=
 =?utf-8?B?OFlxdE1sSG9zcVJEdm11cys0b1R2Y2ZFNHRIcHl5Q3VUZXN5ZUg3NHZJa2ln?=
 =?utf-8?B?VWFEc2cwOThvQWJTZXIzYXF4Mk9SRjVQR3VYSVpZNWhNY1ZUc3kvVm8rSTlR?=
 =?utf-8?B?V3JTdC90Qjc2QmpFRFEzTkUwUmp6eHJUaUhwT3JDSFBVSkE1STJWYjNhZmtS?=
 =?utf-8?B?VWt4ZjVMM0dTd3duenpWV0FOM3hFdFg3d3A5cDQzMUhFQkMvWHZvMVpYbXJx?=
 =?utf-8?B?T0RjeS9wdEhlYThoemxrbkxhL0YzbWJwZmppN01SK3pHM01sOGtGbmdRclly?=
 =?utf-8?B?eXM2MUg1ZkdNUFFYY0VkVGlFTnhvZEFoWjN0dnllSEpQQXg4Q2NZSWdKekY1?=
 =?utf-8?B?YmU2ZWtlZ1p2M293TTlnZDRiUDRTdkNkN2RtaEs0V3F1RkJBd2lKRzZkRm5j?=
 =?utf-8?B?VW5sOXNoQWcvOFU0S0JIOUIyS2VmRURISDNQK2ZGd2JzdEZpcEw2aVV2dVdD?=
 =?utf-8?B?RTErUzZTTjFvWjRUSW1tYlo3MTFMMklCZzY5dURzODJRN2pxYkZDSFlKM3BL?=
 =?utf-8?B?Q0h6b0RjekNPd3dOSENQNGdXZjhjbXBMVXF4S1hQWFVNQnlOTU9MZEo2TTZC?=
 =?utf-8?B?QUVnQUtBYWpLUTBReFNCOGc3TFRZd2JZSmR4ZnYzbGlGNVBKVGFhSm9LQ1BT?=
 =?utf-8?B?OUt6cXhxOG9mTlhtZTFBalFNVzZHKzkxSWU2QVo5QVBIVmpidFUzQnpSUWQy?=
 =?utf-8?B?RkR2cVVJc2xsdUs0UjdsYVVRaTM5UFpSYUdBWkJGVittUWIrWmE2QVhFME9S?=
 =?utf-8?B?SkVVWVlRdU5MUjJvV1lDTG43S0FXL3B4MFlNS2VtWFpWU05OcXpyRWdnVXY5?=
 =?utf-8?B?VlF3TmsvaS8wUDEvTVhTL2xwby85VTY5cmNHL0NPWmllZXN0d0Zob2puOGx3?=
 =?utf-8?B?MExSNWlRQ3FiZWpOZCtaazJsZ0NEM0FkTzlJZnAvWFZOQVIxV0pOVnNFaE9Z?=
 =?utf-8?B?RjlTK1FlS2xONThWQ1JLV25EY3cyNVdPN3BPak90cDQ1a3NxZEJkcmI1QXdQ?=
 =?utf-8?Q?re6Z5TCvHFWyx1wA+5EA59gxF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b9f15-7d95-4838-d22f-08dc37d651df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:54:41.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC3XBBh9frCgnXDtoYKiri+dr4Uhvr1j73cQc921Q77W4Vunkoap/OrYsKqeeH1qnjvAJ+ZPQ8e+A5GRmCdjHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

Add power-domains property for asrc and spdif.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 +++
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index bfef2fcb75b14..98616507e3c10 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -74,6 +74,9 @@ properties:
       - const: asrck_f
       - const: spba
 
+  power-domains:
+    maxItems: 1
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The mutual sample rate used by DPCM Back Ends
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 1d64e8337aa4b..82430f1d5e5a2 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -86,6 +86,9 @@ properties:
       registers. Set this flag for HCDs with big endian descriptors and big
       endian registers.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.34.1


