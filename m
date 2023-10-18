Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD57CD68D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjJRIb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbjJRIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:31:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F7BA;
        Wed, 18 Oct 2023 01:31:51 -0700 (PDT)
Date:   Wed, 18 Oct 2023 08:31:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697617910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p1eHh83Sg5uz33qMvHr/Qg2yAhdWF/K7xokZDEP7HJM=;
        b=qHNxPEK8a8M+NaT/1mAM4eDzdD5BZJvbi9C+kk/yOZ7AsiRw/YWc6A08x75cTMOca8wd6G
        +SUCKqdkj4LnabgzZqPbLZL1enDiEHLpM+KUQ+kqvK+YLBGAi2/px3VD2pVP5wJph52OuQ
        mbeEnkNRsWVnQSXUYkTS5cSNmzjdwOgXRg7mvgoLmclx8dvmj/uClFpVEHmvIzXwyBZWqA
        qFKUZW/dMO7f2cqON6HCIGt+zo84OKs7BQxLqrF9pcyyy2qeDhuCOK8FbtGhLhF5V3uFUy
        hDHsI89cHmyrVJnl7yWiXQFXvw9V/GicwvLimwzF2Vk8rfnuo4QwPUjKjOAgGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697617910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p1eHh83Sg5uz33qMvHr/Qg2yAhdWF/K7xokZDEP7HJM=;
        b=9r7v6E9ExhnkSmMK3sOvJSkBTewahkkGEu8jYR1JubHMLh1LbAj+fTF0WfXJzmh34kVrD7
        p0hWgRmxAgp/hgBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix heap corruption more
Cc:     0599jiangyc@gmail.com, Dmitry Safonov <0x7f454c46@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169761790955.3135.2302450117444631157.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d2929762cc3f85528b0ca12f6f63c2a714f24778
Gitweb:        https://git.kernel.org/tip/d2929762cc3f85528b0ca12f6f63c2a714f24778
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Oct 2023 16:59:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Oct 2023 10:22:13 +02:00

sched/eevdf: Fix heap corruption more

Because someone is a flaming idiot... and forgot we have current as
se->on_rq but not actually in the tree itself, and walking rb_parent()
on an entry not in the tree is 'funky' and KASAN complains.

Fixes: 8dafa9d0eb1a ("sched/eevdf: Fix min_deadline heap integrity")
Reported-by: 0599jiangyc@gmail.com
Reported-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218020
Link: https://lkml.kernel.org/r/CAJwJo6ZGXO07%3DQvW4fgQfbsDzQPs9xj5sAQ1zp%3DmAyPMNbHYww%40mail.gmail.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 061a30a..df348aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3657,7 +3657,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
-		min_deadline_cb_propagate(&se->run_node, NULL);
+		if (se != cfs_rq->curr)
+			min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
