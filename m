Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE32757A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGRLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjGRLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:11:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDD1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4x6w6d5fzVjj9;
        Tue, 18 Jul 2023 19:09:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:11:06 +0800
Message-ID: <921f4500-247a-50d5-c8df-49bdb55b9762@huawei.com>
Date:   Tue, 18 Jul 2023 19:11:06 +0800
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
 <23d94414-b819-eaef-6fac-638bf713d341@huawei.com>
 <864jm2vind.wl-maz@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <864jm2vind.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/17 20:15, Marc Zyngier wrote:
> On Mon, 17 Jul 2023 12:56:39 +0100,
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>
>>
>> On 2023/7/17 17:42, Marc Zyngier wrote:
>>> On 2023-07-17 09:07, Kefeng Wang wrote:
>>>> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing the
>>>> user to enable dead code elimination. In order for this to work, ensure
>>>> that we keep the necessary tables by annotating them with KEEP, also it
>>>> requires further changes to linker script to KEEP some tables and
>>>> wildcard
>>>> compiler generated sections into the right place.
>>>>
>>>> The following comparison is based 6.5-rc2 with defconfig,
>>>>
...
>>>
>>> I took this patch for a spin in my tree, and ended up with:
>>>
>>>     CC      .vmlinux.export.o
>>>     UPD     include/generated/utsversion.h
>>>     CC      init/version-timestamp.o
>>>     LD      .tmp_vmlinux.kallsyms1
>>> ld: init/main.o(__patchable_function_entries): error: need linked-to
>>> section for --gc-sections
>>> make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
>>> make[1]: *** [/home/maz/hot-poop/arm-platforms/Makefile:1238:
>>> vmlinux] Error 2
>>> make: *** [Makefile:234: __sub-make] Error 2
>>
>> I don't find this error with CONFIG_FTRACE_MCOUNT_RECORD or
>> allyesconfig, does it need special config or gcc version?
> 
> You tell me!
> 
> gcc (Debian 10.2.1-6) 10.2.1 20210110
> Copyright (C) 2020 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> so hardly something special. This is built with the current state of
> my NV tree, available here[1] As for the configuration, have a look
> here[2].

1) With gcc 10.3.1/ld (GNU Binutils) 2.37， it could be reproduced,
but there is no issue for cross-compiler gcc 9.3/ld (GNU Binutils for
Ubuntu) 2.34.

2) There is same issue like commit f7584322e4fe ("riscv: disable 
HAVE_LD_DEAD_CODE_DATA_ELIMINATION for LLD") said with allyesconfig on
arm64, it takes too long in bfd_flavour_name()

Samples: 257K of event 'cycles', Event count (approx.): 203974259359 

   Overhead  Shared Object             Symbol 
               IPC   [IPC Coverage]
-   61.11%  libbfd-2.34-arm64.so      [.] bfd_flavour_name 
              -      -
      bfd_flavour_name 

-    6.55%  libbfd-2.34-arm64.so      [.] bfd_hash_traverse 
              -      -


Just like you said, it is not ready for prime time, so please ignore
this patch :(


> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-6.6-WIP
> [2] https://paste.debian.net/1286106/
> 
