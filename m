Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED977E269
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbjHPNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbjHPNTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:19:53 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110532719
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bde8160f8bso54047575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191990; x=1692796790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=98R9cDHlqFHC0r2dWqz/zPBLxIy0J2x2FWSHk2LIHOs=;
        b=gViVsHkV+oW/ssvS4V5B85zqurALcAVT4KRsVDHANQvIEQkQVOYWdpUOQBowWMczKW
         rvsBBPgWVlp35+zVDXLlhj8TbkKQSZ99sZbD/OC+i5uVXwEkyM+chrKN8TzQvBSnsDBl
         M1iderqVUPK93t1U8bRodRr3RRziyTT7HdZ39c+u619Mr8o5nAMPewqyrU17uH2hjLMR
         RNFA9ufToYeElGvL1/gbwlMhY6pK8WpXlwJhQEDmNHMAbV7IC4TW9gWS6U/91l5vmQ0w
         FRP8z1y1OL/ya7jdqfkJa6Q5QyCxB1S2ljTqNaVVNiYTNK+d8C72d+T46iTeCEcAppv9
         Zftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191990; x=1692796790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98R9cDHlqFHC0r2dWqz/zPBLxIy0J2x2FWSHk2LIHOs=;
        b=YJZwsx4IQiaFPwsRLskF5jWrO3fYTTgLEaaopkc5y/LvbPhIzs7CFk/F2FXrhw9DCV
         2TXmU1Eyxw/OuB6+6rb8DDiFW9ZkIadm4ioC4n2ZGEa+OEUP/lDNOCBSBTgyqC9cOMR/
         b6w/pOcDRPrOXandbv53YIyEM/Xww5pZCxA9cDEp40TKkdmCr0FuVfNTdnLHdl1VRjS4
         NJj+11GNLBn2HYdbUYsiS45BwjF9SEnXZjypWb5x/hlvOAEotMBVA/pU6XOO7ztgsVA3
         ilTSGdP8pT7MWlnp0KjPVHFwEsZ1Afw+2dfyBy5K41o2NEuQMP5s2WYenunn13uaxNHu
         3qIA==
X-Gm-Message-State: AOJu0YzLGIaN+q8B0z5nzouIMqIDWDolpvROOTAompgoYvUA9+Zp8EnF
        UnukZvgJVKO0W2tOGSZar0UzwXnLn0sF
X-Google-Smtp-Source: AGHT+IE81V2CyAVia66iFNKZ0APyWWZt0UBvJTk0odPbFTyX7tHnQze4OnhoI4OUsspCza+ZRQo6x4kss9Jn
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a17:902:da85:b0:1b8:9866:db2a with SMTP id
 j5-20020a170902da8500b001b89866db2amr693702plx.10.1692191990531; Wed, 16 Aug
 2023 06:19:50 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:44 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v6 04/10] iommu/arm-smmu-v3: move stall_enabled to the cd table
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

A domain can be attached to multiple masters with different
master->stall_enabled values. The stall bit of a CD entry should follow
master->stall_enabled and has an inverse relationship with the
STE.S1STALLD bit.

The stall_enabled bit does not depend on any property of the domain, so
move it out of the arm_smmu_domain struct.  Move it to the CD table
struct so that it can fully describe how CD entries should be written to
it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v5)

Changes in v5:
- Reword commit

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5bb13fadb41ad..44df7c0926802 100644
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
 	cdcfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cdcfg->s1cdmax;
 
@@ -2119,8 +2120,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2459,7 +2458,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
index 5f0e7468db5f3..007758df57610 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -598,6 +598,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -715,7 +717,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.41.0.694.ge786442a9b-goog

