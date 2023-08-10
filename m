Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B3777B78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjHJPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHJPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:00:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF79626B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:00:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AA3113E;
        Thu, 10 Aug 2023 08:00:50 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3613F64C;
        Thu, 10 Aug 2023 08:00:06 -0700 (PDT)
Message-ID: <10095b14-c005-c791-7e3e-d6561dac4dec@arm.com>
Date:   Thu, 10 Aug 2023 16:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG kernel-5.15] aarch64: __pi_strncmp() out-of-bound error
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WGlhb2JpbmcgU2hpICjlj7LlsI/lhbUp?= 
        <Xiaobing.Shi@mediatek.com>,
        =?UTF-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com>
 <ZNEOmRb2sYQlVYwj@FVFF77S0Q05N.cambridge.arm.com>
 <729b1505-c466-8a71-6079-4b0d9f81731d@arm.com>
 <20230810143118.GA5795@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230810143118.GA5795@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 3:31 pm, Will Deacon wrote:
> On Thu, Aug 10, 2023 at 01:23:28PM +0100, Robin Murphy wrote:
>> On 2023-08-07 16:32, Mark Rutland wrote:
>>> On Mon, Aug 07, 2023 at 12:31:45PM +0000, John Hsu (許永翰) wrote:
>>>> [ 7445.269347][  T382] ueventd: Hardware name: MT6886(ENG) (DT)
>>>> [ 7445.269354][  T382] ueventd: Call trace:
>>>> [ 7445.269359][  T382] ueventd:  dump_backtrace+0x0/0x2a8
>>>> [ 7445.269374][  T382] ueventd:  dump_stack_lvl+0x74/0xa4
>>>> [ 7445.269384][  T382] ueventd:  dump_stack+0x14/0x1c
>>>> [ 7445.269391][  T382] ueventd:  mrdump_common_die+0x32c/0x5ac [mrdump]
>>>> [ 7445.269470][  T382] ueventd:  ipanic_die+0x1c/0x28 [mrdump]
>>>> [ 7445.269539][  T382] ueventd:  __die+0xbc/0x308
>>>> [ 7445.269548][  T382] ueventd:  die+0xd8/0x500
>>>> [ 7445.269556][  T382] ueventd:  die_kernel_fault+0x94/0xa8
>>>> [ 7445.269565][  T382] ueventd:  __do_kernel_fault+0x1d8/0x214
>>>> [ 7445.269571][  T382] ueventd:  do_bad_area+0x40/0x174
>>>> [ 7445.269579][  T382] ueventd:  do_translation_fault+0x48/0x54
>>>> [ 7445.269585][  T382] ueventd:  do_mem_abort+0x3c/0x100
>>>> [ 7445.269592][  T382] ueventd:  el1_abort+0x38/0x54
>>>> [ 7445.269602][  T382] ueventd:  el1h_64_sync_handler+0x54/0x88
>>>> [ 7445.269610][  T382] ueventd:  el1h_64_sync+0x78/0x7c
>>>> [ 7445.269618][  T382] ueventd:  __pi_strncmp+0x1a0/0x1c4
>>>> [ 7445.269626][  T382] ueventd:  selinux_genfs_get_sid+0x114/0x220
>>>> [ 7445.269636][  T382] ueventd:  inode_doinit_with_dentry+0x3d0/0x598
>>>> [ 7445.269644][  T382] ueventd:  selinux_d_instantiate+0x1c/0x24
>>>> [ 7445.269652][  T382] ueventd:  d_splice_alias+0x5c/0x280
>>>> [ 7445.269662][  T382] ueventd:  kernfs_iop_lookup+0xec/0x21c
>>>> [ 7445.269674][  T382] ueventd:  __lookup_slow+0xc4/0x150
>>>> [ 7445.269684][  T382] ueventd:  lookup_slow+0x40/0xf0
>>>> [ 7445.269690][  T382] ueventd:  walk_component+0x144/0x160
>>>> [ 7445.269696][  T382] ueventd:  link_path_walk+0x25c/0x344
>>>> [ 7445.269703][  T382] ueventd:  path_lookupat+0x64/0x120
>>>> [ 7445.269710][  T382] ueventd:  filename_lookup+0xc4/0x1b0
>>>> [ 7445.269718][  T382] ueventd:  user_path_at_empty+0x48/0xb4
>>>> [ 7445.269725][  T382] ueventd:  do_faccessat+0xa8/0x1f0
>>>> [ 7445.269732][  T382] ueventd:  __arm64_sys_faccessat+0x20/0x28
>>>> [ 7445.269738][  T382] ueventd:  invoke_syscall+0x3c/0xf0
>>>> [ 7445.269746][  T382] ueventd:  el0_svc_common+0x84/0xe8
>>>> [ 7445.269753][  T382] ueventd:  do_el0_svc+0x20/0x84
>>>> [ 7445.269759][  T382] ueventd:  el0_svc+0x1c/0x48
>>>> [ 7445.269766][  T382] ueventd:  el0t_64_sync_handler+0x7c/0xd8
>>>> [ 7445.269773][  T382] ueventd:  el0t_64_sync+0x15c/0x160
>>>> We found that we hit this issue when we compare these two strings.
>>>> ________________address|_0__1__2__3__4__5__6__7__8__9__A__B__C__D__E__F
>>>> __   0123456789ABCDEF
>>>>      NSD:FFFFFF80089EDA00|>2F 64 65 76 69 63 65 73 2F 76 69 72 74 75 61
>>>> 6C  /devices/virtual
>>>>      NSD:FFFFFF80089EDA10| 2F 62 6C 6F 63 6B 2F 00 E0 03 01 AA E1 03 02
>>>> AA  /block/.........
>>>> ________________address|_0__1__2__3__4__5__6__7__8__9__A__B__C__D__E__F
>>>> __    0123456789ABCDEF
>>>>      NSD:FFFFFF803FD3EFE0| 00 00 00 00 00 00 00 00 00 00 2F 64 65 76 69
>>>> 63    ........../devic
>>>>      NSD:FFFFFF803FD3EFF0| 65 73>2F 76 69 72 74 75 61 6C 2F 6D 69 73 63
>>>> 00  es/virtual/misc.
>>>>      NSD:FFFFFF803FD3F000| ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
>>>> ??
>>>>      NSD:FFFFFF803FD3F0E0| ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
>>>> ??
>>>>
>>>> We observe the second string is put at the tail of the first page and
>>>> the next page is unreadable.
>>>> Thus, we made a simple test as below and it can reproduce this issue.
>>
>> I'm not sure there's strictly a bug here. The C standard says:
>>
>> "The strncmp function compares not more than n characters (characters that
>> follow a null character are not compared) ..."
>>
>> so although any characters between the first NULL and n must not be
>> considered for the result of the comparison, there doesn't seem to be any
>> explicit promise anywhere that they can't be *accessed*. AFAICT what happens
>> here is in the request to compare at most 23 characters, it ends up in the
>> do_misaligned case, loop_misaligned runs twice and finds no differences or
>> NULLs in characters 0-7 and 8-15, so then done_loop loads characters 15-23
>> to compare the last 7, and is tripped up by 22-23 not actually existing in
>> src2. Possibly the original intent was that this case should have ended up
>> in page_end_loop, and the condition for that was slightly off, but I'm not
>> sure, and this code is obsolete now anyway.
> 
> The long backtrace above worries me, as it suggests that you can trigger
> this from userspace. In that case I think it's a bug regardless of what
> the C standard says.

Bleh, poor choice of words... obviously there is a bug overall, it just 
might arguably be in the caller's expectations rather than the strncmp() 
implementation itself. However I would concur that there's no way we're 
going over all ~3000 strncmp() callsites with the "well, actually" comb 
just for this. It was more to say I don't think it's worth digging much 
deeper into exactly why, and I agree the pragmatic thing to do is either 
rip it out or backport the newer MTE-safe implementation which should be 
more robust.

Cheers,
Robin.
