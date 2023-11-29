Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A37FCDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376837AbjK2Du1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376829AbjK2DuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485E12C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701229830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWBuXSLaFECWeXZmOe630vFgcCYGV2E86Z2wpbPrfbQ=;
        b=Aji1I9OgyVF4u45MGc8wI2w1cwm1tqtNH5xYwPilXnTFC14jcHGAgfAMEMGlw8AG4mg+XT
        Oeni8llG+TYvKFSCq8quLIIzHZtDju57YFKRn0BUksyf6WaIJ2hKbvdXlqdqgsclSVutRS
        u/sASC0MPlO03ING1mb76G9DeTRu4W4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-0rHQm99bOZyJRkBPQ849JQ-1; Tue, 28 Nov 2023 22:50:28 -0500
X-MC-Unique: 0rHQm99bOZyJRkBPQ849JQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-285a2ff807cso1484278a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229827; x=1701834627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWBuXSLaFECWeXZmOe630vFgcCYGV2E86Z2wpbPrfbQ=;
        b=LvBKZLUBQjZe79/PaM19iAyB3Ir6P+PMEQhAJmV2T5Oyqw04uIKivAkJP28C/WOntx
         DT9rL5o0W2M47jXPSwsPOz1ED4OdzGTmmg+oS+XB0inCk3dae5muXFjS7apGjCh/HGmE
         shclbHXIwXEw5fggubV4IA+D6u4hhRO3f4BA2XvgtWsBpBtkzWA+27A3G7j6dzY05bi5
         RTXEMQFOnqwjlNhLONWXPUqGRkBNJOVcV8dnsZrAqhXSS5uh72V6Lup9pbcMu5qVAxAt
         wGBHtYnaKQLqK0ERZXllE5uw5kI3Hvp4khkmEXYelZMHG04hGOjrTYKY83MsU9BxDvj7
         stKQ==
X-Gm-Message-State: AOJu0YzB4LmNHesZixGduATNbuKYKaV1g31TgpBhitTlucixJ5hrGSIF
        CiY6KvJX7B4LqXkwh8DDZfV360aZXrcmemVoJQUMtLzWoro4fMEt6BzeaORkDzuMmuwJJb97cpi
        MY6TzY3qWrqSqM1ObJ8PIEciN
X-Received: by 2002:a05:6a20:7f8c:b0:18a:f711:7c12 with SMTP id d12-20020a056a207f8c00b0018af7117c12mr19490487pzj.4.1701229827151;
        Tue, 28 Nov 2023 19:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN3AX84B8X2zf2aFhXbzVZIN3DXqw4G7xwuMEZsbX3qJAM7v6wsXKhXMYWgJVAnoOpTzUcdQ==
X-Received: by 2002:a05:6a20:7f8c:b0:18a:f711:7c12 with SMTP id d12-20020a056a207f8c00b0018af7117c12mr19490474pzj.4.1701229826834;
        Tue, 28 Nov 2023 19:50:26 -0800 (PST)
Received: from [10.72.112.34] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a01d000b00285cc7a867esm323872pjd.0.2023.11.28.19.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 19:50:26 -0800 (PST)
Message-ID: <9538a359-60df-6214-72c0-d9112e7e7715@redhat.com>
Date:   Wed, 29 Nov 2023 11:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] KVM: selftests: aarch64: Move the pmu helper
 function into lib/
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-3-shahuang@redhat.com>
 <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghavendra,

On 11/28/23 05:48, Raghavendra Rao Ananta wrote:
> Hi Shaoqin,
> 
> On Wed, Nov 22, 2023 at 10:39 PM Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> Move those pmu helper function into lib/, thus it can be used by other
>> pmu test.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
>>   .../selftests/kvm/include/aarch64/vpmu.h      | 119 ++++++++++++++++++
>>   2 files changed, 119 insertions(+), 118 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> index 17305408a334..62d6315790ab 100644
>> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> @@ -20,12 +20,6 @@
>>   #include <perf/arm_pmuv3.h>
>>   #include <linux/bitfield.h>
>>
>> -/* The max number of the PMU event counters (excluding the cycle counter) */
>> -#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>> -
>> -/* The cycle counter bit position that's common among the PMU registers */
>> -#define ARMV8_PMU_CYCLE_IDX            31
>> -
>>   static struct vpmu_vm *vpmu_vm;
>>
>>   struct pmreg_sets {
>> @@ -35,118 +29,6 @@ struct pmreg_sets {
>>
>>   #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
>>
>> -static uint64_t get_pmcr_n(uint64_t pmcr)
>> -{
>> -       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
>> -}
>> -
>> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>> -{
>> -       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
>> -       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>> -}
>> -
>> -static uint64_t get_counters_mask(uint64_t n)
>> -{
>> -       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>> -
>> -       if (n)
>> -               mask |= GENMASK(n - 1, 0);
>> -       return mask;
>> -}
>> -
>> -/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> -static inline unsigned long read_sel_evcntr(int sel)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       return read_sysreg(pmxevcntr_el0);
>> -}
>> -
>> -/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> -static inline void write_sel_evcntr(int sel, unsigned long val)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       write_sysreg(val, pmxevcntr_el0);
>> -       isb();
>> -}
>> -
>> -/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> -static inline unsigned long read_sel_evtyper(int sel)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       return read_sysreg(pmxevtyper_el0);
>> -}
>> -
>> -/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> -static inline void write_sel_evtyper(int sel, unsigned long val)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       write_sysreg(val, pmxevtyper_el0);
>> -       isb();
>> -}
>> -
>> -static inline void enable_counter(int idx)
>> -{
>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>> -
>> -       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>> -       isb();
>> -}
>> -
>> -static inline void disable_counter(int idx)
>> -{
>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>> -
>> -       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>> -       isb();
>> -}
>> -
>> -static void pmu_disable_reset(void)
>> -{
>> -       uint64_t pmcr = read_sysreg(pmcr_el0);
>> -
>> -       /* Reset all counters, disabling them */
>> -       pmcr &= ~ARMV8_PMU_PMCR_E;
>> -       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
>> -       isb();
>> -}
>> -
>> -#define RETURN_READ_PMEVCNTRN(n) \
>> -       return read_sysreg(pmevcntr##n##_el0)
>> -static unsigned long read_pmevcntrn(int n)
>> -{
>> -       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>> -       return 0;
>> -}
>> -
>> -#define WRITE_PMEVCNTRN(n) \
>> -       write_sysreg(val, pmevcntr##n##_el0)
>> -static void write_pmevcntrn(int n, unsigned long val)
>> -{
>> -       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>> -       isb();
>> -}
>> -
>> -#define READ_PMEVTYPERN(n) \
>> -       return read_sysreg(pmevtyper##n##_el0)
>> -static unsigned long read_pmevtypern(int n)
>> -{
>> -       PMEVN_SWITCH(n, READ_PMEVTYPERN);
>> -       return 0;
>> -}
>> -
>> -#define WRITE_PMEVTYPERN(n) \
>> -       write_sysreg(val, pmevtyper##n##_el0)
>> -static void write_pmevtypern(int n, unsigned long val)
>> -{
>> -       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>> -       isb();
>> -}
>> -
>>   /*
>>    * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
>>    * accessors that test cases will use. Each of the accessors will
>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> index 0a56183644ee..e0cc1ca1c4b7 100644
>> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> @@ -1,10 +1,17 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>
>>   #include <kvm_util.h>
>> +#include <perf/arm_pmuv3.h>
>>
>>   #define GICD_BASE_GPA  0x8000000ULL
>>   #define GICR_BASE_GPA  0x80A0000ULL
>>
>> +/* The max number of the PMU event counters (excluding the cycle counter) */
>> +#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>> +
>> +/* The cycle counter bit position that's common among the PMU registers */
>> +#define ARMV8_PMU_CYCLE_IDX            31
>> +
>>   struct vpmu_vm {
>>          struct kvm_vm *vm;
>>          struct kvm_vcpu *vcpu;
>> @@ -14,3 +21,115 @@ struct vpmu_vm {
>>   struct vpmu_vm *create_vpmu_vm(void *guest_code);
>>
>>   void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
>> +
>> +static inline uint64_t get_pmcr_n(uint64_t pmcr)
>> +{
>> +       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
>> +}
>> +
>> +static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>> +{
>> +       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
>> +       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>> +}
>> +
>> +static inline uint64_t get_counters_mask(uint64_t n)
>> +{
>> +       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>> +
>> +       if (n)
>> +               mask |= GENMASK(n - 1, 0);
>> +       return mask;
>> +}
>> +
>> +/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> +static inline unsigned long read_sel_evcntr(int sel)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       return read_sysreg(pmxevcntr_el0);
>> +}
>> +
>> +/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> +static inline void write_sel_evcntr(int sel, unsigned long val)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       write_sysreg(val, pmxevcntr_el0);
>> +       isb();
>> +}
>> +
>> +/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> +static inline unsigned long read_sel_evtyper(int sel)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       return read_sysreg(pmxevtyper_el0);
>> +}
>> +
>> +/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> +static inline void write_sel_evtyper(int sel, unsigned long val)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       write_sysreg(val, pmxevtyper_el0);
>> +       isb();
>> +}
>> +
>> +static inline void enable_counter(int idx)
>> +{
>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>> +
>> +       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>> +       isb();
>> +}
>> +
>> +static inline void disable_counter(int idx)
>> +{
>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>> +
>> +       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>> +       isb();
>> +}
>> +
> As mentioned in [1], the current implementation of disable_counter()
> is buggy and would end up disabling all the counters.
> However if you intend to keep it (even though it would remain unused),
> may be change the definition something to:
> 
> static inline void disable_counter(int idx)
> {
>      write_sysreg(BIT(idx), pmcntenclr_el0);
>      isb();
> }
> 

Ok. I will integrate another patch into my seris to fix this problem.

Thanks,
Shaoqin

> Thank you.
> Raghavendra
> 
> [1]: https://lore.kernel.org/all/20231122221526.2750966-1-rananta@google.com/
> 
>> +static inline void pmu_disable_reset(void)
>> +{
>> +       uint64_t pmcr = read_sysreg(pmcr_el0);
>> +
>> +       /* Reset all counters, disabling them */
>> +       pmcr &= ~ARMV8_PMU_PMCR_E;
>> +       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
>> +       isb();
>> +}
>> +
>> +#define RETURN_READ_PMEVCNTRN(n) \
>> +       return read_sysreg(pmevcntr##n##_el0)
>> +static inline unsigned long read_pmevcntrn(int n)
>> +{
>> +       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>> +       return 0;
>> +}
>> +
>> +#define WRITE_PMEVCNTRN(n) \
>> +       write_sysreg(val, pmevcntr##n##_el0)
>> +static inline void write_pmevcntrn(int n, unsigned long val)
>> +{
>> +       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>> +       isb();
>> +}
>> +
>> +#define READ_PMEVTYPERN(n) \
>> +       return read_sysreg(pmevtyper##n##_el0)
>> +static inline unsigned long read_pmevtypern(int n)
>> +{
>> +       PMEVN_SWITCH(n, READ_PMEVTYPERN);
>> +       return 0;
>> +}
>> +
>> +#define WRITE_PMEVTYPERN(n) \
>> +       write_sysreg(val, pmevtyper##n##_el0)
>> +static inline void write_pmevtypern(int n, unsigned long val)
>> +{
>> +       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>> +       isb();
>> +}
>> --
>> 2.40.1
>>
>>
> 

-- 
Shaoqin

