Return-Path: <linux-kernel+bounces-51406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C01848ADF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB231F22AA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE6A94F;
	Sun,  4 Feb 2024 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ZvMvRf9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A71BE65;
	Sun,  4 Feb 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017211; cv=fail; b=tHbJgX+BpvjbzSFypDczODERk+ho3jYF6paARwVNY1Zwg9KwhdSIrzFehJYKCgUYW+jH/SQGq8IglubSnOg0r4yLyM1STmX9HaISYHKHQl/LjNpcbaGexq/za6Hm91o9vLw6hCfoksb1JkZ3zEwhCSndh9ObGj+TqEofW/Mztm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017211; c=relaxed/simple;
	bh=/faDvRJteyXqZPRAcoZKXoQ2KPMAH3/GzFGupp3EFhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUsVqYVq5UfA3q3jc7Ai45JteruSYbEelXCduaairLnsBwPZP8Ubsdr7opvw1g1v6KIj1rmRw3vC7cJ7b1pqPYlsrzs5Dy9wTkrkDQmMHP81UsVqh2taUaPPHVTWgkJybn9+eNUfSZsI7mLylmbnOwVQ5cIMOGpP/GD5GG6JjvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ZvMvRf9; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQbHLX8705aHGr6o6JMjh7TvPOCYWkO0UzojxDct6X4mvo3AWyWAlN9JeZ20CCudWetaMAYaIdv7FWuH5dHuMEQCfNGqMS8SSzqgwXdhk4abgcwKqlKc+2pOflV2n/Y7/LNc6aEiejJibmI0XHmLSZGDxTCQG1SadI/MuIIYwAsabi1AiFq286DFgewaWj4FyhD5MmJj2u1dgK3QYCO/lFPdCW/4sQLGRGt8TH7g0aDFZq4s3JvEp9ACbB7CMD0wdndwpGfrMBqjuNKt0Lh4tL5sLpROHQR9VgYNgB8xcRLnvLyfWdfGq+2U94285+L7w8CJbThfgU4ui9ysOGi0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=QcSS5kL71XiVvvf9CSCzhzrpcbZtsVq1r8OPy4yD7fZYRDh8sUkQTmH1ivztwWY4iXMpqPTJwDdhrVszAyTr58x8i8/jrIaYx8Lcy+ycCr9NGeiqSLQO0GXEkRSBkN3DLqQ4vMuRwmxuhDalz8GfpxoSbUpn7x7XeTkdbfKowowRnyJpr2m6JJGjV4j+LWmweCQcbpzdqbHCeo91iFGLFv7DeBTgOB+sLRu0oFcTdisO1oWzzOZtUleXnP0LavRFrDIHfLreiRcsMx5w+KICba9mei70H+xd9ttLRMpWzKlWkLbIiaoyip3fna30uj5Ifpf8hbdbHnMYjZWN/VyFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy9SNyIn/2SjYTda9oDK5zWZekhmoOyMuf9jAWZS5R8=;
 b=2ZvMvRf9OELDMF4gSa59R1rChlOTbPmgs8xVEErgCyld/33FlLbQLQ7r+fXPvtfOmpQ5LyhMOhVGjyvg6RGRSuy/WWnrUAP0w/RUYed7BPYt2IINSUz6CYDrI1IYVsk8zlVZvODvPsD18k2lEA3hZxSkpNIrOGjYveU8QPpTziA=
Received: from CYZPR17CA0009.namprd17.prod.outlook.com (2603:10b6:930:8c::28)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 03:26:46 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::66) by CYZPR17CA0009.outlook.office365.com
 (2603:10b6:930:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.32 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 4 Feb 2024 03:26:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:42 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Sun, 4 Feb 2024 11:26:13 +0800
Message-ID: <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3d6dd2-6ff9-419c-6e02-08dc25311d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HmsCnkp5N6mF4DruJjGvYpVHlRa+fzDD67KCdB6XdiraZfzyJUNuaecLRZJqC217RZb2dn3nIiKyNUGRdqnZRmz3IkxpUv97tkIPFiA7llDC4lgYxhF3lWJEt2AmVLUYvwvibJR8X1KSK2CWAM6h/tEDycv26am46LrP7OLN/PcMVbg+vkGfEHSFVcHuEcJoD20qX+U81Xt+6wZj8xnSkWAqi9vY6GhZz1bkybzZ+lL8roU+AIQaTQvTbtHiWP1ooelD405mdtuxgZeCAfXDsFQdULUjP6DbY0myNWwfMK20cWsltdmKqb/fDKAzOmawG+VipHPwVh+vTlzFQuPqXJXko/aTSxDJjG6lqyC9JjaZhtIJ1R+MV40W5QTgxR/29Evi5JJFchNgPbHMVQWIyRLrdxZ4oYjsFu6DCrM8KEWavySCBa9vfpb3MsCjrvVt/e2GKluz4THkx5MCmPodof4e3yuciSG8smB3LYbCngT0e4PTjnV1qf7o/pxDx5U+ZS8W+GD6JTnhyhHs/pTIpwhTpXh39pWQ55X7vY0rOoFTfxI3c1uad+DbM6MUoLp1F6GP7DrjruX2ORZEzzwN1wZUqhKdwH+vT8IzZq2Z+yLj8wG5jvrTK3pbk+o/UDycxyQl4v+QyJnOfVYfMVyijYGeLipEr+tbhl1EzScUQPPMmkPw4KRCkRPdR3a+d5FTfGgD39M5cZaoGhVa96aTdLkd/eQU9ptn+kB+MjPSsAlMFgaMa7k2IpD7Syu0F4Q
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40480700001)(16526019)(2616005)(41300700001)(86362001)(36860700001)(36756003)(478600001)(7696005)(6666004)(26005)(47076005)(83380400001)(426003)(336012)(82740400003)(356005)(81166007)(54906003)(6636002)(2906002)(15650500001)(5660300002)(316002)(110136005)(4326008)(8676002)(8936002)(44832011)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:45.5813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3d6dd2-6ff9-419c-6e02-08dc25311d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

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


