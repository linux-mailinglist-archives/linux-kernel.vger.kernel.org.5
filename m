Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B7756B62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGQSLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGQSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F4E56;
        Mon, 17 Jul 2023 11:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD52611E3;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2272AC433CC;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=iPtCMMiG5ZGO7GsFZLh6YccNSibZpzaW5K9xmTwhpgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcXWYrGpMinTfmdViiWkd9mQysD+Go9tXJgs3XfLV5bLrSHz6SPrJMmHApgqRQGmG
         6w9y72m2Nakf5y8KoQvVnncQJiRngN+zxTi9Olyzgf5nR7Sab57qmSL9G+JDQlQm/g
         zJVtaqxU0gnSTO1Q/QAbmjMZ9nIXrUUKHpIYCyT9lPPU5cKob9xOKvOkBeCgoxui9W
         Ks7epyA4TCqo1hcYcZgTDyygwQJg6horlLjLpY5RQqUcIRoOTcOC2hqdz9nWD2zcxp
         cmIBl/yX6f1SMagxkPEvLIFl4fOUa4TL9aSiDCwOs49aF9FdS4Lw0z5BmJRCgysFYX
         3txmTNdZJ3LMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7244CE0902; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 05/13] rcuscale: Print out full set of kfree_rcu parameters
Date:   Mon, 17 Jul 2023 11:11:30 -0700
Message-Id: <20230717181138.1098063-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 18f1b0e13604..821a3e65c54a 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -708,6 +708,10 @@ kfree_scale_init(void)
 	unsigned long jif_start;
 	unsigned long orig_jif;
 
+	pr_alert("%s" SCALE_FLAG
+		 "--- kfree_rcu_test: kfree_mult=%d kfree_by_call_rcu=%d kfree_nthreads=%d kfree_alloc_num=%d kfree_loops=%d kfree_rcu_test_double=%d kfree_rcu_test_single=%d\n",
+		 scale_type, kfree_mult, kfree_by_call_rcu, kfree_nthreads, kfree_alloc_num, kfree_loops, kfree_rcu_test_double, kfree_rcu_test_single);
+
 	// Also, do a quick self-test to ensure laziness is as much as
 	// expected.
 	if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
-- 
2.40.1

