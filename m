Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C06801C19
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjLBKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:04:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5E19F;
        Sat,  2 Dec 2023 02:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511473; x=1733047473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aDYDeaOzsRKl3ev8dC58rNFjF38aQ9l/2QXjjp0gHNA=;
  b=kuuNYiyc/pDkoT46m+N9x8z6QqhoASjGdUluT1jJFXb85y1a90tJGoO9
   U8ocQEdYuKY16rNuFoFZeK+gdEsxTDBzSuhg16enrqveXfWpzYG5bDSLL
   wEzvqI2VNJcxubuUqgXKWGI/AqpA3zos7jcZ1g6RAQ87udXb9efiIbgyj
   Jnn99j02n7MKDrN9QcKFhB5ROGxJg68Gi5pE9HqZwI27WnHzDgUDJgtOn
   qtMCbQz8x+fAAU0uaqXmxzJNXwUNcmcBp/u1L3lALUVku5axXKzh8NWyl
   t1IVCcTpr+A25kiSMCGz0wRTJadaooWBWDuvdz3siYO68dNSKlyGmLdqs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459638"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459638"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887939832"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887939832"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:30 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 39/42] KVM: VMX: add config KVM_INTEL_EXPORTED_EPT
Date:   Sat,  2 Dec 2023 17:35:35 +0800
Message-Id: <20231202093535.15874-1-yan.y.zhao@intel.com>
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

Add config KVM_INTEL_EXPORTED_EPT to let kvm_intel.ko support exporting EPT
to KVM external components (e.g. Intel VT-d).

This config will turn on HAVE_KVM_EXPORTED_TDP and
HAVE_KVM_MMU_PRESENT_HIGH automatically.

HAVE_KVM_MMU_PRESENT_HIGH will make bit 11 reserved as 0.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 950c12868d304..7126344077ab5 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -99,6 +99,19 @@ config X86_SGX_KVM
 
 	  If unsure, say N.
 
+config KVM_INTEL_EXPORTED_EPT
+	bool "export EPT to be used by other modules (e.g. iommufd)"
+	depends on KVM_INTEL
+	select HAVE_KVM_EXPORTED_TDP
+	select HAVE_KVM_MMU_PRESENT_HIGH if X86_64
+	help
+	  Intel EPT is architecturally guaranteed of compatible to stage 2
+	  page tables in Intel IOMMU.
+
+	  Enable this feature to allow Intel EPT to be exported and used
+	  directly as stage 2 page tables in Intel IOMMU.
+
+
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
-- 
2.17.1

