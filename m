Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815FC76B475
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjHAMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHAMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:13:51 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F041990;
        Tue,  1 Aug 2023 05:13:49 -0700 (PDT)
Received: from [192.168.178.44] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id F28AE1118;
        Tue,  1 Aug 2023 13:13:47 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl F28AE1118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1690892028;
        bh=kuuRov0naF5TWWQDqQa6Z0+frZkbiW8DUD6YZNp9hxY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=He4vGpduczIQA5AHH2ZBrnHzYDbkvwpvG40Cbct4QmnNYiuGcWrqmeNFT+AKAL2aB
         d94T4xqdJrNrFjtC0HXRkJfEQQlhOUBX7/4nU23hjg6E3MqV2hT1h/Nbls38EftEvu
         KwYsp68XDqSC4fVLJAnrkC82gp54MWcKpWWc6SrY=
Message-ID: <dbf75067-afca-6f2b-3709-d459c20ec04c@gigawatt.nl>
Date:   Tue, 1 Aug 2023 13:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
Content-Language: en-US
To:     Rich Felker <dalias@libc.org>, Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-x86_64@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
 <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
 <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
 <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
 <20230801025340.GA20403@brightrain.aerifal.cx>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20230801025340.GA20403@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 03:53, Rich Felker wrote:
> On Tue, Aug 01, 2023 at 02:38:47AM +0100, Jessica Clarke wrote:
>> On 1 Aug 2023, at 01:43, Harald van Dijk <harald@gigawatt.nl> wrote:
>>>
>>> On 06/12/2020 22:55, Andy Lutomirski wrote:
>>>> On Sat, Dec 5, 2020 at 4:01 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>>>>
>>>>> Ping?
>>>> Can you submit patches implementing my proposal?  One is your existing
>>>> patch plus fixing struct msghdr, with Cc: stable@vger.kernel.org at
>>>> the bottom.  The second is a removal of struct msghdr from uapi,
>>>> moving it into include/inux (no uapi) if needed.  The second should
>>>> not cc stable.
>>>
>>> Hi,
>>>
>>> This looks like it was forgotten, but it is still needed. Jessica,
>>> are you interested in submitting the requested change? If not,
>>> would it be okay if I do so? I have been running this locally for
>>> a long time now.
>>
>> Hi,
>> Please feel free to; sorry that it dropped off my radar. Part of the
>> issue is my laptop no longer being x86, making it more annoying to test.

No worries and thanks, I will do so.

>>> There is one complication that I think has not been mentioned yet:
>>> when _GNU_SOURCE is defined, glibc does provide a definition of
>>> struct msghdr in <sys/msg.h> with a field "__syscall_slong_t
>>> mtype;". This makes it slightly more likely that there is code out
>>> there in the wild that works fine with current kernels and would
>>> be broken by the fix. Given how rare x32 is, and how rare message
>>> queues are, this may still be acceptable, but I am mentioning it
>>> just in case this would cause a different approach to be
>>> preferred. And whatever is done, a fix should also be submitted to
>>> glibc.
>>
>> Given POSIX is very clear on how msghdr works I think we have to break
>> whatever oddball code out there might be using this. The alternative is
>> violating POSIX in a way that makes correct code compile fine but fail
>> at run time on x32, which is a terrible place to be, especially when
>> the “fix” is to special-case x32 to go against what POSIX says. I just
>> can’t see how that’s a good place to stay in, even if something might
>> break when we fix this bug.
> 
> Absolutely. The application-facing API absolutely needs to have the
> type of mtype be whatever long is in the application-facing C ABI.
> However, I'm not sure how best to fix this.

I shall go with Andy's suggested approach. 
<https://lore.kernel.org/all/CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com/>

>                                             A fix now still leaves
> applications broken on all existing kernels in the wild.

True, but fixing it any other way also leaves applications broken on all 
existing kernels in the wild, and fixing it this way makes it so that 
existing applications that are currently broken start to work 
automatically once people move to new kernels, rather than requiring 
rebuilds.

>                                                          This might be
> a place where libc should have x32-specific translation code to work
> around the wrong kernel ABI that became the contract with the kernel.

The problem is that there are two conflicting contracts, the de jure 
contract and the de facto contract. The de jure contract has always been 
that the field has type "long" and we have seen from the breakage that 
that is what applications have been using already. The de facto contract 
was different, but we do not know of any application that has made use 
of this. We cannot make it so that both work, so it makes sense to me to 
make it so that what we do know is out there works.

> I'm not sure how practical this is, since it seems like it would
> require a temp buffer. Is the message size sufficiently bounded to
> make that reasonable? Should there me a new x32-specific syscall that
> takes the right ABI so that translation is only needed on old kernels?

If a libc wishes to detect the current kernel behaviour and implement a 
workaround, can it technically not also do so without a new syscall by 
just issuing the syscall with a known payload and seeing what comes back?

But personally, I would be happy to leave that as it is now under Andy's 
rationale: "If you run user programs on a buggy kernel, you get buggy 
behavior..."

Cheers,
Harald van Dijk
