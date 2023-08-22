Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46635783E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHVK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjHVK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:57:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9030CF0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74a6dfb0deso2642020276.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701875; x=1693306675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fIEK+scFoPaQOWipSrbqlwk87RaTCX5IMBMHhwH0rc=;
        b=VzPvLxPEkUWtvGRxaI4vgChrPgBtjf6/0dO4DMIS0sPgv7fDNtvVXPrbRKl0S6dUJG
         5Jif4cnLgI2SCQegLHuKV6Ak4FpQ5uV5ha/XyE96/30mOKtY80ezUODmcLJR7lN/E4kj
         oFARbyu2wcSqnVV4Vx7NMcXOH5qGa3vTVWgioQ5cHoX27qkYhbvOYyEP4aYyicsnmHgI
         H6eDa0S8GVMMekyTEt3vZkmhl8Zj0XCgFGBH/v64XbaWn+dP6J04Ryf7QlXsFMV/HynZ
         BTlRcj7wq/qZJYEPC//+OeNhBH7vb9knU6I0fmh0RYk7s8pNxp6+lXRt0tRHaizJP9fA
         SWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701875; x=1693306675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fIEK+scFoPaQOWipSrbqlwk87RaTCX5IMBMHhwH0rc=;
        b=W1vnGOVJdbTWvwUuIgQ/5nMdd6Sx6YZ1FvaTvxZ/MrKEaeFURztjuv6sO5Xu4kMEZw
         aRPPaWHTUPk1Ozpfsqe+ZEVxG3h6ISQv2oQDyD7C8hFzlKrRqkUqSTr9Cij6K4fqaWXQ
         130aANHpxVrmua8yuURBRGAPD7+uhSCmtEVD0ntEI8DCMChsnApC6SOdhHZkhxdLySt6
         aEhheMUv+cttUmbtkGPHFLOeSvqTAZlJTX0/oayxC8V6pzgfxwLhPRt4t8o/+yx1+aic
         JR0+fZs0UfuzbSSCdedbb2hpWgWYe3ZcCGNOhyPQ5IKPoSwgoef66lLyOfLcZZ6FXfG2
         Gemw==
X-Gm-Message-State: AOJu0YyecWFPgBJVDtUaAbRcM/n5bPH2rGeCyI3wWwQL3WIK2ZvDoHsh
        a8elsQ78P3nMtHAzl1ingcljjSs2xscZ
X-Google-Smtp-Source: AGHT+IEeWLCXictoCF2DKIdsuoaCa730sOxBT91INqbmQdApKPT2Vvx2k50fuMZ0N/jHCgwdsRZutgwQV7Yp
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a25:874c:0:b0:d35:bf85:5aa0 with SMTP id
 e12-20020a25874c000000b00d35bf855aa0mr82026ybn.4.1692701875089; Tue, 22 Aug
 2023 03:57:55 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:56:58 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.2.I9e9adbe1cb8164398d7a8f56907e6823fddb45bf@changeid>
Subject: [RFC PATCH v2 2/9] iommu/arm-smmu-v3-sva: Move SVA optimization into arm_smmu_tlb_inv_range_asid
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
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

This will allow the optimization to be decided on a per SMMU basis when
arm_smmu_tlb_inv_range_asid operates on multiple SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 238ede8368d10..53f65a89a55f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -230,9 +230,8 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 */
 	size = end - start;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
+	arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+				    PAGE_SIZE, false, true, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 37b9223c145ba..db4df9d6aef10 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1974,6 +1974,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
+				 bool skip_btm_capable_devices,
 				 struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_cmdq_ent cmd = {
@@ -1985,6 +1986,9 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 		},
 	};
 
+	if (skip_btm_capable_devices &&
+	    smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)
+		return;
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d2790b701e7..05599914eb0a0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -751,6 +751,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
+				 bool skip_btm_capable_devices,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-- 
2.42.0.rc1.204.g551eb34607-goog

