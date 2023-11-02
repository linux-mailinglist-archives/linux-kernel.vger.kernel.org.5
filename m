Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332DF7DF9E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbjKBS0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKBS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF8128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698949556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nyr/rjASVZgore/effUX69OmjObVLQRl57xtQS7aR4A=;
        b=S9mvjyUCTSVI3HjgT0C2QEKcF4NxoV5snAhzUGuseW9HThPz5QDSAPskUDl/ANxI3CNOnO
        sYSqNIx0pSWCwIvT2rNZfQ3jKXofk12Xmg/MLffOwd1lWZVbKI4kis7z5DZMcxF3zWhhF8
        Zdw+zSFr3RohpL8lb63JyDZHiTkVy2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-TMNUtwKsM3CYup-zDsKZvQ-1; Thu, 02 Nov 2023 14:25:53 -0400
X-MC-Unique: TMNUtwKsM3CYup-zDsKZvQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32df2fc01e8so1492160f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949552; x=1699554352;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nyr/rjASVZgore/effUX69OmjObVLQRl57xtQS7aR4A=;
        b=dpXo8+3mbJaM6sP+Sms9CZtY3/4zMOj048J7IjVCKyNOR20sm8u03gRrpeFdz8ltNa
         mLwkM2wnElNhZnVevs1bT3jrqt6GLfNOA6Nkd3zF/meCTeDD+QLHQM4j0myVd4tp7svQ
         1d5cEvvibozkHg5umgZcC/pOnzMDlYzspWy7SMk44EzizfJW2fG9pEIUOUri8LB6Kj/S
         wQymxSV75CdXNoiUMX4OvJd+192S3ZrjSqJX6CLcbEWJzz+xLUZ6U/jSU1l5sUYzYsnc
         yPN2yCDOz5OLwoGBNxlgJmeaTqz/l+F0E5rKbh6lP5rlslWgH/v83lcNEd22MTY5xOOQ
         j1AA==
X-Gm-Message-State: AOJu0YwRAM1peKimwyP7osibn9LnYoDbQM3aDVRIqEvr5GLcw2F05+X1
        Pc/oMsvNdVMIXssgAPlDZREEaz5JMu2AXhhWa2Q0adRzTur5WgKT3DkYp0wp0i/85DWJKAK3DZf
        gEzTQ3y987jLXJntIb935ZcmK
X-Received: by 2002:a5d:6d06:0:b0:32f:8b51:3708 with SMTP id e6-20020a5d6d06000000b0032f8b513708mr425648wrq.2.1698949552326;
        Thu, 02 Nov 2023 11:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbUcKD6Y7mwpSG1ZMW9pt+dr50U4uwG/8pbBgzvj9lstd1lKKCldwBnC7m8GzjVFCE4IBcnQ==
X-Received: by 2002:a5d:6d06:0:b0:32f:8b51:3708 with SMTP id e6-20020a5d6d06000000b0032f8b513708mr425631wrq.2.1698949551939;
        Thu, 02 Nov 2023 11:25:51 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b004065daba6casm3747275wmb.46.2023.11.02.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:25:51 -0700 (PDT)
Message-ID: <d36ae1de672ce8eee122481448c5c5c4589cf8a6.camel@redhat.com>
Subject: Re: [PATCH v6 09/25] KVM: x86: Rework cpuid_get_supported_xcr0() to
 operate on vCPU data
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 02 Nov 2023 20:25:49 +0200
In-Reply-To: <ZUJjs2F-vD1-cZS4@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-10-weijiang.yang@intel.com>
         <96c30a78fa95071e87045b7293c2cf796d4182a0.camel@redhat.com>
         <ZUJjs2F-vD1-cZS4@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 07:41 -0700, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > > 
> > > Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU
> > > state, i.e. on a vCPU's CPUID state.  Prior to commit 275a87244ec8 ("KVM:
> > > x86: Don't adjust guest's CPUID.0x12.1 (allowed SGX enclave XFRM)"), KVM
> > > incorrectly fudged guest CPUID at runtime,
> > Can you explain how commit 275a87244ec8 relates to this patch?
> > 
> > > which in turn necessitated massaging the incoming CPUID state for
> > > KVM_SET_CPUID{2} so as not to run afoul of kvm_cpuid_check_equal().
> > 
> > Can you link the commit that added this 'massaging' and explain on how this
> > relates to this patch?
> 
> It's commit 275a87244ec8, which is right above.  I think the missing part is an
> explicit call out that the massaging used cpuid_get_supported_xcr0() with the
> incoming "struct kvm_cpuid_entry2", i.e. without a "struct kvm_vcpu".
> 
> > Can you explain what is the problem that this patch is trying to solve?
> 
> Is this better?
> 
> --
> Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU
> state, i.e. on a vCPU's CPUID state, now that the only usage of the helper
> is to retrieve a vCPU's already-set CPUID.
> 
> Prior to commit 275a87244ec8 ("KVM: x86: Don't adjust guest's CPUID.0x12.1
> (allowed SGX enclave XFRM)"), KVM incorrectly fudged guest CPUID at
> runtime, which in turn necessitated massaging the incoming CPUID state for
> KVM_SET_CPUID{2} so as not to run afoul of kvm_cpuid_check_equal().  I.e.
> KVM also invoked cpuid_get_supported_xcr0() with the incoming CPUID state,
> and thus without an explicit vCPU object.

Ah, I understand you. I incorrectly assumed that KVM doesn't allow different CPUID
on different vCPUs, while the actual restriction that was recently placed was
to not allow changing a vCPU's CPUID, once a vCPU was in a guest mode once.

I also understand what you mean in regard to the commit 275a87244ec8 but IMHO
this part of the commit message is only adding to the confusion.

I think that this will be a better commit message:


"Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU state
i.e. on a vCPU's CPUID state.

This is needed because KVM permits different vCPUs to have different CPUIDs, 
and thus it is valid for each vCPU to have different set of supported bits in the XCR0"

> --
> 
> > Is it really allowed in x86 spec to have different supported mask of XCR0 bits
> > on different CPUs (assuming all CPUs of the same type)?
> 
> Yes, nothing in the SDM explicitly states that all cores in have identical feature
> sets.  And "assuming all CPUs of the same type" isn't really a valid constraint
> because it's very doable to put different SKUs into a multi-socket system.
> 
> Intel even (somewhat inadvertantly) kinda sorta shipped such CPUs, as Alder Lake
> P-cores support AVX512 but E-cores do not, and IIRC early (pre-production?) BIOS
> didn't disable AVX512 on the P-Cores, i.e. software could observe cores with and
> without AVX512.  That quickly got fixed because it confused software, but until
> Intel squashed AVX512 entirely with a microcode update, disabling E-Cores in BIOS
> would effectively enable AVX512 on the remaining P-Cores.

Yea, sure I know about this, that's why I said "same type". I just was under the impression
that KVM doesn't 'officially' support heterogeneous vCPUs and recently added a check
to ensure that all vCPUs have the same CPUID. Now I understand.

> 
> And it's not XCR0-related, but PMUs on Alder Lake (and all Intel hybrid CPUs) are
> truly heterogenous.  It's a mess for virtualization, but concrete proof that there
> are no architectural guarantees regarding homogeneity of feature sets.
> 
> > If true, does KVM supports it?
> 
> Yes.  Whether or not that's a good thing is definitely debatle, bug KVM's ABI for
> a very long time has allowed userspace to expose whatever it wants via KVM_SET_CPUID.

> 
> Getting (guest) software to play nice is an entirely different matter, but exposing
> heterogenous vCPUs isn't an architectural violation.
> 

Best regards,
	Maxim Levitsky


