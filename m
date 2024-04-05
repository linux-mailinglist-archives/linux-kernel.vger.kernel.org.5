Return-Path: <linux-kernel+bounces-133180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD789A006
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0B7282D94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA3016F29A;
	Fri,  5 Apr 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWMkDYoI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AB16F282
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328159; cv=none; b=G/5E34hvcHX0g+DYzorZxD+nRimzJSntpMBuZ9phE8AsOCxHHVku0zPNbyPyn6KsG74QaV211nV0xv12TgEajjaXNhkRFsaTbcyD9ouTYABKWveq3are0lMk4stqLclzNlZ24wBjKO4wGpBb6Vy5VL7RrLRwK8hyuBeCzk1xUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328159; c=relaxed/simple;
	bh=rJWQfu/YnSRY6XERT2o5HEtNNeUju6+bvYGSwNNeweY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uT4tHkmNW1uq5Wkk+hfpMytmqAmL8Yhe0LODSBxiCiZhmajO3Dy9VMjR98U8nK0P9srKIxAROZPaM5vYZarIFuz/ZSwngL6jsHXxn1moX1/B6RJKwnr8hHPSGvC05zJ0ZYwPFBFgffj3BdhOPT/u9gqeZffkJJbrLU/K926uZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWMkDYoI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fb338247so2166208b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712328157; x=1712932957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyYnurtU73uHg6IQeQma8C3YR2WT84STcDWWD/M1a1o=;
        b=LWMkDYoIAu0XBW6NEMh0r8tWiaoJpHvD2OELn49iTEdumtMO7hjHIcmG7vAiE1sNaF
         ifFOYdP/KtpXyPLqQtHOaXcYT4DobzhVgNYYUKgJHAuhK8rZ8+Y2NBMkRL51dot0X00R
         g5ZdkbkZeYOI7xev1zwimbsKBAXyWY5cOUjVA/QeF9805veDqVuprMT/h0CKwcPebGKh
         k20sDegQtzTX7ZLyp23jeEcIwdthr2BoX58AAlR8QDMT5IIuvvCGVyw9gyltoVVityFW
         5aFYOe4y5W3+gMF1OC2e9ik2bKIXKo5x7JznKW79TMzWsVhM13RlMQq5PhtQDgt5RGDG
         CrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328157; x=1712932957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyYnurtU73uHg6IQeQma8C3YR2WT84STcDWWD/M1a1o=;
        b=Kp7G6alZSrPIbOUjtoIbfiKNQF6mm3sGZwoiUgF5comIZRWDLT97RJTmKKwS/MNngL
         Rsr2ouaPU9hC/E4vN2AN3mQ2e4jnDObeOuPZ/GNXpkveUqfDSR0FlQprxFssPtB+mrxc
         uZiOQ2X2NXQxB0EhW2T7QhuxZ7csME09UjzjNrjaJyUtTAtLVTZuBppXiPEzU5diS8m2
         VjfiAMszh6AIUr4ugWU+eVUhKR7x5NY7l1fpX9mzoR8Kp/+gsiMSAmtRIaW+4frqvAHD
         lQA/L2kpVDz5wMQ561mJIId8hRsi6cY9yFyyenapH3RtyhXeB/5kqA+gjbJKN3LkD+P6
         BPSw==
X-Forwarded-Encrypted: i=1; AJvYcCXeEvZCCs7YDf5smn1cwx3KuCiFEDuC9ZpbzpOZNWQDswoX3wnh3n1NWe0WAgKRBbFMso2vTt5H/82lfIWSr9haGV11CXDxESyQhUr5
X-Gm-Message-State: AOJu0Yzg/0pdKGGx5OqYSC5t2K+NHoU5BguQ3BmTf7Zre6t0SNTXrJjR
	NeFl8LGkuoJ2P9O0QYk1aioiW+2PEFpT94gCfZiuh5xQ7ov/3SUHpqrQJEL2CTzHT69/u8D5uFv
	ZrQ==
X-Google-Smtp-Source: AGHT+IFZzAI5YHJ4GuFroUP31rDn7WEjwh0RSJNfXWW2SekjL9buA2AOsUO7OOZZHrNGXktXVssg9osoOjE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:124d:b0:6ec:fc60:b78d with SMTP id
 u13-20020a056a00124d00b006ecfc60b78dmr227981pfi.1.1712328156680; Fri, 05 Apr
 2024 07:42:36 -0700 (PDT)
Date: Fri, 5 Apr 2024 07:42:35 -0700
In-Reply-To: <ZhAAg8KNd8qHEGcO@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
 <ZhAAg8KNd8qHEGcO@tpad>
Message-ID: <ZhAN28BcMsfl4gm-@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 05, 2024, Marcelo Tosatti wrote:
> On Mon, Apr 01, 2024 at 01:21:25PM -0700, Sean Christopherson wrote:
> > On Thu, Mar 28, 2024, Leonardo Bras wrote:
> > > I am dealing with a latency issue inside a KVM guest, which is caused by
> > > a sched_switch to rcuc[1].
> > > 
> > > During guest entry, kernel code will signal to RCU that current CPU was on
> > > a quiescent state, making sure no other CPU is waiting for this one.
> > > 
> > > If a vcpu just stopped running (guest_exit), and a syncronize_rcu() was
> > > issued somewhere since guest entry, there is a chance a timer interrupt
> > > will happen in that CPU, which will cause rcu_sched_clock_irq() to run.
> > > 
> > > rcu_sched_clock_irq() will check rcu_pending() which will return true,
> > > and cause invoke_rcu_core() to be called, which will (in current config)
> > > cause rcuc/N to be scheduled into the current cpu.
> > > 
> > > On rcu_pending(), I noticed we can avoid returning true (and thus invoking
> > > rcu_core()) if the current cpu is nohz_full, and the cpu came from either
> > > idle or userspace, since both are considered quiescent states.
> > > 
> > > Since this is also true to guest context, my idea to solve this latency
> > > issue by avoiding rcu_core() invocation if it was running a guest vcpu.
> > > 
> > > On the other hand, I could not find a way of reliably saying the current
> > > cpu was running a guest vcpu, so patch #1 implements a per-cpu variable
> > > for keeping the time (jiffies) of the last guest exit.
> > > 
> > > In patch #2 I compare current time to that time, and if less than a second
> > > has past, we just skip rcu_core() invocation, since there is a high chance
> > > it will just go back to the guest in a moment.
> > 
> > What's the downside if there's a false positive?
> 
> rcuc wakes up (which might exceed the allowed latency threshold
> for certain realtime apps).

Isn't that a false negative? (RCU doesn't detect that a CPU is about to (re)enter
a guest)  I was trying to ask about the case where RCU thinks a CPU is about to
enter a guest, but the CPU never does (at least, not in the immediate future).

Or am I just not understanding how RCU's kthreads work?

> > > What I know it's weird with this patch:
> > > 1 - Not sure if this is the best way of finding out if the cpu was
> > >     running a guest recently.
> > > 
> > > 2 - This per-cpu variable needs to get set at each guest_exit(), so it's
> > >     overhead, even though it's supposed to be in local cache. If that's
> > >     an issue, I would suggest having this part compiled out on 
> > >     !CONFIG_NO_HZ_FULL, but further checking each cpu for being nohz_full
> > >     enabled seems more expensive than just setting this out.
> > 
> > A per-CPU write isn't problematic, but I suspect reading jiffies will be quite
> > imprecise, e.g. it'll be a full tick "behind" on many exits.
> > 
> > > 3 - It checks if the guest exit happened over than 1 second ago. This 1
> > >     second value was copied from rcu_nohz_full_cpu() which checks if the
> > >     grace period started over than a second ago. If this value is bad,
> > >     I have no issue changing it.
> > 
> > IMO, checking if a CPU "recently" ran a KVM vCPU is a suboptimal heuristic regardless
> > of what magic time threshold is used.  
> 
> Why? It works for this particular purpose.

Because maintaining magic numbers is no fun, AFAICT the heurisitic doesn't guard
against edge cases, and I'm pretty sure we can do better with about the same amount
of effort/churn.

> > IIUC, what you want is a way to detect if a CPU is likely to _run_ a KVM
> > vCPU in the near future.  KVM can provide that information with much better
> > precision, e.g. KVM knows when when it's in the core vCPU run loop.
> 
> ktime_t ktime_get(void)
> {
>         struct timekeeper *tk = &tk_core.timekeeper;
>         unsigned int seq;
>         ktime_t base;
>         u64 nsecs;
> 
>         WARN_ON(timekeeping_suspended);
> 
>         do {
>                 seq = read_seqcount_begin(&tk_core.seq);
>                 base = tk->tkr_mono.base;
>                 nsecs = timekeeping_get_ns(&tk->tkr_mono);
> 
>         } while (read_seqcount_retry(&tk_core.seq, seq));
> 
>         return ktime_add_ns(base, nsecs);
> }
> EXPORT_SYMBOL_GPL(ktime_get);
> 
> ktime_get() is more expensive than unsigned long assignment.

Huh?  What does ktime_get() have to do with anything?  I'm suggesting something
like the below (wants_to_run is from an in-flight patch,
https://lore.kernel.org/all/20240307163541.92138-1-dmatlack@google.com).

---
 include/linux/context_tracking.h       | 12 ++++++++++++
 include/linux/context_tracking_state.h |  3 +++
 kernel/rcu/tree.c                      |  9 +++++++--
 virt/kvm/kvm_main.c                    |  7 +++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 6e76b9dba00e..59bc855701c5 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -86,6 +86,16 @@ static __always_inline void context_tracking_guest_exit(void)
 		__ct_user_exit(CONTEXT_GUEST);
 }
 
+static inline void context_tracking_guest_start_run_loop(void)
+{
+	__this_cpu_write(context_tracking.in_guest_run_loop, true);
+}
+
+static inline void context_tracking_guest_stop_run_loop(void)
+{
+	__this_cpu_write(context_tracking.in_guest_run_loop, false);
+}
+
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
 #else
@@ -99,6 +109,8 @@ static inline int ct_state(void) { return -1; }
 static inline int __ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static __always_inline void context_tracking_guest_exit(void) { }
+static inline void context_tracking_guest_start_run_loop(void) { }
+static inline void context_tracking_guest_stop_run_loop(void) { }
 #define CT_WARN_ON(cond) do { } while (0)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bbff5f7f8803..629ada1a4d81 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -25,6 +25,9 @@ enum ctx_state {
 #define CT_DYNTICKS_MASK (~CT_STATE_MASK)
 
 struct context_tracking {
+#if IS_ENABLED(CONFIG_KVM)
+	bool in_guest_run_loop;
+#endif
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
 	 * When active is false, probes are unset in order
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..303ae9ae1c53 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3937,8 +3937,13 @@ static int rcu_pending(int user)
 	if (rcu_nocb_need_deferred_wakeup(rdp, RCU_NOCB_WAKE))
 		return 1;
 
-	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
-	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
+	/*
+	 * Is this a nohz_full CPU in userspace, idle, or likely to enter a
+	 * guest in the near future?  (Ignore RCU if so.)
+	 */
+	if ((user || rcu_is_cpu_rrupt_from_idle() ||
+	     __this_cpu_read(context_tracking.in_guest_run_loop)) &&
+	    rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bfb2b52a1416..5a7efc669a0f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -209,6 +209,9 @@ void vcpu_load(struct kvm_vcpu *vcpu)
 {
 	int cpu = get_cpu();
 
+	if (vcpu->wants_to_run)
+		context_tracking_guest_start_run_loop();
+
 	__this_cpu_write(kvm_running_vcpu, vcpu);
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -222,6 +225,10 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	__this_cpu_write(kvm_running_vcpu, NULL);
+
+	if (vcpu->wants_to_run)
+		context_tracking_guest_stop_run_loop();
+
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(vcpu_put);

base-commit: 619e56a3810c88b8d16d7b9553932ad05f0d4968
-- 



