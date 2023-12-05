Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50999804E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbjLEJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjLEJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:40:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA510F4;
        Tue,  5 Dec 2023 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701769221; x=1733305221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+aFL7daZnf4Wu6nMRzJmrQS8C8iY+2iKH6YKfjt/76o=;
  b=M/0nVqu30OsMW7frmK7PzJgxr6t5TqSjra6Ex7clrrkx/55WwFa9eM8Q
   PF/dMF6WSGwZTLRoRIxY3+sQZAKXcqEQ6LqqN3595TeBvQ+3EiDJxVwA8
   C6/d6hqtGtBYOfv82NE7MUmauPVkNdQPDZ0xRNI/dDXvoTbkpN5WXl0WQ
   04rrjbYwfR7Q/MbzRknEBPanlJqURrQbFZHyHiGqC5sXXyAQEvzay90XS
   4KP+Hd/B87bNt/upHyqz3ALFQIqnvDoCQVRdkUwyOEPtnbm8L5TajSJzg
   VJ1hx6lxo3AUo0Wy6XTRNRyJ4940+BP8fWEuVGGCf3Q2vBTbZo1Nb5eaT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15418078"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15418078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836920083"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="836920083"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.10.126]) ([10.238.10.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:40:16 -0800
Message-ID: <f011f979-35e9-4f23-be00-4b189777fb13@linux.intel.com>
Date:   Tue, 5 Dec 2023 17:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 005/116] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <9cda464625f085499cd92191dc5d4cd51ad20554.1699368322.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <9cda464625f085499cd92191dc5d4cd51ad20554.1699368322.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 10:55 PM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> TDX requires several initialization steps for KVM to create guest TDs.
> Detect CPU feature, enable VMX (TDX is based on VMX) on all online CPUs,
> detect the TDX module availability, initialize it and disable VMX.
>
> To enable/disable VMX on all online CPUs, utilize
> vmx_hardware_enable/disable().  The method also initializes each CPU for
> TDX.  TDX requires calling a TDX initialization function per logical
> processor (LP) before the LP uses TDX.  When the CPU is becoming online,
> call the TDX LP initialization API.  If it fails to initialize TDX, refuse
> CPU online for simplicity instead of TDX avoiding the failed LP.
>
> There are several options on when to initialize the TDX module.  A.) kernel
> module loading time, B.) the first guest TD creation time.  A.) was chosen.
> With B.), a user may hit an error of the TDX initialization when trying to
> create the first guest TD.  The machine that fails to initialize the TDX
> module can't boot any guest TD further.  Such failure is undesirable and a
> surprise because the user expects that the machine can accommodate guest
> TD, but not.  So A.) is better than B.).
>
> Introduce a module parameter, kvm_intel.tdx, to explicitly enable TDX KVM
> support.  It's off by default to keep the same behavior for those who don't
> use TDX.  Implement hardware_setup method to detect TDX feature of CPU and
> initialize TDX module.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/Makefile      |  1 +
>   arch/x86/kvm/vmx/main.c    | 34 ++++++++++++++-
>   arch/x86/kvm/vmx/tdx.c     | 84 ++++++++++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/x86_ops.h |  8 ++++
>   4 files changed, 125 insertions(+), 2 deletions(-)
>   create mode 100644 arch/x86/kvm/vmx/tdx.c
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 0e894ae23cbc..4b01ab842ab7 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -25,6 +25,7 @@ kvm-$(CONFIG_KVM_SMM)	+= smm.o
>   kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
>   			   vmx/hyperv.o vmx/nested.o vmx/posted_intr.o vmx/main.o
>   kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
> +kvm-intel-$(CONFIG_INTEL_TDX_HOST)	+= vmx/tdx.o
>   
>   kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
>   			   svm/sev.o svm/hyperv.o
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index e07bec005eda..5f89d6b41568 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -6,6 +6,36 @@
>   #include "nested.h"
>   #include "pmu.h"
>   
> +static bool enable_tdx __ro_after_init;
> +module_param_named(tdx, enable_tdx, bool, 0444);
> +
> +static int vt_hardware_enable(void)
> +{
> +	int ret;
> +
> +	ret = vmx_hardware_enable();
> +	if (ret || !enable_tdx)
> +		return ret;
> +
> +	ret = tdx_cpu_enable();

Maybe it's worth a comment to describe this function can only fail on CPU
online path. So if it fails, the CPU will not online.
IMHO, without any comment, it's not so easy to understand the call of
vmx_hardware_disable() on failure.

> +	if (ret)
> +		vmx_hardware_disable();
> +	return ret;
> +}
> +
> +static __init int vt_hardware_setup(void)
> +{
> +	int ret;
> +
> +	ret = vmx_hardware_setup();
> +	if (ret)
> +		return ret;
> +
> +	enable_tdx = enable_tdx && !tdx_hardware_setup(&vt_x86_ops);
> +
> +	return 0;
> +}
> +
>   #define VMX_REQUIRED_APICV_INHIBITS				\
>   	(BIT(APICV_INHIBIT_REASON_DISABLE)|			\
>   	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
> @@ -22,7 +52,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>   
>   	.hardware_unsetup = vmx_hardware_unsetup,
>   
> -	.hardware_enable = vmx_hardware_enable,
> +	.hardware_enable = vt_hardware_enable,
>   	.hardware_disable = vmx_hardware_disable,
>   	.has_emulated_msr = vmx_has_emulated_msr,
>   
> @@ -159,7 +189,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>   };
>   
>   struct kvm_x86_init_ops vt_init_ops __initdata = {
> -	.hardware_setup = vmx_hardware_setup,
> +	.hardware_setup = vt_hardware_setup,
>   	.handle_intel_pt_intr = NULL,
>   
>   	.runtime_ops = &vt_x86_ops,
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> new file mode 100644
> index 000000000000..8a378fb6f1d4
> --- /dev/null
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/cpu.h>
> +
> +#include <asm/tdx.h>
> +
> +#include "capabilities.h"
> +#include "x86_ops.h"
> +#include "x86.h"
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +static int __init tdx_module_setup(void)
> +{
> +	int ret;
> +
> +	ret = tdx_enable();
> +	if (ret) {
> +		pr_info("Failed to initialize TDX module.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct vmx_tdx_enabled {
> +	cpumask_var_t vmx_enabled;
> +	atomic_t err;
> +};
> +
> +static void __init vmx_tdx_on(void *_vmx_tdx)
> +{
> +	struct vmx_tdx_enabled *vmx_tdx = _vmx_tdx;
> +	int r;
> +
> +	r = vmx_hardware_enable();
> +	if (!r) {
> +		cpumask_set_cpu(smp_processor_id(), vmx_tdx->vmx_enabled);
> +		r = tdx_cpu_enable();
> +	}
> +	if (r)
> +		atomic_set(&vmx_tdx->err, r);
> +}
> +
> +static void __init vmx_off(void *_vmx_enabled)
> +{
> +	cpumask_var_t *vmx_enabled = (cpumask_var_t *)_vmx_enabled;
> +
> +	if (cpumask_test_cpu(smp_processor_id(), *vmx_enabled))
> +		vmx_hardware_disable();
> +}
> +
> +int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
> +{
> +	struct vmx_tdx_enabled vmx_tdx = {
> +		.err = ATOMIC_INIT(0),
> +	};
> +	int r = 0;
> +
> +	if (!enable_ept) {
> +		pr_warn("Cannot enable TDX with EPT disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!zalloc_cpumask_var(&vmx_tdx.vmx_enabled, GFP_KERNEL)) {
> +		r = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* tdx_enable() in tdx_module_setup() requires cpus lock. */
> +	cpus_read_lock();
> +	on_each_cpu(vmx_tdx_on, &vmx_tdx, true);	/* TDX requires vmxon. */
> +	r = atomic_read(&vmx_tdx.err);
> +	if (!r)
> +		r = tdx_module_setup();
> +	else
> +		r = -EIO;
> +	on_each_cpu(vmx_off, &vmx_tdx.vmx_enabled, true);
> +	cpus_read_unlock();
> +	free_cpumask_var(vmx_tdx.vmx_enabled);
> +
> +out:
> +	return r;
> +}
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index c4e3ae971f94..86c8ee6954e5 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -18,6 +18,8 @@ bool kvm_is_vmx_supported(void);
>   int __init vmx_init(void);
>   void vmx_exit(void);
>   
> +__init int vmx_hardware_setup(void);
> +
>   extern struct kvm_x86_ops vt_x86_ops __initdata;
>   extern struct kvm_x86_init_ops vt_init_ops __initdata;
>   
> @@ -133,4 +135,10 @@ void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu);
>   #endif
>   void vmx_setup_mce(struct kvm_vcpu *vcpu);
>   
> +#ifdef CONFIG_INTEL_TDX_HOST
> +int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops);
> +#else
> +static inline int tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
> +#endif
> +
>   #endif /* __KVM_X86_VMX_X86_OPS_H */

