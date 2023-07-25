Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3298761B44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjGYOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGYOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98FA2680
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:16:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687466137bso3225697b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690294573; x=1690899373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFxuOTNi48idsZt2cpb80HlTb2Zev1a6Crwl3aXBH/I=;
        b=Vnvg+6kraoEV4R961SF/K60SkLscD6ltMXTv8foeY0JKks11+5r4lBp5ADRIJyrOGa
         d6n2xSvOx7v42sVgmO2CyW1JxwyEDLIUYxFU/u6LAykPSzMllz9OSI3L//5uBQazyOYr
         vCe6fhoGyES7upDBUZVVRCwUOzjt3V787cVK3tYVRXaVKTHb5X9DBhE+fA7x2cTnxfc2
         4zscfVQYnRGlBpSkRDrLDAgcweyQv4q18QGI9NHE9wJAnCnUm5VKiGGfIW/ELbLw51GG
         7zeRqRVYAQH19p4/3qTj+45e5XJS7pmB1NAopg+dGGPRH6LKSDZC2fUpsPpBulDZDDas
         mwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294573; x=1690899373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFxuOTNi48idsZt2cpb80HlTb2Zev1a6Crwl3aXBH/I=;
        b=LNAEH71F9qhUO7i1s5+Zaica7Lztx4gyzENv+wr+nbENN1a2UbEETGtYIU2J1l24+k
         mGzpCr0qDlFnd6j5M+nIEJZQT+Wox0b92uFJO4izXCHZ2AV9maXWmTWDQTz30pc68+eb
         VSpqheKT9PAOWq4zuMDYC9QX2WbpofUO/7MdPVRDvwUdhvxd7xkFbpuvtQU0ai+WdT5x
         qgUxYVVBNQDrbSGTES+dgpvkiCk6/qKBXBvtVc0o6Joxe3ZcCOvdJpmd7gUIgz8LjqLC
         6JsY3C00jm7fQt1YuLCFDAyJVSmccsp4a4sQO9ZVh5nANjXCpKY6YGWqQf9FrBqeENFo
         Lm6w==
X-Gm-Message-State: ABy/qLYE6DbzFh9bCxWJx/qfTUkne7ZoE775+zVfb5T2fW7C4zLkWelL
        21WnQ7yAug/Rp1LDAC13ufFPqWXKLlqeJ93zh0Y=
X-Google-Smtp-Source: APBJJlHnwscllbyiMqyKzSni+zvMpZ7xsDOd2enSsYZDaaLi+YxRoadU3GPJJ4wXqwVYidJ2mvJSKQ==
X-Received: by 2002:a05:6a20:841a:b0:135:4858:681 with SMTP id c26-20020a056a20841a00b0013548580681mr12732107pzd.9.1690294573391;
        Tue, 25 Jul 2023 07:16:13 -0700 (PDT)
Received: from linux.. (static.111.40.78.5.clients.your-server.de. [5.78.40.111])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm9601482pff.219.2023.07.25.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:16:12 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        l3b2w1@gmail.com
Subject: [PATCH v2] cma: check for memory region overlapping
Date:   Tue, 25 Jul 2023 22:16:02 +0800
Message-Id: <20230725141602.7759-1-l3b2w1@gmail.com>
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

From: l3b2w1 <l3b2w1@gmail.com>

Add a overlapping check in the program flow of paring dts.
Check if cma area overlaps with memblock-reserved areas
(kenrel code area for example)before calling 
early_init_fdt_scan_reserved_mem.

Signed-off-by: l3b2w1 <l3b2w1@gmail.com>
---

Notes:
    v2: delete the logic code for handling return EBUSY.
    
    v1: return EBUSY when detect overlapping and handle the return case.

 kernel/dma/contiguous.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42..20ebbcefd 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
+	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
+		pr_info("Reserved memory: overlap with other memblock reserved region\n",
+		return -EBUSY;
+	}
+
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.39.0

