Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805037FF638
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbjK3Qgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Qgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:36:44 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E361A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:36:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cdc03f9fe9so1329070b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701362210; x=1701967010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xHzArs6mE8k0gKFW47uVkaYV8e6TD1wE2C7VOPjLb4=;
        b=u9sYNGK0SnoZJi2M4fNto/d3DBHZVx8oGKr+V0DDNmD/sPLR1DHmyO9GnTmhOpt9pf
         mzqK3qLOfftbhQAsBuGkwl+yyh2s6C6QqGjhvZ4d/HlFbH8ByQbqlybrbDslLGK8SNqw
         WIGacyNWus+FgvF2Le50Sxbe84PDmpk9AkKpIRIuK/8W8kfRATWhdqmyNZp4rUmWmnPH
         5O84qWy3Y+o60/+d1qixZQwvQMRaZtpjCSZA3MydjsAc5hOO/wSy7QjGCuTJ04SxyJFu
         +UTls6N6h/ONtyB6I+/TnpyABGeYUS0jXPfWSN2SeQ6wFjf47kaGSl4ibjivXFpgQgm1
         Xf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362210; x=1701967010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xHzArs6mE8k0gKFW47uVkaYV8e6TD1wE2C7VOPjLb4=;
        b=N3Fcb0GyiDVEtgZEKwaSwI0/uXuMuUwnK3aZ+c1lreAagqgA2oOxpupbfo3jyOGqI2
         hPQLJjcdRnbqXuTF60sXgV8BCxbFum4TtRv930EXHfyVLgZIhtdjpLeke95KQikSImjL
         uB8jLKGAIpFpjKhyFaUz62CAFSKU5Ga5FgLRa+xAMh6d7fW9rsVAANOlf4AoC5/jN5w0
         vtmk3yN7wltOQOmwyjw7MmpAjrE8HZCTL51bJQ4Dk7V0WNUaojG24QNNNMj/PsBqG+tc
         bRPy8zifjSXy+p2U/RhGokmQQh9Ht9jFV5HgoehlxxRngy78/qrsSCNQshagFZ+XjlWA
         2mLg==
X-Gm-Message-State: AOJu0YyvvBfNw1mimQNM2xO7ZLaAqu1Cl3KbjuhiZDLY+B/ccGdl0TDi
        jzhxXUBnZ56vG8fksqLbT8V8WGBVYLE=
X-Google-Smtp-Source: AGHT+IFyTJvqgU7+F4LwNMiRyYQZ/KoAM9H6+dTJ2Jev+HII5QR1S3/PLcJ09hSbpz5CFo9DmapM9ZYore8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:c90:b0:6cd:f769:9c09 with SMTP id
 a16-20020a056a000c9000b006cdf7699c09mr114286pfv.0.1701362210472; Thu, 30 Nov
 2023 08:36:50 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:36:48 -0800
In-Reply-To: <20231102162128.2353459-1-paul@xen.org>
Mime-Version: 1.0
References: <20231102162128.2353459-1-paul@xen.org>
Message-ID: <ZWi6IKGFtQGpu6oR@google.com>
Subject: Re: [PATCH v5] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andrew

On Thu, Nov 02, 2023, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Unless explicitly told to do so (by passing 'clocksource=tsc' and
> 'tsc=stable:socket', and then jumping through some hoops concerning
> potential CPU hotplug) Xen will never use TSC as its clocksource.
> Hence, by default, a Xen guest will not see PVCLOCK_TSC_STABLE_BIT set
> in either the primary or secondary pvclock memory areas. This has
> led to bugs in some guest kernels which only become evident if
> PVCLOCK_TSC_STABLE_BIT *is* set in the pvclocks. Hence, to support
> such guests, give the VMM a new Xen HVM config flag to tell KVM to
> forcibly clear the bit in the Xen pvclocks.

...

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7025b3751027..a9bdd25826d1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8374,6 +8374,7 @@ PVHVM guests. Valid flags are::
>    #define KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL		(1 << 4)
>    #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
>    #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
> +  #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)

Does Xen actually support PVCLOCK_TSC_STABLE_BIT?  I.e. do we need new uAPI to
fix this, or can/should KVM simply _never_ set PVCLOCK_TSC_STABLE_BIT for Xen
clocks?  At a glance, PVCLOCK_TSC_STABLE_BIT looks like it was added as a purely
Linux/KVM-only thing.
