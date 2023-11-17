Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6327EEAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbjKQBrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345632AbjKQBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:47:14 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363E1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:47:09 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SWfm544TNzMn4N;
        Fri, 17 Nov 2023 09:42:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 17 Nov 2023 09:47:06 +0800
Message-ID: <f55f49d7-1003-0e98-12a2-422bf4d9318e@huawei.com>
Date:   Fri, 17 Nov 2023 09:47:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: Fix 32-bit compatible userspace write size
 overflow error
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231116074706.3448008-1-ruanjinjie@huawei.com>
 <bf176e04-88fe-4333-8500-1335ad7a1bdf@app.fastmail.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <bf176e04-88fe-4333-8500-1335ad7a1bdf@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/16 21:39, Arnd Bergmann wrote:
> On Thu, Nov 16, 2023, at 02:47, Jinjie Ruan wrote:
>> For 32-bit compatible userspace program, write with size = -1 return not
>> -1 but unexpected other values, which is due to the __access_ok() check is
>> not right. The specified "addr + size" is greater than 32-bit limit and
>> should return -EFAULT, but TASK_SIZE_MAX still defined as UL(1) << VA_BITS
>> in U32 mode, which is much greater than "addr + size" and cannot catch the
>> overflow error.
> 
> Thank you for the detailed analysis of the change in behavior that
> resulted from my patch. As far as I can tell, this is an intentional
> change that should have been documented as part of the patch
> submission.
> 
>> 	    assert(write(fd, wbuf, 3) == 3);
>>
>> 	    ret = write (fd, wbuf, SIZE_MAX);
>> 	    pinfo("ret=%d\n", ret);
>> 	    pinfo("size_max=%d\n",SIZE_MAX);
>> 	    assert(ret==-1);
> 
> I think it is wrong to have an assert() here since the
> documentation for write() does not state what happens
> when the beginning of the buffer is addressable but the
> end is not. We were handling this inconsistently between
> architectures before my patch, which ensured we do the
> same thing on all compat architectures now.
> 
> You can argue that this behavior is inconsistent with
> native 32-bit mode, but at the time we decided that this
> was not an important distinction.
> 
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
> 
> Here, the write() successfully gets 1112 bytes of data,
> which matches what you get for any other large size that
> does not overflow user address space in the kernel.

With a 64-bit kernel running a 32-bit user-mode program, the most
confusing behavior of writing a size of -1 is as follows when the
program is executed multiple times continuously, the return value is
different each time(4280、2776、2216、4536、856、4616、4632 or 3288 etc.)
although the same program is run each time:

/root # ./test32
[INFO][test.c][32][main]:ret=4280
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=2776
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=2216
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=4536
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=856
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=4616
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=4632
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted

/root # ./test32
[INFO][test.c][32][main]:ret=3288
[INFO][test.c][33][main]:size_max=-1
test32: test.c:34: main: Assertion `ret==-1' failed.
Aborted


> 
>> Fixes: 967747bbc084 ("uaccess: remove CONFIG_SET_FS")
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
> This adds back the cost for every user access that I was
> trying to save, and it makes arm64 behave differently from
> the other architectures.

Indeed, this adds to the cost of checking.

> 
> As far as I can tell, the current behavior was originally
> introduced on x86 with commit 9063c61fd5cb ("x86, 64-bit:
> Clean up user address masking").

Thank you!



> 
>      Arnd
