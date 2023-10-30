Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D57DB2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjJ3FRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3FRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:17:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A23C2;
        Sun, 29 Oct 2023 22:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698643070; x=1730179070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIStc9GOYwCOvHrL8lm6DnRI3x60BMV87uFJC0r9mIg=;
  b=YtD5y4TkcjuzuitYZZI1vEPfsXBsbUWmWEsxkYIU1BtHdVfRYeu+amtF
   qKTbqvQ+6EtzRTtFHr7x13Sf3frDljjyhoiLig8XHHcKRHJ0tYj4KpqqA
   Q3lSy9eNLVT+sgJkt82lz9Ximc30d4T8cjsMPs1pX63tng0FZprBmx/Ng
   sYGquW3UX9UfNzI/8nnMdC7BUQbf0WL0DEoV+Zxmxs1rEKhy5eXyibUyK
   JwrpCXZAlFhJ/wj8v1E1mTYDt7g+Jpjx8QJ5QUIJJFYGNm+it7+mj6ALX
   erx9trsq2AEjba6mrUEpL9+VBpFhF96Tpgua3Og9OJjHWyiy+aPWWooUa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="474246358"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="474246358"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 22:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="1354681"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.9.145]) ([10.93.9.145])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 22:17:46 -0700
Message-ID: <61b2ef33-8ecf-4fe8-86fe-d1fe598e4db0@intel.com>
Date:   Mon, 30 Oct 2023 13:17:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/kvm/async_pf: Use separate percpu variable to
 track the enabling of asyncpf
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025055914.1201792-1-xiaoyao.li@intel.com>
 <20231025055914.1201792-2-xiaoyao.li@intel.com> <87a5s73w53.fsf@redhat.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87a5s73w53.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 5:10 PM, Vitaly Kuznetsov wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Refer to commit fd10cde9294f ("KVM paravirt: Add async PF initialization
>> to PV guest") and commit 344d9588a9df ("KVM: Add PV MSR to enable
>> asynchronous page faults delivery"). It turns out that at the time when
>> asyncpf was introduced, the purpose was defining the shared PV data 'struct
>> kvm_vcpu_pv_apf_data' with the size of 64 bytes. However, it made a mistake
>> and defined the size to 68 bytes, which failed to make fit in a cache line
>> and made the code inconsistent with the documentation.
> 
> Oh, I actually though it was done on purpose :-) 'enabled' is not
> accessed by the host, it's only purpose is to cache MSR_KVM_ASYNC_PF_EN.

I didn't find any clue to show it was on purpose, so thought it was a 
mistake. Anyway, if the fact is it was done on purpose and people now 
still accept it. I can drop this patch, and write another one to 
document it's intentional instead.

>>
>> Below justification quoted from Sean[*]
>>
>>    KVM (the host side) has *never* read kvm_vcpu_pv_apf_data.enabled, and
>>    the documentation clearly states that enabling is based solely on the
>>    bit in the synthetic MSR.
>>
>>    So rather than update the documentation, fix the goof by removing the
>>    enabled filed and use the separate percpu variable instread.
>>    KVM-as-a-host obviously doesn't enforce anything or consume the size,
>>    and changing the header will only affect guests that are rebuilt against
>>    the new header, so there's no chance of ABI breakage between KVM and its
>>    guests. The only possible breakage is if some other hypervisor is
>>    emulating KVM's async #PF (LOL) and relies on the guest to set
>>    kvm_vcpu_pv_apf_data.enabled. But (a) I highly doubt such a hypervisor
>>    exists, (b) that would arguably be a violation of KVM's "spec", and
>>    (c) the worst case scenario is that the guest would simply lose async
>>    #PF functionality.
>>
>> [*] https://lore.kernel.org/all/ZS7ERnnRqs8Fl0ZF@google.com/T/#u
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   Documentation/virt/kvm/x86/msr.rst   |  1 -
>>   arch/x86/include/uapi/asm/kvm_para.h |  1 -
>>   arch/x86/kernel/kvm.c                | 11 ++++++-----
>>   3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/x86/msr.rst b/Documentation/virt/kvm/x86/msr.rst
>> index 9315fc385fb0..f6d70f99a1a7 100644
>> --- a/Documentation/virt/kvm/x86/msr.rst
>> +++ b/Documentation/virt/kvm/x86/msr.rst
>> @@ -204,7 +204,6 @@ data:
>>   		__u32 token;
>>   
>>   		__u8 pad[56];
>> -		__u32 enabled;
>>   	  };
>>   
>>   	Bits 5-4 of the MSR are reserved and should be zero. Bit 0 is set to 1
>> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
>> index 6e64b27b2c1e..605899594ebb 100644
>> --- a/arch/x86/include/uapi/asm/kvm_para.h
>> +++ b/arch/x86/include/uapi/asm/kvm_para.h
>> @@ -142,7 +142,6 @@ struct kvm_vcpu_pv_apf_data {
>>   	__u32 token;
>>   
>>   	__u8 pad[56];
>> -	__u32 enabled;
>>   };
>>   
>>   #define KVM_PV_EOI_BIT 0
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index b8ab9ee5896c..388a3fdd3cad 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -65,6 +65,7 @@ static int __init parse_no_stealacc(char *arg)
>>   
>>   early_param("no-steal-acc", parse_no_stealacc);
>>   
>> +static DEFINE_PER_CPU_READ_MOSTLY(bool, async_pf_enabled);
> 
> Would it make a difference is we replace this with a cpumask? I realize
> that we need to access it on all CPUs from hotpaths but this mask will
> rarely change so maybe there's no real perfomance hit?
> 
>>   static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
>>   DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
>>   static int has_steal_clock = 0;
>> @@ -244,7 +245,7 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
>>   {
>>   	u32 flags = 0;
>>   
>> -	if (__this_cpu_read(apf_reason.enabled)) {
>> +	if (__this_cpu_read(async_pf_enabled)) {
>>   		flags = __this_cpu_read(apf_reason.flags);
>>   		__this_cpu_write(apf_reason.flags, 0);
>>   	}
>> @@ -295,7 +296,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
>>   
>>   	inc_irq_stat(irq_hv_callback_count);
>>   
>> -	if (__this_cpu_read(apf_reason.enabled)) {
>> +	if (__this_cpu_read(async_pf_enabled)) {
>>   		token = __this_cpu_read(apf_reason.token);
>>   		kvm_async_pf_task_wake(token);
>>   		__this_cpu_write(apf_reason.token, 0);
>> @@ -362,7 +363,7 @@ static void kvm_guest_cpu_init(void)
>>   		wrmsrl(MSR_KVM_ASYNC_PF_INT, HYPERVISOR_CALLBACK_VECTOR);
>>   
>>   		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
>> -		__this_cpu_write(apf_reason.enabled, 1);
>> +		__this_cpu_write(async_pf_enabled, 1);
> 
> As 'async_pf_enabled' is bool, it would probably be more natural to
> write
> 
> 	__this_cpu_write(async_pf_enabled, true);
> 
>>   		pr_debug("setup async PF for cpu %d\n", smp_processor_id());
>>   	}
>>   
>> @@ -383,11 +384,11 @@ static void kvm_guest_cpu_init(void)
>>   
>>   static void kvm_pv_disable_apf(void)
>>   {
>> -	if (!__this_cpu_read(apf_reason.enabled))
>> +	if (!__this_cpu_read(async_pf_enabled))
>>   		return;
>>   
>>   	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
>> -	__this_cpu_write(apf_reason.enabled, 0);
>> +	__this_cpu_write(async_pf_enabled, 0);
> 
> ... and 'false' here.

sure, I can do it in a v3, if v3 is needed.

>>   
>>   	pr_debug("disable async PF for cpu %d\n", smp_processor_id());
>>   }
> 

