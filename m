Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF861756B33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQSD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGQSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4A1BE;
        Mon, 17 Jul 2023 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44FF7611C6;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653EC433CA;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=w65onYuj7ePMCkLvjZLbWr2mrrWxblP9v1QgU7VLyv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+3yOAwjLMvwjPlg9dCrC2H0t0nf8sR/shzrFrp+rKAiRP7ALllkz6jIR1V76IbVm
         07qhF6IJSI3QXZnULiX9lH0lhN4N0yqIHNoJH+G+DH3FlfeJZOKNdmKdE3lpuSNB0o
         yjkaPXFPEUPSVz4lqOXjvoLzPKQXLLdMfbddElVJ0d3/7mMCpRiQhzUA4FLJfzzEZZ
         CDkkg27uaPSs6Hz8lq8mVC5z4EFxGrPrDEYn4SeafPT/7CFABT08KbjhI8lPqQwKld
         MK2hhI/EzgwfSBJYM9EYVSq1uWc+lom+YwZR20YicE62ZBOZRhkperItRpQdWU79IA
         KpQpqsZ6/D63g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CF50CE0806; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        atthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH rcu 3/6] srcu,notifier: Remove #ifdefs in favor of SRCU Tiny srcu_usage
Date:   Mon, 17 Jul 2023 11:03:14 -0700
Message-Id: <20230717180317.1097590-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes two #ifdef directives from include/linux/notifier.h
by causing SRCU Tiny to provide a dummy srcu_usage structure and a dummy
__SRCU_USAGE_INIT() macro.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: atthias Brugger <matthias.bgg@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sachin Sant <sachinp@linux.ibm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/notifier.h | 11 -----------
 include/linux/srcutiny.h |  7 +++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 86544707236a..45702bdcbceb 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -73,9 +73,7 @@ struct raw_notifier_head {
 
 struct srcu_notifier_head {
 	struct mutex mutex;
-#ifdef CONFIG_TREE_SRCU
 	struct srcu_usage srcuu;
-#endif
 	struct srcu_struct srcu;
 	struct notifier_block __rcu *head;
 };
@@ -106,7 +104,6 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 #define RAW_NOTIFIER_INIT(name)	{				\
 		.head = NULL }
 
-#ifdef CONFIG_TREE_SRCU
 #define SRCU_NOTIFIER_INIT(name, pcpu)				\
 	{							\
 		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
@@ -114,14 +111,6 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 		.srcuu = __SRCU_USAGE_INIT(name.srcuu),		\
 		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
 	}
-#else
-#define SRCU_NOTIFIER_INIT(name, pcpu)				\
-	{							\
-		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
-		.head = NULL,					\
-		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
-	}
-#endif
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
 	struct atomic_notifier_head name =			\
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index ebd72491af99..06ce65518974 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -48,6 +48,13 @@ void srcu_drive_gp(struct work_struct *wp);
 #define DEFINE_STATIC_SRCU(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
 
+// Dummy structure for srcu_notifier_head.
+struct srcu_usage {
+	char srcuu_dummy;
+};
+
+#define __SRCU_USAGE_INIT(name) { .srcuu_dummy = 0, }
+
 void synchronize_srcu(struct srcu_struct *ssp);
 
 /*
-- 
2.40.1

