Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150775B3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGTQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGTQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:07:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874921BEF;
        Thu, 20 Jul 2023 09:07:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668704a5b5bso841790b3a.0;
        Thu, 20 Jul 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869262; x=1690474062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlR75jCTWnutj2GqCkt5kjAmLZ3uaWEFiEojxMDrOA=;
        b=GXaEZu3t4pzn71mFp69Of/QYBFraIdZR0yIlR4e3y+CSg61eWb/C+JUWIXDIW/WQQi
         w1YGEi/ir6nGvTDCNLj7//wk2OXaUurXP3D8Ysiu55KxtOWlj3L4J6WN9S3GjBjCfzua
         IXBLb7Q1ekV7FrKpMtRwxFQosIaReUr+x9bjvv1s5EJGi5Hy6QxqUlupVdk/qhnxh4L9
         D2Y7HH/JdF7yX5GYscgv9IpSoGszQe7i5O2tD5wleYgLJzXgxukdDbTotFB1CCxoh9lD
         TfjJjfEPuuDlcCjasdJBmtcMNgVbl7WlS8vxM3MfT0vuJ5F4w+ILpNlwDEj72ab/y47g
         ulPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869262; x=1690474062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDlR75jCTWnutj2GqCkt5kjAmLZ3uaWEFiEojxMDrOA=;
        b=SK1IAHhKSrHddn4nTQQRt5Nn8zSTMCsGbQ9ddA3wP+pqrx1ERpHyP321vY65BYPk+A
         h1o1oRrPb4PpQR8bxhWpcYQ74nRwFQ3W4SGMRbqLl1/zembLhvqwvZWDcu1eWLElyRNH
         HJ2PwK4mRTsWwAUk4SieANgCLsXXWk6qETop359VOOBqduNvjxg4DwIvQTtSNZopQPHb
         zkGGfBed8B4XyYsrOXfDxx0zO8+eScCCADyLFdb2HNtaNEvgVisOE3K8fFIOHQN9ctUJ
         LVhIbEh6UWwrnmP40LApxEHYYC9XqW1jwtCJEcZOZoyOixrilCQehUuHSwAOEY++pVPe
         lzhA==
X-Gm-Message-State: ABy/qLYlKyRntCzgtFpWfH8VCg5pdiVVvfHKpeLwpRTc2MjFQRzAvvTu
        Nk4x4jcdZoiLXmhlZS1tR4g=
X-Google-Smtp-Source: APBJJlGsiSzauWOSKd4n1ByDIDYS8P/EIAsQheqzHj4aeeJVZn12STbjIByZE7ft/dmtqsa6x71MsA==
X-Received: by 2002:a05:6a20:9383:b0:134:76f6:e9e2 with SMTP id x3-20020a056a20938300b0013476f6e9e2mr17240293pzh.58.1689869262478;
        Thu, 20 Jul 2023 09:07:42 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b006687b4f2044sm1348010pfn.164.2023.07.20.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:07:42 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        l3b2w1@gmail.com
Subject: [PATCH] cma: check for memory region overlapping
Date:   Fri, 21 Jul 2023 00:07:29 +0800
Message-Id: <20230720160729.39324-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

Cma memory region editted carelessly in dts may overlap
with kernel code/data memory region which is reserved by memblock
during the early phase of system memory initialization.

Without checking overlap and cma area setup done,
this region will be released to buddy system later.

When memory usage under pressure, memory allocated from
this region will collide with kernel code which is read-only.
And the following writing to this region will trigger the panic
of writing to read-only memory.

So when rmem_cma_setup returns EBUSY, do not phys-free this region
to memblock or else we end up with free the kernel code memory
to buddy system.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 drivers/of/of_reserved_mem.c | 3 ---
 kernel/dma/contiguous.c      | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcb..d62cc76ef 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -338,9 +338,6 @@ void __init fdt_init_reserved_mem(void)
 					rmem->name);
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
 			} else {
 				phys_addr_t end = rmem->base + rmem->size - 1;
 				bool reusable =
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..a349f3e97 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with exsiting one\n");
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.34.1

