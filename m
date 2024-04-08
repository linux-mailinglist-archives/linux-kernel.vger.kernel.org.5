Return-Path: <linux-kernel+bounces-135469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012AD89C532
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8EB1F23628
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271F7BAF7;
	Mon,  8 Apr 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Jq49BESc"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F06FE35
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584457; cv=none; b=ZTjonTGdrw2VuGNfvvgHZ2xANyK/mSbrvWxv5REBbv8RsA7/p6j8MSZdnwL3NMn51IH6DFF3qXZtrxquHUS8UWSmSDQseA58NWrHtSGGo++sY60mwAuUrRDL3seqmqRtpoN9eFAh2vtwkxlXjlLq+PN/rB8g40q6whI4ONP4ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584457; c=relaxed/simple;
	bh=gh4tpdih8esLI25MktXhFMkdTYnw/T/NHIj4HYT3EbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx/O1jpU5Wqqsgpxv0z/m4JFj3jSRa8T8f04pJ0FrUfxKO1RqAKXvpFh2jGdEbPE58TGO/FJpE7pjgP9WeuTFF67rA76i8vU/IMY8lQjBj07sWL/UwA+NkLitKe8/eCzg+54PhmNb3k8wxWZ988uxGHxg52rXRLdLGRN33j7Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Jq49BESc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so4126646276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1712584454; x=1713189254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6kKl1aVWYliHDaR8y7CAp1UicpeJTf7oqPqbEf20fQ=;
        b=Jq49BEScC06+wCNJ9QgSlmh7eHiZZ4IWSBL2RNFdYJ0mJ30HmdCibEUW6A/fBJtZUq
         vMZ2mFrksCGWwLM2NJ05c8PJ/5anSh8yDEwOYRtpMt20cS7r7IW/TgHQphYgJ93r+Fr3
         sjstIp3cNuyb2PJLAjI1ihbqkMbSLZPJqHpGLKxeLMClRmhSJv+AFoeAzAQsA+N/XTnD
         ZeahT5BAYxjpN5ufms7R09wfFb1yAkr9o4vEyAc/0ooiBOu8XBMDyWATiaY/6SiM2hgY
         qhhbB/4Nw/qm2ZQGF4tg6BhxbdQe++nnzfNqHCrbe7fDEskNMSqDEfEXm5qTbpjwJx4y
         kJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712584454; x=1713189254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6kKl1aVWYliHDaR8y7CAp1UicpeJTf7oqPqbEf20fQ=;
        b=Ct6yrXCbYRJaMjQFLso+GEycYjwps8ejP+sXy7nP87bJlegZn2x6vb/jGNDnUfxRy1
         vuhLlq/afa7KcFuALX47rHELoNtOGM25+snotBJM/L6tVRG1Pkr3ldl85CX85IeYyAaq
         ydE8Id/eKDYBPplc7foqoxlxE1ENHo/by9fjBf4HJi23p1NfOifiFv4lJSudQNWaQDbI
         vzxOMydpVvFxccSiiNIvhHpPMUzwX0+tDEZjwx9I4CF4tfTcMnV8NvcDKkDcnBGPw5re
         ZBrEUY3dAGGCO0HYA75x6HA/frWNjVhK53PVi5mr4sDebcPvyeMNqdrzt+5RHeRNpydA
         sd2w==
X-Forwarded-Encrypted: i=1; AJvYcCXM0rCRCqcVGyNlkn2oea5iJSTGhAwArVy47px4qVqD+2jvTLT0Yg13mTIy5oF2L1Kcbc3rBvUsMiP+uHFExzXnHWiVFcqaSb+4RRMw
X-Gm-Message-State: AOJu0Yxi3fkoxRH7F9vpXJQtNnjROFhwCvfDaDgAmAy8JvpnVB+cfg3i
	avdPpLGDM3XPv2VkgVHGSBUJDWN2b41zJOoTirXUTxvimIEc3xiaVt/RLdKEYh14a2c3rruyx7k
	VokNeP4Xyl1l9iheZnhpv+45r+1tS3zLlXWBVUA==
X-Google-Smtp-Source: AGHT+IH6aYXDJY7AtBiVf3L56XP6JRG4Itct4K0aXsB9PQJoxGQyOcejapCFG8ilC7sE1YFX78GSj6rciiivOwMMtq8=
X-Received: by 2002:a25:360a:0:b0:de0:e368:fa59 with SMTP id
 d10-20020a25360a000000b00de0e368fa59mr3644918yba.31.1712584453724; Mon, 08
 Apr 2024 06:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
In-Reply-To: <20240403140116.3002809-1-vineeth@bitbyteword.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 8 Apr 2024 09:54:03 -0400
Message-ID: <CAO7JXPiiN+w+Liuov3rXAbr1QLwt+eUq=4Weoy8gB0fXaC7D3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
To: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	David Vernet <dvernet@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I missed sched_ext folks, adding them as well.

Thanks,
Vineeth


On Wed, Apr 3, 2024 at 10:01=E2=80=AFAM Vineeth Pillai (Google)
<vineeth@bitbyteword.org> wrote:
>
> Double scheduling is a concern with virtualization hosts where the host
> schedules vcpus without knowing whats run by the vcpu and guest schedules
> tasks without knowing where the vcpu is physically running. This causes
> issues related to latencies, power consumption, resource utilization
> etc. An ideal solution would be to have a cooperative scheduling
> framework where the guest and host shares scheduling related information
> and makes an educated scheduling decision to optimally handle the
> workloads. As a first step, we are taking a stab at reducing latencies
> for latency sensitive workloads in the guest.
>
> v1 RFC[1] was posted in December 2023. The main disagreement was in the
> implementation where the patch was making scheduling policy decisions
> in kvm and kvm is not the right place to do it. The suggestion was to
> move the polcy decisions outside of kvm and let kvm only handle the
> notifications needed to make the policy decisions. This patch series is
> an iterative step towards implementing the feature as a layered
> design where the policy could be implemented outside of kvm as a
> kernel built-in, a kernel module or a bpf program.
>
> This design comprises mainly of 4 components:
>
> - pvsched driver: Implements the scheduling policies. Register with
>     host with a set of callbacks that hypervisor(kvm) can use to notify
>     vcpu events that the driver is interested in. The callback will be
>     passed in the address of shared memory so that the driver can get
>     scheduling information shared by the guest and also update the
>     scheduling policies set by the driver.
> - kvm component: Selects the pvsched driver for a guest and notifies
>     the driver via callbacks for events that the driver is interested
>     in. Also interface with the guest in retreiving the shared memory
>     region for sharing the scheduling information.
> - host kernel component: Implements the APIs for:
>     - pvsched driver for register/unregister to the host kernel, and
>     - hypervisor for assingning/unassigning driver for guests.
> - guest component: Implements a framework for sharing the scheduling
>     information with the pvsched driver through kvm.
>
> There is another component that we refer to as pvsched protocol. This
> defines the details about shared memory layout, information sharing and
> sheduling policy decisions. The protocol need not be part of the kernel
> and can be defined separately based on the use case and requirements.
> Both guest and the selected pvsched driver need to match the protocol
> for the feature to work. Protocol shall be identified by a name and a
> possible versioning scheme. Guest will advertise the protocol and then
> the hypervisor can assign the driver implementing the protocol if it is
> registered in the host kernel.
>
> This patch series only implements the first 3 components. Guest side
> implementation and the protocol framework shall come as a separate
> series once we finalize rest of the design.
>
> This series also implements a sample bpf program and a kernel-builtin
> pvsched drivers. They do not do any real stuff now, but just skeletons
> to demonstrate the feature.
>
> Rebased on 6.8.2.
>
> [1]: https://lwn.net/Articles/955145/
>
> Vineeth Pillai (Google) (5):
>   pvsched: paravirt scheduling framework
>   kvm: Implement the paravirt sched framework for kvm
>   kvm: interface for managing pvsched driver for guest VMs
>   pvsched: bpf support for pvsched
>   selftests/bpf: sample implementation of a bpf pvsched driver.
>
>  Kconfig                                       |   2 +
>  arch/x86/kvm/Kconfig                          |  13 +
>  arch/x86/kvm/x86.c                            |   3 +
>  include/linux/kvm_host.h                      |  32 +++
>  include/linux/pvsched.h                       | 102 +++++++
>  include/uapi/linux/kvm.h                      |   6 +
>  kernel/bpf/bpf_struct_ops_types.h             |   4 +
>  kernel/sysctl.c                               |  27 ++
>  .../testing/selftests/bpf/progs/bpf_pvsched.c |  37 +++
>  virt/Makefile                                 |   2 +-
>  virt/kvm/kvm_main.c                           | 265 ++++++++++++++++++
>  virt/pvsched/Kconfig                          |  12 +
>  virt/pvsched/Makefile                         |   2 +
>  virt/pvsched/pvsched.c                        | 215 ++++++++++++++
>  virt/pvsched/pvsched_bpf.c                    | 141 ++++++++++
>  15 files changed, 862 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/pvsched.h
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_pvsched.c
>  create mode 100644 virt/pvsched/Kconfig
>  create mode 100644 virt/pvsched/Makefile
>  create mode 100644 virt/pvsched/pvsched.c
>  create mode 100644 virt/pvsched/pvsched_bpf.c
>
> --
> 2.40.1
>

