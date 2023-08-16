Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0D77E3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbjHPOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjHPOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:42:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20326BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:42:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bde8160fbdso36991885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692196957; x=1692801757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+NKKfGEeZmwLeWjKJlNSbTEwrWsyhKqsr/nfdnWkMI=;
        b=PvGRNivZAHac1lVhb7q2gfjl72s07J4x8rqc+JmqafvaLh/c6zZHA4Y+6vlWDoRXSb
         Wzbc0TNO7hO//fE3xUEURlTA3aAm07ld2+GTNXu/SaB3S1h+zQS3UaAynNU4//QYqMRH
         hE/7x4TIZgKHm1lT/jWGeJIzKZ0xpFukyOCl9PUmRaiFm2QkFF3qeYbpQt+J6behjuR1
         C0d2x2nzgjqYNL2yM8bhDkCpVNVdPJbN+oOFPniRM2p2xQtoWLgfZb44NEpoye1/+Wpt
         QzrrfCHIiAzdG6XIR2x5oO0KKpehZlCAGwkOtW803Y0Y6YnMvgBGchKfdqCyZY8Y/nl6
         XfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196957; x=1692801757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+NKKfGEeZmwLeWjKJlNSbTEwrWsyhKqsr/nfdnWkMI=;
        b=ACnfcEQr21cYbzl0WvAiDNt3leOW0J8G0p5ITzksz5TVr9P2LKzDMP9oAnPwHGJMCh
         lnYnlzD9QW7GvASF2Cz0VF8k43mszR0rPH3XC0K2iGpGgobi6zWLSAkmajmLlqxXJcsP
         VkE+xLwFItM8vjnTePgBPcK/+QHH8PU7WrJvHtnpfwKR5afQvMNNMtvig1LlKunz0Zmp
         rRWVcD9tBz3xvhwJSWpLl3CSu5q7ugNP55RkPqcihOUI3vxzsfyX7Pr1pXZaiiVKB/4j
         +WFXLgaBBvIP/9YIIPCpM/sh1vakO7bJi8geU5fuBPZ5zJvY2BNcCEW9nwynzp4oSz3S
         tycg==
X-Gm-Message-State: AOJu0Yx87HZMB8+TtaVlc7VxfKgORlw8R+7U0+ykiNVvp1ba7j5nzRTh
        Oy4y6HRutgx+gG6qD3my8T8xIigR98Q=
X-Google-Smtp-Source: AGHT+IECDUtRVVRnx6BMLTfuVckuU+Xenk8TbZKwZilY62e5q35p07pBOOqcstMkeQmSJoopdrgQzDwj434=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da91:b0:1bb:b033:88f2 with SMTP id
 j17-20020a170902da9100b001bbb03388f2mr609257plx.12.1692196956999; Wed, 16 Aug
 2023 07:42:36 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:42:35 -0700
In-Reply-To: <55bfeecb59787369d57c2704785af13604e63a62.camel@intel.com>
Mime-Version: 1.0
References: <20230815203653.519297-1-seanjc@google.com> <20230815203653.519297-8-seanjc@google.com>
 <55bfeecb59787369d57c2704785af13604e63a62.camel@intel.com>
Message-ID: <ZNzgWwUNy/2J3SV2@google.com>
Subject: Re: [PATCH v3 07/15] KVM: nVMX: Use KVM-governed feature framework to
 track "nested VMX enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuan Yao <yuan.yao@intel.com>
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

On Wed, Aug 16, 2023, Kai Huang wrote:
> On Tue, 2023-08-15 at 13:36 -0700, Sean Christopherson wrote:
> > Track "VMX exposed to L1" via a governed feature flag instead of using a
> > dedicated helper to provide the same functionality.  The main goal is to
> > drive convergence between VMX and SVM with respect to querying features
> > that are controllable via module param (SVM likes to cache nested
> > features), avoiding the guest CPUID lookups at runtime is just a bonus
> > and unlikely to provide any meaningful performance benefits.
> > 
> > No functional change intended.
> > 
> > 
> [...]
> 
> >  
> > -/*
> > - * nested_vmx_allowed() checks whether a guest should be allowed to use VMX
> > - * instructions and MSRs (i.e., nested VMX). Nested VMX is disabled for
> > - * all guests if the "nested" module option is off, and can also be disabled
> > - * for a single guest by disabling its VMX cpuid bit.
> > - */
> > -bool nested_vmx_allowed(struct kvm_vcpu *vcpu)
> > -{
> > -	return nested && guest_cpuid_has(vcpu, X86_FEATURE_VMX);
> > -}
> > -
> > 
> 
> [...]
> 
> > @@ -7750,13 +7739,15 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
> >  		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
> >  
> > +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VMX);
> > +
> > 
> 
> Nit:
> 
> nested_vmx_allowed() also checks 'nested' global variable.  However
> kvm_governed_feature_check_and_set() is called unconditionally.  Although IIUC
> it should never actually set the VMX governed bit when 'nested=0', it's not that
> obvious in _this_ patch.

Yeah, 100% agree after re-reading this patch without context.  I had to go search
the code to remember where "nested" is checked.  :-)

> Should we explicitly call this out in the changelog so git blamers can
> understand this more easily in the future?

Yep, I'll add a blurb to point out the dependency in vmx_set_cpu_caps().

Thanks!
