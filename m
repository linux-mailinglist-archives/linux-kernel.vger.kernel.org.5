Return-Path: <linux-kernel+bounces-76911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DC85FE82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE51F259DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F75153BF8;
	Thu, 22 Feb 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RF/RoxGX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DB15098A;
	Thu, 22 Feb 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620907; cv=fail; b=jyTDApxMUytM7cnoqM9NuWbiArcANFOmoUr6WvDgsJ7w6MEWsKNJLohN6izGp2f/V4siRDLsrAmaAy8nl6kIhz00utDriv/P4hPmP4Lj/4mI72OVFjZDlUnBULpfPqhmED2N4Uam2vk8x4CHFJydcrgyK4+cqVuhGTeCZ4Mlzhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620907; c=relaxed/simple;
	bh=ZCnjNbBQgJ/MQjlQeOCEPc8uZa2nulbupCi6Cdzb6X0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrBR4S5a5iI3HNH79Hl8WnAejd1bMkicd7NNNZRsKs2VIveL9tHK4mh1GVmhfDZ6/bwBRdQgzww9KczgsdzoR3HxF7UEZeHrJ6XIiPbIfEvAvtQQ1PNZTjoo/8uqZCJmKqihr1vU7eWhnoXayZXgNstnETR2z++zIReBNaRU3yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RF/RoxGX; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEVkVNHNAAxfbPFwtEjYD2Lx+7Qh/yr/2L7Jvb8LBgNL3tD8IeUtJ/AOopqnpmYaYYl7hKH1aH7FkUyOjO5P38Px5Yr/kJrFYMzM3vqekq3ciK9Yfj69uMGJ/pj53O2ge+VF4fadSiWWzcX7fqdr8onHVoW3OC8Y+zraundb90mByrk0uMLvaNJnrXbD1GMX7NMdI57sgaytuIYA26ZCLvJS1GBNb8rkgOROA2tuUHoAPaHYmWWztR1h6OPR3jQD9c4qmP4elMGztWq8AdtyYofZbg78qa9/8IjyXbS0IRzO3K3CtE9fjyj7ByBwpsUDCUX3TF+XK2URKndEm8Od6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEWrLJhcJNx3jvUGP3CWe4rhsGDi+5feYj/NA/b8cbE=;
 b=KjsJFVKJcQiVm0M8BY7JEWV0YOEokY0whO12FM93kL8nC2fBaHrYDANQVm7SHrsJ8od6NvPJQ6gaDzJGjkJwvk+LK0tiga6TBrD/14Sk/7IPi1SKEFq+uDEQkBVTkpAsadxpKEIAibBZ4UawnNDn5Cam21ioThOSGHO/q/VfysunE01fjTLv0xkmwKIFkbw7upA31qrijmiSS0LGPs1QZsFAjGnu3pcDq33SEa2TtfTwGguSXVutZcNQ4/YqFh+WrmNMkKYkHRAkpaHC5FxJTvIn40UWrvdOYx7f9v3UhRSbat5mnp0QpKnNCoeRO3FKAbf94Lm89wWtUYDK5N8jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEWrLJhcJNx3jvUGP3CWe4rhsGDi+5feYj/NA/b8cbE=;
 b=RF/RoxGX0/TEX2zOU5FzYZ7n2lzFyhhezxKPIK0G0BpHaJljNbi10OAqYuKRIQ009Lln6uVfYGolLLNgm3ne6RRqrryYKnWRLEkrZIpnLFDO+3ejM0RovlOJ0yFpDNt0Z1jkiWJ5oWSd0d47PZPyEfShBCkXWB6eMxRR+dw0kwE=
Received: from BYAPR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:e0::38)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 16:55:02 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::46) by BYAPR05CA0097.outlook.office365.com
 (2603:10b6:a03:e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Thu, 22 Feb 2024 16:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 16:55:00 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 10:54:59 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/ATL: Fix bit overflow in denorm_addr_df4_np2()
Date: Thu, 22 Feb 2024 10:54:49 -0600
Message-ID: <20240222165449.23582-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 9388dc5d-d93b-47bf-c046-08dc33c70261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uVDuEwiifQjNVyFxnw41Z97EY98pyi9pikpprgj/52Xdzs6uVDULei2LHbVIoSIgIiEPFU4bB7Tv/ICu03/mNehOrjkZTd/pc0U7U/SmAPH0vZHACB6zywIB/7JISsFFiy85luFFEaeCyyRpIiLmY6g9qfH3vgWxcrcn5RKK+rHXUCtE6nB5uWIx82eXt5uEjAyAbj6JRNx1mZt633TcBhPA6nlZLS5yI1aCFetZlvJauJEGyUNM7ikrA/z1uHyjW0scu587Njs/itqYRrnv513xOqNEgCJ3Nz7WZOXZdkkVXqDZvzxGEMNxGUc6KiB6I0FOy10IAnzxxPA2qUVaCY4osQIl/Dn2FNeCExx90z6V76KdkCaTr1SX3UB/BMQ0YeD/qyl4ybQ4wVuJ8TBRqEJiYJl0LzoZSne2cd98toT8+95gK7JxwZlRRxUOXW4l8rLYi9M3czHM2PfG6t3tF6U3sjXHImJ5pPxw8dxxBEjOAOUPSpiwH2JFbWd+04ohP4XTFbnyUG9MCpA35E+wmrt8Z8EnMZCHBZC0zmJSlYMMSBrtn6HfgjjSbfEhImWUE5kfFjRVIhQOOkXuz9LtQIoHGJw6qfCZwo1A8eUS9xV4VC47o/h5l+g2ygah3rgC4rzZMz8NPSGPTwvNj37JYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:55:00.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9388dc5d-d93b-47bf-c046-08dc33c70261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

The hash_pa8 and hashed_bit values in denorm_addr_df4_np2() are
currently defined as u8 types. These variables represent single bits.

'hash_pa8' is set based on logical AND operations using masks with more
than 8 bits. So the calculated value will not fit in this variable. It
will always be '0'. The 'hash_pa8' check later in the function will fail
which produces incorrect results for some cases.

Change these variables to bool type. This clarifies that they are
single bit values. Also, this allows the compiler to ensure they hold
the proper results. Remove an unnecessary shift operation.

Fixes: 3f3174996be6 ("RAS: Introduce AMD Address Translation Library")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/denormalize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index 49a900e066f1..f46bce119255 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -545,7 +545,7 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	unsigned int mod_value, shift_value;
 	u16 mask = df_cfg.component_id_mask;
 	u64 temp_addr_a, temp_addr_b;
-	u8 hash_pa8, hashed_bit;
+	bool hash_pa8, hashed_bit;
 
 	switch (ctx->map.intlv_mode) {
 	case DF4_NPS4_3CHAN_HASH:
@@ -578,7 +578,6 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 		temp_addr_a	= remove_bits(shift_value, shift_value, ctx->ret_addr);
 	} else {
 		hash_pa8	= (ctx->coh_st_fabric_id & df_cfg.socket_id_mask);
-		hash_pa8	>>= df_cfg.socket_id_shift;
 		temp_addr_a	= ctx->ret_addr;
 	}
 
-- 
2.34.1


