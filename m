Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62279797B64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjIGSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbjIGSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:15:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBDB1A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StS5NAiom72+iqAvfEWf1mh9m5xn8ECa9lG6+Yy6VhkLxMy1wZ9DwIk8e57tn2Dy7EDSciVXVRezynSzih/XlPPn+tKDv9ndL3VTHquuqUfQd9qk8daBaGRJxV4aeHADeJEX0QChtLfyZV7zp/Z9420r5ZIDZ7p3OQD3DbAGELsSRp+xwYC2HdY9guajjyw0wGwE8MrQkyx7Xh4arw/IkkFl7en2bc0Z2t0qluEjALT91mhRNMed3RpeDZ9mS43lF6Lllg71QGAgiPEIbX977atE+qE2Q9J29qWV0K8I9hmsPj1ne8mKXVfZ5ekK3/I2pMt/D3S/UOvmgD99SdwfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA85pcrA65hW3Q0dKfmcFvfC1aWSgQeeuWFChTM927Q=;
 b=azsS0ZQ79Jzet884pnnilyC8j3J5GaTx0PJnZuaBfXfCo/BjGWjVA2VBnaFkqGkDh3a24dhAiiUZBkXIdqR/c9lvycitgju/sz8rfnaWyJ7wHwjN+pXLgxdSBw8877Apl5cK13bfzXRfzZhny1rrw47dTogJEAKPHInuZgl6dg3dJWp2IbzbbBpK6YgJLerNiY/5FS5VVTJ6aKEw+ajQmzqygt82FEI7JqYfi6fEUeSlfTH6XECjbDhCWmHs5L9GuPZlGCPURaeUMA1VO2DWz2ADOpRC3VexLWMG183NFTvD/jBKdQJxDWlpd2igU72yZA/wL9CyuGXdq+H/+k5qIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA85pcrA65hW3Q0dKfmcFvfC1aWSgQeeuWFChTM927Q=;
 b=ahNHfA1iDcVq/28PF2n0ny4j+y1H9JYSKbhdWB7Hh/3y9zuYggWOUjL8vrfnSH44ZYG0Hjn+5XTOIhyGghi4+lx11R85rPI8fQy4JybTTIYJjR65smVMrUTNN0V23oujsDUWGCdNpeJ69w6xxjxih5xPJI4Lk2gA80hFwfYvLqu5NAOqCKr3dLRyy6i5kSwmNfaFgUmkVkXOssW38KA/21zaFnBUGk6RZ9AwiZywJYQmVof/IoA5unp2Z/LNys395NwhDtVk6yzesv4ksXCKs6RPTAE1Ye4Z9jcGgz/rnBOTfVk8uH/2JTYNVOYoppUEt1xfr3gkrkoGBT/Li3WCRg==
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:15:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::5b) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Thu, 7 Sep 2023 18:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:15:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 11:15:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 11:15:00 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 11:15:00 -0700
From:   <ankita@nvidia.com>
To:     <ankita@nvidia.com>, <jgg@nvidia.com>, <maz@kernel.org>,
        <oliver.upton@linux.dev>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
        <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
        <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Date:   Thu, 7 Sep 2023 11:14:58 -0700
Message-ID: <20230907181459.18145-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907181459.18145-1-ankita@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 44698d35-ff27-4d8c-33de-08dbafce5ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ3hphooijgsM6Db9YwLKIUneXcEK8o0q8yEyT/5rrWUFJYVxORnFyGedZbtF7tn3RS61YYKjB5kT9xZfG1GCd77WQdN9yIdLrWALKCGkEW8bO0tlysad8VUutvLE4T1paWxfcZrLTJKZhMfzJxTnrKqVDkp0ItchZVMkP3h59z4pFg/Cg1zXKNiu+BxvmyZVzN29j9CG2bK3pzjmAnIPBk+ae/UHiay8hCAW3CMrv7Ro5DZo6Ur0380FAiLvvOdtaft+N9mWHs5HejwANQxFi8u/7ik6xi0yjjZft7e7qYnbjOu71JPubw2v9JFr91OVwRoKOeErldzyQteoIWVhFNph/wWoYWsjLsc08Xap/hS9pVPDodXQhtFbq4sm5S4XaNYF77x6IZ3673dlpB38STEqJDBLRQVmYqwdTxiW2Oc6KqOUXRCJLgi8W9RUloL1kcQIIFP8N8BNm11fSchbVUPyOOI95zC8TMKTVSpK3e2/sdfM4e5vHvdz2zK/wFtbRk/Jz7daqu99GWGg4VOYKPs4fg7IqBvoBv44exay1K2mQmWiw2fTtFzBv4EIc7GxfV/zJ/43kdlB5WP2ncXcwas6Po0bME47TPEgE1uRB+zG+PeWaY2ekrEHSu6IjwBlX0lizUOUo1iUoXJpXwDSDvYQGbEdy3x0VfqrkJ1gpMZUNUhGvklxPZG74T2EtSzCQ1ux6c5Jdq/qqfXINhjp3nbOG3NOm9zQaYPYtRFxwnVpT3EnZxfl+V8MONiEPQB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(478600001)(336012)(426003)(83380400001)(40460700003)(36756003)(7696005)(26005)(7636003)(356005)(2616005)(82740400003)(1076003)(36860700001)(316002)(54906003)(47076005)(8676002)(2906002)(41300700001)(8936002)(4326008)(5660300002)(86362001)(70586007)(70206006)(110136005)(2876002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:15:09.0608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44698d35-ff27-4d8c-33de-08dbafce5ed2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Agrawal <ankita@nvidia.com>

Currently KVM determines if a VMA is pointing at IO memory by checking
pfn_is_map_memory(). However, the MM already gives us a way to tell what
kind of memory it is by inspecting the VMA.

Replace pfn_is_map_memory() with a check on the VMA pgprot to determine if
the memory is IO and thus needs stage-2 device mapping.

The VMA's pgprot is tested to determine the memory type with the
following mapping:

 pgprot_noncached    MT_DEVICE_nGnRnE   device
 pgprot_writecombine MT_NORMAL_NC       device
 pgprot_device       MT_DEVICE_nGnRE    device
 pgprot_tagged       MT_NORMAL_TAGGED   RAM

This patch solves a problems where it is possible for the kernel to
have VMAs pointing at cachable memory without causing
pfn_is_map_memory() to be true, eg DAX memremap cases and CXL/pre-CXL
devices. This memory is now properly marked as cachable in KVM.

Unfortunately when FWB is not enabled, the kernel expects to naively do
cache management by flushing the memory using an address in the
kernel's map. This does not work in several of the newly allowed
cases such as dcache_clean_inval_poc(). Check whether the targeted pfn
and its mapping KVA is valid in case the FWB is absent before continuing.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  8 ++++++
 arch/arm64/kvm/hyp/pgtable.c         |  2 +-
 arch/arm64/kvm/mmu.c                 | 40 +++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d3e354bb8351..0579dbe958b9 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -430,6 +430,14 @@ u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
  */
 u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
 
+/**
+ * stage2_has_fwb() - Determine whether FWB is supported
+ * @pgt:    Page-table structure initialised by kvm_pgtable_stage2_init*()
+ *
+ * Return: True if FWB is supported.
+ */
+bool stage2_has_fwb(struct kvm_pgtable *pgt);
+
 /**
  * kvm_pgtable_stage2_pgd_size() - Helper to compute size of a stage-2 PGD
  * @vtcr:	Content of the VTCR register.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f155b8c9e98c..ccd291b6893d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -662,7 +662,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static bool stage2_has_fwb(struct kvm_pgtable *pgt)
+bool stage2_has_fwb(struct kvm_pgtable *pgt)
 {
 	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
 		return false;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 482280fe22d7..79f1caaa08a0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1391,6 +1391,15 @@ static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_MTE_ALLOWED;
 }
 
+/*
+ * Determine the memory region cacheability from VMA's pgprot. This
+ * is used to set the stage 2 PTEs.
+ */
+static unsigned long mapping_type(pgprot_t page_prot)
+{
+	return FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(page_prot));
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1490,6 +1499,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	gfn = fault_ipa >> PAGE_SHIFT;
 	mte_allowed = kvm_vma_mte_allowed(vma);
 
+	/*
+	 * Figure out the memory type based on the user va mapping properties
+	 * Only MT_DEVICE_nGnRE and MT_DEVICE_nGnRnE will be set using
+	 * pgprot_device() and pgprot_noncached() respectively.
+	 */
+	if ((mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRE) ||
+	    (mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRnE) ||
+	    (mapping_type(vma->vm_page_prot) == MT_NORMAL_NC))
+		prot |= KVM_PGTABLE_PROT_DEVICE;
+	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
+		prot |= KVM_PGTABLE_PROT_X;
+
 	/* Don't use the VMA after the unlock -- it may have vanished */
 	vma = NULL;
 
@@ -1576,10 +1597,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (exec_fault)
 		prot |= KVM_PGTABLE_PROT_X;
 
-	if (device)
-		prot |= KVM_PGTABLE_PROT_DEVICE;
-	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
-		prot |= KVM_PGTABLE_PROT_X;
+	/*
+	 *  When FWB is unsupported KVM needs to do cache flushes
+	 *  (via dcache_clean_inval_poc()) of the underlying memory. This is
+	 *  only possible if the memory is already mapped into the kernel map
+	 *  at the usual spot.
+	 *
+	 *  Validate that there is a struct page for the PFN which maps
+	 *  to the KVA that the flushing code expects.
+	 */
+	if (!stage2_has_fwb(pgt) &&
+	    !(pfn_valid(pfn) &&
+	      page_to_virt(pfn_to_page(pfn)) == kvm_host_va(PFN_PHYS(pfn)))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	/*
 	 * Under the premise of getting a FSC_PERM fault, we just need to relax
-- 
2.17.1

