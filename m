Return-Path: <linux-kernel+bounces-150946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D298AA707
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562A81F22677
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96715664;
	Fri, 19 Apr 2024 02:45:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DE10E3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713494735; cv=none; b=YMYbcdMsxjV0+1JGdmD/2rFj+FzaxqaOEnCPwkw/iHogILiX7UNAi/7sU6eWPqzddHEhXi2+6yCaXj4hPdnyXF5eJ4TUukuzt0NSYCI0WwWLlpRJWyjwi6wEbeQWr7Pn6h8Kx3A7iWiCYtXZh3nxO6f8ImJTauW2d/T0gpClX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713494735; c=relaxed/simple;
	bh=Iae9cynw7OmdrWRsk+f/gAQZF6urO+XjsPxDrtQgW4c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sOgFPb4x69QnFl4ut7793yjQusMdVRfuQ9TuJXEBVO26oXY5bWapB10bxtwPv0K8ZDR7tm/BpSIeiHXy9uqp6iDLyTkNaFYJdJhk2hDTie364wmTS6VmIKHvlJ9QieaqUcA7anW4Ai9j8xTRDE4RHMpgrzyPjVthRwF6hlQ6HE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxebrK2iFmXpopAA--.13089S3;
	Fri, 19 Apr 2024 10:45:30 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWRLG2iFmo8Z_AA--.35587S3;
	Fri, 19 Apr 2024 10:45:28 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KVM: Add PMU support
To: Song Gao <gaosong@loongson.cn>, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, zhaotianrui@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, loongarch@lists.linux.dev
References: <20240417065236.500011-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <82ddc457-5204-c05e-28cf-688cd8121f2f@loongson.cn>
Date: Fri, 19 Apr 2024 10:45:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240417065236.500011-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxWRLG2iFmo8Z_AA--.35587S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZF47uryDtr1UArWUJF1xXrc_yoW8GF47Co
	W8tan29rWrJw43Aw4DKrnFqayUZrW8uw4kAFy5Aw1ru3W7J345WrW8Kw4rtFy3WF98ur17
	uay2qa1vgFy8K3Zxl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYW7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2024/4/17 下午2:52, Song Gao wrote:
> On LoongArch, the host and guest have their own PMU CSRs registers
> and they share PMU hardware resources. A set of PMU CSRs consists of
> a CTRL register and a CNTR register. We can set which PMU CSRs are used
> by the guest by writing to the GCFG register [24: 26] bits.
> 
> On KVM side. we save the host PMU CSRs into structure kvm_context.
> If the host supports the PMU feature. When entering guest mode.
> we save the host PMU CSRs and restore the guest PMU CSRs. When exiting
> guest mode, we save the guest PMU CSRs and restore the host PMU CSRs.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> 
> v1->v2:
>    1. Add new vcpu->request flag KVM_REQ_PMU. If we use PMU,
> We need to set this flag;
>    2. Add kvm_check_pmu() to kvm_pre_enter_guest();
>    3. On _kvm_setcsr(), after modifying the PMU CSR register value,
> if we use PMU, we need to set KVM_REQ_PMU.
> 
> ---
>   arch/loongarch/include/asm/kvm_csr.h   |   5 +
>   arch/loongarch/include/asm/kvm_host.h  |  20 +++
>   arch/loongarch/include/asm/loongarch.h |   1 +
>   arch/loongarch/kvm/exit.c              |   8 ++
>   arch/loongarch/kvm/vcpu.c              | 185 ++++++++++++++++++++++++-
>   5 files changed, 217 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_csr.h b/arch/loongarch/include/asm/kvm_csr.h
> index 724ca8b7b401..289c3671ee25 100644
> --- a/arch/loongarch/include/asm/kvm_csr.h
> +++ b/arch/loongarch/include/asm/kvm_csr.h
> @@ -208,4 +208,9 @@ static __always_inline void kvm_change_sw_gcsr(struct loongarch_csrs *csr,
>   	csr->csrs[gid] |= val & _mask;
>   }
>   
> +#define KVM_PMU_EVENT_ENABLED	(CSR_PERFCTRL_PLV0 |		\
> +					CSR_PERFCTRL_PLV1 |	\
> +					CSR_PERFCTRL_PLV2 |	\
> +					CSR_PERFCTRL_PLV3)
> +
>   #endif	/* __ASM_LOONGARCH_KVM_CSR_H__ */
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 2d62f7b0d377..e1d64e26e7cb 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -51,9 +51,14 @@ struct kvm_arch_memory_slot {
>   	unsigned long flags;
>   };
>   
> +#define KVM_REQ_PMU			KVM_ARCH_REQ(0)
> +#define HOST_MAX_PMNUM			16
>   struct kvm_context {
>   	unsigned long vpid_cache;
>   	struct kvm_vcpu *last_vcpu;
> +	/* Save host pmu csr */
> +	u64 perf_ctrl[HOST_MAX_PMNUM];
> +	u64 perf_cntr[HOST_MAX_PMNUM];
>   };
>   
>   struct kvm_world_switch {
> @@ -99,6 +104,8 @@ enum emulation_result {
>   #define KVM_LARCH_LASX		(0x1 << 2)
>   #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
>   #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
> +#define KVM_GUEST_PMU_ENABLE	(0x1 << 5)
> +#define KVM_GUEST_PMU_ACTIVE	(0x1 << 6)
>   
>   struct kvm_vcpu_arch {
>   	/*
> @@ -136,6 +143,9 @@ struct kvm_vcpu_arch {
>   	/* CSR state */
>   	struct loongarch_csrs *csr;
>   
> +	/* Guest max PMU CSR id */
> +	int max_pmu_csrid;
> +
>   	/* GPR used as IO source/target */
>   	u32 io_gpr;
>   
> @@ -195,6 +205,16 @@ static inline bool kvm_guest_has_lasx(struct kvm_vcpu_arch *arch)
>   	return arch->cpucfg[2] & CPUCFG2_LASX;
>   }
>   
> +static inline bool kvm_guest_has_pmu(struct kvm_vcpu_arch *arch)
> +{
> +	return arch->cpucfg[LOONGARCH_CPUCFG6] & CPUCFG6_PMP;
> +}
> +
> +static inline int kvm_get_pmu_num(struct kvm_vcpu_arch *arch)
> +{
> +	return (arch->cpucfg[LOONGARCH_CPUCFG6] & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT;
> +}
> +
>   /* Debug: dump vcpu state */
>   int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
>   
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> index 46366e783c84..644380b6ebec 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -119,6 +119,7 @@
>   #define  CPUCFG6_PMP			BIT(0)
>   #define  CPUCFG6_PAMVER			GENMASK(3, 1)
>   #define  CPUCFG6_PMNUM			GENMASK(7, 4)
> +#define  CPUCFG6_PMNUM_SHIFT		4
>   #define  CPUCFG6_PMBITS			GENMASK(13, 8)
>   #define  CPUCFG6_UPM			BIT(14)
>   
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index ed1d89d53e2e..636cd1500135 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -83,6 +83,14 @@ static int kvm_handle_csr(struct kvm_vcpu *vcpu, larch_inst inst)
>   	rj = inst.reg2csr_format.rj;
>   	csrid = inst.reg2csr_format.csr;
>   
> +	if (csrid >= LOONGARCH_CSR_PERFCTRL0 && csrid <= vcpu->arch.max_pmu_csrid) {
> +		if (kvm_guest_has_pmu(&vcpu->arch)) {
> +			vcpu->arch.pc -= 4;
> +			kvm_make_request(KVM_REQ_PMU, vcpu);
> +			return EMULATE_DONE;
> +		}
> +	}
> +
>   	/* Process CSR ops */
>   	switch (rj) {
>   	case 0: /* process csrrd */
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 3a8779065f73..daef2498ad48 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -30,6 +30,144 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
>   		       sizeof(kvm_vcpu_stats_desc),
>   };
>   
> +static inline void kvm_save_host_pmu(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_context *context;
> +
> +	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
> +	context->perf_ctrl[0] = read_csr_perfctrl0();
> +	context->perf_cntr[0] = read_csr_perfcntr0();
> +	context->perf_ctrl[1] = read_csr_perfctrl1();
> +	context->perf_cntr[1] = read_csr_perfcntr1();
> +	context->perf_ctrl[2] = read_csr_perfctrl2();
> +	context->perf_cntr[2] = read_csr_perfcntr2();
> +	context->perf_ctrl[3] = read_csr_perfctrl3();
> +	context->perf_cntr[3] = read_csr_perfcntr3();
> +}
> +
> +static inline void kvm_restore_host_pmu(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_context *context;
> +
> +	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
> +	write_csr_perfctrl0(context->perf_ctrl[0]);
> +	write_csr_perfcntr0(context->perf_cntr[0]);
> +	write_csr_perfctrl1(context->perf_ctrl[1]);
> +	write_csr_perfcntr1(context->perf_cntr[1]);
> +	write_csr_perfctrl2(context->perf_ctrl[2]);
> +	write_csr_perfcntr2(context->perf_cntr[2]);
> +	write_csr_perfctrl3(context->perf_ctrl[3]);
> +	write_csr_perfcntr3(context->perf_cntr[3]);
> +}
With pmu restore, we should firstly restore pmu event data, then pmu 
event ctrl register. There will be contension risk between SW retore and 
HW modification about pmu event data,  if pmu event ctrl is first 
restored and enabled.

> +
> +
> +static inline void kvm_save_guest_pmu(struct kvm_vcpu *vcpu)
> +{
> +	struct loongarch_csrs *csr = vcpu->arch.csr;
> +
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
> +	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL0, 0);
> +	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL1, 0);
> +	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL2, 0);
> +	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL3, 0);
> +}
what is the usage about kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRLxx, 0)? 
Is it to save and disable guest perf?  If it is, There should be 
similiar with function kvm_save_host_pmu().


> +
> +static inline void kvm_restore_guest_pmu(struct kvm_vcpu *vcpu)
> +{
> +	struct loongarch_csrs *csr = vcpu->arch.csr;
> +
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
> +	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
> +}
Ditto, pmu event data should firstly restore, and then pmu event ctrl.


Regards
Bibo Mao

> +
> +static void kvm_lose_pmu(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long val;
> +	struct loongarch_csrs *csr = vcpu->arch.csr;
> +
> +	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ENABLE))
> +		return;
> +	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ACTIVE))
> +		return;
> +
> +	kvm_save_guest_pmu(vcpu);
> +	/* Disable pmu access from guest */
> +	write_csr_gcfg(read_csr_gcfg() & ~CSR_GCFG_GPERF);
> +
> +	/*
> +	 * Clear KVM_GUEST_PMU_ENABLE if the guest is not using PMU CSRs
> +	 * when exiting the guest, so that the next time trap into the guest.
> +	 * we don't need to deal with PMU CSRs contexts.
> +	 */
> +	val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
> +	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
> +	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
> +	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
> +	if (!(val & KVM_PMU_EVENT_ENABLED))
> +		vcpu->arch.aux_inuse &= ~KVM_GUEST_PMU_ENABLE;
> +	kvm_restore_host_pmu(vcpu);
> +
> +	/* KVM_GUEST_PMU_ACTIVE needs to be cleared when exiting the guest */
> +	vcpu->arch.aux_inuse &= ~KVM_GUEST_PMU_ACTIVE;
> +}
> +
> +static void kvm_own_pmu(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long val;
> +
> +	kvm_save_host_pmu(vcpu);
> +	/* Set PM0-PM(num) to guest */
> +	val = read_csr_gcfg() & ~CSR_GCFG_GPERF;
> +	val |= (kvm_get_pmu_num(&vcpu->arch) + 1) << CSR_GCFG_GPERF_SHIFT;
> +	write_csr_gcfg(val);
> +	kvm_restore_guest_pmu(vcpu);
> +}
> +
> +static void kvm_restore_pmu(struct kvm_vcpu *vcpu)
> +{
> +	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ENABLE))
> +		return;
> +
> +	kvm_make_request(KVM_REQ_PMU, vcpu);
> +}
> +
> +static void kvm_check_pmu(struct kvm_vcpu *vcpu)
> +{
> +	if (!kvm_check_request(KVM_REQ_PMU, vcpu))
> +		return;
> +
> +	kvm_own_pmu(vcpu);
> +
> +	/*
> +	 * Set KVM_GUEST PMU_ENABLE and GUEST_PMU_ACTIVE
> +	 * when guest has KVM_REQ_PMU request.
> +	 */
> +	vcpu->arch.aux_inuse |= KVM_GUEST_PMU_ENABLE;
> +	vcpu->arch.aux_inuse |= KVM_GUEST_PMU_ACTIVE;
> +
> +	/*
> +	 * Save the PMU CSRs context when there is a host PMU interrupt.
> +	 * and set KVM_REQ_PMU.
> +	 */
> +	if (read_csr_estat() & CPU_PMU) {
> +		kvm_lose_pmu(vcpu);
> +		kvm_make_request(KVM_REQ_PMU, vcpu);
> +	}
> +}
> +
>   /*
>    * kvm_check_requests - check and handle pending vCPU requests
>    *
> @@ -100,6 +238,7 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
>   		/* Make sure the vcpu mode has been written */
>   		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
>   		kvm_check_vpid(vcpu);
> +		kvm_check_pmu(vcpu);
>   		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
>   		/* Clear KVM_LARCH_SWCSR_LATEST as CSR will change when enter guest */
>   		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
> @@ -295,6 +434,21 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
>   
>   	kvm_write_sw_gcsr(csr, id, val);
>   
> +	/*
> +	 * After modifying the PMU CSR register value of the vcpu.
> +	 * If the PMU CSRs are used, we need to set KVM_REQ_PMU.
> +	 */
> +	if (id >= LOONGARCH_CSR_PERFCTRL0 && id <= LOONGARCH_CSR_PERFCNTR3) {
> +		unsigned long val;
> +
> +		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
> +		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
> +		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
> +		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
> +		if (val & KVM_PMU_EVENT_ENABLED)
> +			kvm_make_request(KVM_REQ_PMU, vcpu);
> +	}
> +
>   	return ret;
>   }
>   
> @@ -333,6 +487,12 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
>   	case LOONGARCH_CPUCFG5:
>   		*v = GENMASK(31, 0);
>   		return 0;
> +	case LOONGARCH_CPUCFG6:
> +		if (cpu_has_pmp)
> +			*v = GENMASK(14, 0);
> +		else
> +			*v = 0;
> +		return 0;
>   	case LOONGARCH_CPUCFG16:
>   		*v = GENMASK(16, 0);
>   		return 0;
> @@ -351,7 +511,7 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
>   
>   static int kvm_check_cpucfg(int id, u64 val)
>   {
> -	int ret;
> +	int ret, host;
>   	u64 mask = 0;
>   
>   	ret = _kvm_get_cpucfg_mask(id, &mask);
> @@ -377,6 +537,18 @@ static int kvm_check_cpucfg(int id, u64 val)
>   			/* LASX architecturally implies LSX and FP but val does not satisfy that */
>   			return -EINVAL;
>   		return 0;
> +	case LOONGARCH_CPUCFG6:
> +		if (val & CPUCFG6_PMP) {
> +			host = read_cpucfg(LOONGARCH_CPUCFG6);
> +			if ((val & CPUCFG6_PMBITS) != (host & CPUCFG6_PMBITS))
> +				/* Guest pmbits must be the same with host */
> +				return -EINVAL;
> +			if ((val & CPUCFG6_PMNUM) > (host & CPUCFG6_PMNUM))
> +				return -EINVAL;
> +			if ((val & CPUCFG6_UPM) && !(host & CPUCFG6_UPM))
> +				return -EINVAL;
> +		}
> +		return 0;
>   	default:
>   		/*
>   		 * Values for the other CPUCFG IDs are not being further validated
> @@ -459,6 +631,10 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
>   		if (ret)
>   			break;
>   		vcpu->arch.cpucfg[id] = (u32)v;
> +		if (id == LOONGARCH_CPUCFG6) {
> +			vcpu->arch.max_pmu_csrid = LOONGARCH_CSR_PERFCTRL0 +
> +							2 * kvm_get_pmu_num(&vcpu->arch) + 1;
> +		}
>   		break;
>   	case KVM_REG_LOONGARCH_KVM:
>   		switch (reg->id) {
> @@ -552,7 +728,8 @@ static int kvm_loongarch_cpucfg_has_attr(struct kvm_vcpu *vcpu,
>   					 struct kvm_device_attr *attr)
>   {
>   	switch (attr->attr) {
> -	case 2:
> +	case LOONGARCH_CPUCFG2:
> +	case LOONGARCH_CPUCFG6:
>   		return 0;
>   	default:
>   		return -ENXIO;
> @@ -982,6 +1159,9 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   	/* Control guest page CCA attribute */
>   	change_csr_gcfg(CSR_GCFG_MATC_MASK, CSR_GCFG_MATC_ROOT);
>   
> +	/* Restore hardware PMU CSRs */
> +	kvm_restore_pmu(vcpu);
> +
>   	/* Don't bother restoring registers multiple times unless necessary */
>   	if (vcpu->arch.aux_inuse & KVM_LARCH_HWCSR_USABLE)
>   		return 0;
> @@ -1065,6 +1245,7 @@ static int _kvm_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
>   	struct loongarch_csrs *csr = vcpu->arch.csr;
>   
>   	kvm_lose_fpu(vcpu);
> +	kvm_lose_pmu(vcpu);
>   
>   	/*
>   	 * Update CSR state from hardware if software CSR state is stale,
> 


