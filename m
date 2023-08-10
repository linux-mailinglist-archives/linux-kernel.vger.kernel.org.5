Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A6777114
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjHJHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHJHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5CF3;
        Thu, 10 Aug 2023 00:10:59 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4ibZomJJGs831EnKckgDLHRDE5xgjYSDrjS2GgTZOc=;
        b=ChK2bCCyrflE1GGL07pj+xPHQwKAdeoMQ0NCY87FuucsZ5ckuU6BaO4fiuVCPq/beL9KB7
        PdgfWpKbcInD+Fikqd5tGXT754E9bAz88lFMt1c0oWXPaH/NA4mB3Rn4YJJAM5cDXDzRPm
        a4xajPmGkgXDKTDyzv+pxe1MRDAlJGosN45B4eh61o0eKPr/HC/IjtVeEAuvDlnGFSnLx8
        gFoD5FH/zkCWoEzeh4HvpSTbUt39BR08dSYduzLRCtaSCbPI2XDvZylanKcDoIyfR0Dlsg
        D2OrzS/00aIQ0s1wu8qcgE3D+e6sM9zuk6HScBP08RGJMJfzbbtyqe3aEcBRqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4ibZomJJGs831EnKckgDLHRDE5xgjYSDrjS2GgTZOc=;
        b=nNATIig822xMthvlsQoWHtly4LNjI7jrDb5ueX9P7Vru4vXxfcoY0XVipph4Hi0r2cYP3A
        D0dlwNJ9hIRpWbAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree: Add rb_add_augmented_cached() helper
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124603.862983648@infradead.org>
References: <20230531124603.862983648@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145631.27769.14339276495833528763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     99d4d26551b56f4e523dd04e4970b94aa796a64e
Gitweb:        https://git.kernel.org/tip/99d4d26551b56f4e523dd04e4970b94aa796a64e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

rbtree: Add rb_add_augmented_cached() helper

While slightly sub-optimal, updating the augmented data while going
down the tree during lookup would be faster -- alas the augment
interface does not currently allow for that, provide a generic helper
to add a node to an augmented cached tree.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124603.862983648@infradead.org
---
 include/linux/rbtree_augmented.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 7ee7ed5..6dbc5a1 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -60,6 +60,32 @@ rb_insert_augmented_cached(struct rb_node *node,
 	rb_insert_augmented(node, &root->rb_root, augment);
 }
 
+static __always_inline struct rb_node *
+rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
+			bool (*less)(struct rb_node *, const struct rb_node *),
+			const struct rb_augment_callbacks *augment)
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	augment->propagate(parent, NULL); /* suboptimal */
+	rb_insert_augmented_cached(node, tree, leftmost, augment);
+
+	return leftmost ? node : NULL;
+}
+
 /*
  * Template for declaring augmented rbtree callbacks (generic case)
  *
