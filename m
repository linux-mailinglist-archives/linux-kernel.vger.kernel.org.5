Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE26478C1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjH2JzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjH2Jyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:54:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D9E9;
        Tue, 29 Aug 2023 02:54:38 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZjNP5yT5zhZHV;
        Tue, 29 Aug 2023 17:50:45 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 17:54:36 +0800
Message-ID: <4b4063c2-dfd3-474b-6827-8dbd1257af2d@huawei.com>
Date:   Tue, 29 Aug 2023 17:54:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v9 0/2] support allocating crashkernel above 4G
 explicitly on riscv
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230726175000.2536220-1-chenjiahao16@huawei.com>
Content-Language: en-US
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20230726175000.2536220-1-chenjiahao16@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a friendly ping. Anyone has additional comments on this patch set?

Best regards,
Jiahao

On 2023/7/27 1:49, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
>
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
>
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low". Besides, there are few rules need
> to take notice:
> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>     is specified.
> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>     and there is enough memory to be allocated under 4G.
> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>     specified, a 128M low memory will be allocated automatically for
>     swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
>
> To verify loading the crashkernel, adapted kexec-tools is attached below:
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
>
> Following test cases have been performed as expected:
> 1) crashkernel=256M                          //low=256M
> 2) crashkernel=1G                            //low=1G
> 3) crashkernel=4G                            //high=4G, low=128M(default)
> 4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
> 5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
> 6) crashkernel=4G,high                       //high=4G, low=128M(default)
> 7) crashkernel=256M,low                      //low=0M, invalid
> 8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
> 9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
> 10) crashkernel=512M@0xd0000000              //low=512M
> 11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M
>
> Changes since [v9]:
> 1. As per Conor's comment, rebase to correct base on riscv/for-next
>     branch. No code logic changed.
>
> Changes since [v8]:
> 1. Rebase to newest mainline head, not modifying any code logic.
>
> Changes since [v7]:
> 1. Minor refactor: move crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE
>     into the !high branch when the first allocation fails. Not changing
>     the result but further align with Arm64 logic, refer to Baoquan's
>     comment.
> 2. Add test case "crashkernel=1G,high crashkernel=0M,low", the result
>     also matches our expectation.
>
> Changes since [v6]:
> 1. Introduce the "high" flag to mark whether "crashkernel=X,high"
>     is passed. Fix the retrying logic between "crashkernel=X,high"
>     case and others when the first allocation attempt fails.
>
> Changes since [v5]:
> 1. Update the crashkernel allocation logic when crashkernel=X,high
>     is specified. In this case, region above 4G will directly get
>     reserved as crashkernel, rather than trying lower 32bit allocation
>     first.
>
> Changes since [v4]:
> 1. Update some imprecise code comments for cmdline parsing.
>
> Changes since [v3]:
> 1. Update to print warning and return explicitly on failure when
>     crashkernel=size@offset is specified. Not changing the result
>     in this case but making the logic more straightforward.
> 2. Some minor cleanup.
>
> Changes since [v2]:
> 1. Update the allocation logic to ensure the high crashkernel
>     region is reserved strictly above dma32_phys_limit.
> 2. Clean up some minor format problems.
>
> Chen Jiahao (2):
>    riscv: kdump: Implement crashkernel=X,[high,low]
>    docs: kdump: Update the crashkernel description for riscv
>
>   .../admin-guide/kernel-parameters.txt         | 15 +--
>   arch/riscv/kernel/setup.c                     |  5 +
>   arch/riscv/mm/init.c                          | 93 +++++++++++++++++--
>   3 files changed, 99 insertions(+), 14 deletions(-)
>
