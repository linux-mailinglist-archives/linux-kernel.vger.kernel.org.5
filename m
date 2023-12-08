Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685A809CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjLHHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjLHG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:46 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A619AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:49 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb34e3da36so2903851fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018789; x=1702623589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOzqFhLXzpjBzeA1uOgLdaHhh/B0dFElnG9pBb+RYR0=;
        b=vUhs2O2o2E6QeqhGwJxNu3ad/YGeGNy9WDmMmHBHqbg6u2kJyASefy0whKhR8JUel4
         dwA+o/lVnlRYl7gVH1OJqyyDvxNt6npmuflNKsP1TjZYmNMirTkfggXqRlMzHDezlmGG
         8zQRPCVgp9yOxqiL81cApoQtOF4gg1v9KJ5htuMFbAFCkCFtmASdyUwcMK8TEq8yRqLN
         zFO6F5ngyHSr17VZE6f3F1ed7QJYZxkl1B8ccnglJpd3NhbBHKPzJKRi32bvx1o41TQi
         LIIZCZb+vch3Q1YJvzIwOleMLFYg0qf/4m8Lz2qT8o3q4lB8xGbnVBjv77nKuwC6bF9W
         nDlA==
X-Gm-Message-State: AOJu0Yx2zl9DhjuPSqnxqX3b82E3ANYp1TZAF4opDPczBnjsxkVCWq88
        1IXWlkC1c0rBAvH14WoaTLrhESxm6yw2TI98X7w1zI6DmnpvsTA=
X-Google-Smtp-Source: AGHT+IF3Fzdrz8O1s1yvtwDt3O+GQEZ2KZT1LAaH3GyqW8/eUqDYvugCxj1PB6tOZ/5jkZrPCOnXdAjLveE8Rl07WnnTm9mFO1CB
MIME-Version: 1.0
X-Received: by 2002:a05:6870:ac08:b0:1fb:3bfc:a07e with SMTP id
 kw8-20020a056870ac0800b001fb3bfca07emr4618017oab.6.1702018789180; Thu, 07 Dec
 2023 22:59:49 -0800 (PST)
Date:   Thu, 07 Dec 2023 22:59:49 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000548be3060bfa2154@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [arm-msm?] [net?] memory leak in radix_tree_insert
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33cc938e65a9

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..5c2f9d8f2c3e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -714,8 +714,10 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
 		return error;
 
 	error = insert_entries(node, slot, item);
-	if (error < 0)
+	if (error < 0) {
+		__radix_tree_delete(root, node, slot);
 		return error;
+	}
 
 	if (node) {
 		unsigned offset = get_slot_offset(node, slot);
@@ -581,6 +579,24 @@ static bool delete_node(struct radix_tree_root *root,
 	return deleted;
 }
 
+static bool __radix_tree_delete(struct radix_tree_root *root,
+				struct radix_tree_node *node, void __rcu **slot)
+{
+	void *old = rcu_dereference_raw(*slot);
+	int values = xa_is_value(old) ? -1 : 0;
+	unsigned offset = get_slot_offset(node, slot);
+	int tag;
+
+	if (is_idr(root))
+		node_tag_set(root, node, IDR_FREE, offset);
+	else
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
+			node_tag_clear(root, node, tag, offset);
+
+	replace_slot(slot, NULL, node, -1, values);
+	return node && delete_node(root, node);
+}
+
 /**
  *	__radix_tree_create	-	create a slot in a radix tree
  *	@root:		radix tree root
@@ -1365,24 +1381,6 @@ radix_tree_gang_lookup_tag_slot(const struct radix_tree_root *root,
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup_tag_slot);
 
-static bool __radix_tree_delete(struct radix_tree_root *root,
-				struct radix_tree_node *node, void __rcu **slot)
-{
-	void *old = rcu_dereference_raw(*slot);
-	int values = xa_is_value(old) ? -1 : 0;
-	unsigned offset = get_slot_offset(node, slot);
-	int tag;
-
-	if (is_idr(root))
-		node_tag_set(root, node, IDR_FREE, offset);
-	else
-		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
-			node_tag_clear(root, node, tag, offset);
-
-	replace_slot(slot, NULL, node, -1, values);
-	return node && delete_node(root, node);
-}
-
 /**
  * radix_tree_iter_delete - delete the entry at this iterator position
  * @root: radix tree root
