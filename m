Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324B7C76E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442189AbjJLTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442138AbjJLTbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A0D50
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697139048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/o6fFvR6aJCe+ERX9AGeyChFFO9xwdSMnRWAOtIGn0=;
        b=d1WnjdvNMjW9lSJh5plKfyWSTyzhIYTi8h2atI290t8k+Pm1gmzv6M1QYAjyDRYoc/Zr1I
        uxVgM5VaD3CBvbxB4cFpKPSJDCUyXVwTgTP0girHi0VDCRI4zDbh2HzeVXa+HZVMpfYnWV
        LTKFFtYOYRv+XsqOUZm+Y6j4z8hTJi4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-wFaJ1ldFOp6yDNQFg7amtw-1; Thu, 12 Oct 2023 15:30:46 -0400
X-MC-Unique: wFaJ1ldFOp6yDNQFg7amtw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32480c0ad52so870612f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139046; x=1697743846;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/o6fFvR6aJCe+ERX9AGeyChFFO9xwdSMnRWAOtIGn0=;
        b=EDJjIM8rVCaWSlI5itmiJqURcPYnWa8R62Yg/TpvS/5YbBk0sKGSuHiiFtIWqU6cdw
         dEkQeMDEYW39mBSg6ko9Q79+fR14AmcQoFKxZWMd/4VB/ncEdcLdo7y+GyI9djwn7GF2
         v1/KT2Nz9y2TqxNNjB+Gxgatl5d0hXLhz0lWWnvmcnhXqMCI+rJW/5ili3U1ytQ1mBEv
         tT2pBmUBQIhG34+s91zfpE+NdIw7nZYBGBFBwuWC/xEOWlieB349ZmRr4eFGVXhW9g3Q
         MSar82aCuJddJnlF50LZzKRb/e+Q9ISJTPTQ57Smj7Qi/8E4ZZ/qo1zCiVaXgntnV+aC
         VdsA==
X-Gm-Message-State: AOJu0YyRkyCdEpWXVFBJCVr1OMq/MHoXqM3FER39LUgDjaZcM5dGNM6S
        Ocdsy1K2N4kLLhVnbyBs3yU4uEqcvmqxIQZp8ggyKKYcOshYINKjRARwS0DDL/X1S0QHMCghm6t
        5a4vcVxWXgNZA4bbqK2tbpvTq
X-Received: by 2002:a5d:6549:0:b0:319:6caa:ada2 with SMTP id z9-20020a5d6549000000b003196caaada2mr21239022wrv.47.1697139045757;
        Thu, 12 Oct 2023 12:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqD7pOjEEChf/y/tkmRxDwOYPb4DVFbtfiY0+0Y5uTpWha0h5XrZV4W2aLQC5muYPI+mcOLA==
X-Received: by 2002:a5d:6549:0:b0:319:6caa:ada2 with SMTP id z9-20020a5d6549000000b003196caaada2mr21239010wrv.47.1697139045438;
        Thu, 12 Oct 2023 12:30:45 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id bv2-20020a0560001f0200b0032d09f7a713sm8387635wrb.18.2023.10.12.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:30:44 -0700 (PDT)
Message-ID: <f7197f64bbac99860ddfeee540c9e44075a29f43.camel@redhat.com>
Subject: Re: [PATCH RFC 01/11] KVM: x86: xen: Remove unneeded xen context
 from struct kvm_arch when !CONFIG_KVM_XEN
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 12 Oct 2023 22:30:43 +0300
In-Reply-To: <20231010160300.1136799-2-vkuznets@redhat.com>
References: <20231010160300.1136799-1-vkuznets@redhat.com>
         <20231010160300.1136799-2-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-10-10 у 18:02 +0200, Vitaly Kuznetsov пише:
> Saving a few bytes of memory per KVM VM is certainly great but what's more
> important is the ability to see where the code accesses Xen emulation
> context while CONFIG_KVM_XEN is not enabled. Currently, kvm_cpu_get_extint()
> is the only such place and it is harmless: kvm_xen_has_interrupt() always
> returns '0' when !CONFIG_KVM_XEN.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 5 +++++
>  arch/x86/kvm/irq.c              | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 17715cb8731d..e5d4b8a44630 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1126,6 +1126,7 @@ struct msr_bitmap_range {
>  	unsigned long *bitmap;
>  };
>  
> +#ifdef CONFIG_KVM_XEN
>  /* Xen emulation context */
>  struct kvm_xen {
>  	struct mutex xen_lock;
> @@ -1137,6 +1138,7 @@ struct kvm_xen {
>  	struct idr evtchn_ports;
>  	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
>  };
> +#endif
>  
>  enum kvm_irqchip_mode {
>  	KVM_IRQCHIP_NONE,
> @@ -1338,7 +1340,10 @@ struct kvm_arch {
>  	struct hlist_head mask_notifier_list;
>  
>  	struct kvm_hv hyperv;
> +
> +#ifdef CONFIG_KVM_XEN
>  	struct kvm_xen xen;
> +#endif
>  
>  	bool backwards_tsc_observed;
>  	bool boot_vcpu_runs_old_kvmclock;
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index b2c397dd2bc6..ad9ca8a60144 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -118,8 +118,10 @@ static int kvm_cpu_get_extint(struct kvm_vcpu *v)
>  	if (!lapic_in_kernel(v))
>  		return v->arch.interrupt.nr;
>  
> +#ifdef CONFIG_KVM_XEN
>  	if (kvm_xen_has_interrupt(v))
>  		return v->kvm->arch.xen.upcall_vector;
> +#endif
>  
>  	if (irqchip_split(v->kvm)) {
>  		int vector = v->arch.pending_external_vector;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

