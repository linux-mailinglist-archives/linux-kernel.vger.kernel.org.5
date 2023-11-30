Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593207FF66D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjK3QmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjK3QmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:42:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C6D50;
        Thu, 30 Nov 2023 08:42:09 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:42:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701362527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=S9xj0ZAADKx7hu7QbhqW7wDQCSHjf9qrcUMkO9n1IJI=;
        b=Z2qk16R5XhEOi87nU1gPUyUSwrCoMXB9G/DE3XTxfykFRS0/qBJr9D6cWrYRAdyYFTBVz7
        HWYgKOnRpj+yzwtDfQUoCOBAdI1nBRIHNRXLjup5YHlT17by9aFT1RBLjTwZtg5f+YOTRz
        prQ7TiWQHZREWQISbQSlgLbgNcQWUlLkcJTZEFVWRYUWlimTJaBEIbRCgq5EiYGhN5TIvb
        4Fzj6jFrYOJ/F2/pKaldFNpj3mMwN+jaAfbAePBgUAgYaC5YmgcZ3llj5z9El+GpolREvx
        HiXSrIrWTYM/qF4TINGHGZVkkhE+E3JvKbF5UWoSnwVJWW/+0cCUXtjye0I9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701362527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=S9xj0ZAADKx7hu7QbhqW7wDQCSHjf9qrcUMkO9n1IJI=;
        b=oI/W4FTas45tKWNnuWBVlFkS9IRdoBvVebb2alZO5ZeFsX2t39PI8Ivil+b8paxzpoPzM9
        f+odN237NEkbd7Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.7-rc3-rt3
Message-ID: <20231130164206.veSGRRd_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.7-rc3-rt3 patch set. 

Changes since v6.7-rc3-rt2:

  - Since the printk rework in v6.6-rt13, the thread for the printing
    console fails to go idle if there is nothing to print. This has been
    resolved.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.7-rc3-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/incr/patch-6.7-rc3-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.7-rc3-rt3

The RT patch against v6.7-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/older/patch-6.7-rc3-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/older/patches-6.7-rc3-rt3.tar.xz

Sebastian

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index a9be219673dbf..0bd5ee1b5b282 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1032,13 +1032,6 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 
 		nbcon_state_read(con, &cur);
 
-		/*
-		 * Some other CPU is using the console. Patiently poll
-		 * to see if it becomes available. This is more efficient
-		 * than having every release trigger an irq_work to wake
-		 * the kthread.
-		 */
-		msleep(1);
 	} while (cur.prio != NBCON_PRIO_NONE);
 
 	/* Bring the sequence in @ctxt up to date */
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
