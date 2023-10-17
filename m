Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81567CB798
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjJQAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjJQAse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:48:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2C92
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697503712; x=1729039712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wQ/wv0mJZcu/O5GpFIU4wq1sZeD6JKJ1NP5p7NJkmsU=;
  b=Abyx9VVS5fYZMx3jJVjuJk1s9gqqGHyEiJzeciYfbs1HVYpbKT32f+k9
   /O1wBgbERo4jaFM1VHjrISJ1hsEgxvHapdQkmnNxjV2RmjMVn6J6iGxtr
   pVI3ECUu3+CsgtMTYYE0c8xEnyl7H0HS2GWn+ZN0WCaqAVlqm6vlTYp6m
   P8TyX938kIJs7K/9ZSBKzwQJpc2g6JJ1oHlZsdWdFQahBoGOVQX8GCSmT
   cRgxiCfzaHA1IbJkdOWIRefFK7A4jQWlP3VQ3dTAShO4vzdzdWBDRYaPt
   DmQKBIFr1f9RJKn1+Y2nEY5p8rgosZPkEdJKrtWAmJzp46YjgRttJ56rx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382893235"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="382893235"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705793664"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705793664"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2023 17:48:25 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v8 0/5] Share sva domains with all devices bound to a mm
Date:   Tue, 17 Oct 2023 08:47:57 +0800
Message-Id: <20231017004802.109618-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to share sva(shared virtual addressing) domains with all
devices bound to one mm.

Problem
-------
In the current iommu core code, sva domain is allocated per IOMMU group,
when device driver is binding a process address space to a device (which is
handled in iommu_sva_bind_device()). If one than more device is bound to
the same process address space, there must be more than one sva domain
instance, with each device having one. In other words, the sva domain
doesn't share between those devices bound to the same process address
space, and that leads to two problems:
1) device driver has to duplicate sva domains with enqcmd, as those sva
domains have the same PASID and are relevant to one virtual address space.
This makes the sva domain handling complex in device drivers.
2) IOMMU driver cannot get sufficient info of the IOMMUs that have
devices behind them bound to the same virtual address space, when handling
mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
performed per device instead of per IOMMU, and that may lead to
superfluous IOTLB invalidation issue, especially in a virtualization
environment where all devices may be behind one virtual IOMMU.

Solution
--------
This patch-set tries to fix those two problems by allowing sharing sva
domains with all devices bound to a mm. To achieve this, a new structure
pointer is introduced to mm to replace the old PASID field, which can keep
the info of PASID as well as the corresponding shared sva domains.
Besides, function iommu_sva_bind_device() is updated to ensure a new sva
domain can only be allocated when the old ones cannot work for the IOMMU.
With these changes, a device driver can expect one sva domain could work
for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
their devices bound to one virtual address space) when handling
mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.

Arguably there shouldn't be more than one sva_domain with the same PASID,
and in any sane configuration there should be only 1 type of IOMMU driver
that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
may not be identical to each other. Thus, attaching a sva domain that has
been successfully bound to device A behind a IOMMU A, to device B behind
IOMMU B may get failed due to the difference between IOMMU A and IOMMU
B. In this case, a new sva domain with the same PASID needs to be
allocated to work with IOMMU B. That's why we need a list to keep sva
domains of one PASID. For the platform where IOMMUs are compatible to each
other, there should be one sva domain in the list.

v8:
 - CC more people
 - CC iommu@lists.linux.dev mailing list.
   When sending version 7, some issue happened in my CC list and that caused
   version 7 wasn't sent to iommu@lists.linux.dev.
 - Rebase to v6.6-rc6 and make a few format changes.

v7: https://lore.kernel.org/lkml/20231012030112.82270-1-tina.zhang@intel.com/
 - Add mm_pasid_init() back and do zeroing mm->iommu_mm pointer in
   mm_pasid_init() to avoid the use-after-free/double-free problem.
 - Update the commit message of patch "iommu: Add mm_get_enqcmd_pasid()
   helper function".

v6: https://lore.kernel.org/linux-iommu/20231011065132.102676-1-tina.zhang@intel.com/
 - Rename iommu_sva_alloc_pasid() to iommu_alloc_mm_data().
 - Hold the iommu_sva_lock before invoking iommu_alloc_mm_data().
 - Remove "iommu: Introduce mm_get_pasid() helper function" patch, because
   SMMUv3 decides to use mm_get_enqcmd_pasid() instead and other users are
   using iommu_sva_get_pasid() to get the pasid value. Besides, the iommu
   core accesses iommu_mm_data in the critical section protected by
   iommu_sva_lock. So no need to add another helper to retrieve PASID
   atomically.

v5: https://lore.kernel.org/linux-iommu/20230925023813.575016-1-tina.zhang@intel.com/
 - Order patch "iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()"
   first in this series.
 - Update commit message of patch "iommu: Introduce mm_get_pasid()
   helper function"
 - Use smp_store_release() & READ_ONCE() in storing and loading mm's
   pasid value.

v4: https://lore.kernel.org/linux-iommu/20230912125936.722348-1-tina.zhang@intel.com/
 - Rebase to v6.6-rc1.

v3: https://lore.kernel.org/linux-iommu/20230905000930.24515-1-tina.zhang@intel.com/
 - Add a comment describing domain->next.
 - Expand explanation of why PASID isn't released in
   iommu_sva_unbind_device().
 - Add a patch to remove mm->pasid in intel_sva_bind_mm()

v2: https://lore.kernel.org/linux-iommu/20230827084401.819852-1-tina.zhang@intel.com/
 - Add mm_get_enqcmd_pasid().
 - Update commit message.

v1: https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

RFC: https://lore.kernel.org/linux-iommu/20230707013441.365583-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
  iommu: Add mm_get_enqcmd_pasid() helper function
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 +--
 drivers/iommu/intel/svm.c                     | 14 +--
 drivers/iommu/iommu-sva.c                     | 94 +++++++++++--------
 include/linux/iommu.h                         | 38 +++++++-
 include/linux/mm_types.h                      |  3 +-
 mm/init-mm.c                                  |  3 -
 7 files changed, 107 insertions(+), 59 deletions(-)

-- 
2.39.3

