Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50787AB4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjIVPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIVPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:19:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D077100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395970; x=1726931970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DGjGBqtW0YmDzNhpM7gkO90ycKqRlM8UiiecicTQT7E=;
  b=CQDEHPLav7kvGIN/jy4/0Cgp1yjDnGHCIllT8OEj+LCpr+Fri5eoxFxx
   eo7KjFdIfNCQBkR/hiVtwda3W7FPqdWwLxRR47ViWYlW3oGL1e/UZ89al
   VDftFjgy1shvOdElhDGvFS/doqrLauLXtIcnrt3kHDVgiBqiONQ3f+R6m
   a7WSbMaRPq3cqFkQT78VQaRrQmgxg5Vfsm/fJQ2kLfZgT3OBwzqgS+mG2
   s+TvPwGsbKCiQxD/tZ9d1qOm8Wv0/kvRzU+Fbrx8IRdKMbLPvD7DXwlWC
   mKHox0NsqkhPx9QBlIgEK1KMrVfaCK0o5FZpjGamCqSCyBLxYgJA1S2y5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360235274"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360235274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741133124"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741133124"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2023 08:19:27 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH v2 0/3] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Date:   Fri, 22 Sep 2023 23:16:33 +0800
Message-Id: <20230922151636.77139-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original debugfs only dumps all IOMMU page tables without pasid
supported. It traverses all devices on the pci bus, then dumps all
page tables based on device domains. This traversal is from software
perspective.

This series dumps page tables whose mappings are created and destroyed
by the iommu_map/unmap() interfaces, by traversing root tables,
context tables, pasid directories and pasid tables from hardware
perspective. It supports dumping a specified page table in legacy mode
or scalable mode with or without a specified pasid.

It adds a debugfs directory per pair of {device, pasid} when attaching
device with or without pasid, i.e.
/sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
And create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/0/domain_translation_struct.
Each device has a PASID#0, i.e. RID_PASID. Remove the corresponding
debugfs directory and file when detaching or releasing a device.

For legacy mode, according to bus number and DEVFN, traverse the root
table and context table to get the pointer of page table in the
context table entry, then dump the specified page table.

For scalable mode, according to bus number, DEVFN and pasid, traverse
the root table, context table, pasid directory and pasid table to get
the pointer of page table in the pasid table entry, then dump the
specified page table.

Examples are as follows:
1) Dump the page table of device "0000:00:01.0" that only supports
    legacy mode.
    $ sudo cat
    /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct

2) Dump the page table of device "0000:00:02.0" with PASID "1" that
   supports scalable mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

Change log:

v2:
 - Add a debugfs directory per {dev, pasid} as suggested by Kevin.
 - Create the debugfs directory when attaching device as suggested by Baolu.
 - Only dump the page tables whose mappings are created and destroyed
   by the iommu_map/unmap() interfaces per Baolu's review.
 - Rename the helpers for creating/removing debugfs directory/file and
   merge patch 2,3,4,5 to one patch per Baolu's review.

v1: https://lore.kernel.org/linux-iommu/20230625150442.42197-1-Jingqi.liu@intel.com

Jingqi Liu (3):
  iommu/vt-d: debugfs: Dump entry pointing to huge page
  iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
  iommu/vt-d: debugfs: Support dumping a specified page table

 drivers/iommu/intel/debugfs.c | 291 ++++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c   |  16 ++
 drivers/iommu/intel/iommu.h   |   4 +
 3 files changed, 261 insertions(+), 50 deletions(-)

-- 
2.21.3

