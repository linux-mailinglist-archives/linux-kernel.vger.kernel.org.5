Return-Path: <linux-kernel+bounces-32451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024A835BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62114B22ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F68F15485;
	Mon, 22 Jan 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJngVLvI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09116416
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909474; cv=none; b=r6z/O0/v680yT8sd7VOougL/b6oduXuWibDNY10ovtSH85muni7eo53QPqDk+pSgIbj1z7f5EfwUKqE0OI9r3a1dBk4ozQ3fy6yQpifzPsWolLsyscWb2sFb9/DdQxVRh5xX7qh22p36lRgpSzWzKeTL8sb1U6u9j9YU6MLixCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909474; c=relaxed/simple;
	bh=WaeZbozXHzble1W02cueiTjc38Ii0RT3AX9RzeBAuRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pzzcs//BIxEioMR9/cVRdoigU4LVnNzjFBwWsTfJIj36oB8vd4IMGKfslx/c/HzwwTCtO7Fi2gq81NTqlqRlkRU95tLij1cGFxzlVZRoe16yue9fWHtOyqmA88A7IcTaezQzIskYi2tTmOtkMqCIUGAuwLiGPdsjdNQLMF0FP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJngVLvI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909473; x=1737445473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WaeZbozXHzble1W02cueiTjc38Ii0RT3AX9RzeBAuRA=;
  b=iJngVLvILBFpjOQVM9vO+sOS12IBRx2dgRLz8k8leq5dXUZ2VX4uK6Nc
   d48mMD8aPqd+ftoScUlV2YpaI5d4USkPrPIp9Z+VPMYKQDNvkhshIxvUc
   N9mscpKBVNyvwqSFc4QmwE4gcrPob72fuLm++69fRNDeIMiDriTtQ5Rng
   emzn3Ms4JNgWX/4EK5jPsPQm23zeQ9lNeuiRyhKDFtxb9Rf9z2+K8noeB
   4fMBE2Gemmfj8UAAvKpDeESIvZizSsryf7Lq9YX8tG/wDMR+TIRzV7Olo
   +CwVNK4k09KaZkS37oAI0/5prU5BnToGrlUx1CP6741bHw/3Zdk9xKH+L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611477"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611477"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778504953"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778504953"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:27 -0800
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
Subject: [PATCH v3 0/8] IOMMUFD: Deliver IO page faults to user space
Date: Mon, 22 Jan 2024 15:38:55 +0800
Message-Id: <20240122073903.24406-1-baolu.lu@linux.intel.com>
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

This series is based on the page fault handling framework refactoring
in the IOMMU core [1].

The series and related patches are available on GitHub: [2]

[1] https://lore.kernel.org/linux-iommu/20240122054308.23901-1-baolu.lu@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v3

Best regards,
baolu

Change log:

v3:
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

Lu Baolu (8):
  iommu: Add iopf domain attach/detach/replace interface
  iommu/sva: Use iopf domain attach/detach interface
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd: IOPF-capable hw page table attach/detach/replace
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  40 +-
 drivers/iommu/iommufd/iommufd_private.h       |  41 ++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  |  91 ++++
 tools/testing/selftests/iommu/iommufd_utils.h |  83 +++-
 drivers/iommu/io-pgfault.c                    | 215 ++++++++--
 drivers/iommu/iommu-sva.c                     |  48 ++-
 drivers/iommu/iommufd/device.c                |  16 +-
 drivers/iommu/iommufd/fault.c                 | 391 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  36 +-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  63 +++
 tools/testing/selftests/iommu/iommufd.c       |  17 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 15 files changed, 1001 insertions(+), 57 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1


