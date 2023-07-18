Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E503757DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGRNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGRNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED25FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689687336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2LaaFEmvvvB0xki9wu2GO0q7MFq/vIR8nWYjwGiino=;
        b=IhwX5hhCfFDxYcuOvowkqeFEZlPq2cTgK+UAJA7JJIShNM/7PZpmASZsVRXTfYooeI11nS
        BCMpP2kgGvgLKfdQ8BEw4/26Lm4iZV/7kveVIcNhivmpuDhzPz33C9mnXkxyzRj+9lzB6G
        18SmQ5PyQ/FRoz+Ltr83Ob8eCzpHWEU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-uNDqW5uLNLuuMQbDJy8F7g-1; Tue, 18 Jul 2023 09:35:35 -0400
X-MC-Unique: uNDqW5uLNLuuMQbDJy8F7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3144bf68a03so3188483f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687333; x=1692279333;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2LaaFEmvvvB0xki9wu2GO0q7MFq/vIR8nWYjwGiino=;
        b=VsicE8xaaiwIt7sM5LDgifry2OMLQb3707m/jImhKeHHwD7wir76VxLN08YULOMUot
         K8c8HdKM8w8c5SyMga7YkvVDpKy0oUKWnzg0mbAxFD8qfFA57YSYHjtfUqP6k+XwrAQi
         XcCbEM8NrQIAW8u+IPY3At5p7ScaG/NjK3Pg9QzHS8PCB+2isb9JwyZppX3aP8IkwVBK
         Z86vmBTTdeYDBDYhd1+dZjUiqNL98fZC+Cy5e6DndXf49eJuEcfUXStzXYKCA27Fgbqg
         CaoMZu3k+En+CH4Z9+X3cubkny+37YHooN+LrKS4vpvf62LltasmHmA8uI3/FwbIxuS9
         c32g==
X-Gm-Message-State: ABy/qLZOUvAgL1n+7xfsf5mri6ZR5aAZjVuNyyIsXSmvDgxx8I9e+qQd
        hh1rHOUVNmWWWuBc4gVikT+En/YzptfaEifiagFa/5pHc1RiVEPxn0/xa4NW1PYgCCE/3M0QDvl
        vtPtXFH4ECZOF/54lluvlGtaY
X-Received: by 2002:adf:ea10:0:b0:314:35ce:a0e7 with SMTP id q16-20020adfea10000000b0031435cea0e7mr11759518wrm.16.1689687333461;
        Tue, 18 Jul 2023 06:35:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZWL+9fkZLh/smKE0EoU4uJcDq3ujLvyCnHIQA62ARVRcw+TfSmReG38Mw3lrq4NLZkhkg2w==
X-Received: by 2002:adf:ea10:0:b0:314:35ce:a0e7 with SMTP id q16-20020adfea10000000b0031435cea0e7mr11759501wrm.16.1689687333166;
        Tue, 18 Jul 2023 06:35:33 -0700 (PDT)
Received: from starship ([77.137.131.138])
        by smtp.gmail.com with ESMTPSA id k22-20020a5d5256000000b0031455482d1fsm2446514wrc.47.2023.07.18.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:35:32 -0700 (PDT)
Message-ID: <f867061cdc25ee887e43ebf6164733b309ccd631.camel@redhat.com>
Subject: Re: [PATCH 1/3] KVM: x86: VMX: __kvm_apic_update_irr must update
 the IRR atomically
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Date:   Tue, 18 Jul 2023 16:35:30 +0300
In-Reply-To: <bda79e85-c0bf-8d59-2750-d922a59bb859@redhat.com>
References: <20230718091310.119672-1-mlevitsk@redhat.com>
         <20230718091310.119672-2-mlevitsk@redhat.com>
         <bda79e85-c0bf-8d59-2750-d922a59bb859@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

У вт, 2023-07-18 у 13:41 +0200, Paolo Bonzini пише:
> On 7/18/23 11:13, Maxim Levitsky wrote:
> > +		irr_val = READ_ONCE(*((u32 *)(regs + APIC_IRR + i * 0x10)));
> 
> Let's separate out the complicated arithmetic, as it recurs below too:
> 
> 	u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);

No objections at all for this change, I wanted to have a minimal patch.

> 
> > +			while (!try_cmpxchg(((u32 *)(regs + APIC_IRR + i * 0x10)),
> > +			       &irr_val, irr_val | pir_val));
> > +
> >   			prev_irr_val = irr_val;
> > -			irr_val |= xchg(&pir[i], 0);
> > -			*((u32 *)(regs + APIC_IRR + i * 0x10)) = irr_val;
> > -			if (prev_irr_val != irr_val) {
> > -				max_updated_irr =
> > -					__fls(irr_val ^ prev_irr_val) + vec;
> > -			}
> > +			irr_val |= pir_val;
> > +
> > +			if (prev_irr_val != irr_val)
> > +				max_updated_irr = __fls(irr_val ^ prev_irr_val) + vec;
> 
> We can write this a bit more cleanly too, and avoid unnecessary

To be honest as far as I see, no matter what to do with this function, it is still
a bit complicated IMHO:

The root cause of the complexity in this function is that it does two things at the same time -
copies both the new bits to IRR and also counts the max_irr.

It would be so much cleaner to first copy new bits from PIR to irr (and that can be done
with 'lock or' or even by setting each bit with atomic bit set (in this way the setting of the bits
will be pretty much the same as what other users of IRR do (set bit atomically + set irr_pending).

And then let the common code count the max_irr.

I doubt this will affect performance in any way, but I don't have a good way to measure it,
so I won't be arguing about it.

On the other hand, I am thinking now that maybe I should make the cmpxchg conditional on
apicv beeing inhibited, as otherwise it works for nothing and actually might affect performance.

This though might in theory cause a race if a sender incorrectly thinks that this's vCPU APICv is
inhibited or not.

It probalby doesn't matter as the only reason for APICv to be inhibited is that AutoEOI thing which
should happen just once when the guest boots.


I also have another idea - I can make the IPI senders still set bits in the PIR even if APICv is inhibited, 
then there is no race to worry about although then the bits will always have to be copied from PIR to IRR
(but then again APICv inhibition is rare).



> try_cmpxchg too:
> 
> prev_irr_val = irr_val;
> do
> 	irr_val = prev_irr_val | pir_val;
> while (prev_irr_val != irr_val &&
>         !try_cmpxchg(p_irr, &prev_irr_val, irr_val));
> 
> if (prev_irr_val != irr_val)
> 	max_updated_irr = __fls(irr_val ^ prev_irr_val) + vec;
> 
> If this looks okay to you, I'll queue the patches for -rc3 and also Cc 
> them for inclusion in stable kernels.

No objections for this change as well.

Best regards,
	Maxim Levitsky

> 
> Paolo
> 


