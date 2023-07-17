Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78956756B31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGQSDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGQSDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8BB3;
        Mon, 17 Jul 2023 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B95C61063;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E373C433C8;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=Ll8sW1RjttvaLOWSpYGmiHDsZNfDqJfD+od6jxaPQrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0RMFCjkONoOuMxS9wbNLk3KMgyDCBwGCX+WPfnD+5EYKbt6/ucnLgi5R8siUgpll
         W/6Y3RIP1LGm04ZLXoCHRtcLXM4ICJ9Nwr8100cyoH8CAnlUZzsTyx929Gj1WGg42r
         4IJUwSiBKfnw+X8IebGMKsl0zMKY8h4to7O1yWmVbwJevFbhel1AuM2yVi9BXWQoQ3
         pB3/YRFMK0wjQj3VEL0v2o9LuvpQ9SBrielyTypx3CpivMgW97EJeI5DNm1GLokb1v
         I0ond5XpzKMLCkuOYM0aghvvuqvmT0Udt/q33jKPHxmkxRXTV0riv1U2ji6c7OTC66
         A/LpxD4wRu66A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 363F1CE03F1; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] rcu: Update synchronize_rcu_mult() comment for call_rcu_hurry()
Date:   Mon, 17 Jul 2023 11:03:12 -0700
Message-Id: <20230717180317.1097590-1-paulmck@kernel.org>
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

Those who have worked with RCU for some time will naturally think in
terms of the long-standing call_rcu() API rather than the much newer
call_rcu_hurry() API.  But it is call_rcu_hurry() that you should normally
pass to synchronize_rcu_mult().  This commit therefore updates the header
comment to point this out.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_wait.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..5e0f74f2f8ca 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -42,6 +42,11 @@ do {									\
  * call_srcu() function, with this wrapper supplying the pointer to the
  * corresponding srcu_struct.
  *
+ * Note that call_rcu_hurry() should be used instead of call_rcu()
+ * because in kernels built with CONFIG_RCU_LAZY=y the delay between the
+ * invocation of call_rcu() and that of the corresponding RCU callback
+ * can be multiple seconds.
+ *
  * The first argument tells Tiny RCU's _wait_rcu_gp() not to
  * bother waiting for RCU.  The reason for this is because anywhere
  * synchronize_rcu_mult() can be called is automatically already a full
-- 
2.40.1

