Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CED75BB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGTXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:22:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347B1724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:22:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb119be881so9942605ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689895320; x=1690500120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjCoDcXSzuJEaW1efhPSb3RNSUyxQu5V/Hxq+lz3rlw=;
        b=L4fS7j2fP9Ixp3TUxZ0LXvyn+Awk0N+bglYo1G6/i3mCE3jlY34HTMNCldI7WxMBsQ
         35cLp+dS+mQG3H1znRyLlYZcdXhr1C1S34jqspVjAXjBrN1z0HnI0El3F1jmowVFTK/0
         cyvXCkJerzdjL5cRL4p4mkV1bdx5TxpXxskdWcgUOOzYwplG7++TDRi9zD70vbaAIrVA
         p/i+8dGWCMp2bpKBs26/+MpGdi9wO2Su9FXPtYrP8s5CHiTsuNzkNQNqEVtMQOt7Jnha
         0VCE0G2znj/f9yzzWnlP2OK1gMRKbXT6FSDAg048/irqq3eaT3JXIUOvtl0fh4o4hAYH
         ULDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689895320; x=1690500120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjCoDcXSzuJEaW1efhPSb3RNSUyxQu5V/Hxq+lz3rlw=;
        b=K5xs9QotPQ/IMTiobbGLLGbdWd/rLDXqSLG/k2e1WtiZTjX1NvsZVEnAAWzmuGCsuv
         KSxJi/z8FmTtnj1q83BvzJPcY6yILcOtjVQM+afvyoUmGo1uhDaoJhh1SIqApPwjyg3K
         tkv1laMJeatTvt29EUCVcN1orbbjqDF7e+JreD+weKaAMpH2Wi5+wfuD/kmVtwBT+u0Y
         larLKDn2kMtilH6y3afTBTwL7SgkG+6u+2bSzODiD+ve6/vjM9/vjcs4x9I4Z2W0H/9j
         6dA8bMVy2PHxLgXTZ2iGuGix9nQ+Gto1RO0z5IHgHmnbJEc56dgGTMinaMIXViPUWvj4
         HyjA==
X-Gm-Message-State: ABy/qLYd3Z5HPwMsrSkaA/L1tnnCNilzQlfW3BK1BzAqvSMqK8MO0FuW
        62uNQzJ6G0SOpXQnkBl1zqI=
X-Google-Smtp-Source: APBJJlHhaKPGvjH/nZHIpKyzPxtoroonfLHzarlmGBQ3jJimUanhdgD+rzgA9NzzZ5cFqKoVBiFd1A==
X-Received: by 2002:a17:902:c103:b0:1b6:9551:e2b8 with SMTP id 3-20020a170902c10300b001b69551e2b8mr376261pli.34.1689895320439;
        Thu, 20 Jul 2023 16:22:00 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-98-231.dynamic-ip.hinet.net. [36.228.98.231])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b001b7f40a8959sm1986182plb.76.2023.07.20.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:22:00 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/apple-dart: mark apple_dart_pm_ops static
Date:   Fri, 21 Jul 2023 07:21:54 +0800
Message-Id: <20230720232155.3923-1-minhuadotchen@gmail.com>
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

This patch fixes the following sparse warning:

drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 'apple_dart_pm_ops' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>

---

Change since v1:
fix a typo

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

