Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704B7FDA88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjK2Ozd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK2Oz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:55:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D74C6;
        Wed, 29 Nov 2023 06:55:33 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WEPXGYdbhKOooWioB6jRt0QqF0avzhckQjBmlIoo6s=;
        b=My0aKc0DwrDN+B2kIHZ/l5PICx7jDel/R0tESE7iWoG8Ri1hbbj2fmETLLEhGzuYeikrkc
        W2FnlaO0nysWqXmb+8qCkKADiGfI66x02PSHaDUOtb6RTZlXAAWjXap5LCk7WAVNPAjol6
        xa8PRROJqaGnUAZSUEG3SULm+8EwzsMFDg3Gx6P97faTYtUpTLYwgiJ3QYoAhMFfb3DWHk
        qi15KfJt8kMyF4yPD/wv2rsJnx9iCHHfkzhZURBMsRiwkxID6GtNwBT0ceikd9DEJVyK6V
        iNilBh1Ub1kK3KnyW4h9ODSzFzPyUHS3NO7hxMm6roC7tKcJG9GivuSpGtNAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WEPXGYdbhKOooWioB6jRt0QqF0avzhckQjBmlIoo6s=;
        b=S6hnk1FdRW0ls8EP3MkrvyCZW6IUWts27ZJIJyBMARX90E+KfdWAtsISUlD8DGYBhfn0Kr
        jOtLoEjlWiYtzFCQ==
From:   "tip-bot2 for Yiwei Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Update min_vruntime for
 reweight_entity() correctly
Cc:     Yiwei Lin <s921975628@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Abel Wu <wuyun.abel@bytedance.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117080106.12890-1-s921975628@gmail.com>
References: <20231117080106.12890-1-s921975628@gmail.com>
MIME-Version: 1.0
Message-ID: <170126973174.398.17001381623417224269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5068d84054b766efe7c6202fc71b2350d1c326f1
Gitweb:        https://git.kernel.org/tip/5068d84054b766efe7c6202fc71b2350d1c326f1
Author:        Yiwei Lin <s921975628@gmail.com>
AuthorDate:    Fri, 17 Nov 2023 16:01:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:43:52 +01:00

sched/fair: Update min_vruntime for reweight_entity() correctly

Since reweight_entity() may have chance to change the weight of
cfs_rq->curr entity, we should also update_min_vruntime() if
this is the case

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>
Link: https://lore.kernel.org/r/20231117080106.12890-1-s921975628@gmail.com
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34fe6e9..bcea3d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (!curr) {
-			/*
-			 * The entity's vruntime has been adjusted, so let's check
-			 * whether the rq-wide min_vruntime needs updated too. Since
-			 * the calculations above require stable min_vruntime rather
-			 * than up-to-date one, we do the update at the end of the
-			 * reweight process.
-			 */
+		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-			update_min_vruntime(cfs_rq);
-		}
+
+		/*
+		 * The entity's vruntime has been adjusted, so let's check
+		 * whether the rq-wide min_vruntime needs updated too. Since
+		 * the calculations above require stable min_vruntime rather
+		 * than up-to-date one, we do the update at the end of the
+		 * reweight process.
+		 */
+		update_min_vruntime(cfs_rq);
 	}
 }
 
