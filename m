Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAB798A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbjIHPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjIHPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:45:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E413E;
        Fri,  8 Sep 2023 08:45:55 -0700 (PDT)
Date:   Fri, 8 Sep 2023 17:45:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694187953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XJnX1m9tikTjZGjqJrcNBhMRmibBo9sQ63QbjXvSeXw=;
        b=OTJyDvj3jMKinyvJ3uHIIWnyLR6NotdnY0IP6y7CyGJnA5XtU0/ZeEttiaKedPNkLmna/C
        DigaDQAHAxez+qHd/uSKRSVdTmebWswOBkpmTv6h+1Mxu5F5PWr5QZdnzRSlmzRaKZ4USj
        oK3e1qtWTJI2XEu5Dqlu3x/IZgiqmOglvLHVan06ZDyGVCRrPpJMby3KfSolOWPKI8D9Tu
        O4YMsjsgjLVZ43+TiCWlfQchvERDgzr05WaZ9UbUxsMQLxEG56cX1TJYpYob/fzTU8Khxc
        NseAGSyhhckgMILHxRMwrA2Uk/VFj4tA90RKsOm35dV+C4TLPQ4pUz9hzH/bJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694187953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XJnX1m9tikTjZGjqJrcNBhMRmibBo9sQ63QbjXvSeXw=;
        b=0OKoHU3dqRxuVPC9vJ0dN9/BYM2+aWjdw5SfRGJA33eRi/J0DGjXRi9VHTbN90MkPJkTM+
        SP2q53KYvdf5KoBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.5.2-rt8
Message-ID: <20230908154552.8TntDGz6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.5.2-rt8 patch set. 

Changes since v6.5.2-rt7:

  - The locking patches for flushed queued I/O had a possible dead lock
    with write_lock(). Reported by Sultan Alsawaf.

Known issues
     None

The delta patch against v6.5.2-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/incr/patch-6.5.2-rt7-rt8.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.5.2-rt8

The RT patch against v6.5.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patch-6.5.2-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patches-6.5.2-rt8.tar.xz

Sebastian

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index b5e881250fec5..34a59569db6be 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -241,7 +241,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &rwb->readers);
 
-	rt_mutex_pre_schedule();
+	rwbase_pre_schedule();
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	if (__rwbase_write_trylock(rwb))
@@ -254,7 +254,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
-			rt_mutex_post_schedule();
+			rwbase_post_schedule();
 			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
@@ -273,7 +273,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
-	rt_mutex_post_schedule();
+	rwbase_post_schedule();
 	return 0;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
