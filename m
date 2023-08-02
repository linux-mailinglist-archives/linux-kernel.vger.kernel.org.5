Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87376D1CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjHBPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjHBPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:23:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAD30FA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:19:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5D0E1F8A4;
        Wed,  2 Aug 2023 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690989491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKIweQamxfw0ZZ0aSOi6JqFL+eQxAp+j1VDPErEK1gA=;
        b=KJRZPyx+5B/Ak0fQd2ZrAyISKSzXy2B+oMdHxqCaPaBRFNwVPz7+F2cTybcjx+QWJIWHLY
        F2rhlPeoEWnZKxdoh6rFW2G2mMXrYTtIk+gedFc/ka+Wg7e7LAX61toOdjJdSLDwHx6K3V
        YrDsLFYcpFZs2v/UBPRag+e+BsckDy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690989491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKIweQamxfw0ZZ0aSOi6JqFL+eQxAp+j1VDPErEK1gA=;
        b=L2RlHRWU0ZWPXiqwbtP1Ze5XJSUg75pgzizNBuqHtuM7BkMJzrv7bkY13k7N/roXmcknDP
        rbqY4Mu+kGq6nyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D073313919;
        Wed,  2 Aug 2023 15:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kRCWMbNzymRnKAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 02 Aug 2023 15:18:11 +0000
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
        linux-kernel@vger.kernel.org
Cc:     ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        Jiri Bohac <jbohac@suse.cz>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 2/2 RESEND] sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
Date:   Wed,  2 Aug 2023 17:19:06 +0200
Message-ID: <20230802151906.25258-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802151906.25258-1-chrubis@suse.cz>
References: <20230802151906.25258-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_rr_timeslice can be reset to default by writing value that is
<= 0. However after reading from this file we always got the last value
written, which is not useful at all.

$ echo -1 > /proc/sys/kernel/sched_rr_timeslice_ms
$ cat /proc/sys/kernel/sched_rr_timeslice_ms
-1

Fix this by setting the variable that holds the sysctl file value to the
jiffies_to_msecs(RR_TIMESLICE) in case that <= 0 value was written.

CC: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 185d3d749f6b..0597ba0f85ff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -3062,6 +3062,9 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
-- 
2.41.0

