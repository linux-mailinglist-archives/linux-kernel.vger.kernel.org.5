Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9480B8E9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjLJEaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLJEad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:30:33 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446CED
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:30:40 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ef4f8d294eso5273296fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 20:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702182639; x=1702787439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYMOmD5xOFfdzZeXC2xyMaSFSXRbMIDGMJPZtUV1K9k=;
        b=kPSn88Wm2gl4IiCjHPV8qAuzFHfQ8bUDbEsMbQ0LTQK/NBSPn7on79PBxBakO+ZDZj
         tf0xovW35nl2MvYWtNVAwlAtMDl4jN9PEMTePqWpc/ilfxYQfWMAGwbhT/hji188/H2g
         U/6J/x+t8KZsO6HvIqA/tCkY0xSgGg8E031lLSngc+/mnV0Y7Jn05ifcP39sMCS+25CJ
         CVGfwJQJ8BMBiqO4FBgLkqGr6UCTFCy6Fav75Yw5jvJ3ytiocmk4soPH0/OHtAW9lwyQ
         G3plSedS6szy9MJTwgcvgem1GHo/JS2Ud5Bwovod5Qy4sKg9/2NTRmuKtJQB3fDh/lRW
         runQ==
X-Gm-Message-State: AOJu0YyF8zK8ZnsvDV4PwYxjWXstT/VbY9k6DoEg2NnscwfwyAlo+BGE
        4rvaMXWpOGyv6KW2IExQhm6e2lfhF4cnSh3Ut7C0nLHCl6CNnkY=
X-Google-Smtp-Source: AGHT+IGubz7arDnFmVy2MyUhSpyMzZmu2pTPGJlmDT9gqvuG6y6Kybq/eVRgTsi9Vfrl0lpZ9o7WyjnX0lVkTGnomtCTiaxXOAd6
MIME-Version: 1.0
X-Received: by 2002:a05:6870:4590:b0:1fa:1c35:e4c5 with SMTP id
 y16-20020a056870459000b001fa1c35e4c5mr2674557oao.1.1702182639540; Sat, 09 Dec
 2023 20:30:39 -0800 (PST)
Date:   Sat, 09 Dec 2023 20:30:39 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092a0e5060c2047b0@google.com>
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
Author: eadavis@qq.com

please test memory leak in radix_tree_insert

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33cc938e65a9

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..41a210e1d8b3 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -274,7 +274,8 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 		flow = kzalloc(sizeof(*flow), GFP_KERNEL);
 		if (flow) {
 			init_waitqueue_head(&flow->resume_tx);
-			if (radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+			if (ret = radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+				printk("r: %d\n", ret);
 				kfree(flow);
 				flow = NULL;
 			}
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b98e9f2c24ac..522277bff6e3 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -413,6 +413,7 @@ static int radix_tree_extend(struct radix_tree_root *root, gfp_t gfp,
 	void *entry;
 	unsigned int maxshift;
 	int tag;
+	int i = 0;
 
 	/* Figure out what the shift should be.  */
 	maxshift = shift;
@@ -428,6 +429,8 @@ static int radix_tree_extend(struct radix_tree_root *root, gfp_t gfp,
 							root, shift, 0, 1, 0);
 		if (!node)
 			return -ENOMEM;
+		i++;
+		printk("i: %d, n: %p, idx: %d, s: %d, %s\n", i, node, index, shift,  __func__);
 
 		if (is_idr(root)) {
 			all_tag_set(node, IDR_FREE);
@@ -611,6 +614,7 @@ static int __radix_tree_create(struct radix_tree_root *root,
 	shift = radix_tree_load_root(root, &child, &maxindex);
 
 	/* Make sure the tree is high enough.  */
+	printk("im: %d, s: %d, m: %d, %s\n", index, shift, maxindex, __func__);
 	if (max > maxindex) {
 		int error = radix_tree_extend(root, gfp, max, shift);
 		if (error < 0)
@@ -625,6 +629,7 @@ static int __radix_tree_create(struct radix_tree_root *root,
 			/* Have to add a child node.  */
 			child = radix_tree_node_alloc(gfp, node, root, shift,
 							offset, 0, 0);
+			printk("c: %p, %s\n", child, __func__);
 			if (!child)
 				return -ENOMEM;
 			rcu_assign_pointer(*slot, node_to_entry(child));

