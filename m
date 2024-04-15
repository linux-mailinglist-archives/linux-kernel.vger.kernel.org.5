Return-Path: <linux-kernel+bounces-145913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B488A5CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2803C1F23C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49315699C;
	Mon, 15 Apr 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3JbSPilj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458315698B;
	Mon, 15 Apr 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215368; cv=fail; b=VVkGYWFut7GZPqtHO3xYCTzegbIhl9Xi5JpW3+0Gw2QbR1RlcJRQUzVecCCvGNqbwisZr4eICs36QEN5M8usuZ2mQ8WahP9BjFc+CEHU0K7bVxR88ROv0eICy75Tqk7rnBp+wVkapfy0jm4T0snApzFtKuyklMNGBzBS4k6r00Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215368; c=relaxed/simple;
	bh=2K2AmmyTVkHC4AykTPxvsdHKDHZ9FjqTwQLGyEwg7+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLv7aFmEEPWfIyIaDReaSkQIWXtMlwRefsbnZ/xy95AB7ucXivsF+bMtGcLp0CRcPZvAslJe7E4LrA28GZ3GiJXAHNrI+OmpC9POq2jTpoWEKXyNwc6WAMCnWxnybOqAoKK5Q6ey8sOCR4uolI4VY/5kgYRjF34l/aUe8JssyTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3JbSPilj; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au3pD5Kcd37cuWgwEyU+8Azv0g8J/vcWJtuq5cDerCG5BvgggRM9FZbW891GGWEkkW0t+anypH6TLjF1CqEJS2zoMCmliVgyUvrbd/Akw/FBzX+WNMmLe73N9pHMRFPkPTy9QBQCmaj8nMvtHuzqxv45YwrsfNVFb/3hY2N5Vy7TDEJgQbJDwQJ/Bymn9sK1q2dL6HkOSTmf1Psm64FX0wp0jjDpnOlacUkzoYffC8H0hI7Fy1Tin9IF+0mVrLutUDxGSJoEgWXt1oXcHxmFT4gBHljnNhq/N7yfT5qSxA2JJKv6mapbjfI98ZmoZO5YIvjuuRaFB4oLgEopnkQdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGQkQEH1v2GAmHaq11hV0nU3FnsusjMoiNd7EkvZ5H8=;
 b=lyL7Yz/MAmr9Shild28vFZ9DNPmtZJpgfZJyeGoRjNq7tiSUO/HGzQuqQ8fHpulr6dQUjAPDWrMyRAzkAyE0S0OMne8GvbIl7rIIIsOuykoA36SHHdy+MXIVcQ335YjxMYpO1xwkOwyLiisSk3B4RDwt5jTBwD1g0wqreJaVyj9DpEZKgJBGcgCvWEC1ciDYAeQ5R4iU+wCWXgzsDnQzfEUmgU2nzvEi57olNOWmN+BMF54EXabPaOgEGEPz0pEjcOl2tqOIqBMuE2pgpn3SvVttqqxYO7iRLMU3A4BBC+cHisrGTQ33StRJjMf8Td0vChD/Zm8XuxFgafE+KN+uRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGQkQEH1v2GAmHaq11hV0nU3FnsusjMoiNd7EkvZ5H8=;
 b=3JbSPilj+MxP7ZwXNMjA3n1UVQoqA8+Kk2REIjVEePEMM09FbA051c3aCoX3cuAvDjZlunauxlFMjfdDPTvNkRzzauCIA9nqWWT5yP1GOhHrSX51X2LQjWY78yZqvWACBjOHCQ7BsVqJ8VCk+WCSUx0PVOHiv9n/AK6cAslFNig=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 21:09:19 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::7d) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 21:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 21:09:19 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 16:09:19 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <bp@alien8.de>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] x86/e820: Expose API to update e820 kexec and firmware tables externally.
Date: Mon, 15 Apr 2024 21:09:10 +0000
Message-ID: <511fcdca720d26a977a427bd21c5f2d668313f65.1713212104.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713212104.git.ashish.kalra@amd.com>
References: <cover.1713212104.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d2d407-f1e1-4ba0-5340-08dc5d90511d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7P9CQ0LBPAD0vLLsRDlTQ6pmVHkb0w1N/JnCEK/6X0f+EK6afoVrbImuoqmSZsoeZASqZG861+vqilE4LUmkAQThTs2c4IzUa0uBgQR52pNECNkeHdQ+ZSq14n+HpI9VCqiNUAgZOWZzpIiWKIJptsljqRgbKNRplZj10Yw90DUKTDr2WjoSGFJY6A7+d5Vvss9FpmeLj671mCARDloIWPhEBHcr9tkHbhUEGf8cunSXfcJ/OSSpGR4LgkvwOfEoG5iT2JsXCKakPDzRB1JCY0tLvWTbM+4zmElrfa80dv7/Qsy/Wd3uiCaPJaPRPirlAZd+u3ee4O0c9zernIu1DMy4uk+oRoFktrRbbLF+rupEUJjIRZKtmiE2CNSZngjg8PotmTslZ2spV9bHlNOXcT9NKHNfTEDdM6leQcV42aYbRF/JN4jRu5ksRvdRx53eaLvjLiPmsDRwB8S4H1Ed2ou/Ag3IngMZwQ0tCYVJs5/jo+YwgzIs0YqnxK1UXRxuV45nq16No7nFwwHL/BAy3ZuKxERei7siGGrJ35UzKJs3Ren0NEEiDIPfkGRQZV7fcwFi/olHz8YVHoGle7imDnWULE7qA2PdqvjA7aNI+ZsLF9197BJCmioDt1mAUzHF8AljrYOz6gCJsSDC/yvPJcrb8fFLzT1Fh9zcjU8+KY43W86h0uYY0fysgW61NHCdjd3MnYcBFtJx+Oaf7YOkD+7F/iv+rfSL1+Gk97F3BZIM4kIrcrW+P+M09BeLmU9A
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:09:19.6849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2d407-f1e1-4ba0-5340-08dc5d90511d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902

From: Ashish Kalra <ashish.kalra@amd.com>

Export the API interfaces to update the e820_table_kexec and
e820_table_firmware.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/e820/api.h | 3 +++
 arch/x86/kernel/e820.c          | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..09fe1ddcdf2b 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -18,6 +18,9 @@ extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 
+extern u64 e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type);
+extern u64 e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+
 extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
 extern void e820__update_table_print(void);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..c59d1bbbe3f2 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -532,7 +532,12 @@ u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
+}
+
+u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
 {
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
-- 
2.34.1


