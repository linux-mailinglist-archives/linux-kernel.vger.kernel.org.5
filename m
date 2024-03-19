Return-Path: <linux-kernel+bounces-107474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8287FCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CEC1F2310C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09057FBD9;
	Tue, 19 Mar 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Soe78rsx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03E7FBB9;
	Tue, 19 Mar 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848022; cv=fail; b=qzA/A6K1Fo6X5rktEF7h3YG2AIfLVO8mt/Xmjf55i663NichsdNxCJ/Ba1QZZq6aeaFsqWbYR2p/B03VThR9fDzQkdsrXir9lPR2hkO1EWA651Xcd9bdRFNfjzuWGXFQiC4DwStZIZr92OMhk8ey2votiLKV1rdHVt4ahTKab44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848022; c=relaxed/simple;
	bh=KONc5UKShc4NqllYcxFGx6fEWh70f+iZ5fBkkyFMKXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEyJH8CzVl0tfEGVlpM0YlIWB6JRGAg5n8ms2s/aJBOnl7NYZig234MPphcf5DjoCEa0ljncqW8JEbPqjJYvu6g7rfRjDEzP87pYHyoqEMrDgpdLpmUG42FvSkIcRvRVmqrNASHzZOq2Imt1eeMLYCNUCHP1w2K+PYD3M7vgZIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Soe78rsx; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar53jN1Vhx5mlJey0PS++2xgq/rcXN9Y3TxfnGW/z5MgdFOQh17YBvC7ADMUPTK2ZW8VrmqtzkShULBXXzoG8bMS6SjWlBahGC9K2tZ9UrNejSggx73NFnjqPuPED8Ld8IsKdWvQShS7JiYEPKD1olkEx7LIgjcOMd1kR/dNoRgPsFzqldw7NXWFUci89YZfwczhzpECzuyuTkyvP7VJ1b+GFvE2Ph52cGr++aGIKkfikEjzLX9ssmc4DUJBD3oKmIDwbKRmewKVwOQUZp88QD9kBj9kUOFljGocFCMPo0coLOmWGdsY2TRAb0cZ7m58BxdFvjwc0HBsbsoHPmjhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrThdxDYx+HelMReifKH/2yl+3W9qSQwuZ/6QxmbMqA=;
 b=PdP6MIWr8wKmi/0nS77YRqZp+nXKoza6vYn0OwHV6dug3UUViQ5OVGFVNzbGnfWnqtM8prILvyl+dvoG3Dez3n1KBJB44EA4d0Rt/ljQw5/lE5CRh9AmNjUglmY9znHuVKgqbm5k2mcqyN/QHHuNsKjF5EfKlAOA0Xs21HTphnifbcUlV33AEvMGaABOxGskLIM1gnEJBFnbensV9LusSEaioJ6srkFFwlOwnmcaywO+nGXoat5w8ElDIyCEohymkcrqZk29rIfrXnlnVLgS64B991UXrMwQJeIVzIBB7UvAOtfLr6FMjC5wR8YiSo30GF7pO/IMv5TOR257PUlJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrThdxDYx+HelMReifKH/2yl+3W9qSQwuZ/6QxmbMqA=;
 b=Soe78rsxKSNONz0luaqqLJAkfwvHlDmZAeMQ2qHKvfRUr9c7DsLL3kfQQOHT+HIVYZtK4aCSfJtiuWC+23At+E/b9EZzmqM4F4we3DHOjFUITLNNKJTJ5hjOB6226aQdxU+3MMz0e2J9YPM+VYJDfvVHX0BTc2TMNC5pm6ZnsIw=
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 11:33:34 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com (2603:10b6:303:2b::4)
 by MW3PR05CA0016.outlook.office365.com (2603:10b6:303:2b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.12 via Frontend Transport; Tue, 19 Mar 2024 11:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 11:33:33 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 06:33:32 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/2] RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
Date: Tue, 19 Mar 2024 06:33:21 -0500
Message-ID: <20240319113322.280096-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319113322.280096-1-yazen.ghannam@amd.com>
References: <20240319113322.280096-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: fae5604a-1b9a-49da-b1fd-08dc4808692b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iLcX8DxUlgK3EgITdF9l56//QFyH/+KmLAQHgMyxVYyU5orusU2vj9grJ+Mc3R90ZH7z4YGAMq3L4Go4jm8uZAhG6ax+L7IoGPyDvbp5wB2oR01EKJX+oAv1YOG9JzuqSq1yVhqt1gSnR0hbkiz2HYA2u0z0DfvdVejPeaBKZAFnPMxS2EhZzdGx7dtnSEqILMF6bHsYtbhW2tbFTi60IIsdbyCQSg6vABMEzGo0edHOaCmo7IWUCrEt/1D+8yiWO8xjejEkVSSu16f3qo3HcnTy4R3uxNCHe5vL4yt7QB/YiBLv0Du5MPWbtzobcDp5o0oExfusPjjr62hhBmsotPKQGWH2ywQCjYDkYk40dQZIQEy3dW0dzrcgvR5SXlVJsJmYIV8HyYNWdPKvWJ9HT5iQBzWbataK3my6+AWvNny1KF4RrJeS0harqPzOMNbXsIovcyMNwMkyZXtIm5FMx5WJCyYHOjuKz+OwEutY89eIoDwlESxpeRMUDkFbvfsbDKwep00OMYzedazOUQ5212u8B+T+ohbl/t/06JGfZBvrLg3KasVUCbeR4qXakpWFC7B+BNcPwB7IQ1UStmXHRVlswY9QDOWyiT7bHxhzE6VlD8hv51LA3cY+e/GeX+t3oqt9gttzdcutlCJUn1cksT2KKycAKfDZITe6wuHVreqkO9QFR4EHpeYlRA9p9XTyWZQ6t1I1JuDvbpqB/KyRIXddIxWIbM4PHs7y4tFgXZ3OjDdWgp/bgVXTfecDZ7JZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:33:33.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae5604a-1b9a-49da-b1fd-08dc4808692b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

An old, invalid record should be cleared and skipped.

Currently, the record is cleared in ERST, but it is not skipped. This
leads to a NULL pointer dereference when attempting to copy the old
record to the new record.

Continue the loop after clearing an old, invalid record to skip it.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/ras/amd/fmpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 2f4ac9591c8f..9d25195b4538 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -676,8 +676,10 @@ static int get_saved_records(void)
 		}
 
 		new = get_valid_record(old);
-		if (!new)
+		if (!new) {
 			erst_clear(record_id);
+			continue;
+		}
 
 		/* Restore the record */
 		memcpy(new, old, len);
-- 
2.34.1


