Return-Path: <linux-kernel+bounces-111004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED48866DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF72862B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5410A01;
	Fri, 22 Mar 2024 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYAx4f1o"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3415EB0;
	Fri, 22 Mar 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089585; cv=fail; b=Ka4OZc0yL7FZRtKya/xqpTILasdh2DeivLV6Vcqun4VPwPXBIulVykiUIEaCnyfs+T9yib4FgbWJsWDGeglm71Q3QatCM7fv5ehSVS8MZSXnWQ0FbueUPoNc8uscbV2wfip4dbe5yBDdAOKdYi30FmlbEb2s+WcHhc4xtltQOuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089585; c=relaxed/simple;
	bh=r47Euoa2ii1USCQHfIC9SqFrj0X/J4wYJD4e7NGvd9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAzhbBQYYKZBtp3Z0VCVhfCKFXB/WX9xlJDFETffafq9+l1V/Fmg9VJxYau7ghq3LLCaI0/tV12oZk+QP3ZmOIOdpN4PXjSQ5V8Ve2EozdbAIPn7FVI5aF9i/tyv5N8wnwwFToR77ncMp8VCYbJjxPd1xXkZGkkaRB1zFG5mS/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYAx4f1o; arc=fail smtp.client-ip=40.107.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z98F9MCZkabYB2upJwgOMDakqOxV7MyrLDBxKSmN+uxr1l3RN1xpQA9wqP+McIQxOsJcMhsNfKqBcHO6DTBxd9ApPe/ZDzdCXc3vhJLubue5saURNpGFp+O1m8q3fmN1y9LgiRYbBLVZjna3EG7M+VdXiFVpGZxMoOWzbFfbAJECsYceTen2RbWaIA0zDYBwyvgSeuK8XaHZ21z8ciDcNHdVOh/qATfa+5qi0b2FZOJWfwH5s8jrbcdK6/17JQIthDdRPJeq4RDWsl3BGS4fHl2fl96Lsm87lQxMjv8lCJpO/9i105WLZuAqD8gsbV5thIS/jG2km6vLcG4yMFVPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+CMt+Rcp1Y8LexpV0MGSjuehDYnZVCAQLAdLLv3SxI=;
 b=G6tj8HEeBiv1LN1OOcZRHhGFHII4GhIThHdtvKxPI4WRzyrZX7wliz/J5wZjjRn8KfoZ1UtJIzLeGDcLXp5TTiDeERKWzd7FLPD9LzgP8jF3JUt3D7IwdcSwYrAscMZUgF2rUFel3zmJnQkoy9h/zNfpy5yZKK1ENt/TxVU47GVDXinrLs+7Q/clKDAKdrBhZhfkPsh+spM27eTogR864oclj1VZsIRIL9KvMcy8vn7fEcCp2SsIqa3ygqRuyjvYkZmucL7huouxbVTv7HglU2fu8RMNVDMGITyXH2huPg4lzx2UE0Nians8MbfDz6DP0h3JPdFV3r+YD75f74k6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+CMt+Rcp1Y8LexpV0MGSjuehDYnZVCAQLAdLLv3SxI=;
 b=DYAx4f1oYHSVJWZyDdMiZRPUS5MR6Ny1EoyGVvbY/yq/RU1phKK2kx0cghXT9IqCY4H1cxgkxWd7oDMmGMcs+La0EeCuWxJS46DysPRLUUJKGzzJCNFZdink33fY3Qir0pY5rkv6Tq/CWgAjW1aXhe0l2h7gvDnDNWlK7L6HHwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:39:40 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:40 +0000
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
Subject: [PATCH v8 5/8] perf: imx_perf: fix counter start and config sequence
Date: Fri, 22 Mar 2024 14:39:27 +0800
Message-Id: <20240322063930.749126-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 995ba2e7-54f1-4c06-e484-08dc4a3ad99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UUgkgyYKq+fGCEjfd4nw3WC12bsnfIQQYdr7w2pH+L0N9Ts/d0rrn5hW76PJUlaDlw90EsjkmQPnhF5tHUSwIW/kJbYIieAxzrZOFIyrLU4veotaeeMp6fsG52AGhFZ/Yt3CN6f6Zf/5EJDm/Pw8HLiM2AUzonU0YxeQC9qR6WtFecAGDAyVNtIgh6Ou18jDGmD80vnSGsBR57tqXtipFh5RIEVh3LFKgAi4O4ihogWnwp6V0NW8djN7XX/n7JPKiJ0J0sO7sEAJK0fIVudO3RcCJjjayN+1H6/66d9n53WE1NAHIBJQ51rtPFhph3Ki5b7CP0vnZtVffBDyoh4ftXQv3vLXkA34aQ9EdPMsI3aaNfWD86bkaourX0ju8vaxNSF1SfRK8FyTS/kJeLIcgSIbR0FYDcUXoXRPBe3Zh0SEVHTDdteWBF8pDsSN1jVH/6XYrStCSbCGLf36HA98E19yYIkxdo3GEV0yR9si2v/z+LIt6a7zVPhihopwnM0GcIpL+ShzATJKx0z1bj2Fg2ARyt35dI5LHL2ZRihVFegcLFGoIf+geWRT08foxlYS471uDgnVmJtgHh760E3DYdTGBsJgM0gjxEq3DhHYUMUiO7PFuo343GaqEYLy4r5vGsZXWkBA197eH5C/nY+W/1/Ew2rm6ZxgS/GunrvidVf38IcKbQioZNEisIo/8MpT9nL3oFw71KSN/TFnNGuwmO4kriCgZtfCpxgtRr/NC6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uj8duaSwgp0yqbdiorrpiXaBQRzShGho9/AKwEcNcIAy7fEsuJRDJOA3OlkV?=
 =?us-ascii?Q?RcO0Q94nUHUn1TNIH92Oa8MuTeeijebWSxv3J7a/QEzra2TKfTah12aB/0mx?=
 =?us-ascii?Q?8Qdcxa0LlvWDfTMm2sqL5oW/wpGIApB+zB0KWr3PgwEDmActHyFzDGz3GDQt?=
 =?us-ascii?Q?xRKHZPgHndharlfX6oXxn6NnQpXAoWHxNNURRwbibFZuvSCvI8FXJcaaut8A?=
 =?us-ascii?Q?WxascSyidtqSux8JLPUgVGZgbXp6DNe4khThsv5PlLvlJl4v9WGC9hb1SUO3?=
 =?us-ascii?Q?gyh1s8bDdNKpL8C2LQbJspxFGWHnJtJE2XrrB+aKEONkBRiGLPPRdr7r2sze?=
 =?us-ascii?Q?8NK7A361gwHAw2xrtsCST3D7Hvni1UFxAuiQb9f4H+dn69ASf7eYdhNPCU/U?=
 =?us-ascii?Q?i0uu9K+U5PQKTw2KerbDt0BUyip0WlzQDo6W9a+Hy7/xhVm8j42y8Wm+DPrL?=
 =?us-ascii?Q?MAu+4KJen1FoCNyBZHD83QWFdTdHD+itDr/G+OkRHzj75+QM3Gr6M2fqZJrP?=
 =?us-ascii?Q?zWwGNqTnmV0nLxTdPdDZvDgDQiH6LtzI7EGPt4sNDEzi5YWXsOyEZnFu8s2O?=
 =?us-ascii?Q?MR8keRL3vofJw4FN88A/5wwEViCPVl/vgi66mJHG3xX/JmnRCFpdJeFxk6Nu?=
 =?us-ascii?Q?1ZpisW8ukhK95F7MfizE35Mhp1XEnvehicaKHE3tJ/BoHZ1RaMBGwU9TyOQR?=
 =?us-ascii?Q?XNV8jo5inoKDzHNm1s2D+9rwkd2n3s8e588jqV9Fgi5VQMpz/K5yEs9M+lFw?=
 =?us-ascii?Q?vLlKSO0xBoxPV5JtMXzyQT47VUQKVoRxNYQJo598heMlvBXD8e6s7L/rziv5?=
 =?us-ascii?Q?Qv5aKlVqRFrl9B4qyHpysJhpvUMAuOCAiTF14ltcR7ozCSFFTyFIK57oEhNq?=
 =?us-ascii?Q?MB+JW3KMNZK7fo63JLR2vEvuha7zuWtCYdv6eaKf4kAM7du3z6skCiU9GLT3?=
 =?us-ascii?Q?Pwld5Vww9agsnRo5Iz4Zyah/W3MNltmCv7fODSSJnfUUYMLYys+rPoUiGm3q?=
 =?us-ascii?Q?JYAljky17oZt8nE86PTJweFtXjt+4umIbllap6HkgQCCi4vOwTz4tPPX7OuZ?=
 =?us-ascii?Q?/JZAEXjPYWkLVqKSBfdmNEqw4EFLs86d30J5ngaSxxerBCK0rqF9uKviI8sV?=
 =?us-ascii?Q?2KWHX4rS/dY5dxJ/HXNc6AIOcT8B4GcelYjlzX8Iptn1od4uCcgLhBj947CV?=
 =?us-ascii?Q?cLDfwhZnReQBbnG1rThXXWIXUsigIw8+CUfvYj1lLKYWQ/UB7m6NIHTzgV2Z?=
 =?us-ascii?Q?6q5zp1Q9jETdWdiMjTu4fzU+24t8Qgb8iXMfYqE+0f9YuHOLiGF4cu58n8uK?=
 =?us-ascii?Q?31EwW/OddzijJdkJgl/ed24lkm8XQpwm5Lae1fnl9O7/ouApQfvRsrggBb7t?=
 =?us-ascii?Q?NAbpb3XrI18LRzjnYtDAYRJbqys99ZVNM9Dubk//js4xJgsZkruF7Tfhqv+w?=
 =?us-ascii?Q?qb6aRr9Tn6Zja4JTDu+yQF3bxHB4om2JenFz0KgC5CBQ4+zUAHgzSvmgfsMn?=
 =?us-ascii?Q?ngvVrRMMxCt1vdf9jL6PAIZ9cmDq0goqKHOn/DuHlgT7FCsGoWa4jA6ViwUY?=
 =?us-ascii?Q?cEw3ZyNTLiPXb2sFHJsPN5MvZYvWix77gSwl5fQl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995ba2e7-54f1-4c06-e484-08dc4a3ad99f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:40.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuBRZcJFOpnaIIBFiSfU5+lyKXEyR1ZiZilN24l/cpl5HtexZax9wpTnolJB42QcGHIcWzzMiTIfQMgXFA4QqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 011377c01dea..fab6596d3e28 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -539,12 +539,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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


