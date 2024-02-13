Return-Path: <linux-kernel+bounces-63410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0A852EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3372B2395A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FBA32C88;
	Tue, 13 Feb 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BB1787cE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DF364CF;
	Tue, 13 Feb 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822958; cv=fail; b=jf7SGVRGP/AEpARNaFL7bfF5EamkjbxDJsOerWpPtUqfHDGu5r4Rw2aqs5rsnKrFdyLo+wTUH4n9pTrYa5822DjtjLp6cpkQihwpkuMeXt06OuAzHgIhcr94KT3u/K04TdxyTppUvn8rcvT4vqzHz4ERZ7XZ5G4PYAWcMMVp97I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822958; c=relaxed/simple;
	bh=0E55QXLIpVd7RqZjbSbxvFTrxGnL+uF5Yylm5YW7asw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNlJKC+5NDHvjf+2bFm4qmjmsELV7Wm2B8fEVhvfNGr1JyG01ZwgBMmZ/OQR5OfTL68xozNqrIlBy9vmtXz8wedthR2HU0ch5Irow6EXrCCnbEUWFv+84Tvc39x28KZDgTtMHkO7xo9rwmNFO/fXRf+xBqbBkfcrqYqttlUnkvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BB1787cE; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF57vxDdjUG4NvxNtku4TkFovYV7KMmmzYj3F6k7r6harc4zbyVwHflFRyZWHYlXBXbNtiVoGuikg4GbhAHDW9Pvmf4zQ3YjSUi1HopscsfIsBg5IQNKXqNvn1eNlLOdhfEiE9P//m3CbzCRSjcA3spibdgkri46Fe5HqAo2BqdKj3vj2F0OZwg/O7OmsPFBIu6CVJKNk4qgb2Xyd/jiP4S5JcEJzBa4DpSIQMvc1leshx1JKs6S6IY3/b6YPKmyqb/vC86827U6SrJWv6teHky3Ic3/mLdZ0GC6U44sTCH5z9zE2mrCcRRj9l0TDYBm/aHDdpVSGZP2/85cDalIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4smij/kG6dq+0f9+u75XypkXVO1jpI1hr1hKqV7GcU=;
 b=c3uXoZJ3z8c3tn4C8Udoy8HvK2Vt9PJLFxeo4laZd3yiqxqbscjNGZFxcN+5gz9hlxhhHJ+Ws9uvYZSijUDmcwnt39Q67/5roiTJGMNq4Zi3SoM0OIRZw33ejnFo2oyN0chcwzATOOMGKoTCf5tEebVaKhcDYs/Wc60Rsm9FPp7+cXz9OYPvPneJ+LMx0UPEYHpzebTYB9m/b3CQoicpWCOeNzMreN0tH8t8UDZwSekYCBfeNx5b2Y7i6IsPgSMJbQ6xw3/aH4fe4+bIxUWuGmJlPRQT2NiR1O1KxEVFNvAgOhw14bOh0gnRRMnwKnf3v0yOkCPspXxu5mkczdXuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4smij/kG6dq+0f9+u75XypkXVO1jpI1hr1hKqV7GcU=;
 b=BB1787cELTPbv+na6WQmoTdkOqmOZh0zGICsHXjy+19ZqP/laZPgMK9BTN7Er6gNrse7QVyKfpsqtnF2PLAmNb9MPvNzb/2lvpkPRnFBYA6bqQUzsxda+yTCvpqIZuckHkXEdUfI8cGbq3+3xAeCuFbnbulsKFchur37/6ixkT+Cp76FuKRk3Pumpa2iHRNm7i4+2PU8uz3DKLuPoXFep766cqcf6O0zJxyo68csCI5w+t1hRdLdiZLdbPaZBONGCmO8hqwp4EUAXcowbfgsE5EFLNYsKjRLk0jQw39CAhP1wTgjDBQ1Tyn1rX7UzDi36FWIPF2AyzDrYRzlqDLq/w==
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Tue, 13 Feb
 2024 11:15:53 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::37) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 11:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 11:15:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 03:15:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 03:15:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 13
 Feb 2024 03:15:39 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] platform/mellanox: mlxbf-pmc: Fix signed/unsigned mix-up
Date: Tue, 13 Feb 2024 06:15:26 -0500
Message-ID: <d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707808180.git.shravankr@nvidia.com>
References: <cover.1707808180.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: e864fba9-aa82-435d-497a-08dc2c85244e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6kQdeX9DhVBB9uiJnBnEDBvMdKoVyEdkIN+A7LBurG5zERNfYil8COubHGOclPqiT52nDSOtKqjJu+lfg0VxwBTThTX6BBJD9s/U1Hvrx/0Z7dAGHxlo8LHb1zB2pGRW1LCGNQo2KaD39qpPLVvRK5JcaOHk6UDntlDaST+qYEvXC4zlqku6nbdyryWmXBnWMF6fW0yaFBDJfXyoZhK03FTQnfKDqT26NYNDmFqOn/15yYq3Dig72aNjATwS0OBuqYEc9BDwEYVcYNmy0jUza+hX1mp1/e0pVIoR04eUC3T90h6pm9P5BG6yaqWjaTAf8Vwe9OXV9TnR2RlejVCtjOT8xidDDM8ryWuM9ou3KdqdVP8///ayTaEF8vsCvThCzQ4M3rBHy4p0nQg/IKeg0NeJh5bvWEx06V/0/V1U7gmN6E0J/W5jGDZ/DgszX3Dr8TvtCklVQOPh8TyA5hsAJAbK0vj0Zc/ZGUs0EbLiNiJjQ1LkmuQI3Hc0xSYZNc+H8oFxEfsb/8OA8WKGWhqhu3Xk3m7syc+9VDb2z3zlDJCPlJeHzw99JtqKwytvT7vNFZwXuRpx8LUA76cnr0S5b/LHHCkMDOtOzyPkdN/hg0A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(86362001)(5660300002)(70206006)(70586007)(8676002)(8936002)(478600001)(4326008)(7696005)(30864003)(2906002)(7636003)(82740400003)(356005)(26005)(41300700001)(83380400001)(2616005)(426003)(336012)(316002)(6666004)(6636002)(54906003)(36756003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:15:52.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e864fba9-aa82-435d-497a-08dc2c85244e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

Use unsigned integer types for register values and array indices.
Use %u instead of %d accordingly.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 129 ++++++++++++++------------
 1 file changed, 68 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 86044d1b8fa5..250405bb59a7 100644
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
 
@@ -956,7 +956,7 @@ static int mlxbf_pmc_write(void __iomem *addr, int command, u64 value)
 }
 
 /* Check if the register offset is within the mapped region for the block */
-static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
+static bool mlxbf_pmc_valid_range(unsigned int blk_num, u32 offset)
 {
 	if ((offset >= 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
 	    (offset + MLXBF_PMC_REG_SIZE <= pmc->block[blk_num].blk_size))
@@ -966,8 +966,7 @@ static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
 }
 
 /* Get the event list corresponding to a certain block */
-static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
-							   int *size)
+static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size_t *size)
 {
 	const struct mlxbf_pmc_events *events;
 
@@ -1044,7 +1043,8 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
 static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 {
 	const struct mlxbf_pmc_events *events;
-	int i, size;
+	unsigned int i;
+	size_t size;
 
 	events = mlxbf_pmc_event_list(blk, &size);
 	if (!events)
@@ -1059,10 +1059,11 @@ static int mlxbf_pmc_get_event_num(const char *blk, const char *evt)
 }
 
 /* Get the event number given the name */
-static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
+static char *mlxbf_pmc_get_event_name(const char *blk, u32 evt)
 {
 	const struct mlxbf_pmc_events *events;
-	int i, size;
+	unsigned int i;
+	size_t size;
 
 	events = mlxbf_pmc_event_list(blk, &size);
 	if (!events)
@@ -1077,7 +1078,7 @@ static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
 }
 
 /* Method to enable/disable/reset l3cache counters */
-static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
+static int mlxbf_pmc_config_l3_counters(unsigned int blk_num, bool enable, bool reset)
 {
 	u32 perfcnt_cfg = 0;
 
@@ -1092,7 +1093,7 @@ static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 }
 
 /* Method to handle l3cache counter programming */
-static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num, u32 evt)
+static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
 {
 	u32 perfcnt_sel_1 = 0, perfcnt_sel = 0, *wordaddr;
 	void __iomem *pmcaddr;
@@ -1156,7 +1157,7 @@ static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num, u32 evt)
 }
 
 /* Method to handle crspace counter programming */
-static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num, u32 evt)
+static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
 {
 	void *addr;
 	u32 word;
@@ -1180,7 +1181,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num, u32 evt)
 }
 
 /* Method to clear crspace counter value */
-static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
+static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
 {
 	void *addr;
 
@@ -1192,7 +1193,7 @@ static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
 }
 
 /* Method to program a counter to monitor an event */
-static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num, u32 evt, bool is_l3)
+static int mlxbf_pmc_program_counter(unsigned int blk_num, u32 cnt_num, u32 evt, bool is_l3)
 {
 	u64 perfctl, perfevt, perfmon_cfg;
 
@@ -1255,7 +1256,7 @@ static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num, u32 evt, bool is_
 }
 
 /* Method to handle l3 counter reads */
-static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num, u64 *result)
+static int mlxbf_pmc_read_l3_counter(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 perfcnt_low = 0, perfcnt_high = 0;
 	int status;
@@ -1286,7 +1287,7 @@ static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num, u64 *result)
 }
 
 /* Method to handle crspace counter reads */
-static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num, u64 *result)
+static int mlxbf_pmc_read_crspace_counter(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	int status = 0;
 	u32 value;
@@ -1303,7 +1304,7 @@ static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num, u64 *result)
 }
 
 /* Method to read the counter value */
-static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3, u64 *result)
+static int mlxbf_pmc_read_counter(unsigned int blk_num, u32 cnt_num, bool is_l3, u64 *result)
 {
 	u32 perfcfg_offset, perfval_offset;
 	u64 perfmon_cfg;
@@ -1340,7 +1341,7 @@ static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3, u64 *res
 }
 
 /* Method to read L3 block event */
-static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num, u64 *result)
+static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 perfcnt_sel = 0, perfcnt_sel_1 = 0, *wordaddr;
 	void __iomem *pmcaddr;
@@ -1392,7 +1393,7 @@ static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num, u64 *result)
 }
 
 /* Method to read crspace block event */
-static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num, u64 *result)
+static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 word, evt;
 	void *addr;
@@ -1415,7 +1416,7 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num, u64 *result)
 }
 
 /* Method to find the event currently being monitored by a counter */
-static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3, u64 *result)
+static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3, u64 *result)
 {
 	u32 perfcfg_offset, perfval_offset;
 	u64 perfmon_cfg, perfevt;
@@ -1454,7 +1455,7 @@ static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3, u64 *resul
 }
 
 /* Method to read a register */
-static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
+static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 {
 	u32 ecc_out;
 
@@ -1475,7 +1476,7 @@ static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
 }
 
 /* Method to write to a register */
-static int mlxbf_pmc_write_reg(int blk_num, u32 offset, u64 data)
+static int mlxbf_pmc_write_reg(unsigned int blk_num, u32 offset, u64 data)
 {
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
@@ -1495,7 +1496,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_counter = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, offset;
+	unsigned int blk_num, cnt_num, offset;
 	bool is_l3 = false;
 	u64 value;
 
@@ -1529,14 +1530,15 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
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
 
@@ -1565,7 +1567,7 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 		if (err)
 			return err;
 	} else if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
-		if (sscanf(attr->attr.name, "counter%d", &cnt_num) != 1)
+		if (sscanf(attr->attr.name, "counter%u", &cnt_num) != 1)
 			return -EINVAL;
 		err = mlxbf_pmc_clear_crspace_counter(blk_num, cnt_num);
 	} else
@@ -1580,10 +1582,11 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
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
@@ -1609,8 +1612,9 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, cnt_num, evt_num, err;
+	unsigned int blk_num, cnt_num, evt_num;
 	bool is_l3 = false;
+	int err;
 
 	blk_num = attr_event->nr;
 	cnt_num = attr_event->index;
@@ -1621,7 +1625,7 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 		if (evt_num < 0)
 			return -EINVAL;
 	} else {
-		err = kstrtoint(buf, 0, &evt_num);
+		err = kstrtouint(buf, 0, &evt_num);
 		if (err < 0)
 			return err;
 	}
@@ -1643,9 +1647,11 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event_list = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	int blk_num, i, size, len = 0, ret = 0;
 	const struct mlxbf_pmc_events *events;
 	char e_info[MLXBF_PMC_EVENT_INFO_LEN];
+	unsigned int blk_num, i, len = 0;
+	size_t size;
+	int ret = 0;
 
 	blk_num = attr_event_list->nr;
 
@@ -1671,8 +1677,8 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num, value;
 	u32 perfcnt_cfg, word;
-	int blk_num, value;
 
 	blk_num = attr_enable->nr;
 
@@ -1692,7 +1698,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 		value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
 	}
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sysfs_emit(buf, "%u\n", value);
 }
 
 /* Store function for "enable" sysfs files - only for l3cache & crspace */
@@ -1702,12 +1708,13 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
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
 
@@ -1745,10 +1752,10 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
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
@@ -1797,8 +1804,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
 		attr->index = j;
 		attr->nr = blk_num;
-		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							  "counter%d", j);
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL, "counter%u", j);
 		if (!attr->dev_attr.attr.name)
 			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
@@ -1810,8 +1816,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->dev_attr.store = mlxbf_pmc_event_store;
 		attr->index = j;
 		attr->nr = blk_num;
-		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							  "event%d", j);
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL, "event%u", j);
 		if (!attr->dev_attr.attr.name)
 			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
@@ -1822,30 +1827,31 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 }
 
 /* Populate attributes for blocks with registers to monitor performance */
-static int mlxbf_pmc_init_perftype_reg(struct device *dev, int blk_num)
+static int mlxbf_pmc_init_perftype_reg(struct device *dev, unsigned int blk_num)
 {
-	struct mlxbf_pmc_attribute *attr;
 	const struct mlxbf_pmc_events *events;
-	int i = 0, j = 0;
+	struct mlxbf_pmc_attribute *attr;
+	unsigned int i = 0;
+	size_t count = 0;
 
-	events = mlxbf_pmc_event_list(pmc->block_name[blk_num], &j);
+	events = mlxbf_pmc_event_list(pmc->block_name[blk_num], &count);
 	if (!events)
 		return -EINVAL;
 
 	pmc->block[blk_num].attr_event = devm_kcalloc(
-		dev, j, sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
+		dev, count, sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
 	if (!pmc->block[blk_num].attr_event)
 		return -ENOMEM;
 
-	while (j > 0) {
-		--j;
-		attr = &pmc->block[blk_num].attr_event[j];
+	while (count > 0) {
+		--count;
+		attr = &pmc->block[blk_num].attr_event[count];
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_counter_show;
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-							  events[j].evt_name);
+							  events[count].evt_name);
 		if (!attr->dev_attr.attr.name)
 			return -ENOMEM;
 		pmc->block[blk_num].block_attr[i] = &attr->dev_attr.attr;
@@ -1857,7 +1863,7 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, int blk_num)
 }
 
 /* Helper to create the bfperf sysfs sub-directories and files */
-static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
+static int mlxbf_pmc_create_groups(struct device *dev, unsigned int blk_num)
 {
 	int err;
 
@@ -1900,18 +1906,19 @@ static bool mlxbf_pmc_guid_match(const guid_t *guid,
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
@@ -1921,9 +1928,9 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 		/* Create sysfs only for enabled MSS blocks */
 		if (strstr(pmc->block_name[i], "mss") &&
 		    pmc->event_set == MLXBF_PMC_EVENT_SET_BF3) {
-			int mss_num;
+			unsigned int mss_num;
 
-			if (sscanf(pmc->block_name[i], "mss%d", &mss_num) != 1)
+			if (sscanf(pmc->block_name[i], "mss%u", &mss_num) != 1)
 				continue;
 
 			if (!((pmc->mss_enable >> mss_num) & 0x1))
@@ -1932,17 +1939,17 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 
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


