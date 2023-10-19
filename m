Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C507CF790
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjJSLzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjJSLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:55:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A295BE;
        Thu, 19 Oct 2023 04:55:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9756C433CA;
        Thu, 19 Oct 2023 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716502;
        bh=sSbMY5CCWBmj3HxnZsWM2SzuTJFQ7pmsTLrLgETzDzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kf6TULOcwoQ0k/urPmEbr8nA8gx7X3lqPGmstxbvYn5iU5ujZYgb7H9MoGR3aZynj
         pBURPPNLMy0as1zjtoRzybBs4P55OuBhVf69lgs8PEXMWC9a1mPYjkURxsWW26mGDr
         aQUuIyzaPB2qPXjhTfjgAG/2NE71zTlCrDlrHAIuFK5rzUADAfFL6wXQp36ZHYAfpw
         7F0KUMeQ2wzVscwt8DSPnRdweG0vnIMLN9AUY52N6YsliJUHVuiPImkRSa+Am/BzOF
         W82uvz9a1b0iKfh/7WCqJC/s1UAYjM1JDhAxt7JzkPbQww6QLQTRpEg9P9LEkGmNu/
         Vyskb1/quY7QA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] refscale: Fix misplaced data re-read
Date:   Thu, 19 Oct 2023 13:54:50 +0200
Message-Id: <20231019115452.1215974-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019115452.1215974-1-frederic@kernel.org>
References: <20231019115452.1215974-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit fixes a misplaced data re-read in the typesafe code.
The reason that this was not noticed is that this is a performance test
with no writers, so a mismatch could not occur.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 91a0fd0d4d9a..750a63e99539 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -655,12 +655,12 @@ static void typesafe_delay_section(const int nloops, const int udl, const int nd
 			goto retry;
 		}
 		un_delay(udl, ndl);
+		b = READ_ONCE(rtsp->a);
 		// Remember, seqlock read-side release can fail.
 		if (!rts_release(rtsp, start)) {
 			rcu_read_unlock();
 			goto retry;
 		}
-		b = READ_ONCE(rtsp->a);
 		WARN_ONCE(a != b, "Re-read of ->a changed from %u to %u.\n", a, b);
 		b = rtsp->b;
 		rcu_read_unlock();
-- 
2.34.1

