Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAA762FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGZIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjGZIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:23:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D87729A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-267fc19280bso471286a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359035; x=1690963835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYZiuBqx6ckWFl98anzbTzEwZ+z/345ZUTz3W5AilLA=;
        b=UY37TDKu0twvwszgVhYceWMnSiyklSFwgsOVGywjtmrkLJSXFOYwHm0cFLDDibc+Sl
         +1VrunZVuLNYwXFEBJceFr/7cl/UxJ701yJbZmlFmHYaho6pTuZIdVh8kohzGqcox2X/
         G/9/XrffPAYdh6AMJtIBZLDgcWQHQgF+7I+/jXOXF4gZsOmJ2EzpCo899MIPIqRyjIiP
         tBX/VyS7r4sbEogmJzWTzn/+sREeVGT8Bo+KzycwKdiq633va22OBvw2p+4WStXY6yXA
         Dq0qJbqciYrp/oNwDyzcp9LvnNAVegjxOI8T0ucLR/8q2ebzgfcWV3JK4fIhAIhQI8u4
         kIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359035; x=1690963835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYZiuBqx6ckWFl98anzbTzEwZ+z/345ZUTz3W5AilLA=;
        b=FHXA37mzyhXAKsMZqjPSXfkY5MeIzs/lgtgyH5NFzqdYj8/j7KH8HTim7tO1HAydZG
         7XxncsKSHVVmer5wf6oh6fFixAO0Px1BPLwZgpwmvtcGM7xooahENJglKm36V9uj9ogD
         YIAlLNXsUKQGLS7z5K4tfVRMTZeul+5A6HPBSI0dLrDwu/6+jrOV0stkGCtk7A79ZO8Q
         JcDq9ipWLYE+vMYBO+kIbCxjH+gz+4q/KYSLmIJM3HIjXFDzBghV6z08wkF1pwesBqW5
         uPlMlAs7HFHytFnX7UXCIRsv5xT7CYC3drr71se0O7dGmq81jc3zX5YhRnTIeMXGhtxh
         tgdQ==
X-Gm-Message-State: ABy/qLapj4zxuOPLoawN+ZI+0+l4dJrESL5NvLz+uUTG5hJ68bAKEFQN
        Ckck6za3Oo5FOBYjPSCFxDkRiA==
X-Google-Smtp-Source: APBJJlF8Oq29jicXQ7LZzSR8Tvg8Z3f0r8jXoW+wL7thrKSoHpxajUTRtxGMChVZFla02C1R6Weu5w==
X-Received: by 2002:a17:90a:1b6c:b0:268:535f:7c15 with SMTP id q99-20020a17090a1b6c00b00268535f7c15mr1294451pjq.0.1690359035369;
        Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 08/11] maple_tree: Skip other tests when BENCH is enabled
Date:   Wed, 26 Jul 2023 16:09:13 +0800
Message-Id: <20230726080916.17454-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip other tests when BENCH is enabled so that performance can be
measured in user space.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c            | 8 ++++----
 tools/testing/radix-tree/maple.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0674aebd4423..0ec0c6a7c0b5 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3514,10 +3514,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3575,6 +3571,10 @@ static int __init maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_root_expand(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
 	mtree_destroy(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 3052e899e5df..57e6b0bc5984 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36140,7 +36140,9 @@ void farmer_tests(void)
 
 void maple_tree_tests(void)
 {
+#if !defined(BENCH_FORK)
 	farmer_tests();
+#endif
 	maple_tree_seed();
 	maple_tree_harvest();
 }
-- 
2.20.1

