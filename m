Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804337C8DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjJMTaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:30:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803095
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:30:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso3654101a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697225425; x=1697830225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7YdfjA2Rn+ebSTRqrkT9q3F9XpUUdA06iSoUXPeWbo=;
        b=TaiUMRc3XdGGtDe9ud22kfOghvz5kF9n5WaC6aTXVsAhJDaj4LtsISra/RbZknYYzK
         cm0lucOqgoBLxkEeBvDlmjDRlC51UvYeCPOts38T5KGkpVtd/AoV45z0IUC0wrfFzmf9
         jRQhAfSjvL2YtGyJv89WOXRo81C1+sLX6azRxKw2rXxKAbtluubFSG7Tmh0BfcID5VZm
         ZMknjZHnWwD+nHQZLh5gbfiQY3DLeAAeSmD83R6mxDm5Lfxk/qW1My3UcscpXLDmwz3r
         a8sQ2iHMuCvRgd9GULmEZTWMfHykm1jJSHjlldDmm7T/1jO2XxO8f9exkDag2Orl8iuy
         6d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225425; x=1697830225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7YdfjA2Rn+ebSTRqrkT9q3F9XpUUdA06iSoUXPeWbo=;
        b=MxPjc7J/D9ou6kNVjBxcs7rtQrdfldeMYL47/gv+sOAwh76nvRWW0ljVjqhuwsBOL6
         W5Zsg1wDkBFYuVLWc1ZQRoLFdDTy9HhlBSaiLmO4KKjn0yq9u7XqeMS1f69ieH2qVl6/
         WY4qMQGCwc9rwh4RPXnbNE3/ztoGayWCfb3GFzNie0RuzRKzjTIlDXvj4zETSd3IK3At
         2jhq5QIXPg9HX8jVtk3+9rqPvKfx4u2qzFkQnHc71mpP2kXeOIV4X5qBGkNKJlImuZr+
         Nic7a09WR8INMUnuceAk1c0MhKKC53n6Gn/a4ua34k3B5mvZ24oJdZeWlKgT7+fMSjTc
         KIwg==
X-Gm-Message-State: AOJu0Yzm3DLeTXqEqPTqwO7hEE/kz8RL0hyL8LDz6WfLMH5etKT32mm/
        QVOLfu7tfDquDQXznmAtDQbA5BNqp4CUPPNgxXo=
X-Google-Smtp-Source: AGHT+IHajNTfr6hjU8eCJFn/QKD/wa4CWVpRRi6H6hBodewvrpvrKKPtbM+1Z91tRyWp+DXst5cc9/2DfMxCgNLGKvk=
X-Received: by 2002:a05:6402:217:b0:533:4c15:c337 with SMTP id
 t23-20020a056402021700b005334c15c337mr23905479edv.16.1697225425303; Fri, 13
 Oct 2023 12:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231011204150.51166-1-ubizjak@gmail.com> <ZSlqo-k2htjN1gPh@google.com>
In-Reply-To: <ZSlqo-k2htjN1gPh@google.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 13 Oct 2023 21:30:17 +0200
Message-ID: <CAFULd4bTyKKw+=SuTVbFXzgqqV+XU-kGaO5eBcXck5BUpvoUJg@mail.gmail.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 6:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Oct 11, 2023, Uros Bizjak wrote:
> > Additionaly, the patch introduces 'rdgsbase' alternative for CPUs with
> > X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
> > only decoding in the first decoder etc. But we're talking single-cycle
> > kind of effects, and the rdgsbase case should be much better from
> > a cache perspective and might use fewer memory pipeline resources to
> > offset the fact that it uses an unusual front end decoder resource...
>
> The switch to RDGSBASE should be a separate patch, and should come with a=
ctual
> performance numbers.

This *is* the patch to switch to RDGSBASE. The propagation of
arguments is a nice side-effect of the patch. due to the explicit
addition of the offset addend to the %gs base. This patch is
alternative implementation of [1]

[1] x86/percpu: Use C for arch_raw_cpu_ptr(),
https://lore.kernel.org/lkml/20231010164234.140750-1-ubizjak@gmail.com/

Unfortunately, I have no idea on how to measure the impact of such a
low-level feature, so I'll at least need some guidance. The "gut
feeling" says that special instruction, intended to support the
feature, is always better than emulating said feature with a memory
access.

> A significant percentage of data accesses in Intel's TDX-Module[*] use th=
is
> pattern, e.g. even global data is relative to GS.base in the module due i=
ts rather
> odd and restricted environment.  Back in the early days of TDX, the modul=
e used
> RD{FS,GS}BASE instead of prefixes to get pointers to per-CPU and global d=
ata
> structures in the TDX-Module.  It's been a few years so I forget the exac=
t numbers,
> but at the time a single transition between guest and host would have som=
ething
> like ~100 reads of FS.base or GS.base.  Switching from RD{FS,GS}BASE to p=
refixed
> accesses reduced the latency for a guest<->host transition through the TD=
X-Module
> by several thousand cycles, as every RD{FS,GS}BASE had a latency of ~18 c=
ycles
> (again, going off 3+ year old memories).
>
> The TDX-Module code is pretty much a pathological worth case scenario, bu=
t I
> suspect its usage is very similar to most usage of raw_cpu_ptr(), e.g. ge=
t a
> pointer to some data structure and then do multiple reads/writes from/to =
that
> data structure.
>
> The other wrinkle with RD{FS,FS}GSBASE is that they are trivially easy to=
 emulate.
> If a hypervisor/VMM is advertising FSGSBASE even when it's not supported =
by
> hardware, e.g. to migrate VMs to older hardware, then every RDGSBASE will=
 end up
> taking a few thousand cycles (#UD -> VM-Exit -> emulate).  I would be sur=
prised
> if any hypervisor actually does this as it would be easier/smarter to sim=
ply not
> advertise FSGSBASE if migrating to older hardware might be necessary, e.g=
. KVM
> doesn't support emulating RD{FS,GS}BASE.  But at the same time, the whole=
 reason
> I stumbled on the TDX-Module's sub-optimal RD{FS,GS}BASE usage was becaus=
e I had
> hacked KVM to emulate RD{FS,GS}BASE so that I could do KVM TDX developmen=
t on older
> hardware.  I.e. it's not impossible that this code could run on hardware =
where
> RDGSBASE is emulated in software.

There are some other issues when memory access to the percpu area is
implemented with an asm. An ongoing analysis shows that compilers
can't CSE asm over basic-block boundaries, the CSE of asm is a very
simple pattern matching through the BB. So, taking into account all
presented facts and noticeable increase in binary size due to the use
of alternatives, I'm leaning towards using C for arch_raw_cpu_ptr().
Compilers are extremely good at optimizing memory access, so I guess
the original patch [1] outweighs the trouble with RDGSBASE. Unless
someone proves that RDGSBASE is noticeably *better* than current (or
future optimized) implementation.

> [*] https://www.intel.com/content/www/us/en/download/738875/intel-trust-d=
omain-extension-intel-tdx-module.html

Thanks,
Uros.
