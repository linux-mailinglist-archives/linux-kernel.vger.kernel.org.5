Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE880C09D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjLKFPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKFPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:15:38 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A6D7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:15:45 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb1eef9152so7435529fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702271744; x=1702876544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG2XORsdR115LsbeGIZEzwq2wnIFBYmqu8Ot+ew7E7Y=;
        b=jR4+0FYe1tSGWS6la0/4/s2HFq3OcQ4HflnLUfhafZEZrLGgDMNgAGF0BW4wQYzYQv
         33bhHdnTr0J0gz6XpepLJNlovs0IVHIAEDiIR7mzCuwRsEfrOxBu6KPGh6XY3EU/VILA
         6kDY4WwQatcdQK/PMW+DcQCpqcaFVmQLMx4rOFvCXkMdtYeFKjR5kQ3XYSXRwqqY62pR
         CeM2dHeQMZA1LNKPPT52J6jnKU+cJW3+ylEuWmR7dYkbEadX12MnQkd/Ob35mmcf/eei
         uomqCH8346ZGsB1+FM10Vrg2Qp5xC43VXONh3nPBwMRzhYEmVIdg2XRLjkgWfxqgDc8H
         8n4A==
X-Gm-Message-State: AOJu0YzvIieO+Lz9KZFf6NkF1+E7BQGYXr+LKtounWSQz9K1XB+wftDO
        /TOXHqiC7IfxMn5/BJ+ZF/t6mWwXHaAQoJ34MQE7+xqfue8XLfc=
X-Google-Smtp-Source: AGHT+IHcstbMsDAvfvjMb8l0Mi7v+dMvWdqdFUXnz6238N4Njdc992DM9mcexIf/BdeKwpIiIJZ4U+AI0YWuHMcynu28wGJi5X0P
MIME-Version: 1.0
X-Received: by 2002:a05:6870:239a:b0:202:d78c:c4d7 with SMTP id
 e26-20020a056870239a00b00202d78cc4d7mr26331oap.7.1702271744587; Sun, 10 Dec
 2023 21:15:44 -0800 (PST)
Date:   Sun, 10 Dec 2023 21:15:44 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5bb71060c350667@google.com>
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
index a89df8afa510..301a8c01816a 100644
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
 
@@ -628,6 +629,7 @@ static int __radix_tree_create(struct radix_tree_root *root,
 		if (error < 0)
 			return error;
 		shift = error;
+		mmshift = error;
 		child = rcu_dereference_raw(root->xa_head);
 	}
 
@@ -637,8 +639,11 @@ static int __radix_tree_create(struct radix_tree_root *root,
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
@@ -656,6 +661,18 @@ static int __radix_tree_create(struct radix_tree_root *root,
 	if (slotp)
 		*slotp = slot;
 	return 0;
+freec:
+	if (mmshift > 0) {
+		struct radix_tree_node *pn;
+		while (shift < mmshift && node) {
+			printk("dc: %p\n", node);
+			pn = node->parent;
+			radix_tree_node_rcu_free(&node->rcu_head);
+			shift += RADIX_TREE_MAP_SHIFT;
+			node = pn;
+		}
+	}
+	return ret;
 }
 
 /*
