Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEB767B41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjG2Bil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjG2BiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:38:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B14ED1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:37:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564fb1018bcso28365327b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690594597; x=1691199397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=czGmzPMDgqsIJ4RQV1Z6GN4pZzqhqI37yd+QxF3MreY=;
        b=2NTUzYwk3TaN5RllCgOP5ct5lZFLcAcfcZZZwfNwujtEk9FPQaGjPFLUv9zpL5dal+
         n4jk6r32/CMwr16FEJlFrMte1BNxTbdaCTChtMRkEw2hzMVhkh9x5+ubSW9p1XTnZgr9
         5Y7ku84iwTlnSU8VTKzDDdO3/feeN5h2CmwmMJQcTln+2vP8PyjZ5BsxOG2istjRrV22
         wgr9lqEQxeR3OEnORORlHuDBeUdudrL4EzZXu4Ks+eLNzZBrOfVjMdYjboLE8ItkIqme
         nP0US683/I0pSpHLK5eKsJzBjBqoFuwQZJJiN1XXweyhxl8F2p3L0UB9XHh3uesrxoL6
         eXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594597; x=1691199397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czGmzPMDgqsIJ4RQV1Z6GN4pZzqhqI37yd+QxF3MreY=;
        b=i5Gp3JJLDXfGsCJuDeT6k/F4B99UnpksOB/JAATd6Vi3+VqRJcoLaCFFqO2G6+aT+k
         GBnxvmDPWzC67CvAIkrLtmpT/jX0R9rNqIStShy2V57FPrS6JaNpUYmyBj0rznxP9Iaj
         Cj8PPDx6oh+nbntt4M3t86bcWxRveFMFPiMBpHLq0p/QzmgibdHNBMw/v55+vWhggODm
         SHf9uyJ/aunCcp3hHydh207Kfl/jMcXYXoeplivt9GGQqvgZTXVXPc6mQqphiktxhgMg
         TZdKWgsVFKx4n6S05SY48xjGfb1cAiMd7cCc/gnuYw+oc+k73K2w68zzOFxvR8q2eYwn
         iInQ==
X-Gm-Message-State: ABy/qLYXsl70BnLjWfYvCE4PdIZqddgeVzTXoMlpwRotht17GycAfSwq
        oSjvrlTgpKOTBLg3bFFo2VQKz+tMeSo=
X-Google-Smtp-Source: APBJJlHGwV7pPJq5hRkVAxu9ubBcdqn9/bza1y8YnJpEuyXVtsAzlmWMNkae8tfB9Wko80gstNdvIg6y4Ho=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:72c:b0:583:5039:d4a0 with SMTP id
 bt12-20020a05690c072c00b005835039d4a0mr24920ywb.0.1690594597389; Fri, 28 Jul
 2023 18:36:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:35:34 -0700
In-Reply-To: <20230729013535.1070024-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729013535.1070024-29-seanjc@google.com>
Subject: [PATCH v4 28/29] KVM: x86/mmu: Handle KVM bookkeeping in page-track
 APIs, not callers
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Yongwei Ma <yongwei.ma@intel.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get/put references to KVM when a page-track notifier is (un)registered
instead of relying on the caller to do so.  Forcing the caller to do the
bookkeeping is unnecessary and adds one more thing for users to get
wrong, e.g. see commit 9ed1fdee9ee3 ("drm/i915/gvt: Get reference to KVM
iff attachment to VM is successful").

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_page_track.h | 11 +++++------
 arch/x86/kvm/mmu/page_track.c         | 18 ++++++++++++------
 drivers/gpu/drm/i915/gvt/kvmgt.c      | 17 +++++++----------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 4afab697e21c..3d040741044b 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -44,12 +44,11 @@ struct kvm_page_track_notifier_node {
 				    struct kvm_page_track_notifier_node *node);
 };
 
-void
-kvm_page_track_register_notifier(struct kvm *kvm,
-				 struct kvm_page_track_notifier_node *n);
-void
-kvm_page_track_unregister_notifier(struct kvm *kvm,
-				   struct kvm_page_track_notifier_node *n);
+int kvm_page_track_register_notifier(struct kvm *kvm,
+				     struct kvm_page_track_notifier_node *n);
+void kvm_page_track_unregister_notifier(struct kvm *kvm,
+					struct kvm_page_track_notifier_node *n);
+
 int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
 int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
 #else
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 2a64df38ccab..fd04e618ad2d 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -157,17 +157,22 @@ int kvm_page_track_init(struct kvm *kvm)
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
  */
-void
-kvm_page_track_register_notifier(struct kvm *kvm,
-				 struct kvm_page_track_notifier_node *n)
+int kvm_page_track_register_notifier(struct kvm *kvm,
+				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
 
+	if (!kvm || kvm->mm != current->mm)
+		return -ESRCH;
+
+	kvm_get_kvm(kvm);
+
 	head = &kvm->arch.track_notifier_head;
 
 	write_lock(&kvm->mmu_lock);
 	hlist_add_head_rcu(&n->node, &head->track_notifier_list);
 	write_unlock(&kvm->mmu_lock);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
 
@@ -175,9 +180,8 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
  * stop receiving the event interception. It is the opposed operation of
  * kvm_page_track_register_notifier().
  */
-void
-kvm_page_track_unregister_notifier(struct kvm *kvm,
-				   struct kvm_page_track_notifier_node *n)
+void kvm_page_track_unregister_notifier(struct kvm *kvm,
+					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
 
@@ -187,6 +191,8 @@ kvm_page_track_unregister_notifier(struct kvm *kvm,
 	hlist_del_rcu(&n->node);
 	write_unlock(&kvm->mmu_lock);
 	synchronize_srcu(&head->track_srcu);
+
+	kvm_put_kvm(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 21342a93e418..eb50997dd369 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -654,21 +654,19 @@ static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu)
 static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 {
 	struct intel_vgpu *vgpu = vfio_dev_to_vgpu(vfio_dev);
-
-	if (!vgpu->vfio_device.kvm ||
-	    vgpu->vfio_device.kvm->mm != current->mm) {
-		gvt_vgpu_err("KVM is required to use Intel vGPU\n");
-		return -ESRCH;
-	}
+	int ret;
 
 	if (__kvmgt_vgpu_exist(vgpu))
 		return -EEXIST;
 
 	vgpu->track_node.track_write = kvmgt_page_track_write;
 	vgpu->track_node.track_remove_region = kvmgt_page_track_remove_region;
-	kvm_get_kvm(vgpu->vfio_device.kvm);
-	kvm_page_track_register_notifier(vgpu->vfio_device.kvm,
-					 &vgpu->track_node);
+	ret = kvm_page_track_register_notifier(vgpu->vfio_device.kvm,
+					       &vgpu->track_node);
+	if (ret) {
+		gvt_vgpu_err("KVM is required to use Intel vGPU\n");
+		return ret;
+	}
 
 	set_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status);
 
@@ -703,7 +701,6 @@ static void intel_vgpu_close_device(struct vfio_device *vfio_dev)
 
 	kvm_page_track_unregister_notifier(vgpu->vfio_device.kvm,
 					   &vgpu->track_node);
-	kvm_put_kvm(vgpu->vfio_device.kvm);
 
 	kvmgt_protect_table_destroy(vgpu);
 	gvt_cache_destroy(vgpu);
-- 
2.41.0.487.g6d72f3e995-goog

