Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1A7E90F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjKLNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjKLNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E259E0;
        Sun, 12 Nov 2023 05:29:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE7C433C9;
        Sun, 12 Nov 2023 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795796;
        bh=JZZrqTDdJSuxU5MLpAn5uf5riXSkGMInIf8m1NqXxDk=;
        h=From:To:Cc:Subject:Date:From;
        b=REa0CdnXCd2gfthn0+5I3wmT1sNBEtNqMOBoJ11RIg1hzHvXvCa0TG+xx8T5kSFqu
         HJgJ98xLq8duHNyIYGbL+p6bbUFVEE2RgIOoSqMGjw2PJAFZluJA7ZqUJrXJUaen9J
         Bq9rCIn+PBjyNEjse0sO/VT0MCvJRXhXPqyY3H7XXYY7kKbBDLlHALIlXg5WxsSmFf
         Zv3oc96cdEIyFNZDNCsJhWdfC1Bwd+9lmE/EXZ9gDGvI1vX40IIWz6kZCns6lA/Zy6
         lNUD5Enw7PIPaTGqE3Hpu3Bf0jsxEqi4r+80XiUGgaNDvG/JIk6rPJI5pOYYMa+7eE
         mQjge9oWLwUFA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 1/2] kgdb: Flush console before entering kgdb on panic
Date:   Sun, 12 Nov 2023 08:29:51 -0500
Message-ID: <20231112132953.177067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit dd712d3d45807db9fcae28a522deee85c1f2fde6 ]

When entering kdb/kgdb on a kernel panic, it was be observed that the
console isn't flushed before the `kdb` prompt came up. Specifically,
when using the buddy lockup detector on arm64 and running:
  echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

I could see:
  [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
  [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
  [   32.552865] Sending NMI from CPU 5 to CPUs 6:
  [   32.557359] NMI backtrace for cpu 6
  ... [backtrace for cpu 6] ...
  [   32.558353] NMI backtrace for cpu 5
  ... [backtrace for cpu 5] ...
  [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
  [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP

  Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
  [5]kdb>

As you can see, backtraces for the other CPUs start printing and get
interleaved with the kdb PANIC print.

Let's replicate the commands to flush the console in the kdb panic
entry point to avoid this.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/debug_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 621037a0aa870..ce1bb2301c061 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
 	if (panic_timeout)
 		return;
 
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	if (dbg_kdb_mode)
 		kdb_printf("PANIC: %s\n", msg);
 
-- 
2.42.0

