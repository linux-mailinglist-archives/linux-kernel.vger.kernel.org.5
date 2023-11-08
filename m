Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911CB7E5532
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjKHLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbjKHLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:22:35 -0500
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01271FE3;
        Wed,  8 Nov 2023 03:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699442544; x=1730978544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFj4X075aGu4UwwOIKw0SMbu/vxZLmqvGhwr4IjXpjU=;
  b=bMupkCSx8kHw7yPBZciU2HV8F0Xl+xtZ09Ws2eUE53PJGeRZCYfT7Nop
   cnV59XpC57W4oEMdNZq6haUMzkf08ibV3IA+JhnmfJnYKUcqQ7/SNUWEw
   4yCNTeBBg/HWh449gZlqWxpqszG8HZucYoctsn85OQPCaAymBvqneZNa4
   0=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="593807859"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:22:21 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 452CD40DAA;
        Wed,  8 Nov 2023 11:22:19 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:28238]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.105:2525] with esmtp (Farcaster)
 id dcf98806-3299-4d1a-b110-916760b68cf4; Wed, 8 Nov 2023 11:22:18 +0000 (UTC)
X-Farcaster-Flow-ID: dcf98806-3299-4d1a-b110-916760b68cf4
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:17 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:13 +0000
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
        <jgowans@amazon.com>, <corbert@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [RFC 19/33] KVM: x86: Decouple kvm_range_has_memory_attributes() from struct kvm's mem_attr_array
Date:   Wed, 8 Nov 2023 11:17:52 +0000
Message-ID: <20231108111806.92604-20-nsaenz@amazon.com>
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

Decouple kvm_range_has_memory_attributes() from struct kvm's
mem_attr_array to allow other memory attribute sources to use the
function.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c   | 3 ++-
 include/linux/kvm_host.h | 4 ++--
 virt/kvm/kvm_main.c      | 9 +++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 96421234ca88..4ace2f8660b0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7297,7 +7297,8 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
 
 	if (level == PG_LEVEL_2M)
-		return kvm_range_has_memory_attributes(kvm, start, end, attrs);
+		return kvm_range_has_memory_attributes(&kvm->mem_attr_array,
+						       start, end, attrs);
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4242588e3dfb..32cf05637647 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2391,8 +2391,8 @@ kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)
 	return xa_to_value(xa_load(mem_attr_array, gfn));
 }
 
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attrs);
+bool kvm_range_has_memory_attributes(struct xarray *mem_attr_array, gfn_t start,
+				     gfn_t end, unsigned long attrs);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fde004a0ac46..6bb23eaf7aa6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2440,10 +2440,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
  * matching @attrs.
  */
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attrs)
+bool kvm_range_has_memory_attributes(struct xarray *mem_attr_array, gfn_t start,
+				     gfn_t end, unsigned long attrs)
 {
-	XA_STATE(xas, &kvm->mem_attr_array, start);
+	XA_STATE(xas, mem_attr_array, start);
 	unsigned long index;
 	bool has_attrs;
 	void *entry;
@@ -2582,7 +2582,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range as the desired attributes. */
-	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
+	if (kvm_range_has_memory_attributes(&kvm->mem_attr_array, start, end,
+					    attributes))
 		goto out_unlock;
 
 	/*
-- 
2.40.1

