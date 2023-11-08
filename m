Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B67E5C47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjKHRUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjKHRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:20:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549962101
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:20:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b59662ff67so8119597b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699464039; x=1700068839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBbKC3JkdJ0oQ9YroQVJM/5WimY0jXaEi0yPTCtmdW4=;
        b=KRvVLLMtR/ldoVMkhZYwEz3RWr0mpd3q5HfMo6E1eymtRVrr5IAbiIZ8LsF395Qram
         8U7JFDCycq8uKe7RzwefkyuCukw8fzhErpmZOdil+naNZKM6sWGRZ4WpaNQnXMtqSikb
         3ty2xBNBcEriOWRl9OxHVD6pPajuEE5knKH6S57r17BoprX44Gl/rSR3TRYqZeFJ62Il
         bVm9palqUFrSLRAzw1ZLo8ogkmXmYd8/NIfuwIu3ROmq/vKmqEfI+u1Fnrk/hLMeJP6e
         bXpibw2MNE18Tn2o7decAmTzFWU4qYSlMGPyDZIplL2U4Ray5FKt58c/+Iawd+2d/tL5
         FsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464039; x=1700068839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBbKC3JkdJ0oQ9YroQVJM/5WimY0jXaEi0yPTCtmdW4=;
        b=Iq9KdtiQglYUvbUhRoTRFr2YbTJDr5ZuR+jgz4XCpsNfQZpAH27RHT1z0CBZo6jSJZ
         P4yC1XZnlw3CrJ/vGC4HXDhx6Kqlc3QdvmwOTGlKwubj0MysaY8JsOg2+XHO3h2FYo21
         H+Q86DvVA+7vfCPo5FZEFycv35ycMpQe4UK79T/XtUCypoicgsg0LKr9yaG6MpOiYvia
         Ad4XXGIsOlaalXGPs/mzBspQxKPcrcII3sVFGBW8Z97yos44jfbPPO/Gu5W26PBd50p6
         OxCMYOWfbapnOGZkpt5c3F8/HYrSjpPq/7P6XyusaeC/XvvfBgqnwWOF3IcZww6Sk1h8
         GuTA==
X-Gm-Message-State: AOJu0Yyrz3YTUXhSjWpJjoFkWP6l1UrQ+x+2lgOMYDj4Mb9N77u3AfzG
        b6El4D2gdS1aLdIaRBoUK6AtcM+K7UM=
X-Google-Smtp-Source: AGHT+IGphpWQHHEDy2ukCPCGjyPMd0Bw17ZH9MJZhu3SATwjM2+XVm/rjVukAqXpoj9DXdfpGc+wU3Ua940=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4047:b0:59b:b0b1:d75a with SMTP id
 ga7-20020a05690c404700b0059bb0b1d75amr122541ywb.4.1699464039546; Wed, 08 Nov
 2023 09:20:39 -0800 (PST)
Date:   Wed, 8 Nov 2023 09:20:37 -0800
In-Reply-To: <20231108111806.92604-30-nsaenz@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-30-nsaenz@amazon.com>
Message-ID: <ZUvDZUbUR4s_9VNG@google.com>
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, graf@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> Save the length of the instruction that triggered an EPT violation in
> struct kvm_vcpu_arch. This will be used to populate Hyper-V VSM memory
> intercept messages.

This is silly and unnecessarily obfuscates *why* (as my response regarding SVM
shows), i.e. that this is "needed" becuase the value is consumed by a *different*
vCPU, not because of performance concerns.

It's also broken, AFAICT nothing prevents the intercepted vCPU from hitting a
different EPT violation before the target vCPU consumes exit_instruction_len.

Holy cow.  All of deliver_gpa_intercept() is wildly unsafe.  Aside from race
conditions, which in and of themselves are a non-starter, nothing guarantees that
the intercepted vCPU actually cached all of the information that is held in its VMCS.

The sane way to do this is to snapshot *all* information on the intercepted vCPU,
and then hand that off as a payload to the target vCPU.  That is, assuming the
cross-vCPU stuff is actually necessary.  At a glance, I don't see anything that
explains *why*.
