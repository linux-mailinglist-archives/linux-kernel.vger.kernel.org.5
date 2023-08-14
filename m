Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63C77B0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjHNFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHNFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F410FE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3SKm8J2qicHbpLtj48Zool8/lFOJq4O9B1SOuknzBzeO0jQuXXekDp13INmlOTDQsOyqjsRkYzR/KMCpDkm63RepF1WuHPgVJ/Z+4QMIF6mjKiroeRFWkJPNgK8ljLBG7aHRCvOrCsnWgAdZPL11Oc9n0pt+K1T/xf5OD+i0vVjTWes01fF4CDTOtse3n8P4Y0xN283gbMKiMt4IT8phhbswUGphzwLTUbpnk4T8YvCknwbZ+FEGVfUORzeF6aAiXJSjD7ShGRu/QB2CzkjdsKU2XJ5ZbymhEwkPWEOtj9g77NmtLnteT5Y2PPe82UasiG9BqPMCDOD2DBH8Y+1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo1Evqk/mz2ev36gdunzlVNfClz3K9jqaUfvzUPSVMY=;
 b=IBmlZoin6IaGp8YWT+m6pc+fBKaw0zZiQr6Opbv6TXskaMTloi90bYIG7qCwadMZOVmOtfGQCL9oaTCOiI/K7bFw29oErYk1fcaxsg85QW8KKwtkMnM+2aOgj0SF92fG0QST7fuwY1egjd/keRXFwdJTuveRYi/pLiis0y09hNdUcFWSyXL04kIkd1zydQDT/hObWlrivH3McmyENIefO3Hr7CHLU6v17Lrt6iuuAP50GcijCsS/oYVp9nujwT2sFJ2hJQf7PjrHgxt6zXBmczVmluyRTndmchNHlGQ7qb2ypuUeXjPIoqYC+RSLdEy7ph7wZuqmV6E3MipIFDgG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo1Evqk/mz2ev36gdunzlVNfClz3K9jqaUfvzUPSVMY=;
 b=xxl8YfAWZQ1+5I2S7+H6uSJl0S6f0Zy4Wnx+3/FLfcj5yUmn0uG/0KENcp03Gvev8EMGNXdW24cqiYCLzTgBikbQu707dmKUuWzRsbZf6NLIqaDMZOEpyE2QfnXBzUHk2RtOWiJKLpcTOwIbeZlmcHbQgL/X3aYyD4e7vNzDt04=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:54:01 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b1) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:54:00 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:53:55 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 08/14] x86/mm: Add generic guest initialization hook
Date:   Mon, 14 Aug 2023 11:22:16 +0530
Message-ID: <20230814055222.1056404-9-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
References: <20230814055222.1056404-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a76c81a-c123-42e3-ea14-08db9c8adb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfoFctfdgLd6ogQL3QXjKWJiVFEzMjtLtV2IES6vslnkBy5Z18G5zTcA2HYp181ecN//znBRYdpxjrz4vaBh16XdOdX62fyd2G80dH4aNp6RfPNzDnjOEMK9xRCIlPCnR/CUzXgNIZqGESRNmt3EkHDF59rheXTYGsNMxug80tUC0/IZqojzHhKahePG2PX2J7G5Uldo5/rBLUJ8Cxg72NwGDWesT/jyRFHk5Euxctl7OLrgmmtN/dWeNwKatcqYTGlBSGFl25vOHHeMr1PP0SznABB+KmYD8KugaothX8J6/xs4y7FnmTYuHobk73yjD8kg0U+YNR+L6eSb0TwIsYd+AmC4SWlCjFiVhux7TnwIkYC9/KU2iW94eFpF90fXWn8zgoRxqC2fakrkdGxcRGBl5QUgA5hwM1MXxRQnjtbZ8VNtafK9XPMlYZJH1MFdXu2BR2GYRHAY2F1frjenCEl0HGAeuncrd6TnTKCnbe/vZsw2AszlApyMwA7CNlmbm4FcrVjAtWmGJUJmdegIqDzLD4Ap6Bo8s4er7eK++bUtNqosJDJO1hr81AAvujUSBt1DvjZvwt78lhI5yRXunydlysMM1gS0hIm3/CLoVnPZvRLeCV3FGwx1Y6++9aQUecXYHhkD8gqx5cEUcXxEx9OSr+R8fPYfmXBeiGYagDum9oapYnIJS+P7xlmpCsQpO5sBMGADpi49d1PVGWf+hmWcg1/pruQQZJaleiTgBA5eX0NxjFUpp66mNDWeZGr/RzCYljH8Gv6KlPTVvzrxfyagO7egjQrDUahB1jxX2oU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(1076003)(41300700001)(336012)(8936002)(70206006)(70586007)(8676002)(316002)(36860700001)(2616005)(47076005)(83380400001)(426003)(6666004)(7696005)(81166007)(40460700003)(478600001)(40480700001)(110136005)(54906003)(36756003)(4326008)(82740400003)(356005)(5660300002)(2906002)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:00.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a76c81a-c123-42e3-ea14-08db9c8adb75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic enc_init guest hook for performing any type of
initialization that is vendor specific.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 2 ++
 arch/x86/mm/mem_encrypt.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6..5bca02769074 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -148,12 +148,14 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_init			Prepare and initialize encryption features
  */
 struct x86_guest {
 	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_init)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa2f1bf..451e0f39d053 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -135,6 +135,7 @@ static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
+static void enc_init_noop(void) { }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
@@ -157,6 +158,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_init		   = enc_init_noop,
 	},
 };
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14e185f..01abecc9a774 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -84,5 +84,8 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
+	if (x86_platform.guest.enc_init)
+		x86_platform.guest.enc_init();
+
 	print_mem_encrypt_feature_info();
 }
-- 
2.34.1

