Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22AC762FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGZIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGZIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:20 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7456E99
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-348c03de0e7so16509305ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359018; x=1690963818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLmPRatqLaPjNdFSIOQqmfdfgzRaFIKbs75zNZxQM3k=;
        b=edqfz4k42nCM4mbt3rgbm433jEQgkgjdf50ULvk8j2xYHjezVeSFt1oZ907tUkLq6H
         ow/CoVkmA5DqlFbF8xELCu7XeAPlG3bTVmgL6D3d33T+UtZlMVWJMJvrYHZ4nrda3KuW
         Pp+6+h0GCAVyTF84xW6NaL1Yy0kreE4NvfODNzLeX1FkzSpYfE4EDIGnEfkgGSLFIcf/
         JNvbkrZvHx4x5rq0B03sAvUSxcYYjCKmiCcAjvYEtA5Y4uzZBxgt5r99KZvcg2AJ4Ce2
         mlpfpAvootB9ZFpXGuoGEyHBwrOZDmHKQMbdKy+9I1mars1V4N4rHoRVXeHhHak5dgDV
         uiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359018; x=1690963818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLmPRatqLaPjNdFSIOQqmfdfgzRaFIKbs75zNZxQM3k=;
        b=aWtrxjF1kCpeTRpF9u6Rgcqbc3rRKslqBQcTAO64Xha2JuLo9TrVHs2a9Ad7WlFp2d
         qNRZ6oymkX5NjgKhIfIjvf4ykwKpPNOppEc2YfKb/4rUcxrDeYlu/cNIKPdUSCviaOAD
         XA8BSjgCw+O/Xefwmb0gcohkxV83nIZe0Ucenj0T/zsWsN9OY/Vlexe8jxT/BcOai/bu
         cEneq9jtMp8RiIP/B7iIXH+kXuL9QhpwbGrI4L8jS8HlavrIzLyCszaL/SH8ABiLWM/4
         ejZ/QcEPwMHJXpqexTLGz04eWpAI/tL7gz59SqpzV00dP2WZbhnU0OITPw70ZaPM/2MM
         B14Q==
X-Gm-Message-State: ABy/qLYHE5sYr+lENtiiOhNdjuB7c6xssiGslyKnj2Wnw54FbUAJKddc
        M7qkZoG56MxafSUCzH3iZ7sczw==
X-Google-Smtp-Source: APBJJlGa1sI8Ot6wDuAGAIzbtMGaPwlxOu08ayCD0nVOoODHEZRjd9Ytl9786BZoeyT8Q0+YuiMnMQ==
X-Received: by 2002:a05:6e02:92d:b0:348:c57f:b016 with SMTP id o13-20020a056e02092d00b00348c57fb016mr1153348ilt.3.1690359018367;
        Wed, 26 Jul 2023 01:10:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:18 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 05/11] maple_tree: Add test for mt_dup()
Date:   Wed, 26 Jul 2023 16:09:10 +0800
Message-Id: <20230726080916.17454-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for mt_dup().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 202 +++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70ba..3052e899e5df 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35857,6 +35857,204 @@ static noinline void __init check_locky(struct maple_tree *mt)
 	mt_clear_in_rcu(mt);
 }
 
+/*
+ * Compare two nodes and return 0 if they are the same, non-zero otherwise.
+ */
+static int __init compare_node(struct maple_enode *enode_a,
+			       struct maple_enode *enode_b)
+{
+	struct maple_node *node_a, *node_b;
+	struct maple_node a, b;
+	void **slots_a, **slots_b; /* Do not use the rcu tag. */
+	enum maple_type type;
+	int i;
+
+	if (((unsigned long)enode_a & MAPLE_NODE_MASK) !=
+	    ((unsigned long)enode_b & MAPLE_NODE_MASK)) {
+		pr_err("The lower 8 bits of enode are different.\n");
+		return -1;
+	}
+
+	type = mte_node_type(enode_a);
+	node_a = mte_to_node(enode_a);
+	node_b = mte_to_node(enode_b);
+	a = *node_a;
+	b = *node_b;
+
+	/* Do not compare addresses. */
+	if (ma_is_root(node_a) || ma_is_root(node_b)) {
+		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
+						  MA_ROOT_PARENT);
+		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
+						  MA_ROOT_PARENT);
+	} else {
+		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
+						  MAPLE_NODE_MASK);
+		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
+						  MAPLE_NODE_MASK);
+	}
+
+	if (a.parent != b.parent) {
+		pr_err("The lower 8 bits of parents are different. %p %p\n",
+			a.parent, b.parent);
+		return -1;
+	}
+
+	/*
+	 * If it is a leaf node, the slots do not contain the node address, and
+	 * no special processing of slots is required.
+	 */
+	if (ma_is_leaf(type))
+		goto cmp;
+
+	slots_a = ma_slots(&a, type);
+	slots_b = ma_slots(&b, type);
+
+	for (i = 0; i < mt_slots[type]; i++) {
+		if (!slots_a[i] && !slots_b[i])
+			break;
+
+		if (!slots_a[i] || !slots_b[i]) {
+			pr_err("The number of slots is different.\n");
+			return -1;
+		}
+
+		/* Do not compare addresses in slots. */
+		((unsigned long *)slots_a)[i] &= MAPLE_NODE_MASK;
+		((unsigned long *)slots_b)[i] &= MAPLE_NODE_MASK;
+	}
+
+cmp:
+	/*
+	 * Compare all contents of two nodes, including parent (except address),
+	 * slots (except address), pivots, gaps and metadata.
+	 */
+	return memcmp(&a, &b, sizeof(struct maple_node));
+}
+
+/*
+ * Compare two trees and return 0 if they are the same, non-zero otherwise.
+ */
+static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
+{
+	MA_STATE(mas_a, mt_a, 0, 0);
+	MA_STATE(mas_b, mt_b, 0, 0);
+
+	if (mt_a->ma_flags != mt_b->ma_flags) {
+		pr_err("The flags of the two trees are different.\n");
+		return -1;
+	}
+
+	mas_dfs_preorder(&mas_a);
+	mas_dfs_preorder(&mas_b);
+
+	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
+		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
+			pr_err("One is MAS_ROOT and the other is not.\n");
+			return -1;
+		}
+		return 0;
+	}
+
+	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
+
+		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
+			pr_err("One is MAS_NONE and the other is not.\n");
+			return -1;
+		}
+
+		if (mas_a.min != mas_b.min ||
+		    mas_a.max != mas_b.max) {
+			pr_err("mas->min, mas->max do not match.\n");
+			return -1;
+		}
+
+		if (compare_node(mas_a.node, mas_b.node)) {
+			pr_err("The contents of nodes %p and %p are different.\n",
+			       mas_a.node, mas_b.node);
+			mt_dump(mt_a, mt_dump_dec);
+			mt_dump(mt_b, mt_dump_dec);
+			return -1;
+		}
+
+		mas_dfs_preorder(&mas_a);
+		mas_dfs_preorder(&mas_b);
+	}
+
+	return 0;
+}
+
+static noinline void __init check_mt_dup(struct maple_tree *mt)
+{
+	DEFINE_MTREE(new);
+	int i, j, ret, count = 0;
+
+	/* stored in the root pointer*/
+	mt_init_flags(&tree, 0);
+	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
+	mt_dup(&tree, &new, GFP_KERNEL);
+	mt_validate(&new);
+	if (compare_tree(&tree, &new))
+		MT_BUG_ON(&new, 1);
+
+	mtree_destroy(&tree);
+	mtree_destroy(&new);
+
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1)
+			mt_init_flags(&tree, 0);
+		else
+			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(&tree, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+
+		ret = mt_dup(&tree, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret != 0);
+		mt_validate(&new);
+		if (compare_tree(&tree, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(&tree);
+		mtree_destroy(&new);
+	}
+
+	/* Test memory allocation failed. */
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1)
+			mt_init_flags(&tree, 0);
+		else
+			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(&tree, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+
+		mt_set_non_kernel(50);
+		ret = mt_dup(&tree, &new, GFP_NOWAIT);
+		mt_set_non_kernel(0);
+		if (ret != 0) {
+			MT_BUG_ON(&new, ret != -ENOMEM);
+			count++;
+			mtree_destroy(&tree);
+			continue;
+		}
+
+		mt_validate(&new);
+		if (compare_tree(&tree, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(&tree);
+		mtree_destroy(&new);
+	}
+
+	/* pr_info("mt_dup() fail %d times\n", count); */
+	BUG_ON(!count);
+}
+
 extern void test_kmem_cache_bulk(void);
 
 void farmer_tests(void)
@@ -35904,6 +36102,10 @@ void farmer_tests(void)
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, 0);
+	check_mt_dup(&tree);
+	mtree_destroy(&tree);
+
 	/* RCU testing */
 	mt_init_flags(&tree, 0);
 	check_erase_testset(&tree);
-- 
2.20.1

