Return-Path: <linux-kernel+bounces-116646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67988A1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025E21F3BA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F2199E9D;
	Mon, 25 Mar 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tyn3X1m3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9C18E0CE;
	Mon, 25 Mar 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351927; cv=fail; b=kZx8I07Xj+B+CR/DJPW1u5ShnwM0/gp9qEYo5oQFLCPHCHtkOULF0GJeo4vY6nA7Ppn9FwlGk9Nv4b1fnAyW/JGHjVSQky+7CBbhmkbpEACjXMOOuQSoeLJ4UdUotTQIdN4hmnpDvbsQpfaS6k0x16xYPA9xF8yc2vrBcwJ2aAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351927; c=relaxed/simple;
	bh=Mes5BwtJFvqIwYbQhJ8iy32nOfVhJiIEexgH8dVBqNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkzWTcR9ruYkGFo1MSXqQg516153hZ4OFf0p+ZRs+VD84iD5Jw/ddPbHJ6BNzXjvGAF64FGppz+/0Kl2OTTjAAod+IbkLbhpiOQIQhZtVUnAh+7LCMRLBxSrEHCtn0DViUQxb1E1HWle++wr8dqjsTi99SE9V5jmNb9Rulx55rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tyn3X1m3; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX13RB3gGSrn5jVv4O9nPIumHeHmKyVdJwlq4wFqrXe6aPbM4LcovecDZ+aaZqCMKCgRpnKmdS0DHr9N9tcSHK+zn7s0kouuWtDLx+zu+VNxiApD3ghYdqmeRz9NYEh8Pss9SmJfqMRxjNiE0NkqauraZ05K4VQCR5VtK6z+i9lS2PyuihTrodqnNG9eE7/wMw5VNDKGc98+C3Fz2Cxz2P0xd5We9IDH+On7wQoQjVTJOKDycLfwQvYo/PlkG+dkRcNH/zP8YBTkIJLSaGv2abOtNIPg0+L9vFnQ1pCUAKyCkMcXvMDTs7+EsfeTiky/vdGfSci9NfM8BdUz/W7AgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLscRJG9cesDLsI+iXCDPMpBeHlnr7fCkaFqn3JmTCk=;
 b=h/g9NGqlYWezxt0sUC0gFP2gv4GeVe6sepIsg5EBLhqbvejwDsI805BSC5hMWDl+Yevb+Hid9PQ3QKWIiraj2HklzFuhmmkzTq8YJIzSTmCLihLzH0v9g/vYG4kSYGzTy540zbEpqDFbd4IEqP/6oIDPciCiXZbMSe0sYBBio5hJ1BViqC5vj9QcWMogV64fvfji/Kr43Xn2ISBnaaqA5/AnMvUqu9ibyPPwk/kJwXiQVV55nNyPjO0Vr5s+RK8ru11ErU7OHD7g14KAyHQJ1EaSP2S+0Wrlsbm1UYTgkHK4aZy4AaW+Jc3R413TH5TbUSFxYnK9sKeIJe2GEo0Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLscRJG9cesDLsI+iXCDPMpBeHlnr7fCkaFqn3JmTCk=;
 b=Tyn3X1m3Qmy6jtIY28Oxp1aZREJXQoFY1HJDKD+ZqlbDq54tTWVYLMtYPrXTe+uqXpnOuKi6KbPXSeKEe8mUR1WQXec7SXiN8TwSuiBZ7E45ok3BuGcqB0l1vgcY0JxKZyTI/Noy2P6WI9qum9ZaEnVGqFP/iQaZpqR91qTTQj4=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 07:31:59 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::40) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Mon, 25 Mar 2024 07:31:58 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:31:53 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v5 0/2] perf/x86/amd: Fix for LBR Freeze
Date: Mon, 25 Mar 2024 13:01:43 +0530
Message-ID: <cover.1711091584.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a6e41f-aa0b-4b2a-ada1-08dc4c9da7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oRczk6rROzFMur+RUp1kO+vFrdHx+YO1KxfnhqUWbqiqIffYUXJi5mXFClAcCUP1IoUFGRam1PQRFfYp3VaI6wKqqJbOjpGwZ8rPljNBvoAQDQhKG32lbTfRe8/gRKZlBX7yTAd0rTbkR5FVTXDL+EyxEH0oEHABklPhGVKJu1lw7GP9HmaRIvo1pATOmsns2eu6134tn8WnAhiv5JLnz9lQ62J+oepANhx9iDwOyi2uoHxLEMJZvPcYvApDu0W/arod6Av7WjWpNRtdg166vijnE7N3FqgyHoGkFioJ7wbK8EmqEqjcCAlVN/5g3VlUDRi2ugYAvqoDWOtlJBmXU67+aUkzWL3nsmqu0kDBrXghRpIRO4dKoEB3MZlnUqqMQTg7D1Pmb2lO3BLpFV9O6IVHr0qrs3rUx2k/soTdolUbL8Z+DKnHzDUOn0ZQMWItDSY13KVliZNJCqtaLw9L1ikAK0fIBDhD9/ptdLbdTZ69gyaXV8ZoXavNk+2h5X7VUosqOkGbHPKQzWckgclzHchom8tuSuR0hl8xNJD36SfnHYLJrSEYHu9GPou1pz8kUnTyXPBN28dtnoRsb+bpRLE9utlTlDdXMlKu5GPiW/gKbJaFbnM6nuRFEC896KHfoFA1c1THDfiKM5Tq3yiZ9K92iOlmifvj61n38oZ99OUcyzUzHRlLkGvHMO0gYKWUEVSq4s0kKwnce2U5j1uDrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:31:58.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6e41f-aa0b-4b2a-ada1-08dc4c9da7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204

Contains a fix for usage of LBR Freeze.

Previous versions can be found at:
v4: https://lore.kernel.org/all/cover.1710836172.git.sandipan.das@amd.com/
v3: https://lore.kernel.org/all/cover.1706526029.git.sandipan.das@amd.com/
v2: https://lore.kernel.org/all/cover.1704103399.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1702833179.git.sandipan.das@amd.com/

Changes in v5:
 - Restore previously moved scattered bits and instead create a new
   Linux-defined feature word for new scattered bits as suggested by
   Boris and Ingo.

Changes in v4:
 - Move scattered feature bits from CPUID 0x80000022[EAX] to a dedicated
   word as suggested by Ingo.
 - Remove patches that have been merged (patch 2 and 3 from v3).

Changes in v3:
 - As suggested by Boris, update the commit message of the first patch
   with the reason behind making the LBR and PMC Freeze feature bit
   visible in /proc/cpuinfo.

Changes in v2:
 - Make the LBR and PMC Freeze feature bit visible in /proc/cpuinfo. As
   suggested by Stephane, this will be useful to determine if it is
   feasible to perform kernel FDO on a system.

Sandipan Das (2):
  x86/cpufeatures: Add new word for scattered features
  perf/x86/amd/lbr: Use freeze based on availability

 arch/x86/events/amd/core.c               |  4 ++--
 arch/x86/events/amd/lbr.c                | 16 ++++++++++------
 arch/x86/include/asm/cpufeature.h        |  6 ++++--
 arch/x86/include/asm/cpufeatures.h       | 10 +++++++++-
 arch/x86/include/asm/disabled-features.h |  3 ++-
 arch/x86/include/asm/required-features.h |  3 ++-
 arch/x86/kernel/cpu/scattered.c          |  1 +
 7 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.34.1


