Return-Path: <linux-kernel+bounces-70221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1308594FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1292D283193
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4EEAD6;
	Sun, 18 Feb 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vxcNhQgq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A85695;
	Sun, 18 Feb 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237629; cv=fail; b=UWGtqDKfohN1txPyDeIFPrRJDuePe2VHtMZfDC444Lnt9nVJ28fR679v2JKL0En7zSshQESHcp2HZIJ7QQOFxpkdY7U3gpbcC38dG2Ng/1Aecdtfrvb1MUqScAdg9vXYgvU2z7HSqwpmekiw/hEgySzv7lmRPQE0VSvIiFgQves=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237629; c=relaxed/simple;
	bh=H4+ZoD63JkPYTQJVGxgkAjZIm2YJ9H8NV5n48wp2+5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3uf3x0oTVbQup+luyg9ek8mOTPwbJxyK0hlfZBR1/YjeDlen3a43q0K0npSl+2q5ParKyoTmcjIZmrdSb9O20OFfoojJSuR1GVaLCk6tcg3OThyzQkBnUyofE9LdC59kyhzZBGGrExo6/GzZ228vPlNFdsgt6f/5dOhrDP9QXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vxcNhQgq; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmxozUYw7Cme1+nCAIcVnp9ysSE8QiV09LhLdnwVboGg8eBq4nOsAu3aqdO/i0cHrI0+RzKpoiufILNSIJ7tXRo21s1gl1W4XHTeJlOk0i/w5PM84+oULMQsMabRmtdhAVfFdTpX9mah4Q9cwylWUiO4wKYTLRR7F5MUeBGjcT1eKOWwIQgjV4DpBcwx36o1b7YRd30aElL5//cgoqp3Endp01GmP5y8zQyFRnHNAnELBMHIteUDoj58M4xafe30nHpLf5JrMwIbU9gLJO0Z3IWzdN3230UMDMl5iBjRFmC4A2jqJWxjEhr99/YR+ZUebNnADckOuCS5axVz0pQj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0CJ7+t5MSUlyWpfVe/hoGkweoM76/+OdtdTGyomBd0=;
 b=HpsthudAW6gHUXDsVzyenTAWu+6owqAIKBhNlBalr0bVyD0pT6ShUSh6t9KR7Gg1R4TzrKEZz/K4DrM9M6pY1Og9i5CEDzVz1LlkQxaQOcBWbCvTDFaBJ92Q2s8ffDcYeTq5VmSQCggWboN7JpqINBP0VEVi1gLjZrz4fyValmZNWAH1HKx0SshDhWnRYA6Islp5EoN23ynH4W/yhuU604Ukys+usCZ4wklOGGXWuhgWUConKocu9IfbDgvlZVFnG76kV5uAlOr6TmbvxUC2PZg/GAwiTNjcmXTB2IjBJeBnopaAxh3pGGghc2Kbke1bUi8VM9FdFs60Sb/4vcLvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0CJ7+t5MSUlyWpfVe/hoGkweoM76/+OdtdTGyomBd0=;
 b=vxcNhQgqRxKY3U6g6LDWemyyy7/KORzRsToQesLGLRxbPLiMJ9K/YBC2J6bXtCf/KvTWbObnGq+wzVkaPtzT9SuJfAHCS+OdVezweIO79DHd58XAuYT6b22CLV89kgZp4sGEJ7MMQkZ6T6mff1G0HJJgzj6C1MsVTdgT4GVYHw8=
Received: from CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::24)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Sun, 18 Feb
 2024 06:27:03 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::e3) by CH5P222CA0003.outlook.office365.com
 (2603:10b6:610:1ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 06:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 06:27:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 00:27:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()
Date: Fri, 16 Feb 2024 19:22:05 -0600
Message-ID: <20240217012205.113614-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217012205.113614-1-mario.limonciello@amd.com>
References: <20240217012205.113614-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1f66ef-e3b3-4612-fdfd-08dc304a9ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JOg5Ym1ZX8Ki3czF9hs8zOgJAX00QJkOwHcDOVGO0nbM1xfYWdQS3UBLt0Z2rFwpcygV+CBHx9M9mv+KfcPufr1Ild9s7HFOCi8lzdO1JKGxvXz+A6ZUmwilJ7WPkMhA6NA1danh119K3PLcMPuD4hdyWwktd5o7BH1A5TMq4aTawgafRhFCRKrLVGR+vb/2e5fwIVuDmt+bXdZCInm49AujmqcfexzM4BtBC2b66zqAZW1UtuLCULgSYhBrDKDukYwf0JkskMo5UUROqwQLqoRzZ0Gfq+afjYRqeS2Rc3+9l5+DaI+kQ9n2m+5d9pGm/uW9VFDHFMztsHMzhMnXN/b6X+gT+zQwOaQ5/2YJZbFeElLQNG6/I0EZrLHFlXsjToyuX79a7vzQpKYc4KPgGgvQ38V3JFYcIz0Vh2L8aLP6kPioq5BjP0NO1HQhKBjzitdp4C0CTR8oexKwXCPFnKWqhbLYcr0p6m89MNLhMmVYL5uAabDqDigMumajjpTsPByDsZfDRXihllRv7JIPuQA3GAUxvgMNCnTLJUVqnr/VPX1USUusD8it/6sKk9sm2fvNtDmBi0itET604WK/Dz4OLuljsgFKXoOuXyp7QKR1vOiDJXmkU6KyX7w7e1ECshVMeBM2eTJMBZgsabdt1G4cUIQCsmam2kHFG89m3fo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(36860700004)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36756003)(86362001)(4326008)(8676002)(8936002)(81166007)(82740400003)(70586007)(70206006)(5660300002)(44832011)(2906002)(83380400001)(356005)(41300700001)(110136005)(54906003)(316002)(26005)(16526019)(426003)(1076003)(2616005)(478600001)(336012)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:27:02.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1f66ef-e3b3-4612-fdfd-08dc304a9ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

amd_pmf_init_smart_pc() calls out to amd_pmf_get_bios_buffer() but
the error handling flow doesn't clean everything up all allocated
memory.

As amd_pmf_get_bios_buffer() is only called by amd_pmf_init_smart_pc(),
fold it into the function and add labels to clean up any step that
can fail along the way.

Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 67 ++++++++++++++++++---------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 1359ab340f7c..feb9dfafea30 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -338,25 +338,6 @@ static void amd_pmf_remove_pb(struct amd_pmf_dev *dev) {}
 static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev) {}
 #endif
 
-static int amd_pmf_get_bios_buffer(struct amd_pmf_dev *dev)
-{
-	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
-	if (!dev->policy_buf)
-		return -ENOMEM;
-
-	dev->policy_base = devm_ioremap(dev->dev, dev->policy_addr, dev->policy_sz);
-	if (!dev->policy_base)
-		return -ENOMEM;
-
-	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
-
-	amd_pmf_hex_dump_pb(dev);
-	if (pb_side_load)
-		amd_pmf_open_pb(dev, dev->dbgfs_dir);
-
-	return amd_pmf_start_policy_engine(dev);
-}
-
 static int amd_pmf_amdtee_ta_match(struct tee_ioctl_version_data *ver, const void *data)
 {
 	return ver->impl_id == TEE_IMPL_ID_AMDTEE;
@@ -454,14 +435,54 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = amd_pmf_set_dram_addr(dev, true);
+	if (ret)
+		goto out_dram;
+
+	dev->policy_base = devm_ioremap(dev->dev, dev->policy_addr, dev->policy_sz);
+	if (!dev->policy_base) {
+		ret = -ENOMEM;
+		goto out_policy_base;
+	}
+
+	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
+	if (!dev->policy_buf) {
+		ret = -ENOMEM;
+		goto out_policy_buf;
+	}
+
+	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
+
+	amd_pmf_hex_dump_pb(dev);
+	if (pb_side_load)
+		amd_pmf_open_pb(dev, dev->dbgfs_dir);
+
 	INIT_DELAYED_WORK(&dev->pb_work, amd_pmf_invoke_cmd);
-	amd_pmf_set_dram_addr(dev, true);
-	amd_pmf_get_bios_buffer(dev);
+
+	ret = amd_pmf_start_policy_engine(dev);
+	if (ret)
+		goto out_start_engine;
+
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data)
-		return -ENOMEM;
+		goto out_prev_data;
+
+	return 0;
 
-	return dev->smart_pc_enabled;
+out_prev_data:
+	cancel_delayed_work_sync(&dev->pb_work);
+
+out_start_engine:
+	kfree(dev->policy_buf);
+
+out_policy_buf:
+out_policy_base:
+	kfree(dev->buf);
+
+out_dram:
+	amd_pmf_tee_deinit(dev);
+
+	return ret;
 }
 
 void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)
-- 
2.34.1


