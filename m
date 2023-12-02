Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC7801BC5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjLBJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:45:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B71A6;
        Sat,  2 Dec 2023 01:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510364; x=1733046364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=i9OyDLqUL8MDcPXZYwlSXijUUvemlGAamKue93VaY0k=;
  b=cvnSYbts+s4GoWYobm/2DkUYUfrDOubaPo2zk169Kai1B3S1t6zn0sRq
   4ZrXjgSJEOvrh1W5WAAPAp3UZM9sTPbpekEDKGwDB0rLAUFR0rI+qubzR
   TN+/ELfGzAOfNsBcAJkgszuYi90xyCJE3c/omEs3ArXUUHDQvAmFRDeZ1
   /gWOkuWgQ0RSvZq22tlqcN+Jh/l1oVq7BCeL2ipPPNefMVf55kpWDjjJd
   5rNZ2lMIjjwBli7sgjhHt1S/E7gD7l6uXyLLenidaXR6kZk8dsxrPV+lp
   wJeWZ78jz03rDZzUjukKn0onBtjnh3w6yeJjq8N3y6mGHnLFalrx3Ba4D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="6886198"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="6886198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="746278747"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="746278747"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:45:59 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 05/42] KVM: Embed "arch" object and call arch init/destroy in TDP FD
Date:   Sat,  2 Dec 2023 17:16:59 +0800
Message-Id: <20231202091659.13707-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed "arch" object in private "kvm_exported_tdp" object of KVM TDP FD
object in order to associate a TDP page table to this private object.

With later patches for arch x86, the overall data structure hierarchy on
x86 for TDP FD to export TDP is outlined below for preview.

kvm_tdp_fd
 .------
 |  ops-|-->kvm_exported_tdp_ops
 | file |                                                 public
-----------------------------------------------------------------------
 | priv-|-->kvm_exported_tdp                              private
 '------'   .-----------.
            |  tdp_fd   |
            |   as_id   |
            |    kvm    |
            | importers |
            |   arch   -|-->kvm_arch_exported_tdp
            | list_node |   .------.
            '-----------'   | mmu -|--> kvm_exported_tdp_mmu
                            | meta |   .-----------.
                            '--|---'   |   common -|--> kvm_mmu_common
                               |       | root_page |
                               |       '-----------'
                               |
                               |
                               |
                               +-->kvm_exported_tdp_meta_vmx
                                  .--------------------.
                                  |      type          |
                                  |      level         |
                                  |     root_hpa       |
                                  | max_huge_page_level|
                                  | rsvd_bits_mask     |
                                  '--------------------'

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/kvm_host.h | 17 +++++++++++++++++
 virt/kvm/tdp_fd.c        | 12 +++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 122f47c94ecae..5a74b2b0ac81f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2327,6 +2327,9 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 #ifdef CONFIG_HAVE_KVM_EXPORTED_TDP
 
 struct kvm_exported_tdp {
+#ifdef __KVM_HAVE_ARCH_EXPORTED_TDP
+	struct kvm_arch_exported_tdp arch;
+#endif
 	struct kvm_tdp_fd *tdp_fd;
 
 	struct kvm *kvm;
@@ -2335,5 +2338,19 @@ struct kvm_exported_tdp {
 	struct list_head list_node;
 };
 
+#ifdef __KVM_HAVE_ARCH_EXPORTED_TDP
+int kvm_arch_exported_tdp_init(struct kvm *kvm, struct kvm_exported_tdp *tdp);
+void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp);
+#else
+static inline int kvm_arch_exported_tdp_init(struct kvm *kvm,
+					     struct kvm_exported_tdp *tdp)
+{
+	return -EOPNOTSUPP;
+}
+static inline void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp)
+{
+}
+#endif /* __KVM_HAVE_ARCH_EXPORTED_TDP */
+
 #endif /* CONFIG_HAVE_KVM_EXPORTED_TDP */
 #endif
diff --git a/virt/kvm/tdp_fd.c b/virt/kvm/tdp_fd.c
index a5c4c3597e94f..7e68199ea9643 100644
--- a/virt/kvm/tdp_fd.c
+++ b/virt/kvm/tdp_fd.c
@@ -52,17 +52,20 @@ int kvm_create_tdp_fd(struct kvm *kvm, struct kvm_create_tdp_fd *ct)
 		goto out;
 	}
 	tdp->kvm = kvm;
+	ret = kvm_arch_exported_tdp_init(kvm, tdp);
+	if (ret)
+		goto out;
 
 	tdp_fd->file = anon_inode_getfile("tdp_fd", &kvm_tdp_fd_fops,
 					tdp_fd, O_RDWR | O_CLOEXEC);
 	if (!tdp_fd->file) {
 		ret = -EFAULT;
-		goto out;
+		goto out_uninit;
 	}
 
 	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
 	if (fd < 0)
-		goto out;
+		goto out_uninit;
 
 	fd_install(fd, tdp_fd->file);
 	ct->fd = fd;
@@ -73,10 +76,12 @@ int kvm_create_tdp_fd(struct kvm *kvm, struct kvm_create_tdp_fd *ct)
 	spin_unlock(&kvm->exported_tdplist_lock);
 	return 0;
 
-out:
+out_uninit:
 	if (tdp_fd->file)
 		fput(tdp_fd->file);
 
+	kvm_arch_exported_tdp_destroy(tdp);
+out:
 	if (tdp->kvm)
 		kvm_put_kvm_no_destroy(tdp->kvm);
 	kfree(tdp);
@@ -102,6 +107,7 @@ static int kvm_tdp_fd_release(struct inode *inode, struct file *file)
 	list_del(&tdp->list_node);
 	spin_unlock(&tdp->kvm->exported_tdplist_lock);
 
+	kvm_arch_exported_tdp_destroy(tdp);
 	kvm_put_kvm(tdp->kvm);
 	kfree(tdp);
 	kfree(tdp_fd);
-- 
2.17.1

