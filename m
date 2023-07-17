Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FF756B32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGQSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGQSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C7E4C;
        Mon, 17 Jul 2023 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9C16119D;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E093C433C9;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=v7j+4/RDCywUwH0JVY5YSjpILugIRR8+kpY9IyawFFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RA/y3TFUBbF+jj4qXI5cAWvGTAEUWF8bE2wU5hgIC3hnyJaC1899+YYO0wMnVFP96
         dG2kZN61Uzgx8U4QpAByTA4JhEdt9K9ZEfBGar8/r6gc5n9jDFCSmwoU3dILafVC6X
         IStR1cWC30coigyp2eW1S9B62ajApXZ7zT+pvpxbCR/NOcKQ23Qvfmq3lNbrh2R+U3
         Nh3JGGIbwnkdChC5uNZU+oggLbR3SkhwX7lJdpe0pvBjHc/qO3607gZ5VGaEbsX2jR
         19bTlHkQ6XrOKvo6N+HXoRGzl1bj4QKpbO0rS4tjotG/UlU0c1lWooxQkCmnwz1Azh
         1A1+N8q6CchvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A439CE04CD; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH rcu 2/6] rcu: Clarify rcu_is_watching() kernel-doc comment
Date:   Mon, 17 Jul 2023 11:03:13 -0700
Message-Id: <20230717180317.1097590-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
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

Make it clear that this function always returns either true or false
without other planned failure modes.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..fae9b4e29c93 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -679,10 +679,14 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
- * Return true if RCU is watching the running CPU, which means that this
- * CPU can safely enter RCU read-side critical sections.  In other words,
- * if the current CPU is not in its idle loop or is in an interrupt or
- * NMI handler, return true.
+ * Return @true if RCU is watching the running CPU and @false otherwise.
+ * An @true return means that this CPU can safely enter RCU read-side
+ * critical sections.
+ *
+ * More specifically, if the current CPU is not deep within its idle
+ * loop, return @true.  Note that rcu_is_watching() will return @true if
+ * invoked from an interrupt or NMI handler, even if that interrupt or
+ * NMI interrupted the CPU while it was deep within its idle loop.
  *
  * Make notrace because it can be called by the internal functions of
  * ftrace, and making this notrace removes unnecessary recursion calls.
-- 
2.40.1

