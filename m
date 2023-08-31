Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795778E4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjHaC5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHaC5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:57:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987DCC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:57:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rbm6345Xgz4f3kp8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:56:59 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qh6AfBkRm_5Bw--.63649S3;
        Thu, 31 Aug 2023 10:57:00 +0800 (CST)
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
Date:   Thu, 31 Aug 2023 10:56:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH1qh6AfBkRm_5Bw--.63649S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UCF4UAFW5Gw4kGrykZrb_yoW5ZF1Upr
        yrCa1FkryUtFn7K3WfA39xWrWrAw48ta429F9avryrAF9rtFn8Xr1UWw129rWjkr98GFW2
        yFWIgFZIka4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 20:16, Baoquan He wrote:
> Now parse_crashkernel() is a real entry point for all kinds of
> crahskernel parsing on any architecture.
> 
> And wrap the crahskernel=,high|low handling inside
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  6 ++++++
>  kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 2e76289699ff..85260bf4a734 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -77,6 +77,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
>  
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> +#endif
> +#endif
> +
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index f6a5c219e2e1..355b0ab5189c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -276,6 +276,9 @@ static int __init __parse_crashkernel(char *cmdline,
>  /*
>   * That function is the entry point for command line parsing and should be
>   * called from the arch-specific code.
> + *
> + * If crashkernel=,high|low is supported on architecture, non-NULL values
> + * should be passed to parameters 'low_size' and 'high'.
>   */
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
> @@ -291,7 +294,30 @@ int __init parse_crashkernel(char *cmdline,
>  				crash_base, NULL);
>  	if (!high)
>  		return ret;
> -
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	else if (ret == -ENOENT) {
> +		ret = __parse_crashkernel(cmdline, 0, crash_size,
> +				crash_base, suffix_tbl[SUFFIX_HIGH]);
> +		if (ret || !*crash_size)
> +			return -1;

Change -1 to -EINVAL?

> +
> +		/*
> +		 * crashkernel=Y,low can be specified or not, but invalid value
> +		 * is not allowed.
> +		 */
> +		ret = __parse_crashkernel(cmdline, 0, low_size,
> +				crash_base, suffix_tbl[SUFFIX_LOW]);
> +		if (ret == -ENOENT)
> +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
> +			return -1;

return ret;

> +
> +		*high = true;
> +	} else if (ret || !*crash_size) {

This check can be moved outside of #ifdef. Because even '!high', it's completely
applicable. The overall adjustment is as follows:

-  	if (!high)
-  		return ret;

#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
	if (high && ret == -ENOENT) {
		... ...
		if (ret || !*crash_size)	//parse HIGH
		... ...
	}

	//At this point, *crash_size is not 0 and ret is 0.
	//We can also delete if (!*crash_size) above because it will be checked later.
#endif

	if (!*crash_size)
		ret = -EINVAL;

	return ret;

-  	return 0;

> +		/* The specified value is invalid */
> +		return -1;
> +	}
> +#endif
>  	return 0;
>  }
>  
> 

-- 
Regards,
  Zhen Lei

