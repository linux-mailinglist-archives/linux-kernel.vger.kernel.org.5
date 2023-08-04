Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0771076FF7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjHDLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHDLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:30:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE67126
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:30:49 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691148647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyi0hihZY2jn2pAnNhMOJoJ7pshtJwt3VPheJEyFbQY=;
        b=T1VtCb5summwfo85838+uP2xHDFvzN6L8pIbSEkwnY/Bt+cKFhCDOm9QsKgH4oyCZ/7jis
        cdVHWkciqXSseqEOQwiDr+0vLtRzh1TBFxBElnlhE+AhRmfVBFfLxYswhBp7tk/7vWEjdh
        V71wZ7ucT+37ZAq7H8oGEKgfxsDBzGMFchyUMxZLF8BUr8UQZs5L8MacZjkfP4dueYS5JA
        eztj6HLBkd3Yy+m3AuayEymhBBb2jgCsRyXAPLSAh/r9pZLBfIG9eV4RsHIOQSVLTE7HgY
        HRLp90yFXYXk4bKbOByTwwYmEyrZwHwnpwmXfVz6y5HklIJWVAeZp8vFknmC2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691148647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyi0hihZY2jn2pAnNhMOJoJ7pshtJwt3VPheJEyFbQY=;
        b=WV6XnA1MUccjmajKxXKw6rjDjDZMqwO4T7Nxv7DOikc6Mw/KSWSxDZE7hZL6AKXlo5BpEg
        ktbaUx5mCTI4yADw==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/3] softirq: Add function to preempt serving softirqs.
Date:   Fri,  4 Aug 2023 13:30:38 +0200
Message-Id: <20230804113039.419794-3-bigeasy@linutronix.de>
In-Reply-To: <20230804113039.419794-1-bigeasy@linutronix.de>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality for the softirq handler to preempt its current work
if needed. The softirq core has no particular state. It reads and resets
the pending softirq bits and then processes one after the other.
It can already be preempted while it invokes a certain softirq handler.

By enabling the BH the softirq core releases the per-CPU bh lock which
serializes all softirq handler. It is safe to do as long as the code
does not expect any serialisation in between. A typical scenarion would
after the invocation of callback where no state needs to be preserved
before the next callback is invoked.

Add functionaliry to preempt the serving softirqs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/bottom_half.h |  2 ++
 kernel/softirq.c            | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d90..448bbef474564 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -35,8 +35,10 @@ static inline void local_bh_enable(void)
=20
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
+extern void softirq_preempt(void);
 #else
 static inline bool local_bh_blocked(void) { return false; }
+static inline void softirq_preempt(void) { }
 #endif
=20
 #endif /* _LINUX_BH_H */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34ccd7973..dd3307a619af7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -247,6 +247,19 @@ void __local_bh_enable_ip(unsigned long ip, unsigned i=
nt cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
=20
+void softirq_preempt(void)
+{
+	if (WARN_ON_ONCE(!preemptible()))
+		return;
+
+	if (WARN_ON_ONCE(__this_cpu_read(softirq_ctrl.cnt) !=3D SOFTIRQ_OFFSET))
+		return;
+
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	/* preemption point */
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
 /*
  * Invoked from ksoftirqd_run() outside of the interrupt disabled section
  * to acquire the per CPU local lock for reentrancy protection.
--=20
2.40.1

