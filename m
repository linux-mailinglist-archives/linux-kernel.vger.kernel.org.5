Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21D7E8CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjKKV2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 16:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKKV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:28:19 -0500
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A1630CF;
        Sat, 11 Nov 2023 13:28:13 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=mjdeD0+2G2xrDblu8xf67zkVr2FckV+NMqJiE7u1C9M=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230917; t=1699738090; v=1; x=1700170090;
 b=BsUhxuMbyD4zeS7Ngw0ZE0VqHmG79G3iGlVMACgppQhpsBznvD3W+dc8xYLxKFnVCFu/KxkU
 JYTbflkkYPmfMdvM3Tp/NRf0yaLheJaGvAeBSXC2h1i4BjiD+8h9Jn2Gy0DaqSQBbU/MRmGQkTX
 Wz7M25jbU0jIJHb3nkIVjYx0CsgIBEJJL57e65dJEMiJD0woMaJ9OwbDAaxcBsKVEThFt2NqvNN
 89ZkpKYpphn0hDcNiXbRHQUOvleMftEoWDBzu58QwoLXIdTDmUhxisjfrB8HCbUtbsBeZiLSb5u
 kstAnVYgu+jGPQmm/HQ+3WOuJoYAll/KkUbHtI1WCLWzSb1SGJ4HttZUcjznTgkeNTlkSl1qrDK
 pODg6SZaK6CyTZF5HhwwzrTsMAiaO0CqoMrkbV1TwRddko2XKSGGRgZoyXIlmA7GNEGyUE52gg7
 oUK5AIEsHbvIScHnWSVlDY2J0vi0/iHQFHClD4QZRDmDwKbwJtmDqgq3iUPrbmw0Vyfb+aaDvBh
 JESw5cp/acCY982cQ0Fk3VUfx0ELBf7i1ga1XNbUkg27F6ByHOhMkPi150eZHr5HMn++sGLcO9S
 Sw3nM5QoupnfA7B2KMX6naNNnvuUH4Y8Ue6dQJvxei7FzgI95SLjvAAenrLZ1wCWkx9nCld6+2N
 5AFGVS2THzQ=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 4886a98c; Sat, 11 Nov
 2023 16:28:10 -0500
MIME-Version: 1.0
Date:   Sat, 11 Nov 2023 16:28:10 -0500
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam James <sam@gentoo.org>
Subject: Re: Bisected stability regression in 6.6
In-Reply-To: <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
Message-ID: <460e91ec172724c8af235efd640eb05d@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-11 16:21, Helge Deller wrote:
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
>>      functions, so get rid of arch specific code and use the generic 
>> version
>>      by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>> 
>>      Note that on parisc the stack always grows up and a "unlimited stack"
>>      simply means that the value as defined in 
>> CONFIG_STACK_MAX_DEFAULT_SIZE_MB
>>      should be used. So RLIM_INFINITY is not an indicator to use the legacy
>>      memory layout.
>> 
>>      Signed-off-by: Helge Deller <deller@gmx.de>
>> 
>>   arch/parisc/Kconfig             | 17 +++++++++++++
>>   arch/parisc/kernel/process.c    | 14 -----------
>>   arch/parisc/kernel/sys_parisc.c | 54 
>> +----------------------------------------
>>   mm/util.c                       |  5 +++-
>>   4 files changed, 22 insertions(+), 68 deletions(-)
> 
> Thanks for your report!
> I think it's quite unlikely that this patch introduces such a bad 
> regression.
> I'd suspect some other bad commmit, but I'll try to reproduce.
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

Nope, I use "make olddefconfig" when upgrading and it appears to be 
default-disabled.

$ grep -i "config_bpf_jit" /usr/src/linux-6.6.0-gentoo/.config
# CONFIG_BPF_JIT is not set
