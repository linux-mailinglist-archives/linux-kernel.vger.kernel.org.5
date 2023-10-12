Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56717C7709
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442431AbjJLThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442423AbjJLThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462EE7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697139411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmGTrpqewTswoSpR8DSjj/XKiSXLuGXnUJ07rtGjW3w=;
        b=GmE4YdRIuDACklyF0O4QEJr2riVuLOo84p1FLChuULB1tOC6T0lYhcucZQ6bjLseQRs1sv
        bdGJiPe7psZkUfqJX8zhMcMSKVF9uJApsZ9vAaNkd7VKSeUNNeuoP4ILkQgc4lcxbUuTbk
        pTqMxVf53PQW+tTpPTJMj8zsmTeY0wo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-2bI77RChP-mBz4ac3ldM1Q-1; Thu, 12 Oct 2023 15:36:49 -0400
X-MC-Unique: 2bI77RChP-mBz4ac3ldM1Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so9359215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139408; x=1697744208;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmGTrpqewTswoSpR8DSjj/XKiSXLuGXnUJ07rtGjW3w=;
        b=DNF1AtlLqMume/aV6wYIQF/jFW9xobFBkxXmFPYIr8Up7bJoTIEpJa6fAnu75b/DzZ
         uH4+qQnN3EsV+1/d62okGEckkNLIw0xsFGOfez7ql99rWtq+DxwXhxmJeBVjpl3JE11C
         68AYA53Q/kbbvwUfbqvThBF8EHvJ+YEAGAJ1dQBJ7sxPn4UnOCvRKjEMRymXBlhfY8tT
         8Rkg5cF4ds9FIlrx0ZpYrOUUxUTV629+gGXmpRiCfzMOCOYeXi8Y/bmCF6YpMy5kzCXV
         vmMC7nNdPnmJXHl0cHnCRJeuHiXKkUeLIFSnNiobDISFs6Kl3xj5wfrzCzB52D3tfVtG
         dr5Q==
X-Gm-Message-State: AOJu0YxjY7MGfhz09vAebLo4lTdLzNWJgjkBqIC39iT81WEsmIwF6bm9
        g6GM9qAQ5fMsK5YDHT6wZTXrMugkgV1msEwA9RWb0KXtM3ThvpFhxPUIEBl4VkyxK+xvmkDIK6g
        8H/VmvdUE5Fw4uZ8yq48kdwL8
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id f10-20020a7bcd0a000000b004053ae62400mr22255821wmj.23.1697139408469;
        Thu, 12 Oct 2023 12:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOAOzz/cLP+Oxa/tpzHOxH6BXt14cWwi5HOdf5y4AwQ3CspFA5TqiBHR+WxotrzT8LKLVTQw==
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id f10-20020a7bcd0a000000b004053ae62400mr22255808wmj.23.1697139408172;
        Thu, 12 Oct 2023 12:36:48 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c020100b003feea62440bsm604911wmi.43.2023.10.12.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:36:47 -0700 (PDT)
Message-ID: <e9092c88813a9cfa9d02928eb818788a0af1147c.camel@redhat.com>
Subject: Re: [PATCH RFC 05/11] KVM: x86: hyper-v: Introduce
 kvm_hv_synic_has_vector()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 12 Oct 2023 22:36:46 +0300
In-Reply-To: <20231010160300.1136799-6-vkuznets@redhat.com>
References: <20231010160300.1136799-1-vkuznets@redhat.com>
         <20231010160300.1136799-6-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-10-10 у 18:02 +0200, Vitaly Kuznetsov пише:
> As a preparation to making Hyper-V emulation optional, create a dedicated
> kvm_hv_synic_has_vector() helper to avoid extra ifdefs in lapic.c.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.h | 5 +++++
>  arch/x86/kvm/lapic.c  | 3 +--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 1897a219981d..ddb1d0b019e6 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -105,6 +105,11 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vcpu_id, u32 sint);
>  void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector);
>  int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages);
>  
> +static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
> +{
> +	return to_hv_vcpu(vcpu) && test_bit(vector, to_hv_synic(vcpu)->vec_bitmap);
> +}
> +
>  static inline bool kvm_hv_synic_auto_eoi_set(struct kvm_vcpu *vcpu, int vector)
>  {
>  	return to_hv_vcpu(vcpu) && test_bit(vector, to_hv_synic(vcpu)->auto_eoi_bitmap);
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0e80c1fdf899..37904c5d421b 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1475,8 +1475,7 @@ static int apic_set_eoi(struct kvm_lapic *apic)
>  	apic_clear_isr(vector, apic);
>  	apic_update_ppr(apic);
>  
> -	if (to_hv_vcpu(apic->vcpu) &&
> -	    test_bit(vector, to_hv_synic(apic->vcpu)->vec_bitmap))
> +	if (kvm_hv_synic_has_vector(apic->vcpu, vector))
>  		kvm_hv_synic_send_eoi(apic->vcpu, vector);
>  
>  	kvm_ioapic_send_eoi(apic, vector);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com

Best regards,
	Maxim Levitsky

