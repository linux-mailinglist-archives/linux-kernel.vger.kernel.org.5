Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49DC7BF954
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjJJLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjJJLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:11:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D1B7;
        Tue, 10 Oct 2023 04:11:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99775C433C7;
        Tue, 10 Oct 2023 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936266;
        bh=9iKuAypH43DUxvnbXpZPc2dgGWiCm/Nxs3g2+wjMZ54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jc/XD19T3XpJw9d8eiZM41pJR/YtEhU1RbsWd4HNiYZYM+u/8fYfrkbsEsLzSzoS9
         sjOK1rUe5Z0OmZU3wOaJ0BnVGB1pKbToYRugsfscehJBj7hK0V4gv/9uwMgniFdI7d
         Lje1+mdLML+vyxYpML2y6NtlQkF7EQ11bm2Oonf5Ol5J5wMivmFAOEornBXa3eJoan
         +Spf8jFvb1ulB5AD1XESR8YyejjSwzRd8v52UjENzEDyv4+Ga/4FjkTq1Yvn1HalX4
         j0TNV0yZgnC6qgbSH+1fpj34ALoZlydg/2V4UuoKj2wQY7WEiVJcjqcC9nU+tfI27v
         Rrhys+jmkvc3Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/3] rcu: Describe listRCU read-side guarantees
Date:   Tue, 10 Oct 2023 13:10:52 +0200
Message-Id: <20231010111053.986507-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010111053.986507-1-frederic@kernel.org>
References: <20231010111053.986507-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

More explicitly state what is, and what is not guaranteed to those
who iterate a list while protected by RCU.

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/RCU/listRCU.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index bdc4bcc5289f..ed5c9d8c9afe 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -8,6 +8,15 @@ One of the most common uses of RCU is protecting read-mostly linked lists
 that all of the required memory ordering is provided by the list macros.
 This document describes several list-based RCU use cases.
 
+When iterating a list while holding the rcu_read_lock(), writers may
+modify the list.  The reader is guaranteed to see all of the elements
+which were added to the list before they acquired the rcu_read_lock()
+and are still on the list when they drop the rcu_read_unlock().
+Elements which are added to, or removed from the list may or may not
+be seen.  If the writer calls list_replace_rcu(), the reader may see
+either the old element or the new element; they will not see both,
+nor will they see neither.
+
 
 Example 1: Read-mostly list: Deferred Destruction
 -------------------------------------------------
-- 
2.34.1

