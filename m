Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5157E5533
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbjKHLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbjKHLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:22:41 -0500
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CC2101;
        Wed,  8 Nov 2023 03:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699442550; x=1730978550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7UoBAKDyQ8FEQ/hZE/ZqdsRX3l1s1mZYyf6joluUVw=;
  b=eKTIdGo5kTWW7brRwyBs8HubcaCaa+Bio9gajh4QmEzRn3QF8Z6Qha+V
   VSbpZ0aHF71h6EKaQ38pEVHzFv4Ad/ADlqtVTftyMLTBIqKTdrR4WoJI4
   iD/tbY4wpYih0q0sPabhPnQTe3x0G4mHKe+KWGmstGMvvc7D382BP83vg
   E=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="164959413"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:22:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 5F0088A33C;
        Wed,  8 Nov 2023 11:22:24 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:16387]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.105:2525] with esmtp (Farcaster)
 id 52d25461-f54c-47d3-a30b-cd79c101be6b; Wed, 8 Nov 2023 11:22:23 +0000 (UTC)
X-Farcaster-Flow-ID: 52d25461-f54c-47d3-a30b-cd79c101be6b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:22 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:22:18 +0000
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
        <jgowans@amazon.com>, <corbert@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [RFC 20/33] KVM: x86/mmu: Decouple hugepage_has_attrs() from struct kvm's mem_attr_array
Date:   Wed, 8 Nov 2023 11:17:53 +0000
Message-ID: <20231108111806.92604-21-nsaenz@amazon.com>
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

Decouple hugepage_has_attrs() from struct kvm's mem_attr_array to
allow other memory attribute sources to use the function.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4ace2f8660b0..c0fd3afd6be5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7290,19 +7290,19 @@ static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
 }
 
-static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
-			       gfn_t gfn, int level, unsigned long attrs)
+static bool hugepage_has_attrs(struct xarray *mem_attr_array,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level, unsigned long attrs)
 {
 	const unsigned long start = gfn;
 	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
 
 	if (level == PG_LEVEL_2M)
-		return kvm_range_has_memory_attributes(&kvm->mem_attr_array,
-						       start, end, attrs);
+		return kvm_range_has_memory_attributes(mem_attr_array, start, end, attrs);
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
-		    attrs != kvm_get_memory_attributes(&kvm->mem_attr_array, gfn))
+		    attrs != kvm_get_memory_attributes(mem_attr_array, gfn))
 			return false;
 	}
 	return true;
@@ -7344,7 +7344,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 			 * misaligned address regardless of memory attributes.
 			 */
 			if (gfn >= slot->base_gfn) {
-				if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+				if (hugepage_has_attrs(&kvm->mem_attr_array,
+						       slot, gfn, level, attrs))
 					hugepage_clear_mixed(slot, gfn, level);
 				else
 					hugepage_set_mixed(slot, gfn, level);
@@ -7366,7 +7367,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 		 */
 		if (gfn < range->end &&
 		    (gfn + nr_pages) <= (slot->base_gfn + slot->npages)) {
-			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+			if (hugepage_has_attrs(&kvm->mem_attr_array, slot, gfn,
+					       level, attrs))
 				hugepage_clear_mixed(slot, gfn, level);
 			else
 				hugepage_set_mixed(slot, gfn, level);
@@ -7405,7 +7407,7 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 			unsigned long attrs =
 				kvm_get_memory_attributes(&kvm->mem_attr_array, gfn);
 
-			if (hugepage_has_attrs(kvm, slot, gfn, level, attrs))
+			if (hugepage_has_attrs(&kvm->mem_attr_array, slot, gfn, level, attrs))
 				hugepage_clear_mixed(slot, gfn, level);
 			else
 				hugepage_set_mixed(slot, gfn, level);
-- 
2.40.1

