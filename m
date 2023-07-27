Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF272765D90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjG0Uqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjG0Uqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:46:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FC2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso15093815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490796; x=1691095596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuTqSOqGGusC4+STWjmE7AEvtPXrFRozZqvR7YJO9tM=;
        b=MYvinfuvPzSR6QZNB+kO061wB6tpem3LnUdQ68duY2x9Lf58oM1yxzxSQNGFKohFk/
         EI1cawtc+AbWjfvWpBvppmYxUriHX3hcCjpQz4l+rQHliweF9u1TU856lSFvZen+b0ac
         /Iqd2lMerRuef36wCLT08cM3aet4zD4TwG6rd3HjnQ3e8jECc7SC98cUtcttUQ97dfkH
         2TCsQq6Rp2S9nECR41e32NdAk0O1RVp9RR8BBusJoiRVB5fSCtegpCAa22SLN6tNpX0M
         IR0L8UXTdcMg4LsESCJXNbMtMfHWQw91m2aMdBO9Amm4VRFmS4e2CIzdeIHkjpK5IJLK
         fqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490796; x=1691095596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuTqSOqGGusC4+STWjmE7AEvtPXrFRozZqvR7YJO9tM=;
        b=C3UXuym9yAG/L2o+sGCamZRSgWaxLiW2A6fEkpaULf3yf4lgJ63cmZken26jliHGAn
         54PBPRKt3Oyyt2LaaFPhuEnqzvCxkXKmsTwOY0oGmga9mspWDXZx7vmXxuO4Y55/A89o
         VdXuknTwmrEsS8SfMq1WnMQDv2YiKPsF56BapUZ4C0SVQ5kxcDGWfpBpPbb49mfkb49k
         X59gYpBlnb2m4Yji1S2ffCljCdoCRIkBau9pqpEwXfTvllsHD0C77yghxofaUgr7/DCb
         kK3GbTDJcBQp8fnJp0Qm6PKclVrgpRj1AFALVLF//Q8EYez5I6784AidfgUyes1hPk18
         L21A==
X-Gm-Message-State: ABy/qLa0uNh9y8xXTl6nhrrKdvqtAsCvDHWEKAp1aAkXE/0YuphmgpjZ
        kSz/0WZJ7UXPN0g8oJ9gOpOynA==
X-Google-Smtp-Source: APBJJlEOKaj+kNcenpgjxlaFx5BKYk7IpRTqAJr1UfKl04jzi5rThxvhDJdy8KNbbbphmnOSEh7YMw==
X-Received: by 2002:a7b:ce16:0:b0:3f9:b748:ff3f with SMTP id m22-20020a7bce16000000b003f9b748ff3fmr151792wmc.1.1690490795841;
        Thu, 27 Jul 2023 13:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:35 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 5/6] mm: move allocation of gigantic hstates to the start of mm_core_init
Date:   Thu, 27 Jul 2023 21:46:23 +0100
Message-Id: <20230727204624.1942372-6-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727204624.1942372-1-usama.arif@bytedance.com>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
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
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 18 ++++++++++--------
 mm/mm_init.c            |  4 ++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca3c8e10f24a..2b20553deef3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1271,4 +1271,5 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 	return huge_pte_offset(vma->vm_mm, addr, sz);
 }
 
+void __init hugetlb_hstate_alloc_gigantic_pages(void);
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 58cf5978bee1..c1fcf2af591a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4418,14 +4418,6 @@ static int __init hugepages_setup(char *s)
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
@@ -4437,6 +4429,16 @@ static int __init hugepages_setup(char *s)
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
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..5585c66c3c42 100644
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
@@ -2768,6 +2769,9 @@ static void __init mem_init_print_info(void)
  */
 void __init mm_core_init(void)
 {
+#ifdef CONFIG_HUGETLBFS
+	hugetlb_hstate_alloc_gigantic_pages();
+#endif
 	/* Initializations relying on SMP setup */
 	build_all_zonelists(NULL);
 	page_alloc_init_cpuhp();
-- 
2.25.1

