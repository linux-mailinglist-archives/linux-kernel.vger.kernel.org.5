Return-Path: <linux-kernel+bounces-144474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3218A46C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7011F21F54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3B2940F;
	Mon, 15 Apr 2024 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WeZ1cui6"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928C17C6D;
	Mon, 15 Apr 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146654; cv=fail; b=CPqZUfN/CMZRXVM0047UaoloLGE4wkzFxFMCTbeE8KRiEhhcLBcXBvJzSXJ2HJg2Hjxef0/WidmlJUit0aBDPtpLgQGoMh4+gQAwsakv0eIYgacAtJJr4wvxfuVjQCKaV0G2ay1d5TQc6yIIbVi4KlJFAzSSzYUURqTNgakGDxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146654; c=relaxed/simple;
	bh=VyqFcU4JgZTBsQwXe7iH3jl76lUHr91izZ5i3vkj9cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qkhpkSek/oH9MMmkLwVx2nDH9riakIn9jK0XqfAzmvT3OlenHXIcVQkJ/kquIw55KXnUsEB3i/x7UVw2e1ewDvz+WuyT8nwtRTZoLM7RN//b1kszLe6Tk6/3fnuR/K/wFvxe9000sKLfpZLLb8HE8oVG6eH8SZx6NJEvTrp3CqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WeZ1cui6; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF/gpYtAGgRSaJqJpjr6kUfq+kEwXM2DlIqQKNCOTa+WQ05HXciyJiWASej6epabX0dUj8GGPTz0eQBmNQ7EeYhCm83uuHsPnm6bLW6/oEDH0SjZLKIKD3YjlaeoSnF4nsV2rkKVFV9Kxz6IiVlPGtZL3j/dQ/tod7QaHVb8VdTjLmBcazj/dlwQo7KkBY4PWDIPpWrBmB4Kk52p4iJcwcfP/kU4vo7zLkt7wrvhPWErZ0uillpbXINZLoiE7fr6Yhz97aESi2sDG+89xFoSvtzHrIYqoMKGYykxjibIz0xOqQkRl2GIMHcjRy5fWfHPac15bDL0n6M12k2ktYK7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPLf6Nu1UbO2Q+wMwpP+lXWdOxCaeV29SJLd/wLNP7Q=;
 b=keDaG3+luCG014v5fLkMf2WWjae0nyOgsaPgQFtS33rH+jCRMHbT8EBM9Uz1qRuRufMLUSMjLAQqiOLEbYFgEaCLgBUDuX/8sS6T8i4RVUVirgpntnSSqjbaww808mWdFhQkpIHTcWeEtXfNhLAmjcZowky3raSqI9ZPzNrgtFmbh0lYMLYJCAijDIAvz6H+fyHZrx2T7McSAsAzGjw4ExyTMCb8+XCp0wfZc6ukqJCa5JUkSDcL8J6vuB2B5nIPsWuTqJ179aBxENTpAUXVOJCe2fC5jh8uOk5/YO8zbxvsCMuhvA6navg6XnaiGu37b8QNd1qCC/z+rlOAFXBZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPLf6Nu1UbO2Q+wMwpP+lXWdOxCaeV29SJLd/wLNP7Q=;
 b=WeZ1cui6L/UbDBC71Ci8L4M+RF6ktYA+ja/ayNwkGIwaPkgZqtwifdKtiMeoV5nT25SdZJHVAW2A9fCbE0qNofB/Vp96HaWY9HwexIsIR93ISaimBk3CrV4MfTt96mknbMf6gLoVq0qI3m57wgATdSFyS1bLQm0Ibozg7FxFIZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:04:10 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:04:10 +0000
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
Subject: [PATCH v9 8/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Mon, 15 Apr 2024 10:03:53 +0800
Message-Id: <20240415020353.3833367-8-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f1db827-639b-4b49-2f24-08dc5cf056f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fnHxWxe3weRxr5y0euR9gyUn5yY1f0sCAVZFNWrQ8TiNZPRFpr5LgCFTHvri/07xIo8lL3uw6ZlW0rvDg4vUKKc1crD7DxbO9qXUygtKj9SCRlG/+Zq1k5FL3k2z9cQtJ03nbofUZW3iM37DbWWxBnyrOFKvdbVB87YF262t7kbdehqCbdBqBuNjnjvn6RjaGhoYATW8GBtff9Gy9B2HhWwxOtvQh4vJ4J6khZGCx+eKYDIhBoU3MTei3nkiGITmuVxVS3FjJq4KbQ/tIzlKmGDshJd+qrZ/AoVd1VnyBY5G2uKbF6FIJjAA4dqhr8cBjqlUkG6ODNDa3xeEGQXQYA6PIY6X/ehIVmB4x2U6AV9Dt9DLAJMF8ebWbW1g/xzgTKVAGAhu6NGBRpf+UvpygDQSRgfbjxW8uDnABNO7v6hx0gBBMpnITWT+5XsdGw/pQA7XiSlkbV274xulqy+qEjttiohvf5UFuhO8FRVCJnxu5/GL6azR/e+n4V8ewtItwl0MlVX/1ZuBxjn2+E3KFdRnBqpsZRTyXfJQ+CinrYi/h0GZibQ+bOwS+OOfISImjCF1PYOgeYsLZ3v629kKfBTqjbncl0Dj1h+U2PEzB8p8/4YtpnEunyTLfAzA9ZcY+0I2nOeUbO8OdmMGEapYhS6JJ+BB2AGrdunkWxuIGmv9Ci0s4zMbcGMZk6GPEr6Bj+wu53qYi1NVs0mV9w3Zfs4s0FB8s3DLhpAQsZlck+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqPLuMoNv8DAVZ6IorMvddu0F7X3ZFy9Rs26mDXn8oS4AL02AgTF53PzLHbf?=
 =?us-ascii?Q?kGdn848Wv91BJ3lpzK4QLrmQvSLrUaPpQ5JPz02chd8U0QcNyLjR6Xwc0g64?=
 =?us-ascii?Q?738UkSKPLhQwApkAHW3zJedVzncT2PdmlGnqK8Evq6p2dl6iGc6uuq36Ywfn?=
 =?us-ascii?Q?F4ZDsK3woM8+y3iVgzbWKIwQ/MxJDjII5ItIeTyn9+6yPwtPz3tBFz05/H30?=
 =?us-ascii?Q?DQ9SGaPkVmCF1oSXkudBv+yCo7W0ktNC1wZLKSsoUSxvqZr5/98g4x1dXCaz?=
 =?us-ascii?Q?SuRtSbGe9BvPlrsWahOHCMSDpJxlq2YxuXjitKoKfI7JFuiKPkrv+6pNWm4j?=
 =?us-ascii?Q?kN52Cl9V9lbiMMazDsi2ozo/+/n6k6lB5uBny/C5dxxE9sM1vmAWG9xogRjc?=
 =?us-ascii?Q?aeArCj4XziAu7G69bX/HsoSrD8JnV4pqMbLsfbxY2aZHEkXjBhddL4dEflgy?=
 =?us-ascii?Q?4541vgn0K7Vz17ySne26asoO1oCRCzoujb8Fg3PH6bw+HhTyNzLJ4Gd0KXPt?=
 =?us-ascii?Q?QHOJ15QRyHSCZO2TmkzG2pq/yBsS4hAZsNH7Brnv/Ml3W49UdVnD+Tru0xLl?=
 =?us-ascii?Q?UmQJ1rbpjtTnBKfke7WPQwuw4z4VAYkpPe2F2KeJ0mITeOJ1AQBesrPHZKGl?=
 =?us-ascii?Q?HPkXTqgs+10ZutvyiRQ6Xc1Dlu2PyKiNeovtVCUWtuMjuU4KDVlmfptajsNY?=
 =?us-ascii?Q?mxtJ5wLuOqKkHt/ZXOibSe7lPRlLRdysO2lA2FpnM1qFAzofY41Vq625Sq8n?=
 =?us-ascii?Q?8AsacDJHZyUQqmxt477e4WCXNEFBXNDhU5r4ge6Kbz9OZFNqX+V/Q1SYR02p?=
 =?us-ascii?Q?IDvrDhtvrWA1wgce4bSwOlSiYAX1wT9J6+LD9FUQl+TrTK42dDMTDehRMCUB?=
 =?us-ascii?Q?QG1pAE5szJC2gbb4kuBmglhldrdpLJpC5z/6A2XgeCM650b+RCAjwJYYWgF/?=
 =?us-ascii?Q?ywqisQE7Do3rL8yxH/4RsnLyjqU7iJjB3DC69xkTf2StssT3oNBRZnDVGzwh?=
 =?us-ascii?Q?9Qk0XEpV90XrNgDou43NIP+rmheq2SWucPe3HldD3vOcFwSVtmTg/pTBdI+c?=
 =?us-ascii?Q?4oEnL2ioJTg9T0Azxgi7Mzjwb6av/l75kc0F8/8/B7lD6iufPGwmuY7Xum2k?=
 =?us-ascii?Q?FwWAEmVr4co5hQhxLUoSHt/Qt7Sxm67luFXxXZOqq0WgDkGtVUc3aFn61Q8Q?=
 =?us-ascii?Q?mQ+wWwAXNkr4lr2MRIUJn+kwpp+My5FnsRe3jJ5/Y+nUHgmdVNjesSkcqN6j?=
 =?us-ascii?Q?hPXY0nql+27Ti+5BH7CT4TVkyYSMU2tXBGnE7FexSQPyn6x9jeNtdSEDQhjF?=
 =?us-ascii?Q?1vY0CsaJ1c4E93FpUfa56H/0O5RJtilNeodVTCo7is+6DdasxU7B2u8+Wb9s?=
 =?us-ascii?Q?ObU39kmpZLWaIOEv7V+OvZVzkP8844KlS4caTrrNvLCny2Nu/TU5ech/kSvd?=
 =?us-ascii?Q?5mVrintQzkcIuh4xb2BMLfUSra6riXVwWwzvs20qKWZGI0+CBp67dVDimiAg?=
 =?us-ascii?Q?ut3EplfKDHG9YgNclDys0V0gTGiyKF/H/JWuQl8G+m9g2Jg08HNaORh2RQCz?=
 =?us-ascii?Q?pSKEa4d3VXDzsCnd3IQb5cqF5TYNGP06fX6Itt7X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1db827-639b-4b49-2f24-08dc5cf056f4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:04:10.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s8HlFyhaltxCCoOPKyUYZVCbb9xnKKISgio2kTtv9JekX2H2vy/w6Udms0S32YKAoi9+KyXGGugxYQGxAH6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

Add JSON metrics for i.MX93 DDR Performance Monitor.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
Changes in v9:
 - add Rb tag
---
 .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
 .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
new file mode 100644
index 000000000000..eeeae4d49fce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx93_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx93"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
new file mode 100644
index 000000000000..4d2454ca1259
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
+	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
+	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr",
+	    "MetricName": "imx93_ddr_read.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr",
+	    "MetricName": "imx93_ddr_write.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   }
+]
-- 
2.34.1


