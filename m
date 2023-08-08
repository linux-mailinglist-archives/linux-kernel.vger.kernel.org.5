Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2236F774F8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjHHXsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHHXsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:48:22 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DECFF0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:48:21 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-687167290fbso6824358b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691538501; x=1692143301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2YnROpvUkDVkcj2rtSrEnyN7qYS/S3plRfhiHd5mcc=;
        b=6P2ISKH9dvBzrmFMwwWEjDe2KAlrgm7n3Rw9Zs+PD42odg66V+LxrZ02Ue8LMdiYul
         oWEUtT2q5ZOWeg6+4OIbliz12nv6mqaJ2+ThsfUOp7RCVT1OBUkYjffdzH7nZ88cKLC/
         cNFeOXcl1+we7dDpCA6swxOHdcqUe7TJFTqs0lRwXcNua58vKB4tlYbk+VYpDkjUaGsC
         DVeyLt7jtkIy5AyihK80tD5eKIIe/TAF5t7O0uJPh0HHrh0N+cTyd6p9CYSX9F6+UGbq
         uhEY1Vt1ZEnz58dxntnxZNVUaNPGBklzd8xOWA4zdJfyZw3OqGMPkPPrDd7jjj2TKYk0
         xBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691538501; x=1692143301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2YnROpvUkDVkcj2rtSrEnyN7qYS/S3plRfhiHd5mcc=;
        b=aCcTGYOF/Q5eNOYvfvLbPpQdv4NDVJrtwskz842PmVq5GsdvX62Lp5rVS5dZtFvyjn
         tG0zab6xdN8IAOTRuq5Sihe4auXsS/0853YKI4dFBaqcL0oGMgHYrWCXrh2UOUJ9tPUP
         wIdGdatfmfN3njesWnuLEZ0D9sG9yYJhVUK+panLhhg1NucO5r09t+M8cjL95CutexPa
         Y9Gyh7WgGIvcgHeuGH6mQfBbUjOsPbqwfikVSKSV+vTw8qmSHNLeOJuvF3JeYl9xevLp
         OkHTZ/UWIzhVEVLnKmTerNFlM0xKPIANqlMuq5XjoqQifYgaTbPZz7NQIN562/edgb1P
         1yug==
X-Gm-Message-State: AOJu0Yx2TqQS+B66/Vk8Ztj5ua+xKOo4OS7hGDCI0/a1GB55p7sDjrLJ
        W6NNtMMToIsI7RI1n+cMb1J4tyHihOU=
X-Google-Smtp-Source: AGHT+IFB+E74GSS+aNsfmXDJZDbtqZmI75nMIS02+u3DXfr2Yncv2vuU3JtqszWWUbFToboGSQ6t0IzWQN4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:179b:b0:686:2ad5:d132 with SMTP id
 s27-20020a056a00179b00b006862ad5d132mr26585pfg.5.1691538500779; Tue, 08 Aug
 2023 16:48:20 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:48:19 -0700
In-Reply-To: <20230808164532.09337d49@ake-x260>
Mime-Version: 1.0
References: <20230807062611.12596-1-ake@igel.co.jp> <43c18a3d57305cf52a1c3643fa8f714ae3769551.camel@redhat.com>
 <20230808164532.09337d49@ake-x260>
Message-ID: <ZNLUQ6ZtugOjmlZR@google.com>
Subject: Re: [RFC PATCH] KVM: x86: inhibit APICv upon detecting direct APIC
 access from L2
From:   Sean Christopherson <seanjc@google.com>
To:     Ake Koomsin <ake@igel.co.jp>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023, Ake Koomsin wrote:
> On Mon, 07 Aug 2023 17:00:58 +0300
> Maxim Levitsky <mlevitsk@redhat.com> wrote:
>  
> > Is there a good reason why KVM doesn't expose APIC memslot to a
> > nested guest? While nested guest runs, the L1's APICv is "inhibited"
> > effectively anyway, so writes to this memslot should update APIC
> > registers and be picked up by APICv hardware when L1 resumes
> > execution.
> > 
> > Since APICv alows itself to be inhibited due to other reasons, it
> > means that just like AVIC, it should be able to pick up arbitrary
> > changes to APIC registers which happened while it was inhibited, just
> > like AVIC does.
> > 
> > I'll take a look at the code to see if APICv does this (I know AVIC's
> > code much better that APICv's)
> > 
> > Is there a reproducer for this bug?
>
> The idea from step 6 to step 10 is to start BitVisor first, and start Linux on
> top of it. You can adjust the step as you like. Feel free to ask me anything
> regarding reproducing the problem with BitVisor if the giving steps are not
> sufficient.

Thank you for the detailed repro steps!  However, it's likely going to be O(weeks)
before anyone is able to look at this in detail given the extensive repro steps.
If you have bandwidth, it's probably worth trying to reproduce the problem in a
KVM selftest (or a KVM-Unit-Test), e.g. create a nested VM, send an IPI from L2,
and see if it gets routed correctly.  This purely a suggestion to try and get a
faster fix, it's by no means necessary.

Actually, typing that out raises a question (or two).  What APICv VMCS control
settings does BitVisor use?  E.g. is BitVisor enabling APICv for its VM (L2)?
If so, what values for the APIC access page and vAPIC page are shoved into
BitVisor's VMCS?

> The problem does not happen when enable_apicv=N. Note that SMP bringup with
> enable_apicv=N can fail. This is another problem. We don't have to worry about
> this for now. Linux seems to have no delay between INIT DEASSERT and SIPI during
> its SMP bringup. This can easily makes INIT and SIPI pending together resultling
> in signal lost.
> 
> I admit that my knowledge on KVM and APICv is very limited. I may misunderstand
> the problem. If you don't mind, would it be possible for you to guide me which
> code path should I pay attention to? I would love to learn to find out the
> actual cause of the problem.

KVM *should* emulate the APIC MMIO access from L2.  The call stack should reach
apic_mmio_write(), and assuming it's an ICR write, KVM should send an IPI.
