Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F87D1492
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbjJTRHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJTRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:07:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED333A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:07:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27779f49458so916164a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697821656; x=1698426456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4BWurQpapK412rcDC+pUyHudLjLoftq7UvjlE0wpgY=;
        b=LKFuLI8QH7jcz8atySd85fQrc6cGMXwxm2hvQ4z2PXbxZITY5blOeTTRAj8tWWxuC4
         h0kAzWEvA9lBKXWQsQwri/k+aLffpsuVaIq9+W8aPY+3HbbiSQzJlP9vzWBUSikVWn3U
         W+dncEOJvoQg2qWYwsXH7KRW62RMhUuxbGd9AMdODPEphCkoE6MgISK9yIM3VuxDpCWV
         DQWgSCPVkqBwJnxoXLHZ5h66KTGIOW6tIpVu9064tluIINHwExkPMmPHj84ta0XJxlJ8
         +gsCUrT4RMJrmPR+EXPfPNrlRYglIrXUbfOg+NOMjCqAMOtRyJEbS8R6dNfuUvF4tgmT
         ae3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821656; x=1698426456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4BWurQpapK412rcDC+pUyHudLjLoftq7UvjlE0wpgY=;
        b=hD/0uH/tx2lgUwFWBQrvRzxqp17ri1G3b7U6o+2b/7NZ3Y2z44vYu4BQ63IfifgjcF
         xd5o5kQ3t6loER4AH1tDPvAwxlTkXUKLTuns0X4MYaHpMAHVqlS2Jcpwc6HWj7owMnk/
         ahFc7UUUwUDdkUqdqViVzy5DRODF/VosUEeuHfnvlTCub6y7j9ipCWbmsxpjRlgs5bYq
         pPycKn72ZcdGGE/88Km6bNVWOAxshEVsvsukMgFL8NF2hKLTbYLMsAxwszGdUFlx7/rT
         iLKdLN7cI46R7BKTapI0nS6lKvOcecvR0dxT3h46OP+Ziw7QGk214n6eCFEFP6ZEM86L
         3nzw==
X-Gm-Message-State: AOJu0YxuwCdF0NkznXHJjSDJn9lhH20lR2Np1/CkBQMumZWmXVKIN55c
        NoAx9zpFFrios8KuVzj+U1nVsEq2iX0=
X-Google-Smtp-Source: AGHT+IFD7JzGLSjKGr2CZcLV495hcYva5IMtUI4k4GCi8eJrVOm0W02oUecMyWYmDKA2AFrypQyXMTC0gf8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ab88:b0:277:3135:bc4f with SMTP id
 n8-20020a17090aab8800b002773135bc4fmr57158pjq.1.1697821656319; Fri, 20 Oct
 2023 10:07:36 -0700 (PDT)
Date:   Fri, 20 Oct 2023 17:07:34 +0000
In-Reply-To: <87wmvh47zb.fsf@redhat.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com> <87wmvh47zb.fsf@redhat.com>
Message-ID: <ZTKg9XMxeBQ36f5L@google.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
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

On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
> > ---
> >  arch/x86/kernel/kvmclock.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index fb8f52149be9..f2fff625576d 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -24,8 +24,8 @@
> >  
> >  static int kvmclock __initdata = 1;
> >  static int kvmclock_vsyscall __initdata = 1;
> > -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> > -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> > +static int msr_kvm_system_time __ro_after_init;
> > +static int msr_kvm_wall_clock __ro_after_init;
> >  static u64 kvm_sched_clock_offset __ro_after_init;
> >  
> >  static int __init parse_no_kvmclock(char *arg)
> > @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
> >  
> >  void kvmclock_disable(void)
> >  {
> > -	native_write_msr(msr_kvm_system_time, 0, 0);
> > +	if (msr_kvm_system_time)
> > +		native_write_msr(msr_kvm_system_time, 0, 0);
> >  }
> >  
> >  static void __init kvmclock_init_mem(void)
> > @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
> >  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
> >  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
> >  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
> > -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> > +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> > +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
> > +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
> > +	} else {
> >  		return;
> >  	}
> 
> This should work, so
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> but my personal preference would be to change kvm_guest_cpu_offline()
> to check KVM features explicitly instead of checking MSRs against '0'
> at least becase it already does so for other features. Completely
> untested:
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b8ab9ee5896c..1ee49c98e70a 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
>         kvm_pv_disable_apf();
>         if (!shutdown)
>                 apf_task_wake_all();
> -       kvmclock_disable();
> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
> +               kvmclock_disable();
>  }

That would result in an unnecessray WRMSR in the case where kvmclock is disabled
on the command line.  It _should_ be benign given how the code is written, but
it's not impossible to imagine a scenario where someone disabled kvmclock in the
guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
kvmclock_disable().
