Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8353765B58
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjG0S2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjG0S2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:28:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334433A94
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so1223437276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482510; x=1691087310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RPG6EjTpCmrlpk3X3dE+3LLtmtBMtKD9Q5+XxQMCjE=;
        b=AjK5zSMi0Im0w3fYQ15yRccpeOAI+14Zvl4PVzDHTHhNvwzjh917aJdYWewXqc2I7J
         wRBzfd9DM1syldv8VA5K0fQ7RLiLKSZeQPH3Ada/itXI3betjMpH20YG/uq9x6aHZz2B
         cyk5BEHGFiuEMyvVAX9Mwcp4O2GgsAyuh2RN7dESRFRpeOR1Q9WM1QQpfa5YWjbGHTXd
         r03k4z/GNWuHOb+G9Sj1j6Nwn4rS3MYRotmRxYEJb1uqN4We7R3WauHxoXhlRwPEZSfw
         f42lVGxivrRZ6JJUS3a06HvKZ/V+CFTe1MQlTl9ed9YJtDMiE2uqIq9CGRJtqBMSNfRh
         Cxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482510; x=1691087310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RPG6EjTpCmrlpk3X3dE+3LLtmtBMtKD9Q5+XxQMCjE=;
        b=fUU1GeFmprUNzNYjhOUfxYfc5DhJlyugGPknijWs/2oLP8V/T0sSXC7aF3Z8vEyMjt
         Y9omuewIiQk1nCoLwudb6XzhYvZJ3QcATeyBnaevBX6/GLa5PtEe/GBxV78yKFCDGv2R
         cC37qIPR+Hlk6n/Si/0qTpFhcsuxY+9gDs7Xg9eeNL6yt6QQO2fjS5mKhrRxkTQsPyIU
         R04NNcWVC0Ad+AnBmXiyOAlKDZBC5mraPHMhk39qflKORfPR6bxbjOjEoRQYy7nKupie
         aLUcfKM0YlFA8kSQOkz/JRBp/PjihWBauZpTbBeYvUzW98ownsV8ThPLKdBTBdlAEXgu
         +GVQ==
X-Gm-Message-State: ABy/qLZknenA9qn6Pi14GlCTbf+WGcJMHcFIaq26vCqKvPltq8K3lSYO
        sDMJmKhp/e3MN0O4ScmsLAT1XIWhd/SF
X-Google-Smtp-Source: APBJJlGoU6uJ7egwAWnQKfHOovr7zjk+sUq6mOv9F1EPj8gq/kZc87NrWnc2HNv6hbz5iuFLYF/0pMUhd9mc
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a25:d001:0:b0:d0a:5674:c4f6 with SMTP id
 h1-20020a25d001000000b00d0a5674c4f6mr1094ybg.3.1690482510319; Thu, 27 Jul
 2023 11:28:30 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:26:20 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-5-mshavit@google.com>
Subject: [PATCH v1 4/7] iommu/arm-smmu-v3: move stall_enabled to the cd table
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controls whether CD entries will have the stall bit set when
writing entries into the table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
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
index 006a724ee9230..0e55ca0d40e6b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -597,6 +597,8 @@ struct arm_smmu_ctx_desc_cfg {
 	unsigned int			num_l1_ents;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				max_cds_bits;
+	/* Whether CD entries in this table have the stall bit set. */
+	bool				stall_enabled;
 };
 
 struct arm_smmu_s2_cfg {
@@ -714,7 +716,6 @@ struct arm_smmu_domain {
 	struct mutex				init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops			*pgtbl_ops;
-	bool					stall_enabled;
 	atomic_t				nr_ats_masters;
 
 	enum arm_smmu_domain_stage		stage;
-- 
2.41.0.585.gd2178a4bd4-goog

