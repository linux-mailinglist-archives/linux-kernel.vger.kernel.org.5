Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C57ACE51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjIYCiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjIYCij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA694107
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609508; x=1727145508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x5U1vWa3UeoSrmulhaPIVKHCG6tOuJUpexK0hg7K4EA=;
  b=IV7isOfHdZHyl+jrGe/3KaIfFn4xG04QHN9YNx3w14lnzdEmoNz3gRux
   EcMk5ebgKl53FQB46is6vDGeVM+OuQg2iCxXdivb+YO3HyJVtURr7+lcA
   fy9SygYy2cIS52aEojQxQwLpb6HlxQfgFmNc3hkkL71kqnQoBQ7PO3lXX
   JNjLZG1W11e0OFr9k9FYahCddUK4QEQut9Tfg3+KfIKBxPyvqrv2Pr6ju
   9NQK8Hqn1eVkA1IMrMCAx5/45xq5ks6dqnSFbIY1/SQVEpkTi6NeJ2phh
   EpHPzi1rAEnBCW0H1MtQaxBp4PEeMszMZCzIT2D2YEeDxoTVVNwYnmCQ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360534564"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360534564"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777505050"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777505050"
Received: from jingxues-mobl1.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.214.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:24 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v5 0/6] Share sva domains with all devices bound to a mm
Date:   Mon, 25 Sep 2023 10:38:07 +0800
Message-Id: <20230925023813.575016-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
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

Tina Zhang (6):
  iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
  iommu: Add mm_get_enqcmd_pasid() helper function
  iommu: Introduce mm_get_pasid() helper function
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
 drivers/iommu/intel/svm.c                     | 14 +++---
 drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
 include/linux/iommu.h                         | 35 +++++++++++--
 include/linux/mm_types.h                      |  3 +-
 kernel/fork.c                                 |  1 -
 mm/init-mm.c                                  |  3 --
 8 files changed, 79 insertions(+), 41 deletions(-)

-- 
2.34.1

