Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1E7D4A42
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJXIeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjJXIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:34:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCBD7E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so2314198a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136436; x=1698741236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=GqvjHc99IbEBZlveybU0D8fTBBlqe+5Ky0UCXDZB8PFwd279bHDMYd6DNStGBbmDYj
         ZrF/X5gQG3+6FzoP+wo6/xV+JHpxmEVyFE/bEp5FlnONxxEArr8+kVhdgW6brSJdenIc
         rW3fn0k6u9xzNZJQuCfokK9CMcg+LzehC2U6+Rnq6+97/iB8CKp+vYDsQDzvwpJOLMOK
         x9axsO7Bj0h7Qd5rjO9oW3CQVyvmNFRhqhcONU818lCuH7DkZswcSOL+lib8Zy33LKI3
         dMjmrg6dEawPdgMnDNO0ezM0C20fT2vrXjVCQ/ElhZpQc0LbBrg6MmtMQutR1LgExcSM
         4dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136436; x=1698741236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmT9t2gNl7JC/Wj/BeBLe/fYUtz3EaMSD0bTELVUlD4=;
        b=GFMzOYwWd+Dj+n67yd76VMaI6bt2Z62fFC+fGHXaQRDgWIcljFPt6C7NF+inZCahu7
         jWo6h45Zy2es7tF0KYTIevN4lGRV8vfqPFMuApN0tTzDlNbJ+G9CLdpFG6LXN4U/DpaM
         +46V03llrZ/isVwAUSCr8465weTj5gInSNL+Hs6kfN1xtg2KPbgSEKwI85ED5yM30pW9
         PSnn0Llvyq89NNoOxbTOOVfEbFHdQhPpBYpJ72R9AxztFMECEr2Rba7vakEZKjRuDfkj
         I5k/OwBlQaitPFcBsnhZjzveECPXAzk2o+58tn41UHjyAhQAhtiUCTJ2jtXqVOqsU9Mi
         bVUw==
X-Gm-Message-State: AOJu0YzJ98Cyp+cKlfc+JlhArbF0JIK0S3NN2/fBvsv+wHGjIWab8F+M
        3IpDT1H5V5TyYFoK5yLQIG01QA==
X-Google-Smtp-Source: AGHT+IF878eTLhy6MBaFtUQubSuP7YPQ3APPj4js3z/kylyjvhAgv4iCwOSuEsZvOnsr4GHMJn44lw==
X-Received: by 2002:a05:6a20:6a28:b0:161:28e0:9abd with SMTP id p40-20020a056a206a2800b0016128e09abdmr2218020pzk.16.1698136436387;
        Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:56 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 07/10] maple_tree: Skip other tests when BENCH is enabled
Date:   Tue, 24 Oct 2023 16:32:55 +0800
Message-Id: <20231024083258.65750-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 464eeb90d5ad..de470950714f 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3585,10 +3585,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3646,6 +3642,10 @@ static int __init maple_tree_seed(void)
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
index 12b3390e9591..cb5358674521 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36299,7 +36299,9 @@ void farmer_tests(void)
 
 void maple_tree_tests(void)
 {
+#if !defined(BENCH)
 	farmer_tests();
+#endif
 	maple_tree_seed();
 	maple_tree_harvest();
 }
-- 
2.20.1

