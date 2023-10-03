Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D57B69AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJCNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:00:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2349B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:00:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so1567896a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696338013; x=1696942813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pO2/tsigRqoegPlNF8cRpnRDUBY1p5NereI6k6PlI=;
        b=XBZ5lwTyfrNv9bQ2iuOq86RXrMPq4t+c3OzQYaxSgQbEazVX5fhDRV4rQY+5vxKe80
         k9OeFzKD4JTk56GzBNlyfkxNf7N8bB7v+3TNIL6+PSTCigIGvVSo2u7QyqAfFnN8VYmD
         r4To/msYcJXWVTKDrbKwBcB833vJAN/KliNbkebIpw7Eyezrzk01If6GcnQnKpkV1oHL
         f5coAeKSNfkoqWiYQXKIaQLXAT/weqiHr3Ye2cM0m9+/mhfT7Gsa2GXcOn3YxponJ62u
         FTpmFFr8paPhzuNkJQgaxsWft/JvSA8K4Vl7S1Dkovv5DA6DLGe9EGSIcYfdfI5LvKOP
         3O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338013; x=1696942813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4pO2/tsigRqoegPlNF8cRpnRDUBY1p5NereI6k6PlI=;
        b=TsoMD4MFxTFo7u3Dc5gQ7Pm2l+7OIXpeFVhAwA/aYc8APGCtLy4Ev88CJFO7YSnLYF
         WxVClhIy+rXbp9xZbtuDNs0ObhaCZDAgnFZjBuM1Wn6GcPkzfaVpeHNOG/yC3cc2JdU3
         NAp5CaedF4RxmMnA++qqIDEIehxFhhDZFWZ5be7OVyB8fgx7jxHdv9dClEytkPprajsz
         Anp8g/1SptTHpatmV8pLe2VQLQtiyKvxLmtBGJ79RkIINj1uF5ohZUqVYqMZCSuGb5Ax
         sEYD4UtEnSCLy11xRoOviYZ4QyzA37PC4M1IuUB8dgPWufKKxDg0x0i6dUbqmX1uz+SC
         Ojtg==
X-Gm-Message-State: AOJu0YyVXd/YZuz0tmWEdIYt+MQpghGrC0UoOsRrajMmA6vFgQGIZ9Mi
        tfuYagEatlnisMgkeazu7g==
X-Google-Smtp-Source: AGHT+IHKJkVEPT1uUitcKyRJufl4sNlbv+Xr9xS5LV19QXQlnA+XybgUJKz/RwMxpU3A14Reok0Niw==
X-Received: by 2002:a17:907:2711:b0:9b6:f0e2:3c00 with SMTP id w17-20020a170907271100b009b6f0e23c00mr1036577ejk.71.1696338012979;
        Tue, 03 Oct 2023 06:00:12 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id d10-20020a170906344a00b00992b71d8f19sm1029159ejb.133.2023.10.03.06.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:00:11 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:00:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:23:10AM -0700, Dave Hansen wrote:
> On 10/1/23 09:31, Alexey Dobriyan wrote:
> > Here is how it works:
> > 
> > * fault and fill the stack from rsp with int3 down until rlimit allows,
> > * fill upwards with int3 too, overwrite libc stuff, argv, envp,
> > * try to exec int3 on each page and catch it with either SIGSEGV or
> >   SIGTRAP handler.
> > 
> > Note: trying to execute _every_ int3 takes 30-40 seconds even on fast
> > machine, so only 1 int3 per page is tried.
> > 
> > Tested on F37 kernel and on custom kernel which did
> > 
> > 	vm_flags |= VM_EXEC;
> > 
> > to stack VMA.
> 
> I guess the subject implies it, but it's probably worth a sentence or
> two in the changelog about this being 64-bit only.
> 
> IIRC, there _are_ x86_64 CPUs that don't support NX.  It's also entirely
> possible for a hypervisor to disable NX enumeration for a guest.  Those
> two are (probably) rare enough that they can be ignored for now.  But it
> might mean adding a CPUID check at some point.
> 
> Basically, could you spend a moment in the changelog to talk about:
> 
> 1. 32-bit kernels on NX hardware
> and
> 2. 64-bit kernels on non-NX hardware

Sure. My logic whas that i386 is dead arch, but this test is easy to
port to i386, only 2 simple functions.

I don't want to parse /proc/cpuinfo. If someone knows they're shipping
NX-incapable hardware, just let them disable the test.
