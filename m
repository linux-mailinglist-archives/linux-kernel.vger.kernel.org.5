Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A550C77017B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHDN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHDN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A55198C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 994886200C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57601C433C7;
        Fri,  4 Aug 2023 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691155689;
        bh=lqWFMUCSgl4MzmkAhbpi04RG6x0pOTOX1AFce7iyhAI=;
        h=From:To:Cc:Subject:Date:From;
        b=eN2Dh/ATWUjDV1BMbtPhyZQkr9SQmTNdS5J3mBcMnsCoe+GdhneMPMPtwsbV8bpb+
         X8fvLSSaxE9gFWIfIPPOMu5sS2ypT4iVOpHPYNP108iboLhBtweWtdGdZrAWl+fPHw
         xrk9RBOfDVZ/mIsSenER/kcpUn2wtdFXPwX2hilMxWVu60eEntzK8D4ItO65yFRvB/
         KJuinP1voQCEeAyM8PkspfkFhE5x/9CcNIVp+negp19GYEoo+YVqp/GuymoPP7oqNH
         eyB7KNTgV2Wt+Dc8cw47skfnBAHRM6jM3c6eX8aHigQgpG0yq3CKuTjz7tqjssaUp7
         WXud7QeKKc5Cg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Pingfan Liu <kernelfans@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog/hardlockup: avoid unused-function warning
Date:   Fri,  4 Aug 2023 15:27:50 +0200
Message-Id: <20230804132800.2270896-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added hardlockup_all_cpu_backtrace_proc_handler() function is defined
in some configurations that don't actually call it:

kernel/watchdog.c:112:12: error: 'hardlockup_all_cpu_backtrace_proc_handler' defined but not used [-Werror=unused-function]
  112 | static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_table *table, int write,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hide the definition when either CONFIG_SMP or CONFIG_SYSCTL are disabled and
the function is not actually needed.

Fixes: 838b3b76220d5 ("watchdog/hardlockup: avoid large stack frames in watchdog_hardlockup_check()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/watchdog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 25d5627a6580b..0dd6a7acacd97 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -108,6 +108,7 @@ notrace void arch_touch_nmi_watchdog(void)
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
+#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
 static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -130,6 +131,7 @@ static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_table *table, in
 
 	return ret;
 }
+#endif
 
 void watchdog_hardlockup_touch_cpu(unsigned int cpu)
 {
-- 
2.39.2

