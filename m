Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6877E26D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbjHPNUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbjHPNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:20:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCD269F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d27ac992539so7024632276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192004; x=1692796804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe3w6+O946qsePdEyrZWPsnq8o2zMwaWjfIN0ZcKH7g=;
        b=S5WZxqs5GurMEnLD1F7xsEeJ3tP2Kjuz5EYWQubEoDvUsMOETXpYFnHhpejZcqD7e3
         NnqWI6nvnfYfN6AtL5sITmgzJP+ke6hgMwZB017TfhXOEWXnqIwu0jOz0oQjjGKp4C/T
         a728LmBL2d02Fj0um4QLEXYUWECa7WxmgIfaKyY0mPb0AiODM+afsc/EdvphdxJVgsoP
         2Jd6L/4pY3GLCnuuZysv7bVyLcbRgx6oif+p+eOOIuOzekpKHS6LMiCE4UV4eR0XMejy
         FM6qp9VQKzLIhKN4odMqomAmMv6C3xplAcrPxnnCGvyny0VolV0k96Yqa1QkeZ8/6WY8
         i6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192004; x=1692796804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe3w6+O946qsePdEyrZWPsnq8o2zMwaWjfIN0ZcKH7g=;
        b=klEtIbxVJkxcVMy+X2cAhzI3d4YfFuJmDAyPr40cnlsnr8L6f/SA0J4M6n5pacTaZO
         tdNhmzInPJw3ww4tI2BILROVqLVGUku5y70vGzRUBMfUoRvgriP8Xd0evOVhv/1xkkgg
         F6nJ5UOER0Z/XTy/F1uiU4g7/eyp9gomi896/SZejczoDSCMsBuAfXk5bkHKiB45Rau5
         eksVc79o4bKy1ji0y8iKgNk/Ht9VPKhKIGbrqrqOoS6E2Moh/ZqYqVgfAEk9Cmax5WVl
         ubXhfrZvAm2wsgxjlBJbXMIOLGZCyxB46IJHa6kopuokWfv+6mmGqchQDB+aGhcNmOh5
         qnmw==
X-Gm-Message-State: AOJu0Ywl1PrW7c+Hv+J1018yxQRckvH/rYfxDqeNnwwGyfM/PPBHa7Xs
        WQf0las6QDvIo2ce5uxDWzluspvpgXD3
X-Google-Smtp-Source: AGHT+IEYlUp8zL7/YW8IE7Aj5eC7FeumYYXwQXcXhER6oHbUSHFFKPGxfH2qQQJIIq2tOTEWY90Zp1X+mIjw
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a25:748e:0:b0:d06:cbd:1f3e with SMTP id
 p136-20020a25748e000000b00d060cbd1f3emr26993ybc.3.1692192004153; Wed, 16 Aug
 2023 06:20:04 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:47 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Subject: [PATCH v6 07/10] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8c5e5fcd55713..de87150cd0242 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2090,7 +2090,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2128,7 +2127,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2153,8 +2151,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2162,7 +2159,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2214,7 +2210,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2426,7 +2422,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.41.0.694.ge786442a9b-goog

