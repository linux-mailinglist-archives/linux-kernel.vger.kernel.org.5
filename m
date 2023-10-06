Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A77BBA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjJFOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjJFOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:36:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995928F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:36:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so33619157b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696603016; x=1697207816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i58l4QdfZN6X+tVl9sXUSU5MssTQt5gV2xYo4Yk/tro=;
        b=AW5UdJMKrweVx1vMeC3UpMFtpMzzGZ6zccr9d0xQCg69lZjKiy8M/ZTytiurPsjUjY
         E3tnbglEVJXkmaZD5Xiz0gHENMvCCHzEVj/WMXg8DVg/Mwothn+/6b/qlYwjtLWKjFK6
         i/qYV+IuYOodck2X1C0yBjt4Cq8bbVHDP/rB4/b6IJJiyp6Y1GgLhg8fVaHZfIlrz9ZE
         dEUsrfXv/JJr5AFcoQ9qIDoMwadC1BV8D95hjpuuOz2q3onGZbHaSEsdETfFQImInqYy
         yO/XSt/jrdSRBtJYR7Pc2bdSEOcRXCsvXTgLadOV4r1JCtbYdRhvZ+ocBU2FTOPtHQe1
         l8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603016; x=1697207816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i58l4QdfZN6X+tVl9sXUSU5MssTQt5gV2xYo4Yk/tro=;
        b=bA94PiM35FJE2Ip5ewLrBbfT16HWoav7bRiqWogCPmGIxqGac8kyjGi3z3AeSEjHhD
         nkVOx4jZBVnjkYohsPZlU87RBoUmXc1Vmv5fiE7ncTFJhE+J5cEyOXnMJEC0XKY3NKOd
         u5lMb9tTVAPtuUqMjjOB5KQFB1T20dLdSuuXkxN1uAkNJvMeI1R1nNhOWJKJi2fPeeus
         bjpzVyaFu9WPqagwasTXumDDUwQGlSZCIW5nWE5zkHVpbwg+ThaVJRm/W9TcHK18i0ed
         7nrkyDA/wZfepLOrZdbWp0BD6d2bTBGn4vOvsz3ap9gEWQwRIpKC/0E1e+Qr1SAIa4SR
         jDGQ==
X-Gm-Message-State: AOJu0YyD0Sqd4E93pkfm3qDOYjllOmrJ4T8VEMqi5xV0vVoO2gsOKCXt
        PYQezXuR04lh3cQ49BXMwyxvwDUvUFM=
X-Google-Smtp-Source: AGHT+IFQPwuq8dktatytMOhE25UzyzqCNlQC2UUPVzg1lqdTu+UMho1qRpPPz4wW/QHlMjyqJHF5XE+bNrg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ae59:0:b0:d7e:752f:baee with SMTP id
 g25-20020a25ae59000000b00d7e752fbaeemr117773ybe.10.1696603015772; Fri, 06 Oct
 2023 07:36:55 -0700 (PDT)
Date:   Fri, 6 Oct 2023 07:36:54 -0700
In-Reply-To: <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com> <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
Message-ID: <ZSAbhk7fu_w3ClOv@google.com>
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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

+Paolo

Please use get_maintainers...

On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
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
> Do not disable kvmclock if it was not enumerated or disabled by user
> from kernel command line.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> ---
>  arch/x86/kernel/kvmclock.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index fb8f52149be9..cba2e732e53f 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -22,7 +22,7 @@
>  #include <asm/x86_init.h>
>  #include <asm/kvmclock.h>
>  
> -static int kvmclock __initdata = 1;
> +static int kvmclock __ro_after_init = 1;
>  static int kvmclock_vsyscall __initdata = 1;
>  static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
>  static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> @@ -195,7 +195,12 @@ static void kvm_setup_secondary_clock(void)
>  
>  void kvmclock_disable(void)
>  {
> -	native_write_msr(msr_kvm_system_time, 0, 0);
> +	if (!kvm_para_available() || !kvmclock)
> +		return;
> +
> +	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE) ||
> +	    kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2))
> +		native_write_msr(msr_kvm_system_time, 0, 0);

Rather than recheck everything and preserve kvmclock, what about leaving the MSR
indices '0' by default and then disable msr_kvm_system_time iff it's non-zero.
That way the disable path won't become stale if the conditions for enabling
kvmclock change.

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index fb8f52149be9..f2fff625576d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,8 +24,8 @@
 
 static int kvmclock __initdata = 1;
 static int kvmclock_vsyscall __initdata = 1;
-static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static int msr_kvm_system_time __ro_after_init;
+static int msr_kvm_wall_clock __ro_after_init;
 static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
@@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
 
 void kvmclock_disable(void)
 {
-       native_write_msr(msr_kvm_system_time, 0, 0);
+       if (msr_kvm_system_time)
+               native_write_msr(msr_kvm_system_time, 0, 0);
 }
 
 static void __init kvmclock_init_mem(void)
@@ -294,7 +295,10 @@ void __init kvmclock_init(void)
        if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
                msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
                msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
-       } else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+       } else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+               msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
+               msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
+       } else {
                return;
        }

