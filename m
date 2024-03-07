Return-Path: <linux-kernel+bounces-94889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E487465A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31D01F24125
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C41C6B4;
	Thu,  7 Mar 2024 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bniD2zW7"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887E1C6B1;
	Thu,  7 Mar 2024 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779728; cv=fail; b=tzyYITkTk4n26x+wPVXtndZsYMnv5bPxNVpqKLREzQ/06vBX6p1IQrfI6TdfO2xJas2g7XQuMHQLRPtg4AtDR9JHFvQnZxULLlFscZDWL0WTq/2ITJfIbR3rRRxXwFVjtW1seYrgamrg3jjjlcZSHIaaaCnYBYwQjzzhi2dhexM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779728; c=relaxed/simple;
	bh=z2Wh81oYigP74xrKZbSZw3Hsv0aT/Fjt9KVRy6XFfug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0gCETemVoxbPzNFcO05Cx4AK6wDfoKDom9iWwr2DaU/jkJ6i/1FOxfmap+u5ak72eijfJv15Cq9V9JS1ixQ2+jQXdvRuhlcS2IB7/5mphxP1mrkj6RDEwUFX/DUL39/2FKFt6e076ultIWgerrJ9N4xrH05YgeLgURoUk0dL+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bniD2zW7; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzQjEXaIoXaA7j1zYP+oMP/6ZVgf2MoycLz0PpGOVt4QsYJ4OqfPmaUmrBll/OUQsW4g0520VBkeH1c8q0HhaPmuOur0Cgvu9+eyd0f4QRu7WON5zPbI7+EKE+4i6gQKr3r5XlkK7/9Uzwd5tBdGXvn9/o1X321Rkm3SgSHRS8hEttnIRc5unGyDfCO8jrm2HTNcYFYN1IEo8MC5ykgNOURLnZ8bomT/1mDfWih4h13vud/ByRx/dl2gIWFTJcn8n2pUp5ygZXLO8+udPUM/xfodOrFJaGd6hK8rdXjZVAe7h2EvCBjG6jNZswFUTxdrJof2i1cX6FsiPbb/NUK6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFvtB+OgOR8gkvh3GSGyDw5OV/A8u1nEX0dx0QgHmUc=;
 b=D0ISBfL7YHYVY560UFSlRHQT/LsULek9D4mUvAv8sYNzmvRiIjMPssuiYN5va3c6n1KqxIelpiqEERmH2vmQxzEnLk3F4ypDGUvW4chMU5vvP49qei9VHvc9Ac5Ncqv4AOox/oLm3kQytnBYyHwcbRdFLNaY/B9Z77CYNeaZLJGJwJC0E/i1978AZhYYclkNo/nBR0WwrUv2cUVenPC6gP9tuDsVDuvUVF9HrCmc3PuUVPMbVYeXTR/SZzRlD1rzJRtLsUNWIslUrqy6EFYNWODBATX5Yp15cE/tlBXVdvyjQfVZ+5PUXZ0Wsn4o8WRXXvFfPYOI2pHG7152Zvhtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFvtB+OgOR8gkvh3GSGyDw5OV/A8u1nEX0dx0QgHmUc=;
 b=bniD2zW7t5g1QD8Blef941KPUyt/KiqZi5Kyd3CkBErgLcT9oLEMwr9PrVm4tYZD0VCIbZEejU3U4e00SHimsCscPCvfcKOam0a/W8iaNfR5USJ7IgE7o5pZEIYEBWtRoOPC21zJBbDCn5b7RP0jO85oQcd0VmFv2i3j6K+HDlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:48:42 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:42 +0000
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
Subject: [PATCH v5 7/7] perf vendor events arm64:: Add i.MX95 DDR Performance Monitor metrics
Date: Thu,  7 Mar 2024 10:47:54 +0800
Message-Id: <20240307024754.3469810-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307024754.3469810-1-xu.yang_2@nxp.com>
References: <20240307024754.3469810-1-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: b502acc2-22b1-4ca4-0247-08dc3e51199f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vty4DWPCz85UjlKMcdC9ABavr/BgOQLFbdPdKAIGd6FZ5vScpl3KionhfYXce6fkg7In8tfuAdVxy58caRvSkR5CabDUbrbAi0SRZoWl0bFA5dSDqZOfINsTJATRdZX6w2woZCuDKCNJcV2YZQaRDJ6xR5/7ZZ+PnfDJv0MTv29XNkmUZGD3rVjFgaFWV9ec1/003n5w3zPIYdoZFY2N12/CuXf5zXBD/0zdJS9ehvL1kzw3HQY/JxaXf9CrTEmUF8Th3+6op9g8CZqQY76gJn1zWnBc0ilRtYD3usGps8/Ze9+kweURBKDXrHwa1o5ftgpxGl/LfIp7u6+KnHcx2a7XFCJlbbdOg2wduAX9b4Hf2DXn+l/WBcA1j1OFBkAvLCZFswNJkzAii6C/q+YOwgEE+UvAU7vJTIFENh25znp1jwcy65iUI+SKflOQfSxtKqG10DIBSV5tbmSezMRYCUrSU06HtfHAUMk4KXJZU2oWT11rm2D5gSnpTeoBqWs7MRTRslnN6WKZPvMAcCJtKquFs81rn3R9VnpwXrW8h9MO6/c4PG6RswS6rj+RO7ZMcb0lpo5pJZPh6mThQHxcCuklXMV2nMIhvz8jMWgN39oexpaWhTJp2tEueI95mHCAM/37S/yE6vqdDF/C9NCNSmLZL3YXjotZMZTFxf+9vaJKDp3HSWmCkZBDEIWp4rNmJsnvrO7saKXssY9K+1nMM7En9xIg9qMZXQwMv6M65c8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p19Y9dXD/5S3k9Jex01FhOajURvy82NsIHxM+ZzVDdOkIjVvYlVQ6A3KbwtA?=
 =?us-ascii?Q?8v7g+Zcv95qB4vqg0xDipwcwccBOqJrD4daott5Wckis46wbK9OQyibnTz2F?=
 =?us-ascii?Q?2Rdy0KUauhCB65YhP5jk+fRCKSLT+VCadi4VWuSHj4H3xXaYTFaxBpmQv18l?=
 =?us-ascii?Q?QhDHwu2sYXunpH2zWhzFIQQ9LtOs49Z/0rqrNpG41/dL04A07Nap3wumslen?=
 =?us-ascii?Q?Fas9hZzt+cpH3KX2hULt7GcOCXWlYx38iFxcYkozvV3uOF5bZjb1KbI6t5Ma?=
 =?us-ascii?Q?P8+K8j2Vyy+opmgMOM1KBACRkKqFhbDDu/eZimXWoDCmVpSuRs8LBtz0BWws?=
 =?us-ascii?Q?DE48dzdD5vu9RVynqLZcQTxFoB/WbnAx6nqzevu0FZqJpyt4MppBVIIZPnEd?=
 =?us-ascii?Q?kfHbowSWlUw0HL91f+n6icDULEhxX5gyXB64NL/TfJdmFBVRafMunW14/T35?=
 =?us-ascii?Q?Tsz67t6DchOvp736o38g9AnuKLDXALdjcbkgV+BsDlsHULgzkrsSraoE/V53?=
 =?us-ascii?Q?qGPHjY3QtoMTLybvcwqG/NCgzajHOfxruTJ1fajne3do+EMg4OcQcqe5Qhl6?=
 =?us-ascii?Q?fJKa80IINc3b7WmZ9UsRREQmrRVB9rwssBQHaTVI16a2RiyV/I9vLnCOVypv?=
 =?us-ascii?Q?C228pmDnuAm430tDfgsbfqS7nNxwH/lZQ2S55dH3vVbUNUpVdbKQT8FTBK6M?=
 =?us-ascii?Q?j+hDtT7bQ818MpZ0Oww2dq4qBhrl8BlZShVm0PtfsA9VZcrwu6t42Cf3xedZ?=
 =?us-ascii?Q?gNWmgrLm83lxonlhAzp4K/GcnmTxob5CDQ3XrlGyqhxFRtstQ6EUxk8CTXYZ?=
 =?us-ascii?Q?x2uBDKjZmYP4RQ7OoQ9G3r5UFfseYPb92QN8B1/vle66Tj6NQG7ceP+E4/0v?=
 =?us-ascii?Q?KAH8pjOkq8AGmDsxNw/i+A1dFxd/omgbsrGk4UWWtGP5/tWBnO1LNj4bDX2d?=
 =?us-ascii?Q?PnHRBgZn1S8QP8ByVIhCDVz/MFSl0h0LDk72YwEEuzgkjA/EpbbzjRK3wWj2?=
 =?us-ascii?Q?MqLI4oukWFyQIhwkXpbzGNKSDWUMmq5HEEltC6XgYlBNyh8gNBGPRjVK29Zb?=
 =?us-ascii?Q?0b2z10/hJ/0xY5Zz/2QcFmRLfzgQXJxfJ942+CMyP1YxoDfX/KxHdLKey+W+?=
 =?us-ascii?Q?FwCwtJbIUb8DuYgIvKwGRpojk8g99muaKimd/UzUFkawvt3hUR2p2bvMSziT?=
 =?us-ascii?Q?YCktxXsnxXB2qS31aQkVIPAHf5XNikwtSRVqRlaKbJQIIKkOysmFRPs5Bf6C?=
 =?us-ascii?Q?x0Ar++uyXI2Ur7e7QLQXQtTUplokdC55JkxZV29A+gyldbp4urkt8iPdp9XC?=
 =?us-ascii?Q?CRBNeszPMK1nDls+D0HduxslqkZwE8DPw5Hbz/5MoWOQ8DKzPOZeWN/KPPzC?=
 =?us-ascii?Q?FqbMUU5ACHGvQrhgRBuXAf9wDOUAOzN7fyQsUBcEMfoQ9UdwTAm6UFq9dxTm?=
 =?us-ascii?Q?IyhLlNeWtk77PYEs6Wrs84ItZRtmvfpyT8KDhDszd3D9n+D7ZLo3iLEyCHCF?=
 =?us-ascii?Q?bxG0FUcJIag9kCFGJ++XBPiuuT4XcN1xc4zeWwvWCiN+iWxxwHLu5KfoTl0q?=
 =?us-ascii?Q?d9WjWP4rrJPPSFwHwWKPTNNX5su0oD6otpJGcDNV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b502acc2-22b1-4ca4-0247-08dc3e51199f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:42.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujT+C7krDrabQyN+bWetLqkB5AVy/0zyatBCnUlwMawJwByLeelt/tvly8IEQMDJ01BnhseQ/KVcrFEQK8Ri2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

Add JSON metrics for i.MX95 DDR Performance Monitor.

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
index 000000000000..2bfcd4d574a8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,778 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.a55_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.a55_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules read from ddr",
+		"MetricName": "imx95_ddr_read.camera_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x380\\,axi_id\\=0x200@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ + imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.camera_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.camera_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part3)",
+		"MetricName": "imx95_ddr_write.camera_all_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules read from ddr",
+		"MetricName": "imx95_ddr_read.disp_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x300\\,axi_id\\=0x300@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.disp_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.disp_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 53ab050c8fa4..be4b541a0820 100755
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


