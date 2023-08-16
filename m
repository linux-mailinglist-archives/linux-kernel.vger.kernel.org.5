Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4577D860
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbjHPCWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241249AbjHPCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:21:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670AC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOZe/z2TfUveuZ6/ELniy6v101up4wZRT9olIcFzRs69D/rDIxXGvjqDWg1DVDGyvZpAG7NC7TowTTjpWZ8OB286LITfaDCMmB1lAKedyxxKBX02KRcqOmnGkFGFIXkwx4z3Kb+0Z4va1gixfLXz4cC7bIQxkOpMECp+LsLalImZWwoSd2xGMRnWV7HIVEqtbjbdZDgtq6upB/C0mnDC6CWT9f8E5up1rfmFABdyI8GpaSdCCqZQaR8GFovGZwMgt6Wb7ZmiDCfgFoZmiy0aBNqeX6rqruMvAIOTCqWb2lReVeAHUBt6WlNtiIFekOLaza5kvShGFEFkAUvZv2jSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5bKsIG6HKAlts7WYlMgYPAZAqFSO5aQlJrnuMQNXsw=;
 b=JVkTv3FpTvFmmQXdCXEylGm6cvVHsj+6TUBH+a+ghj6bB2rdGLtxHdmG+TTsJ/WlJ4uSYL1JK8gqTEzJPJEzTB5/A1dM7aOmxknq/8tEf7hFogwll4cpHY8tekrfnHIyMytQqdVxlIVzUA1PiRYlorczkPOqf01r5B1lHhi/svo/KUtLArDvjWPmTCFqjaLEuJBB6LVW3k/JI3J1PgpwFOLplgYYAKOTCETAJJDdekbHxuXs0sFs3xMork9Vyz/DhwTYxZkwGdnkf8QBWGAL+tIm4dJXjZ3fv5SpuMq8/C26KhsMvFzpOStSLySarNWadu5urWWX1Sd5FjPSVXfIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5bKsIG6HKAlts7WYlMgYPAZAqFSO5aQlJrnuMQNXsw=;
 b=4nYAULf743vCWkOnp7Qjy3gHnOqCPjIZg+qwmrZst1XhhrDqG30oDerfkqX9nY8+xEfAS64GyOPGciTe6z6LV56rNUtQxsTLQagV+2KWXLg7ghuSHcJ7EgBrX4zYutl1eCD0RQRrAvXriEKaMa0P+uMJ3g/OAX50m8WjZKtzeXQ=
Received: from SA0PR11CA0201.namprd11.prod.outlook.com (2603:10b6:806:1bc::26)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 02:21:46 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b5) by SA0PR11CA0201.outlook.office365.com
 (2603:10b6:806:1bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 02:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 02:21:46 +0000
Received: from aiemdeew.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 21:21:42 -0500
From:   Alexey Kardashevskiy <aik@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Alexey Kardashevskiy" <aik@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH kernel v5] x86/sev: Do not handle #VC for DR7 read/write
Date:   Wed, 16 Aug 2023 12:21:22 +1000
Message-ID: <20230816022122.981998-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 87504c29-2d39-4f42-9cec-08db9dff8a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usQMdbpvAnw99f3eiWbRcaefF84rOEaADSfKAecB8L+Js0QNUW0ZqP1C/tLLIxswCsjtoiFz6eAc4qtrYotPyPL6qo5M+gZNvvLMJmfxvbAThZGQWmZJ3mbUUsJVW36lQi4W2T8SS3Ab9gMEY4vrAmJ0LkA1t9Iu7161+UEomcbj4UFUAWb4CqPFOnfbrgbTmh9ZiM3ZTUPURk4EyIUIfVqCJEt78DDLeny9oSQqo0rE18D+hWpmgy3woBLNUbvkdi27Bf9/BKAyUKoBoMKe+9Sy9YgXboYKjR5Mpa1jYrvUOgGWiK3WshwvfolWjuXo6fK4ySbVbHK0FZz425GaSndi2VS5iZGVEQ38f5d4O6XCU90Qe3hBwOW/wCm4w4Gplxpx3v67sQiViku+21v6KChNqEzj8u8K2NeCHShQP/TNW0spEbnC/6/SOrEbaWhwfSNAn3AeaLjlDRx2AbVqJhwyKqIoLism/h0EIrjYH4qUbLZKvFFBhZKEq/ICfsqUuVNLhl9FHi37RIBRnySJoLypZqkJh+gek9vTJtc5EIctbBexLPXVCGs/79UeB0VzOKH5ZYsOtafrWuOtXxI9kXJiT+jd/clkHNQRFvCoIqCZ5d0DJVecLnrsxktoCT8UzBZOGVPkfj9tpvHnWWNQ4lDnAPxw31ZKBhOdhU6Qy75+sUkV7Hsd3pdTUXY0alYqEf8QaYl3ZhtaKK8yfV6j4hToIuGmxQ26ElX6XoyFFQh6FBfOWkGn/2DcHwBcHhgcpfNui5A5qO6bakJZyLFBk/+eQzcJrkl2/R8jD9LrxMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(16526019)(966005)(4326008)(36756003)(316002)(2906002)(6916009)(336012)(8676002)(82740400003)(26005)(36860700001)(47076005)(81166007)(83380400001)(426003)(478600001)(1076003)(40460700003)(2616005)(356005)(6666004)(40480700001)(5660300002)(7696005)(54906003)(8936002)(41300700001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 02:21:46.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87504c29-2d39-4f42-9cec-08db9dff8a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MSR_AMD64_SEV_DEBUG_SWAP enabled, the guest is not expected to
receive a #VC for reads or writes of DR7.

Update the SNP_FEATURES_PRESENT mask with MSR_AMD64_SNP_DEBUG_SWAP so
an SNP guest doesn't gracefully terminate during SNP feature negotiation
if MSR_AMD64_SEV_DEBUG_SWAP is enabled.

Since a guest is not expected to receive a #VC on DR7 accesses when
MSR_AMD64_SEV_DEBUG_SWAP is enabled, return an error from the #VC
handler in this situation.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
---

The KVM part of DebugSwap went to kvm-x86 tree:
https://lore.kernel.org/all/169058576410.1024559.1052772292093755719.b4-ty@google.com/
but it is been suggested that this one can go via TIP:
https://lore.kernel.org/all/ZGv+Y60qvbjeTY57@google.com/
I am trying to bribe now by reviewing patches (internally), does this
work? :) Thanks,


---
Changes:
v5:
* rebased on latest TIP

v4:
* rebased on top of SNP feature negotiation

v2:
* use new bit definition
---
 arch/x86/boot/compressed/sev.c | 2 +-
 arch/x86/kernel/sev.c          | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 199155b8af3b..dc8c876fbd8f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -365,7 +365,7 @@ static void enforce_vmpl0(void)
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
-#define SNP_FEATURES_PRESENT (0)
+#define SNP_FEATURES_PRESENT	MSR_AMD64_SNP_DEBUG_SWAP
 
 u64 snp_get_unsupported_features(u64 status)
 {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a2b50ae61b72..2787826d9f60 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1575,6 +1575,9 @@ static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
 	long val, *reg = vc_insn_get_rm(ctxt);
 	enum es_result ret;
 
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
 	if (!reg)
 		return ES_DECODE_FAILED;
 
@@ -1612,6 +1615,9 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
 	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
 	long *reg = vc_insn_get_rm(ctxt);
 
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
 	if (!reg)
 		return ES_DECODE_FAILED;
 
-- 
2.41.0

