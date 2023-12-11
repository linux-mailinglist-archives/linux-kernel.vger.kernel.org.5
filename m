Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E280C06E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjLKEYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:24:42 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3050E5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:24:47 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb1eef9152so7375316fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702268687; x=1702873487;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjvSEW93B0Z+a+7NTpKonDf3aftegOCmS4ucjHOUqI4=;
        b=j8h2BdZygmH54RcwWMx4YlY3Yahp9c2XrZgMp7wwB1FYK4Dlox6FNQ9Fts/gtf68gQ
         0s/tCjNUZuD84sg3QW8YFsTKNYukvNR/G7e/MXLLlHnHehs9a9sMOMKoRJPNydQgaZ91
         ZsC1aE3oOjeGg+I033LY8ngucZUk6FVFWTpGUikQO5C3+pZSD9vp0WHssqP3R0XNfG2n
         2sn7BXD0hFGuJItwtm5ymUjVitI03dMdcdyWT0Vb9gWkT6pAHXox8K/umWIDjST/sYvm
         ZvXKwbS8BzJfoXkAo5zG6npy+xhx0RfK2h93aBUt7Uvl1xItzL/Y7VyRUpQ+j2IyIwP7
         kAQw==
X-Gm-Message-State: AOJu0YwKC9HnmP3YQQc9Ma1v9CnlD+oDJ7EOeCEGrEbAudBvveLeXzh0
        rVCV7FNfAWpcf0p64hrwV6vmJc1KHkFTEmBOAsPj/cLkqXiNd8s=
X-Google-Smtp-Source: AGHT+IHLKuO1MFUxXd6RPcAePK1Xh4MK/4N50Fm3IErsDHA8HKB0NKcG1WTIlaaKiF9mG0QoD3IAF1E4cLoT8ed/huJbfyVZf1io
MIME-Version: 1.0
X-Received: by 2002:a05:6871:783:b0:1fb:166c:e070 with SMTP id
 o3-20020a056871078300b001fb166ce070mr4375220oap.1.1702268687088; Sun, 10 Dec
 2023 20:24:47 -0800 (PST)
Date:   Sun, 10 Dec 2023 20:24:47 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000680812060c3450ed@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index a89df8afa510..0a2dfecdcd30 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -613,12 +613,13 @@ static int __radix_tree_create(struct radix_tree_root *root,
 		unsigned long index, struct radix_tree_node **nodep,
 		void __rcu ***slotp)
 {
-	struct radix_tree_node *node = NULL, *child;
+	struct radix_tree_node *node = NULL, *child, *orig;
 	void __rcu **slot = (void __rcu **)&root->xa_head;
 	unsigned long maxindex;
-	unsigned int shift, offset = 0;
+	unsigned int shift, offset = 0, mmshift = 0;
 	unsigned long max = index;
 	gfp_t gfp = root_gfp_mask(root);
+	int ret;
 
 	shift = radix_tree_load_root(root, &child, &maxindex);
 
@@ -628,7 +629,9 @@ static int __radix_tree_create(struct radix_tree_root *root,
 		if (error < 0)
 			return error;
 		shift = error;
+		mmshift = error;
 		child = rcu_dereference_raw(root->xa_head);
+		orig = child;
 	}
 
 	while (shift > 0) {
@@ -637,8 +640,11 @@ static int __radix_tree_create(struct radix_tree_root *root,
 			/* Have to add a child node.  */
 			child = radix_tree_node_alloc(gfp, node, root, shift,
 							offset, 0, 0);
-			if (!child)
-				return -ENOMEM;
+			printk("nc: %p\n", child);
+			if (!child) {
+				 ret = -ENOMEM;
+				 goto freec;
+			}
 			rcu_assign_pointer(*slot, node_to_entry(child));
 			if (node)
 				node->count++;
@@ -656,6 +662,18 @@ static int __radix_tree_create(struct radix_tree_root *root,
 	if (slotp)
 		*slotp = slot;
 	return 0;
+freec:
+	if (mmshift > 0) {
+		struct radix_tree_node *dn;
+		while (shift < mmshift) {
+			radix_tree_descend(orig, &dn, index);
+			printk("dc: %p\n", dn);
+			orig = orig->slots[0];
+			radix_tree_node_rcu_free(&dn->rcu_head);
+			shift += RADIX_TREE_MAP_SHIFT;
+		}
+	}
+	return ret;
 }
 
 /*
