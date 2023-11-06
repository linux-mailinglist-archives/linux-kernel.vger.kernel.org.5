Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990517E1AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjKFHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:14:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D5CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254839; x=1730790839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E6/kgqA9Lo5JBiyk0XaJAk9Nzct4odqOsifYkRlm8ZI=;
  b=NQZxqehOr5giCw/JVIsO+cd6Gz6KO3yg5FbgSEA2VP51gXj5nU8zDfFq
   cBFIEbCFUl3KLgnwpi/TmHfwYN9G9NPLiR9D1l5H/erbJE9Vn4N1EhRhV
   /VyvTosKJvaGSg5VWA2dr8Cs/0Qp4O26dComYRLJfHsSFSQ0hq/0R8jTk
   wCGTGDu5KR4ECfTcfnnJWGQLWXjQHv1Hh+TwEVxsxKYWRm1w8pqp2Vi1G
   C1zGNZMg+lJureajyEe0rEKMAkTVz/B3Eq80EpHtxEw7IrjszU5t/ROFw
   +oepM/bzHkqyVZ03nqIDpE0nAtgoSpLF1uGIBKgwdF5OZ5x8eDkWtQLp7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759035"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10759035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690826"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093690826"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain) ([10.239.48.212])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:13:55 -0800
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 0/5] virtio-iommu: Add VT-d IO page table
Date:   Mon,  6 Nov 2023 02:12:21 -0500
Message-Id: <20231106071226.9656-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proposal about virtio-iommu support page tables is being discussed in
the virtio-comment mailing list[1]. This patch-set based on Jean's
virtio-iommu/pgtables branch[2] tries to follow the proposal and add the
basic VT-d IO page table support to virtio-iommu.

On Intel platform with VT-d nested translation enabled, there are two
main benefits for enabling virtual IOMMU support VT-d IO page table:
1) Allowing vSVM (aka vSVA) usage. Virtual Shared Virtual Addressing
   (vSVA) allows the virtual processor and virtual device to use the
   same virtual addresses.
2) Accelerating DMA buffer map operation for vIOVA usage by removing
   the context switch on DMA buffer map operation.
(Note: this patch-set doesn't include the whole patch-set for enabling
vSVM on virtio-iommu, only includes the part for vIOVA case. However,
the vSVM enabling patch-set needs to base on this patch-set.)

There are three changes in this patch-set:
1) The first patch is a bug fixing patch that tries to resolve an issue
   about IOTLB invalidation request with incorrect page size.
2) The next 3 patches are about adding generic IO page table support to
   VT-d driver.
3) The last one introduces the VT-d page format table to virtio-iommu
   driver.

The patch-set is also available at github:
https://github.com/TinaZhangZW/linux/tree/vt-d-pgtable

The QEMU part is available here:
https://github.com/TinaZhangZW/qemu/tree/virtio-iommu/vt-d-pgtable


[1]:https://lists.oasis-open.org/archives/virtio-comment/202310/msg00018.html
[2]:https://jpbrucker.net/git/linux/log/?h=virtio-iommu/pgtables

Tina Zhang (5):
  iommu/virtio-iommu: Correct the values of granule and nr_pages
  iommu/vt-d: Add generic IO page table support
  iommu/io-pgtable: Introduce struct vtd_cfg
  iommu/vt-d: Adapt alloc_pgtable interface to be used by others
  iommu/virtio-iommu: Support attaching VT-d IO pgtable

 drivers/iommu/intel/Kconfig       |   1 +
 drivers/iommu/intel/iommu.c       | 157 ++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h       |   7 ++
 drivers/iommu/io-pgtable.c        |   3 +
 drivers/iommu/virtio-iommu.c      |  27 ++++-
 include/linux/io-pgtable.h        |   7 ++
 include/uapi/linux/virtio_iommu.h |  26 +++++
 7 files changed, 226 insertions(+), 2 deletions(-)

-- 
2.39.3

