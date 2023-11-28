Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA937FB293
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbjK1HVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbjK1HVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B811BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE1VEO/P4SWtiM2JUk8giEN5tkTYagzMpscsqMITB5w=;
        b=dTq7W7F0wgXAwm9/L3Fv2RvpTIWXw8EkTTqIMeaYFeRe2HUwaDrAE/QLlRH84HWmXLcpf/
        tKDWSpSQJNOlGVb9k9tpB77xM8ffas9qDDNmAGDs4uVtm3MMXNdTZsThPhQIxvg0YL2Qm2
        vm7oUaAMdQIetBwhhrppMF5KssYp2rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hg5Au1ruMFOVU9fj-ET19g-1; Tue, 28 Nov 2023 02:21:48 -0500
X-MC-Unique: hg5Au1ruMFOVU9fj-ET19g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3dbe99d9so20559175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156107; x=1701760907;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rE1VEO/P4SWtiM2JUk8giEN5tkTYagzMpscsqMITB5w=;
        b=HRHAW9ib1DdCeiAnbDFDw7JYFL3gdlOf/t6DtuN+AiyRLtzehNbq5IOlPmqNHWJ26+
         +h4+zzVYr00chsq9lS2LrrtzuZQbLuttkouOTysUqyibU7keY2nTeJBPXCs/9E2AtOYC
         4U+PEFvDFDM5x9KoIm+5a32CsSQNcnk4FXH+gUhZ8NLHnD0LoJ6IwpkHomUcEXaMk6JA
         gog5WLLVwSDds8x4JUn8IHfXVREJp2RO3hQyzTbLx850G4Vsyt/77y7F4JIzYxzU36J+
         JHtSI4PsrED0GF0jiRSUwnhPOd7DOS13h9yLvhOE6VghdWhohM/2dRLHuNL6Nrv1vBmi
         ftNA==
X-Gm-Message-State: AOJu0YxGV49yLLxa8oUOzhxm4jrhVsH2ZNxQyykgc5R/HOYVDU1eL6NP
        b8mJX1UeY12aMiM7cvprh6sVnvLcz99Giv2Yrs1vT4AeDPSZqdU6KtdZicO86wYI01VlNjJgYkd
        d/H4ersvdCrYoz3BdL+LUR6Av
X-Received: by 2002:a05:600c:450b:b0:40a:20f3:d127 with SMTP id t11-20020a05600c450b00b0040a20f3d127mr10318546wmo.35.1701156107369;
        Mon, 27 Nov 2023 23:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRAqrROjHJ1qTtcsKosFtEkpI+uCXd2x8KsHl5ZzJYdXsn5YxcHbf1j1XUd/tosccrg8O+Q==
X-Received: by 2002:a05:600c:450b:b0:40a:20f3:d127 with SMTP id t11-20020a05600c450b00b0040a20f3d127mr10318535wmo.35.1701156107013;
        Mon, 27 Nov 2023 23:21:47 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b0040b36ad5413sm16255957wms.46.2023.11.27.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:21:46 -0800 (PST)
Message-ID: <b11d9a96cf1b49eea92a8f3eec31272d47c82fb8.camel@redhat.com>
Subject: Re: [RFC 08/33] KVM: x86: Don't use hv_timer if CAP_HYPERV_VSM
 enabled
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:21:44 +0200
In-Reply-To: <20231108111806.92604-9-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-9-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> VSM's VTLs are modeled by using a distinct vCPU per VTL. While one VTL
> is running the rest of vCPUs are left idle. This doesn't play well with
> the approach of tracking emulated timer expiration by using the VMX
> preemption timer. Inactive VTL's timers are still meant to run and
> inject interrupts regardless of their runstate.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/lapic.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index f55d216cb2a0..8cc75b24381b 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -152,9 +152,10 @@ static bool kvm_can_post_timer_interrupt(struct kvm_vcpu *vcpu)
>  
>  bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu)
>  {
> -	return kvm_x86_ops.set_hv_timer
> -	       && !(kvm_mwait_in_guest(vcpu->kvm) ||
> -		    kvm_can_post_timer_interrupt(vcpu));
> +	return kvm_x86_ops.set_hv_timer &&
> +	       !(kvm_mwait_in_guest(vcpu->kvm) ||
> +		 kvm_can_post_timer_interrupt(vcpu)) &&
> +	       !(kvm_hv_vsm_enabled(vcpu->kvm));
>  }

This has to be fixed this way or another.

One idea is to introduce new MP state (KVM_MP_STATE_HALTED_USERSPACE), which will be set
on vCPUs that belong to inactive VTLs, and then userspace will do KVM_RUN which will block
as if it were for halted state but as soon as vCPU becomes unhalted, it will return to
the userspace instead of running again.

If we go with the approach of using polling on the inactive VTL's vcpus, then we can switch to a 
software timer just before we start polling.

Also note that AVIC/APICv and their IOMMU's have to be treated the same way. 

It is disabled during vCPU blocking due to the same reasons of vCPU not 
being assigned a physical CPU.

Currently it happens to work because you disable APIC accelerated map, which in turn disables (inhibits)
the APICv/AVIC.

Once again if we go with the approach of polling, we should ensure that polling does more or less
the same things as kvm_vcpu_block does (we should try to share as much code as possible as well).

Best regards,
	Maxim Levitsky






>  
>  static bool kvm_use_posted_timer_interrupt(struct kvm_vcpu *vcpu)




