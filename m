Return-Path: <linux-kernel+bounces-39402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253583D06F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BDC1F28CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B34134AD;
	Thu, 25 Jan 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nh8jQYzW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0C134A0;
	Thu, 25 Jan 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224390; cv=fail; b=g9hLw//PrRoxsfydO1HUByGFwJ+M4OBtXdJLDlh+2mLu3QfDMVgzgNYivkrj1bAwAsgj8BtgceIB2XIQ/KCtUnskbmcncej3C7kZ8lfOx/A4My3v8cNaPHubUipQ+XOp1P2n1oJV45k0cL8aVyAsdIbxGM9OCeMM1pOWgpJZXT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224390; c=relaxed/simple;
	bh=14oQQZjNTuAprrLOR22SBskFUX8qmC9qd4aMmZ1l0Sg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWZSJoj2KHZqjK/RkkJs41SeSratdWwhDk+svWz/Pi525cGrgxc9NKxFAzfsvkYpNjKMdFs9NkV8u0dl/0JpjF/rLBa8r1gP69Vsze6x4DAqA+jPtkaTvTi3gLna11csregvDf6vUXSSHsmYY7gSTWY2dPLy9cA1OavoddLnfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nh8jQYzW; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvc1rfCYIwbITA7ATS8clYcEVA3sBHBZeNL5Lahu4DZ3qGBWOrYiQf4Ax0uT04mSmRX36WCjkJPzXTp18wE+FNTmbDC3GG3ioxqpmzcUWEZJauw3XN3OK55aoySLF6OS50xUWFAfVu7uqFIN2BAg3zVA8QFDZcg2vrlRHJFT49DYV/6ZSu9ACqKrR7kgxNy4UUAsa0x9skH0rHzebuyRcjjpX7OHLft/F7cwqtuU8dZjETMUK44tfl2PjQcg4kABVA8a9Qwik4R2rSqN9BlCqXTqcAKtNVjgZmZKUpMjkCARA3cZJVdStAmBaVyZqr9Yjhq8x9Kl5im5IIk2G/QJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCEHDOq6POsNUZC3VqjTU0cTBQps6CLxWYet95t9zns=;
 b=OhFeJnY9BQOqT4oXIi1lNR11Dj++/2o2hrPnI3ld/cdZqN9O0wtNTxanlcdnti+2D2zSu1UbHv+1djuEGD5x55S6hMjSrVwAotNiLONwaehQTSfAZKAGsCyeXAq7VCEwZN1qksudyiQ+KMTXOePY6jwEKiSvUlcObz53rrWh7M1RmOowzmujm8oiKuTaQKp46WGn2neh8IeoeYrNLz7lcc68jXg7prtAqU2/G4SapUBcccbRzERYJy/2YVVFdIat0bqcvxrAcwp0+tPZYXwMicDymHXsidLlRfdaIsgucro0n8+bqAJ3aaACSDd58mUVHt77mokzJb2jtXw5meKqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCEHDOq6POsNUZC3VqjTU0cTBQps6CLxWYet95t9zns=;
 b=nh8jQYzWcyIcguWHn/iafoe/bNjxA+TUa85/Q3f5+4UnePcAxczkfzkJ9iNcgpLSQ2zzb6rhotJ8MfRVeGDic1rsjMdI8C3O5vwopGEJf5vVeMszBy3Ln483KODwkcs9kIE+90NMvBl0dqWYTVV0jKlQgrRswOPqhKLp1DruMQ8=
Received: from SJ0PR03CA0121.namprd03.prod.outlook.com (2603:10b6:a03:33c::6)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 23:13:03 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5c) by SJ0PR03CA0121.outlook.office365.com
 (2603:10b6:a03:33c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 23:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 23:13:02 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 17:13:00 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Kim
 Phillips" <kim.phillips@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked
Date: Thu, 25 Jan 2024 17:12:53 -0600
Message-ID: <20240125231253.3122579-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 705eaad4-7507-49ef-dfb8-08dc1dfb2dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uVUJz5Zso0lJzHApdDzFdzwlb8UuJGmGGbOEuLmp0DE2r5iqTTU9rw7s20NneiYR9RkI6RNAFy1wxrxp5ma/DTGH5S1KH3XcS/ocuSgebkIuJyvNg8HoH/We0wz3YTBLAAXyxYah7Uy86YCPF5gidx+W+huftGmSnUwJ4w/fCHIxTFdbnjT6LKdfxc5grlLfFqr7Owtn7VDE0wW5LoU3gkFcgnKWPaNvmyGJ2ob/0qx0EtJHBGhPnqf8ZN+7UZt9vkv3X+TmD9BwXwys5WhQInCpjtd9lRWEe3MVAW7lMlj9XIjNqR29xtexXXP0voN0DCAib7iJHZz0gZUsee1pQUHlj8td853kLdU1TVfuk7oV09kyz6ykayH6qVyad4nQyTj8iMmfFFQ2Ec0GV4ZkGmsOA8o8I3zZKEhII6QsbI/2+b/+kauRikfJ0d0UFSKpiJMboSXSBSLvEjtR529Euc+m5vk+h5y7b69GhxKXA5XId75OlJmSm/+mYiDplQ5Y9cWIQvxOaDFMClfSNoiGCrbVS6ejS1ANAHqEzz7Rt+6TI5EBLP/wTitlqyePM0KJdRN+EsIbKN6IhPlc+DcZZlsYfE4or01uq6h6KfMVz6AUhVA7n5thEPICDCLJfjvBtW11C8kdml5VbflRFwDSjmwH3I2nZfmVwgGM8Firfw/Wgb1R2pUnKvqm+kuKSBdK74OjkwkJWbIwwegK7gOr4KDthMWUN8oYpyNAh81BtcXKoMiGPjF/6FGi5JL7dYFbKYG6ghUeM6AbhBg1xeyaMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(1076003)(6666004)(70586007)(41300700001)(86362001)(54906003)(2616005)(8936002)(47076005)(7696005)(26005)(70206006)(356005)(316002)(110136005)(36756003)(4326008)(5660300002)(8676002)(44832011)(16526019)(82740400003)(81166007)(36860700001)(2906002)(83380400001)(336012)(426003)(478600001)(45080400002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 23:13:02.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705eaad4-7507-49ef-dfb8-08dc1dfb2dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

The SEV platform device can be shutdown with a null psp_master,
e.g., using DEBUG_TEST_DRIVER_REMOVE.  Found using KASAN:

[  137.148210] ccp 0000:23:00.1: enabling device (0000 -> 0002)
[  137.162647] ccp 0000:23:00.1: no command queues available
[  137.170598] ccp 0000:23:00.1: sev enabled
[  137.174645] ccp 0000:23:00.1: psp enabled
[  137.178890] general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
[  137.182693] KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
[  137.182693] CPU: 93 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1+ #311
[  137.182693] RIP: 0010:__sev_platform_shutdown_locked+0x51/0x180
[  137.182693] Code: 08 80 3c 08 00 0f 85 0e 01 00 00 48 8b 1d 67 b6 01 08 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 00 00 00 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f 85 fe 00 00 00 48 8b 9b f0 00 00 00 48 85 db 74 2c
[  137.182693] RSP: 0018:ffffc900000cf9b0 EFLAGS: 00010216
[  137.182693] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 000000000000001e
[  137.182693] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000000000f0
[  137.182693] RBP: ffffc900000cf9c8 R08: 0000000000000000 R09: fffffbfff58f5a66
[  137.182693] R10: ffffc900000cf9c8 R11: ffffffffac7ad32f R12: ffff8881e5052c28
[  137.182693] R13: ffff8881e5052c28 R14: ffff8881758e43e8 R15: ffffffffac64abf8
[  137.182693] FS:  0000000000000000(0000) GS:ffff889de7000000(0000) knlGS:0000000000000000
[  137.182693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.182693] CR2: 0000000000000000 CR3: 0000001cf7c7e000 CR4: 0000000000350ef0
[  137.182693] Call Trace:
[  137.182693]  <TASK>
[  137.182693]  ? show_regs+0x6c/0x80
[  137.182693]  ? __die_body+0x24/0x70
[  137.182693]  ? die_addr+0x4b/0x80
[  137.182693]  ? exc_general_protection+0x126/0x230
[  137.182693]  ? asm_exc_general_protection+0x2b/0x30
[  137.182693]  ? __sev_platform_shutdown_locked+0x51/0x180
[  137.182693]  sev_firmware_shutdown.isra.0+0x1e/0x80
[  137.182693]  sev_dev_destroy+0x49/0x100
[  137.182693]  psp_dev_destroy+0x47/0xb0
[  137.182693]  sp_destroy+0xbb/0x240
[  137.182693]  sp_pci_remove+0x45/0x60
[  137.182693]  pci_device_remove+0xaa/0x1d0
[  137.182693]  device_remove+0xc7/0x170
[  137.182693]  really_probe+0x374/0xbe0
[  137.182693]  ? srso_return_thunk+0x5/0x5f
[  137.182693]  __driver_probe_device+0x199/0x460
[  137.182693]  driver_probe_device+0x4e/0xd0
[  137.182693]  __driver_attach+0x191/0x3d0
[  137.182693]  ? __pfx___driver_attach+0x10/0x10
[  137.182693]  bus_for_each_dev+0x100/0x190
[  137.182693]  ? __pfx_bus_for_each_dev+0x10/0x10
[  137.182693]  ? __kasan_check_read+0x15/0x20
[  137.182693]  ? srso_return_thunk+0x5/0x5f
[  137.182693]  ? _raw_spin_unlock+0x27/0x50
[  137.182693]  driver_attach+0x41/0x60
[  137.182693]  bus_add_driver+0x2a8/0x580
[  137.182693]  driver_register+0x141/0x480
[  137.182693]  __pci_register_driver+0x1d6/0x2a0
[  137.182693]  ? srso_return_thunk+0x5/0x5f
[  137.182693]  ? esrt_sysfs_init+0x1cd/0x5d0
[  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
[  137.182693]  sp_pci_init+0x22/0x30
[  137.182693]  sp_mod_init+0x14/0x30
[  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
[  137.182693]  do_one_initcall+0xd1/0x470
[  137.182693]  ? __pfx_do_one_initcall+0x10/0x10
[  137.182693]  ? parameq+0x80/0xf0
[  137.182693]  ? srso_return_thunk+0x5/0x5f
[  137.182693]  ? __kmalloc+0x3b0/0x4e0
[  137.182693]  ? kernel_init_freeable+0x92d/0x1050
[  137.182693]  ? kasan_populate_vmalloc_pte+0x171/0x190
[  137.182693]  ? srso_return_thunk+0x5/0x5f
[  137.182693]  kernel_init_freeable+0xa64/0x1050
[  137.182693]  ? __pfx_kernel_init+0x10/0x10
[  137.182693]  kernel_init+0x24/0x160
[  137.182693]  ? __switch_to_asm+0x3e/0x70
[  137.182693]  ret_from_fork+0x40/0x80
[  137.182693]  ? __pfx_kernel_init+0x10/0x10
[  137.182693]  ret_from_fork_asm+0x1b/0x30
[  137.182693]  </TASK>
[  137.182693] Modules linked in:
[  137.538483] ---[ end trace 0000000000000000 ]---

Fixes: 1b05ece0c9315 ("crypto: ccp - During shutdown, check SEV data pointer before using")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index fcaccd0b5a65..53b217a62104 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -534,10 +534,16 @@ EXPORT_SYMBOL_GPL(sev_platform_init);
 
 static int __sev_platform_shutdown_locked(int *error)
 {
-	struct sev_device *sev = psp_master->sev_data;
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
 	int ret;
 
-	if (!sev || sev->state == SEV_STATE_UNINIT)
+	if (!psp || !psp->sev_data)
+		return 0;
+
+	sev = psp->sev_data;
+
+	if (sev->state == SEV_STATE_UNINIT)
 		return 0;
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
-- 
2.34.1


