Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4077EF0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjKQKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjKQKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:38:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24503D4F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:38:41 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWtfM6tL0zvQhF;
        Fri, 17 Nov 2023 18:38:19 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 17 Nov 2023 18:38:38 +0800
Message-ID: <90fb0d11-a621-f1f1-a41e-3b7a644fea29@huawei.com>
Date:   Fri, 17 Nov 2023 18:38:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: Fix 32-bit compatible userspace write size
 overflow error
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>
References: <20231116074706.3448008-1-ruanjinjie@huawei.com>
 <ZVYuM8SzVmFflibQ@FVFF77S0Q05N>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZVYuM8SzVmFflibQ@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/16 22:58, Mark Rutland wrote:
> On Thu, Nov 16, 2023 at 03:47:05PM +0800, Jinjie Ruan wrote:
>> For 32-bit compatible userspace program, write with size = -1 return not
>> -1 but unexpected other values, which is due to the __access_ok() check is
>> not right.
> 
> Can you please explain why you believe that is unexpected?
> 
> e.g. Is that documented somewhere? Do you see a real application depending on
> that somewhow?

In my opinion, access_ok() must ensure that the access address is not
out of bounds，which must be a valid address range for 32-bit userspace
program.

> 
>> The specified "addr + size" is greater than 32-bit limit and
>> should return -EFAULT, but TASK_SIZE_MAX still defined as UL(1) << VA_BITS
>> in U32 mode, which is much greater than "addr + size" and cannot catch the
>> overflow error.
> 
> The check against TASK_SIZE_MAX is not intended to catch 32-bit addr + size
> overflow; it's intended to check that uaccesses never touch kernel memory. The
> kernel's uaccess routines use 64-bit (or 65-bit) arithmetic, so these won't
> wrap and access memory at the start of the user address space.

Thank you! My understanding of Task_SIZE_MAX is wrong, so catch 32-bit
addr + size overflow is designed by MAX_RW_COUNT?

> 
>> Fix above error by checking 32-bit limit if it is 32-bit compatible
>> userspace program.
>>
>> How to reproduce:
>>
>> The test program is as below:
>>
>> cat test.c
>> 	#include <unistd.h>
>> 	#include <fcntl.h>
>> 	#include <stdio.h>
>> 	#include <stdint.h>
>> 	#include <stdlib.h>
>> 	#include <assert.h>
>>
>> 	#define pinfo(fmt, args...) \
>> 	    fprintf(stderr, "[INFO][%s][%d][%s]:"fmt, \
>> 	    __FILE__,__LINE__,__func__,##args)
>>
>> 	#undef SIZE_MAX
>> 	#define SIZE_MAX -1
>>
>> 	int main()
>> 	{
>> 	    char wbuf[3] = { 'x', 'y', 'z' };
>> 	    char *path = "write.tmp";
>> 	    int ret;
>>
>> 	    int fd = open(path, O_RDWR | O_CREAT);
>> 	    if (fd<0)
>> 	    {
>> 	        pinfo("fd=%d\n", fd);
>> 	        exit(-1);
>> 	    }
>>
>> 	    assert(write(fd, wbuf, 3) == 3);
>>
>> 	    ret = write (fd, wbuf, SIZE_MAX);
>> 	    pinfo("ret=%d\n", ret);
>> 	    pinfo("size_max=%d\n",SIZE_MAX);
>> 	    assert(ret==-1);
>> 	    close(fd);
>> 	    pinfo("INFO: end\n");
>>
>> 	    return 0;
>> 	}
>>
>> aarch64-linux-gnu-gcc --static test.c -o test
>> arm-linux-gnueabi-gcc --static test.c -o test32
>>
>> Before applying this patch, userspace 32-bit program return 1112 if the
>> write size = -1 as below:
>> 	/root # ./test
>> 	[INFO][test.c][32][main]:ret=-1
>> 	[INFO][test.c][33][main]:size_max=-1
>> 	[INFO][test.c][36][main]:INFO: end
>> 	/root # ./test32
>> 	[INFO][test.c][32][main]:ret=1112
>> 	[INFO][test.c][33][main]:size_max=-1
>> 	test32: test.c:34: main: Assertion `ret==-1' failed.
>> 	Aborted
>>
>> After applying this patch, userspace 32-bit program return -1 if the write
>> size = -1 as expected as below:
>> 	/root # ./test
>> 	[INFO][test.c][32][main]:ret=-1
>> 	[INFO][test.c][33][main]:size_max=-1
>> 	[INFO][test.c][36][main]:INFO: end
>> 	/root # ./test32
>> 	[INFO][test.c][32][main]:ret=-1
>> 	[INFO][test.c][33][main]:size_max=-1
>> 	[INFO][test.c][36][main]:INFO: end
>>
>> Fixes: 967747bbc084 ("uaccess: remove CONFIG_SET_FS")
> 
> As above, this is *not* a fix. This is the intended behaviour.
> 
> AFAICT, the behaviour didn't change on arm64 in that commit either; we were
> unconditionally using TASK_SIZE_MAX many commits earlier, e.g. in commit:
> 
>   3d2403fd10a1dbb3 ("arm64: uaccess: remove set_fs()")
> 
> ... so the fixes tag is bogus on both fronts.

Thank you! I'll recheck it.

> 
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/processor.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index e5bc54522e71..6a087d58a90a 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -52,7 +52,12 @@
>>  
>>  #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS_MIN)
>>  #define TASK_SIZE_64		(UL(1) << vabits_actual)
>> +#ifdef CONFIG_COMPAT
>> +#define TASK_SIZE_MAX		(test_thread_flag(TIF_32BIT) ? \
>> +				UL(0x100000000) : (UL(1) << VA_BITS))
>> +#else
>>  #define TASK_SIZE_MAX		(UL(1) << VA_BITS)
>> +#endif
> 
> This isn't even the same as on 32-bit. On 32-bit arm, the task size split can
> be 1G/3G, 2G/2G, or 3G/1G depending on configuration, and 4G/4G isn't currently
> an option.
> 
> I don't believe that userspace is actually dependent upon this for functional
> reasons, and I don't believe that there's a security issue here. Even if
> access_ok() allows addr+size to go past 4G, the kernel address calculations are
> 64-bit and won't wrap.

If access_ok() is used only to distinguish between user space and kernel
space addresses, it is not the correct method to modify TASK_SIZE_MAX.

> 
> For all the reasons above, I don't beleive this is correct nor do I believe
> this is necesssary. Given that, NAK to this patch.

Thank you! I'll delve into the semantics of the "write" system call.

> 
> Thanks,
> Mark.
> 
>>  
>>  #ifdef CONFIG_COMPAT
>>  #if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
>> -- 
>> 2.34.1
>>
> 
