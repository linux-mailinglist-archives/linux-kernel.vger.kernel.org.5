Return-Path: <linux-kernel+bounces-166518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A58B9BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB41C20DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87713C677;
	Thu,  2 May 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="qZOaPVLi"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF883CB0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657346; cv=none; b=s1DXz69k6FjEmdyND2gyxF/FKk0ZPP4QpIzgorJav9se/al+4jFwxAA2wgcm9UHIetLx1HJYAC24sFQuVwk9AQLr4HSNw39OBbEB1mlqIRuaOj2j+Ehz6W1SAbBUgFdvkPMdD1g0cJVm24WesDqGpRf0eSa2gnyBm3XqYeEXl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657346; c=relaxed/simple;
	bh=SLRzQD5AsgDseYB/nxQ58MxT4LBQkF1v4GlY4FKg0Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1t9BtpNjUId0hvjT6Z7y4jzmZon+pGPyt5u2XfCpnlLNZmoYtitKU2oG8IDuYwFil8rmmT/WcENrhn6fkpSugoE8J72tU+QckMfa/h00/Dvtf8ZIaJmXCr182quGqtK1ElliNKaZ4sH7e1qAhcOQ3e8MLQWbLRYgQWfmbFvgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=qZOaPVLi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1686651276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1714657343; x=1715262143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OG16h4gDfjf12bjFBJho4mOM91utMUshQv1Ztl+0vXQ=;
        b=qZOaPVLi+XrtByHcvJdfGJDfbC1KGyY0UmEIHqdnVMeiTGndUdJ0fj1tUIN2cnVD3y
         zswuNFBnO4TBCdSohRpVwdXrAo/ojLJB9jsGRvYKO2CtPo8a8FOto7die+Agve0dMHSJ
         +nbjHmW+H9sXIhHbCNGXBX3kXDaM0asH+ionKy+p8+E+Pbwxk3SDXOqLnhxeFOrQDCOO
         EiGj1bkl9xaKICXTFgeBz0Kfsy8B7NRwV7fNQBo4TnnrtVgC5orlfqx88EWpY15pUS44
         HhTybxkcw3pH0gsOiIoFQozZ8GBLDfptNFbpUPHRjhyreQmhsh6UoNXwTZgo7hkQeeJP
         JFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657343; x=1715262143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG16h4gDfjf12bjFBJho4mOM91utMUshQv1Ztl+0vXQ=;
        b=QTrZS0Pmj6qTqAY+xJj9EBnq/I0TdRTm3fPgkFG0I8pG4ce5aU4NxJuiR3MeoJKJFm
         6Wmdu/zHs+mQReJVnHfVH0jJ9/f1rxIRRun9C92MHf4lIk4QJTId/F3LzYvD/S13I5Eg
         A9tqqJfeT83jLIbNv16LIWuUT60Kx5ZdUuo0X9v3ABoJdzROyQNQIQViu8x6Fj4kh+3f
         vPtfawm5wizDMpzUbfn+BaVyiwHalK3jcYb9JWDWWQs3Ez1ph7apDkxHfgKz0JVdB7GL
         9LE3nEe/6LuViUDwdV8pjS2xNwUOJvjlFWvDx4a7U9q8qJ7ucKYYR7p3IDXydhJtzNMu
         oJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCX+K/4vTYq9cnIDrJfS4CwoZAY5xZDlVWysbrHN60pR1D+NTBbWtR3Qqsa7x21INtWXwOjnlgDJx0g7r1gYutUDx7EWKxMXdWVtdmaP
X-Gm-Message-State: AOJu0YzmCH4peyJ61+TU3C9vT896+8k0Pmc7F3fnijby/svYgDKTKZJR
	nmxM8s1NhaOPah7SG81FjUAbMaR/yD/4QxB/gO2N2IgEnPUNshtkNcoFQjeTTRUfdhv6NlN2mHD
	eCbDbpChidfgNh0TiQvP1eiSNduKxK8YfCGU4RA==
X-Google-Smtp-Source: AGHT+IHYsIzKk2iLG+mvbmOXPtNOuGgRxSHPX8lPvf4mCbUUBkrx2pt66ca9v2IIMPdVehoWI/yc7QOogtV6kap51iU=
X-Received: by 2002:a05:6902:1585:b0:de6:12f0:b675 with SMTP id
 k5-20020a056902158500b00de612f0b675mr1916700ybu.12.1714657343030; Thu, 02 May
 2024 06:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org> <ZjJf27yn-vkdB32X@google.com>
In-Reply-To: <ZjJf27yn-vkdB32X@google.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 2 May 2024 09:42:12 -0400
Message-ID: <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
To: Sean Christopherson <seanjc@google.com>
Cc: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > This design comprises mainly of 4 components:
> >
> > - pvsched driver: Implements the scheduling policies. Register with
> >     host with a set of callbacks that hypervisor(kvm) can use to notify
> >     vcpu events that the driver is interested in. The callback will be
> >     passed in the address of shared memory so that the driver can get
> >     scheduling information shared by the guest and also update the
> >     scheduling policies set by the driver.
> > - kvm component: Selects the pvsched driver for a guest and notifies
> >     the driver via callbacks for events that the driver is interested
> >     in. Also interface with the guest in retreiving the shared memory
> >     region for sharing the scheduling information.
> > - host kernel component: Implements the APIs for:
> >     - pvsched driver for register/unregister to the host kernel, and
> >     - hypervisor for assingning/unassigning driver for guests.
> > - guest component: Implements a framework for sharing the scheduling
> >     information with the pvsched driver through kvm.
>
> Roughly summarazing an off-list discussion.
>
>  - Discovery schedulers should be handled outside of KVM and the kernel, e.g.
>    similar to how userspace uses PCI, VMBUS, etc. to enumerate devices to the guest.
>
>  - "Negotiating" features/hooks should also be handled outside of the kernel,
>    e.g. similar to how VirtIO devices negotiate features between host and guest.
>
>  - Pushing PV scheduler entities to KVM should either be done through an exported
>    API, e.g. if the scheduler is provided by a separate kernel module, or by a
>    KVM or VM ioctl() (especially if the desire is to have per-VM schedulers).
>
> I think those were the main takeaways?  Vineeth and Joel, please chime in on
> anything I've missed or misremembered.
>
Thanks for the brief about the offlist discussion, all the points are
captured, just some minor additions. v2 implementation removed the
scheduling policies outside of kvm to a separate entity called pvsched
driver and could be implemented as a kernel module or bpf program. But
the handshake between guest and host to decide on what pvsched driver
to attach was still going through kvm. So it was suggested to move
this handshake(discovery and negotiation) outside of kvm. The idea is
to have a virtual device exposed by the VMM which would take care of
the handshake. Guest driver for this device would talk to the device
to understand the pvsched details on the host and pass the shared
memory details. Once the handshake is completed, the device is
responsible for loading the pvsched driver(bpf program or kernel
module responsible for implementing the policies). The pvsched driver
will register to the trace points exported by kvm and handle the
callbacks from then on. The scheduling will be taken care of by the
host scheduler, pvsched driver on host is responsible only for setting
the policies(placement, priorities etc).

With the above approach, the only change in kvm would be the internal
tracepoints for pvsched. Host kernel will also be unchanged and all
the complexities move to the VMM and the pvsched driver. Guest kernel
will have a new driver to talk to the virtual pvsched device and this
driver would hook into the guest kernel for passing scheduling
information to the host(via tracepoints).

> The other reason I'm bringing this discussion back on-list is that I (very) briefly
> discussed this with Paolo, and he pointed out the proposed rseq-based mechanism
> that would allow userspace to request an extended time slice[*], and that if that
> landed it would be easy-ish to reuse the interface for KVM's steal_time PV API.
>
> I see that you're both on that thread, so presumably you're already aware of the
> idea, but I wanted to bring it up here to make sure that we aren't trying to
> design something that's more complex than is needed.
>
> Specifically, if the guest has a generic way to request an extended time slice
> (or boost its priority?), would that address your use cases?  Or rather, how close
> does it get you?  E.g. the guest will have no way of requesting a larger time
> slice or boosting priority when an event is _pending_ but not yet receiveed by
> the guest, but is that actually problematic in practice?
>
> [*] https://lore.kernel.org/all/20231025235413.597287e1@gandalf.local.home
>
Thanks for bringing this up. We were also very much interested in this
feature and were planning to use the pvmem shared memory  instead of
rseq framework for guests. The motivation of paravirt scheduling
framework was a bit broader than the latency issues and hence we were
proposing a bit more complex design. Other than the use case for
temporarily extending the time slice of vcpus, we were also looking at
vcpu placements on physical cpus, educated decisions that could be
made by guest scheduler if it has a picture of host cpu load etc.
Having a paravirt mechanism to share scheduling information would
benefit in such cases. Once we have this framework setup, the policy
implementation on guest and host could be taken care of by other
entities like BPF programs, modules or schedulers like sched_ext.

We are working on a v3 incorporating the above ideas and would shortly
be posting a design RFC soon. Thanks for all the help and inputs on
this.

Thanks,
Vineeth

