Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9030676FA45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjHDGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjHDGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:39:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F449E6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:39:27 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHGFB4Y1YzNmg3;
        Fri,  4 Aug 2023 14:35:58 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 14:39:24 +0800
Message-ID: <db4b23bb-c31c-b936-68c1-fbc54a2f4329@huawei.com>
Date:   Fri, 4 Aug 2023 14:39:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH -next v3] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>, <ryan.roberts@arm.com>,
        <joey.gouly@arm.com>, <ardb@kernel.org>, <bhe@redhat.com>,
        <thunder.leizhen@huawei.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230725202404.3470111-1-chris.zjh@huawei.com>
 <ZMvefmB6unOE+OPB@arm.com> <ce4e5bfa-6a98-4d5d-d91f-d91835010f71@arm.com>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <ce4e5bfa-6a98-4d5d-d91f-d91835010f71@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
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


在 2023/8/4 14:24, Anshuman Khandual 写道:
>
> On 8/3/23 22:36, Catalin Marinas wrote:
>> On Tue, Jul 25, 2023 at 08:24:04PM +0000, Zhang Jianhua wrote:
>>> When building with W=1, the following warning occurs.
>>>
>>> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>>>    129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>>>        |                                         ^~~~~~~~~
>>> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>>>    142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>>>        |     ^~~~~~~~~~~~~~~~~~~~
>>>
>>> The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS == 3
>>> and CONFIG_VA_BITS == 39.
>> The correct description is that the generic PUD_SHIFT isn't defined for
>> asm files, we still have it defined for C files (there's an #ifndef
>> __ASSEMBLY__ guard).
> Agreed, please rework the commit message explaining how generic PUD_SHIFT
> definition is not available for assembly files, prompting this code block
> movement. CONFIG_PGTABLE_LEVELS == 3 with CONFIG_VA_BITS == 39 just help
> in exposing this problem.
No problem, I will send a new patch soon.
>>> Now move the macro ARM64_MEMSTART_SHIFT and
>>> ARM64_MEMSTART_ALIGN to arch/arm64/mm/init.c where it is used to avoid
>>> this issue, and also there is no other place to call these two macro.
>>>
>>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
>> This fix works for me. I'll leave it to Will for 6.6 as apart from the
>> warning with W=1, there's no other issue (ARM64_MEMSTART_* are not used
>> in any asm files).
> Right, not real a problem to be fixed, this can wait till 6.6
>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
