Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391277FB71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353457AbjHQQFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353444AbjHQQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:04:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B930F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:04:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso82869567b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692288288; x=1692893088;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhmsuM5yHQfjgDqk/74LT3YBolDr49Ko8c7EPxuWM5Q=;
        b=fpTsJB9QT5AxLuechA/2AWtVlA5fkNgrOvdKvs6fU6vVZrpzY+0HwOk7iT4oEsqvvj
         igoEHneiHtSWmblo1kPXhQgIUExEQOKv+VoEB0qdMYR0yEgqXlHoW+Z0edU9LLQPBD6i
         UDexN08PcHJzpFu5gtNVaobxrvOvaqyMpn/aKtWnfg9/mnONaXIH5S5IEpzK2LGuhos7
         dVRFwlCzsF5IJ0g9BBhyKSfA0Aoo/tblAqaby34DASj+JXCYQd2fHAVQfQkURcu/lPhP
         s+WQ70AoMHWt/3jnmWu2VlzsjJ8cBoqSG+Z81b3K4lYJsLnY5d6I9WKJkHwZTFP9Rgbc
         BfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692288288; x=1692893088;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhmsuM5yHQfjgDqk/74LT3YBolDr49Ko8c7EPxuWM5Q=;
        b=lBIgJP++YlSM2wZ8qeI8oiPdlaoxrUagUge7auYNy6FTxVM9N3xE4frUy/K8p9ESN1
         kaor8za05KuL88FsBBzj1ZbUXPWTdNvHqv1jZqPPBMqYTs2Kt+P3wQ3imH3omfnOEROB
         ZG0iba9DXrMpvxk/gJYweCpZtwim5pOQfA25b7IRs8hsCdawbugCM80fBIA7AsOMkts5
         yk9APRrHOgtrmCxQjtBsfq2trn6Xa2nPC3sZxbuinkN9+HmobHukzqqwhMXDJzwsoI+0
         pcvvhXO8Kykks1jZ+yso+X0A70e7EInMDlLI0j9GbksgnYiAA9IYogWENlUbDLRpTCrt
         FYHA==
X-Gm-Message-State: AOJu0Yx+pD0bgt5fE5Q5GXZ2Rlwwc6NTkITEZ3suG87MSJ+SWBJNB79U
        1tYDa4lyArNwa8d+ljYj0CJGTtdHkGRZ
X-Google-Smtp-Source: AGHT+IH/2ZEVO1MgS6IrCQGrdLUhLc7XCvX7bO1lPrLmBV6kXD7edJxFI23NCe5BR7m3R10h3YAQoKli5qWR
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:ad1a:0:b0:576:8cb6:62a9 with SMTP id
 l26-20020a81ad1a000000b005768cb662a9mr76288ywh.6.1692288288309; Thu, 17 Aug
 2023 09:04:48 -0700 (PDT)
Date:   Fri, 18 Aug 2023 00:03:30 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
Subject: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev
Cc:     Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Will Deacon <will@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

It is invalid for an arm-smmu-v3 to have neither FEAT_TRANS_S1 nor
FEAT_TRANS_S2 bits set, and this is even checked in the probe.

Only set ARM_SMMU_DOMAIN_S2 if FEAT_TRANS_S1 isn't supported, otherwise set
ARM_SMMU_DOMAIN_S1. This is clearer as the existing code implies that
something more sophisticated is going on with the stage selection logic.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc35056019..e74c8c630adfa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2206,7 +2206,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
-	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 	switch (smmu_domain->stage) {

base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0.694.ge786442a9b-goog

