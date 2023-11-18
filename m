Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592007F029B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjKRTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8DB194;
        Sat, 18 Nov 2023 11:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd6zGZ3AqNlk+yc4lL7XBxJQ8Oel/7mXvWPrvKJjHsI1TI8+85pVRPsjIJbBwNcdS2DATTWbcp6t7iLDCqkzmPrrMRl7KY2C0qyLQMyeKo2JGwN0ACW4Jxbwf8R/u8JuMUz8zmuiKjKqh92tOIkhksBkJggYaZh48dYmJdNjGbH3IUs5Q+yDaArB9Nm6cuQjz4rPBRAlBkmuUo8sEUE/CeTLI354wTn/YHd0W8Ba3VNC49FkLHFgtrotezVWNcHy7Pl912em3m6CMAjiY8jV0Z5UBYtbbCp5KegKNOFQsMSu+RJMX6LszYnYZsDUNKsugpHwCOuQKr8CAW3qmj2aTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GGCfqY5hSM/VquS9LM1UEwG+d9b2YdzydUitcmEDz8=;
 b=ZG3StHoWDo9EPeTAqOLlEEmjXoOluJmLO+6UbKFwEQXl5jYMeDpipJlqhXLw8O2538HNnDMpiP9JXAkRAwxG9W1IWQD9z7WQXUmbsek8y6ekCj60h+yQuEuFEyeILzR09gNiatH4UjHYSmsmyv228QlsBGSGs/mNVh3v5CrEBnwbEgm+Oax5cmydhScB4lO67EkByjjbxqXCBo9dt7tEkx/Vak9ZK9FusDxht59nWyltm9khd8GRHexeqEsWiXgdaPK5oPZ3/EzrfUqUXSHy96F5H83j+BD9iXDHtQkenlgzgYLxA2LcBpD0gPijLES4qANpFlk0qsPO7xkuxtjeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GGCfqY5hSM/VquS9LM1UEwG+d9b2YdzydUitcmEDz8=;
 b=sgEkQ8Q06hir7f/EqbcsXUYHDNADocDit6AuiMUrjSkAjAe/QcWtUtEJhxfwP6YC8K7FCfjRYTD9A+oeKOfSkpxwCSvYQeDXVnjp73kYfLtowWyyBd1uV26QVN24qzARbyXAgYf7dWNrs6dHAWnLk6XJ9s9X19pTkOAlN42YGxI=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 19:33:08 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::2a) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:08 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:02 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 05/20] x86/mce/amd: Use helper for UMC bank type check
Date:   Sat, 18 Nov 2023 13:32:33 -0600
Message-ID: <20231118193248.1296798-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 71159e73-5b23-43a9-82d0-08dbe86d3163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LodaIw+JgHauZ34G1VCGtwUxUnVInfQHj8BFeq+61Gqi9z1ShzUzyL/TGGKFuCCm1SocerGvngijy4pEx0V73sTxQqpBznFDW0K2U5Hc7omSBGpblBBAj/NMZ6Mq86SH0I9carshiEKpuoxM00qrrpmxwMFHCc6iSVlSnhCUTRf5JkOyFwku3Y5q/Y4+0ywQS8EGZnoMKhwlpvTljkZQahTHuFLg9IbTSZAlAHvaZam26USqoUIf1xSSUdysEHw5CUNo3d/VP84iITvSJb9LbEzoUU9CRcFj0s+GfA6ZsOaiL+9uJPrm6SVMIKx1ROKn2wDWYBlCEhq6PIkTkg8b5hVbuayf9X2IyAkZsUM7rb2D3JBQs95EMRbjroBJdflCK0xjH1jxuqVvXQpgfH74p5QnFBr93QQxcYSntSuVxbHUuVb7DAd2zi7tjEQhRbqCfjTiX/JnkEWAnPurFdihnG0E8mz5FBZiJDqMb5VnYgfI/fc8tm/YHsmIsb7B/IO763l8uHf9Y2Lpu0Osl9B8QQJ5/7myOk0ASJZfo5pOtlFl4A7yriDAIknF8afqfMZwnrHceKLs+s8NflVrdhNNxy3D+tTp2GQeUGLoCoKOdkDRQ+eQAUkE4YiSspBuecbip0rfj4xHSTN+AyeurZ8gzO2gf86cYUcXp8BknGFq5QYtitLmsKYQTHMqxtI9BEG73rdpqVKVZIo9sdCcZwMX96RO8ep3MAOWtXxwLalmzURThQY11XlXfrox1d8GuyRJfdTEP6WrsiuNk/tIEhwt8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(8936002)(8676002)(4326008)(6916009)(70586007)(70206006)(44832011)(316002)(54906003)(5660300002)(40480700001)(81166007)(36860700001)(15650500001)(40460700003)(2906002)(47076005)(36756003)(7696005)(6666004)(478600001)(336012)(356005)(82740400003)(426003)(86362001)(41300700001)(83380400001)(26005)(16526019)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:08.0272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71159e73-5b23-43a9-82d0-08dbe86d3163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scalable MCA systems use values in the MCA_IPID register to describe the
type of hardware for an MCA bank. This information is used when
bank-specific actions or decoding are needed. Otherwise,
microarchitectural information, like MCA_STATUS bits, should be used.

Currently, the bank type information is cached at boot time for all CPUs
and all banks. This uses more memory as the number of CPUs and MCA banks
increases. Furthermore, this causes bank-specific actions to rely on the
OS "CPU number" to look up cached values. And this can break if the CPU
number processing an error is not the same at the CPU that reported the
error.

The bank type should be determined solely on the MCA_IPID values. And
the cached information should be removed.

Define a helper function to check for a UMC bank type. This simplifies
the common case where software needs to determine if an MCA error is for
memory, and where the exact bank type is not needed.

Use bitops and rename old mask until removed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4ad49afca2db..c43b41677a3e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -60,7 +60,8 @@
  */
 #define MCI_CONFIG_MCAX		0x1
 #define MCI_IPID_MCATYPE	0xFFFF0000
-#define MCI_IPID_HWID		0xFFF
+#define MCI_IPID_HWID_OLD	0xFFF
+#define MCI_IPID_HWID		GENMASK_ULL(43, 32)
 
 /*
  * Note that the full MCACOD field of IA32_MCi_STATUS MSR is
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6cf8ed9c79be..c8fb6c24170f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -7,6 +7,7 @@
  *
  *  All MC4_MISCi registers are shared between cores on a node.
  */
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/kobject.h>
@@ -143,6 +144,12 @@ enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 }
 EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
+/* UMCs have HWID=0x96.*/
+static bool smca_umc_bank_type(u64 ipid)
+{
+	return FIELD_GET(MCI_IPID_HWID, ipid) == 0x96;
+}
+
 static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
@@ -304,7 +311,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		return;
 	}
 
-	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID,
+	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID_OLD,
 				    (high & MCI_IPID_MCATYPE) >> 16);
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
@@ -714,14 +721,10 @@ static bool legacy_mce_is_memory_error(struct mce *m)
  */
 static bool smca_mce_is_memory_error(struct mce *m)
 {
-	enum smca_bank_types bank_type;
-
 	if (XEC(m->status, 0x3f))
 		return false;
 
-	bank_type = smca_get_bank_type(m->extcpu, m->bank);
-
-	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
+	return smca_umc_bank_type(m->ipid);
 }
 
 bool amd_mce_is_memory_error(struct mce *m)
-- 
2.34.1

