Return-Path: <linux-kernel+bounces-133662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB189A70F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34721C212B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2F175557;
	Fri,  5 Apr 2024 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmIB9aOx"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFB17554D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354666; cv=none; b=ZHgLN98GUUImB+xYBi7iDw2ggqOiplR3fqAw7v1LnuAleDrXnJU8RDkKcFpDf+jt2EZuHA34yjkf0oUPoqIFx+exPCo0H28YNN4p5YdRfdHCMiixaVY2yNsJed0KmnpMfKZegmqrqjHHc7rxD0J79OAoAi03fJsYHTBi6VahJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354666; c=relaxed/simple;
	bh=3ozwbhvvmQMH/HqtEAnVYhdm4dpfr4GO8gu60e+SKRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7msTZJDwdFUw4PauZTgLzKUT6MZujCy/W6Ocd6aWDoAC4tH3W2AJHBJWbP8G8sdl2CcFt02lbhKgBmjBDy3nExz1ytPMvmxoTzvtYSgTHpjmJFUAIWpj2fTzQN7lThtOuWI/xvZsScRDeLDKdw9WQ0hJUejofH5D3R5oiANV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmIB9aOx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-369de5d5833so13085ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712354663; x=1712959463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYg/cohccThrETIY2rOcIdkjzZTkorKuffC7jTSrYuY=;
        b=AmIB9aOxrEitVl4WXR9IL/GHt7ryrz/oLYNxKjUD4Tc+kwnW/Lgcfhyg/bXP82YtgC
         uYW8ATlg0vTmgJ4pfzwtM0+oc7Mg8XgRwQ1zQmJ1YLKOfxdnQg+XSLTJ5iIISShhNPBc
         CuSTwqYzRFPILE6iDvdFvijsUkU63OJoAz8AnGay8BXRydtHHDakzkrWE7CG4gA/K6J1
         JORXacVUIsBh0BbxhWFBTRT/DZf3hZz8ruWicJA+haNOGxG15e0mV22Y81EqcoeNc/pe
         jHub87a/h3IS4MLb64KcRcEJ2NP8OgdPSBGP59vosXBGxf1JhfT8TX4RqsFTJ0E2eBgQ
         mwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712354663; x=1712959463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYg/cohccThrETIY2rOcIdkjzZTkorKuffC7jTSrYuY=;
        b=MSn7Oc9lReN4Irr654szkvRV6DK6vDEa86ILFBcuS4mn8lsdqQUFJjb0XQkf8LlaJ6
         ZGeg6KNZIch+qTvFApibkoY7txxsoVXGsmveTyF2NhVJy5fOvGopgWiVgoYqwAuinh3P
         yM35/96BqzRnO6un8RU94/lvP7LUVbGCZ5aCt8rDUIM/UbHRiPENcH9Ah5yCHkSm16Tj
         cxt862hcThjkCZiRBdzeWDNPBNu9h7DJJ3pvHwgiBzuCLCTT7eEMhcb9jM5zsAo5uW2X
         JsNWyu8xyL+gTYJkUDZTqOe6pFOJr0jMw1ApZFg8+uYdgE5PCdQwPLFokRuMcu1Xuf/V
         mm5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWooXn7ayW51kYAQAeM3O9d95E+EIGsDoCzN3JaPBUrGPwuJMEpAfGsPlCDgXQeugj/kbL/wG97+7MmpPFpx/h0PbHcQ5KFip07NydB
X-Gm-Message-State: AOJu0YwLD/nzYNVQD2XnYMnWrKMUahLLVZqrr7y8Re5+knXUw7+Tm4Pd
	FQ5bpxkRI/j28IJV3KX4oCU92jcXBWy7VKgUr9XPmoqBFQE7YQHRIH5uJdKiXpDWS+G7y9vVSjb
	peoUg8YS7GG1me59ZCqU7NMD9Q/r25PPeF8oJ
X-Google-Smtp-Source: AGHT+IElSzrKp6E20aXvIWpuz80qCDUebvppshwjtKV04WR2Er3REspcLnfayOjystG2kbz3VFbbhE9bDB7nhqT6Sig=
X-Received: by 2002:a05:6e02:1a45:b0:36a:1201:c733 with SMTP id
 u5-20020a056e021a4500b0036a1201c733mr36689ilv.11.1712354663283; Fri, 05 Apr
 2024 15:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com> <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
In-Reply-To: <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 5 Apr 2024 15:04:11 -0700
Message-ID: <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Apr 4, 2024 at 4:09=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 3/25/2024 10:27 AM, Peter Newman wrote:
> > __resctrl_sched_in() is unable to dereference a struct rdtgroup pointer
> > when defined inline because rdtgroup is a private structure defined in
> > internal.h.
>
> Being inline has nothing to do with whether it can reference a struct rdt=
group
> pointer, no?

No, but it has a lot to do with whether it can de-reference a struct
rdtgroup pointer in order to obtain a CLOSID or RMID, as doing so
would pull the definitions for struct rdtgroup and struct mongroup
into an external header. Before doing so, I would want to make sure
implementing  __resctrl_sched_in() inline is actually adding value.

>
> >
> > This function is defined inline to avoid impacting context switch
> > performance for the majority of users who aren't using resctrl at all.
> > These benefits can already be realized without access to internal
> > resctrl data structures.
> >
> > The logic of performing an out-of-line call to __resctrl_sched_in() onl=
y
> > when resctrl is mounted is architecture-independent, so the inline
> > definition of resctrl_sched_in() can be moved into linux/resctrl.h.
> >
> > Signed-off-by: Peter Newman <peternewman@google.com>
>
> ...
>
> > diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.=
c
> > index 0917c7f25720..8f92a87d381d 100644
> > --- a/arch/x86/kernel/process_32.c
> > +++ b/arch/x86/kernel/process_32.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/io.h>
> >  #include <linux/kdebug.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/resctrl.h>
> >
> >  #include <asm/ldt.h>
> >  #include <asm/processor.h>
> > @@ -51,7 +52,6 @@
> >  #include <asm/debugreg.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/vm86.h>
> > -#include <asm/resctrl.h>
> >  #include <asm/proto.h>
> >
> >  #include "process.h"
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.=
c
> > index 7062b84dd467..d442269bb25b 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/iommu.h>
> > +#include <linux/resctrl.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/pkru.h>
>
> With a change like this we should be very careful about what is included =
when
> the kernel is not built with resctrl and in its current form linux/resctr=
l.h is
> not ready for this.
>
> If CONFIG_X86_CPU_RESCTRL is not set linux/resctrl.h should have the bare=
 minimum,
> just like asm/resctrl.h has.
>
> > @@ -53,7 +54,6 @@
> >  #include <asm/switch_to.h>
> >  #include <asm/xen/hypervisor.h>
> >  #include <asm/vdso.h>
> > -#include <asm/resctrl.h>
> >  #include <asm/unistd.h>
> >  #include <asm/fsgsbase.h>
> >  #include <asm/fred.h>
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index a365f67131ec..62d607939a73 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -304,4 +304,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resour=
ce *r, struct rdt_domain *d);
> >  extern unsigned int resctrl_rmid_realloc_threshold;
> >  extern unsigned int resctrl_rmid_realloc_limit;
> >
> > +DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
> > +
> > +void __resctrl_sched_in(struct task_struct *tsk);
> > +
> > +/*
> > + * resctrl_sched_in() - Assigns the incoming task's control/monitor ID=
s to the
> > + *                   current CPU
> > + *
> > + * To minimize impact to the scheduler hot path, this will stay as no-=
op unless
> > + * running on a system supporting resctrl and the filesystem is mounte=
d.
> > + *
> > + * Must be called with preemption disabled.
> > + */
> > +static inline void resctrl_sched_in(struct task_struct *tsk)
> > +{
> > +#ifdef CONFIG_X86_CPU_RESCTRL
> > +     if (static_branch_likely(&rdt_enable_key))
> > +             __resctrl_sched_in(tsk);
> > +#endif
> > +}
> > +
>
> include/linux/resctrl.h should rather be divided to accommodate code
> as below:
>
> #ifdef CONFIG_X86_CPU_RESCTRL
>
> static inline void resctrl_sched_in(struct task_struct *tsk)
> {
>         if (static_branch_likely(&rdt_enable_key))
>                 __resctrl_sched_in(tsk);
> }
>
> #else
>
> static inline void resctrl_sched_in(struct task_struct *tsk) {}
>
> #endif
>
> so that core code does not get anything unnecessary when CONFIG_X86_CPU_R=
ESCTRL
> is not set.

Will do.

Thanks!
-Peter

