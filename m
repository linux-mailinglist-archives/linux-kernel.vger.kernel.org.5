Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB899756B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGQSBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjGQSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38EB10C7;
        Mon, 17 Jul 2023 11:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56611611D4;
        Mon, 17 Jul 2023 18:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81611C433A9;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=vMU/XgK+8/tyV/dKBByzpBIuwOGp8w97JCzbfLX+ZeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9PPHQZiElIu01MSdWkSAMWPCHtk3+ULIDkRUtTy+2KSA4s50662trJuB+lhQlESi
         6yImgsJSej19sc8OrrtpAlUsnkBaPz1Lu4p33NvTC3l5VhC3z0Ki2wN0lVlEueJ8BT
         y1HHhmXwV2PEB65Xzt/2EcMVOJKgD3DPo2PVMp8FBTt9IC0lVpubSaZoFJFkd0w1Td
         EEnAfNjZhqYu/iR1d/b/1+L4yXRRjULLr7IApvLNZzGwG8Hlo9iARtupoykSmcOSEM
         5rhY5kUujZybVuRJa3BAr3coH8hkC0f25wkqyjJ2J21Z5oUK5y5erARLAtsm3XiimC
         3duUJiqkDYsZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD2EECE092F; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, SeongJae Park <sj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/7] Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
Date:   Mon, 17 Jul 2023 11:01:09 -0700
Message-Id: <20230717180110.1097362-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

The example code snippets on rculist_nulls.rst are assuming 'obj' to
have the 'hlist_head' or 'hlist_nulls_head' field named 'obj_node', but
a sentence and some code snippets are wrongly calling
'obj->obj_node.next' as 'obj->obj_next', or 'obj->obj_node' as 'member'.
Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 479cedfec446..1fb086066377 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -65,7 +65,7 @@ but a version with an additional memory barrier (smp_rmb())
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
          pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-         ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
+         ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
          pos = rcu_dereference(next))
       if (obj->key == key)
         return obj;
@@ -77,7 +77,7 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
   struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
        pos && ({ prefetch(pos->next); 1; }) &&
-       ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
+       ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
        pos = rcu_dereference(pos->next))
     if (obj->key == key)
       return obj;
@@ -97,7 +97,7 @@ Quoting Corey Minyard::
 2) Insertion algorithm
 ----------------------
 
-We need to make sure a reader cannot read the new 'obj->obj_next' value
+We need to make sure a reader cannot read the new 'obj->obj_node.next' value
 and previous value of 'obj->key'. Otherwise, an item could be deleted
 from a chain, and inserted into another chain. If new chain was empty
 before the move, 'next' pointer is NULL, and lockless reader can not
@@ -165,7 +165,7 @@ Note that using hlist_nulls means the type of 'obj_node' field of
   head = &table[slot];
   begin:
   rcu_read_lock();
-  hlist_nulls_for_each_entry_rcu(obj, node, head, member) {
+  hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
     if (obj->key == key) {
       if (!try_get_ref(obj)) { // might fail for free objects
 	rcu_read_unlock();
-- 
2.40.1

