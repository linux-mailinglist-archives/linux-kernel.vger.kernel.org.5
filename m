Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9597FE644
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjK3Bit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3Bis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:38:48 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291C198
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:38:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5be154fe98bso1691061a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308334; x=1701913134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91kgiS9Jgc7V4foMf6RxYX634vn5hfsz4EzI3W+cTWo=;
        b=nuX6GuDgAyIz/iTr6+ZvGbSvO6SMeBtIi1T5FFYoAcLp/y0aULeI+Vo8fyldfZYytn
         glK2kwcUTvsv/YVyMeJx17/K76zaYKHPP0Aq2R4Lj31IZnC6VUZLzEB+9e20j0wzGuXE
         uLlyJx1lf3A6khFG40UyfoyPZpMrQnQQJwUpp+oxj3Jx5Ui2wDa1QwTiVqXle6cLLZJX
         CHIU8LMhumrw0uiB5JcCDItGN/UyOw+BMuG8CP2TCbBnwPXIQ3AkmtzuBaP2T+OmHBzA
         W5pqY30cyfk5KM8wyu4APKQq6qZ0gEfgG9XdCECN13apSQUHj8Tfk5nsxifq/2g8bAbj
         iogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308334; x=1701913134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91kgiS9Jgc7V4foMf6RxYX634vn5hfsz4EzI3W+cTWo=;
        b=KNvhBT4Za/xJ/Wn4CLlxqqX2wI6l3brXtDdIkppi8JTZ+nLhSCdARCBONnbCJKRh/A
         Pcge3UtP2dFzgmnjCPzM5vpJvjGuHmAnddHdutkjVXalHaqXrlyLxVH1Ncx4Dcc8T6dI
         6nniddPbQtcx3hzoY7ATohGeoPxel9xnmh7gFqWMFw8ayNf91mqvS8T9fH2urWFHafsI
         PYeO92jbtdJBIW87ktxwqNHzJ6JThNvp6eJoMd6g2U2UxQGJ2zWI0t593+YFcaD65PFL
         HpSlz9nNhccoWxsaTfbs2MoVfnMvq4oKoktPf/s3/qKtU79uRuRITjZhq5LCPopAyPJ4
         RlwA==
X-Gm-Message-State: AOJu0YzQzpVtYq1s8VFW6lk0pQdZLGQqZBU678ghdu1+kaQH+PRPbops
        5yLSzJxG7KVcxx0at3itgAphg9Zx2c0=
X-Google-Smtp-Source: AGHT+IHqBZdQMIJiW1i3yuviz3YDYA+PL7MJ4JYi8vfwzPkJ3zkNWNdLJVW06CEFNlmCV6zclnL/NgvK92I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1a8c:b0:285:b3a1:3943 with SMTP id
 ng12-20020a17090b1a8c00b00285b3a13943mr3509774pjb.3.1701308334357; Wed, 29
 Nov 2023 17:38:54 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:38:52 -0800
In-Reply-To: <20231025152406.1879274-11-vkuznets@redhat.com>
Mime-Version: 1.0
References: <20231025152406.1879274-1-vkuznets@redhat.com> <20231025152406.1879274-11-vkuznets@redhat.com>
Message-ID: <ZWfnrLyLUS2_viVS@google.com>
Subject: Re: [PATCH 10/14] KVM: x86: Make Hyper-V emulation optional
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
> @@ -1570,6 +1572,7 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
>  	vmcs_load(vmx->loaded_vmcs->vmcs);
>  }
>  
> +#ifdef CONFIG_KVM_HYPERV
>  static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields)
>  {
>  	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
> @@ -2077,6 +2080,10 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>  
>  	return EVMPTRLD_SUCCEEDED;
>  }
> +#else /* CONFIG_KVM_HYPERV */
> +static inline void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields) {}
> +static inline void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx) {}

I'm not sure I love the stubs in .c code.  What if we instead throw the #ifdef
inside the helper, and then add a KVM_BUG_ON() in the CONFIG_KVM_HYPERV=n path?

> +#endif /* CONFIG_KVM_HYPERV */
>  
>  void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
>  {
> @@ -3155,6 +3162,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_KVM_HYPERV
>  static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -3182,6 +3190,9 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
>  
>  	return true;
>  }
> +#else
> +static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu) { return true; }
> +#endif

And this one seems like it could be cleaner to just #ifdef the callers.
