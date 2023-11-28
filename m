Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B07FB83F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjK1KmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjK1KmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:42:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7050218E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:42:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6962152B;
        Tue, 28 Nov 2023 02:43:05 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AB2F3F73F;
        Tue, 28 Nov 2023 02:42:17 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@ziepe.ca, kevin.tian@intel.com
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Date:   Tue, 28 Nov 2023 10:42:11 +0000
Message-Id: <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1701165201.git.robin.murphy@arm.com>
References: <cover.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With bus ops gone, the trick of registering against a specific bus no
longer really works, and we start getting given devices from other buses
to probe, which leads to spurious groups for devices with no IOMMU on
arm64, but may inadvertently steal devices from the real IOMMU on Intel,
AMD or S390. Driver coexistence is based on the fwspec mechanism, so
register with a non-NULL fwnode and give mock devices a corresponding
fwspec, to let the IOMMU core distinguish things correctly for us.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommufd/selftest.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5d93434003d8..f46ce0f8808d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -432,7 +432,11 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
+static struct fwnode_handle mock_fwnode = {
+};
+
 static struct iommu_device mock_iommu_device = {
+	.fwnode = &mock_fwnode,
 };
 
 static struct iommu_device *mock_probe_device(struct device *dev)
@@ -569,12 +573,17 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (rc)
 		goto err_put;
 
+	rc = iommu_fwspec_init(&mdev->dev, &mock_fwnode, &mock_ops);
+	if (rc)
+		goto err_put;
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
 	return mdev;
 
 err_put:
+	iommu_fwspec_free(&mdev->dev);
 	put_device(&mdev->dev);
 	return ERR_PTR(rc);
 }
-- 
2.39.2.101.g768bb238c484.dirty

