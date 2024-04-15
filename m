Return-Path: <linux-kernel+bounces-146003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A98A5E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77038B22009
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518B1591E4;
	Mon, 15 Apr 2024 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BylLhAqg"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F81272B8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223414; cv=fail; b=PE/9NtNYuKYg5Ou0jyxwoqLEBOAgxLFeIBWDUiP3gZvikaQ+Ba+oTOWmwp231RKqnNjdwvnMuhJB7iNKx/EnvBmDS7ErKRkJBpfFsB1mLdjdK2rq9mdRi7/YgVIJDb+1cWqIXHQNMq2AC1LiHfv9WTQ607YIIwOQjHD2Rh3tEo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223414; c=relaxed/simple;
	bh=oeN3YWhguWxjQNeclQa+IfSOz+Df0i08/eFpNzUjq9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8+ajsQ+9BV9T/79NB1x12MjevWlEv1J9ftUKI6OIiNQhbSZ0brEBH0SO59GYsM3ckbDElcJPmTUC6VrtLMrZWF2vHbJq3gVQvBVSt09vKhTWOpqfiWxBRCcYDLFIzk5mlgvXEqlg4OD+AET5Y6hjiygV5DLjiNsfNcth2Jt0wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BylLhAqg; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZHcLuNyPmMFVpS60MYBh4LmH/n3f9HO83EfTWfynSlzg5HvBEWYKZZdS280W1ZHf4O4JB06jXwtPIqw1XO5wn4t1ZRGK7NKVGQZSZqNpxHBPElc1d9F9wF4Rwy2NGHsMs05cIIJM+ZTsqN5m1VFKkL+ZPi2uXVV01/Y9P5j9a/XRknEuHveWSHM4UbZgbgdVOAeTweDhQnoD4lTcOiWFnZD+bz+4H37+9sDGYxok4Zt5jY5vVldmQFxbDGS0Ej/438pYN9zvP1SVrO+aJ0D8BfE58oYjzbFu7wBxEevNMPmH582tb+jyEqWmK8DQBJIvclFE9jES3ffWPcxzE8UPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=HoamId4ljSljEEi3MumwuAEx6ckiw0OTxD+HIp/LC8psW0Cr6tfRoVEluRaIx8twI8QxCaXVamXdzLiSwbdbdy20DDsB5qbIXIBU5AMFoTvKqth11duWQMksPHNb5KJ5Vdh7HMEhr79/IsBEoOY5gt42wa6UK4PAVJztd3nOyPufQt+gsaKG6deesSiFXA4Xl+9D1ccDfRnA56dVywHZ/KrvR2nZBIQq+IRGeTN5HpBb5JQ6NDB/ixyG6WUm8liBIih/zaNqqdOwMqjkrudqlW+DUVO/Hlc84C2IhU7GmO3W5AOIfJU8iDyPshdQJLrtHROPOp/LEA6k5tU2kaXkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=BylLhAqgN3qGUpWq1cCRpnuUFp8Ur59PEw4AOlui0lmtjtZ2TsdqyW99AVWeX4A7kaYdTDK3NM4lLSUlS9wD4txWIfS0cBzJymUT5ebUGiQlkZdoquDMd2WKJ9wM9erFjYSugKsrSC6nS2NkZAn+5bpX1McSYKWyWETSGEjlVq4=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:23:28 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::9f) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 23:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 23:23:28 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 18:23:27 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Mon, 15 Apr 2024 23:23:13 +0000
Message-ID: <1398c689a345b3d1751f4c06b5a9356738a296e7.1713222642.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713222642.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1713222642.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 22102a8b-3319-425f-f1da-08dc5da30e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9rjcWVyHr5jNwmMM6Z/dUAMTfrxeSuTnclDbZTTuubGgMCGFDuxK+QEfyj6owEFc/v+D5i7VHkEWYrtcGuv0sbsvaGXG9z9c8c3yDexCqAgivpTElPDOfbwgJraW43682eHrD0tgy/paQMJq1d2vhbu7TpFs/dSmArSqs119CN6v0KG4+S8oOXgFq8Kqre3dZh9+5gO5+lfdgQGoaNbaoqnFybZZgsMU0hpuoDc1Y28Cxtu7yQg0/GZ+RCzZxBY9kOddrnaDPAAh8o4DLOnP96a5+qWY418j+hau65Fu278nnIurbvGUIYe2wmaWr50GvGfZ/GneEQ/S0o2BPLXQ6Uh6MjU7bgoLfa2dfw0fkDYI2eA3ZfCmFkH7f7Q74z7ITsqaR/y2dLpH8VsamA2hnbFbTensQCo2vM5LYpLqS27pYdgh3DG+XsiQDurxd6E/4vl80hpQq50XyfqsdYSwcVlNNJvNMkXD1L3SpGFKD2pqYsIe8g/vP69KKLpjIAy6qUInUv0X2MKrV4oAm2WdcTFjtZXL5gj2ajyAQw56mbYMgD2IW/NG2Y9KMN/QPhFgRIzEFAcjJABv/UOs8WthtyZiZvYEOfpQMzudn5HgBOfi0Yiu/iiztTWtAPi+5U9d4dgT/W9MfLfecwoHqph8SoJSzCsQd9ccu3jQJTkZVNney7dQeJ6oJQJlifSZ/OcKlLeZybO85Lcxdv1Aq3JfrbM3lYTPtIXVIutCp/SPre0CcINcQv/v3674mOWVBUhO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:23:28.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22102a8b-3319-425f-f1da-08dc5da30e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM during kernel decompressor
causes guest termination as boot stage2 #VC handler for
SEV-ES/SNP systems does not support MMIO handling.

This issue is observed with SEV-ES/SNP guest kexec as
kexec -c adds screen_info to the boot parameters
passed to the kexec kernel, which causes console output to
be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is
preferable to get the console output only on serial, hence,
skip accessing video RAM during decompressor stage to
prevent guest termination.

Serial console output during decompressor stage works as
boot stage2 #VC handler already supports handling port I/O.

Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..3b9f96b3dbcc 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
-- 
2.34.1


