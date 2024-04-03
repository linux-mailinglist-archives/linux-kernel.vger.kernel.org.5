Return-Path: <linux-kernel+bounces-128914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB758961D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7EB2339F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82710A0D;
	Wed,  3 Apr 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaZO+v56"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8DFC0C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106986; cv=none; b=huVuukEHzxVDPE0xMbZwkFgmcMsrFzr56u4Un3QPnqmGF7W2qnRFP/NWD12SULW06J5RvICQpU+vElNjbMuIZmpv0AmkfUpAgVDwRlGK0sSTmYhDOKOYXwgYed4nFXjIWscVOzZwm1BC9J4visg8vZtZztL3zOnVVrXoXPdXNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106986; c=relaxed/simple;
	bh=C/LU1Jlwpb7DB0AiR4br+N1SMTz6Vau5VN7TeJPZZAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y9bEbYGHwuNuidSgOikghQUR9NBTDZpsg/cnrpxgmm3BUEmJgj6EQKyQHbjuXq8l4Z3T3sH5Tj76F43tPQ9XonsO9sPdegklG/vMP3duwaQomX4GdCC64C2m5q/UcREdqu7NLXeajiq64qJKqZl4wmyegV/cdgMdMoy01+wT1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaZO+v56; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106984; x=1743642984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C/LU1Jlwpb7DB0AiR4br+N1SMTz6Vau5VN7TeJPZZAE=;
  b=FaZO+v56EWI4Bt4pOg/2aZfulB6JmfAQ8I6PYPgEzCo7/lmSq20gcsTI
   H9JO+A8qEkiBYqpV1v3G2imnXkvnq/7YiGh70kU0vi6pnz5pFbjdC+Rtx
   1dEcF9rgn4BY5T/kBNj5enOaehh0nKRvBwbMw1G1OulntvSTZ3P04cN3c
   B8om/1yZL8k4kHDC/qmAc0O2uaBrkVVKKEQTNETiotZGXTVd6ADhy3Gnm
   Xtq4khfqwbUiEnoDi69EIC2aOknpaJj2x98Cha40CWj5nXvI9u4MszEzj
   IKId7VwC73LaUbyU3tWJD4fUgGBCJx+EfAkwnukVjlUrKWmSAUIbcJjTe
   g==;
X-CSE-ConnectionGUID: R9EFpKoPQ+OebdkuLlLoWA==
X-CSE-MsgGUID: 12/r5Zi1QKqwoJRs6HpHMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439701"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439701"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:23 -0700
X-CSE-ConnectionGUID: SonVAOAOSMC875vBrUutvQ==
X-CSE-MsgGUID: 0cNtGg+NQk6i+4OEZGq6eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953257"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:20 -0700
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
Subject: [PATCH v4 0/9] IOMMUFD: Deliver IO page faults to user space
Date: Wed,  3 Apr 2024 09:15:10 +0800
Message-Id: <20240403011519.78512-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v4

Change log:

v4:
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
  iommufd: Fault-capable hw page table attach/detach/replace
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  33 +-
 include/linux/uacce.h                         |   2 +-
 drivers/dma/idxd/idxd.h                       |   2 +-
 drivers/iommu/iommu-priv.h                    |   9 +
 drivers/iommu/iommufd/iommufd_private.h       |  43 ++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 122 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  84 +++-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/iommu/io-pgfault.c                    |  37 +-
 drivers/iommu/iommu-sva.c                     |  64 ++-
 drivers/iommu/iommu.c                         | 158 +++++++-
 drivers/iommu/iommufd/device.c                |  16 +-
 drivers/iommu/iommufd/fault.c                 | 372 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  36 +-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  63 +++
 drivers/misc/uacce/uacce.c                    |   2 +-
 tools/testing/selftests/iommu/iommufd.c       |  18 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 21 files changed, 968 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1


