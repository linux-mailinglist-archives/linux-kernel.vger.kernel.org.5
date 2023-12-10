Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0F80B935
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjLJGG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjLJGGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:06:54 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA9118
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:07:00 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d87bcf8a15so5253232a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 22:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702188419; x=1702793219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qq9gnGlxSJBqTFRAS45alYednfidOCOYN7H/qxUtm8=;
        b=Ks6kKldFDtLz/9TcE0xxFaztBtVONcwyPLlR8PCkEmX9Y04SUMYw0oMI8c6Aj4Mi0X
         QDhR8MImARRLNh43YTx6bWOZys2wU2RLZMFPFmNCLaQ0HFOr8CfBMuzHvrNET0NqRS/1
         uBifa+h1JnZcLnrSv/yE3lPR7H3GtrYHQFmn/74QNo22oUnACJo7znT289UzYjQNhC1v
         Ld+b2wfXTgi+QdPrrMUzLXz2WlMo1ywq3zQqcSgI/HDJCBg5dDrg0MoS7DNySbKaKiYQ
         8GWkbC6t16pqDKh/QvhtgEMrcg9/xvurE0D2BJyKDIGH8ntLO0nsJnme1WVkEayWx10K
         BkFw==
X-Gm-Message-State: AOJu0YzzdZudkfxKuw/7Mq0ux2dWP4fz4CiggB3/5QGMpqO8zgUr77IV
        QylOd4rl1UchwFeA+0gdRca1ewpBfH2LQJfiF4eUbtDqva5n8xk=
X-Google-Smtp-Source: AGHT+IEu2PJl30xsJFtx3c0KxlBGwFiibo5j7iHCaIAY0N/ds4VwfM3zWz/KMEjQueUieug5JaLe8bWYbSrdT5cDSRqyBe5Ec7c5
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3498:b0:6d9:f50f:1795 with SMTP id
 c24-20020a056830349800b006d9f50f1795mr2361464otu.4.1702188419357; Sat, 09 Dec
 2023 22:06:59 -0800 (PST)
Date:   Sat, 09 Dec 2023 22:06:59 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013a049060c21a08b@google.com>
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
@@ -344,6 +344,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	struct qrtr_hdr_v1 *hdr;
 	size_t len = skb->len;
 	int rc, confirm_rx;
+	unsigned long maxidx;
+
+	if (to->sq_node == QRTR_NODE_BCAST) {
+		maxidx = radix_tree_maxindex(&node->qrtr_tx_flow);
+		to->sq_node = maxidx + 1;
+	}
 
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {

