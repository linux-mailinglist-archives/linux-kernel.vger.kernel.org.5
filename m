Return-Path: <linux-kernel+bounces-59120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B284F185
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684311F23E55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C56773B;
	Fri,  9 Feb 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0DQex96"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E3664DB;
	Fri,  9 Feb 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468043; cv=fail; b=AlQXhhYkJn0HU+Dpd10l6Ne478k0hUTaSSHnhAJginTpHZPW5tgwIqT0RC3G8HPzWZ6zRoCWcU3S3+HDtosFJEcPHwBRBTAaDIeL+P7dPYkcmH/PU0AtJyRgbezu2OvL32MTna8EiARMX1p5WrTj7xVp1tcplaojEVdSqjGRcBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468043; c=relaxed/simple;
	bh=C5DMkE375gwWFihpjm9SxnxJJY+5nkUgcqSKoDlHnIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp0drcR/dDkmKFLMMjrlwHNY4E2hyZyBxTEVX1Ye0VfDm9lqPl2UJlcS8hYUAGxj/WEyaVN9ikMM9ErPy/2ZSV9IOk6ew7HL8TePKk9dCJRnIY26u4ekH8aLHofkWlm/iGuNzHrsYb7Lfl4KCcT1VeMdOTRgoETsibMvtC+rYcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0DQex96; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVVQWpCZU5JjxyObKx2H1OOloAqUQJNxGmKX+oPdd3NPMwRRkzqant2UKdZKIOcN/uYfZfvrR7UeZsCES7D4OnQpT3t+AqWHhABD1JBbhvtUNS3tl072RTT8cf5Wu0wZpxRiWje0ekBgRbGxnr81WTSPFRpTJGZ81lxXqd3mkjuHJBDl1YB9JXaiuzl4X01jwH3pxDfrn9wLLFSUxMby+QLEsrlecu6te1xpVolBHHq2e8OMdiCrqQuaeMskahDX1Gpc+n8WcUXiKSLf9XN4xOKwq07VZv6bnPRGMSaXmP2NZnyXgFNZsP7PlTv6n1fcAdNjKxHE6skH1K7CtNRTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3eD7DfcGlmCj0sr/Pozml4CO2RM3R9Nwdj5Ax0/XQY=;
 b=nNhIc5MZpx59mh5uhjKSiKCWyNt3lM+Eb7BRkyn6uYokUjTUb8mxb1n0vH4Hj1cnByIlG3VKQlA6YGs0oG9uA7XLeROtDZvXG35Kr8ypaE7i8mPTZA6t7APDqmELkCK8ssKnsog/jep9VXldEdo8dUMhXrmWQ6tTF1opCZCaTj3csTzs1P2ULkv5CPtS0NgRDYgbL4PBr5sCX8dIg6+nocK8/N5aaJ4bz9897terW7LFrvDXXPjLiZeF4loFheMoyq2zx5nNbgFri6TLy5hoI+eL+6wvU5sZGO0pZumiWlkOcQ7segu7EkGDkZ1q7jWThYBVKoKzZc5cdVeT9PXQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3eD7DfcGlmCj0sr/Pozml4CO2RM3R9Nwdj5Ax0/XQY=;
 b=O0DQex966qT4eaDdvZqI1PkAiRPDBC3krDKde5txatng3Rotc8YbxRCVgBQDtGUrBdZUJvv9C30gdjeU6smjA1c0py2otmtA4S/p5CXUM8MAANdDrgUPwgjtKXfiw/7Xw3ThJ/Q9xtgQyeyl24jR4tBT6qKd8J6HiIk+m7KmCp0mVvor1Ft3tcxcUH9p3/oclFGCE9ILMx5UFAZuf2hbMurW9hUG9hr2bhiSoOfML9LR7RSbhiVbBbYvhxbpqyl7u5iKtbfCT+wdJV14Tpxqc98+CdrI4aCg7G9KHMUYdwZzj8WxsesuTJXhbeVAGbY39qK5K/3fhnmJS+OXbaEhNw==
Received: from PR0P264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::24)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Fri, 9 Feb
 2024 08:40:36 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10a6:100:1b:cafe::ef) by PR0P264CA0156.outlook.office365.com
 (2603:10a6:100:1b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Fri, 9 Feb 2024 08:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 08:40:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 9 Feb 2024
 00:40:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 9 Feb 2024 00:40:13 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 9 Feb 2024 00:40:12 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Fix signed/unsigned mix-up
Date: Fri, 9 Feb 2024 03:39:55 -0500
Message-ID: <366b8fc6f5d77c01f9e0e2ad25627df583729017.1707466888.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707466888.git.shravankr@nvidia.com>
References: <cover.1707466888.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fab728d-7f29-4c86-ab3a-08dc294ac87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2XspLSM55HziTuwygXiuyZ1TtbFx85AAG7AK0YBUASuefBQ+yo4uM26CjHw1u8/ZZ+OhinKGRoshtzvXryIQkxF6UEzg7ZCkRMY8bYttUasi4KKs1df2nW1k6MPljJWlKQXhgdZqZ8zefWkr2CJQPZOV11Yqf3ClwJa3qTjF4QopoSz3nkUm0HLxOwhKDTUG/Yw4XbVskYOPQTqPGY5D8TDbZ7etc9LycvmTUN3ho2SgWfHJERgVrum38e3OtiL/+drzAdAjnD1yzGmQnTTHnNU7JsAOfVykAwpVi0zF0BWZ767wkZxdFcaZl/9+3zZZGbQejTG+pl8zL961CmMQUEHqgwOuQZdhThkkjp+ltcJOlnLvOTziZDYoiOyJRtYaS7zAfo6GI3FJGUBu7M/QvLZEDP3tzd6jauGzM7czQssDeKoq4j+tTwGNj19GqUt5+FbYeTxzJ3FB/FfroFcjBxpXVUJI5H/QmQMELBr/6fE7V098cVMDNGHvT+62aEjj3qdh4aHnHOV0wWHrxf8CZIeQPS1Ep69ts/ZOncGS2oOz7GqImtZycYZ+eQDqicXtPSb9jaOh8j9J4ars6OxB0UP50sgm8h93X5G+GYBj02I=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(36756003)(478600001)(41300700001)(86362001)(356005)(30864003)(2906002)(7636003)(5660300002)(82740400003)(54906003)(2616005)(110136005)(316002)(4326008)(70586007)(8936002)(8676002)(70206006)(6636002)(26005)(336012)(426003)(83380400001)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:40:34.6581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fab728d-7f29-4c86-ab3a-08dc294ac87e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 110 ++++++++++++++------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 71d919832e2a..e3f1ae772e43 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -99,8 +99,8 @@
  */
 struct mlxbf_pmc_attribute {
 	struct device_attribute dev_attr;
-	int index;
-	int nr;
+	unsigned int index;
+	unsigned int nr;
 };
 
 /**
@@ -121,7 +121,7 @@ struct mlxbf_pmc_block_info {
 	void __iomem *mmio_base;
 	size_t blk_size;
 	size_t counters;
-	int type;
+	unsigned int type;
 	struct mlxbf_pmc_attribute *attr_counter;
 	struct mlxbf_pmc_attribute *attr_event;
 	struct mlxbf_pmc_attribute attr_event_list;
@@ -169,7 +169,7 @@ struct mlxbf_pmc_context {
  * @evt_name: Name of the event
  */
 struct mlxbf_pmc_events {
-	int evt_num;
+	u32 evt_num;
 	char *evt_name;
 };
 
@@ -959,7 +959,7 @@ static int mlxbf_pmc_write(void __iomem *addr, int command, u64 value)
 }
 
 /* Check if the register offset is within the mapped region for the block */
-static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
+static bool mlxbf_pmc_valid_range(unsigned int blk_num, u32 offset)
 {
 	if ((offset >= 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
 	    (offset + MLXBF_PMC_REG_SIZE <= pmc->block[blk_num].blk_size))
@@ -970,7 +970,7 @@ static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
 
 /* Get the event list corresponding to a certain block */
 static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
-							   int *size)
+							   unsigned int *size)
 {
 	const struct mlxbf_pmc_events *events;
 
@@ -1047,7 +1047,7 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
 static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 {
 	const struct mlxbf_pmc_events *events;
-	int i, size;
+	unsigned int size, i;
 
 	events = mlxbf_pmc_event_list(blk, &size);
 	if (!events)
@@ -1062,10 +1062,10 @@ static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 }
 
 /* Get the event number given the name */
-static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
+static char *mlxbf_pmc_get_event_name(const char *blk, u32 evt)
 {
 	const struct mlxbf_pmc_events *events;
-	int i, size;
+	unsigned int size, i;
 
 	events = mlxbf_pmc_event_list(blk, &size);
 	if (!events)
@@ -1080,7 +1080,7 @@ static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
 }
 
 /* Method to enable/disable/reset l3cache counters */
-static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
+static int mlxbf_pmc_config_l3_counters(unsigned int blk_num, bool enable, bool reset)
 {
 	u32 perfcnt_cfg = 0;
 
@@ -1095,7 +1095,7 @@ static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 }
 
 /* Method to handle l3cache counter programming */
-static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num,
 					u32 evt)
 {
 	u32 perfcnt_sel_1 = 0, perfcnt_sel = 0, *wordaddr;
@@ -1160,7 +1160,7 @@ static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num,
 }
 
 /* Method to handle crspace counter programming */
-static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num,
 					     u32 evt)
 {
 	void *addr;
@@ -1185,7 +1185,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num,
 }
 
 /* Method to clear crspace counter value */
-static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
+static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
 {
 	void *addr;
 
@@ -1197,7 +1197,7 @@ static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
 }
 
 /* Method to program a counter to monitor an event */
-static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_program_counter(unsigned int blk_num, u32 cnt_num,
 				     u32 evt, bool is_l3)
 {
 	u64 perfctl, perfevt, perfmon_cfg;
@@ -1261,7 +1261,7 @@ static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num,
 }
 
 /* Method to handle l3 counter reads */
-static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_read_l3_counter(unsigned int blk_num, u32 cnt_num,
 				     u64 *result)
 {
 	u32 perfcnt_low = 0, perfcnt_high = 0;
@@ -1293,7 +1293,7 @@ static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num,
 }
 
 /* Method to handle crspace counter reads */
-static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_read_crspace_counter(unsigned int blk_num, u32 cnt_num,
 					  u64 *result)
 {
 	int status = 0;
@@ -1311,7 +1311,7 @@ static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num,
 }
 
 /* Method to read the counter value */
-static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3,
+static int mlxbf_pmc_read_counter(unsigned int blk_num, u32 cnt_num, bool is_l3,
 				  u64 *result)
 {
 	u32 perfcfg_offset, perfval_offset;
@@ -1349,7 +1349,7 @@ static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3,
 }
 
 /* Method to read L3 block event */
-static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num,
 				   u64 *result)
 {
 	u32 perfcnt_sel = 0, perfcnt_sel_1 = 0, *wordaddr;
@@ -1402,7 +1402,7 @@ static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num,
 }
 
 /* Method to read crspace block event */
-static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num,
+static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num,
 					u64 *result)
 {
 	u32 word, evt;
@@ -1426,7 +1426,7 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num,
 }
 
 /* Method to find the event currently being monitored by a counter */
-static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3,
+static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3,
 				u64 *result)
 {
 	u32 perfcfg_offset, perfval_offset;
@@ -1466,7 +1466,7 @@ static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3,
 }
 
 /* Method to read a register */
-static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
+static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 {
 	u32 ecc_out;
 
@@ -1487,7 +1487,7 @@ static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
 }
 
 /* Method to write to a register */
-static int mlxbf_pmc_write_reg(int blk_num, u32 offset, u64 data)
+static int mlxbf_pmc_write_reg(unsigned int blk_num, u32 offset, u64 data)
 {
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
@@ -1507,7 +1507,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_counter = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, offset;
+	unsigned int blk_num, cnt_num, offset;
 	bool is_l3 = false;
 	u64 value;
 
@@ -1541,14 +1541,15 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_counter = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, offset, err, data;
+	unsigned int blk_num, cnt_num, offset, data;
 	bool is_l3 = false;
 	u64 evt_num;
+	int err;
 
 	blk_num = attr_counter->nr;
 	cnt_num = attr_counter->index;
 
-	err = kstrtoint(buf, 0, &data);
+	err = kstrtouint(buf, 0, &data);
 	if (err < 0)
 		return err;
 
@@ -1577,7 +1578,7 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 		if (err)
 			return err;
 	} else if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
-		if (sscanf(attr->attr.name, "counter%d", &cnt_num) != 1)
+		if (sscanf(attr->attr.name, "counter%u", &cnt_num) != 1)
 			return -EINVAL;
 		err = mlxbf_pmc_clear_crspace_counter(blk_num, cnt_num);
 	} else
@@ -1592,10 +1593,11 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, err;
+	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
-	u64 evt_num;
 	char *evt_name;
+	u64 evt_num;
+	int err;
 
 	blk_num = attr_event->nr;
 	cnt_num = attr_event->index;
@@ -1621,8 +1623,9 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, evt_num, err;
+	unsigned int blk_num, cnt_num, evt_num;
 	bool is_l3 = false;
+	int err;
 
 	blk_num = attr_event->nr;
 	cnt_num = attr_event->index;
@@ -1633,7 +1636,7 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 		if (evt_num < 0)
 			return -EINVAL;
 	} else {
-		err = kstrtoint(buf, 0, &evt_num);
+		err = kstrtouint(buf, 0, &evt_num);
 		if (err < 0)
 			return err;
 	}
@@ -1655,9 +1658,10 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event_list = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, i, size, len = 0, ret = 0;
+	unsigned int blk_num, i, size, len = 0;
 	const struct mlxbf_pmc_events *events;
 	char e_info[MLXBF_PMC_EVENT_INFO_LEN];
+	int ret = 0;
 
 	blk_num = attr_event_list->nr;
 
@@ -1683,8 +1687,8 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num, value;
 	u32 perfcnt_cfg, word;
-	int blk_num, value;
 
 	blk_num = attr_enable->nr;
 
@@ -1704,7 +1708,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 		value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
 	}
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sysfs_emit(buf, "%u\n", value);
 }
 
 /* Store function for "enable" sysfs files - only for l3cache & crspace */
@@ -1714,12 +1718,13 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int err, en, blk_num;
+	unsigned int en, blk_num;
 	u32 word;
+	int err;
 
 	blk_num = attr_enable->nr;
 
-	err = kstrtoint(buf, 0, &en);
+	err = kstrtouint(buf, 0, &en);
 	if (err < 0)
 		return err;
 
@@ -1757,10 +1762,10 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 }
 
 /* Populate attributes for blocks with counters to monitor performance */
-static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
+static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_num)
 {
 	struct mlxbf_pmc_attribute *attr;
-	int i = 0, j = 0;
+	unsigned int i = 0, j = 0;
 
 	/* "event_list" sysfs to list events supported by the block */
 	attr = &pmc->block[blk_num].attr_event_list;
@@ -1810,7 +1815,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->index = j;
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							  "counter%d", j);
+							  "counter%u", j);
 		if (!attr->dev_attr.attr.name)
 			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
@@ -1823,7 +1828,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->index = j;
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							  "event%d", j);
+							  "event%u", j);
 		if (!attr->dev_attr.attr.name)
 			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
@@ -1834,11 +1839,11 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 }
 
 /* Populate attributes for blocks with registers to monitor performance */
-static int mlxbf_pmc_init_perftype_reg(struct device *dev, int blk_num)
+static int mlxbf_pmc_init_perftype_reg(struct device *dev, unsigned int blk_num)
 {
-	struct mlxbf_pmc_attribute *attr;
 	const struct mlxbf_pmc_events *events;
-	int i = 0, j = 0;
+	struct mlxbf_pmc_attribute *attr;
+	unsigned int i = 0, j = 0;
 
 	events = mlxbf_pmc_event_list(pmc->block_name[blk_num], &j);
 	if (!events)
@@ -1869,7 +1874,7 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, int blk_num)
 }
 
 /* Helper to create the bfperf sysfs sub-directories and files */
-static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
+static int mlxbf_pmc_create_groups(struct device *dev, unsigned int blk_num)
 {
 	int err;
 
@@ -1912,18 +1917,19 @@ static bool mlxbf_pmc_guid_match(const guid_t *guid,
 static int mlxbf_pmc_map_counters(struct device *dev)
 {
 	u64 info[MLXBF_PMC_INFO_SZ];
-	int i, tile_num, ret;
+	unsigned int tile_num, i;
+	int ret;
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
 		/* Create sysfs for tiles only if block number <  tile_count */
 		if (strstr(pmc->block_name[i], "tilenet")) {
-			if (sscanf(pmc->block_name[i], "tilenet%d", &tile_num) != 1)
+			if (sscanf(pmc->block_name[i], "tilenet%u", &tile_num) != 1)
 				continue;
 
 			if (tile_num >= pmc->tile_count)
 				continue;
 		} else if (strstr(pmc->block_name[i], "tile")) {
-			if (sscanf(pmc->block_name[i], "tile%d", &tile_num) != 1)
+			if (sscanf(pmc->block_name[i], "tile%u", &tile_num) != 1)
 				continue;
 
 			if (tile_num >= pmc->tile_count)
@@ -1933,9 +1939,9 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 		/* Create sysfs only for enabled MSS blocks */
 		if (strstr(pmc->block_name[i], "mss") &&
 		    pmc->event_set == MLXBF_PMC_EVENT_SET_BF3) {
-			int mss_num;
+			unsigned int mss_num;
 
-			if (sscanf(pmc->block_name[i], "mss%d", &mss_num) != 1)
+			if (sscanf(pmc->block_name[i], "mss%u", &mss_num) != 1)
 				continue;
 
 			if (!((pmc->mss_enable >> mss_num) & 0x1))
@@ -1944,17 +1950,17 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 
 		/* Create sysfs only for enabled LLT blocks */
 		if (strstr(pmc->block_name[i], "llt_miss")) {
-			int llt_num;
+			unsigned int llt_num;
 
-			if (sscanf(pmc->block_name[i], "llt_miss%d", &llt_num) != 1)
+			if (sscanf(pmc->block_name[i], "llt_miss%u", &llt_num) != 1)
 				continue;
 
 			if (!((pmc->llt_enable >> llt_num) & 0x1))
 				continue;
 		} else if (strstr(pmc->block_name[i], "llt")) {
-			int llt_num;
+			unsigned int llt_num;
 
-			if (sscanf(pmc->block_name[i], "llt%d", &llt_num) != 1)
+			if (sscanf(pmc->block_name[i], "llt%u", &llt_num) != 1)
 				continue;
 
 			if (!((pmc->llt_enable >> llt_num) & 0x1))
-- 
2.30.1


