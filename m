Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152A7C5F05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjJKVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJKVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B2C6;
        Wed, 11 Oct 2023 14:20:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697059247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voP3sbCfwCBN19eF5CDpSusKb/FwsQSqPHHNUWe4GVw=;
        b=WWeztrlVbSwiIc6ZhvmtI/xoK11cepau11p9AcbtfX4AfmspC/Da3yadUO4bDHBOOff9Xa
        MXKt4KhkNG06wZ5K6eq/JsgjAMd+4OEOlBEJwCQn0CU4y3XM1l6vnxGaxrPKfSpSfJLi4D
        A+zGkpQL6Wq8pZVQBDr47iOgzEqLuiN0iL88s9I/z0CuFmQbt6LQfoauwX1M69XYKtLzZp
        P+uEj4ajVqfjd2oAa4Uxk4L4UnjYVvTINqE/I7AE1t4I4ALReBCvP/fO+YCiNXGi5NmF3/
        i/80kAF3oEUOyPiwo4oAbV1lPE1xTjzAQ19xUcQil+pUx/LBHp7rntBQXh1Kbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697059247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voP3sbCfwCBN19eF5CDpSusKb/FwsQSqPHHNUWe4GVw=;
        b=86Ouan/J2Scqx9ZY/L2t60CqJAirjq2Teagr+ceGhqrhJlRRDpDCGXT5btzQE2T3O2TcAh
        0SdaZS/+AD6+E0Aw==
From:   "tip-bot2 for Yang Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Avoid updating PSI triggers and
 ->rtpoll_total when there are no state changes
Cc:     Yang Yang <yang.yang29@zte.com.cn>, Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Ziljstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202310101641075436843@zte.com.cn>
References: <202310101641075436843@zte.com.cn>
MIME-Version: 1.0
Message-ID: <169705924655.3135.2049174551799896356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     80cc1d1d5ee35701daf11725ce06d8a240588973
Gitweb:        https://git.kernel.org/tip/80cc1d1d5ee35701daf11725ce06d8a240588973
Author:        Yang Yang <yang.yang29@zte.com.cn>
AuthorDate:    Tue, 10 Oct 2023 16:41:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Oct 2023 23:07:50 +02:00

sched/psi: Avoid updating PSI triggers and ->rtpoll_total when there are no state changes

When psimon wakes up and there are no state changes for ->rtpoll_states,
it's unnecessary to update triggers and ->rtpoll_total because the pressures
being monitored by the user have not changed.

This will help to slightly reduce unnecessary computations of PSI.

[ mingo: Changelog updates ]

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/202310101641075436843@zte.com.cn
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index be853f2..79f8db0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}
 
 	if (now >= group->rtpoll_next_update) {
-		update_triggers(group, now, &update_total, PSI_POLL);
-		group->rtpoll_next_update = now + group->rtpoll_min_period;
-		if (update_total)
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, &update_total, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
+		}
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 	}
 
 	psi_schedule_rtpoll_work(group,
