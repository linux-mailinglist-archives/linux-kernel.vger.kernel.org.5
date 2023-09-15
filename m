Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9A7A1FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjIONVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjIONVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:21:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E537E171C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so27838287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784071; x=1695388871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUPSRV1Y2NOennFdL40BVpulBOE2JdAWnJXz+eg2+lg=;
        b=LaqL/D23zPPJum+rergsyFuhrt7xuewTVYgoCSBc7ephoMGc384kG9hP2AJF32uaRF
         mzkNMsuKMM04XH/K7GRiTwUKoKktzzUnI2eKQBZOF6IeIMN9d1akjTQLrEA/Rl7PiBMm
         hup2OFjcAgPupzs61hX5zcpwsNISNZG425rwXK4ep1YAzqxDoXjw12nAV8wAGaRtCMgn
         FNnkecmicXeKfWAVgm+W5W0734jVXZRTERHbLj3Z8Iv1Y3BrVnErR3TQg8FWt5B3fBii
         EzVTLeNbQ9OxBHLPlbr2KBrG0PEtKCU0CQrxPJ/fdR4kJKbsUlBmbJaqiKYJ6uYq9Jg+
         e2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784071; x=1695388871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUPSRV1Y2NOennFdL40BVpulBOE2JdAWnJXz+eg2+lg=;
        b=mvmRWxB4nFvYYU4Vh74Sz/J+ajg5SHpGmwGBN0cHg7bw9oAa4lAFdVAMNIcN61ziJW
         YgZka4XN+CTS9ySmfTNarB4Ex7pfeerzituwDMi4a+v9xCFxbDkVFkMpjiqAEfgtSNGu
         23MPKu4SfkM21ZywFXys0JU8+1FH9vyY8mGwjWaSYuaxHZmBCgysGtsqXhdY2yUuIDfy
         DIjX7vKauHt0lg+QkRTKB7F2A8glew1fIE0TUTENFu8yQJY2ACm/XHyECe4wHVYQ7ouq
         ZwmlhYwedgZPEvMIUSnBWhQbfhrBPEohBwMA2vwvYaskLJVacbyoN5aHSwPtupjsk5Rl
         J3bw==
X-Gm-Message-State: AOJu0Yz/fz0GNX2lHs/lO3mjvALVubY1/XkZRrC8RuPfhapXr84/AKgz
        QZ/yFt37IWgoOo1bquoYOh6XddHgHjqg
X-Google-Smtp-Source: AGHT+IE80sO205KDJEKcNpKH17hvdhH3ildl+E6LHEuDB+h1xgVjg474K5hdxY3HF3T1uQfxYdpv6g4XFWRm
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a81:ae49:0:b0:59b:ec33:ec70 with SMTP id
 g9-20020a81ae49000000b0059bec33ec70mr39843ywk.6.1694784071028; Fri, 15 Sep
 2023 06:21:11 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:34 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v8 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
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

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1ccff6d87edf7..a9649eaeed8dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1132,7 +1132,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
@@ -1140,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cdcfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2087,7 +2089,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2100,11 +2101,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->s1cdmax = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.42.0.459.ge4e396fd5e-goog

