Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844BD801BC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjLBJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjLBJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:46:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA1181;
        Sat,  2 Dec 2023 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510396; x=1733046396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=D/v0y2NA6xRqP9bnDret0xs9lulZFX+zXryP5QvmzLE=;
  b=fXwYKADO/y9Mdvz1hDolBDulWghnXQkIyDM9NQojKK/7FwEwhyvhVSQD
   vIeErtLfJZBwbrm99G20ZEbhwF7eB1pRw+JZWnyI8x+NIUHsoUWy7kTEA
   Lpn/B1KyTbmO6NBybCw4amaFn++gDWH6t0WzfWvPjMy01AhCNvNdFLCxP
   4k73P6yL4+GD1hFDU9LUuDqTRJl/es68ZPYqt5aPFo0PN8RKQO0tSEi7l
   B3oErvl5ciBW9if9Dip5Tx+Daq4lmz0grTUE+tUbLz9bS9YG0eAN7CR4P
   yIFMAxEh79+rXf6pL8Tw9zRt/5uICipT8NbJGtJYeXaRR83OYl3QQcNPz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="372982756"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="372982756"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="773705785"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="773705785"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:46:33 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 06/42] KVM: Register/Unregister importers to KVM exported TDP
Date:   Sat,  2 Dec 2023 17:17:38 +0800
Message-Id: <20231202091738.13770-1-yan.y.zhao@intel.com>
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

Each TDP exported by KVM has its own list of importers. External components
can register/unregister itself as an importer with a unique importer ops.

The sequence for external components to register/unregister as importer is
like:
1. call kvm_tdp_fd_get() to get a KVM TDP fd object.
2. call tdp_fd->ops->register_importer() to register itself as an importer.
3. call tdp_fd->ops->unregister_importer() to unregister itself as
   importer.
4. call kvm_tdp_fd_put() to put the KVM TDP fd object.

When destroying a KVM TDP fd object, all importers are force-unregistered.
There's no extra notification to the importers at that time because the
force-unregister should only happen when importers calls kvm_tdp_fd_put()
without calling tdp_fd->ops->unregister_importer() first.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/kvm_host.h |  5 +++
 virt/kvm/tdp_fd.c        | 68 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5a74b2b0ac81f..f73d32eef8833 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2334,6 +2334,11 @@ struct kvm_exported_tdp {
 
 	struct kvm *kvm;
 	u32 as_id;
+
+	/* protect importers list */
+	spinlock_t importer_lock;
+	struct list_head importers;
+
 	/* head at kvm->exported_tdp_list */
 	struct list_head list_node;
 };
diff --git a/virt/kvm/tdp_fd.c b/virt/kvm/tdp_fd.c
index 7e68199ea9643..3271da1a4b2c1 100644
--- a/virt/kvm/tdp_fd.c
+++ b/virt/kvm/tdp_fd.c
@@ -13,6 +13,13 @@ static inline int is_tdp_fd_file(struct file *file);
 static const struct file_operations kvm_tdp_fd_fops;
 static const struct kvm_exported_tdp_ops exported_tdp_ops;
 
+struct kvm_tdp_importer {
+	struct kvm_tdp_importer_ops *ops;
+	void *data;
+	struct list_head node;
+};
+static void kvm_tdp_unregister_all_importers(struct kvm_exported_tdp *tdp);
+
 int kvm_create_tdp_fd(struct kvm *kvm, struct kvm_create_tdp_fd *ct)
 {
 	struct kvm_exported_tdp *tdp;
@@ -56,6 +63,9 @@ int kvm_create_tdp_fd(struct kvm *kvm, struct kvm_create_tdp_fd *ct)
 	if (ret)
 		goto out;
 
+	INIT_LIST_HEAD(&tdp->importers);
+	spin_lock_init(&tdp->importer_lock);
+
 	tdp_fd->file = anon_inode_getfile("tdp_fd", &kvm_tdp_fd_fops,
 					tdp_fd, O_RDWR | O_CLOEXEC);
 	if (!tdp_fd->file) {
@@ -107,6 +117,7 @@ static int kvm_tdp_fd_release(struct inode *inode, struct file *file)
 	list_del(&tdp->list_node);
 	spin_unlock(&tdp->kvm->exported_tdplist_lock);
 
+	kvm_tdp_unregister_all_importers(tdp);
 	kvm_arch_exported_tdp_destroy(tdp);
 	kvm_put_kvm(tdp->kvm);
 	kfree(tdp);
@@ -141,12 +152,67 @@ static inline int is_tdp_fd_file(struct file *file)
 static int kvm_tdp_register_importer(struct kvm_tdp_fd *tdp_fd,
 				     struct kvm_tdp_importer_ops *ops, void *data)
 {
-	return -EOPNOTSUPP;
+	struct kvm_tdp_importer *importer, *tmp;
+	struct kvm_exported_tdp *tdp;
+
+	if (!tdp_fd || !tdp_fd->priv || !ops)
+		return -EINVAL;
+
+	tdp = tdp_fd->priv;
+	importer = kzalloc(sizeof(*importer), GFP_KERNEL);
+	if (!importer)
+		return -ENOMEM;
+
+	spin_lock(&tdp->importer_lock);
+	list_for_each_entry(tmp, &tdp->importers, node) {
+		if (tmp->ops != ops)
+			continue;
+
+		kfree(importer);
+		spin_unlock(&tdp->importer_lock);
+		return -EBUSY;
+	}
+
+	importer->ops = ops;
+	importer->data = data;
+	list_add(&importer->node, &tdp->importers);
+
+	spin_unlock(&tdp->importer_lock);
+
+	return 0;
 }
 
 static void kvm_tdp_unregister_importer(struct kvm_tdp_fd *tdp_fd,
 					struct kvm_tdp_importer_ops *ops)
 {
+	struct kvm_tdp_importer *importer, *n;
+	struct kvm_exported_tdp *tdp;
+
+	if (!tdp_fd || !tdp_fd->priv)
+		return;
+
+	tdp = tdp_fd->priv;
+	spin_lock(&tdp->importer_lock);
+	list_for_each_entry_safe(importer, n, &tdp->importers, node) {
+		if (importer->ops != ops)
+			continue;
+
+		list_del(&importer->node);
+		kfree(importer);
+	}
+	spin_unlock(&tdp->importer_lock);
+}
+
+static void kvm_tdp_unregister_all_importers(struct kvm_exported_tdp *tdp)
+{
+	struct kvm_tdp_importer *importer, *n;
+
+	spin_lock(&tdp->importer_lock);
+	list_for_each_entry_safe(importer, n, &tdp->importers, node) {
+		list_del(&importer->node);
+		kfree(importer);
+	}
+	spin_unlock(&tdp->importer_lock);
 }
 
 static void *kvm_tdp_get_metadata(struct kvm_tdp_fd *tdp_fd)
-- 
2.17.1

