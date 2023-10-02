Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00847B51D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjJBLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjJBLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:55:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BCE0;
        Mon,  2 Oct 2023 04:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EB2B2185F;
        Mon,  2 Oct 2023 11:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696247716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20h7KCpcQajnFp3w5doiMii1hEINmAwyPkgpAacIcrA=;
        b=0XBgxH/3uEkxE5rwWYDJbxD2pnpq8xEDVD76JmxuUplNhbQCxus67Gd2HPME5sNaH1wKFm
        EuFx+gtWVWY6vsZjJ2uKdjtxOUQ3I5C/9cpXAec6WUbE26GozoG/xqjnBTj96kl+mF1fh7
        suOk9uESkButXiFCFLy68Z0S8VMzHYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696247716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20h7KCpcQajnFp3w5doiMii1hEINmAwyPkgpAacIcrA=;
        b=eYmRgWqpmG+K3u8AaBXjk2wqUQci8T/zb85Zg0nyUDuFvL92prmlP0KqxKcI20NbPwylw8
        VX3VNv6BV8z18pBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2777813434;
        Mon,  2 Oct 2023 11:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u2sxCKSvGmVBFAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 02 Oct 2023 11:55:16 +0000
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v3 3/3] docs: scheduler-rt: Use real-time instead of realtime
Date:   Mon,  2 Oct 2023 13:55:53 +0200
Message-ID: <20231002115553.3007-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index a16bee8f74c2..d685609ed3d7 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -39,10 +39,10 @@ Most notable:
 1.1 The problem
 ---------------
 
-Realtime scheduling is all about determinism, a group has to be able to rely on
+Real-time scheduling is all about determinism, a group has to be able to rely on
 the amount of bandwidth (eg. CPU time) being constant. In order to schedule
-multiple groups of realtime tasks, each group must be assigned a fixed portion
-of the CPU time available.  Without a minimum guarantee a realtime group can
+multiple groups of real-time tasks, each group must be assigned a fixed portion
+of the CPU time available.  Without a minimum guarantee a real-time group can
 obviously fall short. A fuzzy upper limit is of no use since it cannot be
 relied upon. Which leaves us with just the single fixed portion.
 
@@ -50,14 +50,14 @@ relied upon. Which leaves us with just the single fixed portion.
 ----------------
 
 CPU time is divided by means of specifying how much time can be spent running
-in a given period. We allocate this "run time" for each realtime group which
-the other realtime groups will not be permitted to use.
+in a given period. We allocate this "run time" for each real-time group which
+the other real-time groups will not be permitted to use.
 
-Any time not allocated to a realtime group will be used to run normal priority
+Any time not allocated to a real-time group will be used to run normal priority
 tasks (SCHED_OTHER). Any allocated run time not used will also be picked up by
 SCHED_OTHER.
 
-Let's consider an example: a frame fixed realtime renderer must deliver 25
+Let's consider an example: a frame fixed real-time renderer must deliver 25
 frames a second, which yields a period of 0.04s per frame. Now say it will also
 have to play some music and respond to input, leaving it with around 80% CPU
 time dedicated for the graphics. We can then give this group a run time of 0.8
@@ -70,7 +70,7 @@ needs only about 3% CPU time to do so, it can do with a 0.03 * 0.005s =
 of 0.00015s.
 
 The remaining CPU time will be used for user input and other tasks. Because
-realtime tasks have explicitly allocated the CPU time they need to perform
+real-time tasks have explicitly allocated the CPU time they need to perform
 their tasks, buffer underruns in the graphics or audio can be eliminated.
 
 NOTE: the above example is not fully implemented yet. We still
@@ -90,12 +90,12 @@ The system wide settings are configured under the /proc virtual file system:
   The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use. This is always
+  A global limit on how much time real-time scheduling may use. This is always
   less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
-  this will limit time reserved to realtime processes. With
+  period_us for the real-time tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to real-time processes. With
   CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
-  realtime groups.
+  real-time groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
@@ -110,7 +110,7 @@ The system wide settings are configured under the /proc virtual file system:
 The default values for sched_rt_period_us (1000000 or 1s) and
 sched_rt_runtime_us (950000 or 0.95s).  This gives 0.05s to be used by
 SCHED_OTHER (non-RT tasks). These defaults were chosen so that a run-away
-realtime tasks will not lock up the machine but leave a little time to recover
+real-time tasks will not lock up the machine but leave a little time to recover
 it.  By setting runtime to -1 you'd get the old behaviour back.
 
 By default all bandwidth is assigned to the root group and new groups get the
@@ -118,10 +118,10 @@ period from /proc/sys/kernel/sched_rt_period_us and a run time of 0. If you
 want to assign bandwidth to another group, reduce the root group's bandwidth
 and assign some or all of the difference to another group.
 
-Realtime group scheduling means you have to assign a portion of total CPU
-bandwidth to the group before it will accept realtime tasks. Therefore you will
-not be able to run realtime tasks as any user other than root until you have
-done that, even if the user has the rights to run processes with realtime
+Real-time group scheduling means you have to assign a portion of total CPU
+bandwidth to the group before it will accept real-time tasks. Therefore you will
+not be able to run real-time tasks as any user other than root until you have
+done that, even if the user has the rights to run processes with real-time
 priority!
 
 
-- 
2.41.0

