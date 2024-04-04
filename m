Return-Path: <linux-kernel+bounces-131698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE9898ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA89281EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49406132807;
	Thu,  4 Apr 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="si5MsP0I"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA412D201;
	Thu,  4 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243674; cv=fail; b=Ffm4HARUoSDZ+gbZvbI2vXR17mNY4RbkpqrwwT/F7ROJCUyz0n4uQRFGWkuqjUNqkUJWQdAUontw4EYEI/HQTGbna3sOPN3vkDHOtFrr+1z1cpHebXfRMaJ7OMnKOlrklDfEWbfjvidrGf+Fprzc0+rdi9d8I6WJI0hrJ3DmXJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243674; c=relaxed/simple;
	bh=EWkuiLxWnzqx+F3Nsyigrz/mhV6d8h3yPRx5MWlM7oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3VzeLILVQKB2Uud73U/nAnIFZR6LhySLH4GtPucbzm/NAa2CwF6Qt0sDX9mLwzVCQ+dkNtt4dNwtPM5bpoh332nS1IIxBzvBZeEk9y+I8F6MI23+JJ4L7q+egSlzab83cn1vS+XetB9AdCqZIrFaxzwDI7GqFK/8kJe5myVoRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=si5MsP0I; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdQe8obnkXqf8ODVd5yDFMJZA5xThROSrOmGGWxnJYCKHSWPQCGD2Ocd4jq5f+ECmftNf/4B2QV72RyE89jygGkh/weuLL3Rw9MbIi7E6/7wu4XG3oI33f17PXgJ/qfe6IvUzvCbkr7Gg7XemVu/qqR5MtAFFNrRbZRxPXhvyNgGqQ1Jlx0Isg27jn82+CUEnbXeYJ5BafTs+PwhFNuE5dPEAxTRVg9nfIes4EaxkvuJOwlbsMFuWNEQhrF+3c7ZwcIjO1b8nIS5vjkkaUinssLzKRKBZqiEA892Azr0W0m+8g6kx+UY/TrN+oP6F42+lDXVw+TeJWOGTC9WTD0gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ash9xkgCW0yMASADP6XU3W6rdbwMTO2LLisUz/Fo/M4=;
 b=YkYXhhQax5BSgY/lcPgAf42+5PsKjRLnJUkr+D3c0pSLZn+ZFCwUavBpLR8sB/J+rWNwQN8b9QRoL5lX7tpAx0EgtOO3dFMXX2WakQl4xoo3i3pFyHXagABGRsL+NZRR32XOLYnnCaKBUlAZN1y9BokqBTo33ZJqHLBnX38OumKXDQtJ/xA9AO2KUfVInPXoeq/1dTkN+j9wsJnm9Pb2d8AF3tPPd5JlwlprB5goXqD6pydxGE4bevdFAuEknzDWemalQsgM0S0VzjwgMaWZ2eTel4xjkGVa7fxBZTw6ZG+FpIgqGwdPg+1mb4lxg4PBbMz/5kt3NChvbUwgsmnW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ash9xkgCW0yMASADP6XU3W6rdbwMTO2LLisUz/Fo/M4=;
 b=si5MsP0IH6DtBrjWN2P4iXQECNUVpVR8C7jmpfJ2X62WbxsFQmviIQgX0x5fFRAkgTmbQX2Kd98coLY1Ii0LBjRo2ht90OS6Vsq2AA2AG3PqbSPhcmEgzv6L7wSYFdlmI1DssOuINmMfHK34yGGm26+jmHvsVvaDQ8bOakOzoBY=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:29 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:29 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Thu, 4 Apr 2024 10:13:59 -0500
Message-ID: <20240404151359.47970-17-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaa0e43-0c58-47c5-a8b5-08dc54b9ec7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uOQmzPgFdrKky2fQlW7VbcoRBEIO+Cvb2IX1PHO4v6BeaSi6Ej7K5dBOEBmQ24OCwJFZBzVTwWVEzJKYodx1EkiojT/fD9akv/aWQA2pD65inB47gxyVfM1FC+vDJShmgZ2jTEdC+8VXJ7v1SB7cav0MGEn13bdG09EQgc8aCWXN41/NmyW7gCfeNj+qsvk4dZiDfEXZFihRIUCUZyeh/g01/LPtukg8rBbZZYmY/UZALatxVD/n2nklkTOO9DZFpAw0K4AMtYIjecCEhBY3P3hKL1h37FQoUhEZV6Oqt3xDu3r5Uda08QM/bYFMytlfuGz2es0/1K85Q+Nahpcx1iYLshFvZZXeA4yPcOL+L56T+ry2Kq4RYTZ8JrATKfbjotrp+4Th1833UOxiH6JJ5B8jDtwV4ZHhlDtU7mblqQuSVvSZDBlJKXWf2KWIFNXgg3eo7oBYc//k4wZNrQnrsBI9vHrom0KV8uvry0b2l3hLwyqUO/OJEJk68+GiELQ2FPSaPUZjU/SCLe3F1/RPLMLYLfP5zk+wv6XsuIJeclZPLW9KdLQ/3OQ954Cx8wUbxVWryUWnn3Eing+2a6+pr/Re/41T1Nk/QldJqR1L5Qs3DaarJ2V8ZAIyf+NfQo8de0138Line6M93xk+3GhEtTAMwmieBbCb82hQ0uk+vrsIm5Mx+IFj818aM2LZB1rUlzEkmp0eRrw0irzkUpMzaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:29.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa0e43-0c58-47c5-a8b5-08dc54b9ec7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Print the FRU Text string, if available, when decoding an MCA error.

Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
error information and save the value of the MSR. The very value can then be
exported through tracepoint for userspace tools like rasdaemon to print FRU
Text, if available.

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-21-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a701290f80a1..2a8997d7ba4d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -59,6 +59,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 
 /*
  * Note that the full MCACOD field of IA32_MCi_STATUS MSR is
@@ -195,6 +196,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;
 			u64 synd2;
+			u64 config;
 		} amd;
 	} vi;
 };
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 43622241c379..a9c28614530b 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -154,6 +154,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vi.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index aa27729f7899..a4d09dda5fae 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -207,6 +207,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vi.amd.config)
+			pr_cont("CONFIG %llx ", err->vi.amd.config);
 	}
 
 	pr_cont("\n");
@@ -679,6 +681,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vi.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 32bf4cc564a3..f68b3d1b558e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vi.amd.config;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vi.amd.synd1, err->vi.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				memset(frutext, 0, sizeof(frutext));
+				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vi.amd.synd1, err->vi.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.34.1


