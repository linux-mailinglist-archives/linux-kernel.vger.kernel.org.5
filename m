Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE07A1AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjIOJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjIOJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:36:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4744171C;
        Fri, 15 Sep 2023 02:36:26 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694770584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFxc2R4QX3SL6qKcyTQop/43MwcshPy66p2kRtRIxKc=;
        b=p0EiLuh6t09J8EmNaD7SQJRVmcG+YZ6GUWswNIUMiipyySKFp1AoW1BfnDWUfIiltKeZBd
        d6n4JNYVZN2CcozrXuLA0NW5qS85ctrVU51NBdeacmBrB6XkBa6DbuTuN6ccXaIEJ6Vr3i
        HICxcO5hujpPwzgl1S4ni6YbGVvWUrQY5lH21ZslTcoai9Piyd0ktaNl509MCCi22Iz91v
        US1df2IVcec9CSRX3Jl8Hk/XW9DLdXHn8JbHb09KY+ytjC6+N/knHctk4ud9UK32ZLq8DF
        p6TMHmK/Fy8Geq7SSuULIsaHhnMY9ba4h/K5WslkxfJC5aXL+uGNrZh0kd3x1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694770584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFxc2R4QX3SL6qKcyTQop/43MwcshPy66p2kRtRIxKc=;
        b=iOyHCMeM7XpKke5X81o3PnfrvhS+RPJmhECKpWGDY2PDvCI1RSM3grSFtiliiNp36AoSFz
        6N2y7wWt1uhjaaBw==
From:   "tip-bot2 for Lukas Wunner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] panic: Reenable preemption in WARN slowpath
Cc:     Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
References: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
MIME-Version: 1.0
Message-ID: <169477058360.27769.17772363826818333894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     cccd32816506cbac3a4c65d9dff51b3125ef1a03
Gitweb:        https://git.kernel.org/tip/cccd32816506cbac3a4c65d9dff51b3125ef1a03
Author:        Lukas Wunner <lukas@wunner.de>
AuthorDate:    Fri, 15 Sep 2023 09:55:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 11:28:08 +02:00

panic: Reenable preemption in WARN slowpath

Commit:

  5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")

amended warn_slowpath_fmt() to disable preemption until the WARN splat
has been emitted.

However the commit neglected to reenable preemption in the !fmt codepath,
i.e. when a WARN splat is emitted without additional format string.

One consequence is that users may see more splats than intended.  E.g. a
WARN splat emitted in a work item results in at least two extra splats:

  BUG: workqueue leaked lock or atomic
  (emitted by process_one_work())

  BUG: scheduling while atomic
  (emitted by worker_thread() -> schedule())

Ironically the point of the commit was to *avoid* extra splats. ;)

Fix it.

Fixes: 5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de
---
 kernel/panic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4..ffa037f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
+		warn_rcu_exit(rcu);
 		return;
 	}
 
