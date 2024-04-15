Return-Path: <linux-kernel+bounces-144470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0B8A46BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B412282F33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5502033A;
	Mon, 15 Apr 2024 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NsbM2cPi"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D918E1E;
	Mon, 15 Apr 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146633; cv=fail; b=o7V/HeYWX7smIACMlMyRf0vugApRc0sPBfTd0sc5kOcPUy3LjvdtZc2KrcJ84CKdJvEgPEgYZDFgW6Dd8GWoan0FpqBh5cV7CTDFTODytKcG9z9308JXNwwWKr+emefapYl/vT47ovYB0iFcinHCZ8yspU5dI7oXukgkLXk3ahY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146633; c=relaxed/simple;
	bh=VhtIFSLoxDJctQdoI3kUuTEoYrxEGzVaTXZBJvkxsdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtrtU5UQoQtrlSDw1erb3r9ZN5wo6fMl/oj8VIW3xDGJlCtHJ/1bzOyhToE3Y1rruWiuHscBHKuEC9dTe1sfAt5lWFtxtLwBA0IRQ1aR6/krvyO/qUDsrurVOseJ8l7hiafWBKR/NoHBDhA7Iyb4XyP4dQgZ4Nyx96IKr6VEI30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NsbM2cPi; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWY/WkBUDKpVDPohFWhlB8Ku4h8muccIUPLYWjn5ZJY2C8JvJDTJvr1y92YKR+XGGCscvYI6NT1PnDDXBQ0nw0y6cIB5EhTCSoCiLXoUu55NI/5/EU9hM7sSZE7/DDp9bO8OkZ+gpti/N7h8bGQ+4U4cnGTfFuKqv+IHrj+1yR6f1r0r1AxSsH2Ysm9yENKZ3pAhI2MXihy/XEpdjJYJ1yiBds4j29j158D+rShwk6cWOKTG5mhLh+a6AK4xtVoMxMtfjzMyPyP6DgCCkmFnVdHtIH2Yokqm+Q4V9GPk8c7qVgJKwpFI5LNn2kLtRKQVsSTPR4X7719wN2hExDwNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LQjDYvdW8tQc+jXTDbv8bKHhC/ea4zn9nLCLe+HWKw=;
 b=lcoloV1rLSAzC9CKdNCXDsN7Ibs047DN8d6izLos7PpgkSA8FYEPt6iAA+La2C0ThRhadVSD2E2tbhZbL+hv2olzafSsOXJiBaYRuanooNuQhoMQB1rlTefiwK5yEqCzVCf2RJzgwevLdVXW7sU7bs+4BxRTsQMWpN1Ytx9O7srY2ZWujxuRwhETpjnGtZMGyeYGYS2ElxSdqdkxM+MExh6jHxx/hcdIiyXRrl8jC8kO1iS0saKH7IMSEy2LdnrMMT9HIsJa5sZlzdtmRv2VqQyg0qbumnmyi6I0yLssahWDtsxdPibfxcPYgsG60wxFdh3h/xOKgfmPikv3LUsPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LQjDYvdW8tQc+jXTDbv8bKHhC/ea4zn9nLCLe+HWKw=;
 b=NsbM2cPiryFVAp+UliP1hJNke0S0YwSNauS5rzuyxEjETqouwNQ90AxYVqFmMCymK5QrKj9Xz0orfOYOOj207TEpDSKZFHP1vk2unWqDNh9mHiNQqG+1+S0a1yCZ9R1T7RFFIKFSnrdqgZcOiTs8aymfFAGoYNHGV9/Rc0HMqTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:48 +0000
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
Subject: [PATCH v9 5/8] perf: imx_perf: fix counter start and config sequence
Date: Mon, 15 Apr 2024 10:03:50 +0800
Message-Id: <20240415020353.3833367-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5524b646-2fb5-4ba0-362e-08dc5cf04a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LxXvVv6zrJEJ7d1HzU+OGRK8SCj+gKOtFyDbuXx1NHkWdcyAPOkWLj5SknXIDPulBY8NaJWClQyLp5ZXVaIxbfXce68w6PuF6LsXLPD3/BF/7yBlqnj4Ct/QQ2uwHSFSY3vIuNuWeGK7ExpJbYuVZJGrHdXfUsgTQRjJCam56iCL7qbhzk1IiPtYvmkqXPpgfthqSB1sqJ95WekB4H/vvpsdLOEkQukZer336TE9mGh0S7nNyd4Of/Sod74YNYeVyWoCUIR3D6KGXfyPy0Or1PcCSd367e253hPM/Rc7gjxjsHWGZZ0HaLKJr9ODtvJWQy4E4QVfPE+NE8QCXSSuYoZ539remhvcp2x1KEAJ2RrpLG9RPI7zEwNZEJJ7iXwnXG3kGiy2703sgCYB7AtI2BUiT4/BC94IuIv+mHrnXQEc5VoQkvnF+wZRG2kmHsMdZnnOX/1VM9x4ejMS+ONKiQ3SuRatERm0G4jP+4Dis8n4JPN4oWTHslRg62Olzb9h9IggDOULq67ryDFw7LudnSAKwytsjR/8Q7eUShSLfBZsXO5WJOCFpUJDk9y2r+7JVP9K3eauwBJbpyeRo1Se7fOG+iveg8EEryJgZy0Pap3X36xlEBBgReBfknIb/4MS+OQpToNXU9EvNRrlZU0a9TZfsiMsiClVCgu5Y3bFZ6zM9lY+KJMRO5SV1l8NGXfZ4m0HdDbOM9MvyGvNL9h20Nj0SddL9y8qvzBJNoVU/m4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DnXQ3rt0ZOQye9Sq2TyC2EnU0yhN4+GkDmdNgU7NVtQIjeg/jwf4rK/ITHCL?=
 =?us-ascii?Q?bKka9IKQmBJCeJ8CQiPe6EjjyFtjn5/LNeNLnELEKKCBZeJjMH6jC8iA5jpD?=
 =?us-ascii?Q?JHJVl2uzt15aY7U8+8BugSny3dObb7ptfwKYjqj8mQIKQMoje5aFnJh8zR/Q?=
 =?us-ascii?Q?WqZVGKPkG3+hpsUrYyd9mrgGUIguoQVr+c/Qu4FeVGgwstwUvgogRn1ER3KM?=
 =?us-ascii?Q?rDgV2BPoNFH/nNW9Ag3KYi0e5o8ssLnDDGG5ugZgNazz9c8b/mLh5cywhBz2?=
 =?us-ascii?Q?BlEZUCpllldwOoJuMH+K4qcskxdPFYsDoxgCz3efdYKmJ4imwgdklLw/FL/g?=
 =?us-ascii?Q?xNYa0Fxz0wPQwkattMzq6IS4HkoAeVZdBKqXWpPwBdG1OiV/yxQzy5lm3AVI?=
 =?us-ascii?Q?aayGkLodyi1H1P2+z8BEUS0+ZkSSeyFoX5XODNAaH4hay6tRzey4q2uUHVOD?=
 =?us-ascii?Q?480ic13HlQS7NLMoInL0RIzFmzXRSPgT/yFJ//NuTbA6OhONqZob+vPkHYdq?=
 =?us-ascii?Q?1eOKxMc5OjS1i5rm4Pf89fpK9kYVl+aNGsOOEKFlMuHb6W0Ak1sbKXe4ZLpr?=
 =?us-ascii?Q?+U4m0HRHiz3Qy5uyCuV/QJtyXaWwsxKy0Hj3RM614JLLZ/vZgG/NnWJPHdGd?=
 =?us-ascii?Q?KcME7lltizpBLfSQZYvncucxRoae04CvEPls5vJoUDfBUrh7jS0jem1mSwK9?=
 =?us-ascii?Q?ayHTP5+XgS/vFsUwvHRgiqYQqfMHzsNGcb0mWuULflWSowaztDQjG1rZQuXa?=
 =?us-ascii?Q?cfHXdS0FKEWp075vn52UErStRxkmIb18t5H+RNLNVmbVjbzOZfzusSPh7C2X?=
 =?us-ascii?Q?sxIfG9imhgcnKJdpMJTM9MiI+GgIPqfJhdzy0TzkPeSMKaMkofvgGzCZigwO?=
 =?us-ascii?Q?cRRxd2tgHUfAY7s8UwMT7OeDCULRkfrKXiynCmZnrxEtz+NpsQvtUheN9KsA?=
 =?us-ascii?Q?CC9sIePQhPR64MNQk1cSLffTkYfSrIQtv0JEn41VR+bGQq/ym+d6YSM6z8ij?=
 =?us-ascii?Q?ySLFEg4i/5AYMwmr1SBtzgWsxEEluLqgEyZV404kd37t7bN3YuMDi7CuqMrS?=
 =?us-ascii?Q?psg8YgHM0CVOwetPQbpcF+Ie9z7Om2ROZ1BQdFdLji1EZAg6F2xqhwZebaNT?=
 =?us-ascii?Q?GoVJsk9Bju60HjvmfSyRjyztYGGqsz35hHQAmmpo918pJXPf6AytiP/bOGER?=
 =?us-ascii?Q?QeVa1tsNyYXDs7wlQLHHfEoo08N14ZgTVdYKRMGzhr+SyZtJyr6cmy8blqwa?=
 =?us-ascii?Q?vmbhmZKPAtItmNOz4BdHA9k+Bwwpu7IxFjIctjk1C0O1s/JncxyCSccvL95H?=
 =?us-ascii?Q?5NaQ959aAplXUe6O1bRmPd23RSMqTiXBOYoWsbyhfBxckdTYbZhUpOqoXJfN?=
 =?us-ascii?Q?tnUQyA3Xoeo8JVqRO6Uz1pIEaMCUaz6YF9xVLTSJzQBRJkT361yE6fNZM5wY?=
 =?us-ascii?Q?GqdfS4hUZKIoslckkLTBM0SVVrPCx7qr1fPB4wSFM4SB/bULwEsPSbKyGvcI?=
 =?us-ascii?Q?3U3zNEK/mieMOAjP5TKeXeZ+Dr8c2VDJaM7bgGBYl96ywH+QCb9Z7I6IOGtT?=
 =?us-ascii?Q?xK4U9SUpWKaVvkqJaj+A+AHREmqcok71PM9DmRGj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5524b646-2fb5-4ba0-362e-08dc5cf04a1f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:48.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv2BbXaKwrZABlYPQdvduDxbrI8zD7Rbc2VniR1vyQUnxEng4M+H4zx6sOsdfvxWqzsr97+4T8H8POWgARj4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Fixes: 55691f99d417 ("drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add fix tag
Changes in v9:
 - add Rb tag
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 1510502862fe..910fda7eb2c6 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -541,12 +541,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 
-- 
2.34.1


