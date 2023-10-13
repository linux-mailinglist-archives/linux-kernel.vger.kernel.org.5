Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFE7C8E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjJMUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:43:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F27CB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:43:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWIIv+mLjlrT3V2Ul9kxF8dv9mzOp3dRSypIrr6l33g=;
        b=iQ9j/OaO0KmRmMgeb3zvonpmkyX4c5ltMPzzabjnEv9LTH/KM0QA/3FCN0HC2sEOYEczlk
        dDEeZAht2XukYEi2tuCNweaYqJ/CDzmOTDqW3c6AKtg8jsLkfYyAWmBs9GaR+8e3pFNBpr
        9k80QK/8KqpEMxcge+27crw/oBWDh2aw0+pEIY65FLYPz+v8M1Y/D66qmR46egXRRV9KGe
        NAU13R6AZcjdYaKy9ESM8N2bT1uulWXGJkYtwR2FPftHjrXHmPHsh2liL3AkL1gq9k3uK3
        8yIA0bTXL30BGh8qV8zx5QpI76nfTi0Rk/u4nkG/sez+mpfc6SqT4GI8ekxEYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWIIv+mLjlrT3V2Ul9kxF8dv9mzOp3dRSypIrr6l33g=;
        b=XY1qhTh8fG/ononxo4SHAtdSqaxOydbsd2QVPEdbzEnvTF5wBVq1jJ2ulbRVTT2/GzIoUU
        bCfKAVtH5BYIrpBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 1/4] printk: For @suppress_panic_printk check other panic
Date:   Fri, 13 Oct 2023 22:49:37 +0206
Message-Id: <20231013204340.1112036-2-john.ogness@linutronix.de>
In-Reply-To: <20231013204340.1112036-1-john.ogness@linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80eb79177bab..abb6a50ee26f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2272,8 +2272,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.39.2

