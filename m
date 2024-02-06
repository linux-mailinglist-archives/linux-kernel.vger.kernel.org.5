Return-Path: <linux-kernel+bounces-54315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E736E84AD99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BDF2869F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE55779F8;
	Tue,  6 Feb 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rbCNEpqy"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5807CF34;
	Tue,  6 Feb 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194113; cv=fail; b=i53pGv4nCLYfv+aFKn7peRpWCEWD1aF08+laxvDBhZImWitwnEHeXvKTuOqRfBirGM5/e7QpCog4w8TtG2LzY0JqVTfN3euC2vifACV+fImd+5YRTXsKMiDjkP/rw/PL5lVjRx3tD/D739egjn5fPVOCLp5ckrz+umW8YYMdxxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194113; c=relaxed/simple;
	bh=/faDvRJteyXqZPRAcoZKXoQ2KPMAH3/GzFGupp3EFhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVRosd9K9nhJosDCs19WKC75uc07Hn0Xb1xVNmGKUicSc2bxmyLGp1I1d/NzYBGE9lZ2GFZatcphz8rh42TSQcK+KxQcNseA2JxtxevCMQIz6BJwohHU0SkFOcscTHzvigc8zUh9xz9SdGjjkuVlFMSdjoCpqqld3VyrDFNefoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rbCNEpqy; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps44N/vaezdmvveS911U1uw/hkJGstDiPFDQBStFkspnDTjRx9WhvSxGFHsozC+TE9aZOuDjH1nyPg9p9nNR32gbR6XN77nSSbyTkLz9fqmspJQONqyGFSXQNrWMUy2u/zprzieB/xTCaIr3LYULPUX+RW0cekpPepWVBi6vxT6idDoyZRVIXCSZx/aHEgcoanhcx9fZvJFIQ+pCin9VGtFqsojQ8Q13PCYlnfNx71BJqtW8ldNCXYeBq4H/11P28Cw66RCiUrFBLrQ6cEgOm7npXcLOrsXTzeel6qfwWRAzA9apTe9CsbAlFOmx3IjTNPxUuKwMyfSJpF7iWqCfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=EuBvrnGHPN8Y0trs7hF48OatyU8ko1TbHdDDmVxlPko4+FYuvaWwx3cPyCaVBl4D84sj72oCP7oo/dnpvIKURl5Cfn/mJJ0MONA+7rH9+Cvm0Pq/Y2dRaS1imZu7u/yEJaHoalXWAXNmuZzcwd3M2AdmujbsjakQDBJ3vioP5gZNvIaZvUrA7s0kls7tvKL4YH/zef78YpOpgp6UHN20gxiDrC0selH/IMf4dFLEaNFI6Vtdg6MqFibP3nMmZKMwKkjl98kgGrK1eJnCJtH941VyP3IbhMCAfBcI9ebH4mbYz7Cd1yZ9ISwqGYAVH1K29yI0N1LVxc2iTUMEd5n6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=rbCNEpqyA23ZjzLwznZzje9OvK6Ubrg5e+6kXVIqEbcuhw1e9CsBeUVYyqjPYZisRdZVskfOlWE7pbJkJKGGBnb6Vybm2mEdLQZvdTGAX02xhUKfA8fSmWSHdfh4zyMYktxB4n6awZEjirh/hA5qIOPOp/glyUj0hwFcF18nUYI=
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 04:35:09 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::39) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:35:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:35:06 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Tue, 6 Feb 2024 12:33:58 +0800
Message-ID: <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0e3f35-e52b-4d0f-695b-08dc26cd0027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PpQpXRSZHlzgtLwU9U94rLAwZq217DlN98NSDD7YayEL07P3Rzgpz0GueOevTJa5mul4h8Uzt+hkLQpzYv/0gNK/f17Hend2HS8GpFoNeICSWLOqoTSmmD2AXFAn7EAAuVVNwUGius38UQsRzenStn/6fbQ06Vm28dmIc6Wbx1ilwxA8fSYoeMeGhLMADx9/WpH8hsI4nkeX/2/1Al6Km+Gp8WlvUmhqTNNxLVAxwYPESdSS9N7zB2zzvKixQkm10QC9/53VwyNbyp/hxRCgdzLRRS5g99c6LFGZkf4DOXvt0DHm3ZD7yw85Kyz0yGYcHJ3K6clBrPigFVoGaD5T80G29CUfPoRLeCCQjhIU1bWPVjd8HVu2fIHEnV0d3LH5lPdS5obchgz4yz8kPS3RAnX9dop+1+BhnAasmAxhsDWgWzdgWPmpytfNs0e8D7+cwSYnJ7+DinDtfry5B/b/Xr5NAimDEONBS3aLkpuBNHC563sKzRlTeSDhfqStq3HRv1aQBhdrbI8gEPVbdJToUV2+KCRX1J5ei90BB2GmL1Zl3SDN45LiMBwIjPbOjXCN+YeiOVHG0gNnRYMgRiQebbd/UEJgTFsHEhoeS3KMFusUG4x6XHif2FYb43e4nNdGyHr2eoMFq4NgeDdLtRfGA7G7xjbRBxv2dDKbzjpU8YKStQMA74UYKRI0XBgDEiQMnsHjUbJy1StuxRparnSSBo231APO8CpigeBWPz9MXGa0EyCu9uiSVOqrph8u99WMr3AbvSd3k0x6vsa1MXoalg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(2616005)(47076005)(26005)(16526019)(336012)(41300700001)(15650500001)(82740400003)(426003)(83380400001)(81166007)(36860700001)(6666004)(316002)(8936002)(7696005)(478600001)(8676002)(110136005)(5660300002)(70586007)(2906002)(6636002)(356005)(70206006)(4326008)(54906003)(44832011)(86362001)(40480700001)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:35:09.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0e3f35-e52b-4d0f-695b-08dc26cd0027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a50e70abdf19..e23a84f4a50a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -679,8 +679,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


