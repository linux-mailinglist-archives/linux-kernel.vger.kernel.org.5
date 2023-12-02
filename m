Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0D801BC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjLBJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjLBJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:47:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC5181;
        Sat,  2 Dec 2023 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510432; x=1733046432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zgOH3vLMDlIUcyJqzB7ENWd/3UPYCaFUNvwD3NOa7Mg=;
  b=kTCuUk0jF3Cet0kEc1nT9o6WBuMhdOP176iSHOBk3UCAA0fNXah5apdy
   MqtYogUNLf78NWVGbQ2frnCPgpngNy17SrYzTh8lkwU6nKKZC+EVP/Ime
   6r+ZsgqT3zOZ2idF3yzkhjjiwCabX+fXcqC6iXQrayh3Dp/XhO2l3zjN9
   E2bMkb3VIEg0p/j/bKgZBIx56dCAhdhLvNxJDQynsBB5rnKHN+j34R5Us
   2z6ZAKjpXTDEpzSwiFG0Xnt/IojXPengQylXDhoeJDd8MZ8cr5HVDB4nQ
   QOkIdRa13YL80aNUV00PTkVx5XyjWaagoNJdaXr0qH8melomxngcGRSZu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="474342"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="474342"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="18037347"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:47:08 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 07/42] KVM: Forward page fault requests to arch specific code for exported TDP
Date:   Sat,  2 Dec 2023 17:18:12 +0800
Message-Id: <20231202091812.13830-1-yan.y.zhao@intel.com>
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

Implement .fault op of KVM TDP FD object and pass page fault requests from
importers of KVM TDP FD to KVM arch specific code.

Since the thread for importers to call .fault op is not vCPU thread and
could be a kernel thread, thread "mm" is checked and kthread_use_mm() are
called when necessary.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/tdp_fd.c        | 28 +++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f73d32eef8833..b76919eec9b72 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2346,6 +2346,8 @@ struct kvm_exported_tdp {
 #ifdef __KVM_HAVE_ARCH_EXPORTED_TDP
 int kvm_arch_exported_tdp_init(struct kvm *kvm, struct kvm_exported_tdp *tdp);
 void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp);
+int kvm_arch_fault_exported_tdp(struct kvm_exported_tdp *tdp, unsigned long gfn,
+				struct kvm_tdp_fault_type type);
 #else
 static inline int kvm_arch_exported_tdp_init(struct kvm *kvm,
 					     struct kvm_exported_tdp *tdp)
@@ -2355,6 +2357,13 @@ static inline int kvm_arch_exported_tdp_init(struct kvm *kvm,
 static inline void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp)
 {
 }
+
+static inline int kvm_arch_fault_exported_tdp(struct kvm_exported_tdp *tdp,
+					      unsigned long gfn,
+					      struct kvm_tdp_fault_type type)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* __KVM_HAVE_ARCH_EXPORTED_TDP */
 
 #endif /* CONFIG_HAVE_KVM_EXPORTED_TDP */
diff --git a/virt/kvm/tdp_fd.c b/virt/kvm/tdp_fd.c
index 3271da1a4b2c1..02c9066391ebe 100644
--- a/virt/kvm/tdp_fd.c
+++ b/virt/kvm/tdp_fd.c
@@ -223,7 +223,33 @@ static void *kvm_tdp_get_metadata(struct kvm_tdp_fd *tdp_fd)
 static int kvm_tdp_fault(struct kvm_tdp_fd *tdp_fd, struct mm_struct *mm,
 			 unsigned long gfn, struct kvm_tdp_fault_type type)
 {
-	return -EOPNOTSUPP;
+	bool kthread = current->mm == NULL;
+	int ret = -EINVAL;
+
+	if (!tdp_fd || !tdp_fd->priv || !tdp_fd->priv->kvm)
+		return -EINVAL;
+
+	if (!type.read && !type.write && !type.exec)
+		return -EINVAL;
+
+	if (!mm || tdp_fd->priv->kvm->mm != mm)
+		return -EINVAL;
+
+	if (!mmget_not_zero(mm))
+		return -EPERM;
+
+	if (kthread)
+		kthread_use_mm(mm);
+	else if (current->mm != mm)
+		goto out;
+
+	ret = kvm_arch_fault_exported_tdp(tdp_fd->priv, gfn, type);
+
+	if (kthread)
+		kthread_unuse_mm(mm);
+out:
+	mmput(mm);
+	return ret;
 }
 
 static const struct kvm_exported_tdp_ops exported_tdp_ops = {
-- 
2.17.1

