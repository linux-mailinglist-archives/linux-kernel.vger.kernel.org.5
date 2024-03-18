Return-Path: <linux-kernel+bounces-106539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68D87F018
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D9128333F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4495646B;
	Mon, 18 Mar 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cr6J0V6E"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0756B77;
	Mon, 18 Mar 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788458; cv=fail; b=W7j91lIHqfsR/Go+sT0Syelde1tmo3zukkX0kXR3P47KvLetZv3lG+vzo9JO0le+cf+ew0+0UBKYgWGzvHFv+8MdoxmVSweqg+uzPytIvA5o1YWQu0k2sL/YuX/XDLxm/m7/geVMVa7PtWbpKHxD+VGUVUmXeP+D0aViJh4QVYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788458; c=relaxed/simple;
	bh=Cx+fgAZdcGrmwKufC+1dSp+tnHj6uqjwfSRMq+CCFMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lhE/YH4O3P3mRgFjuOAZ87CLjFZO8jbSKjyirCyFboNYgCWHXnH1NtJb04iXvEmL6xIIjuZVQaBrAJnMUHW+CpbMf1LH3zov/jrhPjgWqRv0qt+Aw57RAbtkThGpXJzxLAJGjcWy+cpu5xR5W/xynad7yzdR3PG95icmJYy1jGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cr6J0V6E; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQA5LyN1ePvSbeGzBVCUdCiwJNaZTx+I9t06+5UV4h3rSoKbAFC0okYZd9IuiFvtMhKBK/5pJacPg72igf/FiTc7TVA03VeJc88bBP/+8LX6R/Q+HUqeuozb/srF3olNsHcMPYjoCct9J1rnZbXYiaKPqmd4X+dQMXC5dtTigA8NM7ZXwfNl8J+7iz7dckvkFcGruIaiwDNwX5QMc1uz3gx5Ss/ly/1F/wW9n8Zr+wDP6pCStIFjCjq37MbZmAD5B3f1pG6j0DW7Y1UF4cZsUa57dvWrij8VxYR8hSWvfYDVyJUubWKbV/RCZsU1VkyfO6Mbr/kpfNgPGS3/0b4PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVfCUqBc3JRMpqobSR+Ca6P9QVTiYuggictDS+ChHR8=;
 b=Glr553fdl7PHzX23ljzjB6Kt9GrSk5UICe7jPEKNs14Uzytn73ZRvKlK1Y7RTsva1d+dnSTfB/S31W3axoq4+mgkqjtNZQ2sJrcSbDJu37kzlnWNWU3/GycdRcXvZdHAx4tQoIzLlolKCwhHs2s8xEPFAbBkAEoy6YIwuVfZ5lw1PCzcWCXVD8AbFEJapZuUauFdt1GrXPIgJaS+10+JaD9PJLLAUYs8ejARZ5qKuM5fiWfhP7E5EkUIIE/NlJs78Lq2SXlyXHYQAA4K+0//ygneq5lQbqpVwTOYIDnqE8bWTGV5t28OfZrjGWreKt6drGzrjhmMmPEEH7C+5MlpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVfCUqBc3JRMpqobSR+Ca6P9QVTiYuggictDS+ChHR8=;
 b=Cr6J0V6EGv7RjZRA2UnjRAsVSqPEHLbrA1oNj2bhq3OsOmfzKfnSZbyg1UHhv1SjqqgqdkPcNLH0nzZd3GfLxu0D4ulISgIChulSM10MFkc3c2SOM1Hx9o73mco25p6DaMKOQI5QE5v7W+5CkhZs1mA8KOjLJCzLlCKQ3ZtgSkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:00:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:00:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 15:00:08 -0400
Subject: [PATCH v7 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-asrc_8qxp-v7-2-01ce5264a761@nxp.com>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
In-Reply-To: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710788441; l=1349;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cx+fgAZdcGrmwKufC+1dSp+tnHj6uqjwfSRMq+CCFMg=;
 b=yLUwtZ/OjBsa6C9Ug32S83k68sTKya/iqjsxy3hlntrKB/Ycjhx31/Y3hv0TT0wCVZ2xrKp4+
 EiVnJdgEmy7C2rZszcNeP7BpNbfZoID7CNzvWgMjCYnLTuKVaYVpoUA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: faaee3c8-39a5-43d1-dbf9-08dc477dbc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OLk9NpeQfYRuQBtshoGwjf5FjmyVOEd3ls3f1C/aJ9N4+3iKBOz8GRJUIGqqHkaYgzzs8zC8lEbykysPf00ozzWz5p+w8GvbwYbmm7TQqtL56HYJqUUeC+YMqs6+3olQmgmzUXtwRlnGOI4C0xtu34o1ARHPVYVrGz7hkueT3r0H3AqoKj0m4lElB5hLpzDUTJLtBhs94YhIGeagRHyY8qZllaees6bITbIg7ZmH2+80UHk9UsxReZfmXtqq7/uFtuJGJt3SgTArWVkqnSPoygyQ8pvRfaVzTh2YZ7aUNuAtK6vYeqaaAvV5WdyzYQE850mSpJ8tsOY+Oh/7xGtPpVxm0Qhw8UZ14M1dzwWg4+ALsDLKHNhrXL1q76LattTH8tZzGP4NW1CqR2IpvX59HaFrJY6Ga4S2fk6NWVtHoYDaKxcB3v7cLhNOsHQDJTEzw3aDB0V/yB7m0vU/dTRch0EtCrqh6et0ekPJIg/elg7P4+U9HoRiiWbN+a/wJCHj2VcA7udrgbgtUP7aHd3eUfKuKIERDOdJ8ZSSUP1ekVOwM4aWbE/h7lAXxPsxxBF4kVmg0YvRWdQ+jyKXzzVjruSmfW4moFUZCp2fjSJjfLROhhVZ5WMAnPYTOW/cnBwh3vina83W71Jt6DafU3m9MesVZFrTaG8s/ahYVO+Ftia+Pdu56tq0wUH+5rBtXONIJOC2RaOqcQu15e/rDenlI2CizouOn+qTE5Bw3nS7ghU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V29ydjVqTlQvYWFobitRYmJyc1VwUlE3enM2WlpTa1pQb2pCNjFZbVUyTHNm?=
 =?utf-8?B?ZzE2WjRVR3R4ak1qV3MrcFliR3pyMjJ3cHBvcTIzUFUzUkZqbmgzVXRleGlR?=
 =?utf-8?B?VGY3QU8vMGdzWWVZWEN4NHQyU2swM0FuWkVtTldsUVMrUzdUVCsyN0V3eGRM?=
 =?utf-8?B?cXdPWW9STGEvNlVKMFRpY09hb29nN1FkRXYweWtjTDROVDFiYzQrb25nSHB0?=
 =?utf-8?B?WUpjNmw4R2xRTzFKZkY0aDBNU1hKZTgvTXloaTVDeVhjQ1pOaGI1cCsxaGpW?=
 =?utf-8?B?NXNiK2pBU3Nzb0JuYUdDVVYvMmlHalVTVEpYNy9qVmRIOVJCNXZLUUsrbUUx?=
 =?utf-8?B?ZVNldnk5Tms0MENGa3hsZXd3YWh1aVRjbm9oZHlRV2dRRzZ2MDVETUxCMGMw?=
 =?utf-8?B?U3VUS1liMVRCV0p0ZFdtS1VxRFFFTmNwa25BSzFmMmt4ZnNJVFBXbm5QVWJt?=
 =?utf-8?B?TVBrOGpvTE16KzFJOVlYVDZpUWozM3hZdi9RUWxhYnJHY1hlTERweHpRYTU4?=
 =?utf-8?B?NHh4L2RLNUorbDhHbE5CWGJUckdZWjJpcFEzSWhZUks0TG9Qci9yQmVVRXFk?=
 =?utf-8?B?blVJRHJiMFk0SWVFS0ozc29XNjhUNjZZUDE0NURDWklxY0RnRnIxNzY5ZkZ4?=
 =?utf-8?B?Rm85c2N6a21idGRoSGRheUw1WG03RVFwcWg1dE9yell0LzZxdjdHTExWRkRV?=
 =?utf-8?B?ZUVpKy9wNXJQd2lCYm5LOC9kZld0N3BzV2lZRkJ5TFQ5N2I5eDJ0dUhFc2ox?=
 =?utf-8?B?TW5QcGxBRG5pNTd1dWJrMkkxSmF5UjNaaUs0L0c4SW4ra1hBb1lYblY2R1pu?=
 =?utf-8?B?a0VZSTZ6MjZRT0lKQlJINUpGRDN3QkY1RnhkMWxMRElRZFdabTQ3S1ZPT05s?=
 =?utf-8?B?SzlpNXlYT1llcVNRcHJMTStMZ0ZCbFhzbzh5eHU1Nm9Ndk9hdnB3OHBNcUpa?=
 =?utf-8?B?bFlUOHNadWw1dzJQeDNIVWUxMldDSjlBYVQvbUJ2UmpQY2YvTVRqQzFtV1Rt?=
 =?utf-8?B?ZWtvU2EzQVIwa1RTRFY5Y0RDYTdITU16cnc0Mml6ZUdpZWlaTHQ3Z1p2L01m?=
 =?utf-8?B?N1lwSDI1MkREWEx6ejZvWGgwRE9YZ3hZcWdNV1pPM1ZpL2VuRHA4VkxVb3RT?=
 =?utf-8?B?MHcyN1piTXZ6Y1hHNXdZOEZaNzFhNlBLeStnQlpJa09ybWhhajk5MGIrejhj?=
 =?utf-8?B?d0Z4aEZKc3VqZXJaZVlYYzZ4VTNyeEdNa3RsNkVzaDYvSmtSYUErL2c5ZFBp?=
 =?utf-8?B?TUtqVG1RVEZkSEJ3MHYzNTB6cTJKL0xxU0VQS08yWmhmRjhiS2QxVGpZekhk?=
 =?utf-8?B?bkZmUnFwcUljc1VnMHN2SFRxWlJISVJKdDNJdjkzbE5ka0FxSDVLSGV4TGlS?=
 =?utf-8?B?UnJ2YkJDajFyOTM0V3pWTVY5TDlDT3ZJVkhTc0FVaS9maXhyeWUvSm5LdnJt?=
 =?utf-8?B?TExhRjc5YjZIemVlcGhKOXpYUWNqbzZUcTMyUm0rZDZORi9uQkxsb0VhaXlC?=
 =?utf-8?B?R0dCcmJ4cmlObzBKZU55UTFHQ1F0RlhjRjVpcXN0eTJQQzZmQmt3aDVZd0NI?=
 =?utf-8?B?dHQ2c3h1ay84dks4T0ZWMjJPcTFsL3cyb0wrcTYydkQ0RkFmMWNFUE1qU29w?=
 =?utf-8?B?a2lZVTZhY2RBbENMMXV1Rk53bTdtVm1xd25mdG42SUZsUzRTcmJyMzRVN2Zh?=
 =?utf-8?B?YS9WVVNCVEtwMjdoZ2pWNk9MTHJleis0OXRFZGJ6RktINWtkR2dBQTRORHh1?=
 =?utf-8?B?Q0E5TjVwbWM3ak5jK0N5OENQN21oMDdqY2RnTXBaK3dzMDNaVHQ2QlhrdENB?=
 =?utf-8?B?TVRkTVVvdFAzSjBPSXJCUWVOL0ZHTU9RUzhMdEVPN09CdGovTkdKVWlST1R2?=
 =?utf-8?B?MXBhY2NYaVdxVWg3Z1FEUXlvN1NiNXRTYXVHQ291ck5KMWpSMkk1eHpWTy9W?=
 =?utf-8?B?Y2ZkanU0NzErcHJxd0pUaU4xZTdlNHRaL2tkUjRKZXF5QTlFNTAxSW5rVERj?=
 =?utf-8?B?WGZaQnpxcnFmU0JjaVdJZ2pJUzlDVytZZ0J4OEFjRUhuVWc3UllWRTUyQzJD?=
 =?utf-8?B?TzBGajZETGdCTVN5UFkwYjduMUZrMlYrY2lIVmdSY1dqZ3FzT1FxUmYxL3N3?=
 =?utf-8?Q?kmPY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faaee3c8-39a5-43d1-dbf9-08dc477dbc30
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:00:53.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac7nK+BKhfPucEZTpVJnfmP/L8V9knE2g/sfGQcfMZ/ttF5GZNe90KsMs6qpt2tX4ELNLZtLlgfVYfTiBtYKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 56f8c0c8afdea..204f361cea27a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -31,7 +31,10 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Combined or receive interrupt
+      - description: Transmit interrupt
 
   dmas:
     items:
@@ -101,6 +104,21 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8qm-spdif
+            - fsl,imx8qxp-spdif
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
   - if:
       properties:
         compatible:

-- 
2.34.1


