Return-Path: <linux-kernel+bounces-42513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078A84026A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E33B21D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60E56479;
	Mon, 29 Jan 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFClYo2P"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42455C3C;
	Mon, 29 Jan 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522895; cv=fail; b=JsE8WJ9PrsvtiXA0ffdyWai79FDdF4VXKqJS6a0WkJp3fkNoKKnArrXeXtcJfd4hoxU88uQXQPGm6IMnfLs5PsNQnbjYIUzoOaVdulOo6Zwr23k3DzvsZTZU5viaSVRmS0jKOdAdXNMRMTRufL1T+q4ENZB3tnRy10az+MNqdac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522895; c=relaxed/simple;
	bh=u2E7yeYYQxd+6xmzb7ELUOw8Ul9Oe1wdGPLYJnEliAg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s13obD6BPKcjuQZWaVRTK5ZOvLF14rYDybXIn2qAX9lgtQ7+vYLOWTomUSK0wNM2CSQ/FbFOK3M+Br4+CNg2wcIOypYq0b2jlc+tEUYxP1Ez+h169wh+pNkBRmlAX0Zmg23Ikxwbjw6WRgYIkdh8qxC6RQTgyI/Bnxrq7VQZ6l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFClYo2P; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea6X/kXtgp9PTUpBsG6R2JbQDsH2rplrp9ShSxFU81IAn9Nzv2WqMaDm0Ofa0MGG0Ov70QyzkJwiRidGCsRTDvjqBGjkUdfAjN3slr2t9TSFt99wR6a9PkFqqMJxgHy+BrT56uDvno2A46hZ3nap7BBKytIWTYbSGQRQa4h0JBKHqoCT/xG5QSlekAFnhs1mRyWOYNuQqCeSlyzPgsqVcPoR26JXamV2AxBS1aByBfzT1fJEBn24UIEGajYzViuRRaYjL0/4wHUbMbuKg4PXNG9HEEaZK/E6FqWHHlr0J31npv/0+5bc9H8SL2qBTdHhsxQmAJdp93vgANOEYsHtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hJ3R54YX6VeGheu1+rcCrpHcXSbj9DbO0Kp6OzOYPo=;
 b=O9kCK1+BEnvM8RwjqKOMKThB0tvGL2DCBhjzMgc5KElN5daIeftc+tcGIMSl8D5L3CJ5iVQWfGE1Z/qeHqCTi1YZbfnlfyvvzJtgHz9/hIKOMfOCrDDKm8Z70PwEyassjAfEouA6r8rlRUXGGaJbNYSJqR9nfkX/PGCV+u2tbjQmrPxGl/TyvKLSMYme3+8RRLy2w9Dq+GIQYE8zguTrWpSlEDLtRwTZokbKbTdlPFKfzMv7QDkNdQ9cqfry1GnMK6RyKK9HDa5sQznF48bnuCZQhV3EY6s3tQWV2+CJhgLEMRs8umS0BZlbm/jCy0Cg6ltl2FeHcUfoJIFYyZHrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hJ3R54YX6VeGheu1+rcCrpHcXSbj9DbO0Kp6OzOYPo=;
 b=SFClYo2PKlR55TUAPwVblyCr7e5qCW5V6+b7Mu0AB6KvOpsBnp1zeVP4PVELBEh98DvPqmGMPngmtZW3uIAwCsyTkJaJIOpWQH/XzH3r1egnNDuXKexI5RL84D79JqTLmO0rvWfd+IXCFdzPRAP7sI0T2/fGnLd1InV+960WxmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:08:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:08:06 +0000
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
Cc: linux-imx@nxp.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	xu.yang_2@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Mon, 29 Jan 2024 18:14:30 +0800
Message-Id: <20240129101433.2429536-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5c1b6f-ad5c-4a7f-9cc7-08dc20b23035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tm8H8MDO4Waa0efO/HqDSA5l+7lhMa7Axna7H3Jr20ikUR0Kok2/6hdlKe1jnXbdOq87hiJ1IrtTHNpFein4Qlftyb0G6YDfdxbDCszTmzks+I9RG7a3OVHFbF+81/wDW97JcLU7udqlDTl9H/I7wWHr/wUtZjA5y9zq12vtOA6BGLWfIVruTbzNqUUPbKHC3Ia/FFcVLOhFaLg8HhL5qGMEswKNsJpRAvli3dOtRdoATvMM56yuUXa9Aoy/Dz6CbSyxR6/dZXKgOs2/Hs4AxnzNpkJb6c3qwS+xtVkBK+0x/qvIC6uXUreonr7gozjuOLaFyzkzghClr5Pwz7XTzO0Oa45diK+ReohPdWpfVn61uBVC47avgIpqsei4YkPozUQye48UpKGwG1s8qQBozhLT0Hhe8wj0lI8x7wnhDbxbKYE4ud420ExmDLMHWYd3EulkjfFf1/ujj6YvkXaU2FDbtobRcfGUjTUSNu8hBOe/wxMbaJ5xYdEtuACnTPKbjV+kl4JMKlEno8Bdo+zp8ZrSFzPKSlJf8I/ZvDCrEe7ZHMkJUE6fYsgXHex+MMoXPtCo/qEs6Nd2WVXLPQIHYdtf4YNxpw/3JLvAmwW6bzcahSMu3C5O++tJ9jKsYNCNtIoOaeC05c8hrZDxzmW+RA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(26005)(52116002)(6666004)(6506007)(6512007)(2616005)(38100700002)(5660300002)(7416002)(4326008)(8936002)(41300700001)(8676002)(2906002)(4744005)(478600001)(6486002)(316002)(66476007)(66556008)(66946007)(921011)(36756003)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFcsOhy7yvn5CWxqusApWWvhZAHUuAHb7BhGNHueCJVYAf4Swb7cccCBi6UK?=
 =?us-ascii?Q?SqFeEFsJSvAnHd4zuF//vT2bDBRW1ntltggV9p2cjan0jeIXO/z/8QMC4YOO?=
 =?us-ascii?Q?R1zRmmQ6kRG+i4s3jgS5/A3TR98TvUZs9DHSobZkkfEPekMgaAsFkVb15/p6?=
 =?us-ascii?Q?BAVFW/Yv5NWaVJOJUxczV4bibOh+DqeBrbG+nR+PX968cXaeb9ABM6v7Zse1?=
 =?us-ascii?Q?cT5Oh7+QYLK0TUaqKy814KjdaN26qtY/qMJsTNoHrUa4puG61Ea4lC9aH/zM?=
 =?us-ascii?Q?H1aJFe+qVgOGSHRjUgGpBi1CnqJwh3439P87yUtHcFbFleBFvU0BMSXvGTXp?=
 =?us-ascii?Q?WVqxy6AJFBKkE8Qp2rs2ZqbwONlMZ68GZvjgn6CjW0QNvtkLy3kzCiKgPiwl?=
 =?us-ascii?Q?FsxP2v2GSmfZnC3tavEisVDcCFn+wBL43UqW4KPjlFdG+lm/pDjD3gGPWCqs?=
 =?us-ascii?Q?DRMwDqQzWKCh74Z5nIM1Vwpb47EDJW7Z64xQv40E9uH+1qwr2FmxhIxCF1ao?=
 =?us-ascii?Q?JgXaCIVAqmmAwaGqy5ABAhGAIyOjXq/3Ocsg/YwxgQmEvTxZrRLUJsvKpeES?=
 =?us-ascii?Q?BPYVAHV9WgW8oNcGcGKn4rfwuUV6uzxLj5VKVlKXtDaEd0/5EnLjId9Bum0e?=
 =?us-ascii?Q?Iunce9mbCLSFKANKAKOJeBoISS483ECTQlImWSL1piCmZyo/9I01ogkNIQJm?=
 =?us-ascii?Q?VMHD4NsZkZqcHtqyOi+brsSGH7hmTLhja5euWPejyJqfDMopI/SFuo3664Gt?=
 =?us-ascii?Q?VhcKBBSl9GlLajB1w/YMWRdmVj5ADwq7U9yO2f9qNETjavVWQognakoOONnq?=
 =?us-ascii?Q?6N4+HYIHWu1S+2f8M7Iz8Fi13N87tZ8ZMh/zV3+UUQW+lOMAQpSDIx72oMaR?=
 =?us-ascii?Q?WXeuK4wiOyOSbHQAlyQEHvaQFTm/ADyO+CcEXf09ES8oW3LP2NHaGkBMgLQP?=
 =?us-ascii?Q?fF2LdAFGF0sadFN/G134aKef9emEi97dO1ih/ZQnW3iA97QInu9Hj5iFdUNH?=
 =?us-ascii?Q?nB+meaAbvc+7NXcPSVBb1yOJDaYiR3v6L0yowpExaTrUM62XyonDp2D62v8E?=
 =?us-ascii?Q?Vujf6D+ktP0S1tBX0iYAoN3BNJh39k2TXxf4FYOwI9kgsrq4ymKdJwkOe4vl?=
 =?us-ascii?Q?k6cs6d/6TVRkBj8Kl97JmH5Al/I1P2ELGWf+StIUzZZyCrO7bA+zHXAormTq?=
 =?us-ascii?Q?75GAbW1yO9iPFjHqn5/UiJKrFk1BQ8ieSpZ4n46PckxXQ6zajNApRg+8X7gD?=
 =?us-ascii?Q?5InHoWFiPl2nP9EtFyJXWvlyypD5XcrVbGM50Bvdn/2J0kNdNqL0Fq4g18uT?=
 =?us-ascii?Q?Vg/NlkLsjlOPOkC/vVdUOL54yeSpsQgh8KXufEM0kPcqfAoWGjjAhe+1gHwB?=
 =?us-ascii?Q?YmCyCOZ/JX1672TFNZIy1IGBayxjxUmj1nSKB7bMQvTpFmJBDUuC+nyYBu4I?=
 =?us-ascii?Q?/ZIAyBzc2mj3GyVSOXLWILdbbOUo/M1DBpo4AIgxNHrepBTKINSVG3b4m6Gy?=
 =?us-ascii?Q?q2Tzla4eyFLp1RcUv3ltCwnGxF5IEV5W/vG7WMdRCPk6Odm0zl4FZb3rMUD9?=
 =?us-ascii?Q?xrsBkhGgbT9xPnQKM6QaixLGfbIljSJLIapTo7LM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5c1b6f-ad5c-4a7f-9cc7-08dc20b23035
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:08:06.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrmlSU8hEyFE5HyIprKph1UWJI5h5Rnim9WlRwp4ICnu83zI1z+zZ7Z7sSQNppSpbx5js/ET0sBAOkpnEhrgkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733

i.MX95 has a DDR pmu. This will add a compatible for it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
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


