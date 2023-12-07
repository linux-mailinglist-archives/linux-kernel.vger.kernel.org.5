Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F7808BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443523AbjLGPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443516AbjLGPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1410E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701963182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXYZcThuYCHAbdORgsP32hhjeEYnS8/VdqpfdkBxubc=;
        b=MGJGsFkRAx1MFmH59DtdiDLw8IT3FKoOc9H0yBioJB5vts+6dQhftSb4bDmIOaX/mrsfA4
        wo/n3wwDY2eHQSwV2EoSKzmsNDjb7PgMY2FJiXpJlAxWCaZWpa88yJJ/5jqlzx1VLlK2Es
        qfSquifHlSOvI9xx3U20AtzvYB0XCKs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-0LeSHXW-OwWc4ZLD4TCfPg-1; Thu, 07 Dec 2023 10:33:01 -0500
X-MC-Unique: 0LeSHXW-OwWc4ZLD4TCfPg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c27a351e2so7016865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701963179; x=1702567979;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXYZcThuYCHAbdORgsP32hhjeEYnS8/VdqpfdkBxubc=;
        b=mGMUjtipDyhw2FqxIlpts58/wbyJ2ogqIg5gkt8NJvJH5l/ZcC1bI+0E2vNIhcMh49
         udOq2j4EhBR3k91/4HSP5cn9HfSPi+XaaxJ9q0q+hr2fVG5wGiQ0Mx2vlppWuV2H4sPE
         7+yi1eWnYj7fgniIuKHffNV5myas/w9AplxacvGelhsaLHyPQyiO0Z6JpXZCuDd9r30L
         +dZOKC00HwZ23fQ8UKDQPkEI9VY7xQZqB0mHzOKsdfpeWKpQtpo30e7jhCvyvuLqAVqk
         cBrwDm8m2f4cdrgnOcaXVhHDXFYRmP47/XFkeBsZxyv+ZboWWYqa7MZsbp8z+NbpgJo7
         i9oQ==
X-Gm-Message-State: AOJu0Yz/EL8rqYxPEOIJJa3KYZRV1P+FmrXgUGbyECc8aq79WNthGXYA
        v73rSPfemHbAmQo5hqRLcdgfa9yxoSZuh+/bOMo6K8Tp8wv5I+NCqOOvnzaoM0fyie3D9KaGq1F
        cf2PvEShuaJqWX4ENgs2b4KKk
X-Received: by 2002:a05:600c:231a:b0:40b:36e6:9ef8 with SMTP id 26-20020a05600c231a00b0040b36e69ef8mr830433wmo.17.1701963179760;
        Thu, 07 Dec 2023 07:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF73xG1rWSXPP6/USJKY6WpXHrYjibzf4wMxRh4mD+xclLWUKJS1MJJMWuoIt+KM6fE1rncgw==
X-Received: by 2002:a05:600c:231a:b0:40b:36e6:9ef8 with SMTP id 26-20020a05600c231a00b0040b36e69ef8mr830428wmo.17.1701963179400;
        Thu, 07 Dec 2023 07:32:59 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d5444000000b0033342d2bf02sm1697325wrv.25.2023.12.07.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:32:58 -0800 (PST)
Message-ID: <2cf82d25d687ce6747b729146c1a0ac194a1ab7b.camel@redhat.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2023 17:32:57 +0200
In-Reply-To: <20231206032054.55070-1-likexu@tencent.com>
References: <20231206032054.55070-1-likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-06 at 11:20 +0800, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Explicitly checking the source of external interrupt is indeed NMI and not
> other types in the kvm_arch_pmi_in_guest(), which prevents perf-kvm false
> positive samples generated in perf/core NMI mode after vm-exit but before
> kvm_before_interrupt() from being incorrectly labelled as guest samples:
> 
> # test: perf-record + cpu-cycles:HP (which collects host-only precise samples)
> # Symbol                                   Overhead       sys       usr  guest sys  guest usr
> # .......................................  ........  ........  ........  .........  .........
> #
> # Before:
>   [g] entry_SYSCALL_64                       24.63%     0.00%     0.00%     24.63%      0.00%
>   [g] syscall_return_via_sysret              23.23%     0.00%     0.00%     23.23%      0.00%
>   [g] files_lookup_fd_raw                     6.35%     0.00%     0.00%      6.35%      0.00%
> # After:
>   [k] perf_adjust_freq_unthr_context         57.23%    57.23%     0.00%      0.00%      0.00%
>   [k] __vmx_vcpu_run                          4.09%     4.09%     0.00%      0.00%      0.00%
>   [k] vmx_update_host_rsp                     3.17%     3.17%     0.00%      0.00%      0.00%
> 
> In the above case, perf records the samples labelled '[g]', the RIPs behind
> the weird samples are actually being queried by perf_instruction_pointer()
> after determining whether it's in GUEST state or not, and here's the issue:
> 
> If vm-exit is caused by a non-NMI interrupt (such as hrtimer_interrupt) and
> at least one PMU counter is enabled on host, the kvm_arch_pmi_in_guest()
> will remain true (KVM_HANDLING_IRQ is set) until kvm_before_interrupt().
> 
> During this window, if a PMI occurs on host (since the KVM instructions on
> host are being executed), the control flow, with the help of the host NMI
> context, will be transferred to perf/core to generate performance samples,
> thus perf_instruction_pointer() and perf_guest_get_ip() is called.
> 
> Since kvm_arch_pmi_in_guest() only checks if there is an interrupt, it may
> cause perf/core to mistakenly assume that the source RIP of the host NMI
> belongs to the guest world and use perf_guest_get_ip() to get the RIP of
> a vCPU that has already exited by a non-NMI interrupt.
> 
> Error samples are recorded and presented to the end-user via perf-report.
> Such false positive samples could be eliminated by explicitly determining
> if the exit reason is KVM_HANDLING_NMI.
> 
> Note that when vm-exit is indeed triggered by PMI and before HANDLING_NMI
> is cleared, it's also still possible that another PMI is generated on host.
> Also for perf/core timer mode, the false positives are still possible since
> that non-NMI sources of interrupts are not always being used by perf/core.
> In both cases above, perf/core should correctly distinguish between real
> RIP sources or even need to generate two samples, belonging to host and
> guest separately, but that's perf/core's story for interested warriors.
> 
> Fixes: dd60d217062f ("KVM: x86: Fix perf timer mode IP reporting")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
> V1 -> V2 Changelog:
> - Refine commit message to cover both perf/core timer and NMI modes;
> - Use in_nmi() to distinguish whether it's NMI mode or not; (Sean)
> V1: https://lore.kernel.org/kvm/20231204074535.9567-1-likexu@tencent.com/
>  arch/x86/include/asm/kvm_host.h | 10 +++++++++-
>  arch/x86/kvm/x86.h              |  6 ------
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c8c7e2475a18..167d592e08d0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1868,8 +1868,16 @@ static inline int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn,
>  }
>  #endif /* CONFIG_HYPERV */
>  
> +enum kvm_intr_type {
> +	/* Values are arbitrary, but must be non-zero. */
> +	KVM_HANDLING_IRQ = 1,
> +	KVM_HANDLING_NMI,
> +};
> +
> +/* Enable perf NMI and timer modes to work, and minimise false positives. */
>  #define kvm_arch_pmi_in_guest(vcpu) \
> -	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
> +	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
> +	 (in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
>  
>  void __init kvm_mmu_x86_module_init(void);
>  int kvm_mmu_vendor_module_init(void);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 2f7e19166658..4dc38092d599 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -431,12 +431,6 @@ static inline bool kvm_notify_vmexit_enabled(struct kvm *kvm)
>  	return kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_ENABLED;
>  }
>  
> -enum kvm_intr_type {
> -	/* Values are arbitrary, but must be non-zero. */
> -	KVM_HANDLING_IRQ = 1,
> -	KVM_HANDLING_NMI,
> -};
> -
>  static __always_inline void kvm_before_interrupt(struct kvm_vcpu *vcpu,
>  						 enum kvm_intr_type intr)
>  {

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


> 
> base-commit: 1ab097653e4dd8d23272d028a61352c23486fd4a


