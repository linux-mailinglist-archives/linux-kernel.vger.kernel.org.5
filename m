Return-Path: <linux-kernel+bounces-144473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1C8A46C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964FE1C21898
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C61C68F;
	Mon, 15 Apr 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9v/F9q8"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56C28DD2;
	Mon, 15 Apr 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146650; cv=fail; b=KomLWyFC2zB4agRGUq8AoTCMVMMXZAZ93Z/3BprOnM2XdJxZHPzwbQpmUTgzTgVcr8mjYGiTznuCc22dXHFWGzx8oyjLwTAhz8wwYnz2xEs8dGlyNQSwcIHKV0Y+n0OCDq86q7JpywMlKKXeQa6bZYkve26Lr+7MDwldMUWmPeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146650; c=relaxed/simple;
	bh=EdlJADBRGLWHQ7mgVUIIBNrK4/HIBlzC5B/jwIJFzrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKK0uCyHUCfogFUZFup9QeG6mYNTt94xiBfP0U8uRYPmDA49SBznjOAzZF16qg/16SeUxJG8cS9Ccfm4T2RPpFNz/0aBKyq3DSYpwFurYrE6JCSBnVikGn5815IjJ92nk7nZ0LKW6fM2uIcpyyudYqSJ7Ze2nxUF7zogx+L+ZCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y9v/F9q8; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM2D3HF4cI62umaLEJ68aVt3YDO3Tvz8VnP5xc761Ze87lCxpgaRsxCfine9GV0GK4PfSGKIFdewbCEyP7SwkCuMu8vZrL52NBkHvRRql18240PBaoXmjEBPrMShBgHsj0+1raIXlLWDG66CvtWMkL8yWqKiyALh8WvZJfaSy3l3qqnPRq0GivhRp9AXpLSgpxHC/bBKK3QVAOZ7+YB9i2vHY/vH9IzPZgCP0GHI/85ascRB//aHhpplAJbyCWIqD/wpYitS1kaJza7qAGJWQ1ggslVx5LdcMw85c4KRCvmlg8HiQTxXKuxkl7uX/amqiQF/BO0QI/rjG0LyKlqGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l5MBoWHv6mjulWtQZCccsoh2jkgih+tW9a9SCxD+/A=;
 b=dsczN53It1ug48LjZ3YhmgRuZm+jY/T+Zi8uyeiLoIv/Pp865sRiOY+mr0LnDYRObluLaPRiwgHt4iwjZ3k1qtrc++11LTD2bPdhSceIfenMStCv3pCG+TzxugRs+ZPeZjeLBe1PRoimz7PADtXEPeOtcgxSFytzrITLeLRNbHH/GWcTV57qsq6aRNOoZ/FkSnrUlwvNPY7b2S6jaGAZYuB0+avyz/jgLa46oDfJ1qp+P0Ozbva6EGfBV4n0dY5lawwW61AXmc5KZRN24h55wnuVx239mQlCMvjjRqiRXhsjC5goixnyDeRNVBajqcn/xxt7BXygNtFZpSXA2lLx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l5MBoWHv6mjulWtQZCccsoh2jkgih+tW9a9SCxD+/A=;
 b=Y9v/F9q8A0nZoxb+8Csb1r8o8KTgR29XfPJnoCcwol/6e6GXYeCuSY7fe21/VzVyvg2DaA9szyPgsUXOYebOi4Seuml5umVpHbKh+qz8swW7Ylo911XU5ZKZxmU0RPlJMX54aqAzThIJyz9Jz1Y/PNqTv+OMh2prWRtCUmHdG1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:04:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:04:03 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
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
Subject: [PATCH v9 7/8] perf vendor events arm64:: Add i.MX95 DDR Performance Monitor metrics
Date: Mon, 15 Apr 2024 10:03:52 +0800
Message-Id: <20240415020353.3833367-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415020353.3833367-1-xu.yang_2@nxp.com>
References: <20240415020353.3833367-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1cc174-9b76-418e-296f-08dc5cf0529b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i/LeJ22ODh3sUtiONZRUIKOpXuCq2LMKSxj7YfN228s4Nroypyjsy7Jio6mntExciNNHXqeLJ5+hb9NRo4OWrA4CAO8L7OlA0SS15t7MxMfHtVpME6Y2c6Ce2nykf2hDcZ9TulcdzvNqOnsR0wSGs0sIoQu4ihCKJwf5cg84kpCzm/BKkceF3IqovLci0R8i1CPT1Pfwk7xQGekCDFLY/2Y88OLiT63qxnFORMWKu4kmJvMzI3sRu7apaGQ26t4eSpr89feeMligODjTRqxJ1b2EgxUQTzCMNca7Ab3SKQz118z48zmFA47QNv+wVg5FGeH4WmZTBsC5YEHX9aQkdlPlSC3CaTk1DYQYV4q5jxgR5fy//ax0+cS6w2jmhN1qCM30Ipf0RFzL3W3j91Ph7NEiZh2cM96V87X1ZkAElPGih9ZYeC3EkubJN20c9trfgtJ0upP6/oLkdmMCSPa1RWVemHZWOgA1Ze1t80GDcUdlG1S6Pd+aoOe5F4WReZf/X2GOsRdiRQDhkFRHlOA7eka14P1zpR4clBO2PgV/XmsSZZbHCKJPcoqCr6DSEq7ul/+FZPNgFF9tS3BQB0HYL/vJNJ3KqT4kZU6xFU9tedOrarqfsBJRmfxtuKBGkP+T9cFlJJ3y/3tvYBRPVXKC23YdOQBJHBdriHGaczldq3lZYIrwpfGYd6oC6d/eS6+1Oq6ziyB6XCKa9WBkPgBb30yQ6gi9b71/bsQhcKruIAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4miGsP8yr/b2kxP4K/yXBfa0n+pRjZhTALvNk+fbJC0iRqkYxBBn+GIXoLI/?=
 =?us-ascii?Q?fRcxsuSvKDCJyOsNoOnDgbtWqVl88YxmpCt7eGyzug9pHqlcZ3CZQXpPcyyI?=
 =?us-ascii?Q?Os0PRaNqPM+DD3bNZ1eJ7irKpUQp8ucIzzUiESyvCavFwqOs5k3zMEhsGbUC?=
 =?us-ascii?Q?nLBfi/qh3WB1OsfC9L7ekXQtgKbBBF+PApGMPftPEgD0DLxP2knYbWknNFEV?=
 =?us-ascii?Q?Rom6ibckSyAtqufsCtONRntJOXafuicO+QDwP9H/M3dU4SP6DvjDIv+HsKQ5?=
 =?us-ascii?Q?TsevfWL/CTZc+nCnID+ogFU5hjTYp6JqP6+SZnMNho/mZS+foST2yS/v6Z/S?=
 =?us-ascii?Q?ArBfibkxn2xXpv/nCldNU9Gr9OO6HX5jWmXIUdQUaEmqEdVxR7nHCOaIPMnY?=
 =?us-ascii?Q?dkcXqaBK0gdenSdJx1P+7+vRbiLp6p6eDgyAyxTQTDmN+W4sJ9JSh7te5w9V?=
 =?us-ascii?Q?0HZyC6KRleUMZi/kcE4YHy0rbkTZjH160Gsf+XV9/FviyEbqvQULx/t4Sslb?=
 =?us-ascii?Q?aIedebZrMvgbt2VYIS1o3O9PoR3SDeG1u8IVBIy3pE6RhrwyzYbDSdzkl5Oz?=
 =?us-ascii?Q?0X3Z3KAsHvvcE8XKFLf/4k/SRsIAIDIyU/rBb2uR/GTfpZyGGsxIhP0R25tt?=
 =?us-ascii?Q?PCeWU+TNG64YIJh9JXJ9XbZdV4aXUXzyscIpJyzgNaUJ+7iOr4lmwbzdvv5P?=
 =?us-ascii?Q?ZvaEpx+L10EX/4LOAcguZl6xNlLqCp3ppuk3d0ASfLTrNbYRednqRjJUzYt3?=
 =?us-ascii?Q?540NVEdiKofpNhc98tJY400yBCg9eEhF2LjttYgaU2CCNT9n9OkkZ7bO289T?=
 =?us-ascii?Q?atQU+kVCXRNWH6xdzChHbaTlSuW5N43aOgLBA9AP8/L9xHBjae3ML2iVAekb?=
 =?us-ascii?Q?2DDfPY14kp92PjtFmP/GWmpW1aFREifsgjZ1rn6/X5eriF5TCQ65PcSCniOt?=
 =?us-ascii?Q?x+EQE2VGMSMrN38rWSh68H47PhbwO5vtMO6GxkqFPolb5WTT5Vqx1ldd6ge7?=
 =?us-ascii?Q?FqaigckSylt0daETCjRSgeDrSXiV9Gp557wV44CHp2ClxAd6jazX75nVRsll?=
 =?us-ascii?Q?yhqCpPRM2mnxPcEpgHPc2XtAbc4fwUs6GqzLsnezq5xssrtghLlUMbdPO/cO?=
 =?us-ascii?Q?ERC5/To0RRoa+vJExbnGiiQxmWuDSoINhRH7la6dVlGMJXJeb3r0aSHcjBsZ?=
 =?us-ascii?Q?VhtMQLRav8deIfRlR26KHCvHDLKcB/QQZ94JJDDulnnh8Ju2BWMM8Aht3u6S?=
 =?us-ascii?Q?QGkGGwYtCoNyrnnp4oiymJhHdhFhzs6WbXseR8XBPT7Ul/XQj87BIbYyhzVS?=
 =?us-ascii?Q?zHpAt88r1Sp9eKR3/wyuO6Mpp2ODuT2bbYF5qxQ2u3AFfiKqpeeq5gXPJ00M?=
 =?us-ascii?Q?7O4bJhFZbCUSy0d27bAriy0A/z41W9GYZ5seXfQrukxXRrcwEjlS48J448H0?=
 =?us-ascii?Q?r49DbSte2TUzNUSFF/E4b8kL3KaUAdvFeGDuczhgXwaTU2f/3ymBI9Ne3r/o?=
 =?us-ascii?Q?Ms+2/PeebFo29lN33SPiaaTAV/Cow0/K611TuHNEZqId4llIl3Hgre598z11?=
 =?us-ascii?Q?xwxcY60+Hg3HloFj28aufjzIDfw4k60bUq8tTiTC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1cc174-9b76-418e-296f-08dc5cf0529b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:04:03.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18DOQvY3MiDA6hJy7yMjGSx78fPNRBBOFssmSlt5kUcHskEQm/ARI7ZtOFrqYo/nIIgR2hayHd+Oq3q32PGaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

Add JSON metrics for i.MX95 DDR Performance Monitor.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix wrong AXI_MASK setting
 - remove unnecessary metrics
 - add bandwidth_usage, camera_all, disp_all metrics
Changes in v3:
 - no changes
Changes in v4:
 - add Reviewed-by tag
Changes in v5:
 - fix typo
Changes in v6:
 - remove "counter=X" from each metric
Changes in v7:
 - add RB tag
Changes in v8:
 - no changes
Changes in v9:
 - no changes
---
 .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
 .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   1 +
 3 files changed, 788 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
new file mode 100644
index 000000000000..4dc9d2968bdc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx95_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx95"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
new file mode 100644
index 000000000000..a3ae787d448c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,778 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.a55_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.a55_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules read from ddr",
+		"MetricName": "imx95_ddr_read.camera_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x380\\,axi_id\\=0x200@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ + imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.camera_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.camera_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part3)",
+		"MetricName": "imx95_ddr_write.camera_all_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules read from ddr",
+		"MetricName": "imx95_ddr_read.disp_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x300\\,axi_id\\=0x300@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.disp_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.disp_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..ac9b7ca41856 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -284,6 +284,7 @@ class JsonEvent:
           'hisi_sccl,hha': 'hisi_sccl,hha',
           'hisi_sccl,l3c': 'hisi_sccl,l3c',
           'imx8_ddr': 'imx8_ddr',
+          'imx9_ddr': 'imx9_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'UMCPMC': 'amd_umc',
-- 
2.34.1


