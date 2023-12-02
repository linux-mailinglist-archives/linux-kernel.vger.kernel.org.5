Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E9801BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjLBJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjLBJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:44:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A94181;
        Sat,  2 Dec 2023 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510280; x=1733046280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3m2805xxDC9GupP7oswWsUnW1kwrOEt/HuavVpPlfek=;
  b=doAyBkorSKI5GQlTAY56Lfn9XRT5lkLs1Q3aGbjDVVfRCbYIeEfa/YIa
   ZKk4DXV7s7Z+duit9oKQO23iVrNAbqiA30lXJykin+KRE7r1Vz7wUzVa3
   WBdHhCtTmP3dE0uNjw08lOXkF/TseFZua7aGD9RtmmOzC+InIaKMoY1Mu
   2LBkb0zxtZlHaI4JhAUKKD0SmZ36+J6y/D69sc9bZM9dE/hyV5OGsiMI8
   B22Xp7MDsDtsgLvhcseB/pFll9eATs377JfLnXbnGsqdr3vPHAixltJFx
   2EnCyJSho3M47VdLdDYQ+axaqAdagy2fcOQIDXVZr00K1fTFP36e8jRgY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="390756406"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="390756406"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:44:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860817503"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="860817503"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:44:36 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 03/42] KVM: Introduce VM ioctl KVM_CREATE_TDP_FD
Date:   Sat,  2 Dec 2023 17:15:41 +0800
Message-Id: <20231202091541.13568-1-yan.y.zhao@intel.com>
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

Introduce VM ioctl KVM_CREATE_TDP_FD to create KVM TDP FD object, which
will act as an interface of KVM to export TDP page tables and communicate
with external components of KVM.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/uapi/linux/kvm.h | 19 +++++++++++++++++++
 virt/kvm/kvm_main.c      | 19 +++++++++++++++++++
 virt/kvm/tdp_fd.h        | 10 ++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 virt/kvm/tdp_fd.h

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 211b86de35ac5..f181883c60fed 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1582,6 +1582,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+/* ioctl for vm fd to create tdp fd */
+#define KVM_CREATE_TDP_FD	  _IOWR(KVMIO,  0xe4, struct kvm_create_tdp_fd)
+
 /*
  * ioctls for vcpu fds
  */
@@ -2267,4 +2270,20 @@ struct kvm_s390_zpci_op {
 /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
 
+/**
+ * struct kvm_create_tdp_fd - VM ioctl(KVM_CREATE_TDP_FD)
+ * Create a TDP fd object for a TDP exported by KVM.
+ *
+ * @as_id: in: Address space ID for this TDP.
+ * @mode:  in: Mode of this tdp.
+ *             Reserved for future usage. Currently, this field must be 0.
+ * @fd:    out: fd of TDP fd object for a TDP exported by KVM.
+ * @pad:   in: Reserved as 0.
+ */
+struct kvm_create_tdp_fd {
+	__u32 as_id;
+	__u32 mode;
+	__u32 fd;
+	__u32 pad;
+};
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 486800a7024b3..494b6301a6065 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -61,6 +61,7 @@
 #include "async_pf.h"
 #include "kvm_mm.h"
 #include "vfio.h"
+#include "tdp_fd.h"
 
 #include <trace/events/ipi.h>
 
@@ -4973,6 +4974,24 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_GET_STATS_FD:
 		r = kvm_vm_ioctl_get_stats_fd(kvm);
 		break;
+	case KVM_CREATE_TDP_FD: {
+		struct kvm_create_tdp_fd ct;
+
+		r = -EFAULT;
+		if (copy_from_user(&ct, argp, sizeof(ct)))
+			goto out;
+
+		r = kvm_create_tdp_fd(kvm, &ct);
+		if (r)
+			goto out;
+
+		r = -EFAULT;
+		if (copy_to_user(argp, &ct, sizeof(ct)))
+			goto out;
+
+		r = 0;
+		break;
+	}
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
diff --git a/virt/kvm/tdp_fd.h b/virt/kvm/tdp_fd.h
new file mode 100644
index 0000000000000..05c8a6d767469
--- /dev/null
+++ b/virt/kvm/tdp_fd.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TDP_FD_H
+#define __TDP_FD_H
+
+static inline int kvm_create_tdp_fd(struct kvm *kvm, struct kvm_create_tdp_fd *ct)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* __TDP_FD_H */
-- 
2.17.1

