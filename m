Return-Path: <linux-kernel+bounces-94885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D3874651
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DE2B221B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06F63C8;
	Thu,  7 Mar 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntSXa0ap"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEF4C8B;
	Thu,  7 Mar 2024 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779697; cv=fail; b=OT79M4h12NxXEU59qyhHj/NNxAwoPkKvC2roE4XTYCpW9y3d44knXbpqIqp+0PJi1tnGme8ZN8MH+KVm5dYHwVzrRWkmb2gVYrYqKli4RKg02SAI0gAcchhWvCrgiutfZcktNL+2glYHFXsjidBQVmStELovHfd0lS33wmg2oSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779697; c=relaxed/simple;
	bh=aD1jJVnb9jPeALR9c1BeeVxw0S4hY263Lti5faGhqRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxL5LgTw6egoM5wZG5XsyEAkgfIqi5YJ68F82bU8465y2rwYpMDTKNKHOYyLK9vRvTq1tAt4w5Ynw2Z5ZGfqKTLjFtWYrT9CwwozQt4an1mOwPJfGdbpp5Jb5v+HEnmLYagm0wf5O0fxJXP5CDrFrjpny9zAV9zkE2+WeWw65Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntSXa0ap; arc=fail smtp.client-ip=40.107.15.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+AxlLci8CGK0OcC2uwEKTTwkYwR9WzPx3RNheEcIe5f0MUlAASH6UpZs7NQnpfWImiUBlwjELYHRiqcinDAjON68b/U8w4AGsb619gf/TW5MFVkJcBDHJPpEjsHrK2vYXxISkeqsaPUjFyKQGruPEcFOqcXRhvnO7I/NuMRRH4Dt2y3HyuXi2MiDxUJBH3lhbUBbF4I0pYcW3Z+Zdrb+/IepS6Xjk3ZTkxBo0ZpQE5ScD/MhXZWqXcPASPJc83B5dSX1lRXYQXJswF+FHfaFDJzovQwD/oUD6T4Zme8V0kVVJGjqnfIhwxdAGRkwWGJ0oCpmacMqdRU880/GvgwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjn0r2xSo029Zmy14r8gIc/JC8/9MJtPMeZbHgmftPE=;
 b=UOAjj75kuG9/PBtBP2ozZc/jJDAEtHMSATmUc5CphkfTWJX/TAr+IAQQpOJD69Ky4evtyUkkgGNrVIzcbWTAtCyOZD30GDQihMRDVCHnVCigKSKRBtrvZ5IMmWbpxkD6+ee3l7dhwHhfR4SBV1/g/9IVqHw9OmRg0XGXfSjskI8pvZvC1KbOMbqebwSI3qtQTcrgvGYlx7swt2yHxZ5563XqWDHHbJkCZTwLSN/OprFRKcbbtrUHxq5ve/Ghil/kiQREtlnz1yuvGCF5EXln1pjquYhbUyUBwCxS7IwYx+vN4bP4zPbuoTQCQDAgoaG7uBKNgIy+FxpLutpKq8DzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjn0r2xSo029Zmy14r8gIc/JC8/9MJtPMeZbHgmftPE=;
 b=ntSXa0apI21CtnS9q2Y4MFOGoKaaleI3rG+p+QmYvUOtI1E0AnsZ4dx3QkuzqZCL1dJCxp3tb3KhYij83eQ5S1AMdBAcbDyS9pO6TTwI93Dous/QmBqh4w+YQ86UdMlk+FuOvWYXEWHeqkO/5uw1h88yJeCrwRLVilJTjOAplfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:48:12 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:12 +0000
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
Subject: [PATCH v5 3/7] perf: imx_perf: fix counter start and config sequence
Date: Thu,  7 Mar 2024 10:47:50 +0800
Message-Id: <20240307024754.3469810-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86b8975d-2181-4048-bbff-08dc3e5107ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/DzDqGw8/rblGlA6x8L9sjIkGyqzZaqwuK4n8ejSpZVC4YiSOqb91TJedBBAM/Pq8Qc6p620wnd09Ek50psj4OcTwenuuUUFA1VR0OmL69ktyTaO6Hr9u1lVWp1R6o9Qj/K6TgoF0gOPXvrPKO4W78C+pPa1PtRtQP50KezAiWYDjgDYvRkGp1OfrZH5qIvOyHFFcDmSK9fTBQBw0vRjmNljLT7A5q9BXzVmpTApSeouP6MpYhD0BBHT3QvJQzFAWbdjCjFH7fgo616NJk+WOcoixdmacTpBu5jcUhg78l51hhYLu/m+FJnaxq0Sx7cE57tEIWcuHFSjTrf6EfDdpswyE9bSvWhDsHP7b/nEJslH4IQFL5gPnfqXNeJVEzMwBJnOqswWL9+OecDya2QLEx+X3T1wXLNmSWXIzQBYchD8SJNd9AAhH4QS+VmjKRL9pdQw7kKbmjx3qaIBb3dvPIFZM62dHDt2AVJHkABBE5uWsr7e0hjZfpD38ysZSFU19nCBpayx+n0+8syc2VEK9vmDMjBLl+BBawW4majffW/1Eh6jK6XbpyzJerLRn42QanlUQaulHtZNrZxAoherbAs1RQA0Q1WKj1i6SZ1ON8UTyePOr35y1gdOMKoXHS2pYcz5lW17TCOBebfPCkTxZ1YlRIszJPVlSdK1M9/rQwxdWylI0VdffWMzksp1PvDs9TVKgF3PIuSUaBhq2uY2GfdC1ZzMawJN77SylgEsJOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y54yp5D+vL3DLjAvuV24y1RiRqZWnszndQKwHWBd9Zr4ATGjckvNGOuSOcDq?=
 =?us-ascii?Q?Alg7G6aEE1BUUbQ9QvUzvpOVwWfDLU15aguOli0H5tNzqBidZnpPzeFq4dJD?=
 =?us-ascii?Q?vqCQJA2+Gxk54dEtG+iOw3m2D/UxZhArcHHI7lmOpqJIpCSC684mtrrgMGhV?=
 =?us-ascii?Q?HVkzNZ1dhxPctMGBsUVNuKoE45zl4+WSMqsQn29W/fxlyABz1Qfh2vpA6pXF?=
 =?us-ascii?Q?zVT5JuhOFh9xU4iFu6pVV8JSU01cdb0mUmqzFC2qaolGo7ubgl3g5UgDjtHE?=
 =?us-ascii?Q?MQMCR2j57bM+dBm/XW1VUgMX3vzVtIFqcWdpmSW4I0nS0TZ8bdab2ENMt+gS?=
 =?us-ascii?Q?RE48FyTahxjj/eSXxNw2+4lretL1/aIibofCaTwkKqJWClNGynWzujmYXFye?=
 =?us-ascii?Q?rMzh7+ltbT3YNtmcFNfI1DFOTuqPoMGhZd/R4M8i7C5lD0rA4qPYmr2eG7TH?=
 =?us-ascii?Q?N3zuZVixEtvy321IWxFZR1hrGc+dMVjtr307B8EvbFGgSFBA4wc2d8jH7uwC?=
 =?us-ascii?Q?O+YhsA0/EYQ+i8q/k5TDs4uxjkyc0SRZ7ZP13+Vuzzp/TYu/SNQNRUdSCDwC?=
 =?us-ascii?Q?EaVrfLE6P09UX6olwuOl9cSezv59oagEDxwjjCAknY+W8/ddRCmNtBIfLeu1?=
 =?us-ascii?Q?gmlQWCYvINsBd50x93ipkIkVr1Txtr1nw2O3yd8JLfKPbMibo0yFiSVu9EWA?=
 =?us-ascii?Q?sMTPnC2hVgx6ltM1bJuAro9Pn45A1KIR9gp+KBJTTOJlqct6n3MuEXEA+x5/?=
 =?us-ascii?Q?x1ySMCg/UKIrunFnTt3yd+mPj7gRt+/B+dbnlZzVuRXJS3P49qz7FvCsksW7?=
 =?us-ascii?Q?ekFRwMLVDcBEyEkphN5RnOpJol3GEz5oLEe0wic7BCOY+uXsVzsD52ax7ycz?=
 =?us-ascii?Q?zAmuaA3+SxYpGEX9tdM0fsbquUNnKqU8vLT2rXHIhoorIT+r2Qhpr7geJyUe?=
 =?us-ascii?Q?PeyrnBYkJidmtsFK3koVAAnw3n5dBtXl/dulbVxJVC32so1ftsCzv+9JP5h3?=
 =?us-ascii?Q?RPPc7YjcJxUNmbVsJtzw4hX6XDt/Z43Gkz7aP5n9YlnZgZx8fremyTAXRked?=
 =?us-ascii?Q?FAFwQWgpiWo/J5iiSgl2KlTdl9CGUBZfzkmTmOInK6S1gSJa+bRB+WbskA4j?=
 =?us-ascii?Q?f/nRy09AFU6R9Bb0McbS8BUZg4HMzEwmCd3XGpVeQ07CFSgI2ruLjkkKrlbE?=
 =?us-ascii?Q?U0Om9NC7Qbt7sUSoZYyESwvPLer+ON6KMYEiFVfaXVFkffdnK+oaNa2Pl9dy?=
 =?us-ascii?Q?aXvlTCsrJVv4zsJt1V7bNTE0KKXtxis8Wi1B9pABfcILFBR/y4GmpPOT5+ts?=
 =?us-ascii?Q?tOb5aLWM3VDJxpODW4PWoIqwdEo2Lax8+qKXSI13l4anP0YNkDDIil4SSUBS?=
 =?us-ascii?Q?9g+ULIGA9HO8FoPmEJdQKOoZIRKXLZ9rDE+jyJSTz/Q3jzBlnfnc+24p7bPA?=
 =?us-ascii?Q?mlqiztcKax8X7HW/8GCLQplLoLubB/MtI64rNP5VFoRXd7VIcRXeUvx8dACT?=
 =?us-ascii?Q?A/V+0XaW32LPbfBHuF2b8pdoj3X1SLvaFNu5jbz1sQ+8B2JBWNdajo1gOIVJ?=
 =?us-ascii?Q?f5NA6IDTQfCtu5O41lKHH9701aHBaHmQT08boi9p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8975d-2181-4048-bbff-08dc3e5107ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:12.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etX9nxNN738f3Q5fcO2kuyYhfdN1u2Vkiz2SBoKQNXHE0QiuwQoZaLjl+88zA3Vw6Pz49Dz/5mrfxPgj6VnI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index f4dca813b174..2cd5bcf1d3d1 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -498,12 +498,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 
-- 
2.34.1


