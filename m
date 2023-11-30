Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED17FE64E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjK3BmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjK3BmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:42:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120595
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:42:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso8183767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308525; x=1701913325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJiTexEo/V1fShNskSxIf2XvNn8+cQRjMRJWxCEEnB0=;
        b=Xuow30fC4+Knlna+BI56y8gbSenRSlpZVD6YUtEJ0Bcy5gYa4m3X59VO9eXe+/hE4M
         JhzppL9O8gqLmm0sW4OmozLA3zhQUYHkvew7tPSNJ2J5t8nG6vy6w6NG4hha1OrcNnSz
         F5D/NlAyMR+1fDbgOMsM4iuUub6VxDC614Uhc5LwE7g31SBMh1ib76PjdY4K1yu1PKPk
         l30H6z1knSNwGa8RnJkBSGZMsNuRWn2chYE7SAc0Cy3AyspIg+ruEYiV1xGcKATYKiyE
         MZ1lYwdbITG7aeAcZYW3PYSL35rBsAsBEugFSsrtsbr67YCYRUvkwSCDE3Eqtr8Pa+3K
         2kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308525; x=1701913325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJiTexEo/V1fShNskSxIf2XvNn8+cQRjMRJWxCEEnB0=;
        b=XbA5XW2/cMHFqv7UjGcbfZ7HeUSq3tVXyeNEs0EtJEdDOrPG5MHjuAwnr3DA9Gzsnp
         IvjPzsRJFdWDoIdc28FIFIjBZyn9B7wc5CztHkoXgXkuek1b1iuLjdY0QAFq2lTBEu6/
         G62shACrXGWPnAyXMZPNHXQKyqiYXa1ol3n8Q7QL0/w+75u2Tm/KcVPCoBOndL47GMZp
         LXWLb+M5zj0yISQ0LoLIXYRFvPytfiSxYaJY6q3ktZBKtdf3ymqehi1hx7pmY7zwZOhe
         iQRxx7FNpGaE7B5gzsXui1ccIGKcq07qnoENDbe1yvjJpKjk9SiLQbSMuTNB6GXZNZLF
         gF/w==
X-Gm-Message-State: AOJu0Yy1+heJYA0fl7+J96FUlhY732p0bGYx5jG34PubswWaU0VCiMge
        Pq+spBvqbBvqA/3/iGL5tEJtUSOTm+k=
X-Google-Smtp-Source: AGHT+IG8Xv0X2KGQHPvRQOHcUbtzsQsthfYCxiRlfbVLaRRLFYnmSFC8z2XlvUktMdkOuzt9IB2Q97PT6sg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:98d:b0:5cd:c47d:d8a0 with SMTP id
 ce13-20020a05690c098d00b005cdc47dd8a0mr650442ywb.7.1701308525670; Wed, 29 Nov
 2023 17:42:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:42:04 -0800
In-Reply-To: <20231025152406.1879274-1-vkuznets@redhat.com>
Mime-Version: 1.0
References: <20231025152406.1879274-1-vkuznets@redhat.com>
Message-ID: <ZWfobPuhnXZYaAVj@google.com>
Subject: Re: [PATCH 00/14] KVM: x86: Make Hyper-V emulation optional
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 25, 2023, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov (14):
>   KVM: x86: xen: Remove unneeded xen context from struct kvm_arch when
>     !CONFIG_KVM_XEN
>   KVM: x86: hyper-v: Move Hyper-V partition assist page out of Hyper-V
>     emulation context
>   KVM: VMX: Split off vmx_onhyperv.{ch} from hyperv.{ch}
>   KVM: x86: hyper-v: Introduce kvm_hv_synic_auto_eoi_set()
>   KVM: x86: hyper-v: Introduce kvm_hv_synic_has_vector()
>   KVM: VMX: Split off hyperv_evmcs.{ch}
>   KVM: x86: hyper-v: Introduce kvm_hv_nested_transtion_tlb_flush()
>     helper
>   KVM: selftests: Make all Hyper-V tests explicitly dependent on Hyper-V
>     emulation support in KVM
>   KVM: selftests: Fix vmxon_pa == vmcs12_pa == -1ull
>     vmx_set_nested_state_test for !eVMCS case
>   KVM: x86: Make Hyper-V emulation optional
>   KVM: nVMX: hyper-v: Introduce nested_vmx_evmptr12() and
>     nested_vmx_is_evmptr12_valid() helpers
>   KVM: nVMX: hyper-v: Introduce nested_vmx_evmcs() accessor
>   KVM: nVMX: hyper-v: Hide more stuff under CONFIG_KVM_HYPERV
>   KVM: nSVM: hyper-v: Hide more stuff under
>     CONFIG_KVM_HYPERV/CONFIG_HYPERV

No major complaints.  If it hadn't been for the build failure, I likely wouldn't
have even bothered with most of my nits ;-)

I'll wait for v2 though, trying to fixup as I go will be a bit risky.
