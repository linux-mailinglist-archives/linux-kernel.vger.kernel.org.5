Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994417F2CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKUMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjKUMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:15:43 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57DAF13D;
        Tue, 21 Nov 2023 04:15:38 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.183])
        by gateway (Coremail) with SMTP id _____8Dxl+hon1xlVYw7AA--.16278S3;
        Tue, 21 Nov 2023 20:15:36 +0800 (CST)
Received: from [10.20.42.183] (unknown [10.20.42.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxeuRln1xlzWNIAA--.30119S3;
        Tue, 21 Nov 2023 20:15:36 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: KVM: Add lasx support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20231115091921.85516-1-zhaotianrui@loongson.cn>
 <20231115091921.85516-3-zhaotianrui@loongson.cn>
 <f003f38d-37fd-43ed-ada6-fb2d5b282e91@xen0n.name>
 <6d9395b5-e8f1-3990-adb0-a52d03411fc6@loongson.cn>
 <CAAhV-H6Kq1gDvmAS9fnG4Lc4ot0H4tZftZvzSdd39fNjozo4bQ@mail.gmail.com>
From:   zhaotianrui <zhaotianrui@loongson.cn>
Message-ID: <e907c7e2-ff54-e420-ae63-0d2c8481994f@loongson.cn>
Date:   Tue, 21 Nov 2023 20:17:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6Kq1gDvmAS9fnG4Lc4ot0H4tZftZvzSdd39fNjozo4bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxeuRln1xlzWNIAA--.30119S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry7JrWxZry7Xw47uFWkKrX_yoWrWry8pa
        srCFs8Ga18GFn3G3sFvw1qv3sIvrs7Kr1Sga47t34ayFn0gFyDJr1kGryDuF98tw18KF1S
        vF15Kr13WF15A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4cdbUU
        UUU
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/21 下午7:55, Huacai Chen 写道:
> On Tue, Nov 21, 2023 at 5:59 PM zhaotianrui <zhaotianrui@loongson.cn> wrote:
>>
>> 在 2023/11/16 下午3:19, WANG Xuerui 写道:
>>> On 11/15/23 17:19, Tianrui Zhao wrote:
>>>> This patch adds LASX support for LoongArch KVM. The LASX means
>>>> LoongArch 256-bits vector instruction.
>>>> There will be LASX exception in KVM when guest use the LASX
>>>> instruction. KVM will enable LASX and restore the vector
>>>> registers for guest then return to guest to continue running.
>>>>
>>>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/kvm_host.h |  6 ++++
>>>>    arch/loongarch/include/asm/kvm_vcpu.h | 10 +++++++
>>>>    arch/loongarch/kernel/fpu.S           |  1 +
>>>>    arch/loongarch/kvm/exit.c             | 18 +++++++++++
>>>>    arch/loongarch/kvm/switch.S           | 16 ++++++++++
>>>>    arch/loongarch/kvm/trace.h            |  4 ++-
>>>>    arch/loongarch/kvm/vcpu.c             | 43 ++++++++++++++++++++++++++-
>>>>    7 files changed, 96 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/kvm_host.h
>>>> b/arch/loongarch/include/asm/kvm_host.h
>>>> index 6c65c25169..4c05b5eca0 100644
>>>> --- a/arch/loongarch/include/asm/kvm_host.h
>>>> +++ b/arch/loongarch/include/asm/kvm_host.h
>>>> @@ -95,6 +95,7 @@ enum emulation_result {
>>>>    #define KVM_LARCH_SWCSR_LATEST    (0x1 << 1)
>>>>    #define KVM_LARCH_HWCSR_USABLE    (0x1 << 2)
>>>>    #define KVM_LARCH_LSX        (0x1 << 3)
>>>> +#define KVM_LARCH_LASX        (0x1 << 4)
>>>>      struct kvm_vcpu_arch {
>>>>        /*
>>>> @@ -181,6 +182,11 @@ static inline bool kvm_guest_has_lsx(struct
>>>> kvm_vcpu_arch *arch)
>>>>        return arch->cpucfg[2] & CPUCFG2_LSX;
>>>>    }
>>>>    +static inline bool kvm_guest_has_lasx(struct kvm_vcpu_arch *arch)
>>>> +{
>>>> +    return arch->cpucfg[2] & CPUCFG2_LASX;
>>>> +}
>>>> +
>>>>    /* Debug: dump vcpu state */
>>>>    int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
>>>>    diff --git a/arch/loongarch/include/asm/kvm_vcpu.h
>>>> b/arch/loongarch/include/asm/kvm_vcpu.h
>>>> index c629771e12..4f87f16018 100644
>>>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
>>>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
>>>> @@ -67,6 +67,16 @@ static inline void kvm_restore_lsx(struct
>>>> loongarch_fpu *fpu) { }
>>>>    static inline void kvm_restore_lsx_upper(struct loongarch_fpu *fpu)
>>>> { }
>>>>    #endif
>>>>    +#ifdef CONFIG_CPU_HAS_LASX
>>>> +void kvm_own_lasx(struct kvm_vcpu *vcpu);
>>>> +void kvm_save_lasx(struct loongarch_fpu *fpu);
>>>> +void kvm_restore_lasx(struct loongarch_fpu *fpu);
>>>> +#else
>>>> +static inline void kvm_own_lasx(struct kvm_vcpu *vcpu) { }
>>>> +static inline void kvm_save_lasx(struct loongarch_fpu *fpu) { }
>>>> +static inline void kvm_restore_lasx(struct loongarch_fpu *fpu) { }
>>>> +#endif
>>>> +
>>>>    void kvm_acquire_timer(struct kvm_vcpu *vcpu);
>>>>    void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
>>>>    void kvm_reset_timer(struct kvm_vcpu *vcpu);
>>>> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
>>>> index d53ab10f46..f4524fe866 100644
>>>> --- a/arch/loongarch/kernel/fpu.S
>>>> +++ b/arch/loongarch/kernel/fpu.S
>>>> @@ -384,6 +384,7 @@ SYM_FUNC_START(_restore_lasx_upper)
>>>>        lasx_restore_all_upper a0 t0 t1
>>>>        jr    ra
>>>>    SYM_FUNC_END(_restore_lasx_upper)
>>>> +EXPORT_SYMBOL(_restore_lasx_upper)
>>> Why the added export? It doesn't seem necessary, given the previous
>>> patch doesn't have a similar export added for _restore_lsx_upper. (Or
>>> if it's truly needed it should probably become EXPORT_SYMBOL_GPL.)
>> It is needed to be exported, as it is called by kvm_own_lasx. However
>> the "_restore_lsx_upper" is not used in kvm.
> To keep consistency it is better to export both.
>
> Huacai
Thanks, I will export both functions.

Tianrui Zhao
>
>> Thanks
>> Tianrui Zhao
>>

