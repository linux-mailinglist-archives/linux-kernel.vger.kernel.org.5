Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E4752FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjGNDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGNDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:25:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F7D1210A;
        Thu, 13 Jul 2023 20:25:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Cx5_ELwLBkGLQEAA--.13328S3;
        Fri, 14 Jul 2023 11:24:59 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8wKwLBk25UtAA--.21862S3;
        Fri, 14 Jul 2023 11:24:58 +0800 (CST)
Message-ID: <2c2cc78a-bc88-bc23-8fc9-c171f4dd10b5@loongson.cn>
Date:   Fri, 14 Jul 2023 11:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/2] irqchip/loongson-eiointc: Simplify irq routing on
 some platforms
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230713032243.2046205-1-maobibo@loongson.cn>
 <20230713032243.2046205-3-maobibo@loongson.cn>
 <CAAhV-H5wGkRNcwL52pGzAd7S3GnqqkAGxS0BFC-Ezg4F6ycJ-Q@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H5wGkRNcwL52pGzAd7S3GnqqkAGxS0BFC-Ezg4F6ycJ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8wKwLBk25UtAA--.21862S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWxtw47ArW8uw1xWry5Jrc_yoWxJw48pF
        WUGa90qF4UXryUXr9a9w4DZFySvr93XrWDtF1fGayxAFZ09F4kKF1FyrnruF1jk34UGF1j
        yF4Yqry8uF15G3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
        UUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/14 11:01, Huacai Chen 写道:
> Hi, Bibo,
> 
> On Thu, Jul 13, 2023 at 11:23 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Some LoongArch systems have only one eiointc node such as 3A5000/2K2000
>> and qemu virt-machine. If there is only one eiointc node, all cpus can
>> access eiointc registers directly; if there is multiple eiointc nodes, each
>> cpu can only access eiointc belonging to specified node group, so anysend
>> or ipi needs to be used to configure irq routing. IRQ routing is simple on
>> such systems with one node, hacking method like anysend is not necessary.
>>
>> This patch provides simpile IRQ routing method for systems with one eiointc
>> node, and is tested on 3A5000 board and qemu virt-machine.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  drivers/irqchip/irq-loongson-eiointc.c | 80 ++++++++++++++++++++++++--
>>  1 file changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 603d323b8f8b..e6be9d6a18c8 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -127,6 +127,48 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>>         return IRQ_SET_MASK_OK;
>>  }
>>
>> +static int eiointc_single_set_irq_affinity(struct irq_data *d,
>> +                               const struct cpumask *affinity, bool force)
>> +{
>> +       unsigned int cpu;
>> +       unsigned long flags;
>> +       uint32_t vector, regaddr, data, coremap;
>> +       struct cpumask mask;
>> +       struct eiointc_priv *priv = d->domain->host_data;
>> +
>> +       cpumask_and(&mask, affinity, cpu_online_mask);
>> +       cpumask_and(&mask, &mask, &priv->cpuspan_map);
>> +       if (cpumask_empty(&mask))
>> +               return -EINVAL;
>> +
>> +       cpu = cpumask_first(&mask);
>> +       vector = d->hwirq;
>> +       regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
>> +       data = ~BIT(vector & 0x1F);
>> +       coremap = BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
>> +
>> +       /*
>> +        * simplify for platform with only one eiointc node
>> +        * access eiointc registers directly rather than
>> +        * use any_send method here
>> +        */
>> +       raw_spin_lock_irqsave(&affinity_lock, flags);
>> +       iocsr_write32(EIOINTC_ALL_ENABLE & data, regaddr);
>> +       /*
>> +        * get irq route info for continuous 4 vectors
>> +        * and set affinity for specified vector
>> +        */
>> +       data = iocsr_read32(EIOINTC_REG_ROUTE + (vector & ~3));
>> +       data &=  ~(0xff << ((vector & 3) * 8));
>> +       data |= coremap << ((vector & 3) * 8);
>> +       iocsr_write32(data, EIOINTC_REG_ROUTE + (vector & ~3));
>> +       iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
>> +       raw_spin_unlock_irqrestore(&affinity_lock, flags);
>> +
>> +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
>> +       return IRQ_SET_MASK_OK;
>> +}
>> +
>>  static int eiointc_index(int node)
>>  {
>>         int i;
>> @@ -238,22 +280,39 @@ static struct irq_chip eiointc_irq_chip = {
>>         .irq_set_affinity       = eiointc_set_irq_affinity,
>>  };
>>
>> +static struct irq_chip eiointc_irq_chipi_single = {
> What does "chipi" mean? Maybe "chip"?
it is a typo, it should chip.

> 
> And from my point of view, the main goal of this patch is to add
> "virtual eiointc" support which is different from "real eiointc". So I
> think it is better to not touch the "real eiointc" logic, but add a
> variant for "virtual eiointc", and then, the name should be
> "EIOINTC-V", not "EIOINTC-S".
it is not for virt-machine only, it is ok for 3A5000 and embedded boards also.

If it is possible to add special eiointc for virt-machine, irq should be routed
to all vcpus rather than only vcpu 0-3 for virt eiointc model.

Regards
Bibo Mao
Only server h
> 
> Huacai
> 
>> +       .name                   = "EIOINTC-S",
>> +       .irq_ack                = eiointc_ack_irq,
>> +       .irq_mask               = eiointc_mask_irq,
>> +       .irq_unmask             = eiointc_unmask_irq,
>> +#ifdef CONFIG_SMP
>> +       .irq_set_affinity       = eiointc_single_set_irq_affinity,
>> +#endif
>> +};
>> +
>>  static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>                                 unsigned int nr_irqs, void *arg)
>>  {
>>         int ret;
>>         unsigned int i, type;
>>         unsigned long hwirq = 0;
>> -       struct eiointc *priv = domain->host_data;
>> +       struct eiointc_priv *priv = domain->host_data;
>> +       struct irq_chip *chip;
>>
>>         ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>>         if (ret)
>>                 return ret;
>>
>> -       for (i = 0; i < nr_irqs; i++) {
>> -               irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc_irq_chip,
>> +       /*
>> +        * use simple irq routing method on single eiointc node
>> +        */
>> +       if ((nr_pics == 1) && (nodes_weight(priv->node_map) == 1))
>> +               chip = &eiointc_irq_chipi_single;
>> +       else
>> +               chip = &eiointc_irq_chip;
>> +       for (i = 0; i < nr_irqs; i++)
>> +               irq_domain_set_info(domain, virq + i, hwirq + i, chip,
>>                                         priv, handle_edge_irq, NULL, NULL);
>> -       }
>>
>>         return 0;
>>  }
>> @@ -310,6 +369,7 @@ static void eiointc_resume(void)
>>         int i, j;
>>         struct irq_desc *desc;
>>         struct irq_data *irq_data;
>> +       struct irq_chip *chip;
>>
>>         eiointc_router_init(0);
>>
>> @@ -319,7 +379,8 @@ static void eiointc_resume(void)
>>                         if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
>>                                 raw_spin_lock(&desc->lock);
>>                                 irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
>> -                               eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
>> +                               chip = irq_data_get_irq_chip(irq_data);
>> +                               chip->irq_set_affinity(irq_data, irq_data->common->affinity, 0);
>>                                 raw_spin_unlock(&desc->lock);
>>                         }
>>                 }
>> @@ -497,7 +558,14 @@ static int __init eiointc_of_init(struct device_node *of_node,
>>         priv->node = 0;
>>         priv->domain_handle = of_node_to_fwnode(of_node);
>>
>> -       ret = eiointc_init(priv, parent_irq, 0);
>> +       /*
>> +        * 2k0500 and 2k2000 has only one eiointc node
>> +        * set nodemap as 1 for simple irq routing
>> +        *
>> +        * Fixme: what about future embedded boards with more than 4 cpus?
>> +        * nodemap and node need be added in dts like acpi table
>> +        */
>> +       ret = eiointc_init(priv, parent_irq, 1);
>>         if (ret < 0)
>>                 goto out_free_priv;
>>
>> --
>> 2.27.0
>>

