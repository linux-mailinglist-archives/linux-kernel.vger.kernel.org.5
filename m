Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877BC7ACEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjIYD7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjIYD6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:58:46 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6ECD1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a76d882052so3685966b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695614314; x=1696219114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdG6oUlthPIzD1rC2JhHIaoZzeLYPv1w9Sr7ZAA5CbQ=;
        b=LlVLwZHDoqwPOjeARJF8Qy6YzqVf5S1F9wYejmpyJOh0i4Ty+8HWLrpj19OYtBBjhR
         6/6Zi61zITjAVOGWwwnwoOHVrw5DZ0Trui88wM17rdfGUMDAe11T/La0Kcu4SGTBuSuW
         6Qszwv51Oe9dx+/kDkBCrWjC9Z0JBEpMDj5gszNZsjI1aPObTG+c2ApzJQM+Y3EbXjO4
         sV2XrQA5JQyeZVcednY9aJsTPZr0ExWQeiJVqYxERPpcjBXO1V8lLQ9lclvU+EDRrhrW
         8UtJk5NmN54NoAcFjJmlFOCwKmVm1HbKNDhvtovHXeT3O94Z03hESQgQkzqXxsqFSz3W
         wD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614314; x=1696219114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdG6oUlthPIzD1rC2JhHIaoZzeLYPv1w9Sr7ZAA5CbQ=;
        b=XCNwaYWgaPAVWwRNeIwXjTyhwC8bMdpM8XzSwx0l3MhoqTgeEVOFIsgLx/uzug/skR
         GO1J6y6oKBLqz5MBhtVShP2AZaPsdhktqjlmcYEw+lkI8m3WXuagjl4XKo0TuPAKh7Mt
         noBysmnobmjgM68XLHQK/ajvGlT+GTV3JOFOIAUlnoLq3hXnMJXVANRgKpO3b6yg1O1J
         fUz5xxr78Ep7W0P4IM5KXqNDPgiTVVdLVJcuKpgNovpPU8qePYrpULtn0MJvoHgXh9xd
         qJsrarpVyiKW6d0s7IoS71mgTiRu67I4yqJCJFHmSI9ukEYUentkz/b1Pgbu7yEbHKUC
         IShQ==
X-Gm-Message-State: AOJu0Yx7l0+iGCBtOxXwCGY9t/vy9bo2LsQM8TLcBZrxfjNivaskpbrk
        gnYrQoPCzK/6Q2YqL0fi2Eklow==
X-Google-Smtp-Source: AGHT+IHz2ndjLi4p0Gje1YthvgpBIruj0G0SKyaU/Zdnp5MehEAkCxmAplzbTbydiUzzRnW+WyU8Mg==
X-Received: by 2002:a05:6808:130e:b0:3a9:cfb5:4641 with SMTP id y14-20020a056808130e00b003a9cfb54641mr7842375oiv.48.1695614314045;
        Sun, 24 Sep 2023 20:58:34 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm7025387pfb.43.2023.09.24.20.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Sep 2023 20:58:33 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 7/9] maple_tree: Update check_forking() and bench_forking()
Date:   Mon, 25 Sep 2023 11:56:15 +0800
Message-Id: <20230925035617.84767-8-zhangpeng.00@bytedance.com>
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

Updated check_forking() and bench_forking() to use __mt_dup() to
duplicate maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 61 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0ec0c6a7c0b5..485d308a1ca7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1837,36 +1837,37 @@ static noinline void __init check_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
-	int i, nr_entries = 134;
+	int i, nr_entries = 134, ret;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
+
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
 				  xa_mk_value(i), GFP_KERNEL);
 
+
 	mt_set_non_kernel(99999);
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
-	newmas.tree = &newmt;
-	mas_reset(&newmas);
-	mas_reset(&mas);
 	mas_lock(&newmas);
-	mas.index = 0;
-	mas.last = 0;
-	if (mas_expected_entries(&newmas, nr_entries)) {
+	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+
+	ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
+	if (ret) {
 		pr_err("OOM!");
 		BUG_ON(1);
 	}
-	rcu_read_lock();
-	mas_for_each(&mas, val, ULONG_MAX) {
-		newmas.index = mas.index;
-		newmas.last = mas.last;
+
+	mas_set(&newmas, 0);
+	mas_for_each(&newmas, val, ULONG_MAX) {
 		mas_store(&newmas, val);
 	}
-	rcu_read_unlock();
-	mas_destroy(&newmas);
+
+	mas_unlock(&mas);
 	mas_unlock(&newmas);
+
+	mas_destroy(&newmas);
 	mt_validate(&newmt);
 	mt_set_non_kernel(0);
 	mtree_destroy(&newmt);
@@ -1974,12 +1975,11 @@ static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
 #if defined(BENCH_FORK)
 static noinline void __init bench_forking(struct maple_tree *mt)
 {
-
 	struct maple_tree newmt;
-	int i, nr_entries = 134, nr_fork = 80000;
+	int i, nr_entries = 134, nr_fork = 80000, ret;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
 
 	for (i = 0; i <= nr_entries; i++)
 		mtree_store_range(mt, i*10, i*10 + 5,
@@ -1988,25 +1988,24 @@ static noinline void __init bench_forking(struct maple_tree *mt)
 	for (i = 0; i < nr_fork; i++) {
 		mt_set_non_kernel(99999);
 		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
-		newmas.tree = &newmt;
-		mas_reset(&newmas);
-		mas_reset(&mas);
-		mas.index = 0;
-		mas.last = 0;
-		rcu_read_lock();
+
 		mas_lock(&newmas);
-		if (mas_expected_entries(&newmas, nr_entries)) {
-			printk("OOM!");
+		mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+		ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
+		if (ret) {
+			pr_err("OOM!");
 			BUG_ON(1);
 		}
-		mas_for_each(&mas, val, ULONG_MAX) {
-			newmas.index = mas.index;
-			newmas.last = mas.last;
+
+		mas_set(&newmas, 0);
+		mas_for_each(&newmas, val, ULONG_MAX) {
 			mas_store(&newmas, val);
 		}
-		mas_destroy(&newmas);
+
+		mas_unlock(&mas);
 		mas_unlock(&newmas);
-		rcu_read_unlock();
+
+		mas_destroy(&newmas);
 		mt_validate(&newmt);
 		mt_set_non_kernel(0);
 		mtree_destroy(&newmt);
-- 
2.20.1

