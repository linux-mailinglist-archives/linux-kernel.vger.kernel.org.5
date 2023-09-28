Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7096C7B21CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjI1Pxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjI1Pxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:53:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEE136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:53:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f6902dc8bso189685817b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695916423; x=1696521223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+KF8Dx6gkORPNY9sE+tILxrgD0oMG3WrnAvRuzUSWM=;
        b=vjUXxPWdABhEn1cB7ZsLXG9cMuCqnHfWSwfycC4D8nCslWOZrUsf+qZ0UT9teCjak4
         9IDKbYRa95uJvTIeiqynJksLkMsWaW8iNzd3zmxvjRIc38j/hqkl2SYyDQgY2uUJRnpg
         e4dE1+Oo7rM5cOmVNPPiE5vv8jpycovwmnZnfwTzx1EF75dnHZymyylszSJcQ/nWaaY0
         w0ke4c6roSdzkewdzHrCNGFsJQ4IGb0gzTfVZYxNvTvIptYOkO+8sd77zP4nxMIzDOom
         DWgvo5txG3DqsRcdk/d8d0IbBFw449lJ4YUwRTVUbaMdFVkXDJmn5GsdZv62b/GaDSw9
         gFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695916423; x=1696521223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+KF8Dx6gkORPNY9sE+tILxrgD0oMG3WrnAvRuzUSWM=;
        b=QFIaBKYJGRz6hX/mU3AsNWpTUbXQSI0GmysL/4UfUkp8OaZInTqBHdEnjj3EQHMmqh
         hhrfT970rii8xAg1LKw+g6pLhmWWBov/Rk0cFP2Q1pjI/a/ya7Xq3gnU18/df4yxC0sj
         GLsu+aSp7gsCJaTF/Ics0Rfk1PgVPj8Q8KViuohC2bq7/5me54cHGHCIe41O30cLohjB
         Qew/+dBVRgDzcIBiIM7hCkWS6/WL29mnVDDNGj00Ivq7l32KD7eQZ4yWwdyfnguMurWq
         FiTrs54oTGYJ7HfbkfI7pjqSu3K6amCJByIPDXH+DBLaQvpwnQzYlcHhUvJz+S45OeDU
         6b1A==
X-Gm-Message-State: AOJu0Yw+Rvn/QqGElHfc8n9PSolNWvB2BXDtsfsWn7djmP1jVSLzqyGC
        25smNRgqLh/teXT5QfDxyW7GxmztipU=
X-Google-Smtp-Source: AGHT+IH4A7qKg2XydOJbmIvwuoLA9BPXAXOV4ldgBhSu0+Vajy3UmXpajmDHZC2VBSfPhVz068mClgDbRP0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bc05:0:b0:59b:f138:c843 with SMTP id
 a5-20020a81bc05000000b0059bf138c843mr31557ywi.3.1695916422752; Thu, 28 Sep
 2023 08:53:42 -0700 (PDT)
Date:   Thu, 28 Sep 2023 08:53:41 -0700
In-Reply-To: <20230928150428.199929-2-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com> <20230928150428.199929-2-mlevitsk@redhat.com>
Message-ID: <ZRWhhTvQuE2MN9KB@google.com>
Subject: Re: [PATCH 1/5] x86: KVM: SVM: fix for x2avic CVE-2023-5090
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM: SVM: for the shortlog scope

And my preference is to have the shortlog explain the code change and leave the
CVE reference to a line in the changelog.  CVE numbers are meaningless without
context, e.g. listing the CVE isn't going to be at all helpful for future readers
that look at shortlogs.

E.g.

  KVM: SVM: Always refresh x2APIC MSR intercepts when x2AVIC is enabled

or 

  KVM: SVM: Update MSR intercepts for x2AVIC when guest disables x2APIC

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> The following problem exists since the x2avic was enabled in the KVM:

Just "x2avic"

> svm_set_x2apic_msr_interception is called to enable the interception of

() after functions

> the x2apic msrs.
> 
> In particular it is called at the moment the guest resets its apic.
> 
> Assuming that the guest's apic was in x2apic mode, the reset will bring
> it back to the xapic mode.
> 
> The svm_set_x2apic_msr_interception however has an erroneous check for
> '!apic_x2apic_mode()' which prevents it from doing anything in this case.
> 
> As a result of this, all x2apic msrs are left unintercepted, and that
> exposes the bare metal x2apic (if enabled) to the guest.
> Oops.
> 
> Remove the erroneous '!apic_x2apic_mode()' check to fix that.
> 
> Cc: stable@vger.kernel.org

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9507df93f410a63..acdd0b89e4715a3 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -913,8 +913,7 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool intercept)
>  	if (intercept == svm->x2avic_msrs_intercepted)
>  		return;
>  
> -	if (!x2avic_enabled ||
> -	    !apic_x2apic_mode(svm->vcpu.arch.apic))
> +	if (!x2avic_enabled)
>  		return;
>  
>  	for (i = 0; i < MAX_DIRECT_ACCESS_MSRS; i++) {
> -- 
> 2.26.3
> 
