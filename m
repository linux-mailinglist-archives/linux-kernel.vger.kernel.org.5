Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF0756C32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGQSgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGQSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983599
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF3D611F3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB2C433C8;
        Mon, 17 Jul 2023 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618964;
        bh=2Tt8ICMKfzWDkMea/gUwrBxO6s1VpyH+p9cl1SdgSpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qp668aFcRBGP8zLzY6GQvJLG8x7s3Cq1ojefAVvPI8CpHQePhJ6chLqgHnKFZawlM
         IGnvCX9z/cIBkB4dwzII7t5oPYyvRjSncG+YciQjojoTHrMOCXf3gRfWlMGXtlpjo2
         6OUW5v1SiD4VIbM9kkzVYmzl2jSNqw2A9VtmvGiofypvvDz8TQhODBB+bYd0srS+oM
         JLz2ckx42b0+dcoq3UXJgvBJ0s6F3L8hGSaq1trPY+KBQWbZ5wjJEJ3oc2ziou5CxJ
         N5nIAoMtSBvuLW1QpoNrHMBIQq3IoZ5g31+4sjL57ym8XwqsSpBG9Fl1mP7rb2XwGm
         tr/FfnuYD3+Ig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 328F6CE04CD; Mon, 17 Jul 2023 11:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com,
        kernel-team@meta.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH csd-lock 2/2] smp: Reduce NMI traffic from CSD waiters to CSD destination
Date:   Mon, 17 Jul 2023 11:36:02 -0700
Message-Id: <20230717183602.1099773-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <96818440-a922-4b43-8871-50358e18b523@paulmck-laptop>
References: <96818440-a922-4b43-8871-50358e18b523@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Khan <imran.f.khan@oracle.com>

On systems with hundreds of CPUs, if most of the CPUs detect a CSD hang,
then all of these waiting CPUs send an NMI to the destination CPU in
order to dump its backtrace.

Given enough NMIs, the destination CPU will spent much of its time
producing backtraces, thus further delaying that CPU's response to the
original CSD IPI.  In the worst case, by the time destination CPU is
done producing all of these backtrace NMIs, the CSD wait timeout will
have elapsed so that the waiters resend their backtrace NMIs again,
further delaying forward progress.

Therefore, to avoid these delays, issue the backtrace NMI only from
the first waiter.  The destination CPU's other waiters can make use of
backtrace obtained from the first waiter's NMI.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1d41a0cb54f1..8455a53465af 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -46,6 +46,8 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
+static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
+
 static void __flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
@@ -253,7 +255,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
 	}
 	if (cpu >= 0) {
-		dump_cpu_task(cpu);
+		if (atomic_cmpxchg_acquire(&per_cpu(trigger_backtrace, cpu), 1, 0))
+			dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
 			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
 			arch_send_call_function_single_ipi(cpu);
@@ -434,9 +437,14 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	struct llist_node *entry, *prev;
 	struct llist_head *head;
 	static bool warned;
+	atomic_t *tbt;
 
 	lockdep_assert_irqs_disabled();
 
+	/* Allow waiters to send backtrace NMI from here onwards */
+	tbt = this_cpu_ptr(&trigger_backtrace);
+	atomic_set_release(tbt, 1);
+
 	head = this_cpu_ptr(&call_single_queue);
 	entry = llist_del_all(head);
 	entry = llist_reverse_order(entry);
-- 
2.40.1

