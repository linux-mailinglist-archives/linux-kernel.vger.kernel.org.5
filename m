Return-Path: <linux-kernel+bounces-116436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC46889D45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EAF2A5B07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29817920B;
	Mon, 25 Mar 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3QTvOtNu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62B266A1B;
	Mon, 25 Mar 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335867; cv=fail; b=gTWY/cZ8a2AlW6gA1fSLFoaN2WfFcF9xo0mODGwP7zfg0z2kbjKPA4CElgMef8x9+K3Wmp2rV/zX31+3KCRBAtJpKVdoPKo0tuCbNwPOMPE6TuRfOD8wOpTHPuCVEzkNlzaF598Jgzs3FjkruDWGkICCxITerpZzAcutLsYdqVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335867; c=relaxed/simple;
	bh=QuIbzAZ+8WhO8LCCuU2DU2IkfXpm5HMzoRBcXpfUkM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl/0Sb2lGwPEycte/SEGiB3v0BpR7OnujzqrjX5352g7b+I67LkYUXHMxdfGg6f+m4Q2ACJcqTiwOuCbrJpTo1SxF7GLL7zjq4z5a6de5YFj2n/T1Lmug+aQdQepEhzrZ71YbrKS4gLdE1hMahULkNbLHXu91pBJ6/0hsxhM2vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3QTvOtNu; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/89DlOH4+X6JUskmHmC+WhUDKm34PlEfvmYldCbhlgpskDJ3HiGHKBQJSnAWf64fXZZDf00qeoqZH/vkiGSAJtLbZJXBFXDweBdUCHwwXEy1aLFOdpmqzzQAPJrUL7M46HeTPfr4kZ9FclXE+5MhphoJZo7yjsbhGKxtOfawRqHRPD/e2Jq1cW71lTMj3WJnGSZBsCvn9elg8u+OiKnQ6g2Fz0RD66CcKpgC+IjkXx3ZPlRlA2fBj+ssmVRobT5m7tyyO8l45K/N0+8iXv5ozyZ7d3dZRBKfLSv19k3hI9hy3eQEXXEXZQpHTu2KN0lAnzCc401fmjytq9d5LlvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkw80FHPivvzMHp/KDoBrZesEDc6mbdd3HLhIwc665Y=;
 b=cJk+jB2/UZKxAtvlJ8+rAIBpwHebPS9WBQ8xjn4OORm8ANeSjt/niJ09rAwp6LoUj73cyyff6ddt1FlZ50QnTv2XLVirCtBg7Cw9b/YvrPyJgx6GSCaoZif0puiefsdVkhqFHTihDubGTmvwZZWnyyLSdTfKfh9A1rbEsGVVy8ohc67WO+tcBdw405s+R74oD8SO7i16RU5MvKcG7kaIZLBUAx+tOshFTFx0ys7QgPs12YuDKf5wy9D009BIonRrQgO8gywDhZaRG5bmVQcZF0ZX7IWw7z4ofIxFpgbXQ+64C6gkhUUHRx4OoQMBI6gBoTD2Oqrv1wqOOyIgErPgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkw80FHPivvzMHp/KDoBrZesEDc6mbdd3HLhIwc665Y=;
 b=3QTvOtNuKZMNKohFEau+d9uxu8J5dGFUyiRkzrlDBt+rcS2o+20MSwZZHXtK9voPLnVKbDPjd7g+10Vx5Yweb62ZQpvdNeOsRBkzE4vau8zc+p/hUmrEMPL3DEzwyY+0cEizBBljAIE20D+7sodnUptUaigqCUgbHVdIjx60WqI=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:22 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::ee) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 5/8] cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
Date: Mon, 25 Mar 2024 11:03:25 +0800
Message-ID: <c2809391c877dd5842389aaf87bf2b5fce5dc866.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2652fe-82fc-4b8c-e4ee-08dc4c78451a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uAeR8xIl8TSJ26MIeFC4lUuWkyHhsWce0TtNkZMZ6iPXKtfn1qzl+Lb/1Qkv1OeentWJQ9w1EbCI7P7qUXbylm6CkQFXNcVDjwMxolYhYWsrLkQHMd0drljUJbgyEyq00dH3qEuYl31WJjakQ+0QOewjSbeJj8MCaAlWV/nodYyoUt3Ob77pOrMtDK/tavc1W8rHz51/sOfzTbL/mVbYa9GUmVSf0p2OV8+5OFSUrBeUDfrB/Tx2RJt6QEdTcBoY3q3n5jaLG2TCr3iCnFE3/tBhpexRh97xqarx4lmO+5FW5Zq/DYOLJ1DVbVvoTXSfzwZkCWDGE557jK9RQgPB62YfhD5WDXfunjVLXjTcNBD0guqKoNjS+ko++EJoUTFLQ7TCCoBA6m9cf82I6l4jIve06qPiQ+bQjokxdrmgegSrsONuSOFGsBH9zWVHMRQC67ckZlP5Sg2AeI+0wDYaicwifLPv/iBGlsOIV0rs1HWM9fSyUk2/Paww5eaICFQ+wTu41kAczAGJ/BUKo5W98rzytX7sfkAYSWDQ1ZSRpSc4pFhNYp73wz3RrSdxTSHytVAKz32t/tRb3/S2LWQV8KPBUVdRZjDvIus0vAuxahoxVBMomIV42Dakg2RlZrKh9t/PXu/joe7k0su3Hdi+5i/kZSA+Pj/rYAKl10I1OH2PlgPi5Uxa32UDFnZ/QIqwhFa0crI8TsyJc5/kVR28/DO3nZBGYYX/IreA/QCbxIyMs3cpRukfhgbJAj3ZxiYd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:21.8007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2652fe-82fc-4b8c-e4ee-08dc4c78451a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

The amd-pstate driver cannot work when the min_freq, nominal_freq or
the max_freq is zero. When this happens it is prudent to error out
early on rather than waiting failing at the time of the governor
initialization.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 132330b4942f..6708c436e1a2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -839,9 +839,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1299,9 +1301,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
-- 
2.34.1


