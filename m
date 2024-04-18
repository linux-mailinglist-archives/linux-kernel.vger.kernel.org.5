Return-Path: <linux-kernel+bounces-150469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4866C8A9FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BA91F23429
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387D16F913;
	Thu, 18 Apr 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1u0qH0hh"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256716F919;
	Thu, 18 Apr 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456922; cv=fail; b=NKwQ3vsAFYTPa3Ek6krLfv1bZX4Fbhbj6YRgpu1znN5fL4TytDpa5jdUq3L4ozJ/CozaYV6CugChPWV0Fk7QbS7wzt53xY0Nl/uVjW0w1JDpyPzZyD1SGXSfDq9R/I+r31kC794SsxwQo6om1cRcBWHKy758BMGUacFFwt/g//Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456922; c=relaxed/simple;
	bh=UWWEv8nXFMmg2W+AoKlv5a+IK0pRYozRG61dO9UJrGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/54Al0Vv3cp+tiUr7VKT8rn9094o7G0eJqd9BzC6TGSOFPrMOjaWcsFHphjF0Tf10+hyk2v7Z4nYLK6b2fL3lm8pX0WqLdH/b6EBcyF6XphehtbgfNYPzxCxFIEhJRsIKqOBU5IIFeAjcAGjYhrN6eCvLbFFA8hGsN7Toa191w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1u0qH0hh; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9YH6YNeHH6tT7JLKm0MBZC4gbcXGwU1xNj/lccG7JuJSez7IeMustx7P6vxP5AGaXgTCKF0yWxmbwuJeEex6I+IlVATpWKeMvhe4OAXHhFBhrqeCMAL/bOs3QYOQ/Bmyyl4FOMQ+C+u5cz2f6Pn+etR9a7gmj7r1cnD/qc8VfXXkg4GA7Kg3x9kcO8U9Gwl3LXEWJbn+HCyPI4V6NTquxMZOQOrHgrMzlfHBC8tBXy7V+YuoslVufiNsh/8NavI+dbkpWLSO9YtQ+q/p9FCHGPUI7TA8/ZkklIG88Cj9+gmHFAsrjNHAag3W0LeraMSe0SuG6l21DOlLLmEvfaO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLV6vLPXFnlR3v7H57xbe0Tevo/Qq8T7yUY+w7Rf0A8=;
 b=VxE7LWpfWHJc3rG7C8AMIlB7F5tcJl3fuc8gKNfgaD9nJDXAbnXs8VIKQkAdOsSOCJAAzg473cgZN9Bqo/h2mO8pIibbxeQ8sCFDYNvPTKJUaMuyZDX09CJPovoslblkM5RFmOoL9INsW68jlpQBJDU97gJF1lZQFXGfW038ZmMERNkm4A9YS5+sPBcptLmLg/+cL25dpoAUrBid1E82U6n1O650IdTsx+WbtoIh2iZLNboQ4Mrr4d9PE9tdZwd88SOssieccMdHzDFFO1Dj0IP5W/DjnWtF4fZI9wdd/u9+aSZFxLU551FbEyDgMSUOCp80X8Bl6LNKL+846l/ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLV6vLPXFnlR3v7H57xbe0Tevo/Qq8T7yUY+w7Rf0A8=;
 b=1u0qH0hhlzl5JGsf42HqfMpuN83xAoEcoFVJA1kXiJTEhZs70h1N0tvNVmSL9lSVAB6wdkmiDUNYwaSwl5xhmUssMtmPxivvx+Ttu3n7+PbWDWTj+7xtBdNIDwKXoqMV+f9xyuXSI43W/sHBA+Ka3KrI9FR7j8FMo2lTijQ6ci8=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 16:15:11 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::df) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 16:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:15:10 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:15:09 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Date: Thu, 18 Apr 2024 16:14:17 +0000
Message-ID: <20240418161417.6091-5-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418161417.6091-1-john.allen@amd.com>
References: <20240418161417.6091-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 400efe90-0ea0-4591-c49a-08dc5fc2b8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WBYMCMOzubA3eHQmjewAZd32JH0RIZyizidih+S9ynv9P2lfXKQjDTYizuEzLa0CQIY+rhxKAt37hXjWHsGl7nmFwO0YEvCQvBDJ64XfcCUTLISTxgmCWZjzVC+5XoljaXWK/Rv8oybhYAhjKZ3N1FJWmWvJNWeU96d3yEZON0ZDLxnAAzoQxcPf9bwIyIttMQl96i5SS2/XJpX0Ec1wYYLZurcMN1ajugXJq9oufuzEgygkoS4w6PKQnsD6h5vX9RMhclSJ+DGA+lceQS7oqtF/gvT/0J1CRjH4ixz8o0cIEWqbL0NxkVjbeB9SF9boBSkmA+PPf2ZSc0/4Yd0psK/a4xNOYmsCocQjpD1sNZ2ResNP7EWmuTyh3LVTgot67nURhn5WqPJ58NBNxSCY5KWkHe0RLLxX/dDn9A00KsKc6Opb7DmjJJKMZG+NKVwBzq+Ydw0vI+SWCS+tuYk0FdAZZktfq204Ml/xUE6jz5X1Lt5+Wu8W4pfqXqn9uW4lFzuINqZ3p6V2cqmuFGS+tIcAHh7OdiIbMxK7qODvNUj8lEukcRiFmnxsUHobk0WPFSb1+MTRFqGf2zN2pgdZRVhfn9TqN1FRKFAqYVUBQ/GQ3aLfrsvjqhHupFB0kwWWU+jgGXDDgaNZAoktSyFpbrtGzwQZPVMmonV3lofFMgxVYsY9rPRTqIl+XWoEFq9GWNxS6ycq4eSKb2mVZzX8X1VH1QTMpzz9my7+FVhJlYZ48xXPtqU542cdBHpTDw99
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:15:10.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400efe90-0ea0-4591-c49a-08dc5fc2b8ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885

Unlike with previous Data Fabric versions, with Data Fabric 4.5
non-power-of-2 denormalization, there are bits of the system physical
address that can't be fully reconstructed from the normalized address.

To determine the proper combination of missing system physical address
bits, iterate through each possible combination of these bits, normalize
the resulting system physical address, and compare to the original
address that is being translated. If the addresses match, then the
correct permutation of bits has been found.

Signed-off-by: John Allen <john.allen@amd.com
---
v2:
  - Move map validation to patch 3/4.
v3:
  - Change return value of get_logical_coh_st_fabric_id_for_current_spa
    to u16.
  - Initialize variables where defined in normalize_addr_df4p5_np2.
  - check_logical_coh_st_fabric_id:
    - Rename to match_logical_coh_st_fabric_id.
    - Shorten local variable name.
    - Simplify return logic.
  - check_norm_addr:
    - Rename to match_norm_addr.
    - Shorten local variable name and reuse single variable for multiple
      uses.
    - Simplify return logic.
---
 drivers/ras/amd/atl/denormalize.c | 523 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  40 +++
 drivers/ras/amd/atl/map.c         |  20 ++
 3 files changed, 583 insertions(+)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index e279224288d6..5db85116a167 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -448,6 +448,110 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 	return (phys_fabric_id & df_cfg.node_id_mask) | log_fabric_id;
 }
 
+static u16 get_logical_coh_st_fabric_id_for_current_spa(struct addr_ctx *ctx,
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
+	if (cs_id > 0xffff) {
+		atl_debug(ctx, "Translation error: Resulting cs_id larger than u16\n");
+		return 0;
+	}
+
+	return cs_id;
+}
+
 static int denorm_addr_common(struct addr_ctx *ctx)
 {
 	u64 denorm_addr;
@@ -699,6 +803,412 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
+				    u64 addr)
+{
+	u64 temp_addr_a = 0, temp_addr_b = 0;
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
+static bool match_logical_coh_st_fabric_id(struct addr_ctx *ctx,
+					   struct df4p5_denorm_ctx *denorm_ctx)
+{
+	/*
+	 * The logical CS fabric ID of the permutation must be calculated from the
+	 * current SPA with the base and with the MMIO hole.
+	 */
+	u16 id = get_logical_coh_st_fabric_id_for_current_spa(ctx, denorm_ctx);
+
+	atl_debug(ctx, "Checking calculated logical coherent station fabric id:\n");
+	atl_debug(ctx, "  calculated fabric id         = 0x%x\n", id);
+	atl_debug(ctx, "  expected fabric id           = 0x%x\n", denorm_ctx->coh_st_fabric_id);
+
+	return denorm_ctx->coh_st_fabric_id == id;
+}
+
+static bool match_norm_addr(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	u64 addr = remove_base_and_hole(ctx, denorm_ctx->current_spa);
+
+	/*
+	 * The normalized address must be calculated with the current SPA without
+	 * the base and without the MMIO hole.
+	 */
+	addr = normalize_addr_df4p5_np2(ctx, denorm_ctx, addr);
+
+	atl_debug(ctx, "Checking calculated normalized address:\n");
+	atl_debug(ctx, "  calculated normalized addr = 0x%016llx\n", addr);
+	atl_debug(ctx, "  expected normalized addr   = 0x%016llx\n", ctx->ret_addr);
+
+	return addr == ctx->ret_addr;
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
+		if (!match_logical_coh_st_fabric_id(ctx, denorm_ctx))
+			continue;
+
+		if (!match_norm_addr(ctx, denorm_ctx))
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
@@ -710,6 +1220,19 @@ int denormalize_address(struct addr_ctx *ctx)
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
index 05b870fcb24e..946e36c053c5 100644
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
index 94c5f665d5bc..07de50017315 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -704,6 +704,26 @@ static int validate_address_map(struct addr_ctx *ctx)
 			goto out;
 		break;
 
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets != 1 || !map_bits_valid(ctx, 8, 0, 1, 1))
+			goto out;
+		break;
+
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
+			goto out;
+		break;
+
 	case MI3_HASH_8CHAN:
 	case MI3_HASH_16CHAN:
 	case MI3_HASH_32CHAN:
-- 
2.34.1


