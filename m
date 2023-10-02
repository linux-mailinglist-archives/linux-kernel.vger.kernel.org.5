Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195B57B51CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjJBLzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjJBLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:55:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2FDD;
        Mon,  2 Oct 2023 04:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2D1F2185E;
        Mon,  2 Oct 2023 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696247715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsXx++ft+4VCJrpVJaIU2XEeGtrebfs0OM99VTK3rfw=;
        b=1Mag04Uu8qGqH6FxLtUYVFIpkO3sXmjqFUIVACEoFDjjDCL2KNJ4I9ume9PPD8RG7TTwE/
        N43sWOm7p/wspFvAlrzquk2aQ8edSS+78bbIRCROKVW6C96zQT+Zcmr9/087DISvosGgcn
        xgIZqOY1yGjJ6Qchjr5zhKJ0Z4cM7Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696247715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsXx++ft+4VCJrpVJaIU2XEeGtrebfs0OM99VTK3rfw=;
        b=xy1XsqQVhp51b6Y77aSP9q6sJLgyBlyAYmkIOowJElDC6zf/JLbxTR+j5P3ssRorUP4xBE
        XLtR/Zm1G5ynqpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B36813434;
        Mon,  2 Oct 2023 11:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gaVlJKOvGmU/FAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 02 Oct 2023 11:55:15 +0000
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
Subject: [PATCH v3 2/3] docs: scheduler-rt: Clarify & fix sched_rt_* sysctl docs
Date:   Mon,  2 Oct 2023 13:55:52 +0200
Message-ID: <20231002115553.3007-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Describe explicitly that sched_rt_runtime_us is allocated from
  sched_rt_period_us and hence always less or equal to that value.

- The limit for sched_rt_runtime_us is not INT_MAX-1, but rather it's
  limited by the value of sched_rt_period_us. If sched_rt_period_us is
  INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..a16bee8f74c2 100644
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
+  less or equal to the period_us, as it denotes the time allocated from the
+  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to realtime processes. With
+  CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
+  realtime groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
   * sched_rt_period_us takes values from 1 to INT_MAX.
-  * sched_rt_runtime_us takes values from -1 to (INT_MAX - 1).
+  * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
 
 
-- 
2.41.0

