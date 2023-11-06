Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A67E1AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjKFHQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjKFHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:14:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311AD69
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254851; x=1730790851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JXrcRndberQgWoGawVfq93WylWTuPjjrsB1zsCyDKUk=;
  b=Pdvq3G9oshsK/10S7GAfl+yak1B80KtayzriiEpXy+JD8IR8QmZarkj+
   1GooCPhIB0OoS04T0mB9PgJoaiPGjdxWCEoT714ujaABCR369/0Evj3Ot
   A6MnCHgwx0t3GrcK330ROjNsjD6c7fYeT6XIxmiz/1CrjRZARBWjWCC/F
   Mrmk/5YXn9vRQkQodY26VRH2ASWb085Jw5ywtk4u4mFouRIHK8XED0xkC
   Dt+Llx2haVlsbuGO4C1kRhn6iHg96ZfjGrNc8EjSupLwBZJE+ZgCSDE2C
   +jShQeNsmNGjCh/oAOKLYu4UIjZm22lBTFQFWAToT7oxcPkCyI+jVCdXH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759075"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10759075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690912"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093690912"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain) ([10.239.48.212])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:07 -0800
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 5/5] iommu/virtio-iommu: Support attaching VT-d IO pgtable
Date:   Mon,  6 Nov 2023 02:12:26 -0500
Message-Id: <20231106071226.9656-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
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

Add VT-d IO page table support to ATTACH_TABLE request.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c      | 23 +++++++++++++++++++++++
 include/uapi/linux/virtio_iommu.h | 26 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b1ceaac974e2..b02eeb1d27a4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -991,12 +991,25 @@ static int viommu_attach_pgtable(struct viommu_domain *vdomain,
 	};
 
 	/* TODO: bypass flag? */
+	if (vdomain->bypass == true)
+		return 0;
 
 	switch (fmt) {
 	case VIRT_IO_PGTABLE:
 		req.format = cpu_to_le16(VIRTIO_IOMMU_FORMAT_PGTF_VIRT);
 		req.pgd = cpu_to_le64((u64)cfg->virt.pgd);
 		break;
+	case INTEL_IOMMU: {
+		struct virtio_iommu_req_attach_pgt_vtd *vtd_req =
+			(struct virtio_iommu_req_attach_pgt_vtd *)&req;
+
+		vtd_req->format = cpu_to_le16(VIRTIO_IOMMU_FORMAT_PGTF_VTD);
+		vtd_req->pgd = cpu_to_le64((u64)cfg->virt.pgd);
+		vtd_req->addr_width = cpu_to_le32(cfg->oas);
+		vtd_req->pasid = IOMMU_NO_PASID;
+		break;
+	}
+
 	default:
 		return -EINVAL;
 	};
@@ -1034,6 +1047,16 @@ static int viommu_setup_pgtable(struct viommu_domain *vdomain,
 	case VIRTIO_IOMMU_FORMAT_PGTF_VIRT:
 		fmt = VIRT_IO_PGTABLE;
 		break;
+	case VIRTIO_IOMMU_FORMAT_PGTF_VTD:
+	{
+		struct virtio_iommu_probe_pgt_vtd *vtd_desc =
+			(struct virtio_iommu_probe_pgt_vtd *)desc;
+
+		cfg.vtd_cfg.cap_reg = le64_to_cpu(vtd_desc->cap_reg);
+		cfg.vtd_cfg.ecap_reg = le64_to_cpu(vtd_desc->ecap_reg);
+		fmt = INTEL_IOMMU;
+		break;
+	}
 	default:
 		dev_warn(vdev->dev, "unsupported page table format 0x%x\n",
 			 le16_to_cpu(desc->format));
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 656be1f3d926..17e0d5fcdd54 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -139,6 +139,22 @@ struct virtio_iommu_req_attach_pgt_virt {
 	struct virtio_iommu_req_tail		tail;
 };
 
+/* Vt-d I/O Page Table Descriptor */
+struct virtio_iommu_req_attach_pgt_vtd {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le32					flags;
+	__le16					format;
+	__u8					reserved[2];
+	__le32					pasid;
+	__le64					pgd;
+	__le64                                  fl_flags;
+	__le32                                  addr_width;
+	__u8					reserved2[36];
+	struct virtio_iommu_req_tail		tail;
+};
+
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
@@ -224,6 +240,8 @@ struct virtio_iommu_probe_pasid_size {
 #define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2
 /* Virt I/O page table format */
 #define VIRTIO_IOMMU_FORMAT_PGTF_VIRT		3
+/* VT-d I/O page table format */
+#define VIRTIO_IOMMU_FORMAT_PGTF_VTD		4
 
 struct virtio_iommu_probe_table_format {
 	struct virtio_iommu_probe_property	head;
@@ -231,6 +249,14 @@ struct virtio_iommu_probe_table_format {
 	__u8					reserved[2];
 };
 
+struct virtio_iommu_probe_pgt_vtd {
+	struct virtio_iommu_probe_property	head;
+	__le16					format;
+	__u8					reserved[2];
+	__le64					cap_reg;
+	__le64					ecap_reg;
+};
+
 struct virtio_iommu_req_probe {
 	struct virtio_iommu_req_head		head;
 	__le32					endpoint;
-- 
2.39.3

