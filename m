Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7597F5D62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbjKWLFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344979AbjKWLFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4DD59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE8AC433C9;
        Thu, 23 Nov 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737541;
        bh=tQoPadTOpEfcWFltgm4ylsWb6Qh7U5RzNAmqeA9wbms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4qyrx9uuOYtARoBjjr3USSBbEXBVLT5+2YQt8UDuwSWOOjf/oxUtL6+Qaqgn1lHY
         U1iMAw+0oevXiM45qg8DWQRguuekx5nG/LH4T/UrhEC9jYaJLhnCSes0KEHDGJepMW
         EZa2UdrCcQC7mzu1KF1jgmLnI5rAwETjdiH0Pqww7458j+MaIjCDMCNfxUjRlNQ/f2
         8QTqlMhE7BjvuWSLJEVDbQdNeHo+BAi/qGOnoD8MmIyKDc7pbImozDFyxKcmWK29M/
         8PW4kzF/3W9218KayKV8Z84KdQ6I+BiL/C/tm2vM4TkwgwH7TMj15madZX6mZcV3O9
         R96xC7kcdciaA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 3/6] sched: fair: move unused stub functions to header
Date:   Thu, 23 Nov 2023 12:05:03 +0100
Message-Id: <20231123110506.707903-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These four functions have a normal definition for CONFIG_FAIR_GROUP_SCHED,
and empty one that is only referenced when FAIR_GROUP_SCHED is disabled
but CGROUP_SCHED is still enabled. If both are turned off, the functions
are still defined but the misisng prototype causes a W=1 warning:

kernel/sched/fair.c:12544:6: error: no previous prototype for 'free_fair_sched_group'
kernel/sched/fair.c:12546:5: error: no previous prototype for 'alloc_fair_sched_group'
kernel/sched/fair.c:12553:6: error: no previous prototype for 'online_fair_sched_group'
kernel/sched/fair.c:12555:6: error: no previous prototype for 'unregister_fair_sched_group'

Move the alternatives into the header as static inline functions with
the correct combination of #ifdef checks to avoid the warning without
adding even more complexity.

[A different patch with the same description got applied by accident
 and was later reverted, but the original patch is still missing]

Fixes: 7aa55f2a5902 ("sched/fair: Move unused stub functions to header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f555857698..cb68d71c81bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13040,19 +13040,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
-#else /* CONFIG_FAIR_GROUP_SCHED */
-
-void free_fair_sched_group(struct task_group *tg) { }
-
-int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
-{
-	return 1;
-}
-
-void online_fair_sched_group(struct task_group *tg) { }
-
-void unregister_fair_sched_group(struct task_group *tg) { }
-
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a70d51ffa33..eb7e07a1abcc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -461,10 +461,21 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 
 extern int tg_nop(struct task_group *tg, void *data);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
+#else
+static inline void free_fair_sched_group(struct task_group *tg) { }
+static inline int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
+{
+       return 1;
+}
+static inline void online_fair_sched_group(struct task_group *tg) { }
+static inline void unregister_fair_sched_group(struct task_group *tg) { }
+#endif
+
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
 			struct sched_entity *parent);
-- 
2.39.2

