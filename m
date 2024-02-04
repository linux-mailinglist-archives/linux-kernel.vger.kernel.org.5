Return-Path: <linux-kernel+bounces-51627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA8848D76
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FF4B215B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6F23770;
	Sun,  4 Feb 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dI6j23oV"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBC22EF3;
	Sun,  4 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048811; cv=fail; b=P7GTxpKGU0dx5tgRiIbpIuJojYDNCs7wQqxZGTYPO8vKqcH2qIDhstaa7jVMdyRywt9EzaPPkPxRt6PJ7PD4WmtggYiq/BiOjepEP7yQmpt44pVhK/yVt8jnH/HbP07Prfpixfq0KRQ0eq0G0JJq/Ud+n1D60nDCkB+UzbquRsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048811; c=relaxed/simple;
	bh=45MaXr3YTERkJ7DQfyH5UxPqRMS9l4cB8PlpR4qtao8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3v558vKYhVRRK2zdEd4tHehsL6pNZkMnxZOKFYalj81p+cZaLFy7oQogszJ26pnl4NCVE8x2Qd4WvdAZ2UOFEsMab/bXCXwedIq6fjHvSWqWlRvHYq9oeMaUw82P3H3lo6F0HkIj34mdoY2As1Dc6n8rfm+zjO1CZOEMzSmqzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dI6j23oV; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI0IyztVvmAJLvHgrPj8gXk157lhNIjVJ4FoJOFkLXroYvGU+Gb6pt50gVrcwX18t0hdi3mi0ubQ5wq8ITWzTi5exw0pUVhHnARtUyndoyqkQEN6sW+sdxE+lK0IZ9ffApa2oC4ArX9UEkukRomxoOQSi4HtXggVwQCnAlQlgtU5jc7XpEQzGBpmAPhxMIryAUzJjNM2/ev9YgdRoady2nbMgVx7GPNuX8TYgNjYwJ/XoETGopg+4yN0KnE4Ww8NlMjKDNIF84dg/m1rakIE9kaZ4jdAqZjbXaHYM9UvnWOyQtheIE1YZoCE6m4seO9TwsRP/vuH7dGmfKmE4sIYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL7/kDrDkDwifdCPz6m3yDHXFfmRl+0gGOZRFG1jIsM=;
 b=UrLRqcmtxqWLy9L9PrCYGGc8d+f2BBFaKo8BMzF/2v7B2xkedJOqmd2wfvSB+JVZWBm/bZfGpAR+rI003cRpYawy3IkZhsl05+hGUeZPpK7roKhmHPjdeUc/8d9OzR6LW4ZcJWv/tsgs0EZ2cuWguUBqvhr03YL1s8tascpSGLKgCgkr06A40ua0o1SjZ6KHBzMnxI9C1gQcT5Logv1TUI5kijGQZRdBBf+GiE7y/TFyuCdKne4wJErPQainwwu7GnFOKjv97LXEVokOjFZPMrt8nUtpEgQ6yka1UK3VsSA04lVBB8i1+K7wWdMN5t/PNm7q/DgchG1Q22Grp6HN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7/kDrDkDwifdCPz6m3yDHXFfmRl+0gGOZRFG1jIsM=;
 b=dI6j23oV986QjiQtxCW1SFF9R7FbgpkE2UAluyyk64pSBCIJH4gS7VnzUDxtdiO4l279TpVpEpeCDOSTCARBVHRK8ew+TK8Ynmb8Db7McyBU57/b16K5+gohJgh8zONRhAqOXW7tFtqNxkRighekdlG+Z9J6cakIxgJoKvS3Wrc=
Received: from BL0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:207:3d::23)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Sun, 4 Feb
 2024 12:13:25 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::3a) by BL0PR02CA0046.outlook.office365.com
 (2603:10b6:207:3d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:21 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Sun, 4 Feb 2024 20:12:55 +0800
Message-ID: <a97c45571507480d35b36d6e497630e1220eefc6.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 809e9b7a-65dc-431e-5b27-08dc257ab024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGTnsyJrKHt55XVEIPpi+vM3Kgedja2BJlhcGnpCjGhQX0w95hc/FG4VeIhiPe1GkUDmJHBGZSz4F9qIevEI892u1KaEgyBgdGteNPCOhf+WEWmelD/j93Aks9Gr7pelTnYUQ7sG0yAW1ULjvlA9IiVxYXShpf/dxufguWh06/WAB+erfKzp8THTBYXY/Ggo8rnOXBzGkYke4Nn4h7+/7mizenNy0CwodIl/NTOY/4c3ykrdye7OIv5vFcu3sW4CTlaFhmUoBpZKhBu4QkLSv/nEvmDae4vo61nIEFYcgInAUaBKB4vNwE7Kuea/zh6LXRSULLv7rKSD+tR0F1qztJgx/nkGJWfVySfFVouN7Odm8w74Ygvo9TZ2A67Z9l3e8Lbi/F4haVg66K0cHFEbSCeozYiiHFlfy5RDm5XGbn17WN+oZdb5Gg8gWvL/ct7gRfHTwNkjxpvH/9wfm8XZooJTIq9rj/4wUqfL4GyM8/NNAsH/S0C5HO7z8mGzK9RxSC4TmTVNEz+wLhIBbuHhhlujC0iBn4PyLyWJvjILipBuw6ZFPeDAdDfEJWJagNXcqtWbmw9YKhiKzCaBSXxg6mEw5ElG1J2Acv81Xlc3laEJLJtd3RFzXanAYjZ0J2CyUqeaatTtNsWXJHxPdVuXfa0oi2A7RhZSJ5UpuAzsZfpzC4QLDuyCkX6R7HjgCfcrkWZ5ba1QjRtjPpK5OtxB4qYi6bdrqKTn6eLQKI8E1FRcX1gsa8MNTI6ZDNDy5XJ6n5JcjwGk1N48U+uDfYVQ9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2616005)(36756003)(6666004)(7696005)(26005)(86362001)(41300700001)(36860700001)(82740400003)(356005)(81166007)(83380400001)(426003)(336012)(16526019)(478600001)(47076005)(8676002)(4326008)(8936002)(40480700001)(2906002)(40460700003)(5660300002)(44832011)(70206006)(70586007)(110136005)(316002)(6636002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:25.0709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809e9b7a-65dc-431e-5b27-08dc257ab024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here we need to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 107883cf0877..02a76b8fb298 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -443,6 +443,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
@@ -458,6 +459,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!global.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


