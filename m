Return-Path: <linux-kernel+bounces-111007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871138866E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1474B1F24B36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC517998;
	Fri, 22 Mar 2024 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTudlDjp"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43451D30B;
	Fri, 22 Mar 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089604; cv=fail; b=AMZ8ncNYX9+1ZuB/Vy4C06aqLY8bHH/44x0O0yi7WR3Bwf7b8aLVl5tP3uZ8TR32UcsJSaJhXsMDMInYFdZ1TPz/zeJYadCel2pp+aED54tJXaEKXAfgsFJkYzsPdOuOXI0r6dqdaRBRUB8kbk8c51ViZel4g/weL4tOzcKdsXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089604; c=relaxed/simple;
	bh=iq0aeOXRtYSj1S1qQsrH0OYGqDtpnssctSdsD1Uxh+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plC09FBsSHVzbxtYp3ZE1GhrUjrrBgoxzhzY95u8pcaksdSxmeAogqmFxHeZ6e4DHW6ngBMKLw1rFzEENT+OhdpzG1vX7RHYrsCmkcy8taOuWAU2ohErU8GWB7CXfw6eCcNl4L+iW54FbB4gFA9+5iL9WWoLnsYXL+0psLPfrKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTudlDjp; arc=fail smtp.client-ip=40.107.13.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwCmrBsRpNZwdotXEGzrqe0vw93K8TBXGGYuF/q3Qz3UW+xG7XbOhy6/tTkj9EjTAllw91TPDFlK1fNRwxUct8GsuJpX6UQ26P0p7lSs62SnnepM7VmF6gceVsN28VjyWSZrE3XZJL+hkCpovCiywRQGJ4D+2IlMVcGRZD5lj+8aU9KNqzXBA4BExfj0DoPfnzUFhU6O2QWNQh3QD9i3xnverJd2Sg+8jdKTyfPFMscF/eFcQ58QtbEH+Ingl92V1/uod32Vz9hR0WCQtBTtUNEqaXYrMGrzuCbUdplGur0tACquDr8Q05oDhIHQ00wi0J77K+eq2xvlXuWja7wxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IViR90ZsEm7l1zdbOidolnyGedq1oAOZ99AzYJwXUkw=;
 b=USq8fBxPzCmMF3/4NZBe6yUa+H1OnXppA9I6uRjkTMR3XyVDi6xfao4q4lVprX3as57taxN/4+b0Zt7WKLl4eXwoqk+4W2ZfMBUb9U/WJgsnMsEraQjeyR5nSiyh1G+KlekCTE5XkyhJjM3NUgCtfMUgp82KXcHTJplwykBNNuUT0HVs4wzM7Qv3RW3NFBCHLLnOahyqDoQPJjhxGngSgPmmO1JXK/xmjzznAZKCENZcJVP/F8YdOf6GXbcMxsujTtnee1l9NvhaSZoa63GZHpxcHSQ0RiV+l99cR7gjV+hpbHOUxX5IQwC/0Z1KONz5vAAFblIk3JnHX7Ck3+sBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IViR90ZsEm7l1zdbOidolnyGedq1oAOZ99AzYJwXUkw=;
 b=OTudlDjpCNkuIRoD2/9ngJXf/mF9oVD3K0Mh3i1/xuQySbbPFT5JWmKmlF+KzrImr+HyxXb7wqOBr0TPhQKcoqyuFV/1WkFtUHojjsOfYsNajD2U48D1TP/uvNdYs3RKvupRyG9nem1dWY0JqIWwWgTaJDuYwyE1zYgyHhkcgyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:40:01 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:40:01 +0000
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
Subject: [PATCH v8 8/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Fri, 22 Mar 2024 14:39:30 +0800
Message-Id: <20240322063930.749126-8-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322063930.749126-1-xu.yang_2@nxp.com>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: b747d162-ee17-4187-d8f9-08dc4a3ae647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCNBeNq7/6598cCtLskV9mbLHxnqebLqtIqQRW/i69WWwNvW62phphawjKy7wQ5FgSJn7BAIn1sWbNydSsixW5pERUP/k/jmYXUosduHPlY0fM47ZS0IgXasLnbNNsQl8/XkMRnvutBk4vrY5l7rt3jm4z+59c5FLgcrJbFW6vqS9mxSPHcM+0pjxTs1YlPypR+R3YXM/u4iM1XCaX3/iNYFg83YKdHAi3TAhU5EwEMUvN2EEl2qMucqyjtwMXAxlbKV24+P4hfVTvc7iA0HuM0GsxeQnFcFV0t51DNL5Ib43+pUKZ7fEFeUeStgdzxsPxhhIkWWjhPc/yCpJKwiNpxJS0XURD8fkx77qM+A68gi1QNvhLQVcstkzk2um1ZnMe4CMk0sLl6QhfL8wHVDAqc+EM/XjKVaa4Owi4ojcoVr1sSy0ksK9kBwqOZ7Duy26mcKyO4gADjPOX+lmJmNyRpPVR6RQgQyhCiu6DNsu7CjZ0c+yU60mvsf2a/1581OfYVwqJ2js5ScXG0GpfrbqFsXAQf2hpiP+5wACGIfInleHgFy0IXmLKNCia5QA/qRNTlB660UMhhwdSQEach1fSWxlNeH+nUJ4no4wrmGMTtqYY7UVMv48AtTVV0Ef28MB3cD1WCOndSEvrtcvsQ/oLz9hCxVIcZ8EljgjVbt7RrBXrfcb0KZ4HCcJT/zUtYY9t6ESH2WUJoCSiA62O6A/f40oix+U7qqtzlCd83imUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YORkAWrR4qpELRfRoQXorGgwnBaGg4aSGaaS7nUQKnexkmHw+EoZUuJX10Ce?=
 =?us-ascii?Q?BVWbLPfJlCSm88e+5p1oTSKwDyXzsGbv7E42yMSfsgtfoWo1aMPRqhNgM3/5?=
 =?us-ascii?Q?h+OFtKmHinVV4dhDKR2yCC8V9mW95etaibHdJphZdwf9nV7QAgujtMsAUCcn?=
 =?us-ascii?Q?Fvv4hSqi6V6pYknhKyy1zgOoGvxD7ATKN55iMHY+x+KAT18jKU2ZbTiumsSF?=
 =?us-ascii?Q?XBaMfWgvO6GUUTGw0a+d7znYY709dj3vfwf7Cmqz+5dCZferIzoZN/F33eQ1?=
 =?us-ascii?Q?/BvUJKkyF0dHnQMTByv51niJxd5erXDo19McoQqkLv/aharKqk5F2vvRFr1B?=
 =?us-ascii?Q?CyhZiIss+acLJC3rvo1TTNwEaP6Ue4IAWZ+zelZlzUl9BIi2z33RkcNWKLR1?=
 =?us-ascii?Q?Da6b6U9xJydH5gIl9cC/OoqmcSX0vVFchfIct5ET2xaDuQwJlEz2eP1l7rbf?=
 =?us-ascii?Q?+kjJGl1LlsczeNt2fgob3gYUguwNAU6oi2JMxXgJGVeq48gdS0nAOPWApxin?=
 =?us-ascii?Q?oUV0+Sp8zZsTE7DhgLrwU4nhFGtIn1+0LdZlIScWlWy0GrxQfehwI0AAQgPw?=
 =?us-ascii?Q?u6g6ELcee1cmAr9tK4o1wOODAeP5F4b0Wc+L07Hfpjpy7rfiJFghNUSHb7x7?=
 =?us-ascii?Q?AGs9u40IaK4vBHdjwZpSAd7WQvm3exZepwtF29/KqRfd2jPUT2NHJRO4xzGs?=
 =?us-ascii?Q?Oey5M7RhLHkUaffy/2uq1RRZTC8o8Th2jo1+s/mbc+lJyLzKTw9ZEteWvLbW?=
 =?us-ascii?Q?HlYCjuDUFZ9y4xtf3kuDRJ/LGFRtGNL4aayjdnEdnQsmfav8KN2+UkT6f1W4?=
 =?us-ascii?Q?wthF/2U3R8F7hxFk43UtAj7k8X/5wQdBtF2bdYJqwkk0/nOjeiO2t0XnOsOb?=
 =?us-ascii?Q?pWqlN/hj1qfqhl5mIJg2mhWXWFeZsNRTf6Mdwew2QK3jBbf6D/tG4bTghmaP?=
 =?us-ascii?Q?YPD09Q0aeDGKRgApr8i4znSMu6AWMrJ72qgXCnzXrn5cIK9OQHpm232fIc4b?=
 =?us-ascii?Q?veNudCrqSO+DVxBPYIYCxeN4QNZTalUSMKKTETDw+fXmuDSDSbhBZqK4yieZ?=
 =?us-ascii?Q?O587B/lg5BQfDubKqQNzERP8eqHUIruc2ipSC3ThJ3VuI9Fq8hHIuU2qKTl3?=
 =?us-ascii?Q?6bpNfzBdlX3tOdItSv9o2sGerGqiIRyfN3Ud1tc5wPAjfUjc+JqQ0lZmKEqY?=
 =?us-ascii?Q?M/REs0EmH2RhvTVf8FNY4ygTpC50s6Q8jH/TcuszY0YD9uhNdIQxzlnpnSEp?=
 =?us-ascii?Q?n5eWK/CLbDfVEh13m39qDVeWwzvI6ycycDTVczOF7jjNq+vWRK1pIYFg9UbK?=
 =?us-ascii?Q?Z3HW10sD/3s/fkQdJeuolCdO/XO5IL4mhI9LChd4SIHPra4nEthmlV5pDn5v?=
 =?us-ascii?Q?FdmGR1QBSSqre7EFAVxQ/wBuKyywWzF5YtRPAnTk4bWzEuMPW16uoOzlZzSM?=
 =?us-ascii?Q?TMG7X2vp39/7cQrOLQn1Sk+A4ZJK8HnpQAPd+6mld+aYuhLflcNx4QD0WwMm?=
 =?us-ascii?Q?vmzP2ktY2kcqCYdqceB47kmJvyBK8eGrX03c2SAtRRtugGEtdu9haNplALql?=
 =?us-ascii?Q?2oSyjDaAhQT99sKe4KTg5PIpjW+BjPqH080ku+kP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b747d162-ee17-4187-d8f9-08dc4a3ae647
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:40:01.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z2JxBFtWvzvjmu+196flzwQ/2IeVk0TPJ5TuGAefv4GPYPHmnG8liGQ6zWCuCnYrFDSGo5fMasxtX2RQ3tpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928

Add JSON metrics for i.MX93 DDR Performance Monitor.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
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


