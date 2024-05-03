Return-Path: <linux-kernel+bounces-168105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429318BB3BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9131F257B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78667158864;
	Fri,  3 May 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFr4cGmd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4A134B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763372; cv=none; b=MUjDeLBpkbvmNcPcWIEunWfjuFjyDfYN3X02NLPWsay9l06IPWUEFPnv53f0QEUENn+IepanzoVBE7br4hhTvDfxZ5+wnBMxgNPgK1yjSiZmJDz6JANgZwZHZRukv4V2pJJCMphS9qY55PEpmexk+noOvv85IXcYw+q4kedpVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763372; c=relaxed/simple;
	bh=bsUrJhJStA4jT+oy/+6b0aay9cjl1X4e2u6wD2HnNMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VfMZe6u1OlLN3OhLOYhnpoC4h1yKTvJvwsQ4/tuKmoln8bBVjDfpjnAMuxyvPT7H50wSrAN+drZ2a3SguQ9XXnHwflpSfV/XNamHusd1DZzubEIe97fiS7Bn8rAAefPB5Q4byXHcFBDqdadDVesCyDb92x4CRqBa66yLNbBobTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFr4cGmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714763369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfZIeLovJ0OEc5o8V4rjdfq75IXpLSkl12OeDfEK/CA=;
	b=fFr4cGmdC1BsP/P5ZNK1nF92Jz/S9EnSTO20+0LXCBbavG0neV2HKJv546aV2PmhLj6U9J
	aNUQXZ8up/6VvHFkH4ihImO2YXMZU74gZDWbK6UN/s3BzzncTA1DKPonPRWPUBf1Zy5XB4
	FcYLnHQzUcecdQ9kyxCd1lg3tpvFYC0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-1Zs007PPPBqIoOw8qHtFng-1; Fri, 03 May 2024 15:09:28 -0400
X-MC-Unique: 1Zs007PPPBqIoOw8qHtFng-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79265613c9dso472126685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763368; x=1715368168;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfZIeLovJ0OEc5o8V4rjdfq75IXpLSkl12OeDfEK/CA=;
        b=OhmXe9Luhv7kf3/h6u1jytCzTzKiCP9ZHP9ZF6CV7GLELR2tkPaZn5ZzvI3ilIxLk5
         5QZT/LZHnlWOPFcjGePaUTJkfAsW7R/hNc5fjr0AbMBj+OJGQx4ZrutPYRlneV2SbgjC
         b33FBfXmJE8S59WAbmGzbhwFEugD599zITOpi1Js+WJ4YGzZRfDbbRbVDExin11OdoSj
         ccy/uLcdCk3VS8wl2d4vEDkie/cgNiRl7qwYqdyu1TxOu3oXycEhwaKKGtd6KhCy1eF0
         Luq7FKgHVNCo7uJeH4vrOTJDypXgXL9GOIOaHnXu7k2vuGsoycX+Ub1HNK9wOUo8odvD
         aHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1yyFMdMov9YwIPFMluSa7pjITGPBZA+04jdN+qTFxtY7xpfOY6+M2ixY3YI25OLBNKa51enXTzmobsgY4sNWf8bvmesG5l74Q7U/y
X-Gm-Message-State: AOJu0YzO6mJZFNeX0r7SET8eBLUmWovs8G//INzK+ZkSOgeOeZgVPM2p
	DVKlmTCg5tbM0P7nIsYq86L8KCl3XhZDhBkUPog8vMvXwd04hFpA9wVCK3YiIeKR3Qh4IsvIR+Q
	qUGgoVdx68R/PITGkERZohEQl3m6DtwHZ5tqbKbivaXUUm9UktwmIbjgUTYqJEw==
X-Received: by 2002:a05:620a:94f:b0:790:889a:b0bf with SMTP id w15-20020a05620a094f00b00790889ab0bfmr3242094qkw.68.1714763367385;
        Fri, 03 May 2024 12:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTE830hUw/0R/ym9W+rRW5RyC1bGCw2240Vz0MzxC88ZmdjC2YDSooo47VCYmf1D/6skjp6w==
X-Received: by 2002:a05:620a:94f:b0:790:889a:b0bf with SMTP id w15-20020a05620a094f00b00790889ab0bfmr3242072qkw.68.1714763367005;
        Fri, 03 May 2024 12:09:27 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a04e900b0078d5a756e61sm1464486qkh.60.2024.05.03.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:09:26 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Fri,  3 May 2024 16:09:11 -0300
Message-ID: <ZjU2VxZe3A9_Y7Yf@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZjUwHvyvkM3lj80Q@LeoBras>
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com> <ZjUwHvyvkM3lj80Q@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 03, 2024 at 03:42:38PM -0300, Leonardo Bras wrote:
> Hello Sean, Marcelo and Paul,
> 
> Thank you for your comments on this thread!
> I will try to reply some of the questions below:
> 
> (Sorry for the delay, I was OOO for a while.)
> 
> 
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
> False positive being guest_exit without going back in this CPU, right?
> If so in WSC, supposing no qs happens and there is a pending request, RCU 
> will take a whole second to run again, possibly making other CPUs wait 
> this long for a synchronize_rcu.

Just to make sure it's clear:
It will wait at most 1 second, if the grace period was requested just 
before the last_guest_exit update. It will never make the grace period 
be longer than the already defined 1 second. 

That's because in the timer interrupt we have:

	if (rcu_pending())
		invoke_rcu_core();

and on rcu_pending():

	if ((user || rcu_is_cpu_rrupt_from_idle() || rcu_recent_guest_exit()) &&
	    rcu_nohz_full_cpu())
		return 0;

Meaning that even if we allow 5 seconds after recent_guest_exit, it will 
only make rcu_nohz_full_cpu() run, and it will check if the grace period is 
younger than 1 second before skipping the rcu_core() invocation.



> 
> This value (1 second) could defined in .config or as a parameter if needed, 
> but does not seem a big deal, 
> 
> > 
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
> 
> That would not be a problem, as it would mean 1 tick less waiting in the 
> false positive WSC, and the 1s amount is plenty.

s/less/more/

> 
> > 
> > > 3 - It checks if the guest exit happened over than 1 second ago. This 1
> > >     second value was copied from rcu_nohz_full_cpu() which checks if the
> > >     grace period started over than a second ago. If this value is bad,
> > >     I have no issue changing it.
> > 
> > IMO, checking if a CPU "recently" ran a KVM vCPU is a suboptimal heuristic regardless
> > of what magic time threshold is used.  IIUC, what you want is a way to detect if
> > a CPU is likely to _run_ a KVM vCPU in the near future.
> 
> That's correct!
> 
> >  KVM can provide that
> > information with much better precision, e.g. KVM knows when when it's in the core
> > vCPU run loop.
> 
> That would not be enough.
> I need to present the application/problem to make a point:
> 
> - There is multiple  isolated physical CPU (nohz_full) on which we want to 
>   run KVM_RT vcpus, which will be running a real-time (low latency) task.
> - This task should not miss deadlines (RT), so we test the VM to make sure 
>   the maximum latency on a long run does not exceed the latency requirement
> - This vcpu will run on SCHED_FIFO, but has to run on lower priority than
>   rcuc, so we can avoid stalling other cpus.
> - There may be some scenarios where the vcpu will go back to userspace
>   (from KVM_RUN ioctl), and that does not mean it's good to interrupt the 
>   this to run other stuff (like rcuc).
> 
> Now, I understand it will cover most of our issues if we have a context 
> tracking around the vcpu_run loop, since we can use that to decide not to 
> run rcuc on the cpu if the interruption hapenned inside the loop.
> 
> But IIUC we can have a thread that "just got out of the loop" getting 
> interrupted by the timer, and asked to run rcu_core which will be bad for 
> latency.
> 
> I understand that the chance may be statistically low, but happening once 
> may be enough to crush the latency numbers.
> 
> Now, I can't think on a place to put this context trackers in kvm code that 
> would avoid the chance of rcuc running improperly, that's why the suggested 
> timeout, even though its ugly.
> 
> About the false-positive, IIUC we could reduce it if we reset the per-cpu 
> last_guest_exit on kvm_put.
> 
> > 
> > > 4 - Even though I could detect no issue, I included linux/kvm_host.h into 
> > >     rcu/tree_plugin.h, which is the first time it's getting included
> > >     outside of kvm or arch code, and can be weird.
> > 
> > Heh, kvm_host.h isn't included outside of KVM because several architectures can
> > build KVM as a module, which means referencing global KVM varibles from the kernel
> > proper won't work.
> > 
> > >     An alternative would be to create a new header for providing data for
> > >     non-kvm code.
> > 
> > I doubt a new .h or .c file is needed just for this, there's gotta be a decent
> > landing spot for a one-off variable.
> 
> You are probably right
> 
> >  E.g. I wouldn't be at all surprised if there
> > is additional usefulness in knowing if a CPU is in KVM's core run loop and thus
> > likely to do a VM-Enter in the near future, at which point you could probably make
> > a good argument for adding a flag in "struct context_tracking".  Even without a
> > separate use case, there's a good argument for adding that info to context_tracking.
> 
> For the tracking solution, makes sense :)
> Not sure if the 'timeout' alternative will be that useful outside rcu.
> 
> Thanks!
> Leo


