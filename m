Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C08805C18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442356AbjLEPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442295AbjLEPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:03:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A19A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701788628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVfnz9yEraI13QEVMWCv15KSWf2rbynT5uHuzX4Khhk=;
        b=LyhMJJTAqdInVyR0faXIRxqqqqpSv32cEk/bgFsreBzn1Do6gfI2JHT8ivIZPO1C/wu/mz
        qzeQSH1BpnmXyluxLHSpfaWKNRtCPsyVjW8k9c4wcnpXqo7N2jN1ktGPirZZBDcv7xaUOf
        LfPebx8TLM3IMm+7xPJ6d/Q/gsU9vjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-M3SIRF14OnaXyMpF1oniZQ-1; Tue, 05 Dec 2023 10:02:48 -0500
X-MC-Unique: M3SIRF14OnaXyMpF1oniZQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083717431eso40680835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788563; x=1702393363;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVfnz9yEraI13QEVMWCv15KSWf2rbynT5uHuzX4Khhk=;
        b=bDXBqWa5DrczRTdXf8A7KF8nOagAnIlsDADOL9cN6yNHYqIWuDfcWjdVtyOrrX7Tfs
         YnqukfKh8UCRTMcu4Z2uyXYKzQCw357pq55ILwHNz+I8eC0t4bwe3fAulnJq+Wi0F6wV
         O9rFb/oNaB/uZujF+rAUqB/+1pDeXONcvS79Po4cCpVIMNo/IlkGb99+GPrdTj2PKyt/
         xbbi6jDnZiVTNoS/lU8dPInQsc3APnRkfxnHR8z5dLJuD71GMPEEzNuQIA5hm3HIy1ev
         WW1rbz1Zrq917oZfonui0B/iC9EWV9Did6wIgRGg0N3ISqg+STzOcU8FD676XjA9Or9U
         zRFg==
X-Gm-Message-State: AOJu0YyLVmhDcYHnXWCbinuTD34bqS30bF9mSg7k5SBB2DdxTnkvVe6g
        1Gp5NVwerdCjxRAtwLPhqwB2vdrxxED/XNwTZOt8xw4M3yKfOA6ngnehJbxYPreDpP850ipqUej
        M7+ls0ED7ivv51PwwbUScfm00
X-Received: by 2002:a05:600c:4506:b0:40b:37ef:3671 with SMTP id t6-20020a05600c450600b0040b37ef3671mr4708319wmo.38.1701788563080;
        Tue, 05 Dec 2023 07:02:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw+ZIqFfTxBo1MNegF8bmaDRUQK0S0GcC3WZpfcXrIP2tAUAD/esumx04OeKShDkq6yYuUlA==
X-Received: by 2002:a05:600c:4506:b0:40b:37ef:3671 with SMTP id t6-20020a05600c450600b0040b37ef3671mr4708304wmo.38.1701788562696;
        Tue, 05 Dec 2023 07:02:42 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm18964395wmq.14.2023.12.05.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:02:42 -0800 (PST)
Message-ID: <72ab3fa2932dc661a4e0e124ac630e6bb269ebd4.camel@redhat.com>
Subject: Re: [RFC 06/33] KVM: x86: hyper-v: Introduce VTL awareness to
 Hyper-V's PV-IPIs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 05 Dec 2023 17:02:40 +0200
In-Reply-To: <CXD538WSGHGC.BMUQF0OJSSW4@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-7-nsaenz@amazon.com>
         <9249b4b84f7b84da2ea21fbbbabf35f22e5d9f2f.camel@redhat.com>
         <CXD538WSGHGC.BMUQF0OJSSW4@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Fri, 2023-12-01 at 16:31 +0000, Nicolas Saenz Julienne wrote:
> On Tue Nov 28, 2023 at 7:14 AM UTC, Maxim Levitsky wrote:
> > On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> > > HVCALL_SEND_IPI and HVCALL_SEND_IPI_EX allow targeting specific a
> > > specific VTL. Honour the requests.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > > ---
> > >  arch/x86/kvm/hyperv.c             | 24 +++++++++++++++++-------
> > >  arch/x86/kvm/trace.h              | 20 ++++++++++++--------
> > >  include/asm-generic/hyperv-tlfs.h |  6 ++++--
> > >  3 files changed, 33 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > > index d4b1b53ea63d..2cf430f6ddd8 100644
> > > --- a/arch/x86/kvm/hyperv.c
> > > +++ b/arch/x86/kvm/hyperv.c
> > > @@ -2230,7 +2230,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
> > >  }
> > > 
> > >  static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
> > > -                                 u64 *sparse_banks, u64 valid_bank_mask)
> > > +                                 u64 *sparse_banks, u64 valid_bank_mask, int vtl)
> > >  {
> > >       struct kvm_lapic_irq irq = {
> > >               .delivery_mode = APIC_DM_FIXED,
> > > @@ -2245,6 +2245,9 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
> > >                                           valid_bank_mask, sparse_banks))
> > >                       continue;
> > > 
> > > +             if (kvm_hv_get_active_vtl(vcpu) != vtl)
> > > +                     continue;
> > 
> > Do I understand correctly that this is a temporary limitation?
> > In other words, can a vCPU running in VTL1 send an IPI to a vCPU running VTL0,
> > forcing the target vCPU to do async switch to VTL1?
> > I think that this is possible.
> 
> The diff is missing some context. See this simplified implementation
> (when all_cpus is set in the parent function):
> 
> static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector, int vtl)
> {
> 	[...]
> 	kvm_for_each_vcpu(i, vcpu, kvm) {
> 		if (kvm_hv_get_active_vtl(vcpu) != vtl)
> 			continue;
> 
> 		kvm_apic_set_irq(vcpu, &irq, NULL);
> 	}
> }
> 
> With the one vCPU per VTL approach, kvm_for_each_vcpu() will iterate
> over *all* vCPUs regardless of their VTL. The IPI is targetted at a
> specific VTL, hence the need to filter.
> 
> VTL1 -> VTL0 IPIs are supported and happen (although they are extremely
> rare).

Makes sense now, thanks!

Best regards,
	Maxim Levitsky

> 
> Nicolas
> 


