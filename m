Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44175801E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjGROul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGROui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7DEE0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689691783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abV4mlBo90sOV9V4BPvAfWKx6id4MQfiRqiogKOdYOc=;
        b=htZCeh4VGeQJOoRnbtXslXatWUctK/v9+bsvGsOfgJc9VQ4LqYFE7RXs5YZKTZ8r3ULa0y
        Y8ibYqX+MnCUqBqFRWgxNuoh2Apc1ygqacMySYV7LV2eZ6LivDgn5BKguxBCKRE1N1j+sQ
        0HM4HCfLbTD2VGDiOq0tMkFS5qA83Xc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-9eHq0RQ1MU-gB-wNc78bDQ-1; Tue, 18 Jul 2023 10:49:40 -0400
X-MC-Unique: 9eHq0RQ1MU-gB-wNc78bDQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b92dd520a2so32756701fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691778; x=1692283778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abV4mlBo90sOV9V4BPvAfWKx6id4MQfiRqiogKOdYOc=;
        b=apJnmlcxfHGY7SlbkEwzJtPdecuXr84fPoI+KRsZ3UHiW3UBO3SX7DoXgOWpuk7SYo
         0oQ7UevTMDEn9Mbk6TIMlCzXHdHlAYNkUG4P1oIPJ90tzX3J2BrZc1iRWPoHS/oi9UWX
         CGFckFsUZ+f2HMPytXQQpD8MLgqJh1O8csozQ1M/2Pb+WBQwReDb/P2eX3wZKP6cz0LG
         duppHBQbQQsJgQswn3bBFMh+LRkBlG3Zzosf95LjmxpUv/39fLbq8QZIvP3JomOpKCBO
         9Qu6ykK1BT8ZOXg7vIKz9EnbH6FuDAWHDrdgFl3pU551C8aa7xlMeZg5PDsuSdrzVLnb
         4CgQ==
X-Gm-Message-State: ABy/qLZR9mdY/sTQ6/Jy5Rf21AC0HOB1Cfm3oAPnRPz4flh8AGgrfTeT
        eo9Kf/qrQ+tCeSMXcm1TaoAZ5wjTjFk1ACvNUoKCS6F9egPh04vp/61N6//vj0Tphut2oU5MTJE
        BHC0DbjoGT0WTZM9ZWIokMNhwzwSv7BQ=
X-Received: by 2002:a05:651c:20a:b0:2b6:d8d4:161 with SMTP id y10-20020a05651c020a00b002b6d8d40161mr14372992ljn.43.1689691778576;
        Tue, 18 Jul 2023 07:49:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5JDswpR2EOPP8NOHEKluBljHYS7z6yPDbJSsTV4fTGMWZ38+swY5BKfujkIEP2DL6KVNKFg==
X-Received: by 2002:a05:651c:20a:b0:2b6:d8d4:161 with SMTP id y10-20020a05651c020a00b002b6d8d40161mr14372980ljn.43.1689691778205;
        Tue, 18 Jul 2023 07:49:38 -0700 (PDT)
Received: from [192.168.1.121] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id k25-20020a2e8899000000b002b6e00a3e19sm511588lji.132.2023.07.18.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:49:37 -0700 (PDT)
Message-ID: <f25d597b-a0e5-95db-5538-79893b8d37b2@redhat.com>
Date:   Tue, 18 Jul 2023 17:49:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] x86/entry/64: Convert SYSRET validation tests to C
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20230718134446.168654-1-brgerst@gmail.com>
 <20230718134446.168654-3-brgerst@gmail.com>
 <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com>
 <CAMzpN2jzsbUh=2JyCxvOCGJNpycaKPW9WL3JniwrzZB+-mf+tg@mail.gmail.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <CAMzpN2jzsbUh=2JyCxvOCGJNpycaKPW9WL3JniwrzZB+-mf+tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.7.2023 17.25, Brian Gerst wrote:
> On Tue, Jul 18, 2023 at 10:17 AM Mika Penttilä <mpenttil@redhat.com> wrote:
>>
>> Hi,
>>
>>
>> On 18.7.2023 16.44, Brian Gerst wrote:
>>> Signed-off-by: Brian Gerst <brgerst@gmail.com>
>>> ---
>>>    arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++++-
>>>    arch/x86/entry/entry_64.S      | 55 ++--------------------------------
>>>    arch/x86/include/asm/syscall.h |  2 +-
>>>    3 files changed, 52 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>>> index 6c2826417b33..afe79c3f1c5b 100644
>>> --- a/arch/x86/entry/common.c
>>> +++ b/arch/x86/entry/common.c
>>> @@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
>>>        return false;
>>>    }
>>>
>>> -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>>> +/* Returns true to return using SYSRET, or false to use IRET */
>>> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>>>    {
>>> +     long rip;
>>> +     unsigned int shift_rip;
>>> +
>>>        add_random_kstack_offset();
>>>        nr = syscall_enter_from_user_mode(regs, nr);
>>>
>>> @@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>>>
>>>        instrumentation_end();
>>>        syscall_exit_to_user_mode(regs);
>>> +
>>> +     /*
>>> +      * Check that the register state is valid for using SYSRET to exit
>>> +      * to userspace.  Otherwise use the slower but fully capable IRET
>>> +      * exit path.
>>> +      */
>>> +
>>> +     /* XEN PV guests always use IRET path */
>>> +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
>>> +             return false;
>>> +
>>> +     /* SYSRET requires RCX == RIP and R11 == EFLAGS */
>>> +     if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
>>> +             return false;
>>> +
>>> +     /* CS and SS must match the values set in MSR_STAR */
>>> +     if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
>>> +             return false;
>>> +
>>> +     /*
>>> +      * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
>>> +      * in kernel space.  This essentially lets the user take over
>>> +      * the kernel, since userspace controls RSP.
>>> +      *
>>> +      * Change top bits to match most significant bit (47th or 56th bit
>>> +      * depending on paging mode) in the address.
>>> +      */
>>> +     shift_rip = (64 - __VIRTUAL_MASK_SHIFT + 1);
>>
>> Should this be:
>>
>>          shift_rip = (64 - __VIRTUAL_MASK_SHIFT - 1);
>> ?
> 
> I removed a set of parentheses, which switched the sign from -1 to +1.
> I could put it back if that's less confusing.
> 

I mean isn't it supposed to be:
shift_rip = (64 - 48) for 4 level, now it's
shift_rip = (64 - 46)

__VIRTUAL_MASK_SHIFT == 47


> Brian Gerst
> 

