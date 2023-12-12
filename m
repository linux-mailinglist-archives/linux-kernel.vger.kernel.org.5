Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4109480E19C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbjLLC24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbjLLC2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:32 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804A10A;
        Mon, 11 Dec 2023 18:28:23 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5e1a2253045so6491137b3.2;
        Mon, 11 Dec 2023 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348102; x=1702952902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRgDjRdiQ3wMwyUy9FFnN6Mv3fA6CH+t16OZs0Rwzhk=;
        b=njGHFwOtcDU42X9C7bBuGmJbwSuGJhDrZkqPkOqBFbG6PPFGLe9QBiGaBn15QlYi8W
         jVjA5H367FKG7+ERQpZg3RsW2a8hvP9g/5/kFgNk3oAOGRP7MbTmwffPMUs41SIj/rBE
         F8xlM5uNC3dhHL/7ek0Cw3b6a+cRXg0HNIXtj5Fj45L1iPCuHFWqwVQ/qKnXLss41AhL
         ahrgvw0tZSFa0P/RMkrJ2wmvtwy/rvAQW8HY3M4OuW1bcpfji1Wb6vcieHzgjAMCBMb/
         NNN7sHxDh8lPEu9dMBzo0GOEkDr5EqYVLwi9c54O2LrQfXiFyy3drfinIIzCVb13d+8W
         FX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348102; x=1702952902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRgDjRdiQ3wMwyUy9FFnN6Mv3fA6CH+t16OZs0Rwzhk=;
        b=O3MDm5aAelhHdsp4jyWghMYO4ewkiW+/Mi/rhbfVkh9/wI5SBvYuKMOK+ypc6wXZIr
         HAUACqBEogR5H7k/SFGsPdF+tP6O7jdBK+FFZ7PzRyu8Z1+SLlVQxVKjCycDNPrFIrT/
         uokqGASXUcoUs9XLNve/bfp5DTz2nUS+gy7cVKXBMdhMDA6qE+H1MR5SiwvvOl64GAn1
         EfF7I0j6KkXYrIqZuQryvsTJDXEDl3nR9QKJx/tcGhVyuW8TWcHu6mD4xyKbRLxhz5Gq
         TlSVvaL3zwN/q3KUlm8s6McNE+cYL+lKK+0ZjVyzodvucxFnLTRzcPo87GGBoKchRCy0
         CmCg==
X-Gm-Message-State: AOJu0YwGZOlwEXnFsNXaEs1xOGwxdIS1lgzea2STdnQAI9MoqqfyWbQq
        Uo1SaVDI48R45TEoFY0wvl2/aDC/QaPKjA==
X-Google-Smtp-Source: AGHT+IGMwceB9+j1udge1W4cal0kKbCSQgG5Yh316/EdKS360cK7bZCjDy7dckWdtEwCMNE+mk/JJA==
X-Received: by 2002:a05:690c:2c0a:b0:5e1:8405:8b3e with SMTP id eo10-20020a05690c2c0a00b005e184058b3emr1116070ywb.44.1702348101890;
        Mon, 11 Dec 2023 18:28:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id ff9-20020a05690c320900b005e184771849sm519809ywb.93.2023.12.11.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 19/35] iommu: optimize subsystem by using atomic find_bit() API
Date:   Mon, 11 Dec 2023 18:27:33 -0800
Message-Id: <20231212022749.625238-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify  __arm_smmu_alloc_bitmap() and msm_iommu_alloc_ctx() by using
a dedicated API, and make them nice one-liner wrappers.

While here, refactor msm_iommu_attach_dev() and msm_iommu_alloc_ctx()
so that error codes don't mismatch.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 10 ++--------
 drivers/iommu/msm_iommu.c             | 18 ++++--------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..004a4704ebf1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -453,15 +453,9 @@ struct arm_smmu_impl {
 
 static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
-	int idx;
+	int idx = find_and_set_next_bit(map, end, start);
 
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
+	return idx < end ? idx : -ENOSPC;
 }
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f86af9815d6f..67124f4228b1 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -185,17 +185,9 @@ static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_add_page = __flush_iotlb_page,
 };
 
-static int msm_iommu_alloc_ctx(unsigned long *map, int start, int end)
+static int msm_iommu_alloc_ctx(struct msm_iommu_dev *iommu)
 {
-	int idx;
-
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
+	return find_and_set_bit(iommu->context_map, iommu->ncb);
 }
 
 static void msm_iommu_free_ctx(unsigned long *map, int idx)
@@ -418,10 +410,8 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 					ret = -EEXIST;
 					goto fail;
 				}
-				master->num =
-					msm_iommu_alloc_ctx(iommu->context_map,
-							    0, iommu->ncb);
-				if (IS_ERR_VALUE(master->num)) {
+				master->num = msm_iommu_alloc_ctx(iommu);
+				if (master->num >= iommu->ncb) {
 					ret = -ENODEV;
 					goto fail;
 				}
-- 
2.40.1

