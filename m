Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF47E8CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjKKV2M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 16:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:28:11 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3429F;
        Sat, 11 Nov 2023 13:28:08 -0800 (PST)
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
User-agent: mu4e 1.10.8; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     Helge Deller <deller@gmx.de>
Cc:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam James <sam@gentoo.org>
Subject: Re: Bisected stability regression in 6.6
Date:   Sat, 11 Nov 2023 21:27:54 +0000
Organization: Gentoo
In-reply-to: <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
Message-ID: <87edgw6kuz.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Deller <deller@gmx.de> writes:

> On 11/11/23 07:31, matoro wrote:
>> Hi Helge, I have bisected a regression in 6.6 which is causing
>> userspace segfaults at a significantly increased rate in kernel 6.6.
>> There seems to be a pathological case triggered by the ninja build
>> tool.  The test case I have been using is cmake with ninja backend to
>> attempt to build the nghttp2 package.  In 6.6, this segfaults, not at
>> the same location every time, but with enough reliability that I was
>> able to use it as a bisection regression case, including immediately
>> after a reboot.  In the kernel log, these show up as "trap #15: Data
>> TLB miss fault" messages.  Now these messages can and do show up in
>> 6.5 causing segfaults, but never immediately after a reboot and
>> infrequently enough that the system is stable.  With kernel 6.6 I am
>> completely unable to build nghttp2 under any circumstances.
>>
>> I have bisected this down to the following commit:
>>
>> $ git bisect good
>> 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
>> commit 3033cd4307681c60db6d08f398a64484b36e0b0f
>> Author: Helge Deller <deller@gmx.de>
>> Date:   Sat Aug 19 00:53:28 2023 +0200
>>
>>      parisc: Use generic mmap top-down layout and brk randomization
>>
>>      parisc uses a top-down layout by default that exactly fits the generic
>>      functions, so get rid of arch specific code and use the generic version
>>      by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>>
>>      Note that on parisc the stack always grows up and a "unlimited stack"
>>      simply means that the value as defined in CONFIG_STACK_MAX_DEFAULT_SIZE_MB
>>      should be used. So RLIM_INFINITY is not an indicator to use the legacy
>>      memory layout.
>>
>>      Signed-off-by: Helge Deller <deller@gmx.de>
>>
>>   arch/parisc/Kconfig             | 17 +++++++++++++
>>   arch/parisc/kernel/process.c    | 14 -----------
>>   arch/parisc/kernel/sys_parisc.c | 54 +----------------------------------------
>>   mm/util.c                       |  5 +++-
>>   4 files changed, 22 insertions(+), 68 deletions(-)
>
> Thanks for your report!
> I think it's quite unlikely that this patch introduces such a bad regression.
> I'd suspect some other bad commmit, but I'll try to reproduce.

matoro, does a revert apply cleanly? Does it help?

>
> In any case, do you have CONFIG_BPF_JIT enabled? If so, could you try
> to reproduce with CONFIG_BPF_JIT disabled?
> The JIT is quite new in v6.6 and I did face some crashes and disabling
> it helped me so far.
>
>> I have tried applying ad4aa06e1d92b06ed56c7240252927bd60632efe
>> ("parisc: Add nop instructions after TLB inserts") on top of 6.6, but
>> it does NOT fix the issue.
>
> Ok.
>
> Helge

