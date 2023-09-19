Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6697A6934
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjISQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:53:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42610AD;
        Tue, 19 Sep 2023 09:52:55 -0700 (PDT)
Date:   Tue, 19 Sep 2023 16:52:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695142373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a0eDSd4cSDghjb6mnbsI8z3gtL7oCcCNLtmkgwwpC3I=;
        b=FEtetmR8hsv04eddaH9/Rr6FBvQHnqNa7YpmLTNOwxJ7vgQtImbFjozl2LN6s8qOPzGSMD
        DgHTf5ypVJ33l3hO7d/C6RZQCaDrXNHMG0r5DeygxlamAfn4iyZ61C+1hNhio/DaJPaX6r
        9Iu5++qkqsA+WOVl1DYJvMQ5VKh/BGvQmlojHopn0C4K26ucjOlxvBElLY4PBXpZkf92YT
        NGBg+GZ9WnEHNrgY4cGH89WvAp1h5FDUP4X/4o4Tx8lrLMwQ+E9EtFpQnc6Gc+TrcO+LN7
        l2UeSBSKEcLDWEpZlA10EqVDc2RCvhrLn8ssiPTczcIQUfpUqDgk8u/ylWtiHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695142373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a0eDSd4cSDghjb6mnbsI8z3gtL7oCcCNLtmkgwwpC3I=;
        b=eimVFJU/Hfo/wGXgL8gLXCY8rpgxboceWFGiS6L86BYhWWsKk9b95jyuQysbGwxu8NiYUG
        zky0dMEhuw9HGKCw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/shstk: Add warning for shadow stack double unmap
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169514237254.27769.13102793379343449331.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     509ff51ee652c41a277c2b439aea01a8f56a27b9
Gitweb:        https://git.kernel.org/tip/509ff51ee652c41a277c2b439aea01a8f56a27b9
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 08 Sep 2023 13:36:55 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Sep 2023 09:18:34 -07:00

x86/shstk: Add warning for shadow stack double unmap

There are several ways a thread's shadow stacks can get unmapped. This
can happen on exit or exec, as well as error handling in exec or clone.
The task struct already keeps track of the thread's shadow stack. Use the
size variable to keep track of if the shadow stack has already been freed.

When an attempt to double unmap the thread shadow stack is caught, warn
about it and abort the operation.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lore.kernel.org/all/20230908203655.543765-4-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ad63252..59e15dd 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -426,7 +426,18 @@ void shstk_free(struct task_struct *tsk)
 	if (!shstk->base)
 		return;
 
+	/*
+	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
+	 * normal. But size = 0 on a shstk->base is not normal and
+	 * indicated an attempt to free the thread shadow stack twice.
+	 * Warn about it.
+	 */
+	if (WARN_ON(!shstk->size))
+		return;
+
 	unmap_shadow_stack(shstk->base, shstk->size);
+
+	shstk->size = 0;
 }
 
 static int wrss_control(bool enable)
