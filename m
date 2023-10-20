Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696A7D130F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbjJTPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377733AbjJTPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7064B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697816479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aa4iee+yZHK+8BBdXmj4PGqXcZj5CIosrDU7qDGuMQQ=;
        b=VD1OoGJKE8DwpL7JGjY3CBC+MjHZUIXHajm1dAXOpahCR0NSyjqRJdsD6/oVSIz1Xziy1s
        VmgD1NggHkrvfekqW+tutSnuoP+SmLch/h4gsoB7sjujH8bTJNtVa8DLmjUwk/CCmaav+f
        09+m4AnbeZAIKJhWk4sR7KEc7XozwgU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-oGz_kAgKN4iQjyuK55b6YA-1; Fri, 20 Oct 2023 11:41:16 -0400
X-MC-Unique: oGz_kAgKN4iQjyuK55b6YA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507d4583c4cso926885e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816475; x=1698421275;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa4iee+yZHK+8BBdXmj4PGqXcZj5CIosrDU7qDGuMQQ=;
        b=o7nEl+Dvio/AkRJPRKTGeVEl6AUiAYx3QuYMewxeUAtr3/BU9PevuEZzCbeSSIYL23
         selDF3lFcbAIV2yJHhthZ1AbzbHJhV2QcXJt4NxwormGmfcPIO5HPRhpEivmFiQYYZbB
         b2WlHGFuFmCZ+AUgEtpJNGFE7RlCSbtakMXExute7RiBi4HMHGcffimNt0+rky7PzLBL
         O22W2iIUF0q/bI1eFq6ON4HvweL5cKoIkze1Bbjx3OldW87ubeKnNdpnl+4eA7rNbnb/
         TMF23U0/UtV83o5uJ4ngqHVA2i5Sj4bFxAfMiLk6giA0gNeEOIJ29n/ILGhoSuxyYoaO
         EpGg==
X-Gm-Message-State: AOJu0Yy8KqnU4piNAX85LBzRH0bmFH3skuxlvYycM0l+ss8UpV5jOXb1
        +J38JBB+KtIb8/NtCvq5fWQNbj6dzoUm2+7gj00eVdu3vAgogyEoMraFyftN1yoAZD75i/sHBgm
        Wm50Qdl46jBgBv0k7JK0FbWYC
X-Received: by 2002:a19:500c:0:b0:502:cc8d:f20a with SMTP id e12-20020a19500c000000b00502cc8df20amr1641008lfb.27.1697816474862;
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx40VYFF8tpxC5v03dVRu4wq4nsq5G+AfVDRR5o1snolIVICfC2CekJy5f8SCZ1z4mgxc/Og==
X-Received: by 2002:a19:500c:0:b0:502:cc8d:f20a with SMTP id e12-20020a19500c000000b00502cc8df20amr1640982lfb.27.1697816474535;
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id k13-20020a50c8cd000000b0053443c8fd90sm1642437edh.24.2023.10.20.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:41:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
In-Reply-To: <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Date:   Fri, 20 Oct 2023 17:41:12 +0200
Message-ID: <87wmvh47zb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
>
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
>
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
>
> Do not disable kvmclock if it was not enabled.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/kvmclock.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index fb8f52149be9..f2fff625576d 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -24,8 +24,8 @@
>  
>  static int kvmclock __initdata = 1;
>  static int kvmclock_vsyscall __initdata = 1;
> -static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> -static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> +static int msr_kvm_system_time __ro_after_init;
> +static int msr_kvm_wall_clock __ro_after_init;
>  static u64 kvm_sched_clock_offset __ro_after_init;
>  
>  static int __init parse_no_kvmclock(char *arg)
> @@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
>  
>  void kvmclock_disable(void)
>  {
> -	native_write_msr(msr_kvm_system_time, 0, 0);
> +	if (msr_kvm_system_time)
> +		native_write_msr(msr_kvm_system_time, 0, 0);
>  }
>  
>  static void __init kvmclock_init_mem(void)
> @@ -294,7 +295,10 @@ void __init kvmclock_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
>  		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
>  		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
> -	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> +	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
> +		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
> +		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
> +	} else {
>  		return;
>  	}

This should work, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

but my personal preference would be to change kvm_guest_cpu_offline()
to check KVM features explicitly instead of checking MSRs against '0'
at least becase it already does so for other features. Completely
untested:

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b8ab9ee5896c..1ee49c98e70a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,7 +454,9 @@ static void kvm_guest_cpu_offline(bool shutdown)
        kvm_pv_disable_apf();
        if (!shutdown)
                apf_task_wake_all();
-       kvmclock_disable();
+       if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2) ||
+           kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE))
+               kvmclock_disable();
 }

-- 
Vitaly

