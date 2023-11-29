Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5627FDA87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjK2Oza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjK2Oz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:55:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FFBBE;
        Wed, 29 Nov 2023 06:55:33 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:55:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8ySP+SvI+7RTRaiKPPFubKiOWuKxmizoW+aXcEPjUg=;
        b=xcMz8xib+FFkoZcqruU8llUfCVmaY4oPY81F8knQH4IU2DdjJEmtTWSvYVtTtIIuqoc0O5
        PSkjLKWQahkTaNky8LjD/JIX/1A005uSsAiF59Lon3eaVU/uO2BJqalMidUvu3yLOWIPor
        sACJo6Ys5H90Ee6E7W1VKDvKcGfNan5Jr/B1qxDEyGu2TgJpkhk4KqzXpWaVvjA7j05lHk
        Ri3VFcAut4TJutGSl/beVnhNUlu2MwlutSt6CbNIo2f4sOra21wXu1fZLBalvOnIQ8+2wb
        e4MSKPQrhMZqJF4OgDOROUaFNxctMc8uLBjIImI/mpaeyU6NaN4uqxMeJQQV8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8ySP+SvI+7RTRaiKPPFubKiOWuKxmizoW+aXcEPjUg=;
        b=8UJX82e6i7Rvumh0npkmXqJD11e4CFIhnvsdSJMRHtPbVa4P40tzeUEU+K7NQcTH19YJVQ
        9alWh57eU7R+8bDA==
From:   "tip-bot2 for Elliot Berman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] freezer,sched: Clean saved_state when restoring it
 during thaw
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120-freezer-state-multiple-thaws-v1-2-f2e1dd7ce5a2@quicinc.com>
References: <20231120-freezer-state-multiple-thaws-v1-2-f2e1dd7ce5a2@quicinc.com>
MIME-Version: 1.0
Message-ID: <170126973067.398.7349628607545503736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     418146e39891ef1fb2284dee4cabbfe616cd21cf
Gitweb:        https://git.kernel.org/tip/418146e39891ef1fb2284dee4cabbfe616cd21cf
Author:        Elliot Berman <quic_eberman@quicinc.com>
AuthorDate:    Mon, 20 Nov 2023 09:36:32 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:43:53 +01:00

freezer,sched: Clean saved_state when restoring it during thaw

Clean saved_state after using it during thaw. Cleaning the saved_state
allows us to avoid some unnecessary branches in ttwu_state_match.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-2-f2e1dd7ce5a2@quicinc.com
---
 kernel/freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index c450fa8..43b1d1b 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -187,6 +187,7 @@ static int __restore_freezer_state(struct task_struct *p, void *arg)
 
 	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		p->saved_state = TASK_RUNNING;
 		return 1;
 	}
 
