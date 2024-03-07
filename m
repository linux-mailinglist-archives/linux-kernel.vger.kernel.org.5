Return-Path: <linux-kernel+bounces-94883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C887464B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC201F2417F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA046AB8;
	Thu,  7 Mar 2024 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="skoWgE83"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D84C8B;
	Thu,  7 Mar 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779683; cv=fail; b=kllcfgH8skUvKirHgu9PlkWUqfnxe+QC9YgZwgcJoKm5E1A1JAgkXMHBEvvN3CcRiid03zM/kHWTcPHJ0R1evd9GSSSrYBn5G+ZIElyguxrqBIfScbnD5aSYve75o5xXFi8jKM4enjYooYFOAgtjasfMuWx4D/0ioPTyYUtBYjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779683; c=relaxed/simple;
	bh=Uo5KZxuovzy3QKVRZZGolyKjlWeSmNcZp1z1Jhu4CCo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UsmCy6J3+T8PI8YOSiJ8xVbUxXT3D5Eg8EbM0MtULmQCmuni9hUwkrRlidyeY0uQCS6IUM6wEpUO2aaINAtYjylJ/dnaP3qYtIeRG1kPmkCHGxdV28i1AEx+kgEKKB+g6O7gqJCzk8FKezh6W6pylCeDs2zaUpJ6rgh4i0CSN/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=skoWgE83; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq/Q1TUWg+Rt+mYpJw/g/c0zpPj1lPYXGkURkaLI9wzyCcljBf/icl6ZfLEDNrWkXuOx7xV328xuGv5s6881FvxD0wAbNLZGXkHuyD8g2DgmiSZuZikHfdy5TNXfyf8xS0WaDdGPmeXdyLtDzfjEGmqSkDyrO8Vsmqf1TBQNDDyphs/BSZtdYJ5Kjq9zAfiFSlei+fMEIr3MAh2C627qrZ7Lyq5lnK4/rXVoy+AHLJCZmjxCQt5WX+we52HexOybhrV6QxqKaRxT0aAIaxBxBjFdOfI6xltl4sTOQe+MXwOynuFV81xwZvtU17CCSSKmlJynD8dBXIK3y9PZYyEL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daADBYoLpyfi3gTVesUrgMfOc3sM9N5CfKz3mR+j+/g=;
 b=Lqy+FVgfNHwTg4JioLhQO7ij6tp6qgw4mzgLIH25h7I4lgO2lYeC/sxvkCB5mBqzqXflnSKMZ0mAJRGy9mBRnlhxQTH6UuoaSrdeu4BpJpHtsG94SOeMIb2yAofRzDEOC9idFtVTQoWh3OHRXW1bpu6ssXwZcK5citehXQ8xe8JlaDPNuH0w7G5FjOwuSzr+BrZS1KbQphCV1p/9MWg9VnTMLlv2hPI83n6bZXBM+igMkKCDyWzLwubFEyeto/1l7vw1SJ87ggETTymjAVguBblbYImHQ6AZkb5gxJXODoPttp/3XAgsS0FPQxugI85VafDOV6mtxH90/E3zIri4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daADBYoLpyfi3gTVesUrgMfOc3sM9N5CfKz3mR+j+/g=;
 b=skoWgE83iN3xC58PV/DR83mlH6LOWVsDaCpU843zMV6/gF3uRdUhlQwVog7T/YJTMbnxhD3/9Bb2qwxdzqcb/Z+XHsWfRRaa8/hHkVZkTic6R6EWFE2+q1r2bYZeFG54WiNnHkOeeQxZJ+778mISb7P1NP+BHaZUcyrfRTjk8KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 7 Mar
 2024 02:47:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:47:58 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 1/7] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Thu,  7 Mar 2024 10:47:48 +0800
Message-Id: <20240307024754.3469810-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: c437633c-c45c-4d50-1037-08dc3e50ff2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q25fWkSa6utcxDVlW4oGMCvz+hYTCM5v4SvN6oVa9086kkeebztfIqsNzjHGcgA7zPs+olUjeXHvUCgsmZs4aUnmvsa6ldqUX5fcsKIPU6taOZV7JPMuDl/KLRuroZ+sDbTEbz6nJfkhTy0nm2L/FmEVHIxmPUDcCqM5Jgo2LjBi1tzccysM59DAX0ficfyBUuOuWbvqQeYdu/KR1Gt0Z0YBjM1VL5GTFRvaom1DD/kWV9M9ONqCov00oMthv7HMtmn3TDm0CJG8CbeiwAN0xNuGH7vaMYGAlKexISCT9JTcXb1tbFFlb6uRhdBIMnvaq4zx6CavsQLHb+7tUqQDIaaYnBP1mogyxC1oKorIRmp5C+Nnejz0VvHUBlm9rmMbdt3cja/nUFBm9IGo4kzBn25N+FvmeLKNx3peHkkZ2v9OLi78LXmFfPIOXy9w3fvAiGIYf9AOSxjpJLgWqTTxJ2tJ3Rgt0s8oh4GgiPWzZ/kXWuZmiTIiCXwGNVRcFaq7mJpIdwcrjhLubjTe6SPrMYtDHWnPDj2cfJu/BpkT+Q9EOdRfhA4VkSpoJ5pgGpDrKdk73eWdncYAmrHO9HTVzBdZ4bhZCf8WkWflNUiNGd4uIrFXlyLyCO0ke9G9BCctiFCC3BdF/eCfqs0aWcViQxhz2wJin9rqYl5SrzuVkFNhnm3x+UKA/iQWKkGLLvdGXsFJklUqS7uPQV3AdsWQWBeD4VGqU+DGNG+huzXhtw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yWbrcy5kz485BHk2cCIacccXb25YRlHqfT6Z6L8oYcm0GSR+U3crkjZpcluR?=
 =?us-ascii?Q?3y8c7E/FRnRXjKd3mJh1tIBkH5GVQEpiqDXuvKdny19W2Qy5zwzIx++1Yx77?=
 =?us-ascii?Q?C0vfYMeHowS5FhkZiJZ5lFHP5ddLZUjdLRYuS74lxa5xrGZwINeATbJQMoRX?=
 =?us-ascii?Q?kCDCYA7+PbndI6lXgXoceObTL9pCNsgRaYGkVZTivHTlSOTh3GyT1juf19MJ?=
 =?us-ascii?Q?oyMtNVKgj+3+ZEAQKZuevbH0lBFK0r0j3/qTkCEdTKfwknP0X61tS5yZ9bYU?=
 =?us-ascii?Q?Twy7+sjKm9VtkfuKh8LlyaVSzPS2LHNH9U2nF5I6ScVs6uHJ17a+ms3E6jlc?=
 =?us-ascii?Q?I0mvjmjmG6U+0oL3PuoGlo+JqmD4k2moONPnGy98lK2TW4pw9RC79mVpJNl1?=
 =?us-ascii?Q?zGUf5bx3McX7FacyxQBTgBZwqP16WokQzla8R3Y9SzYMC1jgYHp07RJ6cxhq?=
 =?us-ascii?Q?nCsXELjl9pG/X/o0Ugj1IIGeRFBpxsJBDrMlqNB5PSE0Abj6AhYoakTDjmcU?=
 =?us-ascii?Q?wIoHqWGQ5Re6PGixmxrd6ifgmNBBqc6C08umaZIR8k0az+OKpdeB6NOhkD6Y?=
 =?us-ascii?Q?Hk0KHKvAf21mbHLTddilgjLhRwe953J69lsgAnA1gca6qI5V30va7+FLmnIS?=
 =?us-ascii?Q?FHItoagVSGtF1JEKdsuTLqJ6QHF/nzc9CTpMclnb5N/g4ynGw9U6iM7T+CJR?=
 =?us-ascii?Q?G4UMWUtelt8wQqEGDEK2gvjetTF3pCO0IgqIf5lQZfymiYZhUyotQ6IPzF5c?=
 =?us-ascii?Q?oR6FEuVc7M7d2IFauCX9CELSoJYn0qh9AIu+jiEN2SuqX/LCVaj1uCGJsV/g?=
 =?us-ascii?Q?2s0BUaoLxLiMl3MYq3WMoLUf1ZngRvaVCjEXseHFSRZvQRRdXqqnC/DrLg4z?=
 =?us-ascii?Q?NwhwootsiIFYQ/3axC4WAojuGBJzowM+jOB6IC5XtFVxiUfIvGEkcev/pz/x?=
 =?us-ascii?Q?/mFZymgsjaYF6YY5Weti9h9QRWi62lGNCK2EcucIaHnZKwqBAa5zpu8uJtDM?=
 =?us-ascii?Q?ILVntNc1eE7pi3Ua7AWeGwLGtmH2tm92M+ElZXHrcYfuJb7lHwXff+iNPwqQ?=
 =?us-ascii?Q?mNqRMm42DeiX3SfGQluKhyjpDpdlLR3dJfT4CnBPmu6iAiOqVnXGMiYca8gC?=
 =?us-ascii?Q?EbZvz7BFLq5QZnCpopIv+GeJsLc6ero9wGTmtIU9JvJXWu0O8nUuQgOeY6It?=
 =?us-ascii?Q?UV/H7DJve3a6L/TwfmGG/CbAYcw4mif3I7zVGMXJPiuhJA6GSzepjaGF8r8m?=
 =?us-ascii?Q?B8WBdZ+dM0NTM1i+myJ7OrAEspEkformXIqBcbUL74TLaDkPo33CdTOGarrl?=
 =?us-ascii?Q?lznoWAMCd5C8HU+F1F2wOk7XpSt+YTD8LPUCPjyBGyT+ED01jM4up6fmgoep?=
 =?us-ascii?Q?ozq3SBxG3BRrf64ybOdAeYoLMwL0L4YsmXQthn8cYJQi1HHzCJmu9Isj8HUV?=
 =?us-ascii?Q?OlgC639LbfbJamoSqZAmrYxmTMJnaf6w4G+uq9mKrdLNaFomw4klw9pdcnj8?=
 =?us-ascii?Q?s3HiCHPDLBoaJeGZIp29GW0uv7PplNmJwxhAgBi+rdnG69lWpaQfTn0cFgnq?=
 =?us-ascii?Q?Q5pTjuiSPfnSbx32ZmJ7P0toIElGMzbE6AC+E6t2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c437633c-c45c-4d50-1037-08dc3e50ff2a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:47:58.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HwAimhwdf1u7jzHvX0uXO8FFmDi82ujHhkYeJ7RcDIVLswyj0JVSUNCNujOR/aRb/bvUIdQhhTRZNeEffEXVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

i.MX95 has a DDR pmu. This will add a compatible for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
Changes in v4:
 - add Acked-by tag
Changes in v5:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 6c96a4204e5d..37e8b98f2cdc 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -30,6 +30,9 @@ properties:
       - items:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
+      - items:
+          - const: fsl,imx95-ddr-pmu
+          - const: fsl,imx93-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.34.1


