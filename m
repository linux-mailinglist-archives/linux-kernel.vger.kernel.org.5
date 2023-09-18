Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90097A4309
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjIRHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjIRHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:41:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5ED170D;
        Mon, 18 Sep 2023 00:38:14 -0700 (PDT)
Date:   Mon, 18 Sep 2023 06:21:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695022692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifDIpIeokB6phVtS5ilxDHQ0vg3820UzqC9/Ocq+NZI=;
        b=qYpAQ8ZKcmKRRba1kUEMjWqQaBbBWxo+Y+quB6QOnLNKE2nnw8RkBhTVUXWtghm5WlB1jr
        7wSfPNUU61yXXw8U0Q70mpGNc+yQgj3efNcjn9qZK88QvHzE9NkQt+78bfBKIziNj0VWbU
        2xH+IZw1AQBlxsy69kQixZ7xQ+IpfNP6wbEvOdDi5mcH/P+tYQafQMkFMO8ncWdHzpoDl0
        +gvMdRDOJwXTY0MHtfhCTq+Svl2JyyQR7RXf1GtTGDl5UBOoVmy0oP7+/qWM3UtPMT2r+W
        j2gI+Z8bIpSPDJ6LczkH4dEUblwwYeO82KNcrjIpB+hbA+TteUcvUGyHYtkzrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695022692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifDIpIeokB6phVtS5ilxDHQ0vg3820UzqC9/Ocq+NZI=;
        b=XDhu9yzbmDO1nKzhS/SiZykcuQDBTuztDN1zYj44TG7L+6hWbtZWGtWbs0iMf52MQf0A7P
        aO7xNqv877HaifAw==
From:   "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Ratelimit update to tg->load_avg
Cc:     Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aaron Lu <aaron.lu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Vernet <void@manifault.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912065808.2530-2-aaron.lu@intel.com>
References: <20230912065808.2530-2-aaron.lu@intel.com>
MIME-Version: 1.0
Message-ID: <169501808279.27769.6827304555334200206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1528c661c24b407e92194426b0adbb43de859ce0
Gitweb:        https://git.kernel.org/tip/1528c661c24b407e92194426b0adbb43de8=
59ce0
Author:        Aaron Lu <aaron.lu@intel.com>
AuthorDate:    Tue, 12 Sep 2023 14:58:08 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 08:14:45 +02:00

sched/fair: Ratelimit update to tg->load_avg

When using sysbench to benchmark Postgres in a single docker instance
with sysbench's nr_threads set to nr_cpu, it is observed there are times
update_cfs_group() and update_load_avg() shows noticeable overhead on
a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):

    13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
    10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg

Annotate shows the cycles are mostly spent on accessing tg->load_avg
with update_load_avg() being the write side and update_cfs_group() being
the read side. tg->load_avg is per task group and when different tasks
of the same taskgroup running on different CPUs frequently access
tg->load_avg, it can be heavily contended.

E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
Sappire Rapids, during a 5s window, the wakeup number is 14millions and
migration number is 11millions and with each migration, the task's load
will transfer from src cfs_rq to target cfs_rq and each change involves
an update to tg->load_avg. Since the workload can trigger as many wakeups
and migrations, the access(both read and write) to tg->load_avg can be
unbound. As a result, the two mentioned functions showed noticeable
overhead. With netperf/nr_client=3Dnr_cpu/UDP_RR, the problem is worse:
during a 5s window, wakeup number is 21millions and migration number is
14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.

Reduce the overhead by limiting updates to tg->load_avg to at most once
per ms. The update frequency is a tradeoff between tracking accuracy and
overhead. 1ms is chosen because PELT window is roughly 1ms and it
delivered good results for the tests that I've done. After this change,
the cost of accessing tg->load_avg is greatly reduced and performance
improved. Detailed test results below.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
  postgres_sysbench on SPR:
  25%
  base:   42382=C2=B119.8%
  patch:  50174=C2=B19.5%  (noise)

  50%
  base:   67626=C2=B11.3%
  patch:  67365=C2=B13.1%  (noise)

  75%
  base:   100216=C2=B11.2%
  patch:  112470=C2=B10.1% +12.2%

  100%
  base:    93671=C2=B10.4%
  patch:  113563=C2=B10.2% +21.2%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
  hackbench on ICL:
  group=3D1
  base:    114912=C2=B15.2%
  patch:   117857=C2=B12.5%  (noise)

  group=3D4
  base:    359902=C2=B11.6%
  patch:   361685=C2=B12.7%  (noise)

  group=3D8
  base:    461070=C2=B10.8%
  patch:   491713=C2=B10.3% +6.6%

  group=3D16
  base:    309032=C2=B15.0%
  patch:   378337=C2=B11.3% +22.4%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  hackbench on SPR:
  group=3D1
  base:    100768=C2=B12.9%
  patch:   103134=C2=B12.9%  (noise)

  group=3D4
  base:    413830=C2=B112.5%
  patch:   378660=C2=B116.6% (noise)

  group=3D8
  base:    436124=C2=B10.6%
  patch:   490787=C2=B13.2% +12.5%

  group=3D16
  base:    457730=C2=B13.2%
  patch:   680452=C2=B11.3% +48.8%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
  netperf/udp_rr on ICL
  25%
  base:    114413=C2=B10.1%
  patch:   115111=C2=B10.0% +0.6%

  50%
  base:    86803=C2=B10.5%
  patch:   86611=C2=B10.0%  (noise)

  75%
  base:    35959=C2=B15.3%
  patch:   49801=C2=B10.6% +38.5%

  100%
  base:    61951=C2=B16.4%
  patch:   70224=C2=B10.8% +13.4%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  netperf/udp_rr on SPR
  25%
  base:   104954=C2=B11.3%
  patch:  107312=C2=B12.8%  (noise)

  50%
  base:    55394=C2=B14.6%
  patch:   54940=C2=B17.4%  (noise)

  75%
  base:    13779=C2=B13.1%
  patch:   36105=C2=B11.1% +162%

  100%
  base:     9703=C2=B13.7%
  patch:   28011=C2=B10.2% +189%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  netperf/tcp_stream on ICL (all in noise range)
  25%
  base:    43092=C2=B10.1%
  patch:   42891=C2=B10.5%

  50%
  base:    19278=C2=B114.9%
  patch:   22369=C2=B17.2%

  75%
  base:    16822=C2=B13.0%
  patch:   17086=C2=B12.3%

  100%
  base:    18216=C2=B10.6%
  patch:   18078=C2=B12.9%

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  netperf/tcp_stream on SPR (all in noise range)
  25%
  base:    34491=C2=B10.3%
  patch:   34886=C2=B10.5%

  50%
  base:    19278=C2=B114.9%
  patch:   22369=C2=B17.2%

  75%
  base:    16822=C2=B13.0%
  patch:   17086=C2=B12.3%

  100%
  base:    18216=C2=B10.6%
  patch:   18078=C2=B12.9%

Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: David Vernet <void@manifault.com>
Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Link: https://lkml.kernel.org/r/20230912065808.2530-2-aaron.lu@intel.com
---
 kernel/sched/fair.c  | 13 ++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c893721..d087787 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3876,7 +3876,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs=
_rq)
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	long delta;
+	u64 now;
=20
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3884,9 +3885,19 @@ static inline void update_tg_load_avg(struct cfs_rq *c=
fs_rq)
 	if (cfs_rq->tg =3D=3D &root_task_group)
 		return;
=20
+	/*
+	 * For migration heavy workloads, access to tg->load_avg can be
+	 * unbound. Limit the update rate to at most once per ms.
+	 */
+	now =3D sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
+		return;
+
+	delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
 		cfs_rq->tg_load_avg_contrib =3D cfs_rq->avg.load_avg;
+		cfs_rq->last_update_tg_load_avg =3D now;
 	}
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 68768f4..887468c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -594,6 +594,7 @@ struct cfs_rq {
 	} removed;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
