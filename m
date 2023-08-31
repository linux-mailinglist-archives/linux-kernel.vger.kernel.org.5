Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F144678F21D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346916AbjHaRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbjHaRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:46:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E6E7C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso13768977b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503960; x=1694108760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByI1wEibb2VTlOST1QE2nymSPLoO1tZHs3WuW7YknC4=;
        b=Dpkn72Njeaw/NHD7HGE77sAWsit8z0YsFeQI2QL2BlaHijvsS411joYD82mmxQUNr7
         C7o8LsSL9YAAnHm9JfDeuirR8sLx6qjmRxcfZyB/e4/eCRL8jZXa81atHXM9ukPWvsK5
         eZjDnhI5raJv06drh6MPgkpbPcYqq7cqT97SNtTIDIkQ7J8trjVe5cFXrC+C6+ySCcma
         vWe3RguaPUA5Mz6skPdL4znIhHwtXuqYRYRb/c3B6seDW2dLPt/os52Wacv/66B/z8GY
         w/C1WTXmWdiKhR0BO3GS5iu43mScvVVUGu0hGyJo5LZNNmDBRCR4qHry7B59SOouCtA6
         vHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503960; x=1694108760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByI1wEibb2VTlOST1QE2nymSPLoO1tZHs3WuW7YknC4=;
        b=iAM+UF2RLIcOsuVpkbZanNdvjpw+6cfwTcZkuxE7RiJKfw2bDpZmEbf9/hMmGPCLWk
         kkCH4yXy/Ik12ISELoAM1jehF54if0jzBuiS0ms3JFhYv19zjXNFOGwS1nPvJwOTPo3y
         42NLldQHdDD1lJBztakjcEbu6Kbmd3RpWMPVqn3yhXKzYUUjE9vw4hhzfMYBpXhd2eAp
         HQq0jtVaCbw3nD8uzyJ+TmWdCC9ogAZfe2pxVpjPqmj/wT27x+AdQl2qHgc8BveyptGK
         5IWopchclDdqlSokKuLoFPM+wj2Bru2hafnkCdi3NEjn7Xhv53GMh1oiKDqHe3ICbPJx
         qrew==
X-Gm-Message-State: AOJu0Ywtb8suh20Ys27j3opxQSEdmUA2ICD/J1+RGef9/ZO4TpBE03w7
        TJq08xvymlvIGiu5UsePMZETOKIfgE6b
X-Google-Smtp-Source: AGHT+IETeP/TvPNLQEuYy1USk5YI0K7POPLA/zLoU/1XNZBN0JFR3w9Gk0WHW9caWehCDRFFCCFE2F0gY1LX
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:eb0a:0:b0:576:8cb6:62a9 with SMTP id
 n10-20020a81eb0a000000b005768cb662a9mr2924ywm.6.1693503960746; Thu, 31 Aug
 2023 10:46:00 -0700 (PDT)
Date:   Fri,  1 Sep 2023 01:44:32 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v7 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
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
2.42.0.283.g2d96d420d3-goog

