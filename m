Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2C7F8946
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjKYIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjKYIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51249D7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700901245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fifx1OpT0+LOXRVENBYb2+UgoxO00jGJFMkVPCqjJjc=;
        b=QrLHbXNoqefMvdxr36o3dAw7PwuCetUXBwz1T0U4705luuliRzYbfP05UrF83xHOi7YfbI
        4j60r4sfS4WvrLif2GzXpiuearOKkCD7HItzvfZrYxBOFrGkuYIs5nc+IJtvNYw8NLApJl
        crsdGr+7UJS6oKQ0glwgxTBfXXFpWOo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-PaiEfHzPMm2S3SRqgT_Spg-1; Sat,
 25 Nov 2023 03:34:02 -0500
X-MC-Unique: PaiEfHzPMm2S3SRqgT_Spg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C179B3C00097;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F22C1121306;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com
Subject: [PATCH v2 3/4] KVM: x86/mmu: always take tdp_mmu_pages_lock
Date:   Sat, 25 Nov 2023 03:33:59 -0500
Message-Id: <20231125083400.1399197-4-pbonzini@redhat.com>
In-Reply-To: <20231125083400.1399197-1-pbonzini@redhat.com>
References: <20231125083400.1399197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is cheap to take tdp_mmu_pages_lock in all write-side critical sections.
We already do it all the time when zapping with read_lock(), so it is not
a problem to do it from the kvm_tdp_mmu_zap_all() path (aka
kvm_arch_flush_shadow_all(), aka VM destruction and MMU notifier release).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/locking.rst |  7 +++----
 arch/x86/include/asm/kvm_host.h    | 11 ++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c         | 24 ++++--------------------
 3 files changed, 13 insertions(+), 29 deletions(-)

	v1->v2: fix kerneldoc

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 3a034db5e55f..02880d5552d5 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -43,10 +43,9 @@ On x86:
 
 - vcpu->mutex is taken outside kvm->arch.hyperv.hv_lock and kvm->arch.xen.xen_lock
 
-- kvm->arch.mmu_lock is an rwlock.  kvm->arch.tdp_mmu_pages_lock and
-  kvm->arch.mmu_unsync_pages_lock are taken inside kvm->arch.mmu_lock, and
-  cannot be taken without already holding kvm->arch.mmu_lock (typically with
-  ``read_lock`` for the TDP MMU, thus the need for additional spinlocks).
+- kvm->arch.mmu_lock is an rwlock; critical sections for
+  kvm->arch.tdp_mmu_pages_lock and kvm->arch.mmu_unsync_pages_lock must
+  also take kvm->arch.mmu_lock
 
 Everything else is a leaf: no other lock is taken inside the critical
 sections.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7036982332e..f58d318e37aa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1406,9 +1406,8 @@ struct kvm_arch {
 	 *	the MMU lock in read mode + RCU or
 	 *	the MMU lock in write mode
 	 *
-	 * For writes, this list is protected by:
-	 *	the MMU lock in read mode + the tdp_mmu_pages_lock or
-	 *	the MMU lock in write mode
+	 * For writes, this list is protected by tdp_mmu_pages_lock; see
+	 * below for the details.
 	 *
 	 * Roots will remain in the list until their tdp_mmu_root_count
 	 * drops to zero, at which point the thread that decremented the
@@ -1425,8 +1424,10 @@ struct kvm_arch {
 	 *  - possible_nx_huge_pages;
 	 *  - the possible_nx_huge_page_link field of kvm_mmu_page structs used
 	 *    by the TDP MMU
-	 * It is acceptable, but not necessary, to acquire this lock when
-	 * the thread holds the MMU lock in write mode.
+	 * Because the lock is only taken within the MMU lock, strictly
+	 * speaking it is redundant to acquire this lock when the thread
+	 * holds the MMU lock in write mode.  However it often simplifies
+	 * the code to do so.
 	 */
 	spinlock_t tdp_mmu_pages_lock;
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a85b31a3fc44..d3473f4bf246 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -75,12 +75,6 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 {
-	/*
-	 * Either read or write is okay, but mmu_lock must be held because
-	 * writers are not required to take tdp_mmu_pages_lock.
-	 */
-	lockdep_assert_held(&kvm->mmu_lock);
-
 	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
 
@@ -281,28 +275,18 @@ static void tdp_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
  *
  * @kvm: kvm instance
  * @sp: the page to be removed
- * @shared: This operation may not be running under the exclusive use of
- *	    the MMU lock and the operation must synchronize with other
- *	    threads that might be adding or removing pages.
  */
-static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp,
-			      bool shared)
+static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	tdp_unaccount_mmu_page(kvm, sp);
 
 	if (!sp->nx_huge_page_disallowed)
 		return;
 
-	if (shared)
-		spin_lock(&kvm->arch.tdp_mmu_pages_lock);
-	else
-		lockdep_assert_held_write(&kvm->mmu_lock);
-
+	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	sp->nx_huge_page_disallowed = false;
 	untrack_possible_nx_huge_page(kvm, sp);
-
-	if (shared)
-		spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
+	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 }
 
 /**
@@ -331,7 +315,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 
 	trace_kvm_mmu_prepare_zap_page(sp);
 
-	tdp_mmu_unlink_sp(kvm, sp, shared);
+	tdp_mmu_unlink_sp(kvm, sp);
 
 	for (i = 0; i < SPTE_ENT_PER_PAGE; i++) {
 		tdp_ptep_t sptep = pt + i;
-- 
2.39.1


