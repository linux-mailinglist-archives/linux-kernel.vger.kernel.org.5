Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0F75A1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGSWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGSWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:20:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE81FF9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:20:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8ad9eede0so1049735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689805238; x=1692397238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IwjlxlHW+LyjKwbZhGmbSPjjjJ61hnkvbBCUfDjZtk=;
        b=TxVJTnnWETGZjFcjn5k59+Yst4jpK6AajqIApsoMwWanNGNc5/nAkYo98sBAnyYbHB
         68Gscz5i1kKEvbboAtcYODLyRtUOJEJ8LJV9yV4tvsgMlv+SDaoIx0PsxokSPG6bgIxN
         xVNHuyCoFL7Ru+JI9zDXL4HTPRGrIPpfyRewi5FmxuOxiscO+rxJv0JKNcoCa1MmicHL
         o2f+2HXxAgCzhCXlRGeKEnMWUo0s+FQxZ8XN+s3SO/6zIzINitRvXngnBMWZ7VI+qAuQ
         5NxVvObToRQwYOgdu+G6U4O7zHvE9Z+RPJVt6sPk8lHbJIL/dF8PJK7wFVXhfc22Jbms
         ZMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805238; x=1692397238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IwjlxlHW+LyjKwbZhGmbSPjjjJ61hnkvbBCUfDjZtk=;
        b=Kp5LGQnVvtEgUT2tW03MA1DxdXHo547bAEbLp3iZVm8eHNdvaTdXYIC/HTVfbcuNq7
         wiVYTWgoBqMHsorHOZO76qEBlsTWyD5zlF+5hGWlVjlv9qx07B8o1SFglmJBnz9w17G8
         yiEMsQpc4GEsH85LY/ixsOtC7vQR7ukAISC2yb/GAUZQ+YrzEfDaH4ER5zxcdAv7QgEr
         82VbvNWZpfHyMKWQeSukV/bhvaS+lXEu0CVhA15/XNNLwTxQESLh7VX178rBkTA2nnND
         ZE4rbN7vmrWfoWG6NNhY8Gyh0XBMBzVNSi+x6a4whr502EqzF/KV2jvdAQex9ZZeldET
         GS6A==
X-Gm-Message-State: ABy/qLb3BgOWgCMcFfoZeh9zP+19kYS6iiY3NWVdcAmKTehYkw7L037s
        5NWzrtSAuwGtJZxidUFqddU=
X-Google-Smtp-Source: APBJJlGN8EC/OehO6nRLfH5/6Tw0y/ENWnkzpGQDeCVqe7UUiVnMs8jI1TYEvFFKSnPGrkZTGzqY0w==
X-Received: by 2002:a17:903:234c:b0:1b8:4e00:96b with SMTP id c12-20020a170903234c00b001b84e00096bmr4803311plh.9.1689805238376;
        Wed, 19 Jul 2023 15:20:38 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-69-4.dynamic-ip.hinet.net. [36.228.69.4])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b03b7f8adfsm4461150pli.246.2023.07.19.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:20:38 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/apple-dart: mark apple_dart_pm_ops static
Date:   Thu, 20 Jul 2023 06:20:32 +0800
Message-Id: <20230719222033.117513-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch fixes the following sprse warning:

drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 'apple_dart_pm_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 8af64b57f048..2082081402d3 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -1276,7 +1276,7 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 	return 0;
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resume);
 
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
-- 
2.34.1

