Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1889B7F894B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjKYIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjKYIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F671B2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700901248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTG05EW/Vn1GRdMSm15A5fKBFtMK4HcJRfq9goQr52c=;
        b=FNBaXQkynWxqYiYG4eF21f6HByuCnechu1fZIokweIKPC+GorVJUoiM0dy0+AhF36jR46W
        jDTfP5rEcT3+AphBrRADg1MRB6AiClkUVeZeBis3DvXfCyKi8b1O/bmjM0RZMtV6YcJN1v
        TbMGeZC8/3wj2v8K1vjurNmddtgDkNk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-qrcciyPnNpqRMq3RRfw8lA-1; Sat,
 25 Nov 2023 03:34:01 -0500
X-MC-Unique: qrcciyPnNpqRMq3RRfw8lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 974BE1C05AE3;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74E291121306;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com
Subject: [PATCH v2 2/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
Date:   Sat, 25 Nov 2023 03:33:58 -0500
Message-Id: <20231125083400.1399197-3-pbonzini@redhat.com>
In-Reply-To: <20231125083400.1399197-1-pbonzini@redhat.com>
References: <20231125083400.1399197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "bool shared" argument is more or less unnecessary in the
for_each_*_tdp_mmu_root_yield_safe() macros.  Many users check for
the lock before calling it; all of them either call small functions
that do the check, or end up calling tdp_mmu_set_spte_atomic() and
tdp_mmu_iter_set_spte().  Add a few assertions to make up for the
lost check in for_each_*_tdp_mmu_root_yield_safe(), but even this
is probably overkill and mostly for documentation reasons.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 50 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

	v1->v2: keep lockdep_assert_held()

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 05689c8d45b7..a85b31a3fc44 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -155,23 +155,20 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * If shared is set, this function is operating under the MMU lock in read
  * mode.
  */
-#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, _only_valid)\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);		\
-	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))		\
-		if (kvm_lockdep_assert_mmu_lock_held(_kvm, _shared) &&		\
-		    kvm_mmu_page_as_id(_root) != _as_id) {			\
+#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _only_valid)\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);	\
+	     ({ lockdep_assert_held(&(_kvm)->mmu_lock); }), _root;	\
+	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))	\
+		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
 		} else
 
-#define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)	\
-	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
+#define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id)	\
+	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, true)
 
-#define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _shared)			\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, false);			\
-	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, false))			\
-		if (!kvm_lockdep_assert_mmu_lock_held(_kvm, _shared)) {		\
-		} else
+#define for_each_tdp_mmu_root_yield_safe(_kvm, _root)			\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, false);		\
+	     ({ lockdep_assert_held(&(_kvm)->mmu_lock); }), _root;	\
+	     _root = tdp_mmu_next_root(_kvm, _root, false))
 
 /*
  * Iterate over all TDP MMU roots.  Requires that mmu_lock be held for write,
@@ -840,7 +837,8 @@ bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool flush)
 {
 	struct kvm_mmu_page *root;
 
-	for_each_tdp_mmu_root_yield_safe(kvm, root, false)
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	for_each_tdp_mmu_root_yield_safe(kvm, root)
 		flush = tdp_mmu_zap_leafs(kvm, root, start, end, true, flush);
 
 	return flush;
@@ -862,7 +860,8 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 	 * is being destroyed or the userspace VMM has exited.  In both cases,
 	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
 	 */
-	for_each_tdp_mmu_root_yield_safe(kvm, root, false)
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	for_each_tdp_mmu_root_yield_safe(kvm, root)
 		tdp_mmu_zap_root(kvm, root, false);
 }
 
@@ -876,7 +875,7 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 
 	read_lock(&kvm->mmu_lock);
 
-	for_each_tdp_mmu_root_yield_safe(kvm, root, true) {
+	for_each_tdp_mmu_root_yield_safe(kvm, root) {
 		if (!root->tdp_mmu_scheduled_root_to_zap)
 			continue;
 
@@ -1133,7 +1132,7 @@ bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 {
 	struct kvm_mmu_page *root;
 
-	__for_each_tdp_mmu_root_yield_safe(kvm, root, range->slot->as_id, false, false)
+	__for_each_tdp_mmu_root_yield_safe(kvm, root, range->slot->as_id, false)
 		flush = tdp_mmu_zap_leafs(kvm, root, range->start, range->end,
 					  range->may_block, flush);
 
@@ -1322,7 +1323,7 @@ bool kvm_tdp_mmu_wrprot_slot(struct kvm *kvm,
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
 
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id, true)
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id)
 		spte_set |= wrprot_gfn_range(kvm, root, slot->base_gfn,
 			     slot->base_gfn + slot->npages, min_level);
 
@@ -1354,6 +1355,8 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(struct kvm *kvm,
 {
 	struct kvm_mmu_page *sp;
 
+	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
+
 	/*
 	 * Since we are allocating while under the MMU lock we have to be
 	 * careful about GFP flags. Use GFP_NOWAIT to avoid blocking on direct
@@ -1504,8 +1507,7 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 	int r = 0;
 
 	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
-
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id, shared) {
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id) {
 		r = tdp_mmu_split_huge_pages_root(kvm, root, start, end, target_level, shared);
 		if (r) {
 			kvm_tdp_mmu_put_root(kvm, root);
@@ -1568,8 +1570,7 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
 	bool spte_set = false;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
-
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id, true)
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id)
 		spte_set |= clear_dirty_gfn_range(kvm, root, slot->base_gfn,
 				slot->base_gfn + slot->npages);
 
@@ -1703,8 +1704,7 @@ void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	struct kvm_mmu_page *root;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
-
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id, true)
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id)
 		zap_collapsible_spte_range(kvm, root, slot);
 }
 
-- 
2.39.1


