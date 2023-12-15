Return-Path: <linux-kernel+bounces-1369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A57814E19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4720E1C23F54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58747F60;
	Fri, 15 Dec 2023 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QPPNb1XU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDbhOqx2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CB4187D;
	Fri, 15 Dec 2023 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs9x26/0xa1tcBYKbgQAR4XHVyOmk1j4LbahtbGEJ58=;
	b=QPPNb1XUv1JJZyXkWSJEfN4hs115WhG65vgXF8+eYS2NVCHUiR5bdf+0Te2De9CMkDVhX5
	kg+4nxjhReF+U9wcdzwufFTgCeQwQjWs5e258Ldrv1vqqYXu667680eap2RXNzFS97oZ97
	Hl80mYjI7MI1SsnnbfyfgeagmgvnlzY0xr283cnFTp45haOfEGAsbdu95tuNqd14AFBlLh
	IoqH0SrvRHQagmfhbpovRgr2lo+JMaXjSOlPqfVO52gdeCf/JjymwJKCmpvPAqjwoyc52q
	NsJz+5hhs3fygtd4N4fSYjKv7jyo4nbagYTuZK1T6MBDaNXVxUcOQLb/XpjnNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs9x26/0xa1tcBYKbgQAR4XHVyOmk1j4LbahtbGEJ58=;
	b=KDbhOqx2pyNuV88W7bRpl2paKK1qKcH6+JJCM/aNDU55/cuO1o1cA8YMiXZu0qz812rB0f
	YrGOeFqrjm1A/SAQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH net-next 08/24] net: softnet_data: Make xmit.recursion per task.
Date: Fri, 15 Dec 2023 18:07:27 +0100
Message-ID: <20231215171020.687342-9-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
local_bh_disable() there is no guarantee that only one device is
transmitting at a time.
With preemption and multiple senders it is possible that the per-CPU
recursion counter gets incremented by different threads and exceeds
XMIT_RECURSION_LIMIT leading to a false positive recursion alert.

Instead of adding a lock to protect the per-CPU variable it is simpler
to make the counter per-task. Sending and receiving skbs happens always
in thread context anyway.

Having a lock to protected the per-CPU counter would block/ serialize two
sending threads needlessly. It would also require a recursive lock to
ensure that the owner can increment the counter further.

Make the recursion counter a task_struct member on PREEMPT_RT.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 30 +++++++++++++++++++++++++++++-
 include/linux/sched.h     |  4 +++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2564e209465ea..06436695c3679 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3260,7 +3260,9 @@ struct softnet_data {
 #endif
 	/* written and read only by owning cpu: */
 	struct {
+#ifndef CONFIG_PREEMPT_RT
 		u16 recursion;
+#endif
 		u8  more;
 #ifdef CONFIG_NET_EGRESS
 		u8  skip_txqueue;
@@ -3308,12 +3310,36 @@ static inline void input_queue_tail_incr_save(struc=
t softnet_data *sd,
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
=20
+#define XMIT_RECURSION_LIMIT	8
+#ifdef CONFIG_PREEMPT_RT
+
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit_recursion;
+}
+
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit_recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit_recursion--;
+}
+
+#else
+
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
=20
-#define XMIT_RECURSION_LIMIT	8
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -3330,6 +3356,8 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
=20
+#endif
+
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
=20
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c316972485..26b1b7d674b5d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -964,7 +964,9 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	u8				net_xmit_recursion;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
 	struct restart_block		restart_block;
--=20
2.43.0


