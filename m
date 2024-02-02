Return-Path: <linux-kernel+bounces-49515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B694846B59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09AF1C29F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8360881;
	Fri,  2 Feb 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LydtJng0"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E465FF0B;
	Fri,  2 Feb 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864179; cv=fail; b=YtWWEKbM7qO3Ydvxy8brqjWGbeqw5Q7BrWShnL8cuuZAHoDJ5D2+OoBjZ2YpoW61mKWI7F7EAZhsdZUwq0SI1uEDNpfrTnhTzFOzmULJi5Ru3v6UNtAD5Dr+2swy7tF/nGlmuC+5edgJP2xWEXdYz+U1qCRKRkg/lvexhAsM/6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864179; c=relaxed/simple;
	bh=JKdj0RPJy/6N5IVDDqCaH5iwCjEHIj7iTr2NbAgvlAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXwkudw5wHs1qB1WbnTqsb3KGQlv9tCcYa8xfz5/3VH+XCrM4UjLt7QyPtQwRgyrFpcto+FF6m053aWMQabSXvarfcgD0+jQHS0itNuD2Be3dO2UiJvfCugMFTO154wlnib/JdWNkSw18oBqwzmIqYK+iUDpE0+s/LZYHYLSKPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LydtJng0; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd/O0+cbexwu2L9XFwsIAwy2aXzGc4L3kVfymOPVpqhyhn8pl42djUwwxQ/k7HvocIqy8kouE8kCXsn3RZ9+OYobmenlAlwTOqj9Hk6pmXbK+MAMit+KpD9wYmy/cOvQQ761ttjlx4gOez+BNJ3l77n+Ho6tv2204U8IOM+IpQ03wIImku3voVr2RvKBzcFc6AhrJqlvcIDYaWhvb3GOdP7LHKHW5o3edlOjRps+irTagr8zhTpEAD4iSZTMk+V6Es18czpuvxek4DogM4RhXyr4HtVcFk5h/rDXnp7iDaORjZVQ1fCJMDq1E76DjIATmVHGE6Qosb9V7GrEfTFbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5DQuVPGL31ixJ6Ql4gW7mts19jCht6bYp93W0AIIXM=;
 b=kWImzuoMRzyCo9X/h6MlLgaaJvPPszqKrnhCL78b0qikhI0AL4srDf1rCp2NZOtzZGzWUwfqpLBAth25L6CzCNfc0GRnZ6U8eu47TiUmb0S3pmCbw08H1/Qk+Pt2crb71q4uE8ZhWmI51bKuA2PQn1R2Et9bxOlI+kPkcmZ+TmYuPMjQ3YNet+hcixfaVoWC7hcqRBPrGkgJHu3CEyAxpmWyuoM56OvNah+D/cno+dBtKaO19v15XVSdP2utkJtEyMnNFMUNfATlryDaitexs9oEWP4Wfyy/LW51IZLwg/9dd/0ua8W5xFFmvInVM/eyaoR3tiVys8mMpunY8XAwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5DQuVPGL31ixJ6Ql4gW7mts19jCht6bYp93W0AIIXM=;
 b=LydtJng0CTsXu2z0dNax+lZD7XQAVUfig+p9xeuyTghaZCBgv2zh93ytKbQBa7/eSGMN0JelPAmwRIQqswPDYwA8H67ZsE88Np/0ZG/8mdndPlWCVhE27Oi6iPxXTE2xa6/rbcBRI0TlNkvCDgerV8JibbB27d38q5ZbvXiiUSA=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Fri, 2 Feb
 2024 08:56:14 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::72) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:13 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:10 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] AMD Pstate Fixes And Enhancements
Date: Fri, 2 Feb 2024 16:55:32 +0800
Message-ID: <cover.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 677fe42a-0b35-49ca-0ffb-08dc23cccf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+VDIpkV4ejA28V7mCNYBtrKhZfuKoLFMj5YHQyDiCWEfxiJ4J6bjyNZX99W7437rKHS/lceboH7eBVVTmgPZ4eQvP8DMGDHBZvRsp9eyKHGhJjzggb/NUEOce935zODjSpIhQ0F6NUh7bTO7PREuro+f90WnvC6mdR/dxfGIdCdu8KUDi6kjRr5K8aTk3UeBLU1wgrn2vbzVgsvBrh18TF17iadTxJUipW+UiP6lWF+5LtXeZDd1xrNowNnCyCS4JLTDaNhxJpBFcEb0/blAWwoI5+CuTSjrhn+v4mytU1vucQOoL6V+jxooPoj0oMGZAjZ7PEuSLZSQO32QI+6eWAjqa32Sdky2ek/pSROvM5zkQ2Qz46XVfZDUZbxIpBdVWyWtdeQOtOkyVayWODg/zs6ZWW4RbHFLo77oEHWbfKB7TKMKEmctpNnpiD3DKGKTqfZidzvFHRd3rotGjig7ezFmJufu04eloWqV0l3hiBNQzi9ssc9Ew2IG6e9hvtmJs7l+rGaGIwDkyCfO1Hgy1K0i2xOn0XX/H5Lbjf6AvSH2bkQgv8awSL9QqhsUCtJbk0mvzl8sRFNf9lQhwcrO0kSVFhE39oBFdxMFZeNQW6zcVNXAcQbtn07JYH71SBmkbjU6107Dsyxsv3sh6wLSScyNez05C1ZA42ZAoq34hyfaqvRMDprPI/T9W3k4X2/D6l0/LArrb3GlA5RUqYXOQzrQGTfxxrhXcct65/FBcmzkw7O58GO95bwRYiewx/g
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(16526019)(26005)(83380400001)(70206006)(426003)(70586007)(966005)(336012)(2906002)(7696005)(8676002)(54906003)(4326008)(8936002)(110136005)(316002)(6636002)(44832011)(2616005)(6666004)(36860700001)(5660300002)(356005)(82740400003)(81166007)(86362001)(36756003)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:13.9792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677fe42a-0b35-49ca-0ffb-08dc23cccf79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

The patch series adds some fixes and enhancements to the AMD pstate
driver.
It enables CPPC v2 for certain processors in the family 17H, as
requested
by TR40 processor users who expect improved performance and lower system
temperature. 

Additionally, it fixes the initialization of nominal_freq for each
cpudata
and changes latency and delay values to be read from platform firmware
firstly
for more accurate timing. 

A new quirk is also added for legacy processors that lack CPPC
capabilities which caused the pstate driver to fail loading. 

I would greatly appreciate any feedbacks.

Thank you!


Changes from v1:
 * pick up the RB flags from Mario
 * address review comment of patch #6 for amd_get_nominal_freq()
 * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
 * update debug log for patch #5 as Mario suggested.
 * fix some typos and format problems
 * tested on 7950X platform


V1: https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org/

Perry Yuan (6):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
  cpufreq:amd-pstate: fix the nominal freq value set
  cpufreq:amd-pstate: initialize nominal_freq of each cpudata
  cpufreq:amd-pstate: get pstate transition delay and latency value from
    ACPI tables
  cppc_acpi: print error message if CPPC is unsupported
  cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing

 arch/x86/kernel/acpi/cppc.c  |   2 +-
 drivers/acpi/cppc_acpi.c     |   4 +-
 drivers/cpufreq/amd-pstate.c | 108 +++++++++++++++++++++++++++++------
 include/linux/amd-pstate.h   |   6 ++
 4 files changed, 101 insertions(+), 19 deletions(-)

-- 
2.34.1


