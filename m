Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2C7F99DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjK0Ge1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0GeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:34:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76C93;
        Sun, 26 Nov 2023 22:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066871; x=1732602871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8V+xYNV0cvL7zGYJZTO/m6MOhpbNHj0iVzK6EBYh80Q=;
  b=K7drhoiJf/htiubRmBicvkGBzdo3J/BfpcvT7+jtQjVbD+PRPzHfZUUd
   IZJWGBKavfV7oJG30wrVVKtWEpMija2uVxB7LdDwQpz2h24Y/XCaIArQ1
   CQ0O8ZaURMJe4ZXXUbOdJppS/8HEuFjU86qt5MrF7ZHFr71EUJUnSwhnV
   PeuNlfktfDEybMfUDas4WbH81DnspB4SfgJzhhgHVzvRIdwlh6I5EwnyV
   4fDAfSE7GeE+qpJ4PpKzP4u68P5SwReFKu0j8U6cWUl+whsMEQayKKuwX
   iBF4Xlcw0J0Gbv+FHTV0Mnixyc+z7DbVN5pPEo+9gJsY34SxB7QfagDjx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518119"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608923"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608923"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:29 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: [PATCH 0/8] iommufd support pasid attach/replace
Date:   Sun, 26 Nov 2023 22:34:20 -0800
Message-Id: <20231127063428.127436-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PASID (Process Address Space ID) is a PCIe extension to tag the DMA
transactions out of a physical device, and most modern IOMMU hardware
have supported PASID granular address translation. So a PASID-capable
device can be attached to multiple hwpts (a.k.a. domains), each attachment
is tagged with a pasid.

This series first adds a missing iommu API to replace domain for a pasid,
then adds iommufd APIs for device drivers to attach/replace/detach pasid
to/from hwpt per userspace's request, and adds selftest to validate the
iommufd APIs.

pasid attach/replace is mandatory on Intel VT-d given the PASID table
locates in the physical address space hence must be managed by the kernel,
both for supporting vSVA and coming SIOV. But it's optional on ARM/AMD
which allow configuring the PASID/CD table either in host physical address
space or nested on top of an GPA address space. This series only add VT-d
support as the minimal requirement.

Complete code can be found in below link:

https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Change log:

v1:
 - Implemnet iommu_replace_device_pasid() to fall back to the original domain
   if this replacement failed (Kevin)
 - Add check in do_attach() to check corressponding attach_fn per the pasid value.

rfc: https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Kevin Tian (1):
  iommufd: Support attach/replace hwpt per pasid

Lu Baolu (2):
  iommu: Introduce a replace API for device pasid
  iommu/vt-d: Add set_dev_pasid callback for nested domain

Yi Liu (5):
  iommufd: replace attach_fn with a structure
  iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/iommu/intel/nested.c                  |  47 +++++
 drivers/iommu/iommu-priv.h                    |   2 +
 drivers/iommu/iommu.c                         |  82 ++++++--
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  50 +++--
 drivers/iommu/iommufd/iommufd_private.h       |  23 +++
 drivers/iommu/iommufd/iommufd_test.h          |  24 +++
 drivers/iommu/iommufd/pasid.c                 | 138 ++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 176 ++++++++++++++++--
 include/linux/iommufd.h                       |   6 +
 tools/testing/selftests/iommu/iommufd.c       | 172 +++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++++
 13 files changed, 785 insertions(+), 42 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1

