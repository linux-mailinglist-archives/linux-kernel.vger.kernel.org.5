Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BA769372
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGaKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGaKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:48:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27D10C7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso58230667b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800535; x=1691405335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LEwoPypxNg/0wwK9DSpnnqLrV8S3AoRDp+1fjKUE9c=;
        b=EEMFNUSXVHTC6HAOa38cmSdOEiaoD2jrNpOHT4VveZGabJGsF8dATyht8Xu/hVKbF6
         yF/iFDQeMQ7/gWSYJLsfl+7c5oWtTZh4CfBNMmT/WxVunxHXK3tDqFjxNbgpcGTWmW+6
         cCaTaHWSlh3Tx2Qr1H7elgc4IPaOX0m36Jh/tnctw8a3UvBC18Lue9/rCCUw7agpoWnn
         jucQMcbNR9YDAU9QQomc+FfMt3++7DCVfUkBTYzM86OAzAZaPJea2J7EHFIApn8iEbL9
         HLW1iV8Q8HojjNdueabZhuwjVbL6Bl/q/sGb/wFWCKz7nO2mFW0tD5gwBxK+TJ1ofVJO
         fIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800535; x=1691405335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LEwoPypxNg/0wwK9DSpnnqLrV8S3AoRDp+1fjKUE9c=;
        b=fJs6X6W4VBzruArmPfFGcP6NCS+3e38f87vFGiuMNizhAR0LaaTCda+R2mpllBqgDa
         1kURdqq1JBjkS6Wal6ldWJ2icOtroi85ZsjWcFvXUQCpkUcih90teOOq2Gz58nPL2vOS
         2nCZB1TpAJQAJadzdTiSva3LI0LN7TSpYrBRY2WgZheJ2z/G+6ahe289j7pjb2fqVOBJ
         zQgZNJxVPGL7ASRBC2PB+XZa8ouY0sT/qeTIyFgBmzcb9qRn8Fn+UtnzjL7CURzH8mCA
         YIUNr0wcjd/ZJmd2N8e1FBkEZF2ViW+XeIDs0kIMjIppCjSN6CdyqnrUfeb42xCUimta
         knfA==
X-Gm-Message-State: ABy/qLYEzD9T8CkiS5YHoDq625DqEMpBPHCkv70/WMzgml5YczDyAyTc
        vj/IgS3XnGqAb0Q0JQbwyyouJ7ecR75o
X-Google-Smtp-Source: APBJJlGFT8JRbNN2pllj+H+26z9eiMA1wqXAGjOqgKNZgKbHNZEnTJSje3k6Z2LOS2azPtan7cioZd2AbX0T
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a81:b703:0:b0:584:41a6:6cd8 with SMTP id
 v3-20020a81b703000000b0058441a66cd8mr66785ywh.8.1690800535642; Mon, 31 Jul
 2023 03:48:55 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:48:13 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v2 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
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
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8cf4987dd9ec7..8a286e3838d70 100644
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
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cdcfg->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

