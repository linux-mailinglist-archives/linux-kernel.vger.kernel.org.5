Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78689765B59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjG0S26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG0S24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:28:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379430E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d06d36b49f9so1203176276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482517; x=1691087317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgzcf7eJvMa0L22mwJ8xGuOSunsjGTMhpYNWJ+CiplE=;
        b=dZD6K0I5bipVs1gzuK1uObkaYaQyLdEMIZkDJ/j0WkSri5z/IPpDAIsfReU9E79XIf
         JvZF4nl48p7V63uxbMtHsxNesgZ/EVn5Gb3eXzI2Y0koDraKU0XbvzwjDMVkDZEiJxsd
         eP94cTL72rATgqT3uHFszDeTE4cSEl4jVJ+p5hryzT6An78Q+FevMU0YqIYnNEm7OsXf
         HhtHdFQsp+JSUJMwHpG23pvePH5QKg+3sk/FKabcuMA0aCFYQcTZJjrCzGDCQGrIFbaW
         pZrHD+9537u2zz/YW+ARTZgmMoT0yGDt5RdY0yRpVIeR9lcXxZx2IXmuAO1uftLU7/sQ
         B1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482517; x=1691087317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgzcf7eJvMa0L22mwJ8xGuOSunsjGTMhpYNWJ+CiplE=;
        b=bnvps7ZNM4o4Vst4zlY6kaKdt/qH+BYtztv45l4napZV2cpLgPEfm1NDHICvxr3VQ7
         MWbeJwePTzUm+LIhOgD0oa4Z3rIjyL5VOvNNgF9SSSM+rLeO830ySme6s+HVCV3K6VUn
         0u3GHNhaqyeAwHB/y54NE6vbh0tWxpORBCMGntaiEk+X51CHt//EIfV0Mgj8GS8GNIp6
         YtVj0qzX591y5UH31uYJDiorxOzWn9tO6AV9rlQAv+OAso+ISwM+J1VQPNz9gbLRdNxX
         IDQugRMLlhPcR+WqNG8xKLm4HfMdYCTbF/klS2l9xZy23xrgxYv6wOcAAIgHTi+G+I/h
         UKLA==
X-Gm-Message-State: ABy/qLZhy6q+emsYxKVuKhq2l+AcmOSgPeP3r24RCTD1XjIGtQao3ttE
        4So8CmZtFwd4VFeT83BQaa7bF/bXVshf
X-Google-Smtp-Source: APBJJlERZfhSdpF0IyVGRIpcLXk6aibm3Q4tCHGc1ITTizVFBO8EN2gQXnIpx5H10WTmZi/VGpUkp5kHkdIm
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a25:4183:0:b0:d0d:4910:cf0b with SMTP id
 o125-20020a254183000000b00d0d4910cf0bmr1741yba.10.1690482517038; Thu, 27 Jul
 2023 11:28:37 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:26:21 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-6-mshavit@google.com>
Subject: [PATCH v1 5/7] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
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

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 654acf6002bf3..af7949b62327b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -987,6 +987,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
+	if (!smmu_domain->cd_table.installed)
+		return;
+
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -1368,6 +1371,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0e55ca0d40e6b..f301efe90b599 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	bool				stall_enabled;
+	/* Whether this CD table is installed in any STE */
+	bool                            installed;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

