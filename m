Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A327A17EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjIOIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:05:04 -0400
X-Greylist: delayed 553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 01:04:59 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8D1998
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:04:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 90A232800BC39;
        Fri, 15 Sep 2023 09:55:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8356E50E339; Fri, 15 Sep 2023 09:55:44 +0200 (CEST)
Message-Id: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 15 Sep 2023 09:55:39 +0200
Subject: [PATCH] panic: Reenable preemption in WARN slowpath
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during
WARN/BUG") amended warn_slowpath_fmt() to disable preemption until the
WARN splat has been emitted.

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
Cc: stable@vger.kernel.org # v6.1+
Cc: Peter Zijlstra <peterz@infradead.org>
---
The original commit went in through the tip tree, hence submitting to
tip maintainers.  The commit was backported to v6.1-stable (even though
it wasn't tagged for stable), hence this fix needs a stable designation.

 kernel/panic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4..ffa037fa 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
+		warn_rcu_exit(rcu);
 		return;
 	}
 
-- 
2.39.2

