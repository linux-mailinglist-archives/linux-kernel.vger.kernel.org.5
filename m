Return-Path: <linux-kernel+bounces-107244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7E87F9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF761F21FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D377E59C;
	Tue, 19 Mar 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="epKWSJ0K"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E237C0A0;
	Tue, 19 Mar 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836974; cv=fail; b=hAYcFm2Q7gjqbfP4o6GE6yu1gO+GNP2QlETD+pZ7zyJKMrD35wyl7AzN70zqKHeLdk0dVCcdChwnvFYqfPhonep/g6UNftDMt1HxsDLlh3BhbSCIgo3sbKb/Ldm62riFA4+b9LrdLfzUqgNJxnnUO0HUSZQBMBp9qEbvVieLqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836974; c=relaxed/simple;
	bh=Y6JCqTTMV3cmGFiMhMqDQCHfMFBo5UzN/p46o1HKAZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJxhmYxmI+dzB3McoewyvK1cf15kcXVYlkGomJfWY9uNstgS+b6w+IHMe/oiiF+VDEuG+FBQ27fSdXni/xeOUKrksHsyypqn2HvACH4Pnds/fS1fpsVNi+QWhPpoRbkAW2W4uRGAgWMyWDPnwpvR9A6fhhZ9xOZQeuX8oH10ckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=epKWSJ0K; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9WENhxw5fiQ3/GUlIaCg2boDGAW0IIoYx3ZJVW5BmfkO/TpljYOSUAUqrcvajngXYuoCe0qRbl+jq7zckZZUIOOk0/GitmTkHV5pLFbfxhg5ZrYCQni5587YxG0e3QGeVMQjj2SnN7+iQFxWGSxsQymrbcFreZnM7coP3FNRgRXiI3rxDZySKVPDwgwSY74+rKMc8mnuEnNWGDBjZItqNEjmku8xevAzpLCiLWk7TavD9osh3Niyi2eisaesrLtwbSLcAPKWl9YAs9EzCJdDk0TC5B1CkDaWpk1Uq6gbQVwS4PWMRViXQ32HuSlxhkqlpdbo7IBLPKguYKRkWfXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rNaA2YmYsulj1aPiC8t+FJ7gtmnDsiG7h6C2nh31FM=;
 b=ic7NT+UP0iWBunMrtbv8bgWgTPXEq/VQxfEofE2vxGstynbR5BTOAYSsndhOQsUCtcZPDuVWDNvEHNyvGaZOh4LEQtrz0LSdMBemxLzhYe/D5wf0m1ohUQTA77I10mw/F+Kntbb0orkKcLAXQqw7XvQf6HuxJY9RoweqAbBNd0E6e59HNft4PFtrviosqKaxATF8fayn861Dj818DKhPbknyJfsu/b+4Mjds2q4ZJ737hpSJA67UNCm31OW7d8Mlh6FfXIw46HVZJ8SOsI0oJG+h6Mo9lnwdn4+Pa4fQRUqBKC44YJ3XpU7+4TKHIQKjBPalnmJVYOKdMEAuSKUZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rNaA2YmYsulj1aPiC8t+FJ7gtmnDsiG7h6C2nh31FM=;
 b=epKWSJ0KLvAB8eqqzaXZ4rlWVEAD+8xS8ZRGnR6Srqdf4XC46n4QxcCQSTY9bL5aZhhZNomMyXdx6vVObPfNIcpllIO4vn9uDiJZdMZ/IAxMqGFpc9PoCvSsN4tpfbbsZdXdCjDNjFPrpuKUoz+zI13m0/3pgjg1X+Dhh1oRE5A=
Received: from BYAPR06CA0030.namprd06.prod.outlook.com (2603:10b6:a03:d4::43)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:29:28 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::99) by BYAPR06CA0030.outlook.office365.com
 (2603:10b6:a03:d4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 7/8] cppc_acpi: print error message if CPPC is unsupported
Date: Tue, 19 Mar 2024 16:28:42 +0800
Message-ID: <46cab0894ffed593bf70d9800d0652e79c13f722.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d4546c-cd29-42e3-3da2-08dc47eeb131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VNc9kZN2dlfigl7ML6YUA2zU/tKfzhHvu01MK4ImEL5E5JT+Z4NaiaWAZwba/T/+V6lV7+ql1Tbt35BfH9CQomV9FjnFfTUN9PKpv8Dgpd5GjD8RXg7TF+TEWc+QG+vsjvUdEM2AX8tFiLsnBWJvrX6DRg1yKiZj4s/95AbqDoD8FlEnLvdRta65z1gLTYfsjJD6/jj0+N1gjwfLNsN85JBSSyEx2UdBPbyks/Aeu8QDOvnYjFAZ7YWNMhOq6cScxIkCZWXeT8OpZfSz+itFWS+ULeTGSqEf+F8co0rynzCnP/z/pO/EV+l/16oBjMydzIvqEczzRanyET1nORu6yYmYp/ujNPRV7efTCUB8T9/kho77xFL0ZdQebjm5ZLmghcgzyFEtZ4rVusIoAUJmewSmx7VfkMUYvrKZsqp90cWxPsfNF28FKDJhD5rge68bXHcYN+7vjourFK935z+4p5t60dP2HPZ1+zZHwF7qV4S3tcuWkof2JPZWqIT7Tezavd7flo9dpvyacMHZA4deMRhMD0LDqlqmLnSAEZu8wdxPd44qB6l/TpcjjV1e2aVXTYp9hjPQraaBBXJKEf6bIrtFYsihKmzKItSmRdMj99mur6fCtKoxonI/aG0Gnq/OtLrgG0+uXFa6PSMHX+d9r3O8/GFt9DNQX6RjcXj6SKv3JFtwzCXTKk6jDcH0uQk97451ZakJ7iJIY/2l5oZGG9kfYeHswLG2o9ZbLMIs0xvTm+b3Zf6EWl8aTaqqjZAO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:27.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d4546c-cd29-42e3-3da2-08dc47eeb131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

The amd-pstate driver can fail when _CPC objects are not supported by
the CPU. However, the current error message is ambiguous (see below) and
there is no clear way for attributing the failure of the amd-pstate
driver to the lack of CPPC support.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Fix this by adding an debug message to notify the user if the amd-pstate
driver failed to load due to CPPC not be supported by the CPU

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..3134101f31b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
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


