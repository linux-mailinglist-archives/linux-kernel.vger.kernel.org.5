Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA15980B97C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjLJG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjLJG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:58:15 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C5F3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:58:22 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9e4a5d9dfso4422576b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 22:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702191501; x=1702796301;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jOZ461ZHCxYfq9wyhbxNbUvsgNFqJb2JWGx4ihcInU=;
        b=kvBlPlE+3YionDse+NBOSVs7u7ChinpnbhGvbeDhaIxPUO8AtXmzp1UFHhQQ9gb2VL
         vHBfMjyhQbYFKToOxxxKZYt59wvM0YTm9n6SAQnmREqsIL/sBvvlHyZoImnOurvsw7lY
         KQa9xoYDqzMIoVlU/zht/ZUPN2nhZbqNpfAIHKWzCOvgs2tLwepxy4OPpj+wXPydLBKy
         dtU93rou7H7jlrgkYx1Pey0n3IPm18xHEHnGCZ3d6Tx6L+zyWo0Jd3hVjhklMoY5ckvS
         k4f+Pni1dTnc083W5AIPRJ9b0f8wfwkelhkvLKs1I7OCwyu341+Y4Wt7pFquCYy/rMt3
         KPFw==
X-Gm-Message-State: AOJu0Yw/w74DVZsbTgR6KwTrZG91O0/Hi91DkiMRd091rCW5dD9xE+nL
        E4Z2UjfW7WDl+PEGb/uLWNb8ZbIZOBioFmz3UVa7NdsbxIVTsAU=
X-Google-Smtp-Source: AGHT+IGzbDmr7nIKBCpYQg+3CY/Ecrgo+59ldUsYcmrsxt8WZ22BK7Gz+TWSeruCd+f+mDtAV6QYt2BxKRP1tBZ60XLl3l6MXu/o
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2021:b0:3ac:b428:844d with SMTP id
 q33-20020a056808202100b003acb428844dmr2644846oiw.8.1702191501525; Sat, 09 Dec
 2023 22:58:21 -0800 (PST)
Date:   Sat, 09 Dec 2023 22:58:21 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9c707060c2257fc@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index eae67015ce51..cc3e9fc7bae0 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -254,6 +254,7 @@ unsigned int radix_tree_gang_lookup_tag_slot(const struct radix_tree_root *,
 		void __rcu ***results, unsigned long first_index,
 		unsigned int max_items, unsigned int tag);
 int radix_tree_tagged(const struct radix_tree_root *, unsigned int tag);
+unsigned long radix_tree_maxindex(const struct radix_tree_root *root);
 
 static inline void radix_tree_preload_end(void)
 {
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b98e9f2c24ac..a89df8afa510 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -404,6 +404,18 @@ static unsigned radix_tree_load_root(const struct radix_tree_root *root,
 	return 0;
 }
 
+unsigned long radix_tree_maxindex(const struct radix_tree_root *root)
+{
+	struct radix_tree_node *node = rcu_dereference_raw(root->xa_head);
+
+	if (likely(radix_tree_is_internal_node(node))) {
+		node = entry_to_node(node);
+		return node_maxindex(node);
+	}
+
+	return 0;
+}
+
 /*
  *	Extend a radix tree so it can store key @index.
  */
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..abdae567a370 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -274,7 +274,8 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 		flow = kzalloc(sizeof(*flow), GFP_KERNEL);
 		if (flow) {
 			init_waitqueue_head(&flow->resume_tx);
-			if (radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+			if (ret = radix_tree_insert(&node->qrtr_tx_flow, key, flow)) {
+				printk("r: %d, k: %llu, f: %p, %s\n", ret, key, flow, __func__);
 				kfree(flow);
 				flow = NULL;
 			}
@@ -344,6 +344,13 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	struct qrtr_hdr_v1 *hdr;
 	size_t len = skb->len;
 	int rc, confirm_rx;
+	unsigned long maxidx;
+
+	if (to->sq_node == QRTR_NODE_BCAST) {
+		maxidx = radix_tree_maxindex(&node->qrtr_tx_flow);
+		to->sq_node = maxidx + 1;
+		printk("mi: %llu, sn: %llu, %s\n", maxidx, to->sq_node, __func__);
+	}
 
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {

