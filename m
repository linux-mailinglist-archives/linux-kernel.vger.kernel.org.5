Return-Path: <linux-kernel+bounces-164209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F18B7AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5EC281974
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C977112;
	Tue, 30 Apr 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgnTlBcf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBD770E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489130; cv=none; b=km167y3PeSmy3HsojG/n+NACwh+P7RSW3LwfmmuuRkvdP/TzXsll6z0tgQM1lMV5qqgUR6jDz/icZSdAtoVFaz7gBE1k8L2w+sFz7taDAhSzw97Bg66yZhzCOznL65fuYa9GLT6bKMI6x/Wvq7G7Gc4PcGhC49pylquscKDL3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489130; c=relaxed/simple;
	bh=JBVAR+sLuGoJYKowBGO4Ad8l5eFBbZOvpATG0wKcI6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R0KCVzS/QES7FN/JpF+9toG80nl1MUwb3qqdTIfqEKG7ppduqlOltE14nQq2R2Yy7X5jpT7mdpUdbelUk0jtSYF9+1ZkCkXyF/XjgO+f6a8k9+SWnFfOHfjO9mey0L5MiMtzFKqYXnVNkRlYxvHr6hfVs4B9J1z1QRAPVWjoW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgnTlBcf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489129; x=1746025129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JBVAR+sLuGoJYKowBGO4Ad8l5eFBbZOvpATG0wKcI6E=;
  b=AgnTlBcfMuXkBffoZZ2x1j4biXiVEGaFviQ9EfpVgoBRnFx2biuNfogW
   UJin8f5tv3OOKHn8933eUYjQRZEDg8jUMVtSunBX2srHKR1xLlDidLwJu
   T3LOPrEHTZdlVuuuFtiIpKKa96PlXICTaJKFf+gHp4wAzd/iHo5X5l5Tt
   SK3IohkSJb8zSp6uNotIYa0aJ5Ib9r7nmLSYVmxhuofK/prHO6CoH5sNY
   PS39maQuFqkTi4JQS0KVJII9Bodj2I95hLCChtApJc/TraYHPgAeEVATn
   y8fHrC64tsB9kCidJhDg21oSbgGiVxmBbQBLR/vyX9frnEmwiK1pBmTl0
   g==;
X-CSE-ConnectionGUID: VWPoaYx7TrS6Xp+0DNPDsw==
X-CSE-MsgGUID: nehywbi3QlimQBLcAPvFkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059815"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:58:49 -0700
X-CSE-ConnectionGUID: UXIgDc36RUabnKJBXrtVMQ==
X-CSE-MsgGUID: bU6XimoEQIyW+ufqsKOryg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282110"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:58:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/9] IOMMUFD: Deliver IO page faults to user space
Date: Tue, 30 Apr 2024 22:57:01 +0800
Message-Id: <20240430145710.68112-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the functionality of delivering IO page faults to
user space through the IOMMUFD framework. One feasible use case is the
nested translation. Nested translation is a hardware feature that
supports two-stage translation tables for IOMMU. The second-stage
translation table is managed by the host VMM, while the first-stage
translation table is owned by user space. This allows user space to
control the IOMMU mappings for its devices.

When an IO page fault occurs on the first-stage translation table, the
IOMMU hardware can deliver the page fault to user space through the
IOMMUFD framework. User space can then handle the page fault and respond
to the device top-down through the IOMMUFD. This allows user space to
implement its own IO page fault handling policies.

User space application that is capable of handling IO page faults should
allocate a fault object, and bind the fault object to any domain that it
is willing to handle the fault generatd for them. On a successful return
of fault object allocation, the user can retrieve and respond to page
faults by reading or writing to the file descriptor (FD) returned.

The iommu selftest framework has been updated to test the IO page fault
delivery and response functionality.

The series and related patches are available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v5

Change log:
v5:
 - Removed attach handle reference count from the core. Drivers will now
   synchronize their use of handles and domain attach/detach.
 - Automatically responds to all outstanding faults in hwpt detach or
   replace paths.
 - Supports getting a domain-type specific attach handle.
 - Reorganized the series by changing the patch order.
 - Miscellaneous cleanup.

v4: https://lore.kernel.org/linux-iommu/20240403011519.78512-1-baolu.lu@linux.intel.com/
 - Add the iommu domain attachment handle to replace the iopf-specific
   domain attachment interfaces introduced in the previous v3.
 - Replace the iommu_sva with iommu domain attachment handle.
 - Refine some fields in the fault and response message encoding
   according to feedback collected during v3 review period.
 - Refine and fix some problems in the fault FD implementation.
 - Miscellaneous cleanup.

v3: https://lore.kernel.org/linux-iommu/20240122073903.24406-1-baolu.lu@linux.intel.com/
 - Add iopf domain attach/detach/replace interfaces to manage the
   reference counters of hwpt and device, ensuring that both can only be
   destroyed after all outstanding IOPFs have been responded to. 
 - Relocate the fault handling file descriptor from hwpt to a fault
   object to enable a single fault handling object to be utilized
   across multiple domains.
 - Miscellaneous cleanup and performance improvements.

v2: https://lore.kernel.org/linux-iommu/20231026024930.382898-1-baolu.lu@linux.intel.com/
 - Move all iommu refactoring patches into a sparated series and discuss
   it in a different thread. The latest patch series [v6] is available at
   https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
 - We discussed the timeout of the pending page fault messages. We
   agreed that we shouldn't apply any timeout policy for the page fault
   handling in user space.
   https://lore.kernel.org/linux-iommu/20230616113232.GA84678@myrica/
 - Jason suggested that we adopt a simple file descriptor interface for
   reading and responding to I/O page requests, so that user space
   applications can improve performance using io_uring.
   https://lore.kernel.org/linux-iommu/ZJWjD1ajeem6pK3I@ziepe.ca/

v1: https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/

Lu Baolu (9):
  iommu: Introduce domain attachment handle
  iommu: Replace sva_iommu with iommu_attach_handle
  iommu: Add attachment handle to struct iopf_group
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Fault-capable hwpt attach/detach/replace
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  32 +-
 include/linux/uacce.h                         |   2 +-
 drivers/dma/idxd/idxd.h                       |   2 +-
 drivers/iommu/iommu-priv.h                    |  17 +
 drivers/iommu/iommufd/iommufd_private.h       |  43 ++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 122 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  84 +++-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/iommu/io-pgfault.c                    |  34 +-
 drivers/iommu/iommu-sva.c                     |  43 +-
 drivers/iommu/iommu.c                         | 156 +++++++-
 drivers/iommu/iommufd/device.c                |  16 +-
 drivers/iommu/iommufd/fault.c                 | 373 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  35 +-
 drivers/iommu/iommufd/main.c                  |   8 +-
 drivers/iommu/iommufd/selftest.c              |  63 +++
 drivers/misc/uacce/uacce.c                    |   2 +-
 tools/testing/selftests/iommu/iommufd.c       |  18 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 21 files changed, 959 insertions(+), 106 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1


