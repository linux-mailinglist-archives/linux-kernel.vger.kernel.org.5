Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD57773F10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHHQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjHHQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:41:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC915CB5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510094; x=1723046094;
  h=from:to:cc:subject:date:message-id;
  bh=bZYKDkWN/NzViSoHo0Sz+w7bafCwSfAclgWR77m9hZM=;
  b=VL3+r+Joia9AEKj6g474X8WaPHVDN953ZisfX033av7/XysWTrw5kTzx
   34U9/lOVkcKyO25E0u9q2utSlMSO6M/JwHK2sHRWmSe6X3p62DUfe2W/b
   mgAV0w4RNqmVLy98+kI8HTiBU9ETC1vuHH25jlIsIXouv/uX2LIk6v75u
   znpNEcV0sj9eh0PNDO6WAkBDAmpRJyFMxXBMhnprb7wgKMdYKYfn4EfMY
   PLc2LHIpZm0SBJj880IcSqvYvF0yMsBUxv/59AdELXo+MnudssRUoBXhd
   oHFPJF7Bc3GRYOFfdcGFpnNTTweJDSEnmhIu24jugbliRG/3tyqJqYpLe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078606"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146258"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146258"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:49:49 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 0/5] Share sva domains with all devices bound to a mm
Date:   Tue,  8 Aug 2023 15:49:39 +0800
Message-Id: <20230808074944.7825-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sva domain's lifetime begins with binding a device to a mm and ends
by releasing all the bound devices from that sva domain. Technically,
there could be more than one sva domain identified by the mm PASID for
the use of bound devices issuing DMA transactions.

To support mm PASID 1:n with sva domains, each mm needs to keep both a
reference list of allocated sva domains and the corresponding PASID.
However, currently, mm struct only has one pasid field for sva usage,
which is used to keep the info of an assigned PASID. That pasid field
cannot provide sufficient info to build up the 1:n mapping between PASID
and sva domains.

This patch-set fills the gap by adding an mm_iommu field[1], whose type is
mm_iommu_data struct, to replace the old pasid field. The introduced
mm_iommu_data struct keeps info of both a reference list of sva domains
and an assigned PASID.


[1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/


The RFC version of this patch-set is here:
https://lore.kernel.org/linux-iommu/20230707013441.365583-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu: Add mm_get_pasid() helper function
  iommu: Call helper function to get assigned pasid value
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
 drivers/iommu/intel/svm.c                     |  8 +--
 drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
 include/linux/iommu.h                         | 19 +++++--
 include/linux/mm_types.h                      |  3 +-
 kernel/fork.c                                 |  1 -
 mm/init-mm.c                                  |  3 --
 8 files changed, 58 insertions(+), 40 deletions(-)

-- 
2.17.1

