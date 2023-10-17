Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A47CC2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjJQMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjJQMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:19:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382B010CE;
        Tue, 17 Oct 2023 05:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF5FC433CC;
        Tue, 17 Oct 2023 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545160;
        bh=KRYagrNjJg3nrUhLUUzrvcOlwM6Y8bhCaiTkgIqmUKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GR0jSiaU65B9zcMl5Gj8T4xNpbN7aNO4dWavSGJkMDC6fRmb8S1tg8JBiGtCFU26g
         FLz3f8MDGV0c3MtL8yibbz6CdqWFykTTSqwAhpADqJ91kwZC10zIRg5INYxWQxlGwL
         Z8bBltYzYdT3d2Rj2bb2tO/SKaaONdE8DwwQihGmiFt3h3B1Y9IDtSPvS4RoLeX7Ly
         lQoIhVvBqS1hwf8v2Vyv5XBBLHbcjYb+DRdRs6H+AF6/Al463OlG3yxFvrtwbrRuc2
         KDDwSBIf/DuA4LDoEjr9Vk7xZVpCws44O5eW/D6tnGiwvr7SC+vskkJuc3tDQUSRT1
         PzOc0PJ0EhzWA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] rcu-tasks: Make rcu_tasks_lazy_ms static
Date:   Tue, 17 Oct 2023 14:19:05 +0200
Message-Id: <20231017121905.1156166-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017121905.1156166-1-frederic@kernel.org>
References: <20231017121905.1156166-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The rcu_tasks_lazy_ms variable is not used outside the file tasks.h,
so this commit marks it static.

kernel/rcu/tasks.h:1085:5: warning: symbol 'rcu_tasks_lazy_ms' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6086
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 94bb5abdbb37..018f03f20629 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1086,7 +1086,7 @@ void rcu_barrier_tasks(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
-int rcu_tasks_lazy_ms = -1;
+static int rcu_tasks_lazy_ms = -1;
 module_param(rcu_tasks_lazy_ms, int, 0444);
 
 static int __init rcu_spawn_tasks_kthread(void)
-- 
2.34.1

