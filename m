Return-Path: <linux-kernel+bounces-131695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02912898AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7089E1F2ABF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443112FB10;
	Thu,  4 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivulkDJc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B311D543;
	Thu,  4 Apr 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243672; cv=fail; b=LV4sK8Xm0kbOCV7BwTGu6SZZvKSpM2BxxEH3LWNBXvkBJ3YuWL22bJ+9kDNoYb/NcBqTkEb/NIfaKb9eZq+DK8pxD3f1mW+YNtBROxkr80ictKQo2+wqvh3J2Mv8fmNK/5d2B1oQb8FMrwsSelP8Xmr8PWSQe1tC6gP0hUtfwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243672; c=relaxed/simple;
	bh=aoSsT4Cf1q2iEcRO+7KHFuHb/jboMvczY8GloQoLSbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT5f9LVs3+GxTYdn8gPMjyXcoU69WTd0T8hM7as5PchWjuGaHFlYh7cLf15niem7+/S3nFVecAyGiaQfdtlHX7WUQeVcKtiJlpUPbbhe5BBT0sK0Gj/ePPV/uOvKlJFFxY+4c8rCIy0BZ9QsL7FO3mkumfElnOnXgd7AUM1B5Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivulkDJc; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReOVmkK1Qkuxoj2UMOez+ZQtApjAJcQQkpqn8m5TFRBcrf1Di/Acm7ajV8ePrYfCHi8O1z/P/xPXPrM54fZYuTaZfthUPMNnnx5npuOdl4XUhNJgXtsgiTA5T3egwWQdVIbt5trLhb9UaMSlv91V2PPv/69Dh/zVld++7C0zfzr+29rsvE0JLvx/eBF2XU83WPa0blruH+wcM7/nj5G7SxxeCtmHl0ydhTJDBQcnkSTz762YLiLdTzRC4nSjJZWmVb+MTAY6OdE1FTLQKrE3N9RUjyavdzsKzuwduSsVqZ6fXr56GfeLV8Ek7FRVAAxfNp5t7Pz6+26VTLklWRPaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qYZ6FFmRynp6bBjYFro/IJsfaqEsqzjLa/ktE+Hlp0=;
 b=IYVPKmPuDDrgpSO4M5tFAbZG8Na4gVJH4y6+4zfjFnK0NdgSmOljbxZIfE8Rbzw0s39zHV2F+5s9vyXyQslV2hTqbHFb0UXTj3IubkDNmCQnx9q1xiTe8aZ4Fcj0A7qk+TmKnpusLyt4apL/ilnyZb+xDW/e9I+/y5x1BjnUNl+cJVkDDSReH6enFDN5Jh9mAIjr3ika6UJ7+erGbSde79VEzv3CQo/V5Er/mjTlNbcK3D2HWmkIqTzWRF/daywAES4KLRooW255Px/4BZed9tkcKgHksJvtYLy6qr+l+xZQN3qxwGao7TL/bnoqschO5bG2wjhrzkUriU+1hRIB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qYZ6FFmRynp6bBjYFro/IJsfaqEsqzjLa/ktE+Hlp0=;
 b=ivulkDJcL58remg1XOfdtR/fRK99SrWgzfQZIkEqich/MbBbIYVViQyl+S5da/P6N9wHMnUCiFLmRwmmpG6su75mTSnciAArgsBaY5xWEeTxYNB97v70oNNyVDj3DICMwIhk/hMlegPAhhOkDNmZ0ziVRecOm8bWRsWoQ5mhRNM=
Received: from CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 15:14:24 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::5f) by CH0PR13CA0041.outlook.office365.com
 (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:23 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Date: Thu, 4 Apr 2024 10:13:50 -0500
Message-ID: <20240404151359.47970-8-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 82744762-fc75-4a85-9217-08dc54b9e978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t/AVr9K5OxuurG5j8RfhhCuGKD7vCkOO9+TYzLSg7S4Xrled7YNR+DG+4ptr6oV87AhBeenJnvHDdcdqMaZm+k013pqBgND8gaeK7Ns5K0ASWWgJxspjmBh55+AFZDeaOWV2a7GAnVvcWViRet69P334p2pjZv4049P0OL47RAfAY4i70GhLIXg89ouDQ5MZP4XI6OPutMKh8yVomfTrc5eQoHXUAvUiXX+95sBVFRb8U182fddV/vsN3rB0/9n/SSMqIUrZ4pao03Mz69B58IJsQSCJlbaTNfZj3KY/omQ1BJECm8i8ay5JyZRkimviL2EOgkyRQ331u3B204nmPvjRLRjDOP7c0t3cu7v70mSjfBT6naVLbT4LvSuDyPYqs3+xGeAbdQGBqtYCAne5vKSy6YE/oraK9mQYr8oKqak9Os/M+hMayzX3RuPktbGP5WxVArj8tthNiSki9+KmSzsDh9J0U1ED45TUVFi4T8uS7DMKswrlEgGvYeA0DkI+fpvKLmUEuZAAp1BgONfQYTwOeFnlLrWRTXCiULsXRMtuSTMHDaVL3RgF1koOBF6HGj6lEvmHWvgyzoGF81kbMXltzjjZhwLlLrSAhVAm7U+/45PY3jaG/GXJaYWrc4DmGwho/DQMvs8QQvN5WOf+CGzBtozV2JsE5rGvrE896uIoIRVnibbThsxEqQ7Do8YyilRA47peszEEcPYeLRmYjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:23.9943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82744762-fc75-4a85-9217-08dc54b9e978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

AMD systems with the SUCCOR feature can send an APIC LVT interrupt for
deferred errors. The LVT offset is 0x2 by convention, i.e. this is the
default as listed in hardware documentation.

However, the MCA registers may list a different LVT offset for this
interrupt. The kernel should honor the value from the hardware.

Simplify the enable flow by using the hardware-provided value. Any
conflicts will be caught by setup_APIC_eilvt(). Conflicts on production
systems can be handled as quirks, if needed.

Also, rename the function using a "verb-first" style.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-12-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/amd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e8e78d91082b..32628a30a5c1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -48,7 +48,6 @@
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
 #define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
 #define DEF_INT_TYPE_APIC	0x2
 #define INTR_TYPE_APIC			0x1
 
@@ -575,19 +574,9 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
+static void enable_deferred_error_interrupt(void)
 {
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
+	u32 low = 0, high = 0, def_new;
 
 	if (!mce_flags.succor)
 		return;
@@ -595,17 +584,15 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
 		return;
 
+	/*
+	 * Trust the value from hardware.
+	 * If there's a conflict, then setup_APIC_eilvt() will throw an error.
+	 */
 	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
+	if (setup_APIC_eilvt(def_new, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		return;
 
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
 
 	if (!mce_flags.smca)
 		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
@@ -771,7 +758,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	deferred_error_interrupt_enable(c);
+	enable_deferred_error_interrupt();
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
-- 
2.34.1


