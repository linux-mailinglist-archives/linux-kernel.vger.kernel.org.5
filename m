Return-Path: <linux-kernel+bounces-128923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C88961E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D02528AB87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F28FC01;
	Wed,  3 Apr 2024 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/YsNHvq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA6446D2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107015; cv=none; b=PpLAxxT6aYDqL+NDpmpKktzKyteyOSKjCcHevq7sJ9ZWA6XDElJ59P1NWbezhYi8GRfXw8qwL2WFDdyk6+v/pY8Gj6ZEblqiEC1zbPBno+KpsQ1977CYitFNomuY41xURHIbHwaovqk0StQRyYN/eH6uwcqL0lYMOV/mDPecmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107015; c=relaxed/simple;
	bh=neT7HYgXLCtrbErknLj1hAcQ6/k/SrXq7wSzsrM+fa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGry+zCPhtmyYH06uI4huFyfOC2/WsJ2SftM0RlA1gnmMU8zQqIh9kg5lNl+7WDRu/3u1Fu2LAb4grlUD56n7B8Ba65omw4R112jjrbHqSHKWTttWIUQR6HJH05rqLoxXn/BMePMYdNifEH3BxWtyNBynL8QaeWCj18kgDSp+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/YsNHvq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712107014; x=1743643014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=neT7HYgXLCtrbErknLj1hAcQ6/k/SrXq7wSzsrM+fa4=;
  b=C/YsNHvqT5YEfLnf65+/NCGZwXCYJ6C5fdxAsIHPFW7Xc63inm1gmNNO
   Nh/f7n0K7miOl9cK2J3xiUgsDWn0Epb8T6KiL2exqR7WIyP5vxyNbUBBq
   uw99dq5IKy/sHyAqRNaBCxnGHIKSLm3Ucoe3mHt50nFnCh20w6fRydZkh
   pLgZUMyKmnUNhBAKWsSkgX3IMrVr6peP6Nytxef6hI4VVlAOWp/a0HIPT
   YZ2K5sEbrdWspXUuIqOW5sD5032xhHFTQ7JZSD0+BYObibx7gG2Du2XkH
   6G+2qGxTCeEA1Kh90x/hCxvCnyRb3HvX82KrVXgpqiinnSs2uC9Vlm7eW
   A==;
X-CSE-ConnectionGUID: zoijDNw6RcGVrq44kNVKnA==
X-CSE-MsgGUID: pwWbPdSdQb2G4eUT8E17CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439831"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:54 -0700
X-CSE-ConnectionGUID: /qeztM9GTViGmj+xMRLi2w==
X-CSE-MsgGUID: klNvT7QhSK6IJstrrXZsVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953335"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:51 -0700
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
Subject: [PATCH v4 9/9] iommufd/selftest: Add coverage for IOPF test
Date: Wed,  3 Apr 2024 09:15:19 +0800
Message-Id: <20240403011519.78512-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403011519.78512-1-baolu.lu@linux.intel.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the selftest tool to add coverage of testing IOPF handling. This
would include the following tests:

- Allocating and destroying an iommufd fault object.
- Allocating and destroying an IOPF-capable HWPT.
- Attaching/detaching/replacing an IOPF-capable HWPT on a device.
- Triggering an IOPF on the mock device.
- Retrieving and responding to the IOPF through the file interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 84 +++++++++++++++++--
 tools/testing/selftests/iommu/iommufd.c       | 18 ++++
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8d2b46b2114d..7f33389e070c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -153,7 +153,7 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, stdev_id, \
 							   pt_id, NULL))
 
-static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
+static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_id,
 				__u32 flags, __u32 *hwpt_id, __u32 data_type,
 				void *data, size_t data_len)
 {
@@ -165,6 +165,7 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 		.data_type = data_type,
 		.data_len = data_len,
 		.data_uptr = (uint64_t)data,
+		.fault_id = ft_id,
 	};
 	int ret;
 
@@ -177,24 +178,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 }
 
 #define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id)                  \
-	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,   \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, flags,   \
 					  hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, \
 					  0))
 #define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)   \
 	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(                      \
-				     self->fd, device_id, pt_id, flags, \
+				     self->fd, device_id, pt_id, 0, flags, \
 				     hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, 0))
 
 #define test_cmd_hwpt_alloc_nested(device_id, pt_id, flags, hwpt_id,         \
 				   data_type, data, data_len)                \
-	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, flags, \
 					  hwpt_id, data_type, data, data_len))
 #define test_err_hwpt_alloc_nested(_errno, device_id, pt_id, flags, hwpt_id, \
 				   data_type, data, data_len)                \
 	EXPECT_ERRNO(_errno,                                                 \
-		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
+		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, flags, \
 					  hwpt_id, data_type, data, data_len))
 
+#define test_cmd_hwpt_alloc_iopf(device_id, pt_id, fault_id, flags, hwpt_id,    \
+				   data_type, data, data_len)                   \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, fault_id, \
+					  flags, hwpt_id, data_type, data,      \
+					  data_len))
+
 #define test_cmd_hwpt_check_iotlb(hwpt_id, iotlb_id, expected)                 \
 	({                                                                     \
 		struct iommu_test_cmd test_cmd = {                             \
@@ -684,3 +691,70 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 
 #define test_cmd_get_hw_capabilities(device_id, caps, mask) \
 	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, 0, &caps))
+
+static int _test_ioctl_fault_alloc(int fd, __u32 *fault_id, __u32 *fault_fd)
+{
+	struct iommu_fault_alloc cmd = {
+		.size = sizeof(cmd),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_FAULT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	*fault_id = cmd.out_fault_id;
+	*fault_fd = cmd.out_fault_fd;
+	return 0;
+}
+
+#define test_ioctl_fault_alloc(fault_id, fault_fd)                       \
+	({                                                               \
+		ASSERT_EQ(0, _test_ioctl_fault_alloc(self->fd, fault_id, \
+						     fault_fd));         \
+		ASSERT_NE(0, *(fault_id));                               \
+		ASSERT_NE(0, *(fault_fd));                               \
+	})
+
+static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
+{
+	struct iommu_test_cmd trigger_iopf_cmd = {
+		.size = sizeof(trigger_iopf_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_IOPF,
+		.trigger_iopf = {
+			.dev_id = device_id,
+			.pasid = 0x1,
+			.grpid = 0x2,
+			.perm = IOMMU_PGFAULT_PERM_READ | IOMMU_PGFAULT_PERM_WRITE,
+			.addr = 0xdeadbeaf,
+		},
+	};
+	struct iommu_hwpt_page_response response = {
+		.size = sizeof(struct iommu_hwpt_page_response),
+		.dev_id = device_id,
+		.pasid = 0x1,
+		.grpid = 0x2,
+		.code = 0,
+	};
+	struct iommu_hwpt_pgfault fault = {};
+	ssize_t bytes;
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_IOPF), &trigger_iopf_cmd);
+	if (ret)
+		return ret;
+
+	bytes = read(fault_fd, &fault, sizeof(fault));
+	if (bytes <= 0)
+		return -EIO;
+
+	response.cookie = fault.cookie;
+
+	bytes = write(fault_fd, &response, sizeof(response));
+	if (bytes <= 0)
+		return -EIO;
+
+	return 0;
+}
+
+#define test_cmd_trigger_iopf(device_id, fault_fd) \
+	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index edf1c99c9936..5b0169875a4d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -279,6 +279,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 	uint32_t parent_hwpt_id = 0;
 	uint32_t parent_hwpt_id_not_work = 0;
 	uint32_t test_hwpt_id = 0;
+	uint32_t iopf_hwpt_id;
+	uint32_t fault_id;
+	uint32_t fault_fd;
 
 	if (self->device_id) {
 		/* Negative tests */
@@ -326,6 +329,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   sizeof(data));
 
 		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_ioctl_fault_alloc(&fault_id, &fault_fd);
 		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
 					   &nested_hwpt_id[0],
 					   IOMMU_HWPT_DATA_SELFTEST, &data,
@@ -334,6 +338,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   &nested_hwpt_id[1],
 					   IOMMU_HWPT_DATA_SELFTEST, &data,
 					   sizeof(data));
+		test_cmd_hwpt_alloc_iopf(self->device_id, parent_hwpt_id, fault_id,
+					 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+					 IOMMU_HWPT_DATA_SELFTEST, &data,
+					 sizeof(data));
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0],
 					      IOMMU_TEST_IOTLB_DEFAULT);
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1],
@@ -504,14 +512,24 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
 		test_ioctl_destroy(nested_hwpt_id[0]);
 
+		/* Switch from nested_hwpt_id[1] to iopf_hwpt_id */
+		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+		/* Trigger an IOPF on the device */
+		test_cmd_trigger_iopf(self->device_id, fault_fd);
+
 		/* Detach from nested_hwpt_id[1] and destroy it */
 		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
 		test_ioctl_destroy(nested_hwpt_id[1]);
+		test_ioctl_destroy(iopf_hwpt_id);
 
 		/* Detach from the parent hw_pagetable and destroy it */
 		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(parent_hwpt_id);
 		test_ioctl_destroy(parent_hwpt_id_not_work);
+		close(fault_fd);
+		test_ioctl_destroy(fault_id);
 	} else {
 		test_err_hwpt_alloc(ENOENT, self->device_id, self->ioas_id, 0,
 				    &parent_hwpt_id);
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f590417cd67a..c5d5e69452b0 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id,
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, 0, &hwpt_id,
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
-- 
2.34.1


