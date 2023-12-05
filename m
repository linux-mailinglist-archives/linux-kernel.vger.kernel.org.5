Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A92804396
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjLEAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjLEAsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:48:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF6C4;
        Mon,  4 Dec 2023 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737331; x=1733273331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9beogKZrnue2jWeZInSxedei5tVeH9HIT36azUrOOZg=;
  b=diARr6Bdl2X5Wtmus3r+OjGXC6zfYoIvfgQeB2EDtPOfZa+zrAHRec+J
   VYoVgywWgjTv+dEnS0GGvZwrlCYL/1hhu6pO+jceLWlLOXxX55Q9MQdN3
   nS6HeZgp9WTxC0KC9iny6NMiUs8P6KLfPIH8wjgTxd5QEvM0vBnz1hR95
   /3DUMY8jV5N1ESoE6d8D3mfHWTOK9br9bbBUqcrSQxZVOswm4262itEmJ
   2DIFCoMVU426KCI3Y4MN6aLIfPpYUVWi6wJd0ZGjDf0O67/VMWWsml6Eo
   qf+f+oF0Dl94zcgh1IDYMgyn6Zg4eyxD+zSOyLab2CflxVEsH9s+7LCCM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="867650"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="867650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="799777470"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="799777470"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.10.126]) ([10.238.10.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:48:46 -0800
Message-ID: <0fa7580f-a8e9-408e-b6f5-a71326eedb84@linux.intel.com>
Date:   Tue, 5 Dec 2023 08:48:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 001/116] KVM: VMX: Move out vmx_x86_ops to 'main.c' to
 wrap VMX and TDX
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <167bc6ff99c28ace90f7e9873734a3b5502eddda.1699368322.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <167bc6ff99c28ace90f7e9873734a3b5502eddda.1699368322.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 10:55 PM, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> KVM accesses Virtual Machine Control Structure (VMCS) with VMX instructions
> to operate on VM.  TDX doesn't allow VMM to operate VMCS directly.
> Instead, TDX has its own data structures, and TDX SEAMCALL APIs for VMM to
> indirectly operate those data structures.  This means we must have a TDX
> version of kvm_x86_ops.
>
> The existing global struct kvm_x86_ops already defines an interface which
> fits with TDX.  But kvm_x86_ops is system-wide, not per-VM structure.  To
> allow VMX to coexist with TDs, the kvm_x86_ops callbacks will have wrappers
> "if (tdx) tdx_op() else vmx_op()" to switch VMX or TDX at run time.
>
> To split the runtime switch, the VMX implementation, and the TDX
> implementation, add main.c, and move out the vmx_x86_ops hooks in
> preparation for adding TDX, which can coexist with VMX, i.e. KVM can run
> both VMs and TDs.  Use 'vt' for the naming scheme as a nod to VT-x and as a
> concatenation of VmxTdx.
>
> The current code looks as follows.
> In vmx.c
>    static vmx_op() { ... }
>    static struct kvm_x86_ops vmx_x86_ops = {
>          .op = vmx_op,
>    initialization code
>
> The eventually converted code will look like
> In vmx.c, keep the VMX operations.
>    vmx_op() { ... }
>    VMX initialization
> In tdx.c, define the TDX operations.
>    tdx_op() { ... }
>    TDX initialization
> In x86_ops.h, declare the VMX and TDX operations.
>    vmx_op();
>    tdx_op();
> In main.c, define common wrappers for VMX and TDX.
>    static vt_ops() { if (tdx) tdx_ops() else vmx_ops() }
>    static struct kvm_x86_ops vt_x86_ops = {
>          .op = vt_op,
>    initialization to call VMX and TDX initialization
>
> Opportunistically, fix the name inconsistency from vmx_create_vcpu() and
> vmx_free_vcpu() to vmx_vcpu_create() and vxm_vcpu_free().

Nit: 3 indentation alignment below.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/Makefile      |   2 +-
>   arch/x86/kvm/vmx/main.c    | 167 +++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c     | 374 ++++++++++---------------------------
>   arch/x86/kvm/vmx/x86_ops.h | 125 +++++++++++++
>   4 files changed, 395 insertions(+), 273 deletions(-)
>   create mode 100644 arch/x86/kvm/vmx/main.c
>   create mode 100644 arch/x86/kvm/vmx/x86_ops.h
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 80e3fe184d17..0e894ae23cbc 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -23,7 +23,7 @@ kvm-$(CONFIG_KVM_XEN)	+= xen.o
>   kvm-$(CONFIG_KVM_SMM)	+= smm.o
>   
>   kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
> -			   vmx/hyperv.o vmx/nested.o vmx/posted_intr.o
> +			   vmx/hyperv.o vmx/nested.o vmx/posted_intr.o vmx/main.o
>   kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
>   
>   kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
[...]
>   
> -static int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
> +int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
>   					 void *insn, int insn_len)
Indentaion alignment

>   {
>   	/*
> @@ -1742,7 +1740,7 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
>    * Recognizes a pending MTF VM-exit and records the nested state for later
>    * delivery.
>    */
> -static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
> +void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
>   {
>   	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>   	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -1773,7 +1771,7 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
>   	}
>   }
>   
[...]
> +u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> +void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> +		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
Indentation alignment

> +u64 vmx_get_l2_tsc_offset(struct kvm_vcpu *vcpu);
> +u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
> +void vmx_write_tsc_offset(struct kvm_vcpu *vcpu);
> +void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu);
> +void vmx_request_immediate_exit(struct kvm_vcpu *vcpu);
> +void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu);
> +void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
> +#ifdef CONFIG_X86_64
> +int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
> +		bool *expired);

Indentation alignment

> +void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu);
> +#endif
> +void vmx_setup_mce(struct kvm_vcpu *vcpu);
> +
> +#endif /* __KVM_X86_VMX_X86_OPS_H */

