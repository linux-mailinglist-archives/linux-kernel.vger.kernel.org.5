Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954AF76BC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjHASjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjHASjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:39:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272126AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:39:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d061f324d64so6201917276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915150; x=1691519950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAM03TrWnx19tFyGEZeiC8ZPNwQCzRz5upWzC+FfDMU=;
        b=noMSpccdCmyKnDBXuUhvYDP77FEjg3MllnGtclhY+xLWvPBZh2jbRYNgjgvWRtIkmq
         bIlPLJtrytU8jyO/19+MHyU16ZJkdBEOLKn3OVOGP4S/M0e2iPwPOadii30LC0/QCrsj
         /VO11DM3IrSggkwkNF0djIujCQGV06iHUD3if7dqbyigGV5G/qDx9WLr7ljJYc9y3FJy
         swqLhI1Yy8hNKVWU+LZ9rVKzcOmdhh7FFZgy6dd7d/YRDjmLUEpHSD8g1JfeoOuxjeOF
         8N19Ym5DnZm9mMUzRgCN2b9N20p1nkJ+qxF0lS1c1BMZOJZefzm+DCAGue+VVQRDXuG4
         TwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915150; x=1691519950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAM03TrWnx19tFyGEZeiC8ZPNwQCzRz5upWzC+FfDMU=;
        b=K2IdNgBjDNEOoBbs/aAB0BsKYR0CvPlnbXgC7Ktrv5PhlfCbbACylVfFdm+D71Sf6f
         hFC4Y/rtDuKVhKbQ3pIqJiSr3wCe1u3WvSO4F7NK21IfEWmhC0uUSKVRakoK7Qyics7n
         52qGNcP5ZJ0WszySTuXCmJ2nPZcaih8sQGymJRxQBtCK5GRox1lcNvqSP0VXpSeoBhNR
         SZ+DitKHiu6Ag+lCg/GmDu4Tv5ObxrXP+WjpwVzjLPPYkXjhzlrhnVv/YZTb6jNOKWQd
         tf3+3yH4xVhUjXWeYJVhyUlawZWBtO9g0LIWB+OymmR7A7OCmISEXi92XDToq5EG0Ljz
         jp2g==
X-Gm-Message-State: ABy/qLbdINtSU30rR5Us3ryGr+EW5ctUGEvFdKwGxwv6gu1AXlOVZGjE
        RiJqclo7nat05BezD1WokISdDAVbJ7qF
X-Google-Smtp-Source: APBJJlELAdnlXVRI73meTrkv0tFhH71JQ7/kij7cS8tztEz4dJhJ4HmsuRl7WLAvqGssIbMBx5is4LmVBjRt
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:7493:0:b0:d09:17f2:d3b0 with SMTP id
 p141-20020a257493000000b00d0917f2d3b0mr94958ybc.9.1690915150758; Tue, 01 Aug
 2023 11:39:10 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:21 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v3 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
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
index fe4b19c3b8dee..c01023404c26c 100644
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

