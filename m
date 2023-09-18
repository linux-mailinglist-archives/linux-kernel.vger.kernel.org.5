Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76417A49ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbjIRMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbjIRMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:35 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EA9F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:41:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rq4D03xdtz4f3lDp
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:41:20 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd1wRQhlbw0hAw--.6340S3;
        Mon, 18 Sep 2023 20:41:22 +0800 (CST)
Subject: Re: [PATCH v3 3/9] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-4-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <69917722-0788-30f4-b28e-cb0a41881f35@huaweicloud.com>
Date:   Mon, 18 Sep 2023 20:41:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230914033142.676708-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3jd1wRQhlbw0hAw--.6340S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UCF4UCr1UKFy3Xw15XFb_yoW5Aw1Dpr
        yrCa15GrW7JFn7Kw1fAr9xurWrAw40ya429F9akryrAF9rtFnxKr1UWw1UWr1j9r98CFW2
        yFWFvFZxKa4jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/14 11:31, Baoquan He wrote:
> Now parse_crashkernel() is a real entry point for all kinds of
> crahskernel parsing on any architecture.
> 
> And wrap the crahskernel=,high|low handling inside
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  6 ++++++
>  kernel/crash_core.c        | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 6156355ef831..d8050a7eab01 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -79,6 +79,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
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
> index cca1d76e8255..dce2f5874fea 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -283,6 +283,9 @@ static int __init __parse_crashkernel(char *cmdline,
>  /*
>   * That function is the entry point for command line parsing and should be
>   * called from the arch-specific code.
> + *
> + * If crashkernel=,high|low is supported on architecture, non-NULL values
> + * should be passed to parameters 'low_size' and 'high'.
>   */
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
> @@ -296,10 +299,37 @@ int __init parse_crashkernel(char *cmdline,
>  	/* crashkernel=X[@offset] */
>  	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>  				crash_base, NULL);
> -	if (!high)
> -		return ret;
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	/*
> +	 * If non-NULL 'high' passed in and no normal crashkernel
> +	 * setting detected, try parsing crashkernel=,high|low.
> +	 */
> +	if (high && ret == -ENOENT) {
> +		ret = __parse_crashkernel(cmdline, 0, crash_size,
> +				crash_base, suffix_tbl[SUFFIX_HIGH]);
> +		if (ret || !*crash_size)
> +			return -EINVAL;
>  
> -	return 0;
> +		/*
> +		 * crashkernel=Y,low can be specified or not, but invalid value
> +		 * is not allowed.
> +		 */
> +		ret = __parse_crashkernel(cmdline, 0, low_size,
> +				crash_base, suffix_tbl[SUFFIX_LOW]);
> +		if (ret == -ENOENT) {
> +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +			ret = 0;
> +		} else if (ret) {
> +			return ret;
> +		}
> +
> +		*high = true;
> +	}
> +#endif
> +	if (!*crash_size)
> +		ret = -EINVAL;
> +
> +	return ret;
>  }
>  
>  int __init parse_crashkernel_high(char *cmdline,
> 

-- 
Regards,
  Zhen Lei

