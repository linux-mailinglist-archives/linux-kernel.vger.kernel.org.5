Return-Path: <linux-kernel+bounces-103581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D187C162
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7981F21E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B26745EF;
	Thu, 14 Mar 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WWXPhIoS"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2F74421;
	Thu, 14 Mar 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434182; cv=fail; b=iN+Qd1/pwXAM9IIrDER7Et46ItLW7zT6R7A9vL7CGv/gRJ3qTLP0am8aCLAPL+RSHM6a4zwe+5yani3+m11K7KktPTVU+XnLjbwkYfBbDQBKfxpj3AW5aRaxFhivMY2zzZjApIUf0AkpKFlYyX2UjHq0/s6eRPXBinpHyG9FeJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434182; c=relaxed/simple;
	bh=dq2OsqdLiRpUwMnygJA1SWm2iRncEMEqBz28lL+5G0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoasb13lMJLn96fqLyum2opSU+ZRDHzxCdTxpGpnpsgErg+ZPOGnbWt3kd+0/8XHnnAHyJttQgyIf5TLo+RdfmCwGNTrTjXAfFJNYZpOOrX4SUAmpE5F5Hy/j9rOVqjWPCt20Fo2U/7Gx6NIlGwhvYXrAACnoamYsjUHtkt4pLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WWXPhIoS; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrCtftqXG4hxmqjMSkH8G/jiwBZa+ObJBdOjLvTFLr9JW34PDAJaKFj6dXfmdlixgZ1FebxEWGZqXoSFsK3E+MH0bD5WlxemcsypVEvTCFrKvMw2HAVYGTwbNDdyX0acGhjY2Xbcq5AEw0cHSiqSgbtP7xEbyeHz5TjYRhMHtrazkU7BUSBxQBY9j/OpBRvab89b9jLCIhzAvcoBEtgRntdZCrNKtYsz/rcxVJ9AqW/ArSRZ33nRtGszvN8zRawq2EHY1FYLbcXtH9X9w8hLh6UKUZsvC5aCEhoTMY9p5lAz+eSwrg3tPhkus0vRb9nuQJqqTFCOaCojqObRmTkzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBqNmbsczIpnV/KRwLcTHsc286ka5D64xhtZPEA1A6A=;
 b=A31mrDEmK/GC8f5naP+3UcRWX7jVfjT2areb8zJVElUmz9n1Mq7vVrxRnw/S3+qNq4kOjLpu6331pmA9HFqLPVUSyK6yB3WY3GrRKY/vDdibXGmVEpOxoKww3RpWy59LJDx3NReTluRKRXjeh7do4SfNLVCDagh8FVEMbRskI9zrPNpMXQVvBqb3X2cbwf3/APtzkQWVmycugM+Br3KYcYBw3FUfLOvTCFMVGrg/Vj7cu3IOuPcRdPQjV5rJmzvivhjJlCVlmv5z0wcLx1mn/7qHya322PdmCpJvtiraCFgRmfcvmSow7qOnb6hof+L7Ug4gG20cUidpNl5abT4aaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBqNmbsczIpnV/KRwLcTHsc286ka5D64xhtZPEA1A6A=;
 b=WWXPhIoSPS+RpPWTz4MyDOMOuw6Jjg+FPdHL9IK5eowcOwv1ad8RJe47wf6xbfmp8rWxTvK+fwhZTNdylFLhKAlQZK2n4UWfKnAW62jIOOQ1hOplym+sA+nI5l8BB+gNd71urLCCVVjH0KlElmCaTlccfSPrQtz9hxgN9MsUKtk=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 16:36:18 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c2) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Thu, 14 Mar 2024 16:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:36:17 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:36:15 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<yazen.ghannam@amd.com>, <muralidhara.mk@amd.com>, John Allen
	<john.allen@amd.com>
Subject: [PATCH 3/4] RAS: ATL: Add map_bits_valid to header
Date: Thu, 14 Mar 2024 16:35:26 +0000
Message-ID: <20240314163527.63321-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: efd39d18-dd5f-44a2-7cec-08dc4444df8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v1trHWqb9/X7v9GeFKKzb8Rr3o2ZIVT+utxIt0tqpgGPhJg9/VQZrnClcSV5JJQrCWb5WUwW8vBdatUtx8lELKSZpsbXhgjzemVs3QwrwKQjfCevSqvctAriIjR8PJbiOHScpCyBy8PgW6C45xLbvk0hRbtXJ/4EyuH6Pk+12QETWDcfSbeb4rH4gdtf8Ppyg//Gzs02X/26tArvwMr7gQnIgOEDcYGoQnHsUpuPzbdv7lp6NohuI5IWizQ4ML5MtVQp+SqBE0ieGpASar+1skMWsHcj+4L1zPUvXu9I9lUNSeV85o5s+GrMw00dZBt+KB2DD89bdPFvalStlzApAGhgJY0ZvHNZ+QaXAZNFNAXm6FGBzLaFbxUF2FtnZ31WCqbc11c8+L1Sp8biHf9s7M7k5pb4VVqiGP0ylRX3aNuiqGDQSYeYFX0XaXanbdW/Nvg2VhzE7WiAK8Ms+3ljhMEboTh0gTbIh03uA6GlQzQUcFfB3OqzgzDlUoQJTTl+vZ/oxPnzq+823SU6FIVK/Y+IZJsoTxStAtGtGudLHqmZVu41F1lQ4eof0roldqvLutqkMbY/WVA8n+l+6jLBW9CnAl4kmtOZH6JlHTuDWUl6TXxTtMySlVcD+xWvgKT3CcrlSd9Pev21S/txMn51v+mfuAPKiAxncgJCMMmVjnVnWc9uKGiHX9hU9ahrlTLeMMRuyKSX2vLYiuARWeXVIzT0aBN/MG39w/JiSSGpJcZazoy/dmJycWoD1hyaa/vN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:36:17.8421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd39d18-dd5f-44a2-7cec-08dc4444df8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

Make map_bits_valid available in the AMD ATL internal header as the
function can be used in other parts of the library.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/ras/amd/atl/dehash.c   | 2 +-
 drivers/ras/amd/atl/internal.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 4ea46262c4f5..a20cf615b83a 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -19,7 +19,7 @@
  * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
  * respective interleaving is disabled.
  */
-static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
+inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
 				  u8 num_intlv_dies, u8 num_intlv_sockets)
 {
 	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 05b870fcb24e..4681449321de 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -239,6 +239,9 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
+inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
+			   u8 num_intlv_dies, u8 num_intlv_sockets);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
-- 
2.34.1


