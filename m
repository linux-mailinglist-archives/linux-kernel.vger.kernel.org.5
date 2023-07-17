Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA35756B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGQSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGQSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6BE76;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23FC9611E6;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2B4C433AB;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=y5uffG7fOu/TEaIPCaJCZFkXOa/V0l/2zCRZKeCBBW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s93362XbjDt0y86fgUncbBlGLqFyFbcWFytxSLBYFw9hy/yHVawRoA8uzCunf1q7p
         tPQpGyi6+YDM6LyDY1yWFgFuJ+2+qnofFEf527wein1w8ID9jpTThjGgbefxNWpvoL
         fll5l+LThX6QsgLZ0ukxBFprE+TOY5A02qSICXnv/IZETgQ3fAWsM+wOdm3sQ8RJ2q
         rvYAlyl0CHvMKS+kCqAgHFYLct605CTufn5vWXjEhD0raRtxLDGsrlm4QcAFS11+mT
         giSO8h/6SgLONX2OvjbLJbGIk/WiVvqxjgGrUoyjbhy0rx+btBBvQT0WKWU+2o2rlI
         GMi2In6+R0pKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBBC9CE0930; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 07/13] rcuscale: Add kfree_by_call_rcu and kfree_mult to documentation
Date:   Mon, 17 Jul 2023 11:11:32 -0700
Message-Id: <20230717181138.1098063-7-paulmck@kernel.org>
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

This commit adds the kfree_by_call_rcu and kfree_mult rcuscale module
parameters to kernel-parameters.txt.  While in the area, it updates
to rcuscale.scale_type.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a6888e3dfc20..3329dc22f53b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4928,6 +4928,15 @@
 			test until boot completes in order to avoid
 			interference.
 
+	rcuscale.kfree_by_call_rcu= [KNL]
+			In kernels built with CONFIG_RCU_LAZY=y, test
+			call_rcu() instead of kfree_rcu().
+
+	rcuscale.kfree_mult= [KNL]
+			Instead of allocating an object of size kfree_obj,
+			allocate one of kfree_mult * sizeof(kfree_obj).
+			Defaults to 1.
+
 	rcuscale.kfree_rcu_test= [KNL]
 			Set to measure performance of kfree_rcu() flooding.
 
@@ -4973,7 +4982,7 @@
 			the same as for rcuscale.nreaders.
 			N, where N is the number of CPUs
 
-	rcuscale.perf_type= [KNL]
+	rcuscale.scale_type= [KNL]
 			Specify the RCU implementation to test.
 
 	rcuscale.shutdown= [KNL]
-- 
2.40.1

