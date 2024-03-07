Return-Path: <linux-kernel+bounces-95281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D29874BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5911C216AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E612A141;
	Thu,  7 Mar 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbQLenlt"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BB84FD3;
	Thu,  7 Mar 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805464; cv=fail; b=Z7rCRUE2YzboIhO5y/am+s458mLLthGwD1KoDWhW81EPs47oflWH1GFqF4c0tEIABm1rO6Q20zaVyhcEiovqnC29bFv5/v2FFNJ6Jl0ZE+xT7z5Luf0i0e6xTURMQPh8h8ilQqnLEXGv6SMWI3UupTSZWV707+/h5X3x02oe01E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805464; c=relaxed/simple;
	bh=jXkNpCZsLhSucEJLaqmERZGAUbJTj58O1VjlhwFPm/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCjmpZPpytEQVW5yCljktkzVTCwPHeB6E2A/rnH0X59Q9Q1vy0A6sOTYpX3qgiHYeAjqcUfR8wBx6j9sIQhgTgaOL7zNH8lQ76OL0ISo9apWA6+gRFuu+FO/R5bjIlP939bsyBpbylIheWt63OvrRD6w2insnx9PnM3/k/u4LkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbQLenlt; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSnv362bhLoyS6bYJyJfL/xWjGSbL04hajrckBTXVNEa77BrvMuAwbJcDXg5/M3U47+9vGbqznmqZPo+Krd5eUPllZRXe1jaw+OTI4BlYxstzU7we9ftD11a1EajbxovJmMNZJMnLO2f4nx7RXa6EBOzogNkHJMqDre9O7ANlVEMjnKAl7eiSvkyaCquBcxLSD03HhT3JU4xUPFMsDxZFsKakwP9LCS+fgdPdRFcJNHIoSJdiA0Gm9UtT2v9LSDKJntuYfgp8oJZ63ecB1Aqg7XByLNtgcU63W/ZG40kUepA6BOhq8Yek/uQHv7yySTChLCKiQ7YXXEBn1EarBnz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0IF9chlpVscxM54pVRIff9nKJT+0ZOCxABfvJslcYs=;
 b=J6HgYkzRPVBHSjU/bd/VSjSoos2dgU034tqC7VWXFrpQBP5GwHVAErjvAJzoV13EBdvWP+AC+WAffXtrsanu0F+wXvpstb6EL/ATjjjZ6jzBT/FOvY1f/U4U0yHigc6Jgowo2PkB+Wh+x5buEHSw8AJBpcsyd1G44ZwvBguAxCP4szRco16MU3Saa6JgVNL1F9ZNRJ7PT/4/VGus3bSOHDjnNLixcJMWaQUpdzkyKKeF1kx7GuB/U31wA3vEPgE+ZyVxw/+tvdkGRcZ8vGoSAkfol5be2RRcpDkPELGeeiL/Z5GLMtvF0MrsB0CUDYhRdumg1x4q6dSVnz8oaJbyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0IF9chlpVscxM54pVRIff9nKJT+0ZOCxABfvJslcYs=;
 b=YbQLenlt+8E2D2D8tjSp3bqMZHxnCayUNK+XOIx0IshoJqeCvq00qbyZezDa3akPB32bRzJZgbZ/aLooj1IIlafVciH1jbAi5JZ/p0wOoKy+ufdZYYxrM2Csh8n5i17l/Se7e/+QLG+lAX96N4Ei3PhYdW85xwEqidbOy9YZNEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 09:57:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:38 +0000
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
Subject: [PATCH v6 3/7] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Thu,  7 Mar 2024 17:57:26 +0800
Message-Id: <20240307095730.3792680-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307095730.3792680-1-xu.yang_2@nxp.com>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a29084-cfb6-4cc3-3627-08dc3e8d056d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6FFN49jho8YzuixVEstENmXTo//LvoBaohNurkohnpXAK2tWVmB0nJ/iZ0ZDA5ofhZQldGy3N/QSBz9TlbmgezinPmxpK50IYtkRkSDynEMg+yoy04pT0n9K1tDs303PZuozfRZU3Pxsm8ejdG2lFs6qXbNyh4oGue5PQ9XzBkGCTs9oPynPxwR1V0ElTxitBOyhnyaqW67WHbB7eXioOYUZ49PafkI3BN69TC4S3HES9Euizp0UkN2CWHSJAHHRH60y96h9z0vDF/L9mj3MfwpXUBkjPcQzISQZrSRWodmD7T358pXDAeFmzA8xkHbrvSQa6v0AVOlDejW5wBDyz4GxLuW7ZkcdraiGfkIadmHybEaqe372hpzF8NpZrRGrcyIlWIvnjUOaW5UyQOIHaTIRKhRN2vTk2Jf4sKjSbAijoLdoZEZ0rGuvrKCNiaNbIJdxmRI357iT8aoltf6aG5URpaJf/j9tZZKlmJtYaFt265ui4i91/a6JapSeiDhIupQ0AAbb16HPSGf7gYWpnz9IB9ny3vVigFYOlqiTm5SRPjkbV/wXtg4XdWCn/MguJOX+zWhpOR3aGIhXjTSUiKl4HNm4fMD81pdGm6eLZ0CpY2prQasLhnJoSV0RedL1/VyoxHk11Xu0+WhPahqqsg0Y5nfssG64IVQJOR2S8JyVcFvupKEOwse8RQDWhQaeVJ1kav2XVbCWul/fjc9Nu7TdwQdlM4GYgyMVL27Ba4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Oo5K+speK/Cy6s5ejWky6/RfNzWWwFolc8KyBVI1sn4xcXtii9+5LGKPlZ0?=
 =?us-ascii?Q?dRHsa7GGVgCK3UlHGPvKtwRWSfZFp+xKUysaYOnELzAjdNCqzLZmmEE/1U47?=
 =?us-ascii?Q?WnesnzcEEBCaCL4HYFll6IcfwZRgQnD5M8P+9E0HyiWPg4BVIdZ4rPfNsIG0?=
 =?us-ascii?Q?Ooyh5uZPKpKiekIZ/iJLLX8U/xjPHIV0tI7vxnsUZUMAuXyDOHY0GzxRPTSn?=
 =?us-ascii?Q?oktOWz7lP9b4MUN/UB4c7CxagHIFO+WSm7rXab6+XWVKV87hHy8R/UQVbgLv?=
 =?us-ascii?Q?tXHGk6DzrQGbKvaWgd/Oi8nTEK3deVeRj3RdJ0V74mf1e8sfTmZj9qqbjveG?=
 =?us-ascii?Q?WtkG2nTFPxAfc/xN6egJ5BE8zVFH+fc6wWz4APFrrz9nmMHlisd9QygfRN/2?=
 =?us-ascii?Q?95Qtmzbb2nvDePfo6IIR+/8je0KQwCqextsCb+Lpntp7DHYRlHoF6KALdzNp?=
 =?us-ascii?Q?bIUTG1asIkg+gvy21LtOJ18il4ZGUpjZox+hH8A6MgPJJNxSWAIjSY9uj7J7?=
 =?us-ascii?Q?9NH6ppo8slyEzWzWmvE13/XB87CswL8ZPOEnX77/IbZ0cOVOfcbJdUzVhj7o?=
 =?us-ascii?Q?9lvWr9PTs8YHuYaCLV0FdSjD9iqoLVAoUgGVlBrsN2cJOT0nt1orDEeVVicz?=
 =?us-ascii?Q?QcN5KOVeBL3eXyk8lc70GP7PGBlufayoq1tGnXI9e+sv3cE9QUS/u0VIBjnc?=
 =?us-ascii?Q?P7hiyrfBzER94ZCeqElbea1W/FHxJ00/BHuJbDF6cSBkzuYwVxpVVCHXPtDR?=
 =?us-ascii?Q?AZNUDgTOKjt7u2jnBS1Hr72k0oI4QO86a+wcN6KbUwRF5G+04FVgtE/x8M9B?=
 =?us-ascii?Q?7OZ3zq8wQjWrCVs4zSn0MILgS43ciWQriL5h7H9bjp21Si4S4k4eOEPrjJ9N?=
 =?us-ascii?Q?LIMqFJbGP1W9RP//7CWxe+iMEjiK77GkQf/Yp4DI61eqEIHxdMsaRKKkz5/o?=
 =?us-ascii?Q?gUABDt/QdA09aTuLRVjOks1S8ADjTbWOiIMZo8ZqVJw49r2qkawZ/wY445gr?=
 =?us-ascii?Q?fBY+MZ5ZV9c9P81TlgSv416Rd0y1zjs4mvy1459QA9FOpxVyVOg9yOQaQASt?=
 =?us-ascii?Q?muwvKHPjK0lwwl+kQWBXV7UNY0rd/6ZTskDX0jzzcYhzZ+Oazu+DKLwf9ffU?=
 =?us-ascii?Q?BhxhK9R2UcCAiuaMXNPCi4JG+mKoPW0DT1kn8Pq0rr4hSWHG0JLA+7RiFdyi?=
 =?us-ascii?Q?+Y33ZeEukwQpLnXO2VvS7xCLXJOf4JnuGWsp+eclv487g2VQv6eq3ZZ/42fW?=
 =?us-ascii?Q?YtsGfjUqVeXE9fksZlBhZgSRkPNRqC2p7BUTSgbn+66WQ7HgplNZsA290FQw?=
 =?us-ascii?Q?0nDGHLTBNYxTq9cd6CfjcyEyj0VSq8TGb4Ie4tzGwZNok+zBTgeb7g1y59IK?=
 =?us-ascii?Q?ZgWYOYK8CQ0wnjrHMk2bhUZbFxzSXEaZRq1+39AdXAZDcws4Uh5K46QX/fE3?=
 =?us-ascii?Q?LQK7FOm1yrkM7K4+OUXeAeFZ6j/h0QdQIuRGA2g07ZtMcKmJ0I17mYQsOntF?=
 =?us-ascii?Q?h/eJRWJu6QPTV52vkcA5yPQxPfx0PCdXTjyxtWXERKtYq5skrrBGQ1H0uYHw?=
 =?us-ascii?Q?AAq0/+QseMjPphIjGRID/bTmKAOgALz5b6KfiXoW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a29084-cfb6-4cc3-3627-08dc3e8d056d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:38.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXkVbUtk6WZgdT6iW1aAwEKBeRkjbSjUlrBMyXBRvkH5qF8458HF2TGNTi0JBAK5KokeiVipdFDgZp/DIgrnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

In current design, the user of perf app needs to input counter ID to count
events. However, this is not user-friendly since the user needs to lookup
the map table to find the counter. Instead of letting the user to input
the counter, let this driver to manage the counters in this patch.

This will be implemented by:
 1. allocate counter 0 for cycle event.
 2. find unused counter from 1-10 for reference events.
 3. allocate specific counter for counter-specific events.

In this patch, counter attribute is removed too. To mark counter-specific
events, counter ID will be encoded into perf_pmu_events_attr.id.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
---
 drivers/perf/fsl_imx9_ddr_perf.c | 167 ++++++++++++++++++-------------
 1 file changed, 98 insertions(+), 69 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index d1c566e661d8..8d85b4d98544 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -41,6 +41,7 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT_MASK	0x00FF
 #define CONFIG_EVENT_OFFSET	0
@@ -132,6 +133,8 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+#define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
+
 #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	(&((struct perf_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
@@ -164,81 +167,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
 
 	/* counter1 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
 
 	/* counter2 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
 
 	/* counter3 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
 
 	/* counter4 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
 
 	/* counter5 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
 
 	/* counter6 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
 
 	/* counter7 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
 
 	/* counter8 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
 
 	/* counter9 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
 
 	/* counter10 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
 	NULL,
 };
 
@@ -247,14 +250,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-7");
-PMU_FORMAT_ATTR(counter, "config:8-15");
+PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
 PMU_FORMAT_ATTR(axi_mask, "config2:0-17");
 
 static struct attribute *ddr_perf_format_attrs[] = {
 	&format_attr_event.attr,
-	&format_attr_counter.attr,
 	&format_attr_axi_id.attr,
 	&format_attr_axi_mask.attr,
 	NULL,
@@ -368,13 +369,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+				    int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
-	int event, counter;
-
-	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
-	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -394,12 +392,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
 
 	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
 	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
@@ -467,6 +465,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		// Cycles counter is dedicated for cycle event.
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		// Counter specific event use specific counter.
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		// Auto allocate counter for referene event.
+		for (i = 1; i < NUM_COUNTERS; i++)
+			if (pmu->events[i] == NULL)
+				return i;
+	}
+
+	return -ENOENT;
+}
+
 static int ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -474,10 +494,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
+	event_id = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
 	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
 	pmu->events[counter] = event;
 	pmu->active_events++;
 	hwc->idx = counter;
@@ -487,7 +514,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
@@ -508,9 +535,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 
 	ddr_perf_event_stop(event, PERF_EF_UPDATE);
 
+	pmu->events[counter] = NULL;
 	pmu->active_events--;
 	hwc->idx = -1;
 }
-- 
2.34.1


