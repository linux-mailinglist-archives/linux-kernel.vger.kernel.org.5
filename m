Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27561756B36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGQSDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGQSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B499;
        Mon, 17 Jul 2023 11:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8A9611C5;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07CAC4339A;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=vEUUOY6M/3b2MdG2PW8TiiGilUJqe947oj/T9vFTNTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwsvUF/M6y1htH9x4F8FD9RJ7dMM3iqjK0L9G/KO/bHFbfAbvKW9LQqgdffTCkrJ8
         Q3VAWs2tJvzYG01qCc+I0khfxeLsX5IXuA1qB7E7B6bmN6KzPvg0NDwchVgnJZIkRt
         l/BgTtbHEtZ8VzJoDXONq4GP1/9sdbeAh16Ap3IUrKuqUoEdH5IIJkkIX1TXbu5hZI
         ZMocGgOmJXnGa8S6m/1xMih1P4I3vb6g6tBoxrHzFJD1HGwLxm8KgklhyGYt0jh8x3
         PoBhOvFNITxVPY0ovU5TqzlWXzTrJ9FCy1Vy3qu9PymxoGgX6Z0t1iYAQmHbcobG8s
         ZyVrbtuztfxPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 441F6CE092F; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Alan Huang <mmpgouride@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls
Date:   Mon, 17 Jul 2023 11:03:17 -0700
Message-Id: <20230717180317.1097590-6-paulmck@kernel.org>
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

From: Alan Huang <mmpgouride@gmail.com>

When the objects managed by rculist_nulls are allocated with
SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
even though it is just now being added, which means the modification of
->next is visible to readers.  This patch therefore uses WRITE_ONCE()
for assignments to ->next.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ba4c00dd8005..89186c499dd4 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 {
 	struct hlist_nulls_node *first = h->first;
 
-	n->next = first;
+	WRITE_ONCE(n->next, first);
 	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
 	if (!is_a_nulls(first))
@@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 		last = i;
 
 	if (last) {
-		n->next = last->next;
+		WRITE_ONCE(n->next, last->next);
 		n->pprev = &last->next;
 		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
-- 
2.40.1

