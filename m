Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573F27BD631
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjJIJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345711AbjJIJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A7CDE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692c70bc440so3185034b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842256; x=1697447056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9a2wn71CT7l6jmeDgx5GiWCiAo5KcsAe/ofRJgEyKw=;
        b=kq4PypPoQ7szijQX3xuhg3Z63X6w3kvRX944vT5k2nxix/SS6sEuBgCNtJCwfP/AzY
         1oi8ShrbBYvWCbbOhD9hb7i+cyWut0icjG1IUp/Ctx2FlZv09qFczAwSfgEGT2+e0mGL
         NENtqACzsY2gsQIjXyCZbqcPaSG9Mf4Lkt3fcbpC+SUm+QGV1nGXdHgKFDYs8XnPo4o1
         SN1yTde103QlKxRqSs3j+JGBbQ0RpyAOghdCxWD3wfQWm3asmLWxL+0NoogMrC7Rilw6
         NtKUJ2Bi64u5Uez+Q71SUWJkwVGlQNofHGIT2CRw++fhT9qtC4PDJgifFGbQkawI9FH6
         FfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842256; x=1697447056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9a2wn71CT7l6jmeDgx5GiWCiAo5KcsAe/ofRJgEyKw=;
        b=TpUh02kaiS32290gk2UDf5sMfSwvn72UIA4aRo6Hl9XfzPLCz09yQXjpP/nSNLbYDn
         ceGoOrkxB98WjYbk06//KaIR31xfO9djI32VXRwKp5oHDXWxLpxlia5nvNyPn7h8qHyK
         98qGLdfv/LfG4+CDVViKoW1U8r2HahcQIZNj19FJTgYIOeiOvpC6DM693Lv+CrfxCWR7
         2ZDLc0iRsX/Znb6nGXz3eBQ12x/Wlqluno1vb6yacaxO8Tb1PvAOG6CQjR0cOajNiPGX
         2dy1dJ4RJiGZEhg4yIrvoPCFeYYnOz6AZO523LQqM6RlpDbZWB4LYmc6QpWJkDvbtYEu
         B4/Q==
X-Gm-Message-State: AOJu0YzmYBUbtHFHZF08zLxch6mPKxkCKqbkObZsvSf2j82n77ZM+P/S
        uWjHdc7RtaUTd+5roxgCfwG1TQ==
X-Google-Smtp-Source: AGHT+IGhxQLr6e0qKbMl52zcDEJo1xj/bOdWt1iR+YCZ1wJBAvqt7Qzkrv8BWaR76GhnhbO+h6xSDQ==
X-Received: by 2002:a05:6a20:1382:b0:14c:4dfc:9766 with SMTP id hn2-20020a056a20138200b0014c4dfc9766mr11293031pzc.46.1696842256084;
        Mon, 09 Oct 2023 02:04:16 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:15 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 05/10] maple_tree: Add test for mtree_dup()
Date:   Mon,  9 Oct 2023 17:03:15 +0800
Message-Id: <20231009090320.64565-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
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

Add test for mtree_dup().
Test by duplicating different maple trees and then comparing the two
trees. Includes tests for duplicating full trees and memory allocation
failures on different nodes.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 361 +++++++++++++++++++++++++++++++
 1 file changed, 361 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70ba..12b3390e9591 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35857,6 +35857,363 @@ static noinline void __init check_locky(struct maple_tree *mt)
 	mt_clear_in_rcu(mt);
 }
 
+/*
+ * Compares two nodes except for the addresses stored in the nodes.
+ * Returns zero if they are the same, otherwise returns non-zero.
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
+static __init void mas_subtree_max_range(struct ma_state *mas)
+{
+	unsigned long limit = mas->max;
+	MA_STATE(newmas, mas->tree, 0, 0);
+	void *entry;
+
+	mas_for_each(mas, entry, limit) {
+		if (mas->last - mas->index >=
+		    newmas.last - newmas.index) {
+			newmas = *mas;
+		}
+	}
+
+	*mas = newmas;
+}
+
+/*
+ * build_full_tree() - Build a full tree.
+ * @mt: The tree to build.
+ * @flags: Use @flags to build the tree.
+ * @height: The height of the tree to build.
+ *
+ * Build a tree with full leaf nodes and internal nodes. Note that the height
+ * should not exceed 3, otherwise it will take a long time to build.
+ * Return: zero if the build is successful, non-zero if it fails.
+ */
+static __init int build_full_tree(struct maple_tree *mt, unsigned int flags,
+		int height)
+{
+	MA_STATE(mas, mt, 0, 0);
+	unsigned long step;
+	int ret = 0, cnt = 1;
+	enum maple_type type;
+
+	mt_init_flags(mt, flags);
+	mtree_insert_range(mt, 0, ULONG_MAX, xa_mk_value(5), GFP_KERNEL);
+
+	mtree_lock(mt);
+
+	while (1) {
+		mas_set(&mas, 0);
+		if (mt_height(mt) < height) {
+			mas.max = ULONG_MAX;
+			goto store;
+		}
+
+		while (1) {
+			mas_dfs_preorder(&mas);
+			if (mas_is_none(&mas))
+				goto unlock;
+
+			type = mte_node_type(mas.node);
+			if (mas_data_end(&mas) + 1 < mt_slots[type]) {
+				mas_set(&mas, mas.min);
+				goto store;
+			}
+		}
+store:
+		mas_subtree_max_range(&mas);
+		step = mas.last - mas.index;
+		if (step < 1) {
+			ret = -1;
+			goto unlock;
+		}
+
+		step /= 2;
+		mas.last = mas.index + step;
+		mas_store_gfp(&mas, xa_mk_value(5),
+				GFP_KERNEL);
+		++cnt;
+	}
+unlock:
+	mtree_unlock(mt);
+
+	MT_BUG_ON(mt, mt_height(mt) != height);
+	/* pr_info("height:%u number of elements:%d\n", mt_height(mt), cnt); */
+	return ret;
+}
+
+static noinline void __init check_mtree_dup(struct maple_tree *mt)
+{
+	DEFINE_MTREE(new);
+	int i, j, ret, count = 0;
+	unsigned int rand_seed = 17, rand;
+
+	/* store a value at [0, 0] */
+	mt_init_flags(mt, 0);
+	mtree_store_range(mt, 0, 0, xa_mk_value(0), GFP_KERNEL);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret);
+	mt_validate(&new);
+	if (compare_tree(mt, &new))
+		MT_BUG_ON(&new, 1);
+
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* The two trees have different attributes. */
+	mt_init_flags(mt, 0);
+	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret != -EINVAL);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* The new tree is not empty */
+	mt_init_flags(mt, 0);
+	mt_init_flags(&new, 0);
+	mtree_store(&new, 5, xa_mk_value(5), GFP_KERNEL);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret != -EINVAL);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* Test for duplicating full trees. */
+	for (i = 1; i <= 3; i++) {
+		ret = build_full_tree(mt, 0, i);
+		MT_BUG_ON(mt, ret);
+		mt_init_flags(&new, 0);
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	for (i = 1; i <= 3; i++) {
+		ret = build_full_tree(mt, MT_FLAGS_ALLOC_RANGE, i);
+		MT_BUG_ON(mt, ret);
+		mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* Test for normal duplicating. */
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1) {
+			mt_init_flags(mt, 0);
+			mt_init_flags(&new, 0);
+		} else {
+			mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+		}
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* Test memory allocation failed. */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i = 0; i < 30; i += 3) {
+		mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+	}
+
+	/* Failed at the first node. */
+	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+	mt_set_non_kernel(0);
+	ret = mtree_dup(mt, &new, GFP_NOWAIT);
+	mt_set_non_kernel(0);
+	MT_BUG_ON(&new, ret != -ENOMEM);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* Random maple tree fails at a random node. */
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1) {
+			mt_init_flags(mt, 0);
+			mt_init_flags(&new, 0);
+		} else {
+			mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+		}
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+		/*
+		 * The rand() library function is not used, so we can generate
+		 * the same random numbers on any platform.
+		 */
+		rand_seed = rand_seed * 1103515245 + 12345;
+		rand = rand_seed / 65536 % 128;
+		mt_set_non_kernel(rand);
+
+		ret = mtree_dup(mt, &new, GFP_NOWAIT);
+		mt_set_non_kernel(0);
+		if (ret != 0) {
+			MT_BUG_ON(&new, ret != -ENOMEM);
+			count++;
+			mtree_destroy(mt);
+			continue;
+		}
+
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* pr_info("mtree_dup() fail %d times\n", count); */
+	BUG_ON(!count);
+}
+
 extern void test_kmem_cache_bulk(void);
 
 void farmer_tests(void)
@@ -35904,6 +36261,10 @@ void farmer_tests(void)
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, 0);
+	check_mtree_dup(&tree);
+	mtree_destroy(&tree);
+
 	/* RCU testing */
 	mt_init_flags(&tree, 0);
 	check_erase_testset(&tree);
-- 
2.20.1

