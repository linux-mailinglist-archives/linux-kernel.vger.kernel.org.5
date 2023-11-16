Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155697EDBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKPHPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:15:08 -0500
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 23:15:02 PST
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0F192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1700118901; bh=5DHbcB6eo5LDPo3cAilOXMI9H2T9LcCcW11o3Ihx+Z8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pliusvvhpjRn+cVQjMmEMPnQ6PEWo0h9jkT9fP9DhTaMFLNvFB9my2oEIkP6R5dlN
         nHojnlwjCM57yg3Azept4kpJ/ioDcOvuyzCwUk8IcJCB7+myyU0fGHLjAZblQJs0Or
         TzkjCyGXU1SXO4AnE8Frd6jRlCYIRiqfmc83P2A0=
Received: from [IPV6:240e:388:8d26:bf00:6f50:1e00:d62c:dcf9] (unknown [IPv6:240e:388:8d26:bf00:6f50:1e00:d62c:dcf9])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 04AE5601DD;
        Thu, 16 Nov 2023 15:15:00 +0800 (CST)
Message-ID: <28c11122-4433-4302-bb09-95b3d458b457@xen0n.name>
Date:   Thu, 16 Nov 2023 15:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] LoongArch: KVM: Add lsx support
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
 <20231115091921.85516-2-zhaotianrui@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20231115091921.85516-2-zhaotianrui@loongson.cn>
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
> This patch adds LSX support for LoongArch KVM. The LSX means
> LoongArch 128-bits vector instruction.
Maybe we don't need to explain what "LSX" is; people working on 
LoongArch kernel should already know this through the kernel docs and 
the various occurrences in the code.
> There will be LSX exception in KVM when guest use the LSX
> instruction. KVM will enable LSX and restore the vector
> registers for guest then return to guest to continue running.
>
One more extra line that should get removed.
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>   arch/loongarch/include/asm/kvm_host.h |  6 ++++
>   arch/loongarch/include/asm/kvm_vcpu.h | 12 +++++++
>   arch/loongarch/kvm/exit.c             | 18 ++++++++++
>   arch/loongarch/kvm/switch.S           | 22 +++++++++++++
>   arch/loongarch/kvm/trace.h            |  4 ++-
>   arch/loongarch/kvm/vcpu.c             | 47 +++++++++++++++++++++++++--
>   6 files changed, 105 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 11328700d4..6c65c25169 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -94,6 +94,7 @@ enum emulation_result {
>   #define KVM_LARCH_FPU		(0x1 << 0)
>   #define KVM_LARCH_SWCSR_LATEST	(0x1 << 1)
>   #define KVM_LARCH_HWCSR_USABLE	(0x1 << 2)
> +#define KVM_LARCH_LSX		(0x1 << 3)
>   
>   struct kvm_vcpu_arch {
>   	/*
> @@ -175,6 +176,11 @@ static inline void writel_sw_gcsr(struct loongarch_csrs *csr, int reg, unsigned
>   	csr->csrs[reg] = val;
>   }
>   
> +static inline bool kvm_guest_has_lsx(struct kvm_vcpu_arch *arch)
> +{
> +	return arch->cpucfg[2] & CPUCFG2_LSX;
> +}
> +
>   /* Debug: dump vcpu state */
>   int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
>   
> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
> index 553cfa2b2b..c629771e12 100644
> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> @@ -55,6 +55,18 @@ void kvm_save_fpu(struct loongarch_fpu *fpu);
>   void kvm_restore_fpu(struct loongarch_fpu *fpu);
>   void kvm_restore_fcsr(struct loongarch_fpu *fpu);
>   
> +#ifdef CONFIG_CPU_HAS_LSX
> +void kvm_own_lsx(struct kvm_vcpu *vcpu);
> +void kvm_save_lsx(struct loongarch_fpu *fpu);
> +void kvm_restore_lsx(struct loongarch_fpu *fpu);
> +void kvm_restore_lsx_upper(struct loongarch_fpu *fpu);
> +#else
> +static inline void kvm_own_lsx(struct kvm_vcpu *vcpu) { }
> +static inline void kvm_save_lsx(struct loongarch_fpu *fpu) { }
> +static inline void kvm_restore_lsx(struct loongarch_fpu *fpu) { }
> +static inline void kvm_restore_lsx_upper(struct loongarch_fpu *fpu) { }
> +#endif
> +
>   void kvm_acquire_timer(struct kvm_vcpu *vcpu);
>   void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
>   void kvm_reset_timer(struct kvm_vcpu *vcpu);
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index ce8de3fa47..1b1c58ccc8 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -659,6 +659,23 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu)
>   	return RESUME_GUEST;
>   }
>   
> +/*
> + * kvm_handle_lsx_disabled() - Guest used LSX while disabled in root.
> + * @vcpu:      Virtual CPU context.
> + *
> + * Handle when the guest attempts to use LSX when it is disabled in the root
> + * context.
> + */
> +static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu)
> +{
> +	if (!kvm_guest_has_lsx(&vcpu->arch))
> +		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
> +	else
> +		kvm_own_lsx(vcpu);
> +
> +	return RESUME_GUEST;
> +}
> +
>   /*
>    * LoongArch KVM callback handling for unimplemented guest exiting
>    */
> @@ -687,6 +704,7 @@ static exit_handle_fn kvm_fault_tables[EXCCODE_INT_START] = {
>   	[EXCCODE_TLBS]			= kvm_handle_write_fault,
>   	[EXCCODE_TLBM]			= kvm_handle_write_fault,
>   	[EXCCODE_FPDIS]			= kvm_handle_fpu_disabled,
> +	[EXCCODE_LSXDIS]                = kvm_handle_lsx_disabled,
>   	[EXCCODE_GSPR]			= kvm_handle_gspr,
>   };
>   
> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
> index 0ed9040307..32ba092a44 100644
> --- a/arch/loongarch/kvm/switch.S
> +++ b/arch/loongarch/kvm/switch.S
> @@ -245,6 +245,28 @@ SYM_FUNC_START(kvm_restore_fpu)
>   	jr                 ra
>   SYM_FUNC_END(kvm_restore_fpu)
>   
> +#ifdef CONFIG_CPU_HAS_LSX
> +SYM_FUNC_START(kvm_save_lsx)
> +	fpu_save_csr    a0 t1
> +	fpu_save_cc     a0 t1 t2
> +	lsx_save_data   a0 t1
> +	jirl            zero, ra, 0
"jr ra" for consistency (e.g. with the function immediately above); 
similarly for other such usages.
> +SYM_FUNC_END(kvm_save_lsx)
> +
> +SYM_FUNC_START(kvm_restore_lsx)
> +	lsx_restore_data a0 t1
> +	fpu_restore_cc   a0 t1 t2
> +	fpu_restore_csr  a0 t1
> +	jirl             zero, ra, 0
> +SYM_FUNC_END(kvm_restore_lsx)
> +
> +SYM_FUNC_START(kvm_restore_lsx_upper)
> +	lsx_restore_all_upper a0 t0 t1
> +
> +	jirl                  zero, ra, 0
> +SYM_FUNC_END(kvm_restore_lsx_upper)
> +#endif
> +
>   	.section ".rodata"
>   SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entry)
>   SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
> diff --git a/arch/loongarch/kvm/trace.h b/arch/loongarch/kvm/trace.h
> index a1e35d6554..7da4e230e8 100644
> --- a/arch/loongarch/kvm/trace.h
> +++ b/arch/loongarch/kvm/trace.h
> @@ -102,6 +102,7 @@ TRACE_EVENT(kvm_exit_gspr,
>   #define KVM_TRACE_AUX_DISCARD		4
>   
>   #define KVM_TRACE_AUX_FPU		1
> +#define KVM_TRACE_AUX_LSX		2
>   
>   #define kvm_trace_symbol_aux_op				\
>   	{ KVM_TRACE_AUX_SAVE,		"save" },	\
> @@ -111,7 +112,8 @@ TRACE_EVENT(kvm_exit_gspr,
>   	{ KVM_TRACE_AUX_DISCARD,	"discard" }
>   
>   #define kvm_trace_symbol_aux_state			\
> -	{ KVM_TRACE_AUX_FPU,     "FPU" }
> +	{ KVM_TRACE_AUX_FPU,     "FPU" },		\
> +	{ KVM_TRACE_AUX_LSX,     "LSX" }
>   
>   TRACE_EVENT(kvm_aux,
>   	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int op,
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 73d0c2b9c1..f0bb583353 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -378,9 +378,13 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
>   		break;
>   	case KVM_REG_LOONGARCH_CPUCFG:
>   		id = KVM_GET_IOC_CPUCFG_IDX(reg->id);
> -		if (id >= 0 && id < KVM_MAX_CPUCFG_REGS)
> +		if (id >= 0 && id < KVM_MAX_CPUCFG_REGS) {
>   			vcpu->arch.cpucfg[id] = (u32)v;
> -		else
> +			if (id == 2 && v & CPUCFG2_LSX && !cpu_has_lsx) {
> +				vcpu->arch.cpucfg[id] &= ~CPUCFG2_LSX;
> +				ret = -EINVAL;
> +			}
> +		} else
>   			ret = -EINVAL;
>   		break;
>   	case KVM_REG_LOONGARCH_KVM:
> @@ -561,12 +565,49 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
>   	preempt_enable();
>   }
>   
> +#ifdef CONFIG_CPU_HAS_LSX
> +/* Enable LSX for guest and restore context */
> +void kvm_own_lsx(struct kvm_vcpu *vcpu)
> +{
> +	preempt_disable();
> +
> +	/* Enable LSX for guest */
> +	set_csr_euen(CSR_EUEN_LSXEN | CSR_EUEN_FPEN);
> +	switch (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
> +	case KVM_LARCH_FPU:
> +		/*
> +		 * Guest FPU state already loaded,
> +		 * only restore upper LSX state
> +		 */
> +		kvm_restore_lsx_upper(&vcpu->arch.fpu);
> +		break;
> +	default:
> +		/* Neither FP or LSX already active,
> +		 * restore full LSX state
> +		 */
> +		kvm_restore_lsx(&vcpu->arch.fpu);
> +	break;
> +	}
> +
> +	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
> +	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
> +	preempt_enable();
> +}
> +#endif
> +
>   /* Save context and disable FPU */
>   void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>   {
>   	preempt_disable();
>   
> -	if (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
> +	if (vcpu->arch.aux_inuse & KVM_LARCH_LSX) {
> +		kvm_save_lsx(&vcpu->arch.fpu);
> +		vcpu->arch.aux_inuse &= ~(KVM_LARCH_LSX | KVM_LARCH_FPU);
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LSX);
> +
> +		/* Disable LSX & FPU */
> +		clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN);
> +	} else if (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
>   		kvm_save_fpu(&vcpu->arch.fpu);
>   		vcpu->arch.aux_inuse &= ~KVM_LARCH_FPU;
>   		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU);

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

