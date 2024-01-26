Return-Path: <linux-kernel+bounces-39745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C583D5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C94C1C232B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C467E92;
	Fri, 26 Jan 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WDE3u4e6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E167E70;
	Fri, 26 Jan 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256542; cv=fail; b=dJJbtrJazDmfY5Rd0dRU7l5rd/mjU5A9YdSPATeqDhsUUxMugBXa4OIOo/z1nxEgXoFMR3SD5dt607UhUcIlCKAYWwv69zCV9iVF9HfxfWDpyO5M626+4Ni4cmZF0J6gUKMfWZMVAagy529asVVnn4iXr142tgWqbl9nM9IVNXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256542; c=relaxed/simple;
	bh=HHN68mUMnQ/ke/MzVYKq29cso4Wlt0lOHTl5DYePJ7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0h9AFU5WhVWL+8No93ePCFIgEbMrKKO64zlvQL6gCVM8NV8rDY4kUNcy7j+e8w3460IBue8Efw2lFrUgIx72tHmO1ezWH5WGSM0OJY3DU2TwG1Gu7HOHGiVQBB7dPYxOFYp4KqT999PzZpqmBAHXDvU1yC0NGmC8psl9l4wY4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WDE3u4e6; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkT8wVjNuz45YZ+kHf2AsNrryKT9gkQFBLttk9mCr5+CbVszD2FRhTHSN9fklE1joptUJeWa+7waPSKBnSqqJZA9BKaywPiLj6iyrE5L0IL0wlsJYwo35Z/nlv+3JqaugSPJHhKClA1DrczI5qWuSTML6Iw1bO7FT8eZp0vf1SQT96fKJjZx2dVg2NwvnEA8MGAx6tiC5wKGd8QEUUy5Pixd22n1ihHF3T2pAIRDJaXmbtklPJADyHZXIldLY9mY5165hziCQhUR8VAnwzF87Tox7xIRxAsmKuuZIgPqfuUf/lCm+BeCkZdElew4eMM+Nub8SDFuWMr0HejdgErvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sp20khTAJZurAfz42nx13ejcvn5tzFPqNDo5+iMW3o=;
 b=ehw1j5CLL+bxsg9ddQGMFmdDAFZ9w1LDKAoSh25KYEVSeg/byIx3/5DbIeUTzn2VljF41puPgXoSOyDMwfr1TU54KQE6exFWpCCA/3FDfmdfQxx6vXt1Xo4wRI858zePGqrvwjQ9emZxgFf6Dx832DUwNtN9wNxcCQFIru5MeUi+PY4XRNKg8dcqmCCQSkuQkMb6WCy4RiYcX4QprSF7aaa3HgQQflBtW9yCLPm/KYQmLiB7GzzRMlS97WvYnSiPFlrjiAgyUJYbsL2ACeeuTynJjETRkkos1zvVROtLXXzkPxYN+u5hzk+E3qiHsllHrAkjP3ZuW/k73K5FRbWEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sp20khTAJZurAfz42nx13ejcvn5tzFPqNDo5+iMW3o=;
 b=WDE3u4e6yM6ZOE5UMZEhBhV4YSqGutPDVea5otoX2TNP2qWHxvOlRkQD39+1RMU15q8oh3xbME7tMKBOo6Chjal+6DuslPLaVjSjZ8z9si2zzJDrghV7WJPz3IcCRHNHkKaHvFfTV56CkmzYfW081eX87rK7WQC1ADMudp3JEsw=
Received: from BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46) by
 CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 08:08:58 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::11) by BYAPR01CA0033.outlook.office365.com
 (2603:10b6:a02:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:58 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:54 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Fri, 26 Jan 2024 16:08:08 +0800
Message-ID: <fa8ef25c7483169571ac9c7f26074045ba4da477.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: b4297f0a-6abb-4ae5-cf16-08dc1e460c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/WqGENfOFwcI1+4Sc+IMo58DIWa9HjicTz8vZEnvv3bIyYbwwAKxwaqGznvmzHEW3iW/OQfXC6YzOEuGvZ3Ebe/Ox1ALVeleQ4ejvgAnNlokIYyeVSrp/X0ZZL1PhOSz2qDW1XZzROPoKKOgAk4E20UbPMPt8n55Ql9Rm9kX+lG8fHIYqzstz56eSxLOql9k+gIzr6CX5dB2Om1BTTUPudCfC51WVuMZabmigB8CYNleC1Tn2XTV72kwayLoFuUaKuFEdNsDK2AkcSar4nG47KZoN9/jJpGycYnPclGZvxFw1dys2uUJm37YMNk3IDsukr3DBqiiJOGlPt2ve3vTfq+Ubx4YJnBJnQGZvWzrcrvHM724eNNgDqP616xxH06FmULgSmonwGhwvOjE6Ug9QpZ+HjAjAQRRMo1JLMXsSARfZwB9fhkGgvCtO2jARMMa+UsRmOKUjwi7/Xxryl7NI6fMYXRnBYUNNkMSogIuiqU53uXchG7wWyRygk/qB+tXKA8ndanY1XqGgjCfUjPpQSRCEO+NwouBOD3VG9vT2o5/Fd7wjsky8+8haY2zPA+dDDaNLZZ8qyaBu5hwi9Y7iqUjdn1StSRDHN0CJYdHxy0V+w5VLcY4oYfMnRZ4YJT6PgPYLzKqX7UtepSl1tuMA9GSFkVqhmQrcrAIkF+Zq1Z00lVD7cr7G5scuNHPjQFXsoL+1uFKlANKQO7HReS3+2SOWFEb9OdgsJhO8kk6edJHL+N8EkY9hx2mU6/J3uVQmLZ7mQQ/tMaIGG0ZI0pnJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(36860700001)(40460700003)(40480700001)(81166007)(356005)(2906002)(86362001)(110136005)(70586007)(70206006)(47076005)(44832011)(82740400003)(54906003)(36756003)(41300700001)(83380400001)(6636002)(426003)(8936002)(336012)(316002)(4326008)(8676002)(478600001)(26005)(16526019)(2616005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:58.3574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4297f0a-6abb-4ae5-cf16-08dc1e460c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

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
index 3286d72f375e..5cbbc2999d9a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -443,6 +443,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u64 nominal_perf = READ_ONCE(cpudata->nominal_perf);
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


