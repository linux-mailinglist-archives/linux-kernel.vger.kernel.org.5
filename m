Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F27F8943
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjKYIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjKYIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC010E4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700901245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPrF/vSjRPm2fd0sspMYyxzeSYwBWlkCsnLNpcIl0aE=;
        b=Iep9fvAUio00rnvWjvlXChyYBZdVgu6GN8corDyFhsRuXV8zsudfJAg64UpFfhYyG9AD3o
        0wXVJEZj9HNIGIp9upIMBh+k8kJRq15YA+nHDoWTNnKCfk4BxsSMy36CROk1Oz7839nnmP
        F0vVM9NI+fFbl+rLPqF3z/32aXonPAw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-jgv7MS3gP9-R5CC6iMbj8w-1; Sat,
 25 Nov 2023 03:34:01 -0500
X-MC-Unique: jgv7MS3gP9-R5CC6iMbj8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D94D3C00096;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBFBE1121306;
        Sat, 25 Nov 2023 08:34:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com
Subject: [PATCH v2 1/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
Date:   Sat, 25 Nov 2023 03:33:57 -0500
Message-Id: <20231125083400.1399197-2-pbonzini@redhat.com>
In-Reply-To: <20231125083400.1399197-1-pbonzini@redhat.com>
References: <20231125083400.1399197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither tdp_mmu_next_root nor kvm_tdp_mmu_put_root need to know
if the lock is taken for read or write.  Either way, protection
is achieved via RCU and tdp_mmu_pages_lock.  Remove the argument
and just assert that the lock is taken.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c | 34 +++++++++++++++++++++-------------
 arch/x86/kvm/mmu/tdp_mmu.h |  3 +--
 3 files changed, 23 insertions(+), 16 deletions(-)

	v1->v2: comment tweak

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c57e181bba21..1cb81573a60b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3556,7 +3556,7 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 		return;
 
 	if (is_tdp_mmu_page(sp))
-		kvm_tdp_mmu_put_root(kvm, sp, false);
+		kvm_tdp_mmu_put_root(kvm, sp);
 	else if (!--sp->root_count && sp->role.invalid)
 		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6cd4dd631a2f..05689c8d45b7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -73,10 +73,13 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
 	tdp_mmu_free_sp(sp);
 }
 
-void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
-			  bool shared)
+void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 {
-	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
+	/*
+	 * Either read or write is okay, but mmu_lock must be held because
+	 * writers are not required to take tdp_mmu_pages_lock.
+	 */
+	lockdep_assert_held(&kvm->mmu_lock);
 
 	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
@@ -106,10 +109,16 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
  */
 static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 					      struct kvm_mmu_page *prev_root,
-					      bool shared, bool only_valid)
+					      bool only_valid)
 {
 	struct kvm_mmu_page *next_root;
 
+	/*
+	 * While the roots themselves are RCU-protected, fields such as
+	 * role.invalid are protected by mmu_lock.
+	 */
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	rcu_read_lock();
 
 	if (prev_root)
@@ -132,7 +141,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 	rcu_read_unlock();
 
 	if (prev_root)
-		kvm_tdp_mmu_put_root(kvm, prev_root, shared);
+		kvm_tdp_mmu_put_root(kvm, prev_root);
 
 	return next_root;
 }
@@ -144,13 +153,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * recent root. (Unless keeping a live reference is desirable.)
  *
  * If shared is set, this function is operating under the MMU lock in read
- * mode. In the unlikely event that this thread must free a root, the lock
- * will be temporarily dropped and reacquired in write mode.
+ * mode.
  */
 #define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, _only_valid)\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, _only_valid);	\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);		\
 	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, _shared, _only_valid))	\
+	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))		\
 		if (kvm_lockdep_assert_mmu_lock_held(_kvm, _shared) &&		\
 		    kvm_mmu_page_as_id(_root) != _as_id) {			\
 		} else
@@ -159,9 +167,9 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
 
 #define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _shared)			\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, false);		\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, false);			\
 	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, _shared, false))		\
+	     _root = tdp_mmu_next_root(_kvm, _root, false))			\
 		if (!kvm_lockdep_assert_mmu_lock_held(_kvm, _shared)) {		\
 		} else
 
@@ -891,7 +899,7 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 		 * the root must be reachable by mmu_notifiers while it's being
 		 * zapped
 		 */
-		kvm_tdp_mmu_put_root(kvm, root, true);
+		kvm_tdp_mmu_put_root(kvm, root);
 	}
 
 	read_unlock(&kvm->mmu_lock);
@@ -1500,7 +1508,7 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id, shared) {
 		r = tdp_mmu_split_huge_pages_root(kvm, root, start, end, target_level, shared);
 		if (r) {
-			kvm_tdp_mmu_put_root(kvm, root, shared);
+			kvm_tdp_mmu_put_root(kvm, root);
 			break;
 		}
 	}
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 733a3aef3a96..20d97aa46c49 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -17,8 +17,7 @@ __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
 	return refcount_inc_not_zero(&root->tdp_mmu_root_count);
 }
 
-void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
-			  bool shared);
+void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root);
 
 bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool flush);
 bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp);
-- 
2.39.1


