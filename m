Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432B8802E02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjLDIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjLDIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:46:22 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07FFB100;
        Mon,  4 Dec 2023 00:46:26 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.183])
        by gateway (Coremail) with SMTP id _____8Dx_+vhkW1lzLM+AA--.58220S3;
        Mon, 04 Dec 2023 16:46:25 +0800 (CST)
Received: from [10.20.42.183] (unknown [10.20.42.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd7fkW1llRhUAA--.57231S3;
        Mon, 04 Dec 2023 16:46:24 +0800 (CST)
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Allow to access HW timer CSR
 registers always
To:     Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231116023036.2324371-1-maobibo@loongson.cn>
 <20231116023036.2324371-3-maobibo@loongson.cn>
From:   zhaotianrui <zhaotianrui@loongson.cn>
Message-ID: <4b729d67-dd56-6ba2-652c-8d52c3429e35@loongson.cn>
Date:   Mon, 4 Dec 2023 16:48:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231116023036.2324371-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxjd7fkW1llRhUAA--.57231S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur17tryxJr4rKF17Cr4xZrc_yoW5Gw1kpr
        ZakFy7tr48tryqgF9rJrsxuF15WrWxKa4xWFW7AFW2yrnrZw15tFyxG3s7JFW3X34fXF4S
        vryrCwnIvF4DW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wN
        VDUUUUU==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Tianrui Zhao <zhaotianrui@loongson.cn>

ÔÚ 2023/11/16 ÉÏÎç10:30, Bibo Mao Ð´µÀ:
> Currently HW timer CSR registers are allowed to access before entering to
> vm and disabled if switch to SW timer in host mode, instead it is not
> necessary to do so. HW timer CSR registers can be accessed always, it
> is nothing to do with whether it is in vm mode or host mode. This patch
> removes the limitation.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/kvm/main.c  |  1 -
>   arch/loongarch/kvm/timer.c | 27 ++++++---------------------
>   2 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 1c1d5199500e..86a2f2d0cb27 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -287,7 +287,6 @@ int kvm_arch_hardware_enable(void)
>   	if (env & CSR_GCFG_MATC_ROOT)
>   		gcfg |= CSR_GCFG_MATC_ROOT;
>   
> -	gcfg |= CSR_GCFG_TIT;
>   	write_csr_gcfg(gcfg);
>   
>   	kvm_flush_tlb_all();
> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
> index 437e960d8fdb..e37c0ebffabd 100644
> --- a/arch/loongarch/kvm/timer.c
> +++ b/arch/loongarch/kvm/timer.c
> @@ -70,15 +70,6 @@ void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long timer_hz)
>    */
>   void kvm_acquire_timer(struct kvm_vcpu *vcpu)
>   {
> -	unsigned long cfg;
> -
> -	cfg = read_csr_gcfg();
> -	if (!(cfg & CSR_GCFG_TIT))
> -		return;
> -
> -	/* Enable guest access to hard timer */
> -	write_csr_gcfg(cfg & ~CSR_GCFG_TIT);
> -
>   	/*
>   	 * Freeze the soft-timer and sync the guest stable timer with it. We do
>   	 * this with interrupts disabled to avoid latency.
> @@ -175,21 +166,15 @@ static void _kvm_save_timer(struct kvm_vcpu *vcpu)
>    */
>   void kvm_save_timer(struct kvm_vcpu *vcpu)
>   {
> -	unsigned long cfg;
>   	struct loongarch_csrs *csr = vcpu->arch.csr;
>   
>   	preempt_disable();
> -	cfg = read_csr_gcfg();
> -	if (!(cfg & CSR_GCFG_TIT)) {
> -		/* Disable guest use of hard timer */
> -		write_csr_gcfg(cfg | CSR_GCFG_TIT);
> -
> -		/* Save hard timer state */
> -		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
> -		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
> -		if (kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG) & CSR_TCFG_EN)
> -			_kvm_save_timer(vcpu);
> -	}
> +
> +	/* Save hard timer state */
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
> +	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
> +	if (kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG) & CSR_TCFG_EN)
> +		_kvm_save_timer(vcpu);
>   
>   	/* Save timer-related state to vCPU context */
>   	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);

