Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DD7F9A07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjK0GjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0GjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:39:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9D113;
        Sun, 26 Nov 2023 22:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701067151; x=1732603151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wWLfgYUjzP+gqB9GkQe3X8Oga+Po8HH51kWXVclMi80=;
  b=fdJDnIfRyiI6heaeHpfEkygUnhDOBKJqaIxs7K8UYdybgBaBXdIHGk5Z
   hVfc+dlbYOjPaSJuWRFEI2x/mWkWogwNAB3XlxDQqmd/hfCAyT4Uhn8lV
   FG+brZXhBrMciibLA6+sIjpoUnLZnsTjyNbJkU2Stx+LJJ/nsmxApis14
   OR210OooaRt/u2WgQa/OnmVbm5ktDeXoy97ErUxnw9nHtyePrcHUry3D8
   OmVK+G3ElFutiKMcbzNIKbkbZGZ4bQ2rAcpuZF1oHrP8U3+82vEy3Yd6W
   fMmLLT3F8wCD9c99OnEwl8TUIBMFhQDlpfWtlITT/XRfVK7vv4eWmMxbT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="392397722"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="392397722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717940800"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="717940800"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2023 22:39:10 -0800
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
Subject: [PATCH 0/3] vfio-pci support pasid attach/detach
Date:   Sun, 26 Nov 2023 22:39:06 -0800
Message-Id: <20231127063909.129153-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the pasid attach/detach uAPIs for userspace to attach/detach
a PASID of a device to/from a given ioas/hwpt. Only vfio-pci driver is
enabled in this series. After this series, PASID-capable devices bound
with vfio-pci can report PASID capability to userspace and VM to enable
PASID usages like Shared Virtual Addressing (SVA).

This series first adds the helpers for pasid attach in vfio core and then
add the device cdev ioctls for pasid attach/detach, finally exposes the
device PASID capability to user. It depends on iommufd pasid attach/detach
series [1].

Complete code can be found at [2], tested with a draft Qemu branch[3]

[1] https://lore.kernel.org/linux-iommu/20231127063428.127436-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1%2Bpasid

Change log:

v1:
 - Report PASID capability via VFIO_DEVICE_FEATURE (Alex)

rfc: https://lore.kernel.org/linux-iommu/20230926093121.18676-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Kevin Tian (1):
  vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices

Yi Liu (2):
  vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
  vfio: Report PASID capability via VFIO_DEVICE_FEATURE ioctl

 drivers/vfio/device_cdev.c       | 45 +++++++++++++++++++++
 drivers/vfio/iommufd.c           | 48 ++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c      |  2 +
 drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++
 drivers/vfio/vfio.h              |  4 ++
 drivers/vfio/vfio_main.c         |  8 ++++
 include/linux/vfio.h             | 11 ++++++
 include/uapi/linux/vfio.h        | 68 ++++++++++++++++++++++++++++++++
 8 files changed, 233 insertions(+)

-- 
2.34.1

