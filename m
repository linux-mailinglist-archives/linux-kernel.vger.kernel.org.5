Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698587F177D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjKTPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjKTPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:39:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021B9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:39:56 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:39:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700494794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jKa+73bOkmstRrVLNFByvwYpmmA0HUVCWi0eT+FJSg=;
        b=lV0BQrEoFA00H4hA5ap5xjOuF2taI/iHHSngCA+qrOqx7DcRqlMR1YG5Nfdgxu/qahSQAr
        YiE4hRTD+iBYvLF5PTXZrziSQErL7WO1Gl854T6BhiFt4WqJNxaRBRjxBg42l4gAveQf9a
        JqCM/RnJFJmnC5XX51GAUJO+PVcGBSfhNgmVM9uOma03dSBirHM0Hz0raLudS/hVpPjnJU
        S4VKkF/+n3hRBPOSYcQLmdaKwLxUkSaMZ+vncGELRljDm3Pa/uEAb0JwseZonGpHH9GWOG
        t/QJwVhruibfT2qdGkek4DLOMogdZlCdhcR/uZ9j0FDOy3CUmXWUG14O6ZKkyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700494794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jKa+73bOkmstRrVLNFByvwYpmmA0HUVCWi0eT+FJSg=;
        b=BHOt5HeOK4aLojRPZbdWRrX6O2NlXUna85NobobWNb4fgLHsDDVLelJhPNLvjCowcRlxYw
        3e3d8m/dYXjR4eAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] hrtimer: Make the argument passed to lockdep_hrtimer_exit()
 look used.
Message-ID: <20231120153953.kGBSHe5j@linutronix.de>
References: <202311191229.55QXHVc6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311191229.55QXHVc6-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep_hrtimer_enter() macro returns a value which is then saved in
a local variable. The value is then fed to lockdep_hrtimer_exit(). In
case lockdep is disabled then the value remains unused leading to a "set
but not used" warning by the compiler.

Make the content passed to lockdep_hrtimer_exit() look used so the
compiler does not complain about it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311191229.55QXHVc6-lkp@intel.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 2b665c32f5fe6..2e09c269bf9d8 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -126,7 +126,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
-- 
2.42.0

