Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AA8026F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjLCTem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjLCTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:13 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D01BD7;
        Sun,  3 Dec 2023 11:33:44 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d05ff42db0so42210827b3.2;
        Sun, 03 Dec 2023 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632022; x=1702236822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vguNRNHZWUrDOSu/TVKVOPIB86L1io3LlGEpKJkKhiw=;
        b=BnlSM+sEOduvbEUrrvCDcvg+vYlF5hKVKUkmiSk20y+NXZ9rlfSFBC/XxwGXu5FxnQ
         OlZgRkfBLkFgr05ufkOc0kNxcSpiDLoBYJxmjX3oSyl1DVw8mQ+OrQmgaiWTm34E5oSX
         a5vBPq/t9S2WHl3qKcrmyrK1l+TTV4/nll23ZlhcEAw0Mz6zRG5M6wqOAnHkWIPNGFuq
         baLJeW9UzP7qWRaTB2MYyBJ2ieydGukGKUviNHKT4/tf1za6SsgC1TyhNh4Z80T01saR
         h4Mi5/Pmmf7FYTLEHZ/rYDlmpZ2PBZOqLYv8EQyDOPMyfkSiHuEz+Fnurd1cu8dfpDJL
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632022; x=1702236822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vguNRNHZWUrDOSu/TVKVOPIB86L1io3LlGEpKJkKhiw=;
        b=gVhYNGIpHnlP0Swz4VKfhieUzc1u1Sn7WBUKlE0/GDvT8vHe1IuMmbJrZcYJvirVZJ
         ZNNd0u5c483ckzVfRkZ7QKSsSRHYgU/rcsO9+HbuFNTRI1SzWMQmYnZuiHfER/NRo4eB
         hyREQEwisSG6Elyi6KI0MFtDtmwRNTbEL4eZbPiXyLgoJbW240PBf8vxqDU1DIGSoh3n
         5HpN2vICySn0mncf9o4YXZ5QrifCyuu1XFmHf5h8fXTbVoXdViA+D6x4PXhutaoOvlD7
         M0oX6xtMoLtkTD0St/mQu2aFUzqpQPnpISuJXmFEKBI/O46FKXKhFBd6vnmk5LKNpDYO
         K6eA==
X-Gm-Message-State: AOJu0Yw1guZMuv8NCiiuvpWm1KOmExUEo4o/ClUHhU5JVHnFxbTT7gGg
        5ejSiDR7AcyghB9FGx9pAIQInWumTTk75Q==
X-Google-Smtp-Source: AGHT+IFSv+65IiQiN8WCGcLVQvQiuR6hHdW5qXQ7nf6ECXpLpXmmUxxmzvhwBggjw2vBz5nonWlXlg==
X-Received: by 2002:a05:690c:3745:b0:5d8:5fad:8dcc with SMTP id fw5-20020a05690c374500b005d85fad8dccmr507589ywb.29.1701632022542;
        Sun, 03 Dec 2023 11:33:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id m190-20020a0dfcc7000000b005463e45458bsm2765478ywf.123.2023.12.03.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:41 -0800 (PST)
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
Subject: [PATCH v2 19/35] iommu: use atomic find_bit() API where appropriate
Date:   Sun,  3 Dec 2023 11:32:51 -0800
Message-Id: <20231203193307.542794-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

Switch opencoded find_and_set_next_bit() in __arm_smmu_alloc_bitmap()
and msm_iommu_alloc_ctx() to use dedicated API, and make them nice
one-liner wrappers.

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

