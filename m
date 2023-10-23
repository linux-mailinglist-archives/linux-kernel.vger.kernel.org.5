Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E07D2D18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjJWIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732BDD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698050735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ONX0XVyCTtsac8zioBH3gBVyx/xvQWqU8VDZR3vizo=;
        b=XaIEgQYK/KYOCXAwQTuzhRg2eXbT1O6S3AKXvz5OzFCqYk3xlglrolU4aeA3N8nMZ/vjWM
        n7fHMDIAPAkTJhz1Jiu2dlyQUYDuks47FXHxqAZXc8cJkI+41S2hIB5vwTzu8JLYiMyZLZ
        VPvV3pPFydT5+KN/OLXyL5GIZGTV4Qo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Q2K0u80_P_a8Jk7krNi2iQ-1; Mon, 23 Oct 2023 04:45:33 -0400
X-MC-Unique: Q2K0u80_P_a8Jk7krNi2iQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bcb13d8ddso186272466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050732; x=1698655532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ONX0XVyCTtsac8zioBH3gBVyx/xvQWqU8VDZR3vizo=;
        b=POZCeYQwbGpq/OlXX8HzjfPrcMcKMXGCiwPtOTUNx2ToyDI4SlnNHAtEhur7O/CNJS
         KqqD5gdAytfZ54JDeGtdkg2S0Zpu1wsf614rODCRtGhGtfJlgwzwfWEog8Osu/eBmIoc
         +Nd5iPHNkS/3w9v3HLmhNUs15Ys7gnJR2frodH7sp5Yl4fbGGvMTmOj4Y5dDLZIkrVVU
         VZCKwHkyvVaTk+UyDGjDfL2yXBDh2Yh97jlhlzMTbTE5gCbK8jDpwoyvvQ5gGDdMKX73
         qyH2h+iLwaSIC6GJXe3DtS2moB8JOvVKpwO4s+ttIK8Z8bsarnctBGxCvmqh6hLFEjlU
         yWow==
X-Gm-Message-State: AOJu0YzoJG52AkLjV+emmigSk0nZQgpXxEv1uyYzpZGgRtLRMnIU6PIY
        A7JUEdmryB3iBzFI++NZb8DUAzb/QaJ5y+xEfQORjwrekDSw+U8Z1O2XWSkuyZpto/6nVE/g1/A
        v1mkJiXc+ZQkQb5MWpKJgCsU8
X-Received: by 2002:a17:906:eec6:b0:9c7:5200:e4f4 with SMTP id wu6-20020a170906eec600b009c75200e4f4mr6393498ejb.41.1698050732742;
        Mon, 23 Oct 2023 01:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWTFAp6QtMJSjMVDuSWl670+37nbjJceCxIyo+JB67CunU+EP22o6HuiyUdGLqsHZXvKal7w==
X-Received: by 2002:a17:906:eec6:b0:9c7:5200:e4f4 with SMTP id wu6-20020a170906eec600b009c75200e4f4mr6393489ejb.41.1698050732408;
        Mon, 23 Oct 2023 01:45:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906580100b009ae3e6c342asm6302165ejq.111.2023.10.23.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:45:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
In-Reply-To: <ZTKg9XMxeBQ36f5L@google.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
 <87wmvh47zb.fsf@redhat.com> <ZTKg9XMxeBQ36f5L@google.com>
Date:   Mon, 23 Oct 2023 10:45:30 +0200
Message-ID: <87r0ll4thx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Oct 20, 2023, Vitaly Kuznetsov wrote:
>> > ---
>> >  arch/x86/kernel/kvmclock.c | 12 ++++++++----
>> >  1 file changed, 8 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>> > index fb8f52149be9..f2fff625576d 100644
>> > --- a/arch/x86/kernel/kvmclock.c
>> > +++ b/arch/x86/kernel/kvmclock.c
>> > @@ -24,8 +24,8 @@
>> >  
>> >  static int kvmclock __initdata = 1;
>> >  static int kvmclock_vsyscall __initdata = 1;
>> > -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
>> > -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
>> > +static int msr_kvm_system_time __ro_after_init;
>> > +static int msr_kvm_wall_clock __ro_after_init;
>> >  static u64 kvm_sched_clock_offset __ro_after_init;
>> >  
>> >  static int __init parse_no_kvmclock(char *arg)
>> > @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
>> >  
>> >  void kvmclock_disable(void)
>> >  {
>> > -	native_write_msr(msr_kvm_system_time, 0, 0);
>> > +	if (msr_kvm_system_time)
>> > +		native_write_msr(msr_kvm_system_time, 0, 0);
>> >  }
>> >  
>> >  static void __init kvmclock_init_mem(void)
>> > @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
>> >  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
>> >  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
>> >  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
>> > -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
>> > +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
>> > +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
>> > +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
>> > +	} else {
>> >  		return;
>> >  	}
>> 
>> This should work, so
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> but my personal preference would be to change kvm_guest_cpu_offline()
>> to check KVM features explicitly instead of checking MSRs against '0'
>> at least becase it already does so for other features. Completely
>> untested:
>> 
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index b8ab9ee5896c..1ee49c98e70a 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
>>         kvm_pv_disable_apf();
>>         if (!shutdown)
>>                 apf_task_wake_all();
>> -       kvmclock_disable();
>> +       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
>> +           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
>> +               kvmclock_disable();
>>  }
>
> That would result in an unnecessray WRMSR in the case where kvmclock is disabled
> on the command line.  It _should_ be benign given how the code is written, but
> it's not impossible to imagine a scenario where someone disabled kvmclock in the
> guest because of a hypervisor bug.  And the WRMSR would become a bogus write to
> MSR 0x0 if someone made a "cleanup" to set msr_kvm_system_time if and only if
> kvmclock is actually used, e.g. if someone made Kirill's change sans the check in
> kvmclock_disable().

True but we don't have such module params to disable other PV features so
e.g. KVM_FEATURE_PV_EOI/KVM_FEATURE_MIGRATION_CONTROL are written to
unconditionally. Wouldn't it be better to handle parameters like
'no-kvmclock' by clearing the feature bit in kvm_arch_para_features()'s
return value so all kvm_para_has_feature() calls for it just return
'false'? We can even do an umbreall "no-kvm-features=<mask>" to cover
all possible debug cases.

-- 
Vitaly

