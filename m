Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26D276ECE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjHCOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjHCOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16B4217;
        Thu,  3 Aug 2023 07:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B0A61DD0;
        Thu,  3 Aug 2023 14:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E788BC433C7;
        Thu,  3 Aug 2023 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691073637;
        bh=9pxec8ZBavvpLPblzW9Mu0vwSLRXinc+qf3BTn5DC6s=;
        h=From:To:Cc:Subject:Date:From;
        b=BebWia0X00VwPvauWpfbmsnwyn0BB+Xuxw5ybhmZ7D//GhXsYxonbTMb87DnAI0Tt
         I9djm3zRyvigZwt71z08v+j8ZGRGnAgs6/VdcWki1VIQC6zgcyz+uOZ4Ua/o/FB5hP
         pasRFRD/JJPZ5gRmcDXq/wm5WuMzZczpHCWhLv19OtOx9K6Bh61j0BF7d1t9aX3ToF
         9Xb6aHpaHTG8eRXzyuk6hDDL+DL8tjzPtgZXS39/2CoNqK4qIfx07jU74xSM+EB2Pm
         g6YDCJmhSJg8gAMEk11SSULXkYazz8nsw4ea3xHj5gj6ssTZn0Et0GlI8DWpsjCUoX
         bHcqnWxJznAXg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: include torture_sched_setaffinity() declaration
Date:   Thu,  3 Aug 2023 16:40:11 +0200
Message-Id: <20230803144025.14023-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

The prototype for torture_sched_setaffinity() moved to a
different header, which needs to be included from update.c
to avoid this W=1 warning:

kernel/rcu/update.c:529:6: error: no previous prototype for 'torture_sched_setaffinity' [-Werror=missing-prototypes]
  529 | long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)

Fixes: 521ec59e5453e ("torture: Move rcutorture_sched_setaffinity() out of rcutorture")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 0533b510f0a8..c534d6806d3d 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/torture.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/percpu.h>
-- 
2.39.2

