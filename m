Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB7769371
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGaKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGaKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20231E7A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso4468680276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800540; x=1691405340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wCGxdM3vMHiwD5Hqt1d7Th7Pi/IDzxiPCnlsNf6ST4=;
        b=wvipL4WYLuG06Yh5YopeGwe+XP+zY71R/EbIkI2asNYrYY+npiquOLOKtTV2H4wE2V
         EaHCyurHW1OnBNBicb3akuqlgF4MJPoQognV8Zlk2nlY3F68isgainEajrK0YmO8BFKX
         v9uxGx2aUalsMGIWmLEXx77Qt9MTtXIWfIaXsQN9QhUdFKcBkreF2WgktcFBR6IE/uoH
         55LrshvxNW8mBQlz05AGY0+XgdTfXjNZFqKztaF2CceW22NfA18nxf+yKVrkIKH/GwA+
         awt3aG+Mo/+5YJJba+ZkC4K6v8Jqe+YiictB/4pRzc9kXU9nN1RKGk/pvbOiCaLhUeE+
         mn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800540; x=1691405340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wCGxdM3vMHiwD5Hqt1d7Th7Pi/IDzxiPCnlsNf6ST4=;
        b=FaqKoN20ya2CJHnuZpVPzCy6fHoo3H50avWVf/eTGtiKzlclo2JMbuUWfTEeAmW5yB
         A0djZlOjnhYDqFPqEh/HV405le98JUAy18WtnEUMxKG9TgLpU2A1QKaEu4truVHOiqWB
         sSELAziqqg/pFD+7+n0PxYBPlnuFsLW7h4B5Wu1L7OJTExfyu67mRyVqAG4OxO7RAPSu
         NizqIOcu4PHwjJkRdR0g3ziLHl3DiOwIlttRQ4Lar4JsrzjeiAnq12xpHBaR170jiEv6
         fWjY6z+ywel8UsH55aLyT35JANqZKj7rCeIGOwF714Y2iy+PwejAWmswuFF7AbdKY2ek
         8qkw==
X-Gm-Message-State: ABy/qLb9xzKy6w2N8QMb+XTQQZ2BDM9/2W3ksBkfleLeargX9vVtgSWE
        44E7qBk0D+21anItGw+63ho6FljTqBci
X-Google-Smtp-Source: APBJJlFQ7Qm2AbHHFTv+59ukHyucVUan8ZyEh930iZGIBXi3F+1k6wJAPucN7Z8mtOU9tmxewSWQWBEKDQ12
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a25:7341:0:b0:d0b:ca14:33fd with SMTP id
 o62-20020a257341000000b00d0bca1433fdmr49423ybc.8.1690800540379; Mon, 31 Jul
 2023 03:49:00 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:48:14 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
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
---

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a286e3838d70..654acf6002bf3 100644
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
index 35a93e8858872..05b1f0ee60808 100644
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

