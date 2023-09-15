Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58437A1FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjIONVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjIONVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:21:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997F2703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bee08c13aso23094867b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784089; x=1695388889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJc+j08yY490Vv/eC62RVS7PByOeYuEaCKVM2vlNjBk=;
        b=KU9HW2I7PjyvCIWtpu0SvukLJcODX1uGeciMIsP2VugqcGPxyoO7m5j7F0Qyxmsj/h
         blSEx65WmjynPibbBSpAlfDCmdn4F8rcR9DIYI+jGSkWB3yBn19WSnrUqid5ld078m9M
         2t4v63+7XUsj1CEeYzwkW8FockxDYLHOZ114gTmAfnX/6iZHoVyx5Ec9tugFxTd9w+1E
         f8YdQOztmlz5rfTwR/VPc2MKxsXAutvwrcXOG/Jsp/FT5A+HzL33Sob+xLjR5fHQ6o/Z
         KOd920dd8d7mgqfCk0F9GTaabMtLOjCUak0KZqu3AI7L4qNp3dJb7A1Pg1u145lHkgoP
         Fe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784089; x=1695388889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJc+j08yY490Vv/eC62RVS7PByOeYuEaCKVM2vlNjBk=;
        b=BKS2UXEwSPPy2ncNtSDcvVbDSF0eer47okmnLDCrKKVJsnqf8/PkMvWPcweew9qcQs
         tZgv2NcmokriegWHGUvjJ/3lMBoo8FjGfYR+IVG//jFQemr8sw6vv/3vFiX9Emzd3cWk
         YYTp+YJ8YVvtxLv2IyoU8hooglImSWVMV/FRX2iXh0QkK78Eiawj6gLPZRMXV2XHGVYN
         oWHJ+G4AVCxs6No27V7U1DqykUKxGyOIowmSbJw5e/LHriaxdYT6f4pO4xrIVbXR0hA+
         F8PbIaw4VwMNeyNv3Z1CAiLjUaMtYnQvter415a28OUQjGWMEUUDcS7HOtijHXds5yz4
         wAAA==
X-Gm-Message-State: AOJu0YzYuFmTLNpTVUwwVxvNJ5v5l6YTgncmKtlY6KLU61ky3O6T8JCX
        YU2rbFoACuY9zZ4y3mX5jkFalX9One5P
X-Google-Smtp-Source: AGHT+IEuJ5KcwfdedexvLlz7riXbSm41Db7pn05pdZl1N5uV4Svr00phOyLnhZeuePRuFFcvJm2feFAxCAND
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a5b:b03:0:b0:d81:6927:d806 with SMTP id
 z3-20020a5b0b03000000b00d816927d806mr35071ybp.0.1694784089726; Fri, 15 Sep
 2023 06:21:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:38 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v8 7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, will@kernel.org,
        Michael Shavit <mshavit@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tomas Krcka <krckatom@amazon.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused master parameter now that the CD table is allocated
elsewhere.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 25ce62d25732c..f9bfa2c8ab1e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2072,7 +2072,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2110,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2137,8 +2135,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2146,7 +2143,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2198,7 +2194,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2408,7 +2404,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.459.ge4e396fd5e-goog

