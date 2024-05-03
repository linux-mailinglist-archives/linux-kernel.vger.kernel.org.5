Return-Path: <linux-kernel+bounces-168201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E58BB506
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D71C23051
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF146521;
	Fri,  3 May 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijOMoo8U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DE2E83F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769077; cv=none; b=pmqQj2pBqkHcmONJGcmTzg/D7Po2jMuOZbtzUuwqGBingiVKLNGmXX7h5MCMh/1FxdtDB+cqn+tPDVyUnqjJtETUwe0tZHIsRjwcbrYtYD4x4ZrmT7WaoUHpPt4yYdyxb4DArWHsocqMBR6IrLtDybcDRZZjX1q+YxNV+SPYz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769077; c=relaxed/simple;
	bh=JzRjkCX97QxPT+mb9uzryASAmrChjV0ADLlSGccLdJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=I9uSHFCfSLTFuAXvkLgF8vKTn9OqXo0Gdn5LIrdkQ2qfA9L3aHJRDTjxoWfYS0Ys/kl1VaHEE8KetcrwbZ1p/6rNvgobrzA5EwSPoy5iPQ0mgv5O02eykWR/h4orox6sQ3CKCdQv8o+KkKNI01D9fXDOHKGUqjUEytklo4Cxxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijOMoo8U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714769074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPCuy2UEuVN4pMmMZGfLyGZGFO30PUf2umTvt3R4wAg=;
	b=ijOMoo8UtLMwtWL0xW5/cRlG3vhDkOBQxXYwgbc7DlmPLGmXet5G9KAbvrhoLmQtZyt0/5
	XZC1y1vB/LAt/i3cvF8ZcMElSbn//Ydp9pnfu+KmJp9gv5dUGeyXV9gzBJc5y6UNnGm7HY
	Y8DJb1cWMqC+I/aPVJVCwB4KnX8Ud/4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-1LsOsQZyPcWbuTJW6atHAg-1; Fri, 03 May 2024 16:44:32 -0400
X-MC-Unique: 1LsOsQZyPcWbuTJW6atHAg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-790f61b870dso5681785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714769071; x=1715373871;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPCuy2UEuVN4pMmMZGfLyGZGFO30PUf2umTvt3R4wAg=;
        b=VVP0VHWNd/SDWm1yQZ5fEo23o3NS0XiFrPZVq4PZEFojsAyuDh79rsc4aY/Bpm1/5o
         zj6LP1p7iT8M/y53FBSOvZWFrLQFJmcEEVllYhygeL0ZM+7tQO7D8C4mzcXylTbAabuc
         vfz62ZAs47XZKGMfhADDvbR+Mrp+r+jOgyV9nVQKLcmkadEzx9lGpwpfDCHubaGtbJCA
         NYlw/MGNab9oU6rPLbkFkGavvzRAdlM1ElUfjRFrg4PUsfM2biWndxf0A9+UxKs8EdQL
         1LPwSeEKIECxMJTBdQ1QjJEhWp82wEEZDeCMLlwumxyxLs9Gcg2WCIELxO11GHIHfhom
         5Iyw==
X-Forwarded-Encrypted: i=1; AJvYcCWPnUOUrNghI7hx6qAokS+MdJPVIHxM1twkC+mH9UmVUu64wc/xuY/jggs82umNpAfFFFEwUMk7N/eU3nmhv6tfwtk6eSOx1WS0pg8Z
X-Gm-Message-State: AOJu0Yx44niuT/66ZIneE1mUR7KRfXKnfQfLUCsVX8YtD4LcML1dNpGO
	oB+ipM7pr1Nw+psZSGgRfuw8GZGHs6c3iqwdU9r1ovPoMBcfRhpKKXSKyb6iLEeljIViPgZ+k05
	jn+npFLtgsQy+3DAd7xP4fx3dcJhckXEz3XqmmMiUW3QxltyLRhl/6654JIDNl3CICxO4UA==
X-Received: by 2002:a05:620a:3713:b0:78f:405:95ea with SMTP id de19-20020a05620a371300b0078f040595eamr4007226qkb.20.1714769071217;
        Fri, 03 May 2024 13:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4AcQehl9JUPoSGXujIYRwTeelKr+7ueA7bjBtN6ZPAq3O3bweRVjLuqFV+C/OKibQLDOZyw==
X-Received: by 2002:a05:620a:3713:b0:78f:405:95ea with SMTP id de19-20020a05620a371300b0078f040595eamr4007202qkb.20.1714769070805;
        Fri, 03 May 2024 13:44:30 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id vq17-20020a05620a559100b0078ec8690764sm1532578qkn.87.2024.05.03.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:44:30 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Fri,  3 May 2024 17:44:22 -0300
Message-ID: <ZjVMpj7zcSf-JYd_@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZiAFSlZwxyKzOTRL@google.com>
References: <ZhAAg8KNd8qHEGcO@tpad> <ZhAN28BcMsfl4gm-@google.com> <a7398da4-a72c-4933-bb8b-5bc8965d96d0@paulmck-laptop> <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad> <Zh2cPJ-5xh72ojzu@google.com> <Zh5w6rAWL+08a5lj@tpad> <Zh6GC0NRonCpzpV4@google.com> <Zh/1U8MtPWQ/yN2T@tpad> <ZiAFSlZwxyKzOTRL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 17, 2024 at 10:22:18AM -0700, Sean Christopherson wrote:
> On Wed, Apr 17, 2024, Marcelo Tosatti wrote:
> > On Tue, Apr 16, 2024 at 07:07:32AM -0700, Sean Christopherson wrote:
> > > On Tue, Apr 16, 2024, Marcelo Tosatti wrote:
> > > > > Why not have
> > > > > KVM provide a "this task is in KVM_RUN" flag, and then let the existing timeout
> > > > > handle the (hopefully rare) case where KVM doesn't "immediately" re-enter the guest?
> > > > 
> > > > Do you mean something like:
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index d9642dd06c25..0ca5a6a45025 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3938,7 +3938,7 @@ static int rcu_pending(int user)
> > > >                 return 1;
> > > >  
> > > >         /* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> > > > -       if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> > > > +       if ((user || rcu_is_cpu_rrupt_from_idle() || this_cpu->in_kvm_run) && rcu_nohz_full_cpu())
> > > >                 return 0;
> > > 
> > > Yes.  This, https://lore.kernel.org/all/ZhAN28BcMsfl4gm-@google.com, plus logic
> > > in kvm_sched_{in,out}().
> > 
> > Question: where is vcpu->wants_to_run set? (or, where is the full series
> > again?).
> 
> Precisely around the call to kvm_arch_vcpu_ioctl_run().  I am planning on applying
> the patch that introduces the code for 6.10[*], I just haven't yet for a variety
> of reasons.
> 
> [*] https://lore.kernel.org/all/20240307163541.92138-1-dmatlack@google.com
> 
> > So for guest HLT emulation, there is a window between
> > 
> > kvm_vcpu_block -> fire_sched_out_preempt_notifiers -> vcpu_put 
> > and the idle's task call to ct_cpuidle_enter, where 
> > 
> > ct_dynticks_nesting() != 0 and vcpu_put has already executed.
> > 
> > Even for idle=poll, the race exists.
> 
> Is waking rcuc actually problematic?

Yeah, it may introduce a lot (30us) of latency in some cases, causing a 
missed deadline.

When dealing with RT tasks, missing a deadline can be really bad, so we 
need to make sure it will happen as rarely as possible.

>  I agree it's not ideal, but it's a smallish
> window, i.e. is unlikely to happen frequently, and if rcuc is awakened, it will
> effectively steal cycles from the idle thread, not the vCPU thread.

It would be fine, but sometimes the idle thread will run very briefly, and 
stealing microseconds from it will still steal enough time from the vcpu 
thread to become a problem.

>  If the vCPU
> gets a wake event before rcuc completes, then the vCPU could experience jitter,
> but that could also happen if the CPU ends up in a deep C-state.

IIUC, if the scenario calls for a very short HLT, which is kind of usual, 
then the CPU will not get into deep C-state. 
For the scenarios longer HLT happens, then it would be fine.

> 
> And that race exists in general, i.e. any IRQ that arrives just as the idle task
> is being scheduled in will unnecessarily wakeup rcuc.

That's a race could be solved with the timeout (snapshot) solution, if we 
don't zero last_guest_exit on kvm_sched_out(), right?

> 
> > > >         /* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > 
> > > > The problem is:
> > > > 
> > > > 1) You should only set that flag, in the VM-entry path, after the point
> > > > where no use of RCU is made: close to guest_state_enter_irqoff call.
> > > 
> > > Why?  As established above, KVM essentially has 1 second to enter the guest after
> > > setting in_guest_run_loop (or whatever we call it).  In the vast majority of cases,
> > > the time before KVM enters the guest can probably be measured in microseconds.
> > 
> > OK.
> > 
> > > Snapshotting the exit time has the exact same problem of depending on KVM to
> > > re-enter the guest soon-ish, so I don't understand why this would be considered
> > > a problem with a flag to note the CPU is in KVM's run loop, but not with a
> > > snapshot to say the CPU recently exited a KVM guest.
> > 
> > See the race above.
> 
> Ya, but if kvm_last_guest_exit is zeroed in kvm_sched_out(), then the snapshot
> approach ends up with the same race.  And not zeroing kvm_last_guest_exit is
> arguably much more problematic as encountering a false positive doesn't require
> hitting a small window.

For the false positive (only on nohz_full) the maximum delay for the  
rcu_core() to be run would be 1s, and that would be in case we don't schedule out for 
some userspace task or idle thread, in which case we have a quiescent state 
without the need of rcu_core().

Now, for not being an userspace nor idle thread, it would need to be one or 
more kernel threads, which I suppose aren't usually many, nor usually 
take that long for completing, if we consider to be running on an isolated (nohz_full) cpu. 

So, for the kvm_sched_out() case, I don't actually think we are  
statistically introducing that much of a delay in the RCU mechanism.

(I may be missing some point, though)

Thanks!
Leo

> 
> > > > 2) While handling a VM-exit, a host timer interrupt can occur before that,
> > > > or after the point where "this_cpu->in_kvm_run" is set to false.
> > > >
> > > > And a host timer interrupt calls rcu_sched_clock_irq which is going to
> > > > wake up rcuc.
> > > 
> > > If in_kvm_run is false when the IRQ is handled, then either KVM exited to userspace
> > > or the vCPU was scheduled out.  In the former case, rcuc won't be woken up if the
> > > CPU is in userspace.  And in the latter case, waking up rcuc is absolutely the
> > > correct thing to do as VM-Enter is not imminent.
> > > 
> > > For exits to userspace, there would be a small window where an IRQ could arrive
> > > between KVM putting the vCPU and the CPU actually returning to userspace, but
> > > unless that's problematic in practice, I think it's a reasonable tradeoff.
> > 
> > OK, your proposal looks alright except these races.
> > 
> > We don't want those races to occur in production (and they likely will).
> > 
> > Is there any way to fix the races? Perhaps cmpxchg?
> 
> I don't think an atomic switch from the vCPU task to the idle task is feasible,
> e.g. KVM would somehow have to know that the idle task is going to run next.
> This seems like something that needs a generic solution, e.g. to prevent waking
> rcuc if the idle task is in the process of being scheduled in.
> 


