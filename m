Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8167C4D76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbjJKIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjJKIot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:44:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013885; x=1728549885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FA+jyWK+BSN42cAZ+8JuVtQ0iB2leEc/ZRDAIJ0Y5OU=;
  b=cCupjOCJ/uIeMtSMNAwnSqBLmy3s00aSI+NPtF1Srks5QxjS7it5iHrr
   YRfKynLhK3tJx7UPoKOOE2yOa/BUzWQL3NzNZljAb5/NuoEU+nptHznpw
   ntN8h+eqTIpmhE9hZZpDT9T8dDq45ZxXAMNs5eYk1sJBqngI9X4QjI3G6
   skVKOXw+qHwXtFCSfgMc0VBeQIh+wKLdzXIvY0OaupID4NpyPANuw6Khx
   hz2F24FOi98ft95dTz7nwgz7G0IomoOH5lSnSe11rUuVjQboechHOgDvJ
   XwpWmnWDQpOihY2BzR0g8er/k24ZeYDiG30pTy3XJ5WwvhmiYy59BQ7/Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383474559"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="383474559"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877587364"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877587364"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 01:44:42 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v4 0/3] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Date:   Wed, 11 Oct 2023 16:39:12 +0800
Message-Id: <20231011083915.36706-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
device with pasid, i.e.
/sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
And create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
For the default domain without pasid, it creates a debugfs file in the
debugfs device directory for users to dump its page table. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
Remove the corresponding debugfs directory and file when detaching or
releasing a device.

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
    /sys/kernel/debug/iommu/intel/0000:00:01.0/domain_translation_struct

2) Dump the page table of device "0000:00:02.0" with PASID "1" that
   supports scalable mode.
   $ sudo cat
   /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

Change log:

v4:
 - Save the debugfs dentry in 'device_domain_info' and 'dev_pasid_info'
   structures to simplify debugfs operations per Baolu's review.
 - Use 'dev_pasid_info' to get the infomation of {device, pasid} pair
   when dumping the page table per Baolu's review.

v3: https://lore.kernel.org/linux-iommu/20230927151536.67319-1-Jingqi.liu@intel.com
 - Add domain as a parameter for creating debugfs pasid directory
   per Baolu's review.
 - dput() the dentry after debugfs_lookup() per Baolu's review.
 - debugfs device and pasid directory are managed separately per
   Baolu's review.

v2: https://lore.kernel.org/linux-iommu/20230922151636.77139-1-Jingqi.liu@intel.com
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

 drivers/iommu/intel/debugfs.c | 300 ++++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c   |  11 ++
 drivers/iommu/intel/iommu.h   |  18 ++
 3 files changed, 283 insertions(+), 46 deletions(-)

-- 
2.21.3

