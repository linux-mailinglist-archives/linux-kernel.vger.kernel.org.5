Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15D7ACEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjIYD64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjIYD6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:58:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F891A7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7742be66bd3so135378885a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695614307; x=1696219107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4LS/TFttl0uhdXEX5m8lwn2u6CezP5DBiTdl/qFdZ8=;
        b=RbkY5du3e8f5L6fTOBHDl/rIqGkpPP2l8STPrbSNtDdnszFsq7XS55GmpE6aCoMb4m
         /PAe0Jbt3rNynoYGefUf2h19aaaZTUJwD/YIna/14Z9XrI7Nnl7sBv8jFqwEUYcHpxZJ
         7Ffg+9ZR/0bvoJ0/5Pqq1tmQVH2kpkSoO6pAMcTq7v/ih+UDoCbCXwaaTgapd2YWd7o/
         poPLVdgDxazK6cCWC5Lvwu2hgFJBw7t8K887WboLqR7GHztnXMvodHaOTTy4RgrLKfyc
         p23QohmyTgDEMuGOrl/OV5CZIEcwLBH26RguVZ378W7KUuMpiPb1XNJMhW3AGFu0DVKf
         vcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614307; x=1696219107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4LS/TFttl0uhdXEX5m8lwn2u6CezP5DBiTdl/qFdZ8=;
        b=E1LUnuRQ9ui2lq1jbRm0hLS3qWM/+Q1AmaSQ6ESEwFiofm4C7ez9dyFqiAkbgbKZnK
         E9HLwjbzxNHKW3EwX2/K4DTORAsUpOrSJS2g3ajy+lK8g/wN+j/+d1TzAl95SYrYK1qA
         gqD60S0HzZIOaQN9Gnq95Lgd8Pwrxh7bdxQOYzvz97y9l5UJl1MxN7osW20/F2ZdZJFB
         EkA77Fku04neADgZVYKu+b4EV7clMtnZykgKzGYkWVAgizWRHFSUpp/wUtCMIXL9rPoz
         YLUBnsxv9qa2tYcGJvl1yf5X9YDv4rHWC8da8QbJJqxWws42obbwEWC3pK4fUmcAtabt
         pJyQ==
X-Gm-Message-State: AOJu0Yzw4QuKGWaJnenrZFEeX2qt7wAlM1gyT+TeEZWX36YBC+QB1cWC
        ZrAj2cZqSZHYVE9ZQCARV5TqdQ==
X-Google-Smtp-Source: AGHT+IFyPjYxuSfNgvsS9Z7GkNZ6srfa0PNzA2kN76VBzGnCz9+3nPN5C/SDQMLJt6pMfLPc2iPj9w==
X-Received: by 2002:a0c:ab82:0:b0:64f:8994:792d with SMTP id j2-20020a0cab82000000b0064f8994792dmr4730466qvb.38.1695614307072;
        Sun, 24 Sep 2023 20:58:27 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm7025387pfb.43.2023.09.24.20.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Sep 2023 20:58:26 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/9] maple_tree: Skip other tests when BENCH is enabled
Date:   Mon, 25 Sep 2023 11:56:14 +0800
Message-Id: <20230925035617.84767-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
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

