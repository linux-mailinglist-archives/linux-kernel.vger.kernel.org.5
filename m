Return-Path: <linux-kernel+bounces-48812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D41868461E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F0A1C23460
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF5128809;
	Thu,  1 Feb 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSUj323o"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C125128807;
	Thu,  1 Feb 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819003; cv=fail; b=FGT2eCjDwIo4GjMikh4t/Gal1qWqK0srsje7Gn3o4qp2SGP788kobbJrDsYI08wueEzI/nU68wGbGZWx+iHz1aoGdYpHHKeEOqN1/wb47o1+moagKX8P4L/0+s8DSnuSJ1iC+1RV+k47XhnsCV9IhFaAVk8s0nvMUoeI0fJbOvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819003; c=relaxed/simple;
	bh=jpnWM8jiOwNWekltzEGiRL6AfuuR6h8sp+0ntVlnnXs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Dz+NdCaus5heS/IvL+8Meq+TC4utMAAliZUxpkGc5U1L/PGcC/H0CSNBh7uc8mmflMmjwC8HNjnGwbjQiWSzJ8EprU7uDjj9+psrkaGlKG7nHw0B816NPLsCA79LvoHweSwlktXuGL6BM4QEq/vfZH7h4BBSt3xpuZzekyuwXeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PSUj323o; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwpcNIRyS+3fKHeXpMkuN583YaeEdRXVtE9Dk8HoUWERjvhLn60yqetcSpdKzZBnO4pBVlCRDF12gv8HjsuaJGWfEWZovnN0z77yPFUwKp5n0MByZZKBYPHJRll3buscRzm22/p8LTXVTF5gEiuXcWyNuy2XEMjOY0kAQAGEJKQp8EOd+hBCK7t9bH74n/nqawfnPJBPfOGpyjPFcZD0t2Gbzzhe5hnzgxQugIHNidGbz9x/O8kQtuveVqcnkUHOYc0HfFNlHWaVQM+duShb5L4dQFPJWwBAOTLSeXtiv6kkw+6/XGy9B7W78y2WzhWZwIs5Eb564lANTKWmOdtlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMfys3ace7tGXX+z66AA+VcVmClW2umobocT4FtDmOw=;
 b=buLmror/Kfuxi4UeqBsmRfDTh8npQRtCfaSwu6gQPdaIe8HjIBqQP6RpLejfv7jRbX1MTIALmTdMTRqli4RVI889fSewVNUcZARYFui66HDToMdN8HvkYq0foKl3iYLX4eXp19ckHnbrdl9SjQou4hX/t36v1QBbmkNx62YKZFY7iRZ0HnBjOHTicpPtlOyXKzOu2KdyVQh5FWoQ6oIOayF59mCIoz/Xbhy3QPmhhXJiaRKBhVgpVVUZEZzW3/Vd4uXRFOf5GsprlkPelQAJsfxHe9CyHl9+F8wpgyXo0m1ZIs3ogF4i6CDiHK6Opovi4/C5AAuh71GW5699kPXgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMfys3ace7tGXX+z66AA+VcVmClW2umobocT4FtDmOw=;
 b=PSUj323oLXmAI/5a/IURm2+xO3Q8jRYnglbTpQOpKdmSV9X5YD81mE9RX9eCZB3+EoZHVsVup37t0eqWl4IVANClA4pBdTDoN7zmCBCmgARnLv/F/JcInnKWYvvN9nRvC9sViruw1Nmz6LSNpjfsrX7icfwcz0hn/CkUJnXPKls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:23:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 20:23:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 15:22:42 -0500
Subject: [PATCH v2 2/4] dt-bindings: net: fec: add iommus property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-8qm_smmu-v2-2-3d12a80201a3@nxp.com>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
In-Reply-To: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706818983; l=710;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jpnWM8jiOwNWekltzEGiRL6AfuuR6h8sp+0ntVlnnXs=;
 b=i12JwjxSBJ7kbhzr4wGoMJTqJOEnsfZF+z9K6IFO9ckEzOqiTbRhsObDptC2aAUmhzp+CZHJn
 MgQ4/RWbBJkBlsolB+NlBm8COgHHfPV/Fn/UY5RBUrg1Geckq8/bVqM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: ebadaaca-7853-4162-2dde-08dc2363a111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wt0cFHj5dXZ7ueN+jWzQEJinP+Whw8XaNwHGuaElCznBCKeEkaiwfvCVKvxUz4BfjbE/Tz8+LHQ0neQQu3zXaAdjIQ2eycd88i4d3rFjuvYRk2QWHnaemnNee/gf8oxGwDAGBFgUERG9ZjW7fuFdGlxGMr40ibrJ5KG7ndqgkS1mjXufi9o1tI+vGOgfBzU8f/L4hUO25iRTDeSEWRswBghBUjN80kAbd59dPtb9RL7DrXlYorYnyb9z4VPSIWC9K2cbQ/g01ab09s5cppQH4vsPmHHSTYJPGfi/w+PnT5ULTI8jbuut7Ccp9gO+A32z90PPBYsfL+SJk/Jc0xFyxs2g5Fy2wjMXbAGHBQb/MW4MsPiJ2nwnlsLBlyfAY8TAQVmdOtr02SMKPJATpM4gxmQ94Qt/FufHZnTFnrwoscXr8nC7his+t7SyvUphWTvLXuBix6oIairI0dYnz+YJmCmfkwOIZUJXkEOnGmGpLo8PKo1jSeFrgLp/WRm9i25yha1KlTSBsC7tX/bnRNjVXBoe1gblqHiLk+oHvocSjw/+hIk4TEVELKmI2LMgigq5R8etGJG8vLSv97fcJpLz+4jHPH4eE3bp86P3smdTTS0F7HgSPwapdg8gPmoe/QH2qhmse1RQofwSdagPFHigvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(921011)(41300700001)(478600001)(6666004)(6512007)(6486002)(6506007)(316002)(52116002)(7416002)(110136005)(66946007)(66556008)(66476007)(36756003)(8936002)(4326008)(8676002)(5660300002)(38100700002)(2906002)(86362001)(38350700005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS9PRXF6dHhBZnBqR0N4M0c5cG13V3R3ZS9FTDk5L3NyMXE5SXJuV3RHK1g2?=
 =?utf-8?B?UWQvZDB0alpNNXViUGdHanVRNnpISHRaemdONjI3U2F0UlhqV1dGTGhlQ3Bl?=
 =?utf-8?B?aDFyVm5iZzRicmYrZVp2SG9la1c1MDlqWXVhdVA1ZElMaktsL2xFb0JTdmY0?=
 =?utf-8?B?bG43TmZ1MjhjSU9IcWkvS2gvQy9EOHMwSVZKVHU3WFJTY3g1aEdCOFpqVE8r?=
 =?utf-8?B?S2JCTm9QbXIwcCtuUGd6bTJQZ2xRdkdUVlVTM2JhTDZQSWtGdDc1VUtlRW80?=
 =?utf-8?B?VjNWNjZSQmUySW5YN0ozSGZxcmJxWFREWG5td05LR3FKZW9GYzJmbUtmQ25Q?=
 =?utf-8?B?M2U2d1hmRFg5dnhTL2dVYlAwYmdTUFNCZmtRSDUwbmRSelo3Rm9POFFQUEFC?=
 =?utf-8?B?UzBUdm1LQnErMHpZeUE0bGhuTWVnTkdIeDdqMytBZXZ5UW5YN0xncURzZVhS?=
 =?utf-8?B?ZW11WW56blBqajNUeWQzNkU5WEdETi9zaUIxdXpYVGFyc0NQc1JVNXZxekxs?=
 =?utf-8?B?S2EvWmZRNHR2WXlmNXQraWZPNlpuak90cVV2eWtOWXdDRmNQdkdvNW5ZSFps?=
 =?utf-8?B?YktNYWl5WTBYZ0pnRytjTktrOGpQb0s0azFYcXJqMWdvOGw3T0pNYjA1dGFm?=
 =?utf-8?B?VzZpdUs2WjZsRkprNUFXSzJyT3NQTExoYTJCYkRHOHgvL1hzd052dzRLR1lI?=
 =?utf-8?B?YXR6bTBKWnN2M1F3WGRHZisxL05rWWc1U21ZWHNCcVJhNVloWmxpQkZidjdE?=
 =?utf-8?B?TVhZYWppMzVUemU3OXFsTmRWdU5uN2tiRWZ2NDJ4WWI5eHlUTzIreUZTRHA2?=
 =?utf-8?B?ZnFkLzgxN3N2eWhhVGtzd09iVW1TVi9BK3NVSmlPYWVCWG1TRlhibjVQR3Q0?=
 =?utf-8?B?U2g3amsrcVFvbzNMRmN2RmtCa3dFSWtQM2wzYm14bEE5MmtEMkxYMk1oTkpU?=
 =?utf-8?B?T3NNdi83cVdYWUtYVm1tR2E0N1VROE1OckozaTdCVGpuQzE1ekJOS2FjajBJ?=
 =?utf-8?B?MUp5aFUwMWltS2lxZUpvWVByd1V2RHhFNWp0WjhEcVhLQ0g4cmxDdkdkN2U1?=
 =?utf-8?B?RVhpejJLbndUWUZpWEdLUytIVjRYMnN0cEptOEU0SmVJb0tpamttUzlhWEZB?=
 =?utf-8?B?UG5ESC9GM2VZd09oMSsxalFwY01TS3JYQ2ZNaVFkMFdSMG9BbFA3eWpOWlV1?=
 =?utf-8?B?dEF5WDR5ZXc0UTR0aThvS2ZtU0x1REJaeFZRR1pHU09CZGJIVU1UdGJidmxV?=
 =?utf-8?B?UHg4Z0l2UDVnNUJCamRVd2RRaE1yZnpLa0cyVDBCMzNNbld3Nk1QTDZjekJQ?=
 =?utf-8?B?SXBqbVdKN2tVc0p4dE1tRTdQblZ0T0R2WWFzZm1MSFBLWlRsMDhhWGVzM3o3?=
 =?utf-8?B?ejNSaGp2N1N5Q2cyNUZSYnMyL2Y1NlJMc0dEVWhZdFBoN282RHd1WHgvUndH?=
 =?utf-8?B?dEprZXV6ZnRzeWVYV1JaRWZ2MjZXVTFyVVFQd3QxWUtzRzVyRE0weHgxV1FP?=
 =?utf-8?B?akdKNW5selIwcW5lQTBXcER5bHI0eVZYeEpxRVJ3YVhFcEw2aHhYWkw2aHJB?=
 =?utf-8?B?WWppTWsrUUJMNWZVUDQ1K0VQTG05NHNCbUwxRHVWajdBVFhpaTdYZVJzdmJC?=
 =?utf-8?B?VUx5TDJUTzlBS0NZRVNkTk1iVEhBdkJzblZuTFoySWg4S29oOEV6eVV1cGRx?=
 =?utf-8?B?MVZWczR4RldiREhWVy95UnZCMjBjMEk0cC95Y1hhNEZwRVIraEhwbEFZN3c1?=
 =?utf-8?B?RGRlTVJSUUcrVXlUVW1YMWFVRmZ1ZEZJbHI1YW1rd2dmNVNPRFhHT2FSV1Jk?=
 =?utf-8?B?T1M2MjR3NGJMRlBBZkVuaXlYcHlxNzY5L1NqdVBwRHFwV2REWjBIdXZjOWVq?=
 =?utf-8?B?Q3E0UUdWdEVXZzRpSjdTWHJ2WnVSbDF0TlpPYVVncUZVeVZQTVM1S3ducnFD?=
 =?utf-8?B?d2VnNlRpUWZzSnZpRlZFb28wU2MxbmNpMVFrNG5zRmNFRkhBUVdMdEIzVXNI?=
 =?utf-8?B?WkV6NVVHWDRUMm0vSUMySi9na1BxREtBbVFuVCtlY3VCSWxxdVdNT0dqeGc2?=
 =?utf-8?B?bkJ3U05DeFhQYisyekx0NzBjcThrVGtrUkFNMHFyQWFKRmVCSGZqTWlYaE5T?=
 =?utf-8?Q?voXGwfR154v0V0jHKlmpEVeMF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebadaaca-7853-4162-2dde-08dc2363a111
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:23:19.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN37BiQaZ84XkYVMiteVinnO+jZGf58N9KRSmMCoIPWEjyaKz4lIXDjuGKGGUhIDtUzarRqrKz4NX51xh3xP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

iMX8QM have iommu. Add proerty 'iommus'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,fec.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index 8948a11c994e4..5536c06139cae 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -224,6 +224,9 @@ properties:
       Can be omitted thus no delay is observed. Delay is in range of 1ms to 1000ms.
       Other delays are invalid.
 
+  iommus:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.34.1


