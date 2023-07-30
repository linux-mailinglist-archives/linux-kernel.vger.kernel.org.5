Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA5768629
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjG3PQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjG3PQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F69138
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so42071685e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730174; x=1691334974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFM4pR1QacGlm/8xlIUmCJcy4VSy/s+0OM0YFxjuA8k=;
        b=TkyhfbVGe1Y7YHfHksu1wqG6hgQhYRmidCb5+Y61F1QRRs/h47YJFt0AIJh54Q0FKL
         gByq+10/h43JlVcCEVZjC6aUzw/Omy08uMjBB7CgI/FZQXN3z5WuJzdScj4/HnraGiyu
         il7QDEWZYGSpogyg92dYwrJa+Eqeb9M65dGnmL7nnCP2F14JH377zSxW/hWjC6XaZnyk
         O4M74hvreh6XC7+2F9vY3dYi8dCjt4haamygyIK9l6ZMqTa22DtdrGIfwCNlLo2xUbbo
         yHp+23v36B0XyqElADWdUdmxDLaLZYjFnCSrKJy9muMAQ+U2qOTBbbF4yWjE1y0Ngwfe
         EPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730174; x=1691334974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFM4pR1QacGlm/8xlIUmCJcy4VSy/s+0OM0YFxjuA8k=;
        b=YW4EEIX4ylfJSBse2jsh5Dwd577GK00szMeZY1xSl5zbyNMxecH2sf27ZHgbnuUd3S
         g9sG+OpoEzfCScytXOPQLSbq0s8n8uASoiwpocWAmFuQKfsu7A2Jy3yofy33877XeIYC
         DS8shqJVhPQKDToft7zzOyEBie0jcJZDkAPHNQW8IE3G5AaD2F0UEhHjmizplXAvtuc0
         tOdT7Nd7tmHPQ21BNpTjz89chSNz+w6Qr5ImFLy8KpY7vkvXAMHLAYmh39+DQhJMCz+x
         6/s5n0RDRj0Z3EFyG2lS1FtHfalzEx5Jpo6AjOaML+MDV/AXYWQxVsacSvGvdpIA6TEY
         bxsw==
X-Gm-Message-State: ABy/qLb3o9Dyp3eeJGMUfS/gYDusB9ow2MAgbPmr4WlLVedRFa2D8h/3
        myGTE08cEfpcYTXgnYWakTpu2w==
X-Google-Smtp-Source: APBJJlGH28j3h1b9uEfHTlqYomCBicErb0vATQvL1NGT50ZdEoNVQZEd6E1WZNtnMG3Mxzbn8725YA==
X-Received: by 2002:a05:600c:d5:b0:3fb:e206:ca5f with SMTP id u21-20020a05600c00d500b003fbe206ca5fmr5709508wmm.31.1690730173889;
        Sun, 30 Jul 2023 08:16:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:13 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 5/6] mm: move allocation of gigantic hstates to the start of mm_core_init
Date:   Sun, 30 Jul 2023 16:16:05 +0100
Message-Id: <20230730151606.2871391-6-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether the initialization of tail struct pages of a hugepage
happens or not will become dependent on the commandline
parameter hugetlb_free_vmemmap in the future. Hence,
hugetlb_hstate_alloc_pages needs to be after command line parameters
are parsed and the start of mm_core_init is a good point.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c  | 18 ++++++++++--------
 mm/internal.h |  9 +++++++++
 mm/mm_init.c  |  6 ++++++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 541c07b6d60f..bf60545496d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4400,14 +4400,6 @@ static int __init hugepages_setup(char *s)
 		}
 	}
 
-	/*
-	 * Global state is always initialized later in hugetlb_init.
-	 * But we need to allocate gigantic hstates here early to still
-	 * use the bootmem allocator.
-	 */
-	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
-		hugetlb_hstate_alloc_pages(parsed_hstate);
-
 	last_mhp = mhp;
 
 	return 1;
@@ -4419,6 +4411,16 @@ static int __init hugepages_setup(char *s)
 }
 __setup("hugepages=", hugepages_setup);
 
+void __init hugetlb_hstate_alloc_gigantic_pages(void)
+{
+	int i;
+
+	for (i = 0; i < HUGE_MAX_HSTATE; i++) {
+		if (hstate_is_gigantic(&hstates[i]))
+			hugetlb_hstate_alloc_pages(&hstates[i]);
+	}
+}
+
 /*
  * hugepagesz command line processing
  * A specific huge page size can only be specified once with hugepagesz.
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..692bb1136a39 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,4 +1102,13 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+#ifdef CONFIG_HUGETLBFS
+void __init hugetlb_hstate_alloc_gigantic_pages(void);
+#else
+static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
+{
+}
+#endif /* CONFIG_HUGETLBFS */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..f2751ccd7d99 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/hugetlb.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -2768,6 +2769,11 @@ static void __init mem_init_print_info(void)
  */
 void __init mm_core_init(void)
 {
+	/*
+	 * We need to allocate gigantic hstates here early to still use the bootmem
+	 * allocator. Non gigantic hstates are initialized later in hugetlb_init.
+	 */
+	hugetlb_hstate_alloc_gigantic_pages();
 	/* Initializations relying on SMP setup */
 	build_all_zonelists(NULL);
 	page_alloc_init_cpuhp();
-- 
2.25.1

