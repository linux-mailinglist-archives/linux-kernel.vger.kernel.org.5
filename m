Return-Path: <linux-kernel+bounces-104222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5587CAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C517B212F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1417C98;
	Fri, 15 Mar 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMVlylM/"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C361759F;
	Fri, 15 Mar 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496551; cv=fail; b=JCUTQ/oscUsbp5pxtKljGJ03Ftrt4CSYIlTDcbUuq6DDxrnp+OCxIVIbShMb8B+i7JSZvdWqq4gZO6gfqXbI59BIGeXOoI23tiQwLswKTZZ+IpinDtqzzLDuGhXeu9wEzdwTKThU41tT7ApSexgRBUehVSQQfhMJZUi7yRGlaGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496551; c=relaxed/simple;
	bh=Sdtu0uV5Eopw3DFXRg+ZNCYWYgNh2DppRCa/hUscfm8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JWCvMeJEgJoTsNL9+3lliWO83WkE6HKwOoC+gsiF/WrkfSdjeLe9rp65KQCPTuG0sioCKibVNYao+QC/V0YJpRtR1K3FanCwoKgtFSrhOwkS6nFLQvjUGnV5yIeIc6/ra6MtpI5WFP43jUMpr/ypH3Qea2X0sXblR6I/MGGsx3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iMVlylM/; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2FtWEs1YU5xv5sVZUvLvus2/thJDD1Xu5g7tQnQp8fEff9uHkn1Y4uJFUvdWRwqdQvu5VsfUZd3k1vo2qyyRoGDcr+ci9Ahwi/Lxc9XmNXd9iQ9Dj+NYIK2KGtuVwDVTLOQ4J84iDHzYbZRCsTP/pFf5rPzA1ydjrzo6o7Hqa//eS8dEFeXDTRqnDKx1gLzNP8jXBCVeIldZJLUEoCRoDzaF16WS2EnhiFZqHI3MMvmO0SnCwjjm/XZ/rdERjz2WPYKOJqhQc/xo1HLuVzDlXS0D5kyeV5I/HHgpebIwH+dM6xz5I/e2pT6lrqs4AHOdbgw7864TbQX+VdTS8u82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgsMBGpxw/x1YGOlm4/rebrMq8R5J7h2s1WZSu6Tl24=;
 b=HviQfT5pFG/cPtMpM+5oC302QAXyWwCeHiZTtNqUFv6RCvroFqgrvNl7OEJDcc2Bj+WmSSOD1igRprFSI1+16bQ1qXteI7fRYm8FF5VXuGD7istMaEHXQ/c+k5ZrpKvqqBhWwrhPMx9vdLJ9fei3bQThsd7oacLbTqq4cNd6XC2whlZCM9eS+TafsrnUS+dXDO0Dji4GWWfMXVDWpqX8jSZG1aKnyVchhT4y2xWPoPCsD4bvXtHLt9saDNdGIBa9ZnrhfvVDexghOOCsN7G0B8Ri8BRICBXZhLZgbrUAERpzivrcUzkFj1goGidtglHTRPjGjGnsYONmtmfHcpqlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgsMBGpxw/x1YGOlm4/rebrMq8R5J7h2s1WZSu6Tl24=;
 b=iMVlylM/oAvpu+iPHXsOOFOCCHLiiWvryDPMWEDH4G7vq/1ALap1YuIzUVvaZs/oEacpSSnVVCE5TvLYgdG1sZni+UXUMZnvT3BV+8aSkBuYf3DW63gS56u3q13oP6lEg8kCth9A8gbkZ37cHsstb762OXxxuw0gWZUbPNrCuMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:55:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:55:42 +0000
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
Subject: [PATCH v7 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Fri, 15 Mar 2024 17:55:48 +0800
Message-Id: <20240315095555.2628684-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 686ec677-5c92-4c22-30ed-08dc44d613b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OqLQqnq+Ia0UCDG9O9Qk1fS8Bau8I8V0iEbECBefRlpSAogsqAEaE2xyt47sj5vqpnsR3fJ9QgeM5c41i07F7EzYvHVaNakpq89eWoaxUpzl/Iv1yyPXNF3JnsR07I8S5gQJN+B9/yrbOOZom8PN1iyn2dpjgnwULs3JtTSr6TfLxzK2tN+m8pzTwmAtp4wVz3Gk6TPxJJUoA8C/ySgWZ0YQVULFBvLdiUuLcmrTTGr3/3c07EC2ZzMFYyjClmLdKitJKFrgRNbsarUX8wf+L1CffkWdzT4kTukOPpdboxIhla+BJE9fKpeW8L8sYB/ST+m+RYjdYgkEt4bvBWaTGtbnlADCzTiE1tebU9/64HOspzQze5VAJhZNnEP07nSvr55tPmEVnBUCSZMmzOXxZcy9bQjkyp4UaF7e/l7iTvnci3gxs7fuuhDwSXjW5urtzpKhHbqpZKqoHtf3I+J0p13Qd1+lNDKInIzpkRIX9/y95rw0q1LCm6gSEOJR+E/1HS44O61d12yjtoYMA0l364cowPRlsP6oqQX/xrFivLjNQ/jkB3P9Gw8PRRHj9IVX8Vro6kjKKc7VsdffMzTwDbYyZf6HIoC1D54Cr2XjY9JTjgWEymmO/7Kum6Iayafs9MppRh39rel9Hg/IgBMJip1ClMRwIKygFD5dAZZxH+J4uC6Kh6aEngF5QA5iagICCXQ0eOw9mL+2T2v4IByAB2+f9E6zKsNX2H+BwTuGr10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VO0+x0WnqUpWLEpKgiVFTQVED54iL23ENXvVlh/CipDgpsCcQK8ge0xQjA0y?=
 =?us-ascii?Q?uOx7m1wMBADPkUzIk3c9CvViFAt7npa2KfEowed0+vw8xDN4AbSaFPrDimef?=
 =?us-ascii?Q?g+h8081ggq9CUfXswAPoNlSvAqLcNWu2a3abn3yHWpnqde6PCBkPAWtBSrbk?=
 =?us-ascii?Q?U7+APCxBa66dRzsF1nFvXt9QoHq9t8WeHKBA08vlQd5J+LwFED984nJEmHZG?=
 =?us-ascii?Q?nPBbFUhH74yJZuLEhy5MA3pDhYzVR7dfW6m9hUX9N9Y0pRnKANE9iz0yOeLp?=
 =?us-ascii?Q?Fe/Xaq99WGCxVIdERErJDgcJEBi60x5WB5wKPBG7E51jArLbp+hOBF/WGXOG?=
 =?us-ascii?Q?te3Hr8AnBiCzrrBOhDJjz/vFsa/bPQlsJ7MFXhcAbD7BXYXSSH2OSdycD3HK?=
 =?us-ascii?Q?kjqTv6cY39I3H7XX3iwcrW/rOJ4zzyk02J21ikzCdmiZ4WHTzEm68VxQUXCu?=
 =?us-ascii?Q?hzgejXZl8j3hwJzlan0PRotxHS/OZrEcxzR7ZGXd9l4qhiFn9ug56QfAr4dz?=
 =?us-ascii?Q?TrgYAyBLDwBQJkdvp9ayefbplVfTlCZYo+1VPxjq825BqdGq4fmUlbbnO2xz?=
 =?us-ascii?Q?W0Rb8rAX7oiv57Aj+LZsUmjsvoOox2CEswkeFtWNKhOu/taePtzc9AN4r/NA?=
 =?us-ascii?Q?8qX9jK6VKEApk4zt3Ir+h0VkNIW35KI6VVqE5d/Mv7sJqK7mVJM6T/YI4xH+?=
 =?us-ascii?Q?LugIX2VjzH029DvsUYOBhBO4yG5bYOZvgqIn9x4t/8ZkhdH1kRs2byy5NVsL?=
 =?us-ascii?Q?cWxu+wwa4iODp8P9TVvIS6h7x3pkM7gPLyhZREu8kieJcsxsYQ9IP5i1/U9O?=
 =?us-ascii?Q?jHDvC+gWOoE2VEw1Q2zUpGj557A+CwHAvfjgBjKrGO+js6qHHYORgsxo9yVe?=
 =?us-ascii?Q?57VhYmoLIcYn6e8syiolQH32guFmqhk/knTlFISZ+fH5VyhmdOfynPhuU8QC?=
 =?us-ascii?Q?CXblE8fAZNDav3mRVP+tBtr4RTsk8oCGiaL1EX7MyygvMI7muphXkjhdJXu5?=
 =?us-ascii?Q?xiZNzHmLrXY/9A3bYXtxCReTGaAehszdeMsqgYX37JzCnMBKqgrZPIne+HJI?=
 =?us-ascii?Q?SW1L7yUUpmsPXAlxegf4d6MQC4m3EI6IUA3B7nJaiUSnNRJ64bxLYxRv8xzB?=
 =?us-ascii?Q?A/QOCXWkH4O0FcsnXdfL8NAS4ufrAoR4JHapDYHozdKw6g2hVlMznpfVOi5A?=
 =?us-ascii?Q?CtyOAKthzmFO2cGOdMGuGSvU8bUbTGGhp2g4D/496dPuV9xDrOn8dVofKc5H?=
 =?us-ascii?Q?FslF0gRv2+Njz45346V4pcN5+nFg1OIgCV2Kqr8nztBirR6pTRbPsV4ibd+Z?=
 =?us-ascii?Q?h4Gbb51DfotozstP8f29Tmkblqe8Obr1Q2byU3pq9ppUknXoL9EAYmdbdsTW?=
 =?us-ascii?Q?bHCqrEXzJFegbbObVRGM1+g3iizkKcqjIhv7Ao2ak4Xsi4lDtj+8n/drAk1V?=
 =?us-ascii?Q?UBcjUXsPkH8TAOyfKLbYHiC+BmSoW+kl8cOnAbZqZudnD3v/daD+f3OZucGh?=
 =?us-ascii?Q?vfMdb41B5JhY9lyYg0LbSayjBmWYSgmk4FF88Hou3hBmsg5ltqJPddMIKihL?=
 =?us-ascii?Q?0fehFJ4fGyQq/yVcd1RkLApmd494Wu4UnUljvmc+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686ec677-5c92-4c22-30ed-08dc44d613b7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:55:42.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnvrpAuGoxtnJw194zutb1hZxcFM9OhYWPmJ+puDojrhg3CXCeh7CoQQSpFwilcqc3yZ3iILqmUuLdT8kp6IMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

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
Changes in v6:
 - no changes
Changes in v7:
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

