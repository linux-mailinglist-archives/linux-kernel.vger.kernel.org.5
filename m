Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF37BDCF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbjJINAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbjJIM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:59:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18518F;
        Mon,  9 Oct 2023 05:59:58 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696856397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=004py6dV+Hxp9dA+Tj1mSJV1eqQXyR+S3HHuVu00MT4=;
        b=Alk+/e0EzjqlUsVxw6danKB7BdZbOSQ2q4KFNOOdz+44tVS2JpKnWusk1HXflL9fno4NkN
        8NGbN0Pllx74i5xHlRb7ah9j+eZx+/qVYaryldb24B4VRuvTXRlA7T02+DQPN3t/W/7BbO
        iv03tDac6rKZwwXBXn6bE3tfAk7MI0nbGUU9E+6wgdGNxpvtGH2PPrL4a3qNUJ4ZT0riIp
        XqfjDf+YeWbnZRvFh/DZfORCxHEeAN4p5qxq5krnbUeeU6kh5hJ8OHUNKi6K+I8dJZD3xs
        brRX45SYYBamJYty1Ws662zb3j90XKNdvjf17IxwH+wCfhJzK8uGMv/gBcWCXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696856397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=004py6dV+Hxp9dA+Tj1mSJV1eqQXyR+S3HHuVu00MT4=;
        b=+ZOfWFN3nGPujckryXTPbetjst23UX9lGaFCT32HgzNX7RRdJvwsJtuNDrKSEDh8MumI4a
        2fIL9AziB0Ysw+AQ==
From:   "tip-bot2 for Yang Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Change update_triggers() to a 'void' function
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202310092024289721617@zte.com.cn>
References: <202310092024289721617@zte.com.cn>
MIME-Version: 1.0
Message-ID: <169685639641.3135.6956705844549112349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e03dc9fa0663bc303383170e961561462ff00c93
Gitweb:        https://git.kernel.org/tip/e03dc9fa0663bc303383170e961561462ff00c93
Author:        Yang Yang <yang.yang29@zte.com.cn>
AuthorDate:    Mon, 09 Oct 2023 20:24:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 14:54:50 +02:00

sched/psi: Change update_triggers() to a 'void' function

Update_triggers() always returns now + group->rtpoll_min_period, and the
return value is only used by psi_rtpoll_work(), so change update_triggers()
to a void function, let group->rtpoll_next_update = now +
group->rtpoll_min_period directly.

This will avoid unnecessary function return value passing & simplifies
the function.

[ mingo: Updated changelog ]

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/202310092024289721617@zte.com.cn
---
 kernel/sched/psi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1d0f634..be853f2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -434,7 +434,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
+static void update_triggers(struct psi_group *group, u64 now, bool *update_total,
 						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
@@ -503,8 +503,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
-
-	return now + group->rtpoll_min_period;
 }
 
 static u64 update_averages(struct psi_group *group, u64 now)
@@ -706,7 +704,8 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}
 
 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
+		update_triggers(group, now, &update_total, PSI_POLL);
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
