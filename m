Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB307EDBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjKPHTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:19:29 -0500
X-Greylist: delayed 263 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 23:19:25 PST
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A96C5;
        Wed, 15 Nov 2023 23:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1700119163; bh=q2AuehPSVg0PAMSpgfi8EJzOTmrs6NwGqXh97Sh11+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KA5J/G4UWDHFRE1c0EwMstzoUwRQYy+31GHqhkrgTtAWX/o/FY1SZ+czziBtEZvQ0
         dzHnpB3y4OGJwtuBJ/hJQJBBEjd23BRQcHBVdWZBvPa+ZiQPPfGTYO8rqqRe3g7Tt8
         dWbA+U4QiRy6lUamE8A0a7NCfw+BNQmftIqM97r8=
Received: from [IPV6:240e:388:8d26:bf00:6f50:1e00:d62c:dcf9] (unknown [IPv6:240e:388:8d26:bf00:6f50:1e00:d62c:dcf9])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 79AC16018A;
        Thu, 16 Nov 2023 15:19:23 +0800 (CST)
Message-ID: <f003f38d-37fd-43ed-ada6-fb2d5b282e91@xen0n.name>
Date:   Thu, 16 Nov 2023 15:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] LoongArch: KVM: Add lasx support
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20231115091921.85516-1-zhaotianrui@loongson.cn>
 <20231115091921.85516-3-zhaotianrui@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20231115091921.85516-3-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 17:19, Tianrui Zhao wrote:
> This patch adds LASX support for LoongArch KVM. The LASX means
> LoongArch 256-bits vector instruction.
> There will be LASX exception in KVM when guest use the LASX
> instruction. KVM will enable LASX and restore the vector
> registers for guest then return to guest to continue running.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>   arch/loongarch/include/asm/kvm_host.h |  6 ++++
>   arch/loongarch/include/asm/kvm_vcpu.h | 10 +++++++
>   arch/loongarch/kernel/fpu.S           |  1 +
>   arch/loongarch/kvm/exit.c             | 18 +++++++++++
>   arch/loongarch/kvm/switch.S           | 16 ++++++++++
>   arch/loongarch/kvm/trace.h            |  4 ++-
>   arch/loongarch/kvm/vcpu.c             | 43 ++++++++++++++++++++++++++-
>   7 files changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 6c65c25169..4c05b5eca0 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -95,6 +95,7 @@ enum emulation_result {
>   #define KVM_LARCH_SWCSR_LATEST	(0x1 << 1)
>   #define KVM_LARCH_HWCSR_USABLE	(0x1 << 2)
>   #define KVM_LARCH_LSX		(0x1 << 3)
> +#define KVM_LARCH_LASX		(0x1 << 4)
>   
>   struct kvm_vcpu_arch {
>   	/*
> @@ -181,6 +182,11 @@ static inline bool kvm_guest_has_lsx(struct kvm_vcpu_arch *arch)
>   	return arch->cpucfg[2] & CPUCFG2_LSX;
>   }
>   
> +static inline bool kvm_guest_has_lasx(struct kvm_vcpu_arch *arch)
> +{
> +	return arch->cpucfg[2] & CPUCFG2_LASX;
> +}
> +
>   /* Debug: dump vcpu state */
>   int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
>   
> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
> index c629771e12..4f87f16018 100644
> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> @@ -67,6 +67,16 @@ static inline void kvm_restore_lsx(struct loongarch_fpu *fpu) { }
>   static inline void kvm_restore_lsx_upper(struct loongarch_fpu *fpu) { }
>   #endif
>   
> +#ifdef CONFIG_CPU_HAS_LASX
> +void kvm_own_lasx(struct kvm_vcpu *vcpu);
> +void kvm_save_lasx(struct loongarch_fpu *fpu);
> +void kvm_restore_lasx(struct loongarch_fpu *fpu);
> +#else
> +static inline void kvm_own_lasx(struct kvm_vcpu *vcpu) { }
> +static inline void kvm_save_lasx(struct loongarch_fpu *fpu) { }
> +static inline void kvm_restore_lasx(struct loongarch_fpu *fpu) { }
> +#endif
> +
>   void kvm_acquire_timer(struct kvm_vcpu *vcpu);
>   void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
>   void kvm_reset_timer(struct kvm_vcpu *vcpu);
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index d53ab10f46..f4524fe866 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -384,6 +384,7 @@ SYM_FUNC_START(_restore_lasx_upper)
>   	lasx_restore_all_upper a0 t0 t1
>   	jr	ra
>   SYM_FUNC_END(_restore_lasx_upper)
> +EXPORT_SYMBOL(_restore_lasx_upper)

Why the added export? It doesn't seem necessary, given the previous 
patch doesn't have a similar export added for _restore_lsx_upper. (Or if 
it's truly needed it should probably become EXPORT_SYMBOL_GPL.)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

