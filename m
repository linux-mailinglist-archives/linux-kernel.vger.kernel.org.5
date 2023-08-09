Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD7775FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHIMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F81BFF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585424; x=1723121424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rILMLf+tn+A62NOPg8CdxcaaGELEWihPPF22lpcqp3E=;
  b=Y5afsCBi/4VEqw1BfkzToktAHsYc6ebXgiCVfbTb/5NjopvO8oqm14cd
   CDjVq5eUIVQByeJzqQCTzv9fLBh31gAGLUPuEwPalu7RYKmdR7d7ld3VJ
   3/xP3wtdpAhR5FPkB1GjeWzzsicZQWYDtwabYwuh24jISLihnojrcSfwL
   nJJ5SfECGgeMVo7tu/lpT39wamjC9MAYZHhe/AfhY5nBC9KmP7+OiEdwX
   Y1tDkGSfrcM/XP2GT6V78Qm7/+JN7AAPpYoYHE84qWrZWdb+LpeIWgzeX
   selTHgr7XC2Xgogm4sirwTOQDpJg+6sV2OcZvINmBnq/VNR5deqx5cW/G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821659"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821659"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521641"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521641"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] [PULL REQUEST] Intel IOMMU updates for Linux v6.6
Date:   Wed,  9 Aug 2023 20:47:53 +0800
Message-Id: <20230809124806.45516-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This includes patches queued for v6.6. They aim to:

 - Enable idxd device DMA with pasid through iommu dma ops.
 - Lift RESV_DIRECT check from VT-d driver to core.
 - Miscellaneous cleanups and fixes.

All patches are based on top of the next branch and vt-d patches can
apply to v6.5-rc5 as well.

The series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.6

Please consider them for v6.6-rc1.

Best regards,
Baolu

Jacob Pan (3):
  iommu: Generalize PASID 0 for normal DMA w/o PASID
  iommu: Move global PASID allocation from SVA to core
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

Lu Baolu (7):
  iommu/vt-d: Add domain_flush_pasid_iotlb()
  iommu/vt-d: Remove pasid_mutex
  iommu/vt-d: Make prq draining code generic
  iommu/vt-d: Prepare for set_dev_pasid callback
  iommu/vt-d: Add set_dev_pasid callback for dma domain
  iommu: Prevent RESV_DIRECT devices from blocking domains
  iommu/vt-d: Remove rmrr check in domain attaching device path

Yanfei Xu (2):
  iommu/vt-d: Fix to flush cache of PASID directory table
  iommu/vt-d: Fix to convert mm pfn to dma pfn

YueHaibing (1):
  iommu/vt-d: Remove unused extern declaration dmar_parse_dev_scope()

 include/linux/dmar.h                          |   2 -
 include/linux/iommu.h                         |  13 +
 drivers/dma/idxd/idxd.h                       |   9 +
 drivers/iommu/intel/iommu.h                   |   9 +
 drivers/iommu/intel/pasid.h                   |   2 -
 drivers/dma/idxd/device.c                     |  39 ++-
 drivers/dma/idxd/dma.c                        |   5 +-
 drivers/dma/idxd/init.c                       |  54 +++-
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  16 +-
 drivers/iommu/intel/iommu.c                   | 237 +++++++++++-------
 drivers/iommu/intel/pasid.c                   |   4 +-
 drivers/iommu/intel/svm.c                     |  62 +----
 drivers/iommu/iommu-sva.c                     |  29 +--
 drivers/iommu/iommu.c                         |  65 ++++-
 16 files changed, 330 insertions(+), 225 deletions(-)

-- 
2.34.1

