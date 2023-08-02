Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3D76D3CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHBQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHBQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:34:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B02D69
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:33:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so82268397b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994033; x=1691598833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkSkXQKYJ56ysrmlEDQExeOLrrR+KHQKd0NE5Ad+0tQ=;
        b=Sx4NgzTXcAqonwe3umZclUZGuCSTNOJdjHZfhQsHFzrrGgvIBu+PVtD/2bbThkc2kg
         O/sl/fsv5azhqF6rFWZaIoCHnP/dsGxMk80XJekswYjv3IYw+0unms2NiOxnWe9mtMed
         d+vYRYCK+LmW/8uHomdrDGzkjSrKkMZ98LCels1IDh735su3QiiRYMMiZPsdWP6xMEMn
         WhaPiXb3DC8n86HOkDb1expULa/KNgZQMmuevHGecWWfRrBbMHtE8vm19ZWUoU8x2a/c
         IlcM9zeUNhiB99UW7QV8MuCdv5p4/3k5j4PcrytWgqaoLwkYtmZLqLUYQ0ylGG3xlVub
         +rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994033; x=1691598833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkSkXQKYJ56ysrmlEDQExeOLrrR+KHQKd0NE5Ad+0tQ=;
        b=Ro4d/KP8juiSQZhfOC1SIGbCCp2tMBvks29yhLItFhcKGgVfu5998poBkfEXzGt8Mu
         HqOGZSaoOo65dtBbT1ACQtNnql+CzKQPv7EhQpptivrSSip/GO9iuQQmk2AJ+SiBo5jP
         twcBMpKLldGN9loLC7IoGZLnr+dlFcGAwv+XExh1FbtGkPimpCiKAl8+J2sO0o/YCN4X
         H+UckRkybtgPvxr9as6AtEgeXgPjY/KqNR84/Dz6fwQHqJYCZKKvhEEIGGzt9hnBiqsV
         WOXMJpKisY4xTbQC1tg3w/A5FRByHVK0TXzTHSYt67zT9t8RiUruwt02txRAdfI66knE
         0jBg==
X-Gm-Message-State: ABy/qLarWTdQ2zaecT2sgrn+neDxkhqK0/Eks5wpEIQ/3C9ytYV6fxov
        1qKWpDhfZjHk2TF5XOlUBYoR88u+rG7p
X-Google-Smtp-Source: APBJJlEJkxL7n5t/WP1xXbG+m0y+BaZM5+ewq4E8ARRYBnMdtfnw5rA+asX1x1w8C+XChKwEP8BbnPzCQZIC
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:48a:0:b0:d37:353:b7eb with SMTP id
 132-20020a25048a000000b00d370353b7ebmr56014ybe.11.1690994033344; Wed, 02 Aug
 2023 09:33:53 -0700 (PDT)
Date:   Thu,  3 Aug 2023 00:32:32 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v4 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
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

This controls whether CD entries will have the stall bit set when
writing entries into the table.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v2)

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fe4b19c3b8de..c01023404c26 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (smmu_domain->cd_table.stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1141,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
@@ -2121,8 +2122,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2461,7 +2460,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
+		   smmu_domain->cd_table.stall_enabled !=
+			   master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 35a93e885887..05b1f0ee6080 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -597,6 +597,8 @@ struct arm_smmu_ctx_desc_cfg {
 	unsigned int			num_l1_ents;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				max_cds_bits;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -714,7 +716,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.41.0.585.gd2178a4bd4-goog

