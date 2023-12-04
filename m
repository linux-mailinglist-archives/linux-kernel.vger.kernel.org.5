Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D41802A25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjLDCFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjLDCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:05:51 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 584F0A6;
        Sun,  3 Dec 2023 18:05:56 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.173])
        by gateway (Coremail) with SMTP id _____8Cxc_D_M21l9aE+AA--.59169S3;
        Mon, 04 Dec 2023 10:05:52 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxiuT_M21lashTAA--.55524S3;
        Mon, 04 Dec 2023 10:05:51 +0800 (CST)
Subject: Re: [PATCH v5 3/4] KVM: selftests: Add ucall test support for
 LoongArch
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Peter Xu <peterx@redhat.com>, Vipin Sharma <vipinsh@google.com>
References: <20231130111804.2227570-1-zhaotianrui@loongson.cn>
 <20231130111804.2227570-4-zhaotianrui@loongson.cn>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <de23c3f6-556a-1ddb-bd1e-01bf249cfceb@loongson.cn>
Date:   Mon, 4 Dec 2023 10:05:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231130111804.2227570-4-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxiuT_M21lashTAA--.55524S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryfKF45Zr4UXF45Jr45CFX_yoW5Cw4Dpa
        4rA3WrKr4xKF17A3s3Jw1qq3Z3Grs2kF1xZ342qrWF9w42y3WxJr1xKFyjyFyxtr4ktFs5
        ZFn2ganruF1Ut3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUU
        U==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 下午7:18, Tianrui Zhao wrote:
> Add ucall test support for LoongArch. A ucall is a "hypercall to
> userspace".
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>   .../selftests/kvm/include/loongarch/ucall.h   | 28 ++++++++++++++
>   .../selftests/kvm/lib/loongarch/ucall.c       | 38 +++++++++++++++++++
>   2 files changed, 66 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c
> 
> diff --git a/tools/testing/selftests/kvm/include/loongarch/ucall.h b/tools/testing/selftests/kvm/include/loongarch/ucall.h
> new file mode 100644
> index 00000000000..e9033ea6fbf
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/loongarch/ucall.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_UCALL_H
> +#define SELFTEST_KVM_UCALL_H
> +
> +#include "kvm_util_base.h"
> +
> +#define UCALL_EXIT_REASON       KVM_EXIT_MMIO
> +
> +/*
> + * Default base address for application loading is 0x120000000,
> + * DEFAULT_GUEST_TEST_MEM should be larger than app loading address,
> + * so that PER_VCPU_MEM_SIZE can be large enough, and kvm selftests
> + * app size is smaller than 256M in generic
> + */
> +#define DEFAULT_GUEST_TEST_MEM	0x130000000
> +
> +/*
> + * ucall_exit_mmio_addr holds per-VM values (global data is duplicated by each
> + * VM), it must not be accessed from host code.
> + */
> +extern vm_vaddr_t *ucall_exit_mmio_addr;
> +
> +static inline void ucall_arch_do_ucall(vm_vaddr_t uc)
> +{
> +	WRITE_ONCE(*ucall_exit_mmio_addr, uc);
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/kvm/lib/loongarch/ucall.c b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
> new file mode 100644
> index 00000000000..fc6cbb50573
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ucall support. A ucall is a "hypercall to userspace".
> + *
> + */
> +#include "kvm_util.h"
> +
> +/*
> + * ucall_exit_mmio_addr holds per-VM values (global data is duplicated by each
> + * VM), it must not be accessed from host code.
> + */
> +vm_vaddr_t *ucall_exit_mmio_addr;
> +
> +void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> +{
> +	vm_vaddr_t mmio_gva = vm_vaddr_unused_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
> +
> +	virt_map(vm, mmio_gva, mmio_gpa, 1);
> +
> +	vm->ucall_mmio_addr = mmio_gpa;
> +
> +	write_guest_global(vm, ucall_exit_mmio_addr, (vm_vaddr_t *)mmio_gva);
> +}
> +
> +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_run *run = vcpu->run;
> +
> +	if (run->exit_reason == KVM_EXIT_MMIO &&
> +	    run->mmio.phys_addr == vcpu->vm->ucall_mmio_addr) {
> +		TEST_ASSERT(run->mmio.is_write && run->mmio.len == sizeof(uint64_t),
> +			    "Unexpected ucall exit mmio address access");
> +
> +		return (void *)(*((uint64_t *)run->mmio.data));
> +	}
> +
> +	return NULL;
> +}
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

