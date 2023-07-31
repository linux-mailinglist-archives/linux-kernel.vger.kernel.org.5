Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEF769373
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGaKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjGaKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558F10EB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c49018c6so51274027b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800544; x=1691405344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOLHkJaT+7H0fEwKCF1U6y0LUywm6xuO1oN6Y683ukY=;
        b=wpLAsENIWJ8wPIvQXtzKrwlZ6cmns5IxNkosywEnU8vIi2VRqkKXyg7IgNJLtU2yYM
         pA798G7cy5i8aGBzkQfk7TMF+3OzVxxf4KXgsLYfYtzN983zooa0XPtIvRQJBZPPTnzb
         gNIlPXfmoBL6gRtQAKXVw0vyIz3ZVrSzxEV47z7ZCPvWlAWJ43TH/sqJxrU60QmCutYJ
         unlLPnHUz52Mf7NRqdcrEWLGxS1xK9S1Bgic8ph8D7Kreo16nJyjyyR0MD+usfE8nmr6
         S6sFMIovzFLeTmgEVZxrwwFn0cAC2vkGgj9Pkvtb6nNvjIpZU23gEXufrm8bnoRuB2Uz
         bMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800544; x=1691405344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOLHkJaT+7H0fEwKCF1U6y0LUywm6xuO1oN6Y683ukY=;
        b=iIdsTTUV+Buoqmgi3S0S7styvwdyWQsqeNPR7iXR7kpmePkmYy/ZFZ/dCv/jDiTyvD
         MpMQo/oQJX6FwYZaKMD+pD0AjJTea7t7xhJvfsyW3OFUNHEYGyNoneoEHviUq3z5Nmmw
         6n/1v+wpPDiXDdF+sDPVf/3VU/dVt6y/W9lWGDI3Aj8rW7QmjlVvMt8JBlB8dozPGRJG
         SlR+5WyHWDvM+txf3yvtCN98TNNeisk6Pwif5vCiTVn3Ce37pA5JJrzAVzZmTHlDGuKN
         ueSPcJFd+xpOoSyHaYiYuRqwfdDj+SUQmkT6xQGvpRO82eZ6t24ZYE80wmt1GLtLLd04
         UKpg==
X-Gm-Message-State: ABy/qLbS/aE472aMYWTwqLSc3+gCRrUZebcv/xczm1E3uv3MajWLi7UH
        v87zcS/6duK8mnspl98HLOU6JoVavU9X
X-Google-Smtp-Source: APBJJlF6qpQSFj22+rJwXVfNU7jT8nG/y2QM0YsXib8x2omrgoE9ga/5alIh5ruNgPiD4/m0AgMZfZ9hXHhN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a81:ec0f:0:b0:576:6e4e:b87f with SMTP id
 j15-20020a81ec0f000000b005766e4eb87fmr72197ywm.10.1690800544479; Mon, 31 Jul
 2023 03:49:04 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:48:15 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.5.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v2 5/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
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

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 654acf6002bf3..4f7fe19d88fda 100644
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
@@ -1098,7 +1101,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
@@ -1368,6 +1371,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 05b1f0ee60808..3a56987a5fd0b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

