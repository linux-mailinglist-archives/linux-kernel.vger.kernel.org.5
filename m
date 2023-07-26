Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B23763918
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjGZO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjGZO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:28:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D29B4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:28:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb119be881so51637415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381713; x=1690986513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCvX+WYhj5dekGw4g3WHkvBAMFYYr8sXX+D13FHMfqA=;
        b=f3dsw2E2l/B/cUFrODAkpl1M5OV5n27zUh0TtgO7ZVOPLJBKhFVIHjs+5JB8zmB1sy
         suMKD2y9b0K4Ha7tTHZvAiIupK8FK/ggWg/Y/T30voOfQE9nbUOygUDJCgwPnd9DaIW0
         rhc9Adfd7VRJR1ip84y2Y9F6pTcDx/3FbWxuI328R3IufSOP7emgXXaTsXCpvClztO8N
         aRpojkWDoGwkSrT36kghgwaJJfpZGLPkmeYyuHoXHAUu5yuqOu0HgxFmePOJ4EqIWhZz
         Vhs8N0aW0sG9/G/EVh3bo2AgKnFWIkcRjAzq950BlbibwDQSRCzGe3ZTXQMRBGglcWzq
         pD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381713; x=1690986513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCvX+WYhj5dekGw4g3WHkvBAMFYYr8sXX+D13FHMfqA=;
        b=ETVQJy2L45w+HZOfGfjW/EAH134ydhU/dfEmXI2guTVT31CGJKjkjy3AWcHWD2Tw5s
         YNDcPoOh6I8RTA7+SCayP7x8miuRNTDuHSiagSUX8K2CMXzk7S+5FcNa9gJvTiV4F8Qs
         cWNWDlEWevYVh6gLWL03QnkeEpRQ+jm2WOpZcI6O2bMRE/fXz85pkAzOovKWc7Z5mPdO
         C4t0YTrBVf2474oGNQj+z8AWFD++HmJ3VTq3W0rr26DNOvLtuaYBZDWk4QdCCYri6sAd
         xWtF/PTmLv2sAorYF1d/S1zI0TGuPnd3iu3XOPeuYP3htLrJIH9iZxLfaYw0j9DLXg0+
         +d0Q==
X-Gm-Message-State: ABy/qLaJOUFgWDLTQ3agRH4bg8bQE1rBborDtiOwtKqQdR0DmO4/bC4A
        kXA9xjeteEIHq2UXWUstx9c=
X-Google-Smtp-Source: APBJJlFgRurokiGu50ZcGdSRGZbbIAEsnfEeD56NX7ND2XmLmc3XeMtiBfQo2ah3ofMPQZ4U2bnpoQ==
X-Received: by 2002:a17:902:ec8c:b0:1ab:11c8:777a with SMTP id x12-20020a170902ec8c00b001ab11c8777amr2739116plg.13.1690381713404;
        Wed, 26 Jul 2023 07:28:33 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b8b26fa6a9sm2189312plg.19.2023.07.26.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:28:32 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        l3b2w1@gmail.com
Subject: [PATCH v3] cma: check for memory region overlapping
Date:   Wed, 26 Jul 2023 22:28:23 +0800
Message-Id: <20230726142823.6356-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

In the process of parsing the DTS, checks
whether the memory region specified by the DTS CMA node area
overlaps with the kernel text memory space reserved by memblock
before calling early_init_fdt_scan_reserved_mem.
Maybe it's better to have some warning prompts printed.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---

Notes:
    v3: fix compile error.
    v2: delete the logic code for handling return -EBUSY.
    v1: return -EBUSY when detect overlapping and handle the return case.

 kernel/dma/contiguous.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..dc6d2af1e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with other memblock reserved region\n");
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.34.1

