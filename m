Return-Path: <linux-kernel+bounces-16335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E24823D02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE4F1F224C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C14200A6;
	Thu,  4 Jan 2024 07:54:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57C1F94D;
	Thu,  4 Jan 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxeeoSZJZlU+EBAA--.3001S3;
	Thu, 04 Jan 2024 15:53:54 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvocPZJZlRTMBAA--.3040S3;
	Thu, 04 Jan 2024 15:53:53 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongson-eiointc: Refine irq affinity setting
 during resume
From: maobibo <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jianmin Lv <lvjianmin@loongson.cn>
References: <20231219095158.285408-1-maobibo@loongson.cn>
Message-ID: <a6661b44-2fab-4c7f-5997-e01a6f64c737@loongson.cn>
Date: Thu, 4 Jan 2024 15:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219095158.285408-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxvocPZJZlRTMBAA--.3040S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyrCr4xtF18WFW5ur1ruFX_yoW5Cr48pF
	W5A3Z0yrW5JFyUXryakr4DXa4avwn5XrW7KFsxWay7ZFs8JF1DKF4FkF1jvF40k3y7JFsI
	vF4Yqr18C3WYk3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	SoJUUUUU=

+ irqchip maintainer Thomas.

Jianmin,

Could you give some feedback about this patch since you are author about 
this patch? By searching code of all hw irqchip drivers, there is no 
affinity restoring during s3/s4.

Regards
Bibo Mao

On 2023/12/19 下午5:51, Bibo Mao wrote:
> During suspend and resume, other CPUs are removed and IRQs are migrated
> to CPU0. So it is not necessary to restore irq affinity for eiointc.
> 
> Also there is some optimization for function eiointc_irq_dispatch,
> in genral there are 256 IRQs supported for eiointc. When irq happens,
> eiointc irq handler reads the bitmap and find pending irqs. There are
> 4 times of  consecutive iocsr_read64 operations for the total 256 bits,
> indeed in most scenario pending value is zero in 3 times, and not zero
> in one time. Here zero checking is added to avoid some useless
> operations sush as clearing hw ISR.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   drivers/irqchip/irq-loongson-eiointc.c | 29 +++++++++++---------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index 1623cd779175..b01be85b8ebc 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -198,6 +198,17 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
>   
>   	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
>   		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
> +
> +		/*
> +		 * Get pending eiointc irq from bitmap status, there are 4 times
> +		 * consecutive iocsr_read64 operations for 256 IRQs.
> +		 *
> +		 * In most scenario value of pending is 0 if no multiple IRQs
> +		 * happen at the same time
> +		 */
> +		if (!pending)
> +			continue;
> +
>   		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
>   		while (pending) {
>   			int bit = __ffs(pending);
> @@ -241,7 +252,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   	int ret;
>   	unsigned int i, type;
>   	unsigned long hwirq = 0;
> -	struct eiointc *priv = domain->host_data;
> +	struct eiointc_priv *priv = domain->host_data;
>   
>   	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>   	if (ret)
> @@ -304,23 +315,7 @@ static int eiointc_suspend(void)
>   
>   static void eiointc_resume(void)
>   {
> -	int i, j;
> -	struct irq_desc *desc;
> -	struct irq_data *irq_data;
> -
>   	eiointc_router_init(0);
> -
> -	for (i = 0; i < nr_pics; i++) {
> -		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
> -			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
> -			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
> -				raw_spin_lock(&desc->lock);
> -				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
> -				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
> -				raw_spin_unlock(&desc->lock);
> -			}
> -		}
> -	}
>   }
>   
>   static struct syscore_ops eiointc_syscore_ops = {
> 


