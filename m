Return-Path: <linux-kernel+bounces-57444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583184D920
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CD31C23256
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152B2DF7D;
	Thu,  8 Feb 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1CfYSElG"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6D2D054;
	Thu,  8 Feb 2024 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364265; cv=fail; b=tyHjplH1L/sZzEnYFZnaG6Rv+P8akQ/WvSgcnOfOS7yt/RDHCCLAN9h+wtrprsmvvPJHF6X7eGbA4thkNHRBKaeVLeZ/RLLR+wKMZz0ZDIVk2S77Rl21et4JL1HPpudGaxZ49ShiYpKVAhNIg08Tx+VsDCG5q84df+nldT6ty2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364265; c=relaxed/simple;
	bh=a7HUM9GDkpRgPggDObzXxL1tRHl/EW7CtZAkMKBnLBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot32ObEEhTHhI7u7VkOi/L7ZaP8KG26weMNJvDeDWVuXqYN8ceVXPBRyZfIAJS+6vKgKMRboq3cAbC8NH+HMEEb/afPgl1RwTy0dwLpymGSsDkmS7gLr4ydtoBRU1zdkqRkQo0AWu1behp+uRm80ynVBZCPYJnbGndRn9maw6cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1CfYSElG; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzwshKIEzObJu/LTwMuNZgNv241gOYDGLHTrnrOgk9JkEGg1iv1ORSY3VSSf5CQZx/3t9VLPTZBMORSnZ3kMYZDiL71UGiwDci5JcaxFun5w7ABuMBLJhO8ArydSKfp//7jrI3yq8Hqne7KjS4XjXrLXen1t3i6MHieXhRnIw3zWbU7PsyS7usdZ6khtjki+lVwJgwxDtN5o0qZWvfohMeZkcq2YlQxPzmcRCPlQpIQfh2AwecZkNcahEGecV8RWBdUvLQAqSTBP6Zpwz3EMWy5F8uV93dNT0NqqVUYhE92yuwAZc4Y2W+ZfY92u2LP8Z/wQ5RmNdyUGWIMSasFtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=bvHonB573rSTMedfXY5M77uzhwfUi71IXflMiL8cYAFU6p6oRwYpQRtypndI7p+YbIZtYtLKsJxFBk2QVZlmiaFnrn5eNUC1XcHCPDiR8agpp9Tgj39OuOVVNCRJstwF+9NKQyKUmHnaPOAKa9zE0G1JpwwC8X6tNfIOKRfB9rYEkdOrU/EXlNHHQw1YO7X17D/A38nFAkjzN2OFBmlHSd3cYNU+rX6csCrLfQWgtIvsSPqaSuPIaqTzlGG3AWKGQKxbh/sdBnYjWlvzactG67/krgr/j2H7AWVcGB8iRvfuGtZJpYLZtalHQmdqQfQEPD1OHbD/LVZEdjkjv3wwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=1CfYSElGDg+vrN6dmLbUrkAu/Dyna0k6L97TBtDJlA+DSBiQqX3Lg3mM25W027HcyAdnbKJEL1aSn8hJQW8dfHRMGJvEv07pqPt45SdnnIMCvcqvhDLKAJ2Ic6K3/kvr/or7kRGuBP0WHoqGe9YCd0koUjRgK+ulROjz6MO9aAU=
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 03:50:56 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a1) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 8 Feb 2024 03:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 03:50:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:50:52 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Thu, 8 Feb 2024 11:46:29 +0800
Message-ID: <ebbe3741501a31b1ffcea208393cdd8929df6455.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: faa60675-587a-446f-afe7-08dc28592789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MrJGNJuwHIiqy+VOLRqxZ8I0X0rPe+7if8r17knT/96QuM7FFYASb9Xu5VNZrmbgDc0MrEs/MCNMOhI2YJzOuetqROUfsb+VZpOPxR79JsgWR3l9ANUS8SaAbE4YIUgVjoN6Ljoeg5AwE4608j48IRKgx0cMegTNHOri1OCBKRb7FttXDpZHmoiKMqvTNx/XrCyT1M6YwAqROtppdJNXX303mcEhviLgz73jCAQLpHTziApet/aeJDgoPoCVqTDleT87FWj3O3zeU00ieQ54yYObRJjiPwHrTfsHE5UtKs09ux3n+HY5oL5SribtdboUYZHoPz8018dcMUqm5NCM7BrrcyLXNKYAYkdiYg9EGq5ohFc3aD7CmF3GYrjlWE+H2iagYQmTNVAMmN4rP0jyK5PldzKKbuQyxReKI6xpwouJ4c0eY2hQ7rifxJ5oAS4rLvASuvGU1yI2ahPdtCpMnQEqGgKa8zbwf868CMSNZUeZ9EgJBCmOBBn1JRSyhD0W6WNGCZPNc1b+dUD9u+MtMml+ksjQNoNM+c9WfaHdPjMBsHr9fjyqgEs41LDp6WzJ1dubX8ZMsXAUmcdXID1izqViBTrYXKg9CecMrkBtd8o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(4326008)(8936002)(316002)(70586007)(110136005)(6636002)(54906003)(70206006)(8676002)(2906002)(478600001)(7696005)(36756003)(81166007)(6666004)(83380400001)(2616005)(26005)(16526019)(426003)(86362001)(356005)(82740400003)(41300700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:50:55.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa60675-587a-446f-afe7-08dc28592789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

Address an untested error where the nominal_freq was returned in KHz
instead of the correct MHz units, this oversight led to a wrong
nominal_freq set and resued, it will cause the max frequency of core to
be initialized with a wrong frequency value.

Cc: stable@vger.kernel.org
Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..ac7faa98a450 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


