Return-Path: <linux-kernel+bounces-14072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A3B821793
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE31B21448
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88F15D5;
	Tue,  2 Jan 2024 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9A/j9Gz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A615C5;
	Tue,  2 Jan 2024 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcLmK6g4/TINLZrBaV73TzeOexHq0EyWUiXchE7hE4e1YOyaM6zor3XlkNwfuyjSsc5fWisLWHk4frqnQ0zWBdnisdEAMMMt97qzvS3xOXYuxI9WQ4qHMSN6jOK6fyoHHcwnFBGEa/2W9kum/tM1Cq6RG7/A0BBBg6kQGYfqP94DRmdVMH8CVyO1K5ygZ17ZSQkopJNV7NrehxPLKqO98eX/txlzFe1y9Nmn+GBrqywRQ1pm+ZKByzvUCvrO0qMqX3jT45JpLC7xyH2HhVnBeDXHHMxGbh4Tk8bmcGM9cJU+PNbopSw0a5ULjjQOCpjTDteWVOW1X8DliMUjWHpvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPMy8QQOvVtzv+5yS5UcoCje3KI+shnpnly5qLELA8w=;
 b=DJAxZBmGHrdF8jG8sezkXAxwpL6H7Tq8S0iy/hVcVUqDD626VTGDxlBuAVcf+TPzM5lc9CNZG/8LUH4qjnKp7kHjvWkyELwEPGVhjCWnwet4mp/5+n20NyyMsb+ImOK2JBAGKb76llPuXEulVRKod7bn+j1U+i2QBZwQvPbHiGUksPoM0XBC7G/KAq/vSpzJFGvSDAg8AykFDigUeFxXAiXSGqEsEg29ilqhPtos1Pv07yWxOOfqmBXJo1k5VMYD/TL+MlWBzY09bvo6Ko93DInKoeKG0ZlavpUetelE023f+seSfmrx9KpbDVH/KxQdd24J+i4hj6U5sJDmA31hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPMy8QQOvVtzv+5yS5UcoCje3KI+shnpnly5qLELA8w=;
 b=J9A/j9GzD52ZQguzBvp/cHlliiV1CDOwH0/iFwnKYQl2AvUTx/qIzPESfqaiXBpaBJFiwqsGZVklBRBuk7ts2wznnzo7L3btTGpJ6KiXKN5dQnY5eOmHXKLbCW+Hd7Sfjz+w9UBANDxlfQlPq7c9scXbDjO6VgEaJEPXC7qtIzw=
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:04:55 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::fa) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 06:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.1 via Frontend Transport; Tue, 2 Jan 2024 06:04:54 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:04:18 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 3/3] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Tue, 2 Jan 2024 11:31:30 +0530
Message-ID: <69e89600fe5ebb2d4e870d1bb7f1ac6d7954d259.1704103399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704103399.git.sandipan.das@amd.com>
References: <cover.1704103399.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7f9fd0-e90a-433c-97cd-08dc0b58bde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DUyk4QnJUKDC4BKNUPnwhcuVBLwAd5vFG5ncnDFjSPW6VBwFABNLYrucqECsGCazt55KTjkKH1wWT9cHnVr2iyKeKjuSruL40MTZ4eoStOve+YWPFaz6XBpuiGVUzVio+/oyJbfhHmknJMufncXBdVQSlOuWjEnfmATB+q4otnpZhbl5i5OQOlGM+/Xx8g0r5nniG7Rh7Ly958DY7RiE6eFHFYcmIBcH9lzYeoHjhr26Xacw8yTOy4iN7MIcvXAseF3uc7tXfOQcPF+YLf82tMb7xrxPB+KA6UBblpprg8f7T3mepJGobxuiZTV1JmmtmJ2a5bvKeOZyeIKTjzyO21MiVztyF5DxAJ1vOpKlTrgEG5JTYgwyfM3usMEvNYPpsdaBZ2PL5lmC7MbnEpife9qDcMe9GlvKdccyDshu9Ym3h2RL0WNIT5HelizMXW3jOBu2GQxFAvYLoBqwFvoOMoTyzkfCT0kUxbzK6ubyqWE0T5T6ENjjt4WnQsXFdMDsqWLSUfNKEpTS2B4ZMLetR6LY2yYK4cJp7cSFDXwn3xBQCmWW/HWfoV+HG92QcfVNevFKaS73550tfOk9K0OsmzfVNr5zZl2quEIg7oV+PgVvFUKhRoWfj5eTX3svXNeKPT47OcWKzRJxZPu5oAVG1zxMuPR0ERUERHMeo1bKxdG+mCCgX83AYKKJ6NA7725AtJwpQ1sfiUi42eWJzDIJhjaNbYkYRiT7IQVGl4iho3AjoQ1PZ07Amd8eO2LbdCPEOQjiJOFh0zCht4jna4CXtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(2906002)(7416002)(44832011)(5660300002)(8676002)(4326008)(316002)(110136005)(54906003)(70586007)(70206006)(8936002)(36756003)(82740400003)(81166007)(356005)(478600001)(966005)(7696005)(86362001)(6666004)(47076005)(36860700001)(336012)(426003)(26005)(2616005)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:04:54.9526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f9fd0-e90a-433c-97cd-08dc0b58bde8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Link: https://lore.kernel.org/all/20231026170330.4657-3-mario.limonciello@amd.com/
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ffdfaee08b08..63514c311f44 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
-- 
2.34.1


