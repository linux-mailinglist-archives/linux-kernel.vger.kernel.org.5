Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09227B272F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjI1VLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjI1VLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A101A2;
        Thu, 28 Sep 2023 14:11:12 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:11:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695935470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe1hnQ8O830GEjIaYbkhYp049qinjisAloma8VEM6yo=;
        b=n1L6U/qBJfah3tECd9qQQtOPJ+fbVsqTdcwU2zV/XnQ7PJhm1HpvstxL/bdNGrvU3LpLCp
        0Z7j3OTQWQA+ZdcNE9qlqci2n1BvGRz7c9kPeACQ5F4G+WUdTEqJYKlkLlwIVORZ8VFaUV
        j3NZmYknkZI/JpUmrtKTMeEefd/fAGtdv8s9u+IYGY4+U3ZwDJ2RDXZx71kO25ykOTlacS
        e5sE7ZQ5roOsoKMIIVU1ZqoEUeg2lAK+t+nDL2Jyb63UYQ88HPbCv02sH2Ej/2f6e2S6FB
        54thRvmJ9AmxP6z36/UMP/S8fjHY2mhqHukHyprqtLLKBfFuPE1kkZEECfUh3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695935470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe1hnQ8O830GEjIaYbkhYp049qinjisAloma8VEM6yo=;
        b=sI/kCc2n9pPftBQJdDM20sOsXVUVhVgFlQ3QPrc5vTCLEJTzlwu5PNMezk5JTeugJIViH6
        bH12Y2/z35QR52Dw==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt: Fix live lock between
 select_fallback_rq() and RT push
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230923011409.3522762-1-joel@joelfernandes.org>
References: <20230923011409.3522762-1-joel@joelfernandes.org>
MIME-Version: 1.0
Message-ID: <169593547011.27769.15927547566549866294.tip-bot2@tip-bot2>
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

Commit-ID:     fc09027786c900368de98d03d40af058bcb01ad9
Gitweb:        https://git.kernel.org/tip/fc09027786c900368de98d03d40af058bcb01ad9
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Sat, 23 Sep 2023 01:14:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 22:58:13 +02:00

sched/rt: Fix live lock between select_fallback_rq() and RT push

During RCU-boost testing with the TREE03 rcutorture config, I found that
after a few hours, the machine locks up.

On tracing, I found that there is a live lock happening between 2 CPUs.
One CPU has an RT task running, while another CPU is being offlined
which also has an RT task running.  During this offlining, all threads
are migrated. The migration thread is repeatedly scheduled to migrate
actively running tasks on the CPU being offlined. This results in a live
lock because select_fallback_rq() keeps picking the CPU that an RT task
is already running on only to get pushed back to the CPU being offlined.

It is anyway pointless to pick CPUs for pushing tasks to if they are
being offlined only to get migrated away to somewhere else. This could
also add unwanted latency to this task.

Fix these issues by not selecting CPUs in RT if they are not 'active'
for scheduling, using the cpu_active_mask. Other parts in core.c already
use cpu_active_mask to prevent tasks from being put on CPUs going
offline.

With this fix I ran the tests for days and could not reproduce the
hang. Without the patch, I hit it in a few hours.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230923011409.3522762-1-joel@joelfernandes.org
---
 kernel/sched/cpupri.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e72..42c40cf 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
