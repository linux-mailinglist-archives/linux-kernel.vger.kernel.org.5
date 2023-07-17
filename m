Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFC756B27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGQSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGQSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA1115;
        Mon, 17 Jul 2023 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E74FF611CE;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5101BC433CB;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=Y/tGOWx5q4ZXPiE4it7zg9nYO16lZ6O1v/m4xTWMYUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzwrAmSWJKoFU94kWriauk8IWoBE5TS+HnmT9tykbdY2EHGd4AYQEqu00ysi5aHFl
         ilwh6BJ0kVhp/tgiuy2qklG84FTHT42EG8indXY6dc4SKsjBRPffbKs+e18ia5PrIc
         bePSuyefnHyvvqMSMBgyI+vtAnTf4Hfak9p9q+lZYRdv1Dqbaks4EYmmS9t6BHrgvV
         qfTTWgxs72OwqK6jS+0JYUGn07iRbzAB5m7jaYI+kuQ2rlCASpLmpoDIqfxv0Yq3VD
         7UJ+V8ClN6aEQNK70VOvWXDg3rG6EiAAJs70Sczxu4PECyeX7lnsMpUDhnCPWKOmxr
         B7aU9iDg+nIRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D8FA2CE0836; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, SeongJae Park <sj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples
Date:   Mon, 17 Jul 2023 11:01:07 -0700
Message-Id: <20230717180110.1097362-4-paulmck@kernel.org>
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

Lookup example code snippets in rculist_nulls.rst are using 'obj'
without assignment.  Fix the code to assign it properly.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 25b739885cfa..4d6f077552ed 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -56,7 +56,7 @@ but a version with an additional memory barrier (smp_rmb())
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
          pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-         ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+         ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
          pos = rcu_dereference(next))
       if (obj->key == key)
         return obj;
@@ -68,7 +68,7 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
   struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
        pos && ({ prefetch(pos->next); 1; }) &&
-       ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+       ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
        pos = rcu_dereference(pos->next))
     if (obj->key == key)
       return obj;
-- 
2.40.1

