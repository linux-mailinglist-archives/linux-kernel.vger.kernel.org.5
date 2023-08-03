Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8276DEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHCDY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjHCDYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8902D43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:24:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-786bb09e595so41271139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691033053; x=1691637853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri+AV8Kf+G5whax+bk9HTGfLE0fpaHCunlBX3LcI+MY=;
        b=SSROfGyqV9e3u74mTKmoa9swo8SFey1Lh0VpFbL1JE70n1rclCj8tC30xw4OMGN2vB
         +IlNzwUN30w4Nw4O0wOw4zYh/3Z5xy5EI6IPgTWrmkRvfYDNsjzL6uSm3a0h4mlH2GOM
         10aW6NWacR4dbgGPHJmVb5bJhYKUm3LEhZML0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033053; x=1691637853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri+AV8Kf+G5whax+bk9HTGfLE0fpaHCunlBX3LcI+MY=;
        b=aL4VZ24SpnnHqIzHtOQMUL/QXd+Clah9+OfSHe47z9clgfVmIa9XBOo1DR7oi+GbEV
         T2O+iHy02smmzeOpOmG+414hmRy6w2P0y247+zVus8o95qvB03066P9dUar0Tf+gqe0O
         dDeyEz4AfNCRby9Q84gQzddnRG6i1Yy/LEdJnlNOok/mcqOwsOZIVIwsMGHTeL8II+82
         Lem+gkIguwxtySUOWc1hsc9rxJOuu3zgCKE1gbj/jQMDJDrguGgYsgwjEDWWswpuqVtZ
         UJZCcD8ZiDQQdKXkh5a19eLVQvMzS+8cg3V5ILTYI+nV3mNL42fhql5pQqD95RozKEhH
         Y7rQ==
X-Gm-Message-State: ABy/qLZwen31P2waKRCRfZfNrOW7m5K5pD3YU8VawgFa8Xp2CSvfeMj+
        hri0lnwH8Sf7CtEbDjZD36JcWACbbziQWo9z+CQ=
X-Google-Smtp-Source: APBJJlHbI5KfWmA5QewNsyrWaZR6V3ElyXs1v2enBL4DptJM5Dt3K9W5sbejVgaJWYiVHbEr+1qIJQ==
X-Received: by 2002:a05:6602:2559:b0:785:cac9:2d49 with SMTP id cg25-20020a056602255900b00785cac92d49mr14841576iob.1.1691033053197;
        Wed, 02 Aug 2023 20:24:13 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a14-20020a02ac0e000000b0042b67b12363sm4535176jao.37.2023.08.02.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:24:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
Date:   Thu,  3 Aug 2023 03:24:06 +0000
Message-ID: <20230803032408.2514989-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a detailed note to explain the potential side effects of
plain-accessing the gp pointer using a plain load, without using the
rcu_dereference() macros; which might trip neighboring code that does
use rcu_dereference().

I haven't verified this with a compiler, but this is what I gather from
the below link using Will's experience with READ_ONCE().

Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f3b605285a87..e0b896d3fb9b 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -376,6 +376,38 @@ mechanism, most commonly locking or reference counting
 .. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
 .. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
 
+Note that, there can be strange side effects (due to compiler optimizations) if
+``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE()`` or
+``rcu_dereference()``) potentially hurting any succeeding
+``rcu_dereference()``. For example, consider the code:
+
+   ::
+
+       1 bool do_something_gp(void)
+       2 {
+       3   void *tmp;
+       4   rcu_read_lock();
+       5   tmp = gp; // Plain-load of GP.
+       6   printk("Point gp = %p\n", tmp);
+       7
+       8   p = rcu_dereference(gp);
+       9   if (p) {
+      10     do_something(p->a, p->b);
+      11     rcu_read_unlock();
+      12     return true;
+      13   }
+      14   rcu_read_unlock();
+      15   return false;
+      16 }
+
+The behavior of plain accesses involved in a data race is non-deterministic in
+the face of compiler optimizations. Since accesses to the ``gp`` pointer is
+by-design a data race, the compiler could trip this code by caching the value
+of ``gp`` into a register in line 5, and then using the value of the register
+to satisfy the load in line 10. Thus it is important to never mix
+plain accesses of a memory location with rcu_dereference() of the same memory
+location, in code involved in a data race.
+
 In short, updaters use rcu_assign_pointer() and readers use
 rcu_dereference(), and these two RCU API elements work together to
 ensure that readers have a consistent view of newly added data elements.
-- 
2.41.0.585.gd2178a4bd4-goog

