Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C475621F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGQL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGQL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:56:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D43A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:56:45 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4L9z2JYTzVjfq;
        Mon, 17 Jul 2023 19:55:19 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 19:56:39 +0800
Message-ID: <23d94414-b819-eaef-6fac-638bf713d341@huawei.com>
Date:   Mon, 17 Jul 2023 19:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: enable dead code elimination
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
 <801e30a093e41c3eebd675f0d224f8d7@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <801e30a093e41c3eebd675f0d224f8d7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/17 17:42, Marc Zyngier wrote:
> On 2023-07-17 09:07, Kefeng Wang wrote:
>> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing the
>> user to enable dead code elimination. In order for this to work, ensure
>> that we keep the necessary tables by annotating them with KEEP, also it
>> requires further changes to linker script to KEEP some tables and 
>> wildcard
>> compiler generated sections into the right place.
>>
>> The following comparison is based 6.5-rc2 with defconfig,
>>
>> $ ./scripts/bloat-o-meter vmlinux-base vmlinux-new
>> add/remove: 3/1106 grow/shrink: 4102/6964 up/down: 35704/-99980 (-64276)
>> Function                                     old     new   delta
>> ...
>> Total: Before=17888959, After=17824683, chg -0.36%
>>
>> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-44 (-44)
>> Data                                         old     new   delta
>> ...
>> Total: Before=4820808, After=4820764, chg -0.00%
>>
>> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1096 (-1096)
>> RO Data                                      old     new   delta
>> ...
>> Total: Before=5179123, After=5178027, chg -0.02%
>>
>> $ size vmlinux-base vmlinux
>>    text       data         bss      dec       hex    filename
>> 25433734  15385766  630656  41450156  2787aac    vmlinux-base
>> 24756738  15360870  629888  40747496  26dc1e8    vmlinux-new
>>
>> Memory available after booting, saving 704k on qemu,
>> base: 8084532K/8388608K
>> new:  8085236K/8388608K
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> I took this patch for a spin in my tree, and ended up with:
> 
>    CC      .vmlinux.export.o
>    UPD     include/generated/utsversion.h
>    CC      init/version-timestamp.o
>    LD      .tmp_vmlinux.kallsyms1
> ld: init/main.o(__patchable_function_entries): error: need linked-to 
> section for --gc-sections
> make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
> make[1]: *** [/home/maz/hot-poop/arm-platforms/Makefile:1238: vmlinux] 
> Error 2
> make: *** [Makefile:234: __sub-make] Error 2

I don't find this error with CONFIG_FTRACE_MCOUNT_RECORD or 
allyesconfig, does it need special config or gcc version?
> 
> so it's probably not ready for prime time.
> 
>          M.
