Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00627E5530
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjKHLWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344775AbjKHLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:22:29 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9532595;
        Wed,  8 Nov 2023 03:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699442535; x=1730978535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0xPIztXiJ7BozvZWMLf19nS4eQCyoOv0IyQ7RPZ9oY=;
  b=ScG3mjd4qwEUTBFvQ+qL53JHqLOqgY4i/iWkFCjCq/HOq1GCAgsSyW3X
   6pMcvDICCD68aTy80gFBxxOnZwtbhliEV0N3yLlHqNPCUKXPefTq+npqV
   4Frx7Bx5Aay2dODnOlP+XcPDWNWoyGh0dT9ydSBITImWlLnlqWIJ6BIcW
   w=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="251428368"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:22:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 372E640DB0;
        Wed,  8 Nov 2023 11:22:14 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:29860]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.105:2525] with esmtp (Farcaster)
 id 76b6a16b-a40f-4cc6-97d8-14f01b8119af; Wed, 8 Nov 2023 11:22:13 +0000 (UTC)
X-Farcaster-Flow-ID: 76b6a16b-a40f-4cc6-97d8-14f01b8119af
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:12 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:08 +0000
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
        <jgowans@amazon.com>, <corbert@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [RFC 18/33] KVM: x86: Decouple kvm_get_memory_attributes() from struct kvm's mem_attr_array
Date:   Wed, 8 Nov 2023 11:17:51 +0000
Message-ID: <20231108111806.92604-19-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231108111806.92604-1-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple kvm_get_memory_attributes() from struct kvm's mem_attr_array to
allow other memory attribute sources to use the function.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c   | 5 +++--
 include/linux/kvm_host.h | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a1fbb905258b..96421234ca88 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7301,7 +7301,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
-		    attrs != kvm_get_memory_attributes(kvm, gfn))
+		    attrs != kvm_get_memory_attributes(&kvm->mem_attr_array, gfn))
 			return false;
 	}
 	return true;
@@ -7401,7 +7401,8 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 		 * be manually checked as the attributes may already be mixed.
 		 */
 		for (gfn = start; gfn < end; gfn += nr_pages) {
-			unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+			unsigned long attrs =
+				kvm_get_memory_attributes(&kvm->mem_attr_array, gfn);
 
 			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
 				hugepage_clear_mixed(slot, gfn, level);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 631fd532c97a..4242588e3dfb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2385,9 +2385,10 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+static inline unsigned long
+kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return xa_to_value(xa_load(mem_attr_array, gfn));
 }
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
@@ -2400,7 +2401,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
-	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	       kvm_get_memory_attributes(&kvm->mem_attr_array, gfn) &
+		       KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
-- 
2.40.1

