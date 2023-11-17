Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4B7EF35D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjKQNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjKQNHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:07:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78FD5A;
        Fri, 17 Nov 2023 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700226447; x=1731762447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNaYz7iy30KVHMhHAV2qo0PJlGdOsQbJ8Uvt0Ebwm2k=;
  b=XArybbIcJ4OJm+pJgBlgdb7tJmsE0a44JgH+FOkdLv6qe9H03LLKy8tL
   Si3e4qBEUX+eBQeV3QSqIpVygPbg6vS4yRlJZnMWQ29igvJy/kS0NUNzs
   CnYnoQB35nxqKECvlQmW3wAwNGkd90X9oVqUX8UnGxAHdSVFx3/yVcTri
   N+8Sp9Wj/kIWStM8jNym2ZVzCDQR0gJfxgsS8Q0MmeBC1fON3SbvfsDu9
   TxYtPbUEVY57sibl7G5LSjAsdgNUhtztCzJvyWZLc4bXo+8A4zCfSstNj
   zak6pLZd1I5KSOOiKVBHveYoT3txbZhVwkHoVdG7LNpJW5sp6o5DgSiAQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388446416"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388446416"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="836072061"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836072061"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 05:07:25 -0800
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
Subject: [PATCH v6 4/6] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date:   Fri, 17 Nov 2023 05:07:15 -0800
Message-Id: <20231117130717.19875-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add mock_domain_cache_invalidate_user() data structure to support user
space selftest program to cover user cache invalidation pathway.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 17 +++++++++++
 drivers/iommu/iommufd/selftest.c     | 43 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..0000f58dcda3 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -148,4 +148,21 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: invalidate flags
+ * @iotlb_id: invalidate iotlb entry index
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_ALL	(1ULL << 0)
+	__u32 flags;
+	__u32 iotlb_id;
+};
+
+#define IOMMU_TEST_INVALIDATE_ERR_FETCH	0xdeadbeee
+#define IOMMU_TEST_INVALIDATE_ERR_REQ	0xdeadbeef
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5d93434003d8..2a9b970ca84e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -473,9 +473,52 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array,
+				  u32 *error_code)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	struct iommu_hwpt_invalidate_selftest inv;
+	int rc = 0;
+	int i, j;
+
+	if (domain->type != IOMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	for (i = 0; i < array->entry_num; i++) {
+		rc = iommu_copy_struct_from_user_array(&inv, array,
+						       IOMMU_HWPT_DATA_SELFTEST,
+						       i, iotlb_id);
+		if (rc) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_FETCH;
+			goto err;
+		}
+		/* Invalidate all mock iotlb entries and ignore iotlb_id */
+		if (inv.flags & IOMMU_TEST_INVALIDATE_ALL) {
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+			continue;
+		}
+		/* Treat out-of-boundry iotlb_id as a request error */
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_REQ;
+			rc = -EINVAL;
+			goto err;
+		}
+		mock_nested->iotlb[inv.iotlb_id] = 0;
+	}
+
+err:
+	array->entry_num = i;
+	return rc;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1

