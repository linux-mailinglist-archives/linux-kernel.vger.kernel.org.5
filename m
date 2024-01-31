Return-Path: <linux-kernel+bounces-46060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BC8439E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4517228E6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F535627E2;
	Wed, 31 Jan 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zNJpONKb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5E4204B;
	Wed, 31 Jan 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691042; cv=fail; b=sGUQ+SL9AxAg7JsjtocVN7y0sqsd6OXGV4v+GKYnbZOg3AlT1o+I5Qbugc2IshH7hpEHLidHYe3UKvAn1v2R0CA4qm8EmNnc+/xkO6HjfzdAY600uI1j/8IDqlOuJVo5PErqwzVcRTXg5mIx+A+k3sm9lHiPIaEWonlt2sWmx68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691042; c=relaxed/simple;
	bh=47bmkUd05L2fvMc60yNEXSm/t4/z0xaYx7bf+7D7mU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+ORIw/N8yGs1/gOgqKpRxMSRkIiLHZeN+3zLHFF/D6eMGIdAO0rmC8uStitA8qoB+f+0m1v8Moh0Tr3HEjK8JB9fCL2zN9BA/Qkihq2SCwGL2n23LEK25+vxVYtwHd1A0aMMnvFJhDXVfUpr4pBwuxyNazO1juCv1mIqbZxPKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zNJpONKb; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHkVnNqD4WF8qSm4xwRN0blcGaexr/X3E1ixaxd4PXHUZY09xh+sahyQSxH/bnHjUv+2uTnI4k6WLA8juV2uhJNRB1lGKvLx+aP5nZoBFIJQlB3I0d9nryqonxhewzi9tXLmZSe3P0lqCOJmrGRXXa+/IfGrNlmjwZHno1kNhyr+XsRrnwHIQXn8MkkLztoqTF8o//0Iaoj15AfKKiGOSN+gbWohKr5r7Fga1RTIdvABUtaswdNUXC0jrKTtXtZRTTrfPIQgx4f+hEjNNVvkzG7yEa6sN09QbGzS9O1YC84hMxZhnsZaT277lfF/fzu5D/Z4bICfhoKszvCLcQfp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkNCRbyiz1pbLO5c0nCyf7uLgZu/3YvIGzBTEIr3CC4=;
 b=JZ9NSJXO0FRzowmE4apmIudCcD/8r9cXy/eiPLAGVOARzekfbclQIPtRv2A/nt9+hEOh5EOG4RIoprB03KrWNmFrOSznsgUflV2qWzRcRgMdr4uDKhEAPbfTWOEh5BIzmfbrHh+wHcwA4Om5q5erkjFMugA21mqPtzf9hUJJlPaJyhnU+5mJSM3ykATqLBJQ8r/XJYbFQwdhJc++YLgurq9GieplhHYSQpkqey5926Xo391g0rC6F0MTUGULoAPioT1zjsJj6GQMeKvUWAb96nScnSi9rkqENbT/aRuGyZJcEeYR4YJI0gCNA8NUhEbmy9XZPAWjAYBom8NiOdUFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkNCRbyiz1pbLO5c0nCyf7uLgZu/3YvIGzBTEIr3CC4=;
 b=zNJpONKb8QqJdYNvVqsLVGGeKfZpS9lFtvSBaN4JWkdYqVkBTRAdBroL7nFje/HExwTxNOLZQCJPXwg2vOQtMoOUi9uuz7j8i5fL4z7SN9glGpGbmosg6sn1siDVfqxAtJ/uE1bNF50bGHQgWSv5XzG7TADcS6MrBSf4eV3M0U0=
Received: from CY5PR15CA0088.namprd15.prod.outlook.com (2603:10b6:930:18::29)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 08:50:36 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com (2603:10b6:930:18::4)
 by CY5PR15CA0088.outlook.office365.com (2603:10b6:930:18::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22 via Frontend Transport; Wed, 31 Jan 2024 08:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 31 Jan 2024 08:50:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:50:33 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] AMD Pstate Fixes And Enhancements
Date: Wed, 31 Jan 2024 16:50:15 +0800
Message-ID: <cover.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 977e7313-c533-4e7e-5af9-08dc2239b1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JmSlfwPUvtykcHXBOcIg8H6swxylxsv+k62QntWSzMxzAIa+Tjc/iv8el2AebQA66p+Clt3rngit02mNWxiiUmPmaE/2VQoBXFkdTCSjbV5fX58JVrV0mF3W77sOdBA1tHwNVIK6W5UGCVBv/oLgj7ADicKLcSDmRQrIst7zTGhtBjXzS0Assx8xpf3seO7iM/eugzXzrvfAYxWx7grT1tw6dO3AiTj8JGm8JP11Z/mXhpS3h4LKOsWBrM7VY1MISs9Lc/8mQWIze2pYk+XvUiMbij7EVEfVV/JpOh5+6c3UZ3cUg5ze4/qPdSjFey53gX/bmyKEKvbVWlhKndE5Ze3qf5uviBXw4D+ysBdxZKJ41ylw5mZEkRpDrXXiXVlMJWax3jcV5ExnO0v/u6HDlnrH+wR/79KQpjJN4EsOsaInrYMmbTg0ycts8bk3pN98KxqXQ2nJWG9OYkvMGMJ39jUeeEZwMnzaOc87uzNMwEeCCKTxdKLttcMZpkgOtsVh8QicfMjBz0gG2O+mHD2d2jfGZwHjn792rjBpk2B5+ML0RO966et9pgj0X8c/zdVwlEpYYNPJ06aVm6SFT95HsOaiPwbpgG9XyPq+hMH10fgL9PIqEZjxszn8k1GrlQ9IJWl89kJXCzGFbUHR3aoXH/WiocO464l7eGkEyuW6cBCoglbOp3q4SZ/H4n0mFVd3t5NnYpOi4SIm2KtADyQmRAb7FR08MhKqvMURXIH6+DHtGYLadGDKjhBrF3SEd+Ni2gJqZO35K/KnsA+2UELnuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(426003)(16526019)(26005)(5660300002)(336012)(478600001)(70586007)(70206006)(83380400001)(2906002)(4326008)(7696005)(6666004)(110136005)(316002)(6636002)(54906003)(8676002)(8936002)(2616005)(44832011)(36860700001)(356005)(81166007)(82740400003)(47076005)(86362001)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:50:36.8107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977e7313-c533-4e7e-5af9-08dc2239b1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

The patch series adds some fixes and enhancements to the AMD pstate driver.
It enables CPPC v2 for certain processors in the family 17H, as requested
by TR40 processor users who expect improved performance and lower system
temperature. 

Additionally, it fixes the initialization of nominal_freq for each cpudata
and changes latency and delay values to be read from platform firmware firstly
for more accurate timing. 

A new quirk is also added for legacy processors that lack CPPC capabilities,
which caused the pstate driver to fail loading. 

I would greatly appreciate any feedbacks.

Thank you!


Perry Yuan (6):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
  cpufreq:amd-pstate: fix the nominal freq value set
  cpufreq:amd-pstate: initialize nominal_freq of each cpudata
  cpufreq:amd-pstate: get pstate transition delay and latency value from
    ACPI tables
  cppc_acpi: print error message if CPPC is unsupported
  cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing

 arch/x86/kernel/acpi/cppc.c  |   2 +-
 drivers/acpi/cppc_acpi.c     |   6 +-
 drivers/cpufreq/amd-pstate.c | 112 ++++++++++++++++++++++++++++-------
 include/linux/amd-pstate.h   |   6 ++
 4 files changed, 102 insertions(+), 24 deletions(-)

-- 
2.34.1


