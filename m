Return-Path: <linux-kernel+bounces-103582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796AA87C164
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8591C21B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C073535;
	Thu, 14 Mar 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l481hXlB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCB7352C;
	Thu, 14 Mar 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434198; cv=fail; b=Akc277SXNFcprsQE1rFav5eQma3Uk5pzaJ8yIUK7ckMdePb6H7kcz8RNaAnTx7bCKI4lWBq35nEpYXoQpvZHIrBjnjToOsRbyOfLu4StsJ/hY1dscne00382UU+iPrtKzs3OWf20D/eZ66eFGVjqHY1rs10hgrQUzjBgMdyvLwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434198; c=relaxed/simple;
	bh=IXa7wY3G5lblqD2vhQgg+aEKVTQFc/FtmAceGLZHFho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI0G89P/Hhro3LjaR4Nqx440ifUV4qAQGXN51lQ1y3wl0oRmRWlwhz0clXqEU5dtYAGLGtio6rJJIUUrXJDXj2Qr//Ih57Lg7H4EKBBwecQdzHt0XJIn+STlFECgdBbLO61N7zgagnhnljVNNxJAjV7/ljE/FZ/ZR3DxvLQuTAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l481hXlB; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL+cfnMLrOcE0qEi1jwXxzZ5Iav+pP472yLUpP+NoHebyJyrNlxRsPpArwSXoQjW/meGKV9GZc0gVeJhm8mABoKXUMq7OVRsCzkbvmJiI//ew2M1oCE0uQmgQbUU23+1tUNdHRl6jDyU85XB5XNGejcekqlcntdCsken7AgsTJBlNTwXV38nYh2gphxQDN/IIuGJ7s11Op5oILmwAzPW2d5nl9bRr9ohgg9JEvBLUByZld3ejbfmDlbx5BOEEUVziJNXaAZT8Dypul92lfea7zK6lK74Su4KB8d7KOm56Dn6vWEiRd9rPhIM7CSOkf8Y3hoEe31yn8aOLVJBzDAGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDEHI7t7yTtn+rcFrlJQmC3pqcXviCsYl2DRKHCLaP4=;
 b=UqOIwZa46l8bXSf0KznFYT7VmqcBu4B7suOIZQqUAVr6HXau1kgTr6tsb7vVoeesFgJBWTuh8bf3sqSmtMdrFSxjrvCOBszUI5OiCkm2/PX92yKJ0LgF1O94y3q76mNObxFcUH0UvowXrpEDwnyi1SdBjBQF9ksfTt7Pcf6yi3WNZMaeLc0Pv6QB69EjbJ0gvDlM/kl6uyL0alQQs5UPGRL54QmFhxfQoP7au3ugmTWPvg7U69VzsFRuOY/p4MlT3kkGHnm45nQ+/N1n7dGB6uztniNkjMiPgCtMoWLz2blPZhIA8PzBHm/sYaqAgCkuDjiYipxZHQAGN5Fh5QXIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDEHI7t7yTtn+rcFrlJQmC3pqcXviCsYl2DRKHCLaP4=;
 b=l481hXlBNnm8zgwJBKAu5KilN/mr63aFngd/ja6GfurTi0jtHk9F7NYVrAr9Fyoe3kwr0PXhbUbSNGosxc5H57SpVV1d6KbVXuNqhjQmsXN5EAQARovtVHWqtpgD/dUlpLRj5t+4u+UNWp+eXMC92+3xDPZNvXcHII1Xk8N24ws=
Received: from BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) by SA0PR12MB7001.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 16:36:32 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2a01:111:f403:f903::) by BL6PEPF0001641A.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Thu, 14 Mar 2024 16:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:36:22 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:36:21 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<yazen.ghannam@amd.com>, <muralidhara.mk@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH 4/4] RAS: ATL: Implement DF 4.5 NP2 denormalization
Date: Thu, 14 Mar 2024 16:35:27 +0000
Message-ID: <20240314163527.63321-5-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314163527.63321-1-john.allen@amd.com>
References: <20240314163527.63321-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 67281d8f-1e4b-48a3-d1db-08dc4444e249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3/ArjGH5gO9UoLRbe2sMFBN40972uvVj6rbcJH3Syh9vhOdbXvpj/FbE/YlKx8rGOovaZ4ZsvxXAPXr0PUMmJc1RFaBuDOZMf45iL5PF3wCxkaBG7zFG3zTQxW/KIhFfbPJJ6QjGlKStzRrHKiS/49vh+9DB9TxnKeYZCH6zDZQrDLWLUlCO4DZyvOGDlqlLFmZRftfD1Tm2j+WfLpzO3y9kaIcFooi5Ezt64kccEZ+X6f9dKg1GiJrKgpsG8vyOX/B86SXLXqHNeaQzvljqXRNmCPpGvQJXyJs2QsyFvmEnc0qGCVc6jsH26qdMSdhDT4MNeKQvSM5t7oCXpOxSx+44QU4isEzJ7iy7B/UZh76xJaNbd5LtRNbRjyAyFDJOrv28FAE3qNocBL1A8BHOaEsAbGVM1pEbkeZzDuQgYGNFS+hwdmsY48G04HyDx/XcY2XazwP46qTvDQStaS2t+xlHSVqFSZZdP2mM3hkehfnkoz1jIeeooslqZq6yAZxPtCNzDUhKx2BFW7KlMg8djO5+fCIJYXHk6OeZeO8JpVNAFPW9nFN6UNImW2lI7TC9C/eGF3IICx6BH000b5bIIP1tBIKvVfKx061jlKDsYSh6o4kB6U4NMlF7WCCti74wWNAb+32DANUnhAZ7CaH4Ag0/8FvmvDAFe6rRKWWybJ2DZFaJMth5k3NwCuy1ouwvU9u9ND8Jwm88+FMWPM0HyexwPijar3hZb9tY8YL6WKwg+mTRJGCmxNnx4qmLCtf2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:36:22.4252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67281d8f-1e4b-48a3-d1db-08dc4444e249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001

Unlike with previous Data Fabric versions, with Data Fabric 4.5, there
are bits of the system physical address that can't be reconstructed from
the normalized address. Using NPS0_24CHAN_1K_HASH as an example, the
normalized address consists of bits [63:13] (divided by 3), bits
[11:10], and bits [7:0] of the system physical address.

In this case, the remainder from the divide by 3 and bits 8, 9, and 12
are missing. To determine the proper combination of missing system
physical address bits, iterate through each possible combination of
these bits, normalize the resulting system physical address, and compare
to the original address that is being translated. If the addresses
match, then the correct permutation of bits has been found.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/ras/amd/atl/denormalize.c | 530 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  40 +++
 drivers/ras/amd/atl/map.c         |  37 +++
 3 files changed, 607 insertions(+)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index e279224288d6..b03bba851e14 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -448,6 +448,105 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 	return (phys_fabric_id & df_cfg.node_id_mask) | log_fabric_id;
 }
 
+static u64 get_logical_coh_st_fabric_id_for_current_spa(struct addr_ctx *ctx,
+							struct df4p5_denorm_ctx *denorm_ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
+	bool hash_pa8, hash_pa9, hash_pa12, hash_pa13;
+	u64 cs_id = 0;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	hash_pa8  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
+	hash_pa8 ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
+	hash_pa8 ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa9  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
+	hash_pa9 ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa12  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
+	hash_pa12 ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa13  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
+	hash_pa13 ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa9 | (hash_pa12 << 1));
+		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
+		break;
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa12 | (hash_pa13 << 1));
+		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa9 << 1));
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa12 << 1));
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) << 1);
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(GENMASK_ULL(9, 8), denorm_ctx->current_spa);
+		cs_id %= denorm_ctx->mod_value;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) << 1;
+		cs_id %= denorm_ctx->mod_value;
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	return cs_id;
+}
+
 static int denorm_addr_common(struct addr_ctx *ctx)
 {
 	u64 denorm_addr;
@@ -699,6 +798,424 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
+				    u64 addr)
+{
+	u64 temp_addr_a, temp_addr_b;
+
+	temp_addr_a = 0;
+	temp_addr_b = 0;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 10), addr) << 8;
+		break;
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 9), addr) << 8;
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 14), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(9), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 2;
+		temp_addr_b |= FIELD_GET(GENMASK_ULL(9, 8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	return denorm_ctx->base_denorm_addr | temp_addr_a | temp_addr_b;
+}
+
+static void recalculate_hashed_bits_df4p5_np2(struct addr_ctx *ctx,
+					      struct df4p5_denorm_ctx *denorm_ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T, hashed_bit;
+
+	if (!denorm_ctx->rehash_vector)
+		return;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(8)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(8);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(9)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(9);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(12)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(12);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(13)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(13);
+	}
+}
+
+static bool check_logical_coh_st_fabric_id(struct addr_ctx *ctx,
+					   struct df4p5_denorm_ctx *denorm_ctx)
+{
+	unsigned int logical_coh_st_fabric_id;
+
+	/*
+	 * The logical CS fabric ID of the permutation must be calculated from the
+	 * current SPA with the base and with the MMIO hole.
+	 */
+	logical_coh_st_fabric_id = get_logical_coh_st_fabric_id_for_current_spa(ctx, denorm_ctx);
+
+	atl_debug(ctx, "Checking calculated logical coherent station fabric id:\n");
+	atl_debug(ctx, "  calculated fabric id         = 0x%x\n", logical_coh_st_fabric_id);
+	atl_debug(ctx, "  expected fabric id           = 0x%x\n", denorm_ctx->coh_st_fabric_id);
+
+	if (denorm_ctx->coh_st_fabric_id != logical_coh_st_fabric_id)
+		return false;
+
+	return true;
+}
+
+static bool check_norm_addr(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	u64 current_spa_without_base = remove_base_and_hole(ctx, denorm_ctx->current_spa);
+	u64 norm_addr;
+
+	/*
+	 * The normalized address must be calculated with the current SPA without
+	 * the base and without the MMIO hole.
+	 */
+	norm_addr = normalize_addr_df4p5_np2(ctx, denorm_ctx, current_spa_without_base);
+
+	atl_debug(ctx, "Checking calculated normalized address:\n");
+	atl_debug(ctx, "  calculated normalized addr = 0x%016llx\n", norm_addr);
+	atl_debug(ctx, "  expected normalized addr   = 0x%016llx\n", ctx->ret_addr);
+
+	if (norm_addr != ctx->ret_addr)
+		return false;
+
+	return true;
+}
+
+static int check_permutations(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	u64 test_perm, temp_addr, denorm_addr, num_perms;
+	unsigned int dropped_remainder;
+
+	denorm_ctx->div_addr *= denorm_ctx->mod_value;
+
+	/*
+	 * The high order bits of num_permutations represent the permutations
+	 * of the dropped remainder. This will be either 0-3 or 0-5 depending
+	 * on the interleave mode. The low order bits represent the
+	 * permutations of other "lost" bits which will be any combination of
+	 * 1, 2, or 3 bits depending on the interleave mode.
+	 */
+	num_perms = denorm_ctx->mod_value << denorm_ctx->perm_shift;
+
+	for (test_perm = 0; test_perm < num_perms; test_perm++) {
+		denorm_addr = denorm_ctx->base_denorm_addr;
+		dropped_remainder = test_perm >> denorm_ctx->perm_shift;
+		temp_addr = denorm_ctx->div_addr + dropped_remainder;
+
+		switch (ctx->map.intlv_mode) {
+		case DF4p5_NPS0_24CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 14;
+			break;
+		case DF4p5_NPS0_24CHAN_1K_HASH:
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 13;
+			break;
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 12;
+			break;
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 9;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(GENMASK_ULL(1, 0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 2), (temp_addr)) << 12;
+			break;
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
+		default:
+			atl_debug_on_bad_intlv_mode(ctx);
+			return -EINVAL;
+		}
+
+		switch (ctx->map.intlv_mode) {
+		case DF4p5_NPS0_24CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
+			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 12;
+			break;
+		case DF4p5_NPS0_24CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 13;
+			break;
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			break;
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
+			break;
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			break;
+		default:
+			atl_debug_on_bad_intlv_mode(ctx);
+			return -EINVAL;
+		}
+
+		denorm_ctx->current_spa = add_base_and_hole(ctx, denorm_addr);
+		recalculate_hashed_bits_df4p5_np2(ctx, denorm_ctx);
+
+		atl_debug(ctx, "Checking potential system physical address 0x%016llx\n",
+			  denorm_ctx->current_spa);
+
+		if (!check_logical_coh_st_fabric_id(ctx, denorm_ctx))
+			continue;
+
+		if (!check_norm_addr(ctx, denorm_ctx))
+			continue;
+
+		if (denorm_ctx->resolved_spa == INVALID_SPA ||
+		    denorm_ctx->current_spa > denorm_ctx->resolved_spa)
+			denorm_ctx->resolved_spa = denorm_ctx->current_spa;
+	}
+
+	if (denorm_ctx->resolved_spa == INVALID_SPA) {
+		atl_debug(ctx, "Failed to find valid SPA for normalized address 0x%016llx\n",
+			  ctx->ret_addr);
+		return -EINVAL;
+	}
+
+	/* Return the resolved SPA without the base, without the MMIO hole */
+	ctx->ret_addr = remove_base_and_hole(ctx, denorm_ctx->resolved_spa);
+
+	return 0;
+}
+
+static int init_df4p5_denorm_ctx(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	denorm_ctx->current_spa = INVALID_SPA;
+	denorm_ctx->resolved_spa = INVALID_SPA;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 3;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(9) | BIT(12);
+		break;
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 3;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12) | BIT(13);
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12);
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = 0;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = 0;
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	denorm_ctx->base_denorm_addr = FIELD_GET(GENMASK_ULL(7, 0), ctx->ret_addr);
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(9, 8), ctx->ret_addr) << 10;
+		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 10), ctx->ret_addr);
+		break;
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(10, 8), ctx->ret_addr) << 9;
+		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 11), ctx->ret_addr);
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	if (ctx->map.num_intlv_chan % 3 == 0)
+		denorm_ctx->mod_value = 3;
+	else
+		denorm_ctx->mod_value = 5;
+
+	denorm_ctx->coh_st_fabric_id = get_logical_coh_st_fabric_id(ctx) - get_dst_fabric_id(ctx);
+
+	atl_debug(ctx, "Initialized df4p5_denorm_ctx:");
+	atl_debug(ctx, "  mod_value         = %d", denorm_ctx->mod_value);
+	atl_debug(ctx, "  perm_shift        = %d", denorm_ctx->perm_shift);
+	atl_debug(ctx, "  rehash_vector     = 0x%x", denorm_ctx->rehash_vector);
+	atl_debug(ctx, "  base_denorm_addr  = 0x%016llx", denorm_ctx->base_denorm_addr);
+	atl_debug(ctx, "  div_addr          = 0x%016llx", denorm_ctx->div_addr);
+	atl_debug(ctx, "  coh_st_fabric_id  = 0x%x", denorm_ctx->coh_st_fabric_id);
+
+	return 0;
+}
+
+/*
+ * For DF 4.5, parts of the physical address can be directly pulled from the
+ * normalized address. The exact bits will differ between interleave modes, but
+ * using NPS0_24CHAN_1K_HASH as an example, the normalized address consists of
+ * bits [63:13] (divided by 3), bits [11:10], and bits [7:0] of the system
+ * physical address.
+ *
+ * In this case, there is no way to reconstruct the missing bits (bits 8, 9,
+ * and 12) from the normalized address. Additionally, when bits [63:13] are
+ * divided by 3, the remainder is dropped. Determine the proper combination of
+ * "lost" bits and dropped remainder by iterating through each possible
+ * permutation of these bits and then normalizing the generated system physical
+ * addresses. If the normalized address matches the address we are trying to
+ * translate, then we have found the correct permutation of bits.
+ */
+static int denorm_addr_df4p5_np2(struct addr_ctx *ctx)
+{
+	struct df4p5_denorm_ctx denorm_ctx;
+	int ret = 0;
+
+	memset(&denorm_ctx, 0, sizeof(denorm_ctx));
+
+	atl_debug(ctx, "Denormalizing DF 4.5 normalized address 0x%016llx", ctx->ret_addr);
+
+	ret = init_df4p5_denorm_ctx(ctx, &denorm_ctx);
+	if (ret)
+		return ret;
+
+	return check_permutations(ctx, &denorm_ctx);
+}
+
 int denormalize_address(struct addr_ctx *ctx)
 {
 	switch (ctx->map.intlv_mode) {
@@ -710,6 +1227,19 @@ int denormalize_address(struct addr_ctx *ctx)
 	case DF4_NPS2_5CHAN_HASH:
 	case DF4_NPS1_10CHAN_HASH:
 		return denorm_addr_df4_np2(ctx);
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		return denorm_addr_df4p5_np2(ctx);
 	case DF3_6CHAN:
 		return denorm_addr_df3_6chan(ctx);
 	default:
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 4681449321de..0c67ceedfc60 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -34,6 +34,8 @@
 #define DF_DRAM_BASE_LIMIT_LSB		28
 #define MI300_DRAM_LIMIT_LSB		20
 
+#define INVALID_SPA ~0ULL
+
 enum df_revisions {
 	UNKNOWN,
 	DF2,
@@ -90,6 +92,44 @@ enum intlv_modes {
 	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
 };
 
+struct df4p5_denorm_ctx {
+	/* perm_shift: Indicates the number of "lost" bits. This will be 1, 2, or 3. */
+	u8 perm_shift;
+
+	/* rehash_vector: A mask indicating the bits that need to be rehashed. */
+	u16 rehash_vector;
+
+	/*
+	 * mod_value: Represents the value that the high bits of the normalized
+	 * address are divided by during normalization. This value will be 3
+	 * for interleave modes with a number of channels divisible by 3 or the
+	 * value will be 5 for interleave modes with a number of channels
+	 * divisible by 5. Power-of-two interleave modes are handled
+	 * separately.
+	 */
+	u8 mod_value;
+
+	/*
+	 * base_denorm_addr: Represents the bits that can be directly pulled
+	 * from the normalized address. In each case, pass through bits [7:0]
+	 * of the normalized address. The other bits depend on the interleave
+	 * bit position which will be bit 10 for 1K interleave stripe cases and
+	 * bit 11 for 2K interleave stripe cases.
+	 */
+	u64 base_denorm_addr;
+
+	/*
+	 * div_addr: Represents the high bits of the physical address that have
+	 * been divided by the mod_value.
+	 */
+	u64 div_addr;
+
+	u64 current_spa;
+	u64 resolved_spa;
+
+	u16 coh_st_fabric_id;
+};
+
 struct df_flags {
 	__u8	legacy_ficaa		: 1,
 		socket_id_shift_quirk	: 1,
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 8b908e8d7495..1a32a52be942 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -642,6 +642,39 @@ static int get_global_map_data(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int validate_address_map(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
+			goto out;
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets != 1 || !map_bits_valid(ctx, 8, 0, 1, 1))
+			goto out;
+		break;
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	return 0;
+
+out:
+	atl_debug(ctx, "Inconsistent address map");
+	return -EINVAL;
+}
+
 static void dump_address_map(struct dram_addr_map *map)
 {
 	u8 i;
@@ -678,5 +711,9 @@ int get_address_map(struct addr_ctx *ctx)
 
 	dump_address_map(&ctx->map);
 
+	ret = validate_address_map(ctx);
+	if (ret)
+		return ret;
+
 	return ret;
 }
-- 
2.34.1


