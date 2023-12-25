Return-Path: <linux-kernel+bounces-10969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88881DF67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AF3281B60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF54443E;
	Mon, 25 Dec 2023 09:13:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F90DDB9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8BxbOnIR4llhWoEAA--.21828S3;
	Mon, 25 Dec 2023 17:13:44 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx6r3ER4llOJAJAA--.9412S3;
	Mon, 25 Dec 2023 17:13:43 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Let cores_io_master cover the largest NR_CPUS
To: loongson-kernel@lists.loongnix.cn, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
 Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20231225070002.1350705-1-chenhuacai@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
Date: Mon, 25 Dec 2023 17:13:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231225070002.1350705-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dx6r3ER4llOJAJAA--.9412S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW3Cw18GFW5GF1kZrWrJFc_yoW5Jr47pr
	ZrZFykWrZ5Wrn5JFWUt3s8ur4UAwnxGa12ga1293y8CFy7Xw1jqF10k3srXFnFya1rKFyF
	qF9Y9an2ga1rJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2023/12/25 下午3:00, Huacai Chen wrote:
> Now loongson_system_configuration::cores_io_master only covers 64 cpus,
> if NR_CPUS > 64 there will be memory corruption. So let cores_io_master
> cover the largest NR_CPUS (256).
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/bootinfo.h | 4 ++--
>   arch/loongarch/kernel/acpi.c          | 2 +-
>   arch/loongarch/kernel/smp.c           | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> index c60796869b2b..32fd0319594a 100644
> --- a/arch/loongarch/include/asm/bootinfo.h
> +++ b/arch/loongarch/include/asm/bootinfo.h
> @@ -30,7 +30,7 @@ struct loongson_system_configuration {
>   	int boot_cpu_id;
>   	int cores_per_node;
>   	int cores_per_package;
> -	unsigned long cores_io_master;
> +	unsigned long cores_io_master[4];
Can the hardcoded 4 be defined something like this?
    DIV_ROUND_UP(CONFIG_NR_CPUS, sizeof(long))

the others LGTM.

Regards
Bibo Mao
>   	unsigned long suspend_addr;
>   	const char *cpuname;
>   };
> @@ -42,7 +42,7 @@ extern struct loongson_system_configuration loongson_sysconf;
>   
>   static inline bool io_master(int cpu)
>   {
> -	return test_bit(cpu, &loongson_sysconf.cores_io_master);
> +	return test_bit(cpu, loongson_sysconf.cores_io_master);
>   }
>   
>   #endif /* _ASM_BOOTINFO_H */
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 8e00a754e548..b6b097bbf866 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -119,7 +119,7 @@ acpi_parse_eio_master(union acpi_subtable_headers *header, const unsigned long e
>   		return -EINVAL;
>   
>   	core = eiointc->node * CORES_PER_EIO_NODE;
> -	set_bit(core, &(loongson_sysconf.cores_io_master));
> +	set_bit(core, loongson_sysconf.cores_io_master);
>   
>   	return 0;
>   }
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 9e33b5e36122..a16e3dbe9f09 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -208,7 +208,7 @@ static void __init fdt_smp_setup(void)
>   	}
>   
>   	loongson_sysconf.nr_cpus = num_processors;
> -	set_bit(0, &(loongson_sysconf.cores_io_master));
> +	set_bit(0, loongson_sysconf.cores_io_master);
>   #endif
>   }
>   
> 


