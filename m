Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A969788E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHYSQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHYSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:16:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7362717
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:16:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74829dd58fso1556297276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692987351; x=1693592151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4n4KOjY74JnrmhEGS2L7ydOY3XF2ULpzGXoLwRXZcg=;
        b=tvshAaqKiI3YG78HuECSBWhISnw8beOa9d4cBNzU/UFom0WVTKmcM0V40fmQMeZSPe
         if8jDwDqXcBMj/VLIZ3yvr1Jn70d9zA/Y85jF2f/fJooexkGk/7LFViON2IH0tjnrkZ0
         cJU4fc2G52qYHxYnfrG6Jg1EW+SevakkgFaJdEYl8s9Mw4AmB0Klq/YI7fs58/nyKCg7
         SafMXH8JuyRYHpY/JvJkfwu7hf/QZz0MuBJK7R1UivQ4ESnZmH274xTX5M2vH10Ul6dJ
         HFKfRVXa9jHATag24976weKbaCnly0Rqv337rQ8nQxoKZXxoRhvQ8LAaoe8Av4llrUfL
         G2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987351; x=1693592151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4n4KOjY74JnrmhEGS2L7ydOY3XF2ULpzGXoLwRXZcg=;
        b=V/6ZAYJVbEtnSeGwJmNgpcFuDRDUUsexa3DxgFKi+njGK+6Sb4QgCdC40i8LJsjk4L
         PeY07nculUjPv5mB2kdJzo+UsEZ9cjzjHKxd73Ie1gcLmHkobm4Jbzh6XJIGw3EE62gb
         bUydeDFEI5FfsknGSz7NxpUt2H1GLheOxV3a5t6JhfSiALU99h+3IDahdbhQvxfRJVk3
         iC7ezDBQtxDuhEv+AJiSAc50J6Gc532gOuilpnG+uR7ylPlG8Y7uGWtSlAtNwoWsBBkO
         rOKEOY3NYfZl16xCww4AcfZqOOJru30ara8erRrw2Oy6caVafPI+ePHbbl8f/KxxbHMa
         61jw==
X-Gm-Message-State: AOJu0YyZZDcK3iZ/kBCDdA14OHiLZasMF0b77gkYD4bsyKs3qqXFmIVZ
        trSKF4TLNwzqTuaAKPjQ9qRmu59jotU=
X-Google-Smtp-Source: AGHT+IHOrgarhEwVR43cF387sp8o4ePocJLHFh8derHzOiZZuZE6HdbhxugdmeQdzEX3kY/eLJif0wR8gls=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:106:b0:d77:984e:c770 with SMTP id
 o6-20020a056902010600b00d77984ec770mr390126ybh.5.1692987351336; Fri, 25 Aug
 2023 11:15:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:15:49 -0700
In-Reply-To: <79d5f5914fb42c2c62418ffbcd78f138645ded21.1692919072.git.jpoimboe@kernel.org>
Mime-Version: 1.0
References: <cover.1692919072.git.jpoimboe@kernel.org> <79d5f5914fb42c2c62418ffbcd78f138645ded21.1692919072.git.jpoimboe@kernel.org>
Message-ID: <ZOjv1Q0YgoxwElMW@google.com>
Subject: Re: [PATCH 04/23] KVM: x86: Add IBPB_BRTYPE support
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Aug 25, 2023, Josh Poimboeuf wrote:
> Add support for the IBPB_BRTYPE CPUID flag, which indicates that IBPB
> includes branch type prediction flushing.

Please add:

  Note, like SRSO_NO, advertise support for IBPB_BRTYPE even if it's not
  enumerated by in the raw CPUID, i.e. bypass the cpuid_count() in
  __kvm_cpu_cap_mask().  Some CPUs that gained support via a uCode patch
  don't report IBPB_BRTYPE via CPUID (the kernel forces the flag).

  Opportunistically use kvm_cpu_cap_check_and_set() for SRSS_NO instead
  of manually querying host support (cpu_feature_enabled() and
  boot_cpu_has() yield the same end result in this case).

Feel free to take this through tip if this is urgent enough to go into 6.6,
otherwise I'll grab it for 6.7.

Acked-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d3432687c9e6..c65f3ff1c79d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -729,8 +729,8 @@ void kvm_set_cpu_caps(void)
>  		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
>  	);
>  
> -	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
> -		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
> +	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
> +	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
>  
>  	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
>  		F(PERFMON_V2)
> -- 
> 2.41.0
> 
