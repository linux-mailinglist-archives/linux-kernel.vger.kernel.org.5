Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADF76625F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjG1DWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjG1DWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507426AE;
        Thu, 27 Jul 2023 20:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B3161FBE;
        Fri, 28 Jul 2023 03:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D911C433C8;
        Fri, 28 Jul 2023 03:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690514554;
        bh=OdIg2aXzGzFs49NnjepUU10sn6rio+r3n+Tr+oWKU1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWo031NX1r7c8UrgItH+YXzPJOxvuF2BY1QORHAmRAs302+OlWW1IQnuPZOceWKtB
         2+ZhNNkvzK/2O7sZ89BcsN7SCvzRQ0rzAodvSlLImrPRfGGQBTK3kQVijk+JZFLv8E
         511Yv7MtB1XTKwb213k5rCLO0lI1lXizna4Bds84F9Jm7og+a+RO7q8doV/sgdy99R
         K7iVtQO0mgb4BFXdae2dHdLVAL8b2SiIJsUvDhR0+JB/s4hUJjFa9ACxL1uNHyRP4A
         LsDFC+MUFntXos6vqsY/PzzQElcdww99cjxiA5j9sIQr8Ds88am3sdLItEol+DFtjQ
         ocGI9Aa+by+jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF279CE0AD7; Thu, 27 Jul 2023 20:22:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Stultz <jstultz@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Subject: [PATCH rcu 1/2] torture: Add a kthread-creation callback to _torture_create_kthread()
Date:   Thu, 27 Jul 2023 20:22:31 -0700
Message-Id: <20230728032232.816584-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop>
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop>
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

This commit adds a kthread-creation callback to the
_torture_create_kthread() function, which allows callers of a new
torture_create_kthread_cb() macro to specify a function to be invoked
after the kthread is created but before it is awakened for the first time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: John Stultz <jstultz@google.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
---
 include/linux/torture.h | 7 +++++--
 kernel/torture.c        | 6 +++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 7038104463e4..bb466eec01e4 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -108,12 +108,15 @@ bool torture_must_stop(void);
 bool torture_must_stop_irq(void);
 void torture_kthread_stopping(char *title);
 int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
-			     char *f, struct task_struct **tp);
+			     char *f, struct task_struct **tp, void (*cbf)(struct task_struct *tp));
 void _torture_stop_kthread(char *m, struct task_struct **tp);
 
 #define torture_create_kthread(n, arg, tp) \
 	_torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
-				"Failed to create " #n, &(tp))
+				"Failed to create " #n, &(tp), NULL)
+#define torture_create_kthread_cb(n, arg, tp, cbf) \
+	_torture_create_kthread(n, (arg), #n, "Creating " #n " task", \
+				"Failed to create " #n, &(tp), cbf)
 #define torture_stop_kthread(n, tp) \
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
diff --git a/kernel/torture.c b/kernel/torture.c
index 8be83fdc6be1..b88a1a86d9da 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -932,7 +932,7 @@ EXPORT_SYMBOL_GPL(torture_kthread_stopping);
  * it starts, you will need to open-code your own.
  */
 int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
-			    char *f, struct task_struct **tp)
+			    char *f, struct task_struct **tp, void (*cbf)(struct task_struct *tp))
 {
 	int ret = 0;
 
@@ -944,6 +944,10 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 		*tp = NULL;
 		return ret;
 	}
+
+	if (cbf)
+		cbf(*tp);
+
 	wake_up_process(*tp);  // Process is sleeping, so ordering provided.
 	torture_shuffle_task_register(*tp);
 	return ret;
-- 
2.40.1

