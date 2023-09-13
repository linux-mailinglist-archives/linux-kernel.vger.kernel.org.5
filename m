Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7279E55B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjIMKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbjIMKye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:54:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463AC1726
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bfb17435e4so15902811fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694602446; x=1695207246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av0vrlLKsg9xBQaLOcb8CPCy93VQFu46a3TbtxpfU4U=;
        b=P5GWihmMHmwcNkj9lfDILOmiDbCAze1/o2zhKzbWGEmPSTV6Vveaa4b96w64JfAGgH
         UXr2WFXck9FLMeG1WT6GZbzf1dY0VJ7tee9TjuJSGvzLjKfdSc7J7pv8T5I4d1SxIC8P
         JByflZJXcSNcu7WmFW2H9ub1Ppgi0oYGo0feH64uYnCcKfTojMGVee2IuWkhYXFMW70q
         TRqXzB/7caGX1dcpqMkotb0p1ELUEMNCICleLJsP3QpsshS90o22q0w5SDW+RF3jj4hr
         9zQvnQaiBYEcw1vVXCq+x8xmtHHlgX/YgajPjDRBQsyonoW4ykWYYaMXEN/gNQV3y0pe
         FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602446; x=1695207246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av0vrlLKsg9xBQaLOcb8CPCy93VQFu46a3TbtxpfU4U=;
        b=bUjMjqZHFrRNWI7FouGKUW7ZBBDYeX7cVgtXgdDJcDz3/KH8ikWxiNuBrNunmNR018
         WmkG+GfdWRWqWSglr6e5XNXD/ytGLBuzeWFDzC93kXQb30+M8xUwyQKETCgmdbliVlyX
         p/oDjtcNdBJWLA28liaqWyEryB0Q/aPtA4HL9CZy5m2pu1aEBFag5AI/da64Pu8ZFUMi
         z3WeWNJmHsNWuJ0FIeg83/Y97Z8OW3xW/E6YbJb8aqgPamUBsv7vRQkMPaeCDAfpLnjo
         ieKporHgBGSkKTkYqp6RYpiXgafxnHh057NWQJERa4F2SWwVWI5uCB0csotv6MJUZYCZ
         PHqQ==
X-Gm-Message-State: AOJu0Ywic08p1kjGAsL6vieFVDK5vh95s8iuQbzbDitcYME455NSr8Mt
        jIR9LOShvvFb0X5CD1SGlU0ptw==
X-Google-Smtp-Source: AGHT+IHgwCAQBLvB0z1DFSfacZLlZe7iyFgzrmCJNMai57WocOmkFwr5tPYGi6nJ7z357utYkGkfeA==
X-Received: by 2002:a05:651c:8f:b0:2bf:9576:afd4 with SMTP id 15-20020a05651c008f00b002bf9576afd4mr1875974ljq.16.1694602446317;
        Wed, 13 Sep 2023 03:54:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:59d5:28b9:7f13:cd1b])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b003ff013a4fd9sm1757055wms.7.2023.09.13.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:54:05 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v5 1/4] mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Wed, 13 Sep 2023 11:53:58 +0100
Message-Id: <20230913105401.519709-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913105401.519709-1-usama.arif@bytedance.com>
References: <20230913105401.519709-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tail page prep and initialization is skipped, then the "start"
page will not contain the correct nid. Use the nid from first
vmemap page.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index aeb7dd889eee..3cdb38d87a95 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -319,7 +319,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
 	};
-	int nid = page_to_nid((struct page *)start);
+	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
 			__GFP_NOWARN;
 
-- 
2.25.1

