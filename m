Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514D756B28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGQSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGQSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FEE6C;
        Mon, 17 Jul 2023 11:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5737F611D5;
        Mon, 17 Jul 2023 18:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F604C433AD;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=xfeG1xbltoTNTdzL3NqsELbTv/pa9FZB5bRq1zF+OuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYV63FMskzWxOynzItXA45uVGlpO3lupAQaIN8axaEuksbv960TRV2h2o3luJZuLB
         ylpn6KwLy/bs8SfIVknVOgKv8FSWLf6x2t3tGV90Et5z3obUQEhd0PB+5r8q8Q20gT
         1U0pEZlKNIDmCcFQLNI1rc9YmIJxMlQlkau6jGm4gpBmx7EA9jmXCgspiaiH6ADrL/
         jFtZTpIFTVLrjZMIEkbzCf4+E3Dwzr8yrCe2E2B2XMwJmf3H6bobh2FTgoEvXFpQBh
         U8F2eFEoBpz52Vc2H1mZahNNCwyysN3SBwdKXiXbv1PKzPNT2lusiHhW8zsUDj8+HT
         Txi7v1wuTyKrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF4D9CE0930; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, SeongJae Park <sj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] Docs/RCU/rculist_nulls: Fix text about atomic_set_release()
Date:   Mon, 17 Jul 2023 11:01:10 -0700
Message-Id: <20230717180110.1097362-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

The document says we can avoid extra _release() in insert function when
hlist_nulls is used, but that's not true[1].  Drop it.

[1] https://lore.kernel.org/rcu/46440869-644a-4982-b790-b71b43976c66@paulmck-laptop/

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 1fb086066377..21e40fcc08de 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -140,8 +140,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================
 
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra _release() in insert function.
+With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -196,6 +195,9 @@ Note that using hlist_nulls means the type of 'obj_node' field of
 2) Insert algorithm
 -------------------
 
+Same to the above one, but uses hlist_nulls_add_head_rcu() instead of
+hlist_add_head_rcu().
+
 ::
 
   /*
-- 
2.40.1

