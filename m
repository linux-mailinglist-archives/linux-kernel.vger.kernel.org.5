Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C21812165
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442789AbjLMWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9859BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702506357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtHNIqYNLvneVefWnBC6zOfsKWdZrXaTN0MEXSsNlm4=;
        b=Rmkb2yODSi2De1AAGZTsceFTfeeBTexRdmVxK6k9A2AmIuIe6ba6KkKdMB5bQBBUSMNBwy
        hxzc5ewD84q5lO/6dzWIuMSkZivZSWsJAE4rLQ78O28AQyeP8/8AVD2tm12uWW3V4URhkN
        FJH7jc5KyW6m5rbryI++UG3MR90cvt4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-h9tjRpSyM9yUaBg4mBdBpw-1; Wed, 13 Dec 2023 17:25:55 -0500
X-MC-Unique: h9tjRpSyM9yUaBg4mBdBpw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c22bc1ebdso50865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702506354; x=1703111154;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtHNIqYNLvneVefWnBC6zOfsKWdZrXaTN0MEXSsNlm4=;
        b=aQdsAjU9K2HjHemLeHkjyoJRxCpJk8+QfB13l0suTASL+xO6zX6F/BzCumeo3CzO5j
         Tmn59cIXcVlc2zYq9QovLQ/pgCx9g2GDQBeHSdYxs6+Mpu6vHTMkk5XGKTVs0VuF4l96
         HmK8QvdL/GeoudNB7ePNyQvkkumeBO1zQ0i1KcFmB4oFf/pF/Ofa3va0M3SVd1qi0m1w
         o+b6K+DS6xn7HLlHjoIGH40hLhKdltj1zqhXAg4lmONASuAU1aX3LDMWbuNnPWVzphLH
         YYPpN5T67Wwp073iXkOS6w3pxZzmIJ1CzqVXP60KgfxlQuOwUkahuWk702ASWt8mx7ze
         4dfg==
X-Gm-Message-State: AOJu0YwPEiBEkP1ZnANyNUE6FuHoT2CHdAbvBY/H3ATXWjBv4fLIKug6
        me8llRkF0HPeH1qZSbOboOXIhKL8IRFOoFPOvP1b9iZAuleSPq9ivjo55/k8ADamHfUJ0tX2R0k
        mfqZKzGjwtPMgFfhCa3R7zwId
X-Received: by 2002:a05:600c:518a:b0:40b:5e4a:2354 with SMTP id fa10-20020a05600c518a00b0040b5e4a2354mr4800767wmb.86.1702506354406;
        Wed, 13 Dec 2023 14:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq5vSBS9iWIl4hhY+47LaF7O2e11U2yVs0UmGQ3dWeLwMn5yVhoe2ukGq+e6/HNoX4k1QrCw==
X-Received: by 2002:a05:600c:518a:b0:40b:5e4a:2354 with SMTP id fa10-20020a05600c518a00b0040b5e4a2354mr4800760wmb.86.1702506354019;
        Wed, 13 Dec 2023 14:25:54 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm24509354wms.30.2023.12.13.14.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:25:53 -0800 (PST)
Message-ID: <5ca5592b21131f515e296afae006e5bb28b1fb87.camel@redhat.com>
Subject: Re: [PATCH v4 10/12] KVM: x86: never write to memory from
 kvm_vcpu_check_block()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     alexandru.elisei@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org,
        borntraeger@linux.ibm.com, chenhuacai@kernel.org, david@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com
Date:   Thu, 14 Dec 2023 00:25:50 +0200
In-Reply-To: <ZXh8Nq_y_szj1WN0@google.com>
References: <20220921003201.1441511-11-seanjc@google.com>
         <20231207010302.2240506-1-jmattson@google.com>
         <ZXHw7tykubfG04Um@google.com>
         <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
         <ZXh8Nq_y_szj1WN0@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 07:28 -0800, Sean Christopherson wrote:
> On Sun, Dec 10, 2023, Jim Mattson wrote:
> > On Thu, Dec 7, 2023 at 8:21 AM Sean Christopherson <seanjc@google.com> wrote:
> > > Doh.  We got the less obvious cases and missed the obvious one.
> > > 
> > > Ugh, and we also missed a related mess in kvm_guest_apic_has_interrupt().  That
> > > thing should really be folded into vmx_has_nested_events().
> > > 
> > > Good gravy.  And vmx_interrupt_blocked() does the wrong thing because that
> > > specifically checks if L1 interrupts are blocked.
> > > 
> > > Compile tested only, and definitely needs to be chunked into multiple patches,
> > > but I think something like this mess?
> > 
> > The proposed patch does not fix the problem. In fact, it messes things
> > up so much that I don't get any test results back.
> 
> Drat.
> 
> > Google has an internal K-U-T test that demonstrates the problem. I
> > will post it soon.
> 
> Received, I'll dig in soonish, though "soonish" might unfortunately might mean
> 2024.
> 

Hi,

So this is what I think:


KVM does have kvm_guest_apic_has_interrupt() for this exact purpose,
to check if nested APICv has a pending interrupt before halting.


However the problem is bigger - with APICv we have in essence 2 pending interrupt
bitmaps - the PIR and the IRR, and to know if the guest has a pending interrupt
one has in theory to copy PIR to IRR, then see if the max is larger then the current PPR.

Since we don't want to write to guest memory, and the IRR here resides in the guest memory,
I guess we have to do a 'dry-run' version of 'vmx_complete_nested_posted_interrupt' and call
it from  kvm_guest_apic_has_interrupt().

What do you think? I can prepare a patch for this.

Can you share a reproducer or write a new one that can be shared?

Best regards,
	Maxim Levitsky

