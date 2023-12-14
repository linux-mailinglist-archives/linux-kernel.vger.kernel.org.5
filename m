Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6A812BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443379AbjLNJbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:31:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BE98
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702546289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTE0cMZgmLT4mbBDje7gzm+ln7P9WsJQeR7EiRHzoUg=;
        b=bdgEI6di7G9lPBavmDo4uBPBhGkfhDKh8mKGlvenUgoCKUVk3uS7iZNvhuNJh3TNSRhatI
        zx8dX8YUa9aLB0jyE2oBXL/p/ajZx5s3PIbvSZRrzfKqm7yOv4bNH0IElEiSuaTXqhRuev
        WNkdHK8LR/1Yxxq8/SZTgKFS1ePSDCo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Qvc7B4AjOu-G8iD0fwHZMQ-1; Thu, 14 Dec 2023 04:31:27 -0500
X-MC-Unique: Qvc7B4AjOu-G8iD0fwHZMQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c299d1e36so54279315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546286; x=1703151086;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTE0cMZgmLT4mbBDje7gzm+ln7P9WsJQeR7EiRHzoUg=;
        b=luOwyzWVJcrq/LdDnUkmRf/eRbRYAlCIlarQ/qHCCQnr1gFiEz1x8Vh+MfIpgK77af
         rv0RIMQxUga79wfT4wDS2TppAASDIG2YC0mOUWMfiCppKGltqTvRKxxqxJtADfHYTna9
         R/iFoxSa/Sl4ry5G6YnoaRfhvzY2ZpxL2qYxPvUGIaTeKBDHrWns6AsBGcD+CA/YL7AZ
         AogkkABU5h32UAMqJf08Se3s53axfYC1AXQQalWNfFMD7CF7OgzvpcejGwGo2lUbv0M3
         M8pYf/dXZ+P24PknnbArEWJZsKT/HpI1H2t7sBEUpyktxpzgH8QvlWhylUmc2Q6Wtk5s
         tF4Q==
X-Gm-Message-State: AOJu0YxIGk0yLEi/UYZb1thqIeU+m9TNoGpHrkTBEYtuBERYlI1QmT6Q
        CjtlmwRwQzBusHUMWfAuhZ8EnZJLNZNtndT2tv7u+UZRKr2KT9hpqGjrlSq3BQmFQftf+yTSX/j
        iVPHJ9v6QI/BZaNV2w3+yzxEa
X-Received: by 2002:a05:600c:188f:b0:40c:32e6:d567 with SMTP id x15-20020a05600c188f00b0040c32e6d567mr3338885wmp.119.1702546286718;
        Thu, 14 Dec 2023 01:31:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRxP7fEK8hsKy8ujv5AAy1+oBp2F4A/KQqv4ZVDGZIIzspF+szw+DRvb7Fz+JaTSBb7ZWKhg==
X-Received: by 2002:a05:600c:188f:b0:40c:32e6:d567 with SMTP id x15-20020a05600c188f00b0040c32e6d567mr3338872wmp.119.1702546286273;
        Thu, 14 Dec 2023 01:31:26 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm24076640wmb.30.2023.12.14.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:31:25 -0800 (PST)
Message-ID: <aa7aa5ea5b112a0ec70c6276beb281e19c052f0e.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency
 vm variable
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Dec 2023 11:31:24 +0200
In-Reply-To: <ZXo54VNuIqbMsYv-@google.com>
References: <cover.1699936040.git.isaku.yamahata@intel.com>
         <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
         <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
         <ZXo54VNuIqbMsYv-@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-13 at 15:10 -0800, Sean Christopherson wrote:
> On Thu, Dec 14, 2023, Maxim Levitsky wrote:
> > On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > 
> > > TDX virtualizes the advertised APIC bus frequency to be 25MHz. 
> > 
> > Can you explain a bit better why TDX needs this? I am not familiar
> > with TDX well enough yet to fully understand.
> 
> TDX (the module/architecture) hardcodes the core crystal frequency to 25Mhz,
> whereas KVM hardcodes the APIC bus frequency to 1Ghz.  And TDX (again, the module)
> *unconditionally* enumerates CPUID 0x15 to TDX guests, i.e. _tells_ the guest that
> the frequency is 25MHz regardless of what the VMM/hypervisor actually emulates.
> And so the guest skips calibrating the APIC timer, which results in the guest
> scheduling timer interrupts waaaaaaay too frequently, i.e. the guest ends up
> gettings interrupts at 40x the rate it wants.

That is what I wanted to hear without opening the PRM ;) - so there is a CPUID leaf,
but KVM just doesn't advertise it. Now it makes sense.

Please add something like that to the commit message:

"TDX guests have the APIC bus frequency hardcoded to 25 Mhz in the CPUID leaf 0x15.
KVM doesn't expose this leaf, but TDX mandates it to be exposed,
and doesn't allow to override it's value either.

To ensure that the guest doesn't have a conflicting view of the APIC bus frequency, 
allow the userspace to tell KVM to use the same frequency that TDX mandates,
instead of the default 1Ghz"

> 
> Upstream KVM's non-TDX behavior is fine, because KVM doesn't advertise support
> for CPUID 0x15, i.e. doesn't announce to host userspace that it's safe to expose
> CPUID 0x15 to the guest.  Because TDX makes exposing CPUID 0x15 mandatory, KVM
> needs to be taught to correctly emulate the guest's APIC bus frequency, a.k.a.
> the TDX guest core crystal frequency of 25Mhz.

I assume that TDX doesn't allow to change the CPUID 0x15 leaf.

> 
> I halfheartedly floated the idea of "fixing" the TDX module/architecture to either
> use 1Ghz as the base frequency (off list), but it definitely isn't a hill worth
> dying on since the KVM changes are relatively simple.
> 
> https://lore.kernel.org/all/ZSnIKQ4bUavAtBz6@google.com
> 

Best regards,
	Maxim Levitsky

