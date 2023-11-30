Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65B67FF33D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbjK3PLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C2194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701357107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tTb7/Brcw9eH7ls4rESUEPjpWAXCIT3tROznUXci3eY=;
        b=GuuVtE9U6Ojpe2mkS/g0KD8Yeq+r/+C8oFpmvZfJ5U1HamCP/KOLIPQnXMiFHqk+eGO2bN
        L2ySHZqRLT5jdE9R6nDKLoCzQGzBFJRrJNHeHLTwEADl2JK9Ngb0yE9iR45Aqg05CM3xA0
        yoEwLuwKPEb6KAk7IhUkCFcTDr8cP0g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385--jp7GhegNvePqCKhIm8Xfw-1; Thu, 30 Nov 2023 10:11:46 -0500
X-MC-Unique: -jp7GhegNvePqCKhIm8Xfw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5444a9232a9so859463a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357105; x=1701961905;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTb7/Brcw9eH7ls4rESUEPjpWAXCIT3tROznUXci3eY=;
        b=cVXnTOXDvfe5Eo+rQzcwDxo8F2VRdrRGL65JPv0sPxPcDsRPP+nMUn7f+N2V6HMfzz
         oa1dLHAXqvn4bxC5nTnePUNKgf5Ea5p9Ff3hbgOHCKlabfrjXsSYj3MyEz/AmdO2QLR1
         k71is2WlTvhqnzEfqnOuk8tODYVOZVJF2iwV1sdd705mm+38cjajyi8m2VtQHBSqmrKn
         3o8wscytNC6ON46xT440qGlseHfVYA54nheLOdKV7Wyb3nA+pbB8JbUTJuyIamh07u+D
         qXfnEwUzTCcBtEQddFD4DS0a097mRKujPzFkG1s7RjhMQ6NpBuM9wrkHnpsdY+nJ4ldi
         J+KA==
X-Gm-Message-State: AOJu0YzEGv/rBujg1fVsyp3fkfjU45OJbORsANeqhqRPmd443e6nPxQR
        9QXqL0bFZQ1TP5krkrMwoGtMmubeQhrAEumFbnMN2PaDgNYNxUgBMGHZ0PGxVKIfRHsDQHsfri8
        jvtbevFYOapH1l4FED71yCLGCj5X2Sx1YjRvrhXS3hivJvUt5ERiHUS4BTPMOawjoKxNZQm0OD3
        UpV6aFKi+5
X-Received: by 2002:a05:6402:b44:b0:54b:eae2:31f0 with SMTP id bx4-20020a0564020b4400b0054beae231f0mr2801934edb.38.1701357105128;
        Thu, 30 Nov 2023 07:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcoQRjN9FDyRmd09UWPdOXNcjtgFl05hyoI4ljPOGLTZWlnuhzIwOGMzLfhGUcYX69PhiQWQ==
X-Received: by 2002:a05:6402:b44:b0:54b:eae2:31f0 with SMTP id bx4-20020a0564020b4400b0054beae231f0mr2801912edb.38.1701357104769;
        Thu, 30 Nov 2023 07:11:44 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a7-20020aa7d907000000b0054b37719896sm637773edr.48.2023.11.30.07.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:11:44 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] KVM: x86: Make Hyper-V emulation optional
In-Reply-To: <ZWfl3ahamXPPoIGB@google.com>
References: <20231025152406.1879274-1-vkuznets@redhat.com>
 <20231025152406.1879274-11-vkuznets@redhat.com>
 <ZWfl3ahamXPPoIGB@google.com>
Date:   Thu, 30 Nov 2023 16:11:43 +0100
Message-ID: <87y1efmg28.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

...

>
>>  static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>>  {
>> @@ -3552,11 +3563,13 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>>  	if (!nested_vmx_check_permission(vcpu))
>>  		return 1;
>>  
>> +#ifdef CONFIG_KVM_HYPERV
>>  	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
>>  	if (evmptrld_status == EVMPTRLD_ERROR) {
>>  		kvm_queue_exception(vcpu, UD_VECTOR);
>>  		return 1;
>>  	}
>> +#endif
>>  
>>  	kvm_pmu_trigger_event(vcpu, PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
>
> This fails to build with CONFIG_KVM_HYPERV=n && CONFIG_KVM_WERROR=y:
>
> arch/x86/kvm/vmx/nested.c:3577:9: error: variable 'evmptrld_status' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (CC(evmptrld_status == EVMPTRLD_VMFAIL))
>                ^~~~~~~~~~~~~~~
>
> Sadly, simply wrapping with an #ifdef also fails because then evmptrld_status
> becomes unused.  I'd really prefer to avoid having to tag it __maybe_unused, and
> adding more #ifdef would also be ugly.  Any ideas?

A couple,

- we can try putting all eVMPTR logic under 'if (1)' just to create a
  block where we can define evmptrld_status. Not sure this is nicer than
  another #ifdef wrapping evmptrld_status and I'm not sure what to do
  with kvm_pmu_trigger_event() -- can it just go above
  nested_vmx_handle_enlightened_vmptrld()?

- we can add a helper, e.g. 'evmptr_is_vmfail()' and make it just return
  'false' when !CONFIG_KVM_HYPERV.

- rewrite this as a switch to avoid the need for having the local
  variable, (untested)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c5ec0ef51ff7..b26ce7d596e9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3553,22 +3553,23 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
        enum nvmx_vmentry_status status;
        struct vcpu_vmx *vmx = to_vmx(vcpu);
        u32 interrupt_shadow = vmx_get_interrupt_shadow(vcpu);
-       enum nested_evmptrld_status evmptrld_status;
 
        if (!nested_vmx_check_permission(vcpu))
                return 1;
 
-       evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
-       if (evmptrld_status == EVMPTRLD_ERROR) {
+       switch (nested_vmx_handle_enlightened_vmptrld(vcpu, launch)) {
+       case EVMPTRLD_ERROR:
                kvm_queue_exception(vcpu, UD_VECTOR);
                return 1;
+       case EVMPTRLD_VMFAIL:
+               trace_kvm_nested_vmenter_failed("evmptrld_status", 0);
+               return nested_vmx_failInvalid(vcpu);
+       default:
+               break;
        }
 
        kvm_pmu_trigger_event(vcpu, PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-       if (CC(evmptrld_status == EVMPTRLD_VMFAIL))
-               return nested_vmx_failInvalid(vcpu);
-
        if (CC(!evmptr_is_valid(vmx->nested.hv_evmcs_vmptr) &&
               vmx->nested.current_vmptr == INVALID_GPA))
                return nested_vmx_failInvalid(vcpu);

Unfortunately, I had to open code CC() ;-(

Or maybe just another "#ifdef" is not so ugly after all? :-)

-- 
Vitaly

