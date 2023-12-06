Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B78074CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379318AbjLFQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378358AbjLFQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C518D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701879616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/Q8rdpQLGJDQtjt7EUY5rfj9IQLbZ3N/w3XKiq7Zp8=;
        b=TpTmEJBoX+djj9ILv/DaL4ivOAC7nwMpsj5pMZ9uR8WgjAds8tUWqOlzYMULUCYwQCSZEQ
        GhYqgaF/20T9naQ6NlfmDYPo/qf/3OrxN+Vpp+cO/Ypyz5aHmqbxW7G2zpSpKOXM51gWNe
        F1IM2kOEBUZrTdsSaUDfxmhq6hEV1u8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-RS1cUJGMPtG_zjZkinS0SA-1; Wed, 06 Dec 2023 11:20:14 -0500
X-MC-Unique: RS1cUJGMPtG_zjZkinS0SA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33331e69698so813042f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879594; x=1702484394;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/Q8rdpQLGJDQtjt7EUY5rfj9IQLbZ3N/w3XKiq7Zp8=;
        b=TYgsFO7fgH9hTN2B+Pco1mM9HwDaxKsdRU5pgUyJhG4eHS3HfUXZn1u93BCsIqEWMT
         ZVPjOuInxV/m6u9v8XAgMz4Hfl217K2LnT6FSuUQ+hurm2QxjIKz84bgVyWX5CProny3
         r9dQDxjbdy2ElZP6iQZdgS85VdGkl6FQAjRXt6s1y7w3nmM18TUAlWV3IOBJjvyyQv7l
         o6Q4pkmtwalO5Es8ncqr5z2XSsBfdrcFUN/F4wBioVMK3X7qc3cO44ZVDamrwXwcZDDv
         AqqYrO0htUvDLu3QDjhY1I7yOgwMCv706LdNDj46SA+YfrXI2xhsJHk6/zdCaxEmyyPT
         tLtg==
X-Gm-Message-State: AOJu0Yzwv8bqjBs0w2kRZyUVz/8kE4EiwbvD79DAZXwSdR+29PTk43BL
        tz98UNFGjJtEw6g6tjXJd9XGLjrwXxjybXXldIjtdFd9BNJDL2FHarjf5YSlMgpyxbhAn55jF8m
        Sk7aApPzPPii04IlIp7l8O8db
X-Received: by 2002:a05:600c:1e18:b0:40c:2101:dab2 with SMTP id ay24-20020a05600c1e1800b0040c2101dab2mr485145wmb.185.1701879594036;
        Wed, 06 Dec 2023 08:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4xLDaJ0nX52wZDtegFdbDV/Vhk4LlL67t4ugX51B9lLHdkt4Pwtf1OhZN87CJx1NsN5/KNQ==
X-Received: by 2002:a05:600c:1e18:b0:40c:2101:dab2 with SMTP id ay24-20020a05600c1e1800b0040c2101dab2mr485124wmb.185.1701879593670;
        Wed, 06 Dec 2023 08:19:53 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d408f000000b00333381c6e12sm59389wrp.40.2023.12.06.08.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:19:53 -0800 (PST)
Message-ID: <afb23eab62a9a0f3dce360579e9aeefa5a3f1548.camel@redhat.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com,
        graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Date:   Wed, 06 Dec 2023 18:19:51 +0200
In-Reply-To: <ZW-7Mwev4Ilf541L@google.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-6-nsaenz@amazon.com>
         <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
         <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com> <ZWoKlJUKJGGhRRgM@google.com>
         <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com> <ZWocI-2ajwudA-S5@google.com>
         <CXD7AW5T9R7G.2REFR2IRSVRVZ@amazon.com> <ZW94T8Fx2eJpwKQS@google.com>
         <fc09fec34a89ba7655f344a31174d078a8248182.camel@redhat.com>
         <ZW-7Mwev4Ilf541L@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Tue, 2023-12-05 at 16:07 -0800, Sean Christopherson wrote:
> On Tue, Dec 05, 2023, Maxim Levitsky wrote:
> > On Tue, 2023-12-05 at 11:21 -0800, Sean Christopherson wrote:
> > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > On Fri Dec 1, 2023 at 5:47 PM UTC, Sean Christopherson wrote:
> > > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > > On Fri Dec 1, 2023 at 4:32 PM UTC, Sean Christopherson wrote:
> > > > > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > > > > > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > > > > > > > > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> > > > > > > > 
> > > > > > > > I thought about it at the time. It's not that simple though, we should
> > > > > > > > still let KVM set the hypercall bytecode, and other quirks like the Xen
> > > > > > > > one.
> > > > > > > 
> > > > > > > Yeah, that Xen quirk is quite the killer.
> > > > > > > 
> > > > > > > Can you provide pseudo-assembly for what the final page is supposed to look like?
> > > > > > > I'm struggling mightily to understand what this is actually trying to do.
> > > > > > 
> > > > > > I'll make it as simple as possible (diregard 32bit support and that xen
> > > > > > exists):
> > > > > > 
> > > > > > vmcall             <-  Offset 0, regular Hyper-V hypercalls enter here
> > > > > > ret
> > > > > > mov rax,rcx  <-  VTL call hypercall enters here
> > > > > 
> > > > > I'm missing who/what defines "here" though.  What generates the CALL that points
> > > > > at this exact offset?  If the exact offset is dictated in the TLFS, then aren't
> > > > > we screwed with the whole Xen quirk, which inserts 5 bytes before that first VMCALL?
> > > > 
> > > > Yes, sorry, I should've included some more context.
> > > > 
> > > > Here's a rundown (from memory) of how the first VTL call happens:
> > > >  - CPU0 start running at VTL0.
> > > >  - Hyper-V enables VTL1 on the partition.
> > > >  - Hyper-V enabled VTL1 on CPU0, but doesn't yet switch to it. It passes
> > > >    the initial VTL1 CPU state alongside the enablement hypercall
> > > >    arguments.
> > > >  - Hyper-V sets the Hypercall page overlay address through
> > > >    HV_X64_MSR_HYPERCALL. KVM fills it.
> > > >  - Hyper-V gets the VTL-call and VTL-return offset into the hypercall
> > > >    page using the VP Register HvRegisterVsmCodePageOffsets (VP register
> > > >    handling is in user-space).
> > > 
> > > Ah, so the guest sets the offsets by "writing" HvRegisterVsmCodePageOffsets via
> > > a HvSetVpRegisters() hypercall.
> > 
> > No, you didn't understand this correctly. 
> > 
> > The guest writes the HV_X64_MSR_HYPERCALL, and in the response hyperv fills
> 
> When people say "Hyper-V", do y'all mean "root partition"?  
> If so, can we just
> say "root partition"?  Part of my confusion is that I don't instinctively know
> whether things like "Hyper-V enables VTL1 on the partition" are talking about the
> root partition (or I guess parent partition?) or the hypervisor.  Functionally it
> probably doesn't matter, it's just hard to reconcile things with the TLFS, which
> is written largely to describe the hypervisor's behavior.
> 
> > the hypercall page, including the VSM thunks.
> > 
> > Then the guest can _read_ the offsets, hyperv chose there by issuing another hypercall. 
> 
> Hrm, now I'm really confused.  Ah, the TLFS contradicts itself.  The blurb for
> AccessVpRegisters says:
> 
>   The partition can invoke the hypercalls HvSetVpRegisters and HvGetVpRegisters.
> 
> And HvSetVpRegisters confirms that requirement:
> 
>   The caller must either be the parent of the partition specified by PartitionId,
>   or the partition specified must be “self” and the partition must have the
>   AccessVpRegisters privilege
> 
> But it's absent from HvGetVpRegisters:
> 
>   The caller must be the parent of the partition specified by PartitionId or the
>   partition specifying its own partition ID.

Yes, it is indeed very strange, that a partition would do a hypercall to read its own
registers - but then the 'register' is also not really a register but more of a 'hack', and I guess
they allowed it in this particular case. That is why I wrote the 'another hypercall'
thing, because it is very strange that they (ab)used the HvGetVpRegisters for that.


But regardless of the above, guests (root partition or any other partition) do the
VTL calls, and in order to do a VTL call, that guest has to know the hypercall page offsets,
and for that the guest has to do the HvGetVpRegisters hypercall first.

> 
> > In the current implementation, the offsets that the kernel choose are first
> > exposed to the userspace via new ioctl, and then the userspace exposes these
> > offsets to the guest via that 'another hypercall' (reading a pseudo partition
> > register 'HvRegisterVsmCodePageOffsets')
> > 
> > I personally don't know for sure anymore if the userspace or kernel based
> > hypercall page is better here, it's ugly regardless :(
> 
> Hrm.  Requiring userspace to intercept the WRMSR will be a mess because then KVM
> will have zero knowledge of the hypercall page, e.g. userspace would be forced to
> intercept HV_X64_MSR_GUEST_OS_ID as well.
>   That's not the end of the world, but
> it's not exactly ideal either.
> 
> What if we exit to userspace with a new kvm_hyperv_exit reason that requires
> completion? 

BTW the other option is to do the whole thing in kernel - the offset bug in the hypercall page
can be easily solved with a variable, and then the kernel can also intercept the HvGetVpRegisters
hypercall and return these offsets for HvRegisterVsmCodePageOffsets, and for all
other VP registers it can still exit to userspace - that way we also avoid adding a new ioctl,
and have the whole thing in one place.

All of the above can even be done unconditionally (or be conditionally tied to a Kconfig option),
because it doesn't add much overhead and neither should break backward compatibility - I don't think
hyperv guests rely on hypervisor not touching the hypercall page beyond the few bytes that KVM
does write currently.

Best regards,
	Maxim Levitsky


>  I.e. punt to userspace if VSM is enabled, but still record the data
> in KVM?  Ugh, but even that's a mess because kvm_hv_set_msr_pw() is deep in the
> WRMSR emulation call stack and can't easily signal that an exit to userspace is
> needed.  Blech.
> 


