Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C276D957
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjHBVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHBVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:19:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C3273D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011161; x=1722547161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7szUAj1MO0pduuFM3N+UrE5TnhGHuzoroH9LPy8/+7A=;
  b=MdShOnKw1kHsF77QDdM5jfh2hMVChU6SyZQsXaVX9ESmENnvdO+Ebu0C
   gYsMjKMthxMSyzvKaC2QwbNDad21EqoPninJ1KeMzOMqOgEoM3M0GkDHU
   Lg8+vOJQplvIRQ7iEDd3IjfsLfEXiV1sKzUMJ6/mfaCxK0Udl84tjuCkD
   L5vThjjkPPENRpojjMvtqJUzdH4lnzS4++zpKDPzFmCfaiGxZsCRsDQ13
   lZcBxA0J0t0eNk7TFt57qsCJBoLroFyi3lfu3Kq4RLGfBN/gzdAf0pZw7
   Sv767q2gu07L4oUUmsHFt/5exd5J500kl619bwFl4mgEec+xyDSzEKyNH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436118"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436118"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290759"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290759"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:19 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Will Deacon" <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v12 0/8] Re-enable IDXD kernel workqueue under DMA API
Date:   Wed,  2 Aug 2023 14:24:19 -0700
Message-Id: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg and all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD driver
can then re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series. (merged)
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v12:
	- no code change, improve commit messages and add Reviewed-by tags
v11:
	- Rebased onto Joerg's next tree (v6.5-rc1)
	- Split RIDPASID check in invalidation code into patch (6/8)
	- Renamed iommu_alloc_global_pasid_dev to iommu_alloc_global_pasid (2/8)
	- Added WARN_ON if no dev_pasid is found during remove (7/8)
v10:
	- Fix global PASID alloc function with device's max_pasid=0
v9:
	- Fix an IDXD driver issue where user interrupt enable bit got cleared
	  during device enable/disable cycle. Reported and tested by
	  Tony Zhu <tony.zhu@intel.com>
	- Rebased to v6.4-rc7
v8:
	- further vt-d driver refactoring (3-6) around set/remove device PASID
	  (Baolu)
	- make consistent use of NO_PASID in SMMU code (Jean)
	- fix off-by-one error in max PASID check (Kevin)
v7:
	- renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
	  (Jean)
	- simplify range checking for sva PASID (Baolu) 
v6:
	- use a simplified version of vt-d driver change for set_device_pasid
	  from Baolu.
	- check and rename global PASID allocation base
v5:
	- exclude two patches related to supervisor mode, taken by VT-d
	maintainer Baolu.
	- move PASID range check into allocation API so that device drivers
	  only need to pass in struct device*. (Kevin)
	- factor out helper functions in device-domain attach (Baolu)
	- make explicit use of RID_PASID across architectures
v4:
	- move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
	- dropped domain type check while disabling idxd system PASID (Baolu)

v3:
	- moved global PASID allocation API from SVA to IOMMU (Kevin)
	- remove #ifdef around global PASID reservation during boot (Baolu)
	- remove restriction on PASID 0 allocation (Baolu)
	- fix a bug in sysfs domain change when attaching devices
	- clear idxd user interrupt enable bit after disabling device( Fenghua)
v2:
	- refactored device PASID attach domain ops based on Baolu's early patch
	- addressed TLB flush gap
	- explicitly reserve RID_PASID from SVA PASID number space
	- get dma domain directly, avoid checking domain types

Jacob Pan (3):
  iommu: Generalize PASID 0 for normal DMA w/o PASID
  iommu: Move global PASID allocation from SVA to core
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

Lu Baolu (5):
  iommu/vt-d: Add domain_flush_pasid_iotlb()
  iommu/vt-d: Remove pasid_mutex
  iommu/vt-d: Make prq draining code generic
  iommu/vt-d: Prepare for set_dev_pasid callback
  iommu/vt-d: Add set_dev_pasid callback for dma domain

 drivers/dma/idxd/device.c                     |  39 ++---
 drivers/dma/idxd/dma.c                        |   5 +-
 drivers/dma/idxd/idxd.h                       |   9 +
 drivers/dma/idxd/init.c                       |  54 +++++-
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  16 +-
 drivers/iommu/intel/iommu.c                   | 157 +++++++++++++++---
 drivers/iommu/intel/iommu.h                   |   9 +
 drivers/iommu/intel/pasid.c                   |   2 +-
 drivers/iommu/intel/pasid.h                   |   2 -
 drivers/iommu/intel/svm.c                     |  62 +------
 drivers/iommu/iommu-sva.c                     |  29 ++--
 drivers/iommu/iommu.c                         |  28 ++++
 include/linux/iommu.h                         |  11 ++
 15 files changed, 287 insertions(+), 145 deletions(-)

-- 
2.25.1

