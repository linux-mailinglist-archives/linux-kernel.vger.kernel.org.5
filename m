Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64A7C632A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjJLDBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjJLDB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:01:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BF94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697079687; x=1728615687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fl/EXghDTPSZgzFJRiBLR2GJ5KCltdo2NJB+HICye9A=;
  b=dBO8GqUXiacU+heDS+0TP3nw1IA6Su+R3WYwvBB4mQdrIZwKZMSJCIM7
   Ne6Wmi61NFsG7mnEhaJR/mnnUeED4gB0t/q//0SVOiqv6ngr6PcK/cdJo
   BqgZOS9AI6+gL4+cn81eSVelOmXUpWZv8G2zuMu0FqSaq5cyau1q7nhM1
   CUpy+9ab7xSuBKMmvFGFyaFxeKT6gTE4rJ4INkS1zU3UlV92bFkfvcyZJ
   2qJ3mbH2ALMBFaL/mAsvWEt5tei+Y3WvowCOK4Tyutdr+Gb20/RGBE9Mb
   VY5d9obTSV+YAdq6uKKpyXZPOOesSD20c0Dwa2jSoyIR065mSodGCb0TN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="6371383"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="6371383"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 20:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730736482"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="730736482"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2023 20:01:15 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Nicolin Chen ^C-cc=iommu @ lists . linux . dev" 
        <nicolinc@nvidia.com>, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v7 0/5] Share sva domains with all devices bound to a mm
Date:   Thu, 12 Oct 2023 11:01:07 +0800
Message-Id: <20231012030112.82270-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

v7:
  - Add mm_pasid_init() back and do zeroing mm->iommu_mm pointer in
    mm_pasid_init() to avoid the use-after-free/double-free problem.
  - Update the commit message of patch "iommu: Add mm_get_enqcmd_pasid()
    helper function".

v6:
 - Rename iommu_sva_alloc_pasid() to iommu_alloc_mm_data().
 - Hold the iommu_sva_lock before invoking iommu_alloc_mm_data().
 - Remove "iommu: Introduce mm_get_pasid() helper function" patch, because
   SMMUv3 decides to use mm_get_enqcmd_pasid() instead and other users are
   using iommu_sva_get_pasid() to get the pasid value. Besides, the iommu
   core accesses iommu_mm_data in the critical section protected by
   iommu_sva_lock. So no need to add another helper to retrieve PASID
   atomically.

v5:
 - Order patch "iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()"
   first in this series.
 - Update commit message of patch "iommu: Introduce mm_get_pasid()
   helper function"
 - Use smp_store_release() & READ_ONCE() in storing and loading mm's
   pasid value.

v4:
 - Rebase to v6.6-rc1.

v3:
 - Add a comment describing domain->next.
 - Expand explanation of why PASID isn't released in
   iommu_sva_unbind_device().
 - Add a patch to remove mm->pasid in intel_sva_bind_mm()

v2:
 - Add mm_get_enqcmd_pasid().
 - Update commit message.

v1: https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

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
 include/linux/iommu.h                         | 33 ++++++-
 include/linux/mm_types.h                      |  3 +-
 mm/init-mm.c                                  |  3 -
 7 files changed, 102 insertions(+), 59 deletions(-)

-- 
2.39.3

