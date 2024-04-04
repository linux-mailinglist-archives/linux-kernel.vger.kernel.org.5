Return-Path: <linux-kernel+bounces-131689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3ED898ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E98BB2CE90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5F12BE9D;
	Thu,  4 Apr 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5TwQ8IJp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D0823D0;
	Thu,  4 Apr 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243669; cv=fail; b=V08kHq9dDxtGnaoPo6anqF/znYfBk6txArQ2ULYyBbUXi0qn9skFSgmf6gbHf42s97vg0/Yrppk7sO/zXo+nQ+1gG6g2G3vnlWlX4yiKXYlRF7fxFIn3T/cfsLzZjRME0VhGhY6tGtaKuVCtT1k3yACCa6c1et5diqtCnVSZ7VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243669; c=relaxed/simple;
	bh=X/O/cVvQ0bk66pmGOrC4kUiJGBmZGD9SrKgoQG/VdOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnAdDdvZKFbvbdNycxgRW9ucnbLRRsZaHjj1yDhhOVKYUDXAt8X8fDXwpa4hVZ0lHR5vOGd1LXil/eHNRVYQDYss7kSR4pYTiXLtj4tRJDJRNTRhutLqVz0kOE5l9g23h0IHv5TrZkwyGeQztQ6ZwfoiH7sEZDBOFaJ4/aGNcTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5TwQ8IJp; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeUQS1WGpcXBG2HlqmgIJgxqAJ3vyjCfRd0sPFW4s8OeAX8KIemeOHBcGqb2GIa3IWsAXwGjn/BxgOwURQJPK45C/A0cZSsEf2e9KJZxaQGFDkOYT+StO8PkMVqtHq1i6MvvqBWYtYmikXQVwzWxRH+yUbZ2CSSjB9RIf2meUMBCJRnbDkKUoCLo149tG+85bqdIop+p1y5Wi60e8ZHYy2jP7ja7JKGS/fwC67pJZrKSzuVNFsfJZ0Wbj4nJBjrGUEhG6lfQmABRfb4Nx/Dp/l9W93VBAWMIb2jDXqebMPQSS49qOQwn4vfyk4pbxiUZIRaghMVZsapX20gnZBKBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKYsFKaHwAtFnsm54C34f0OvS6eu45Lr8/f0OlgxHIM=;
 b=P52s4S3jdrTPglF27t3C+2s1R61/7ceOnOgX1/HLgq1hkQcUOQ3gE3JdnPXgruC9Gpb/ZT3XkIivmqw37r1r7RtYnsBbUNZNdEfEQiD9Cf0dLWKEiDsBAFHTYCYDe2rqd1h4KJwmWmNh4KCKhu9BLEGnvuNVGET+TWtyal0ccmVvWjboGP7LlqwNn9Wrhn7k3PTr2qb0cIrgpcH2m1nfMHcmQdwHwwB89IeW8szuhmCSFhcje4osuNa04FUAU4s1GbyRocs965Ckz64mH6YqeONaf2JaZNpP+I+iL5JbJ9hgwjNoLVz1BiIqVdAs1BKLBBRHvjybrjnH6LsZFpvEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKYsFKaHwAtFnsm54C34f0OvS6eu45Lr8/f0OlgxHIM=;
 b=5TwQ8IJp7xeb+RuM10mV7wZSa7Bwf+S8vsXNNQhnvOjrbL5mo1npY/BDuyKl+pOx1uqzAhFwoVfhPtlelwfxidCiV/AnHRHzKKih3ESACO4xXOGGV6hLCj3g/xlVGa1bhtggZ3GYEbfcjWIPZ3OEShctrfs6UT5rEZiMWt500i0=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:21 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::7) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:20 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 02/16] x86/mce: Use mce_setup() helpers for apei_smca_report_x86_error()
Date: Thu, 4 Apr 2024 10:13:45 -0500
Message-ID: <20240404151359.47970-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 501fd181-48df-4fcf-3a00-08dc54b9e776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N1Y/k7yAFTYCf/d5oumfTlfOPpTnbd5VwYzlKoNkXCWEymEj3Xf4oatbgFGtghPR01e76yy0ILNAPJ+exiugw3xTOIYoQ15e+X3umEpEWbty3WxcR0P6DqOnPVHjjQfE/b4+jO0mPwoanIY26Bn7vj9L0KP+V4cE/TKXXRTdJVQ0QvFbOh0Ixq/WIuA63u+OAYYz+bNeiueRiWseVL4Cdq6nV87nPIg93J8/jMs5jIfsZsL44Q2ZJBj2gQuDr4Kx2OZVDKYOO4MfZQDxdhORHk2B9Soy8Ru3jgPpJDu5CjsIlWCSvoaHo/e+id4awURv5Jzkb9VzMqkFvlfY1MKcKMYz+9gO/YtNlaJYeKKM4G6vFGDrL8qAAHHzIbh86GVXNNcm1cb9zzY0R+iyNHKr6BplrtpJ1V2TLjB8uU9Im00b350UJDvb/E8wdFxAhQZTb9XUHzH+MYXHQwOJEipUMCHgxINREAV32rY0g/LPmSwixa5yjzKmAzeqT/uWT6736FAVGpvgfjb1fYNJ/kKeWFsuwgON0eUIPEqa2BtSsPcVzOBz8Dc2ejLUvT4LvBo78iakbD3ZNIlrKoXq8dkyjQZltjs72mMl/b8YtyvxvfZAhPj0SXVQlS32P6pPKdowInp/qvETI3/jmKGpU0TaBoWvVfRb7DgUwkFEgzXvkSpmPT3D1aKCjJMqPwLsDlXFQQPgWbSVtaQX5C/IZ9dR4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:20.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501fd181-48df-4fcf-3a00-08dc54b9e776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

Current AMD systems may report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

The CPU number is determined by searching all possible CPUs for a Local
APIC ID matching the value in the x86 CPER.

Use the newly defined mce_setup_*() helpers to get the correct data.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-4-yazen.ghannam@amd.com
    
    v1->v2:
    * Trim commit message (Boris)
    * Rebase on earlier changes (Yazen)

 arch/x86/kernel/cpu/mce/apei.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..e4e32e337110 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -97,20 +97,17 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
 			break;
-		}
 	}
 
-	m.apicid = lapic_id;
+	if (!cpu_possible(cpu))
+		return -EINVAL;
+
+	mce_setup_common(&m);
+	mce_setup_for_cpu(cpu, &m);
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
-- 
2.34.1


