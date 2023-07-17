Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D34756B56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGQSKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGQSKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE6E55;
        Mon, 17 Jul 2023 11:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56B4611D5;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419A6C433CB;
        Mon, 17 Jul 2023 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617408;
        bh=9DECvy9XfdgRY+x9LckD1Cegiv8FGc1KYWwYrCtIolA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ20wt8hXUnilQK44b7T3ETV6YhnGxFIP2ItWK0ReN+Zb2YZlIDPq60bkKEStAXae
         SehDce8e8mztDJ3zyMNhgIKie5LnJtmimW0pig1upIknxQq6JejG0ModyG3B/I7RMZ
         +Om3p/UisF3Y0+hg4LVyoelXGyghl171Kyss58KU1iIWY1nI6aCDY6jeyhAe6kbXoV
         /+KGKXgxJ84EP8pcGZ0V5rGafu9ubEEC7WfXMbiz/zQeH/CNshuGzRPA/BV6zcEx12
         xBZgTXwj4TzdH1FcTtzHbYvjLLXqveMUXz3CjyaJNwDTUUCL+ZvrEFzMrWTz/ZbpCt
         ZRrrQtWnUxhXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D45E7CE0806; Mon, 17 Jul 2023 11:10:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] refscale: Add a "jiffies" test
Date:   Mon, 17 Jul 2023 11:10:06 -0700
Message-Id: <20230717181006.1097957-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
References: <2c4aea8b-6f82-45ab-988e-a6bb19129808@paulmck-laptop>
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

This commit adds a "jiffies" test to refscale, allowing use of jiffies
to be compared to ktime_get_real_fast_ns().  On my x86 laptop, jiffies
is more than 20x faster.  (Though for many uses, the tens-of-nanoseconds
overhead of ktime_get_real_fast_ns() will be just fine.)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 71d138573856..91a0fd0d4d9a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -528,6 +528,38 @@ static struct ref_scale_ops clock_ops = {
 	.name		= "clock"
 };
 
+static void ref_jiffies_section(const int nloops)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--)
+		x += jiffies;
+	preempt_enable();
+	stopopts = x;
+}
+
+static void ref_jiffies_delay_section(const int nloops, const int udl, const int ndl)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x += jiffies;
+		un_delay(udl, ndl);
+	}
+	preempt_enable();
+	stopopts = x;
+}
+
+static struct ref_scale_ops jiffies_ops = {
+	.readsection	= ref_jiffies_section,
+	.delaysection	= ref_jiffies_delay_section,
+	.name		= "jiffies"
+};
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Methods leveraging SLAB_TYPESAFE_BY_RCU.
@@ -1047,7 +1079,7 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
-- 
2.40.1

