Return-Path: <linux-kernel+bounces-95280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA2874BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B59D1F238AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB7129A68;
	Thu,  7 Mar 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o2/yHDAm"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B184FD3;
	Thu,  7 Mar 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805455; cv=fail; b=Q67OaPNPGGaVTeg3iM4UqVx/xvKjJwYTDPdGV1x+TNG0zfpWjSrPxGc9gk8uv1GYvBzMAdu2oGTrlH09Ln+b1ZLA4A3Uqoe586e0GCY7XjH7ZJRoikOBe8OoWA9DlLvp6H0DlwdO80WcmxHoVeFM+/L8P86OMEr8otrrfYO56KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805455; c=relaxed/simple;
	bh=kyTWMp6dEGTdTVopemiSiazWFrZMpxaNHgMYhapHgBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDp98K4KK4Ny2zmwuqMkvmWF+wOWjn8uF7zEJqRnmHWV5b40BZW7y+FWRHuVA3Oh9WwGx/OLxMjqWV8E0Gov0XZUKDqviGLGqYptMaliiyxaDiozpx5KuVolUEYEfslVmUxlnw2fBqFDDewIiD881b6v6txIYuY0xPPkRcVOCZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o2/yHDAm; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8A0xqB/NwltRF5Pf23m8N5ODCkuwkwC1r88psefWkGZgWxqmA4Tt8cGeoiNLrP5cT3vAreKDYjTel2IdacWAhOpePbjVNIsYArSBf7h344EyzyUD+gJBEAa5up2Nq1Shq4w8FI5dQd0nlK+b2CAEEVNtKGv+kThgSpDv1dyc+OqHLALead+xnKX7YZV4DRTzrGp7WQD5OCUApkJ9i/7wHaxNWiLVJ4d8gA7px3tcBqgcjT2nOq23eYlTcQJJOrJ4V3CW8OCv3WPtefI57Vc65IR4obRFQzrqXerqYn9ZANso+mwxPkBv3++WclaKyMPwC6hi13Y7Vr3swshfokmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSeSPkwtLOTMXf4NxSxuTegX/doYDSiFgycD/Td0+bA=;
 b=WSaLQK9tGLyj/b7p/NDeQnmGFUzpOuvfN0MibV1X6IzB9mV3yeeaF4VL8E1xKrZ4gabW7tv0SLTOEeMvzzCmxa3sdJPtxeKdXf+VM8kQR9DnW9Ux/b9OmipdAsCMDa8Q5ce+XacPB41gbT6HjXho2+nXzS8k5HPLSsCChmDOcuJkztlN+KwxprX2DGJUYECbnYPK4qkUSbI6XWc2/+wdMc2w7V/QBECyilh07RQbYeHVR1lriyXNX/Reho7QoBQfIK2+1cgm2B/hnYOXHfiyS63HPB9EoUIsS1OyJzJ2lMxxp7eUjT1oL3JyZ3UlE9iBlyROjPXrxCliCpf3k2FO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSeSPkwtLOTMXf4NxSxuTegX/doYDSiFgycD/Td0+bA=;
 b=o2/yHDAm/MtyHA21Bw1aH1jQ82hpFJ9cIq7T/fOFmBFgaFUrSkGDwRqk96R1DmGCjRSWcmbNrQvzPv4KDPBOim0USn5AQ1pkfO3NWX3QPf/xNft5AxPNBSIF2YKdAhjmnlmbtJsK5SrU8tLgHC+PTt7PBhevwnOR4og9nHNtPOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 09:57:31 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:31 +0000
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
Subject: [PATCH v6 2/7] perf: imx_perf: add macro definitions for parsing config attr
Date: Thu,  7 Mar 2024 17:57:25 +0800
Message-Id: <20240307095730.3792680-2-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03721603-7b99-478e-3841-08dc3e8d0148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fo8KOgwgYLUaHFHb/NHzaQ2oygjDsobtP90KOJ6UzWVonRuQWtyzTreYDfQvpOotWWboeWBSfyUNszRvAwJdVX9R0gKrTzt5xT8wxuEJc+4LAdJLNQZ2d4B5F2wzA+Ka3Jf8pwSY+3xaZ0LASMmtwnZGJbcFKyhwfuDVU+O0udLhPttkapkm7m1/9etKy2dUdcDzQRgWRjJc3QSkNPYCYSy7FxqC7M7LKS/v08fWDOGjkjEsW2IBtTsyLjuT9XAh3oS8e2AhCH0Ph4RVSVTbYbcQoimYb/z3B+Lm1IxmB1P9RNBqxYBJUbTaXXmos/dJKw0zWwnsP8ZJbHq/dTyNKZg6R5++lcPmyxxWBFC/AOSC6wROYJ2zkjWlK+cYIP7KOzjIiDfq+do6pHRFwHf1zVGQGhzgalYIKftMP9WvUmlYWCmsQ35aa31ODJuVGdFmoVDkaS3tstGHZo7RFxZ29H2IWVdIlPKooX1SIVWX5A6tzQkH07J+P0d48teFOmA+qsDXz8a8mqEHeAT58GANeOUXu40snAefZUM9MbpYebXdP7rsqW+ZXI7qa5mZWlWZFEHQRnds+9aJMT0f4KEdxdxUJIxj6ZBA1iC/1ihY/41SUlYg5gB5lQVlErtIZmzFU+6Fz6MYgY+cXphJzSH9WaPs/Edxk3ExfeVMTJLG9RcnmhhszpM+SgOscupK9lfGpiti2mek6zG/JPYp90bU62eX38W7OobOV6EgYA80bGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5C4h0fMRt8wX5B7N3CiKO1WbnL0AL9podf8paUWZzqwW+weU2p0e7djSpJ6D?=
 =?us-ascii?Q?nkM5Ux21rGeQCwVAdqEkZ1GPKibVINNZAAHbTjVEU8SaY1mQdWL6CptkvPhm?=
 =?us-ascii?Q?gEoZurGeajN/AiFnWS1AovSBZSt+ARB/vyWlghlyQFc90/OCIll8TxDz8GMj?=
 =?us-ascii?Q?TdTfpksFx5IfPXT4N++1+/F9sG0R0MJqvtGauOIaOKFNAvdKcPbkg7RsVcKU?=
 =?us-ascii?Q?171l9Jr1M3RkT8/tfZuJINzYeFPm4KCsSJ4ok9x6QCysL8WjHyQkVUX2ppEh?=
 =?us-ascii?Q?oMHZUxSgHkzNpMTAhu7Cbg597bQyGRYG42iQ9EPE6SJgVsSw4Nzd61XpA1JU?=
 =?us-ascii?Q?GXUKW5rN96BauI4mmxqBu/uQZXSRul9HdJN+WncB23235DwTCvk5mo2fV8nW?=
 =?us-ascii?Q?vAhUzBU1fB5/wWx1hYnpINNJRgA2NTuo5tFrT6YA+N05wp3tpxwSIsZWSysu?=
 =?us-ascii?Q?3xvyMkzo6LEaxLAGppABrXYfS1Y/lVuU6uj93HTQayN7/f374LeZ7NYpHSsz?=
 =?us-ascii?Q?CyiM1JMHCwtUvABizcelwjiJjt/rX5zRl2/W0Z9bWrwUdfRFcEbaArslEDDT?=
 =?us-ascii?Q?WkfBPtfM3bLtXegNmB65tpE7J8gktkqQ3d2JwSU7ARQo8eNiv/avaTELUhyl?=
 =?us-ascii?Q?frUlme3Fx6gJGSIbWPZ44552AjniR23/lkCnQrFb9CXLEp8C/mfapt1OhOIg?=
 =?us-ascii?Q?jgT/Tqwui9V+e5ijbSrNHqxiS5JASbwAMZAYdPQpQviENH1uwsyF2p3KeQws?=
 =?us-ascii?Q?ejAr2Ta35unEKiOqpCr+3kTbYJ3GaLguv4RKyp+ZaP9JQLpwlZcgGUyc46KD?=
 =?us-ascii?Q?4PNDqevEBCpnesC7THcpeEgDMeKbalynjyly/zvaI1f3jFaMLarddHTGJSZe?=
 =?us-ascii?Q?zk2uWysAN04IXJkloR6ZFLvJ65uNofw93GxZ5RRoEmNOhNAydxg6b3SDbUCo?=
 =?us-ascii?Q?AdW12M2xoKZy/FrM3WdZh49rMdPn2GriiKSORqpyBdBQECg4/fsIPvxozK7H?=
 =?us-ascii?Q?iATuoT5xGnKDiSJyZiGcBO8N+jjcdpgGxy39sCihh+VeWAfrdEjFmQBpHS72?=
 =?us-ascii?Q?8etcVV+yGLlIla8WCcn3S6j8mSMS3CKfSUej0OZ1gdmjuf0NO5WD6qYlVEGi?=
 =?us-ascii?Q?/gmtFIyDf3++0olUAP9x4ENz4n13Pb1vPcMvPa+inDy9uVEe8+0Ap9WS8evI?=
 =?us-ascii?Q?xv+EIg1ohWGxNWZfl7lzGbmXjEqhu8SsZ2Srz5cIk0mCWVBCWdhFIoP92FQn?=
 =?us-ascii?Q?v/AE6pJaxKTexTdwZb//3L3lZynjVlvN42P5kHzdq2QsAIDigYivKL62aYkr?=
 =?us-ascii?Q?f3wx3pNFf/KmAndmnR3PELFjvpi/+ObtOCYIytGWBYBaUdql4rFfdSqmAWNH?=
 =?us-ascii?Q?R+b37AN+5OEqoJbpWd1vQb6zojJIibB/9Se4IVV2xYjFoZmLGjjLNkUq335O?=
 =?us-ascii?Q?QXkcO8fnNbdnsbV6kgpVsdUaOjpdWhSRJUUA3iW+LdRwKYH49orIEqFWecp0?=
 =?us-ascii?Q?xzpiJ14cw2XjrwUletFNrrfYa5PeqI61tk+cyv23K5aiIy+5/L2EFPLuNQXh?=
 =?us-ascii?Q?ymXs/+Ncx7aNOykDdzkap8/F1lOalC1UGhmxBF4A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03721603-7b99-478e-3841-08dc3e8d0148
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:31.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+/qBuHQI27LyPvFmE0KBe/hVdjjEm2V2VN1Gk7DZLa6uiLWjHWVJs01C0xMqTe5rlYgC5d+xn4nAhA5TTL7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - move this patch earlier
Changes in v6:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..d1c566e661d8 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,11 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT_MASK	0x00FF
+#define CONFIG_EVENT_OFFSET	0
+#define CONFIG_COUNTER_MASK	0xFF00
+#define CONFIG_COUNTER_OFFSET	8
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -339,8 +344,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = (config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -352,7 +359,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -366,8 +373,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -469,7 +476,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1


