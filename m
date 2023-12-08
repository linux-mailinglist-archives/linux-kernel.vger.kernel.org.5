Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B34809D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573338AbjLHHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573325AbjLHHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:44:36 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195401720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:44:43 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1faef8466f9so3150795fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702021482; x=1702626282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF23So3eTGy+0U3Y49QflHjA50Q1YjNpuWzkNe4lr8Q=;
        b=WGfkEvUPzOgVQvkVOIIHAlMZXsnktUPfRUB9P420Nf8gsxo3ZzIStwnkSCjOftJKiP
         VUH23XlV4JIYorJnoaUbCmxDH8mD5X3lg38mlPxq1EziLkiyj2xOS2afTpJat+3cQHp9
         oWWDlFe0n/GHvx6LBRIWzFGnYLERXfrDG5r92LeFiRQSXXxqaMHTYn7yJ30OeHb5M7F1
         jfNr879u8D1366+W2snscsvM9TAQZD3qFKNKtwdySrZLzpaATssAHb99XFvjESp0UFbj
         nt2K4IztawVtO8+lo9m2GIRmR6xt+luWsyggLdLCd8URIe4g/CglY2kAN18YhhWscqc0
         AR0Q==
X-Gm-Message-State: AOJu0YxYxcgOUQQTK5TNCQDtv6ecfzN7g/CTPrhTul3olSpjzz1OF1F3
        Al84LLz+eYsJYdOeYz1YMJs6T14Sh8U2BJwr6fJ6ULarYdvA8b8=
X-Google-Smtp-Source: AGHT+IFCJWl0j/2rLeyGe72Cdc+j8lrhXThntf8kH58SJaMdHfB5bw/xokdlWypVRo7mA6jMIC83U2DubYJSkOouJVpIv79u4TJG
MIME-Version: 1.0
X-Received: by 2002:a05:6870:f62a:b0:1fb:f51:25bb with SMTP id
 ek42-20020a056870f62a00b001fb0f5125bbmr4441101oab.5.1702021482517; Thu, 07
 Dec 2023 23:44:42 -0800 (PST)
Date:   Thu, 07 Dec 2023 23:44:42 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd9c39060bfac1fb@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index 976b9bd02a1b..5c2f9d8f2c3e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
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
