Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F07B01E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjI0K3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0K3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:29:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A532EB;
        Wed, 27 Sep 2023 03:29:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDD9A2192D;
        Wed, 27 Sep 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695810572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxG0ZA7/Za7bKDG5oepNfkkaA1iabq3sh46JVCNH8po=;
        b=dDe2oM3eK05m45PKqfd2dr2jQJnjjU5g+MDzcdEpeUR4plWb0ym3fDxultL2cnZ4fDaTki
        017FNq+dyOK1IglPAzU55pezr194FZeSgR7Ck5OYWZagIgWxIAnmERaHVg4murdvrGFc00
        d1WHi5FRluuTEaEkKZzE6FgQt/r1m+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695810572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxG0ZA7/Za7bKDG5oepNfkkaA1iabq3sh46JVCNH8po=;
        b=H7HJMb6JO9ZjffHKwP/FT5OgGufVRDAUQ+i/z0HZ9qYliWVizjxNv3V23nGH2xf9uB/ohl
        /gh4AczGHeLCqmCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD35F13479;
        Wed, 27 Sep 2023 10:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HORLNAwEFGWqMwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 27 Sep 2023 10:29:32 +0000
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
Subject: [PATCH v2 2/2] docs: scheduler-rt: Clarify & fix sched_rt_* sysctl docs
Date:   Wed, 27 Sep 2023 12:30:12 +0200
Message-ID: <20230927103012.9587-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927103012.9587-1-chrubis@suse.cz>
References: <20230927103012.9587-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Describe explicitly that sched_rt_runtime_us is allocated from
  sched_rt_period_us and hence always less or equal to that value.

- The limit for sched_rt_runtime_us is not INT_MAX - 1 but rather it's
  limited by the value of sched_rt_period_us. If sched_rt_period_us is
  INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..033661a5838f 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -87,18 +87,20 @@ lack an EDF scheduler to make non-uniform periods usable.
 The system wide settings are configured under the /proc virtual file system:
 
 /proc/sys/kernel/sched_rt_period_us:
-  The scheduling period that is equivalent to 100% CPU bandwidth
+  The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use.  Even without
-  CONFIG_RT_GROUP_SCHED enabled, this will limit time reserved to realtime
-  processes. With CONFIG_RT_GROUP_SCHED it signifies the total bandwidth
-  available to all realtime groups.
+  A global limit on how much time realtime scheduling may use. This is always
+  less or equal than the period_us as it denotes the time allocated from the
+  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to realtime processes. With
+  CONFIG_RT_GROUP_SCHED it signifies the total bandwidth available to all
+  realtime groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
   * sched_rt_period_us takes values from 1 to INT_MAX.
-  * sched_rt_runtime_us takes values from -1 to (INT_MAX - 1).
+  * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
 
 
-- 
2.41.0

