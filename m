Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B117CAE50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJPPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjJPPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:55:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B1B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:55:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9a1762b43so37725625ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697471732; x=1698076532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLBVM4RWGGrzmJKsFRzk8wkU3z95jkXd7ukKT1dlnz0=;
        b=gJXtmdMB2ya5nyxgnLRDeKTYayA6LcD4ZArzRyA3jIVy2egcakLOx2nlAPHN3MPHRB
         7tSyZU32VUi8e+wh+FPQPRmCQYEmj+dU1Bq5XIAvZUjU9EhOEqDcLIMr+JMAdVEfqu0j
         +lakdBNkX8mDsNC63o+/5yBlPt4NYtH8j5mVxC+RLTx1rrjnp/kPV17bIXWGQRQmMx/P
         V/juxBKnhyb68FAfY8N5zA3snT7Wqncn1AONeJGJUZHXcCbB+F0UEPYknSo/iGDiEA9P
         X8FLe12WCpz/0km4onhdIVrZzAn9YlVZcT0qsp7xfJUP5fw6u7Tj9fa1ATJGJNcuaS2d
         vAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471732; x=1698076532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLBVM4RWGGrzmJKsFRzk8wkU3z95jkXd7ukKT1dlnz0=;
        b=hdO39ZGVAc7D9Sgsr+ZfllqlOkTOptRM4WrtLOx/gwl++I21qWaxHzSm6aX1VjHbuJ
         6BYrh3q8CkoG3a85AsqhUkq2UZN43Fsksx6YfwWoyD6Jy7BuYUfhQ2z4IKDXPlmZGRAu
         37O4FE7X0vVgZhPSjxsrjDGllGs/zTSDsyqgYJ0pSzyKNGMDRcU2lH7EvbcAb1IgqxEE
         P+vtsAtGDs7gBYUzanTAVZdO4RtvGB2DE1MjIO+WgHMJU0Qywru0U2yRvrJeb1Etd2L2
         XS2ejGEsgT95dwJmYeUc8h07OygNOjwqZjRz0ubmHjOUjlvD4L2U/We5r2HYdc0U2kEU
         Dt1w==
X-Gm-Message-State: AOJu0Yx4W7nJi7Bb/ePjiQSbXn7iyf+APnR+97UIZSaH5DY4TapQItJ5
        3baFETXvpN8NlKXyRcj9H6mhtQl6VXeUMdkN
X-Google-Smtp-Source: AGHT+IG3/ps/pwG6hfneGQTTv6uees6/0qluU+reezGbrPeo29f58hY6vUoQqPNbwbZKYUj85rqrAg==
X-Received: by 2002:a17:902:c94e:b0:1c7:245a:7fea with SMTP id i14-20020a170902c94e00b001c7245a7feamr46280761pla.58.1697471732270;
        Mon, 16 Oct 2023 08:55:32 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (218-164-142-9.dynamic-ip.hinet.net. [218.164.142.9])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001b890009634sm8634304plb.139.2023.10.16.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:55:31 -0700 (PDT)
From:   s921975628@gmail.com
To:     s921975628@gmail.com, walken@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] rbtree: Examine rb_add* helpers in rbtree_test
Date:   Mon, 16 Oct 2023 23:55:19 +0800
Message-Id: <20231016155519.41374-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RinHizakura <s921975628@gmail.com>

We had introduced rb_add() and rb_add_cached() helper for the
partial-order based rbtree, which may be the most commonly way
to use rbtree. We also have rb_add_augmented_cached() for EEVDF now.
Since these helpers are actually the same as what rbtree_test examines
for, we can reuse these helpers to test them under rbtree_test directly.

This also introduces some correctness test and benchmarking for these
generic interface, which means the correctness and performance can be
minimally guarantee under the tests. User can choose to use these
great rb_add* helpers without extra effort to implement their own
one considering the test results.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 include/linux/rbtree_augmented.h | 21 ++++++++
 lib/rbtree_test.c                | 82 +++++---------------------------
 2 files changed, 32 insertions(+), 71 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 6dbc5a1bf..e4d2d74ba 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -86,6 +86,27 @@ rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
 	return leftmost ? node : NULL;
 }
 
+static __always_inline void
+rb_add_augmented(struct rb_node *node, struct rb_root *tree,
+			bool (*less)(struct rb_node *, const struct rb_node *),
+			const struct rb_augment_callbacks *augment)
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	augment->propagate(parent, NULL);
+	rb_insert_augmented(node, tree, augment);
+}
+
 /*
  * Template for declaring augmented rbtree callbacks (generic case)
  *
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c757..5768512f3 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -29,41 +29,19 @@ static struct test_node *nodes = NULL;
 
 static struct rnd_state rnd;
 
-static void insert(struct test_node *node, struct rb_root_cached *root)
+static inline bool less(struct rb_node *a, const struct rb_node *b)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *parent = NULL;
-	u32 key = node->key;
-
-	while (*new) {
-		parent = *new;
-		if (key < rb_entry(parent, struct test_node, rb)->key)
-			new = &parent->rb_left;
-		else
-			new = &parent->rb_right;
-	}
+	return rb_entry(a, struct test_node, rb)->key < rb_entry(b, struct test_node, rb)->key;
+}
 
-	rb_link_node(&node->rb, parent, new);
-	rb_insert_color(&node->rb, &root->rb_root);
+static void insert(struct test_node *node, struct rb_root_cached *root)
+{
+	rb_add(&node->rb, &root->rb_root, less);
 }
 
 static void insert_cached(struct test_node *node, struct rb_root_cached *root)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *parent = NULL;
-	u32 key = node->key;
-	bool leftmost = true;
-
-	while (*new) {
-		parent = *new;
-		if (key < rb_entry(parent, struct test_node, rb)->key)
-			new = &parent->rb_left;
-		else {
-			new = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&node->rb, parent, new);
-	rb_insert_color_cached(&node->rb, root, leftmost);
+	rb_add_cached(&node->rb, root, less);
 }
 
 static inline void erase(struct test_node *node, struct rb_root_cached *root)
@@ -85,53 +63,15 @@ RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
 static void insert_augmented(struct test_node *node,
 			     struct rb_root_cached *root)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *rb_parent = NULL;
-	u32 key = node->key;
-	u32 val = node->val;
-	struct test_node *parent;
-
-	while (*new) {
-		rb_parent = *new;
-		parent = rb_entry(rb_parent, struct test_node, rb);
-		if (parent->augmented < val)
-			parent->augmented = val;
-		if (key < parent->key)
-			new = &parent->rb.rb_left;
-		else
-			new = &parent->rb.rb_right;
-	}
-
-	node->augmented = val;
-	rb_link_node(&node->rb, rb_parent, new);
-	rb_insert_augmented(&node->rb, &root->rb_root, &augment_callbacks);
+	node->augmented = node->val;
+	rb_add_augmented(&node->rb, &root->rb_root, less, &augment_callbacks);
 }
 
 static void insert_augmented_cached(struct test_node *node,
 				    struct rb_root_cached *root)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *rb_parent = NULL;
-	u32 key = node->key;
-	u32 val = node->val;
-	struct test_node *parent;
-	bool leftmost = true;
-
-	while (*new) {
-		rb_parent = *new;
-		parent = rb_entry(rb_parent, struct test_node, rb);
-		if (parent->augmented < val)
-			parent->augmented = val;
-		if (key < parent->key)
-			new = &parent->rb.rb_left;
-		else {
-			new = &parent->rb.rb_right;
-			leftmost = false;
-		}
-	}
-
-	node->augmented = val;
-	rb_link_node(&node->rb, rb_parent, new);
-	rb_insert_augmented_cached(&node->rb, root,
-				   leftmost, &augment_callbacks);
+	node->augmented = node->val;
+	rb_add_augmented_cached(&node->rb, root, less, &augment_callbacks);
 }
 
 
-- 
2.34.1

