Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A176FA02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjHDGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjHDGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:24:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 995FD2D69
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:24:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEAD2F4;
        Thu,  3 Aug 2023 23:24:58 -0700 (PDT)
Received: from [10.163.54.21] (unknown [10.163.54.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE07E3F5A1;
        Thu,  3 Aug 2023 23:24:11 -0700 (PDT)
Message-ID: <ce4e5bfa-6a98-4d5d-d91f-d91835010f71@arm.com>
Date:   Fri, 4 Aug 2023 11:54:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next v3] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
        joey.gouly@arm.com, ardb@kernel.org, bhe@redhat.com,
        thunder.leizhen@huawei.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725202404.3470111-1-chris.zjh@huawei.com>
 <ZMvefmB6unOE+OPB@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZMvefmB6unOE+OPB@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 22:36, Catalin Marinas wrote:
> On Tue, Jul 25, 2023 at 08:24:04PM +0000, Zhang Jianhua wrote:
>> When building with W=1, the following warning occurs.
>>
>> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>>       |                                         ^~~~~~~~~
>> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>>       |     ^~~~~~~~~~~~~~~~~~~~
>>
>> The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS == 3
>> and CONFIG_VA_BITS == 39.
> 
> The correct description is that the generic PUD_SHIFT isn't defined for
> asm files, we still have it defined for C files (there's an #ifndef
> __ASSEMBLY__ guard).

Agreed, please rework the commit message explaining how generic PUD_SHIFT
definition is not available for assembly files, prompting this code block
movement. CONFIG_PGTABLE_LEVELS == 3 with CONFIG_VA_BITS == 39 just help
in exposing this problem.

> 
>> Now move the macro ARM64_MEMSTART_SHIFT and
>> ARM64_MEMSTART_ALIGN to arch/arm64/mm/init.c where it is used to avoid
>> this issue, and also there is no other place to call these two macro.
>>
>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> 
> This fix works for me. I'll leave it to Will for 6.6 as apart from the
> warning with W=1, there's no other issue (ARM64_MEMSTART_* are not used
> in any asm files).

Right, not real a problem to be fixed, this can wait till 6.6

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
