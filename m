Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766D7FDFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjK2S4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:56:32 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5CA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mnqfuOINSRYoVqpQH4axM59kPcJff9hNQcJnzv6NSeU=; b=i7fufibmigOcoWhN7fy+M4cMok
        ovLL2utU4+XRQMUMOt9pHaLzrEUC9uRpfMC8krU9gsUGJBMJzvwzV4GNhGRZF4GSC/xiIPDC3geKx
        OUSA2sH6VMTCYvEESkMu0DIL4mLherHnx4DDRK+devuRmy5yCKPNe9IFBIHwCPK808YhZ012kYtub
        Zms6l5rQsdcF5ba6NuqCqTM7Lp7wnDHerO4pyyRNIOKx7LrUyl1CdGTqDaP/7W53lrxQtkX+t21lM
        ssOuiuB2IYvOzhKgiI1jsDk8bAKXx5viRk49cklr8X3CpJAK1Lb9gpPx/TnmeA8w485ukopB4qMmF
        btvGy55w==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209] helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r8PjN-008Wiw-BR; Wed, 29 Nov 2023 19:56:17 +0100
Message-ID: <d35af5a1-12c1-4b5a-8e9e-c4bc5bda4de2@igalia.com>
Date:   Wed, 29 Nov 2023 15:56:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
To:     Wei Gao <wegao@suse.com>
Cc:     tglx@linutronix.de, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@redhat.com,
        peterz@infradead.org, Arnd Bergmann <arnd@kernel.org>
References: <20231123053140.16062-1-wegao@suse.com>
 <189e733e-7056-45c4-a5c6-3371f8219b7e@igalia.com> <ZWSIfy+QJFyw/zGC@wegao>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ZWSIfy+QJFyw/zGC@wegao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Em 27/11/2023 09:15, Wei Gao escreveu:
> On Thu, Nov 23, 2023 at 01:09:55PM -0300, André Almeida wrote:
>> [+CC Arnd]
>>
>> Hi Wei,
>>
>> Em 23/11/2023 02:31, Wei Gao escreveu:
>>> From: wei gao <wegao@suse.com>
>>>
>>> Current implementation lead LTP test case futex_waitv failed when compiled with
>>> -m32. This patch add new compat_sys_futex_waitv to handle m32 mode syscall.
>>>
>>> The failure reason is futex_waitv in m32 mode will deliver kernel with struct
>>> old_timespec32 timeout, but this struct type can not directly used by current
>>> sys_futex_waitv implementation.
>>>
>>> The new function copy main logic of current sys_futex_waitv, just update parameter
>>> type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
>>> and use get_old_timespec32 within the new function to get timeout value.
>>>
>>
>> From, what I recall, we don't want to add new syscalls with old_timespec32,
>> giving that they will have a limited lifetime. Instead, userspace should be
>> able to come up with a 64-bit timespec implementation for -m32.
>>
>> Thanks,
>> 	André
> 
> Just a comment, I have checked the glibc latest code but do not see any implemention(*.c) on
> futex_waitv syscall. So normally you have to do syscall directly with __NR_futex_waitv from
> userspace. So i guess glibc-side can not covert this struct correctly currently. Correct me if
> any misunderstanding.
> 

futex() has no syscall wrappers in glibc. Userspace needs to figure out 
everything by themselves, including which struct they should use, and I 
don't think that glibc does any conversion. If you create manually a 
timespec64 that works in -m32, and pass this to sycall(__NR_futex_waitv, 
..., &timeout, ...), it should work correctly. You can read more about 
how glibc is planning to deal with this at [1]. Please let me know if 
now it's more clear :)

[1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign

> Thanks
> Wei Gao
