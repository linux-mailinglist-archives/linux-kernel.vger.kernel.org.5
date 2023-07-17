Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7A756B34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGQSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGQSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D90E60;
        Mon, 17 Jul 2023 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A458611CF;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EEBC433CD;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=faENVi6cC50zYs1JsPUdeoJna1PA0xy0tmxx8qvTGUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwsgXiGGyLxGtlNnGaH4qkO5xQ+pXbWqFQn67T/rhn/Kk9ilaql1M1NQwI5VTfXtz
         favsZTYWhw/fpKAmN13CT5s+9eRGKUzzI4WrJDUtw7HjFEGdD7kJa4BiIue7QiMA6i
         lWZXDSmmOIXMHOrJg9slg6rosvhwhRiQWiKKSu62ipxsDMyegCMPKp7OHMeovFcbQT
         +F2h1r8TaOcpEfRwQqmWq/bp4x9Z+IGUt9si8blRDYzOwi+vYU9f5pUx5Q1S8+XQI8
         FOukS7Y9EIb569hDIMCtl38Tm63De0QF2Kfk059vU3q0YYfdaWiwuSg6Ep3ODSoZx8
         Q8UStCGfAqAlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41D52CE0902; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcu: Make the rcu_nocb_poll boot parameter usable via boot config
Date:   Mon, 17 Jul 2023 11:03:16 -0700
Message-Id: <20230717180317.1097590-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The rcu_nocb_poll kernel boot parameter is defined via early_param(),
whose parsing functions are invoked from parse_early_param() which
is in turn invoked by setup_arch(), which is very early indeed.  It
is invoked so early that the console output timestamps read 0.000000,
in other words, before time begins.

This use of early_param() means that the rcu_nocb_poll kernel boot
parameter cannot usefully be embedded into the kernel image.  Yes, you
can embed it, but setup_boot_config() is invoked from start_kernel()
too late for it to be parsed.

But it makes no sense to parse this parameter so early.  After all,
it cannot do anything until the rcuog kthreads are created, which is
long after rcu_init() time, let alone setup_boot_config() time.

This commit therefore switches the rcu_nocb_poll kernel boot parameter
from early_param() to __setup(), which allows boot-config parsing of
this parameter, in turn allowing it to be embedded into the kernel image.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 43229d2b0c44..5598212d1f27 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -77,9 +77,9 @@ __setup("rcu_nocbs", rcu_nocb_setup);
 static int __init parse_rcu_nocb_poll(char *arg)
 {
 	rcu_nocb_poll = true;
-	return 0;
+	return 1;
 }
-early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
+__setup("rcu_nocb_poll", parse_rcu_nocb_poll);
 
 /*
  * Don't bother bypassing ->cblist if the call_rcu() rate is low.
-- 
2.40.1

