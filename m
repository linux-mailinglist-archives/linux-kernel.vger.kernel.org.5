Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE07E5BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjKHQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:59:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA291719
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:59:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da040c021aeso8227547276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699462782; x=1700067582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpEPwj1+3M0yPZeVquG+vKJ0idoDjxiUbhXJ8UOhbv8=;
        b=XPWK41NJ9TP55vaeDEW2CT2aoqip51D1Wxgzh9niv3qPYTbggkIAnTWPUA/ipAbpCI
         zQ/H0ERgHA1Ag6evaNHjKRoaY5K41wFKS4ZtftcNRKilR9Lm7N7vatAljEFFZAktKRvY
         Y0FGXdypJCyqfYL6FiUBPNb5whllsbXRiRpbnnzodj8KCuppIJZCobxXf4e8oeBHEKk9
         ZJP4yv6ZT+roRS0V8e6X8zMqRMBbMu5KRWdeLUlAFxFz0rIR5fxFd8PelzUQtHChoHDp
         MjFzulTvHZlRdC1qows4uqHyNzT1pV8sCGc4bgFAJ8CKTmqoaNXuapgJvOuvW3iDipoX
         n1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462782; x=1700067582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpEPwj1+3M0yPZeVquG+vKJ0idoDjxiUbhXJ8UOhbv8=;
        b=e49FsDJR9Kr1kBdRBw4z6nf9Y0nh8Sgh8TT4AEbd/kmYCGJeXp+rETX6SYTbOTO81S
         SskyJ4tEPG+pZvgJ31+fkkuQPNJg1x9KimqeZ5NaTySb31nYVTfGVnbX3h5ehDgnojcR
         6c5V2I/DCWfZ99ZLMKi9Z5vzcJvIhuaF9XidnOIPFXOs8eoDoFMPOI6g1RSlodUGmAxV
         bRPha1pX8FvQO3Rxh1Dp8dV2VtEeCuIgOy1hqGjuj9vv9z4F/T+ManmIAl9ObxKC8WHG
         3V03tjpGvJz6/fJJTv//ii8uunIQIVq9Y/3aHN4sjMegJjTAPif1RnviN2soFhI5LIgr
         bQKA==
X-Gm-Message-State: AOJu0YwwAxjstThYzSJgLuueqQPFnJHhYQhbfXBMbA5HwDRSBhYuSqYs
        C2WTKncuY2AruMfPJv4GqZk0qs2AM+U=
X-Google-Smtp-Source: AGHT+IFJxSqbqH04V4CdJrSt2ML48nciNEkXKyUcY0n7jXVYIpLnHLDjSshRNYH2nl7Ej/GNN7RSKDGvir0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d384:0:b0:d9a:c27e:5f37 with SMTP id
 e126-20020a25d384000000b00d9ac27e5f37mr43658ybf.3.1699462782601; Wed, 08 Nov
 2023 08:59:42 -0800 (PST)
Date:   Wed, 8 Nov 2023 08:59:41 -0800
In-Reply-To: <20231108111806.92604-19-nsaenz@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-19-nsaenz@amazon.com>
Message-ID: <ZUu-fZl3ZK2Vy8M8@google.com>
Subject: Re: [RFC 18/33] KVM: x86: Decouple kvm_get_memory_attributes() from
 struct kvm's mem_attr_array
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
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 631fd532c97a..4242588e3dfb 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2385,9 +2385,10 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  }
>  
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> -static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +static inline unsigned long
> +kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)

Do not wrap before the function name.  Linus has a nice explanation/rant on this[*].

[*] https://lore.kernel.org/all/CAHk-=wjoLAYG446ZNHfg=GhjSY6nFmuB_wA8fYd5iLBNXjo9Bw@mail.gmail.com
