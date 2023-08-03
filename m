Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8113576E552
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjHCKOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjHCKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C04272E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso13814577b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057647; x=1691662447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wRhIRrggJAZYs6e7aV6RdIU6iSXzW0ONi/CWI4qUk=;
        b=v8M8EpvgykyvNj5+VFK4+5VS1GCx+4thN93X5qGdv2Q6mDg+Q9BprkKi/ZqVY1cMB5
         hgughi4UN1aYu/EXNqY13NPNEQutZvvu2GYwDAvr8QOh2o+EQF3P9BYp4pftEx0ox7R7
         H293Y2C2VTDWZWO6xMfqIKxlFoQitde1l6TRNNpWpcVfHJP20iQVEqHd2/LLHggfZnBa
         ZYsMt0hplLT0HqFF4jX+LVen+NA6yXSnT9/tIhVW1iyXGrZn3ULvFc83mH9XfV5ftRLp
         iOKnNntwlT0uTtypEVze4RGIkmvLieWvFRULXEHMTA02TJWP0zXal6LCAjTnDjAfnCr4
         3weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057647; x=1691662447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wRhIRrggJAZYs6e7aV6RdIU6iSXzW0ONi/CWI4qUk=;
        b=IVTFdUOHs+O8L1KJaGQnOswhWScW4j+u8aHjX2ClOBPUPW+2Eu5+roOdKf1gQO53Bv
         eQDMmznvjvJzfy7cEW9Y1jmU2gYukZk1QPrc24uucrSAkBByZAchlhOCnEj2fl5QW/W/
         XMmF10CnSbdO0DFsrxFjZq5bvyKJA0cHYQPSjduK+40PWxPmbgOrr+lucCDL9V0mtFYI
         D2mC8nrWhAB41415YMccg2+eDGJi/2Nd5up14nQS97j/bOewATLzI9o54MwQ2lTGpd8b
         0Ff4B+gKLj0rZZJZmlsq8GmxsEtU864SViWL8K2nRtPv3Fx7Q1vcr/+uu3yE+u4a0vlR
         J3kA==
X-Gm-Message-State: ABy/qLaJ0vr/5sYIYFwePexhynT3DsUJZF+Lj1TtkWK1L53wdFDYFW8q
        5dRqWqLeLmq3RHo6WXDO7K4X+7HOhVsv
X-Google-Smtp-Source: APBJJlGq7z9/Y1wQFTi6d5yV5b9fzok7EZ8JGI+3DYlCHleYWyG2dZOEveRtsUS2kTL+q5mmdG0WEODi8+D8
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:b301:0:b0:573:54d8:e5be with SMTP id
 r1-20020a81b301000000b0057354d8e5bemr268745ywh.3.1691057647550; Thu, 03 Aug
 2023 03:14:07 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:21 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.1.I18d69f4908b8a9f801239117d2a6c3f5aa1e2e76@changeid>
Subject: [PATCH v5 1/6] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
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

arm_smmu_enable_ats's call to inv_domain would trigger an invalidation
for all masters that a domain is attached to everytime it's attached to
another ATS-enabled master. It doesn't seem like those invalidations are
necessary, and it's easier to reason about arm_smmu_enable_ats if it
only issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v2)

Changes in v2:
- Fix commit message wrapping

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 61de66d17a5d5..4df335424b266 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2305,7 +2305,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.41.0.585.gd2178a4bd4-goog

