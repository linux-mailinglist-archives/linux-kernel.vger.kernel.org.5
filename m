Return-Path: <linux-kernel+bounces-95283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14F874BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232BBB24CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125912B148;
	Thu,  7 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T71owC2d"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0912AAE5;
	Thu,  7 Mar 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805476; cv=fail; b=lg/x8HnUqzYJwRf+V+/tRis2HGu1vmaFApA+ou2ZtVHa7CYgvT1bLhpLWB3ba0PwTsO0K5jP7uCK2467FS/kDFuuxAlCePbP85vXn0XKS9nFZKUU3jIfApXUqhHTSNi5IU2UQYajaR/ChzrFEJlML68HEXrh4E/wLV+iQxELHJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805476; c=relaxed/simple;
	bh=rAIg/z5WFPmD9rJiqtZzUclV2yUnrpvZ+yUSZtT3/Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YpGitB3WyM26KWmsSQ9t6QVN58KjImsnu1XFTsDt339IuNX3m/p3N/XIfR/1l3us5WSV2OHD3T3775pVVCn7APS1JCzRxweaRosHu6XQYzhiH4BFdSK26ENLyzNl7JogMP/vziJEWQVpoSyNEshkFM2X8/WUnxDnw1hzNqvRlp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T71owC2d; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty/YywlsSV8WUYjVPQDO4DdEeestbsoXcsClpExgdAu54oUeBpLRc4KduhOcQEfFDzy3pa1EuHX4NG185+r1xV6C0OZ8uU6tWKrGGNIO/KB/csJgQfvJTyiifEe1lVMj9K87ZUoQwv7Lv8IpO6xwKdLdcgcSjE+1sn6jTu8wIIK/lMHzXwDqm0pJVa6DnA92MD8ol+q0aWP9Tptg26JKDLXCfUg/fI9oQ+xN0HlZNjLKctrIJbnFKxOpD2Yh+QFouYDn4BwRVW2Ec2XWRFpLO5ZvxNEewum/CXviH2mUeBBN4JAcGSTuWx+kpLwgBgoIhb7rT6riALq5OY+R/3Njeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCpzQMQMQqszgg3W6CM2LVpPEFvKH19j+v/4y3aPj7k=;
 b=jbR6Ut8OxsudMyLvq5pBeJ7lkjeBOPYb96HrSXHtPc6ucNwGbaAZ64F07v+BhloOesWQcPs99Zt2IKidUI9+XyDAHcASnKeDxWVb6FN4ru7aP/nIEtR+bXPQdxQOtZF9/j3Bxzj7ycp3f+P/LJ/H1YVVPchcPUI3tNnX1iHi0fycU1WE3dkoWJeN4vf6m8vBJq4/G9CYFyOA0aV4E+duAeF0JkG1UpjNYIfzY6xqhYVNTnOX0WU0LXAa9WopggiSNpJRuR3gLAWpbP2sTw/q1wHm9thalkDdFfGAMmYM56etd1FztJWNqNvsOuwAg7xSEG/+mZXn7+JJDOfAyQYgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCpzQMQMQqszgg3W6CM2LVpPEFvKH19j+v/4y3aPj7k=;
 b=T71owC2dInp/TXLcAWWsF4oPQgpr1/HRUBkKS/JVW4RasSQ/m8/KVLjMlNi3V7+yRW27AbP7W5rBGfzSjM21O2cB8to70gXMBDZ+ewtOCbD3bCjdySt5gdRRZXfz2xbWdQwtztv7fMLy5iT6wLKTeRV/bnVjBsLK4kqFRoU8Hc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 09:57:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:52 +0000
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
Subject: [PATCH v6 5/7] perf: imx_perf: fix counter start and config sequence
Date: Thu,  7 Mar 2024 17:57:28 +0800
Message-Id: <20240307095730.3792680-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ccc7ae2-1a1d-4539-821e-08dc3e8d0df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2sfUP6yR4HYSabKxsJxef2rfq+d1mf0KVc854bunyp/DovfNErYZR88z2Yly6XzKOfLbxOkj+gUIFVFAY8FoCZ+jm/7po1lMan96tTbCCCnOKAQ9d0LY7NxA+VSGjgSC3eTSeWQ1FnOitmuan/GqYlTJQXJBsCwmKgvBxuXw0hkogF5dkLE63NSO77cqYfFTHgcw8mCkEcb4Tnz6CHrM3EPViAXhvI5atFC8eOeQ10c/KZHMHWeBeoRB5jNXU1aPI/RicHUIc0hiLrfkaQq6Da4U5qWd8ZOuvsFQIuxcSCEfEnXwIQiMsPqXfghJ0GAkvCNB2C6O5Ls2chRj+5Nu3ZJHLqFz0tfZMRF012DrrjL4Y9Dvz8lTQHdiPp+XGa0rreu4BqvCSgPfATq4XcNMtLhh3z5CV0JE9yS4xCLNZQ4Sa3szcmVMmcvzZuwSkNCpQkMBIsx3NnG3h/BmXXUTchLnQ0TBBrRKb3MI1MD18HP0lirfpFUXBMTAEocYnlEkOzT6kpp8b3pp8uT4N4+pEXZOKI1+PHCJHLLaiZhWN2a8LAm3fgLgD8j5pJB3+C5pYEpxub5zlTWkbJaELpTnei281CwCovoELjR3RLgk0vIU8kX7JIGYX3h3iD1LMliWPxPaK/0s1N7uJ84Nnz+3MPm/m/AcN69D43XUtesqEhyigyFPGcqVekpLO/CzIMjBLo3LqMneziw8vnz6XTfWHK/P83X7cRZx0waNGF0Rygw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKWnbxceFK5pYxCzHLtLh8Hzc9uivulkr4HC9rahLyBj4cy+Bl36Jvrmyhfg?=
 =?us-ascii?Q?A5OwwbYgxfq1wRuMDCO1vtn3tuSfK1KgJO+BonwwnMzC5q0/NQMagLGAhZ2D?=
 =?us-ascii?Q?1yOtGYKb5gO53fw8+JKf0IYIdiFxcKMmDru/9nZVkPVBZhF5HORgBbycb9fU?=
 =?us-ascii?Q?B0xMS+kRmmqgkp2xDmEqHl67uezWQSp4kNha8mUUo/Wh+PAKi0jDeuTIWEof?=
 =?us-ascii?Q?OgySnIfS6H5kh38O1p5X4uw/3Pq4ssTpFgmtcULXmY5GgfoXk2IaqTssB+Uq?=
 =?us-ascii?Q?nEio2q00AELGEE5Eaz0KFWYwxEVQYvaSrmR6LGpkou4dPhxr4tAr7NP3TzVv?=
 =?us-ascii?Q?17UDHufOnGaplDdHG/Qe0SIB/1u9yRKgEo94nzgWZc8fSYPRDh6dh7OgnbhA?=
 =?us-ascii?Q?u41QUp19i0rvbh6pkO9AhgCpSRW1RgkWsX3x9iira1OlF6hc9KSuFvyPpMnM?=
 =?us-ascii?Q?4hHrwbkxK/shyEqtFFx5BHdiLkFt927bXm0Wt8t1oSJN1lwa3fQZ8FdnPE0o?=
 =?us-ascii?Q?xV6oWMF6HoS3mKT9leDyGElByg2by3/aWfQVV1uZML9xkFCXH/BMUT6woOy3?=
 =?us-ascii?Q?hnzy6dHaMzuQgCbqXAOjLeYVha8yc9XwLKTPJ930W2r/tEdVgvBaiE31rXCu?=
 =?us-ascii?Q?AnJQqBorsdjGxWMEgghBcmp2x9eIKkRj8J694ZrsAlRIFn6JT/5PloiPVQwQ?=
 =?us-ascii?Q?AokuBhUCRxXdr/VhG4p7sE4J0RyuzmZjgppBRw2cFLKP3lEzizEfRSZ4e9i6?=
 =?us-ascii?Q?jy5hmU05T5w+yR6uyuc+GjXNQr3XNzM/Jok5xaYvqv0YfagM3xgmmr2yzE46?=
 =?us-ascii?Q?fDZeUtTjLD0Amjz1OH0ltQBNH6bHfCfEbFBcnfMs1ztnEYOAybGxUDoft690?=
 =?us-ascii?Q?coqGT4xP1fZgnoD+gWV4N8oCtsAPLaSsa2IwBuZpMgQ7aoirgQZESPXO/AD+?=
 =?us-ascii?Q?zsq5jcg3OqmGmDJ7WsKOfdRyEzhDXeiMC4SG+m3GqeXGHLoY2zb52jcphidO?=
 =?us-ascii?Q?e/OYCJZfOUKg+xZLRoZoZUe8bT6CiRGmZi6DABRuj8CYfSUfOTcRPCiuFh+9?=
 =?us-ascii?Q?pbqGvKwrWejhDtTJW/EdAsZNYjHb7+xPaaAIuiUX+ITInEkK5WtEz20s5f/+?=
 =?us-ascii?Q?OA15aiewfpEdEYFSBISqn4e4V5FW/oBgbjxTTdGCT1n0z0xmu8fPtXo6GfZ2?=
 =?us-ascii?Q?WVP6BGvNvEjxQzzMd6pK/P8XW1tvMczLFsv4iaqEA1AKmNrT+o7L9PDq9gpA?=
 =?us-ascii?Q?M3lA7uOaEi4NMh+Rbc7v2xXJIwlywZWEc1nQpBtkx0uAtSkTbatMIWPsJhyh?=
 =?us-ascii?Q?00Hkv9uF6068hS4ZlyQ9B6V0zvnFsQDbYoBDKfUWSN1MV8gqhuS0dD8/tO3V?=
 =?us-ascii?Q?QSe4d/EiVk5k4mzV/yh4yBDAYfzTkD3MNu2T1G3ofWn2b38GQ7jfbskmLMIV?=
 =?us-ascii?Q?so0QLIvW0TUpjx+eXate5Zd+lyOP0HiXj0kHRECEDzZ07IzldwrmsS85Wemk?=
 =?us-ascii?Q?aEEyfctu3VF6lKVC1sS/exOAgLtLMs/ZJO1B6VVowIp7m5hgCybrpGw87lXP?=
 =?us-ascii?Q?SKDF/z5MmgYbb64vZ9TL9b9MxFmc14ZbBEYrZ8OD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc7ae2-1a1d-4539-821e-08dc3e8d0df4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:52.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDQF9X5CZXcG6o0nkGdCvFRk7V1QnlsA27Nd4aKT00xl1KvJiAFcejQk+pjAxp2eGhkvhLmZUuzUfU8UIhX6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 4e8a3a4349c5..52234b97d0cb 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -543,12 +543,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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


