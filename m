Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549DB76D3CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjHBQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjHBQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:33:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593372733
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:33:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583b256faf5so692807b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994029; x=1691598829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGhWSbzc4cZej0FeJJbc3VXFTtBzmMATq60yYbQRCzk=;
        b=Wfmjss+UWmZsCytY4z2zpjHfRx8D5zoF9UEpfx4Rmioi27engfbfmtGjsJKQWBcyVf
         QS5jrHEj985TIIPJU2Mfx45hFU3uZrL0e52dgYK7tVtA9xaCfnfD2ihgwvbDsnbWO4Ag
         So0UGVMoWSVnDk+FESZFRihVwOytovkaGPzW4T8N0gSCoM2jXawxIf3LpwlN5Khp+pah
         yjcreTw1ONoQ8cMSKG2QPznIeGjCQIWll17RNVuYyACk1GcDPSczUDF/RDsO9l6A46K0
         0Lcty3jmaLU2xZl9Y76nI9/56Xbhl0emopedb/DqA/C06TZARGBtPULdRn5u2XTvcmw/
         kOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994029; x=1691598829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGhWSbzc4cZej0FeJJbc3VXFTtBzmMATq60yYbQRCzk=;
        b=eGRpqs/jhvoJ9IcpwR2Se2/WOWRIqgtvC4C0paKW0yjrC7jB/6tGA+wQaZVk3tlXUu
         fefFxLQxnbd5XIjA2ylx+4bGOJZWHpPt2HN0W1AN4mNqt+SncmSTvhw9ZKrGx2mPI5tf
         Zppwx3FPSj1/jjzTYRSFJ3B0g9lJGLM31f/g77IgCumXogZfJjhH8xSg2UkL76p/64o3
         pdmvC1K+Yjk9+0AK1q9BjXmYSNafLhW9GKj04lvV430RIw7qDhmA5S2E7UCSEvYHLWKK
         bLrGWzGp2INePh/KtwYFHnNp6hlxQjHM9DmsSQvzO3hBtqc1OLBdq5zAnbWQDf0SUPvp
         AMUQ==
X-Gm-Message-State: ABy/qLbBFtjs/ehGMioL19nPHu0xzcyCnDUFJurZoryK13HWdGifUJkN
        LYEDOom6TFs2Vm3wwnbfFss4FX/mE/or
X-Google-Smtp-Source: APBJJlFrdCMuLTcNvB4PEmrjrdw1E2K0mx6VOTk63TBd4jAAKLgWBwBxXteZbNG1vw2PQrNREyOTvEazvG+L
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:ad5b:0:b0:56c:e9fe:3cb4 with SMTP id
 l27-20020a81ad5b000000b0056ce9fe3cb4mr227897ywk.1.1690994028873; Wed, 02 Aug
 2023 09:33:48 -0700 (PDT)
Date:   Thu,  3 Aug 2023 00:32:31 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v4 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ded613aedbb0..fe4b19c3b8de 100644
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
 
+	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2107,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

