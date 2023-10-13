Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0527C8756
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjJMOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJMOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF9BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697205842; x=1728741842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L+BJl8arir8twRp0z5G9kzK3Wv1CSeE9gmszGMCzHgI=;
  b=LpCalEgvWZzBe7oPem8T3St4Qm5cMSZ22T2kqgawzPk7O/0nJejkty1Y
   zGuVbsnvpSz1PDzEpo5mjtCuYee2FHwdWylmuka4eYbSYwz2KxDpLAdsg
   qkU2AhljVOiYw5uH03Of6K3TUo0o06GWDxwkxgGId6Ze+rUciDRqMdezn
   dalxL/zKryGKcHvhaIEkOm1+MKkTkX69EwkIaXpuzJsWMBhamtCp3eWZw
   qhRo8AkTtEWPq7jre7hBKZCNnlC8FXsKbX2zGWHkqxjKWpD0TkPM8mSD2
   8kPkBGKjxV8s+CxuIDkpBYzJxGWFMRtJRh+uU6w5tKXdnXd4UpV0zFgv1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384049296"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384049296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 07:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1086156301"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086156301"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2023 07:03:57 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v5 0/3] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Date:   Fri, 13 Oct 2023 21:58:08 +0800
Message-Id: <20231013135811.73953-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
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

The original debugfs only dumps all IOMMU page tables without pasid
supported. It traverses all devices on the pci bus, then dumps all
page tables based on device domains. This traversal is from software
perspective.

This series dumps page tables whose mappings are created and destroyed
by the iommu_map/unmap() interfaces, by traversing root tables,
context tables, pasid directories and pasid tables from hardware
perspective. It supports dumping a specified page table in legacy mode
or scalable mode with or without a specified pasid.

It adds a debugfs directory per pair of {device, pasid} when setting a
domain to a PASID of device. i.e.
/sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
And create a debugfs file in the directory for users to dump the page
table corresponding to {device, pasid}. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
For the default domain without pasid, it creates a debugfs file in the
debugfs device directory for users to dump its page table. e.g.
/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
Remove the corresponding debugfs device directory when releasing a
device.

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

v5:
 - Simplify the parameters for creating debugfs PASID directory per
   Baolu's review.
 - Simplify some checks before debugfs operations and fix some coding
   style per Baolu's review.

v4: https://lore.kernel.org/linux-iommu/20231011083915.36706-1-Jingqi.liu@intel.com
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

Thanks,
Jingqi

Jingqi Liu (3):
  iommu/vt-d: debugfs: Dump entry pointing to huge page
  iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
  iommu/vt-d: debugfs: Support dumping a specified page table

 drivers/iommu/intel/debugfs.c | 216 +++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c   |   7 ++
 drivers/iommu/intel/iommu.h   |  14 +++
 3 files changed, 196 insertions(+), 41 deletions(-)

-- 
2.21.3

