Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB6783E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjHVK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjHVK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:57:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721A1B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so61983427b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701869; x=1693306669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMqZtDvlSX07gyZ0u5Dl6BMVcufM2gRGniU6L1WlEwU=;
        b=Ix94X6F96wzJuSjo8aNRndBwhpicfnsuKrnh/oKMivxMGel4dqf/ogPNg5Cjxvi5nr
         AB8AM/bRuJIrrA2LkbIZv5WEt0WUI8brlEapCeVt9GCvMcnD3igwxweGtHcPpHjgvUPP
         pv9/113iyGn0oOkSawXSC5qJDnIB64Zdyu1HfagqXJnoBMRljhv7MafWdZ08MfLITQzj
         21J0HSfeNwlbaaDlfi6LLhjcmPouoCOnSrty8NKTE60KbB8hskmCwJ6xGsM/80vkjilK
         np0gAcI5YY62LjgdlEyDYVZw6pBStWJBQQYAVoUl0Io2mwf/zMAZy8YXueXOcT35V3v2
         YuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701869; x=1693306669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMqZtDvlSX07gyZ0u5Dl6BMVcufM2gRGniU6L1WlEwU=;
        b=gdbfC/+9FnNfRsMBXApoeEEINrQBJYavphWU0F3xpQncG2jbWFC9jrUT+uDKekXlau
         7rAygigwoZ/3tC0u7YDeX4pcBhB/K2JjA78yMzPTaBNIgG3AOfgSi1H7h6YI/Ogv5OaS
         XjJpZXChtjjndNiujV2NVw2v0vvDTdyZoQR95c7/GzwjtbfKkoZaHPCJ6khmthPgTtoG
         lOUpRihb5+TmNLYwQfuvTGms+kUDHBt8OBkROAWbMdr22Xq5amaW6EZS1l3TmxGGRGrm
         0egeL12fRvxPfjf4lJUm+2fuFhmRhgUBXtbNnaskzYyCd4NOGXkAQYKjNCuQbIzhWwDD
         PmAA==
X-Gm-Message-State: AOJu0YwAy9RMFeVLsCjJH1TIOWwU9ATpA1E9CfrHi2IgR39jYaGy2ZCA
        KHjHShIaNNErH2/bnmPbksiv1/vCDCPJ
X-Google-Smtp-Source: AGHT+IFl31R48qo4ur1dLKvDtJJz2U6vSie9HrG6LLwP12qhr8EwPDR8M4v6oArRwgOrfdiaqHOQuhpRrYQ8
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a0d:ec47:0:b0:579:e07c:2798 with SMTP id
 r7-20020a0dec47000000b00579e07c2798mr95478ywn.2.1692701869478; Tue, 22 Aug
 2023 03:57:49 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:56:57 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.1.Ib87a2696f25414e0fc39cc22dc74e31a4415c2a1@changeid>
Subject: [RFC PATCH v2 1/9] iommu/arm-smmu-v3: group attached devices by smmu
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
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

Always insert a new master in the devices_list besides other masters
that belong to the same smmu.
This allows code to batch commands by SMMU when iterating over masters
that a domain is attached to.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f17704c35858d..37b9223c145ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2382,6 +2382,24 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 		arm_smmu_write_ctx_desc(master, 0, NULL);
 }
 
+static void arm_smmu_domain_device_list_add(struct arm_smmu_domain *smmu_domain,
+					   struct arm_smmu_master *master)
+{
+	struct arm_smmu_master *iter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	if (list_empty(&smmu_domain->devices))
+		list_add(&master->domain_head, &smmu_domain->devices);
+	else {
+		list_for_each_entry(iter, &smmu_domain->devices, domain_head)
+			if (iter->smmu == master->smmu)
+				break;
+		list_add(&master->domain_head, &iter->domain_head);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2435,9 +2453,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	arm_smmu_domain_device_list_add(smmu_domain, master);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		if (!master->cd_table.cdtab) {
-- 
2.42.0.rc1.204.g551eb34607-goog

