Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1F7DDA94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjKABXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKABXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:23:39 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14600F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:23:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvIq7WL_1698801803;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VvIq7WL_1698801803)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:23:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jgg@ziepe.ca
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] iommufd/selftest: Remove unused function
Date:   Wed,  1 Nov 2023 09:23:23 +0800
Message-Id: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function are defined in the selftest.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/iommufd/selftest.c:511:1: warning: unused function 'get_md_pagetable_nested'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7104
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iommu/iommufd/selftest.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 256f93715a0d..758d328a44cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -515,25 +515,6 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	return hwpt;
 }
 
-static inline struct iommufd_hw_pagetable *
-get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
-			struct mock_iommu_domain_nested **mock_nested)
-{
-	struct iommufd_hw_pagetable *hwpt;
-
-	hwpt = __get_md_pagetable(ucmd, mockpt_id, IOMMUFD_OBJ_HWPT_NESTED);
-	if (IS_ERR(hwpt))
-		return hwpt;
-	if (hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
-	    hwpt->domain->ops != &domain_nested_ops) {
-		iommufd_put_object(&hwpt->obj);
-		return ERR_PTR(-EINVAL);
-	}
-	*mock_nested = container_of(hwpt->domain,
-				    struct mock_iommu_domain_nested, domain);
-	return hwpt;
-}
-
 struct mock_bus_type {
 	struct bus_type bus;
 	struct notifier_block nb;
-- 
2.20.1.7.g153144c

