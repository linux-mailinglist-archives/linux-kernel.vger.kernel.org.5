Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAD77E268
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbjHPNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245473AbjHPNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:19:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D126BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c4d30c349so29229537b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191985; x=1692796785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Qph3ozTnmUe4nSAzwJ4ofPLTPQz2snZpAAblUqODc=;
        b=TmHgiutirouQshZamGptMenL3DNfb6BiuDDxQBMWdGsIUyxPXe7a6Bccf489Amlq6J
         9Sjd+HqbSMemzDTpNMSwgIQ82Llpc+YDVq3Xs9QZpy+9cWPhEv4LaPdtffxQqAYlC1H4
         r6WwCavdmeNmN3oL/td4Nr0reo1/FIY1soFjVIVuOjAjdMyljKyWHIl3WaIvjlkCss+u
         75JVXZtxooXr9CFJSDPU73k7OKB6mqCttmx98ddRUWUzlbqTdE9DgcZJErkhNrZJNL+c
         ZUDKhWPxJMrqNHt3RB+OzM917I1dF1v7znoHqjF4+G6QcpkqnEsbuZW3y44onsBwd2Nn
         X6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191985; x=1692796785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Qph3ozTnmUe4nSAzwJ4ofPLTPQz2snZpAAblUqODc=;
        b=El11TMVxwgqbSkkhhmHQQPg0NWgj0taByyj8usOKSIP7vmVsiDecoyLPHfKnIg9LZK
         8Aig5X7UFYOcM6i3V8ADMIg0VaJTVC2NoLMexMh6okA4sYAca+GEtm4O2WEusYtDECg5
         dnJsK7JjPdgAnFiCarDwoGsJjxQs2gZmyvfNfKmYQKwqfKVG+/geFpX6QW4YZbsTFWar
         43qSvFRhdD5Po6Tm1qOx2o4HKbLClqUHGj6Uk91IW8+q+9Rbf+eP7dYSuNjvMKr5lmWP
         G2jA4c6dlBPfxckmaHrOE8KnqG1V6CtH1MRHgoc6z/n2F7HXeayk9FRI0AUmu8C8z+4e
         UOfA==
X-Gm-Message-State: AOJu0Yzqg5nhwAADh9HMJFvmJ8X+DqyVVM4O16VDGeztP+ZvHa4H8CEX
        6R2425P7Y/yQJsTpeF4q08bRp6vPMveu
X-Google-Smtp-Source: AGHT+IEQkGlhcowEepsZcDP4dk0vcyGvPOlRQmzOByosSK0aD9YS7+DG0MWabh67GUnpxb/n1LaxVC3xXZlM
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:ae1d:0:b0:583:5471:1717 with SMTP id
 m29-20020a81ae1d000000b0058354711717mr25272ywh.10.1692191985709; Wed, 16 Aug
 2023 06:19:45 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:43 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v6 03/10] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
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
index 5d1977027d2c4..5bb13fadb41ad 100644
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
@@ -2105,7 +2107,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2118,11 +2119,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
2.41.0.694.ge786442a9b-goog

