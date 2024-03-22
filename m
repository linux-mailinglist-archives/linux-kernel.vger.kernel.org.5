Return-Path: <linux-kernel+bounces-111083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562BE8867AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2291F24BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AA13ADD;
	Fri, 22 Mar 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WSbhSn1D"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33A14002
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094254; cv=fail; b=b1s0xR6VY41l/XZtKVYcTUZUnzM9QJoJJcBiFtSaHYd8UeAfrZ2VxKyuBG1yOOUJ/eYVUWF8HLe8dJsAFBcK6b1e306UtFzZXwndvYfvVQGYAhXgkaKQSfb/4ON8KVENbHeK8AphTp9F0fUYzQdqFNd1n/J7VmT3pS8SEgmUVpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094254; c=relaxed/simple;
	bh=ZCo0nbqNdHQZ0zoWDuwWRFPJTLeqj/xFYFVlxGMBBu0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HYErNVPboxsX9gsirptRMaaT5N5vEY3U840HusO2+ryswd9lQvhuT8jUJ98s8mcxk5xh2Dj92VgYneb4db6BR258EwqMNiEwlV67IPyPAr6wKaHau4aEGwIqe96+K5b3pfXA/YYs5mlih3uDrlcGFhLwR3UQp3rBQ6KiUz4+k9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WSbhSn1D; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVL8Ye4p08nIG1xFS+lK0R39JV6znwKQji0DVJ380kHV4xC+i5Lsn8ZaXV+c0nzPG6vTWdBcoKg/EO1VPhRqr8nWy+e4oZcoiR8DO1zysvQFm0FoiAQZd8W9VNmohF16m63q6M6YPmGI7BFL4ZVXSwAIAhYR/jEXK5uRxy2lfx/nRvlqxByIkeL1QTrpT9H0BlzGfvpOjsbaUFqxfiBdDw8g/o8QPAGX6pp8VuQawiPymqPytA5bCI/ASC1gizEPn/oBzfTVR6WZx+aY2F59YYE/y/PcAzqBTATB1Ab2651EHNfduIAtVUxAc3itFJPm1q0WktS1baEIDKuBlOpilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xin5drCagYKLbxMIgU7D4plJfzTAfC3fvkeyo+7txss=;
 b=fZh/86KtqIiDx1jOqIkhjcwBj1IWQUt2AmsUdsTSaTOJM9J8K2BcojxcArfWU7XnKCRUHLqCdKhC13ppZ0ULbnUH3/fdFK60/s0psciSjRgTe7wev83i3+SOlw3+PRtc9ZTxppqd2f1O0NOzxee+5/v/iCORMleGfS3rEsjMCTmsQCKyEa+IceAvFf2Gs+hBHt2H1n72bo8SiwdTKXQAqTRlQw+BT28y5v5aXQpVjAZC4i7k3pMQ5vZ2/tUCEcg9K2qWC9sXX4shMUgHyHs8xsTujkC2hWXPzwaNK+4TkGuC9a6HisYx4FUp5lfV7nbM0NOD3HEGTGXd2SuhgkUypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xin5drCagYKLbxMIgU7D4plJfzTAfC3fvkeyo+7txss=;
 b=WSbhSn1Dw6ETisYU+GdtDqMXeoDXikfq3XOIuwRFv/7KlZRKUsueSJo5qduxi9TiHfSDRrblD6KDZ/1AUSXCmUaf5VWRanaY8MIldXSSqjVh0derE2fEaWQznG8GofEo8tI1PwZMX/Ctkf+fpnrgTZWeylBq72qvHD78ehahRoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 07:57:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 22 Mar 2024
 07:57:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] firmware: arm_scmi: perf: print domain name in error path
Date: Fri, 22 Mar 2024 16:05:31 +0800
Message-Id: <20240322080531.3365016-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bb6156-0563-4890-126e-08dc4a45b7fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0YHRRDPECya2YkWeKwF+a+x4QTQkrZ8j5Za6krvLTQZk1DbypkoqQWg4WbzOvZ45iWjypL372QSrYHmR1bdpOyaNpCLtL2QgLiL0vdtMPGMokrfDRr2YHIdm8CvPZnKt+Qqp1yqJQhfflKZfe0X7rMU/SjN+x/h/7hdO/aCC7b6A6glOGfSEC2RSFmjcjVMNYOxsKy40No24xTx0fvBhmpnCQJehVK5Qljcww/KbsXUQw/ODqaMMXyX/P/q9x00lfBxSQgjzzetcwuqLFgOS6H4BxngdNn/dnukZURyTr5jUPrl08H9Q3OqgwQ4NgsOaUo7CwK6KpbguA3IX3yWgpsxhaSX6OVPFPLjdG4rpNSBgeLIZu4all5oleeEQNTjc7pFIqhq6j3MoehCoXx8FENkmDuiee6jp8LL1s3EYC4Yzh+3fDXfJueCweqYX1RmYIuwfRSoaAgJfqXBhiiAHV9jWCiznU5tc9aKPlj/J/PrJmJ8C2MMOB+VylxrjYm54sVcXm6ll2CuTch7MXcmRbewlbu6U0BOSo2bPJnl5eToQRQKUotO+JvRA2Dlab0K3UOfySDkrXj1czawE/9mQtcvJTI2o7tyHv8tbTTIKeGCzlSbMFlQALtmCnCnw4EWnEIcQQyUlqiyVyTPkNvjUHhjbzVCMgzL5evITzAJq12hC0I/m38rwKavWhgkyiP+lEmZjJUqen5jFLPscYXdIdioOqfA9kMegHgRSKBJzASQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kvl7Yd4YdE46D1/zzC/uda42oRVv9fFC5tLkNG9ODcAYY9hYT2Fn7JZMakRn?=
 =?us-ascii?Q?dQOVWtyQfYNGwKLngGXLoOhyYpdlIO12202iU8zEMTx/ed2JnBg0WK0eK25g?=
 =?us-ascii?Q?kh/vus8JNpTMovdtAdMNil1XylZARi+a6p1pvf7BUo+XU3JVrEC9r1wtGJCp?=
 =?us-ascii?Q?5RkbAGHApjYYXd1yRGGO1U6WSKivuufrMDFVrMOAXTlX0EE0w/sLwOnZYpKg?=
 =?us-ascii?Q?7hJJtJUU9iRwUGo3h5haYSdOl0OtKAyphR7uwmltMjgLLDTAxtxQ2kz5JG1h?=
 =?us-ascii?Q?SyAkPvfy2ZqnQqFoHmqrL2LbfT6J5eSDwzgYq8vFBcFs8dKonwAcC2Q+1oqz?=
 =?us-ascii?Q?zC3I7opAEqeD6NBXm0B0dhfN/LqNdM69IzTXX/TqyKCkdG1qh1nVl4+j0i7X?=
 =?us-ascii?Q?g5aOEa1636LGbOwJGM27cni6PtP9OhK9HolMV4aN/R1rIhOhS12EZeMazm2L?=
 =?us-ascii?Q?DtfD7emdA/I760UJpZN0wJu3yCO6UGKXp0TdbTSsZt0z/Q80NMp0WiLf62iM?=
 =?us-ascii?Q?nJnSs60kOTjwBQHQ5xcRzjNqKfAMH2c2LUfhGGPyJYcsQ5th3oUD6pERloYs?=
 =?us-ascii?Q?krM7Ksm7J3jhfjA0tq6h97yJTJhfk71d0PQ/tWCMc7dRZX14W+H6NXRSBpNf?=
 =?us-ascii?Q?H1GgeWBNar7+5efV8Nyed/SgNpPG4PCZZENvr9KR1FiNV0IFEO2AJD/pdjN1?=
 =?us-ascii?Q?GY/rspQgeqASpne+RRk0UgEql89lzbKIWeIhGUWcOY876xFiAMu96MAx5iu8?=
 =?us-ascii?Q?eVLT4oH9/yAOsRzoTlJY0egqrWn5/3RZOPUsSHdsjqFOByI70G8XrCMMjlVh?=
 =?us-ascii?Q?H5LEj5+s2jyweXlre1Z926Dsc+vFo1U8PfZsraV0TEAJqgVcpU3GVaK9FOJZ?=
 =?us-ascii?Q?RtSrmZP6q8qXbOmyW+JWQH3qPlkV9ivZspAPAZ54A6tdEniXGC+vyxQrzWbo?=
 =?us-ascii?Q?rXGgg29TIRzrksiWK3dIv+Eu979TDSsxluT6/hGOWBY0gcxE2vadCmXLlPrv?=
 =?us-ascii?Q?wjxSAfMmIQZSbBAxaHYLQzVvwQQtadFwskbf5PunPIzCIS8SZIX+ODTgcD85?=
 =?us-ascii?Q?z9TgyyK91MPyJAynXLsuMOZPv+O1yNKwPdmrg/gi7+hpUGf3a4HPgXap81XD?=
 =?us-ascii?Q?iv77WMX/NmjSc7CQkw+bis2f+lIhYNPj3agnC0V/gpen6L1Q4nu6EjP3Q5ff?=
 =?us-ascii?Q?94VHcJ0HtvdEUE0Y2Zm8DOrlugTL9Dnk2OkzRuJnTlxBVs1mtzjYYfkyr7aD?=
 =?us-ascii?Q?3K2aiTPA004IwMOx5KORoy5q7U0R9Mi00IjysLw7dQYafa8xvPQA8XYL7cJh?=
 =?us-ascii?Q?BrNb0L3wKmVgGgMm3xe5UkOF6eY+rKy/4EPFg6RxkSt/FC8jZCZinoL4W5mb?=
 =?us-ascii?Q?GgoTMFe0vfUAauMjUrqIjJozQh5x3PxQUHgsJQw4yYLT2k+UYz3UZF3Tdkb7?=
 =?us-ascii?Q?Vrl1u7DCSjTySi2QvX2UCowhhZXzjlLRziq1RnbrAn1chmyIKoOJtrRPmEZb?=
 =?us-ascii?Q?1yHsvmnzl7g6jV/CSyoRwLWa/woVIqs+VcD0Eehncv2JW4SCyzp+a2+ZIscr?=
 =?us-ascii?Q?s1SQPMHYT05ifr3/mG48H9jr0ECfUmeQ6j20tUiP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bb6156-0563-4890-126e-08dc4a45b7fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 07:57:28.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX9jIgylARyPDDGwVGdpvSlmaJntPeWGkipar7l0ZyYld3TzVvxl4kznlTFhkTyNwxddtDq5dDrPOWDDH/UoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290

From: Peng Fan <peng.fan@nxp.com>

It would be easier to locate the problem if domain name is printed out.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update extra two places

 drivers/firmware/arm_scmi/perf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 345fff167b52..c36a390bba60 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -387,8 +387,8 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret)
-		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
-			 opp->perf, ret);
+		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s- ret:%d\n",
+			 opp->perf, dom->info.name, ret);
 }
 
 static inline void
@@ -405,8 +405,8 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret)
-		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
-			 opp->perf, ret);
+		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
+			 opp->perf, dom->info.name, ret);
 
 	/* Note that PERF v4 reports always five 32-bit words */
 	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
@@ -417,8 +417,8 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 				GFP_KERNEL);
 		if (ret)
 			dev_warn(dev,
-				 "Failed to add opps_by_idx at %d - ret:%d\n",
-				 opp->level_index, ret);
+				 "Failed to add opps_by_idx at %d for %s - ret:%d\n",
+				 opp->level_index, dom->info.name, ret);
 
 		hash_add(dom->opps_by_freq, &opp->hash, opp->indicative_freq);
 	}
@@ -879,7 +879,8 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 
 		ret = dev_pm_opp_add_dynamic(dev, &data);
 		if (ret) {
-			dev_warn(dev, "failed to add opp %luHz\n", freq);
+			dev_warn(dev, "[%d][%s]: Failed to add OPP[%d] %lu\n",
+				 domain, dom->info.name, idx, freq);
 			dev_pm_opp_remove_all_dynamic(dev);
 			return ret;
 		}
-- 
2.37.1


