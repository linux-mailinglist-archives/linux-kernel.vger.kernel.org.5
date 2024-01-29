Return-Path: <linux-kernel+bounces-42585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D603E84037B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518A9B2300C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18AC5B5CD;
	Mon, 29 Jan 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNEMBc1Y"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41185B20F;
	Mon, 29 Jan 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526405; cv=fail; b=oQE0k1tKJgRjbWOxQGKvHa+wmAt+ohpHUjPJ9LRPkRjGZ2hSIvZi68PzV0cGuUIiIaRg3p+6AbN819jlAX1nnwHwtFTXmXJ5fiTS9X+QcYB1IpgPo3AQKEBsDcUDtA/eefZGCftO4JN8DGahllFMM7ijZYLJmHGzKXI4F8HI4J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526405; c=relaxed/simple;
	bh=cpOVrc9/MOdrbbpJOB4L6QJLF1b077f9hPEqEjZFW2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqlVhV/c6rEnS3BDgICqPuY9afpek0hlxU9LowuXHN0XkcTa2FhujmTGtQA9fbJhHy9yA/4r/Mjgj0mAy3CMWYmnSbD8HcrRXQdX0nLl6hFkBhh/a657tHdwPDQJrO0GlfUjbnQw32ifohmVXKEVBYgb5+sUlL9dnC4++cJEOkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNEMBc1Y; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j99hY19GXgs1cw+A/Fl/sgvQ3ZoYKoJQ/95KndVe7lXVPHM+BHMOQ71Z7ZvxyT3QlT9j6DsOpjAmDFfvSWHFTquUdy2A959p2oNLDcWKpVVLJ3yVYjrybUd9tEoNTA21kDaFYvVz8qtU+eWSDezCTFhnYxrCXOhnGG8L9wyExCinzUjzxRHe9XiMtMYnBZpWp6uyVPN9LIcyuNVgDyTWvqUGh+yF+KM/e2JrnGMpU186lslNTmRl2UEyIn+4ZYh1FrQ4BAQomr5YK0MVjrFH6uee9ulA0o2AIDZOQnEtGJFkPSZ7CoRsb9iCkD4bi2ZViKAKMak35mUswnFT0tieIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP9ieVX1UQvN4X57w19jA4iL9iEmQEJ7qkwoCo4wLis=;
 b=MQc47D5yvvzuIoJ1mukOm8xIng4pwHc+BwIF3NduwkkfYGmAkZR98UEoJJcN7tqrYQGaVoZl04EhFCqn5g8bPIf0UZsDEzjPsGUr3KAm37lFnByhlOOijRYAOseVRYrW3O6eyiD33m4JQKYHFzjAz5A/IysuEkY6gQ4zuHAkqhjVxLs93KQ8X89Zet4JRdfc21mKcVQA/S5ACK6CWc1pmvVLnJkcypNFmi0Jup0Z7gOY7Fg6WlyInfsoCdBoM64o0Wdp4f3sorK65aFHymQqgoyOLC4PaIluyTrNPgIokeCfUAXRb5mbJoPekusoyl7uKqsybtISSz8sJpV3xMvpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP9ieVX1UQvN4X57w19jA4iL9iEmQEJ7qkwoCo4wLis=;
 b=TNEMBc1YAoBdRxbakfy1ZuUAMCICaAvLHQOLF4bbAytiG390T5jidpvclcNxR7BycMlqxufBS3dlUHRw45herEDB5a4e5xWOjDxRNdRIT87LjYrrmoRWNzMnC/n5+bUz/Y3uzK3XHljKRVYgJRzlVOr9tegfyaW6g3oW4PxNA8s=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 11:06:39 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::5a) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Mon, 29 Jan 2024 11:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Mon, 29 Jan 2024 11:06:39 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 05:06:33 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 0/3] perf/x86/amd: Miscellaneous fixes
Date: Mon, 29 Jan 2024 16:36:23 +0530
Message-ID: <cover.1706526029.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: aca20f6a-97eb-458e-c9fc-08dc20ba5df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YY2ocIT/h3NoTqlrOUaWyxXPddf3Fld8OFMzcCNTbPTpoCFJ/WO4xuxSk5jmUYx3wnJB6fZgC/4O9hceeP6nCM0mpxHdyX4koUWyBKKiFZEOLre9JPm83ruTSVZ1T2n2MhUl2/IZ5/9CgwqnxZYMZDabl0zSYQYW4RuCcqSTGErC381FCmNQTcqfoc3Ph+hGAgKvvvlEkFAPP6uA5Rrs7BJ0h9KTwqng5t1m7y810mEaaCpjq5gGPNBif4cHFvCnK92dVCr7RAtX6NPOFwcYh3n6CnwWTQ8YY9/joeA+CACTl5GjXyKIueXW8UFWP6MbFkPQsLLdWJ3hMi17QIJdva/vAoTFs6lPQQ4kc+P7hlLqycHzKH6kgNsxSLsssL6H42pLgreq4qA8pzvQcHRZ+0omb5kT8dmoZaQc5e1hvnfk1o5Im9xLtoNLdmt41wRMSK1ts9EmYdg9VXLsudKGYuThQEC0Z6G0EXC45W7Zpb/L3n03ureOA324i4++Zm8gcX2GUOXaG5yDUcu/4yy0mTWbdEkds/3a4UhY2mKEwHgi9OUVXvjz6SERdHyfKqppE9Ab5q/R8LnZuJuP7tJnw2o2zsdVAbu+wT4deClmgEjCR+gkqREMjhHatHaGksbimI4Jx9YcT9SdbNnh50h5dhLq1xPtrr3a2rJTE0OxobQAWISrWmRIkPVW7f3NO/lkIxu22DXG2QiyUIjQtA9mAZzJhPqzEnzqILw0q+6XksySsNflQoaCnvt13eI5loDOIasshKM+yHfIp2TIncXe3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(426003)(336012)(26005)(16526019)(83380400001)(6666004)(2616005)(36860700001)(47076005)(5660300002)(44832011)(7416002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(966005)(316002)(54906003)(110136005)(70586007)(70206006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:06:39.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca20f6a-97eb-458e-c9fc-08dc20ba5df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

Contains fixes w.r.t usage of LBR Freeze, Erratum 1452 and a bug in the
CPU offline path where PMU-related registers are reset.

Previous versions can be found at:
v2: https://lore.kernel.org/all/cover.1704103399.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1702833179.git.sandipan.das@amd.com/

Changes in v3:
 - As suggested by Boris, update the commit message of the first patch
   with the reason behind making the LBR and PMC Freeze feature bit
   visible in /proc/cpuinfo.

Changes in v2:
 - Make the LBR and PMC Freeze feature bit visible in /proc/cpuinfo. As
   suggested by Stephane, this will be useful to determine if it is
   feasible to perform kernel FDO on a system.

Sandipan Das (3):
  perf/x86/amd/lbr: Use freeze based on availability
  perf/x86/amd/lbr: Discard erroneous branch entries
  perf/x86/amd/core: Avoid register reset when CPU is dead

 arch/x86/events/amd/core.c         |  5 ++---
 arch/x86/events/amd/lbr.c          | 22 ++++++++++++++--------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.34.1


