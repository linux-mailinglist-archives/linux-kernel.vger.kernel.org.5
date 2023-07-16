Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197AF754D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGPG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 02:56:40 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF3189;
        Sat, 15 Jul 2023 23:56:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4B9AC425B3;
        Sun, 16 Jul 2023 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689490594;
        bh=DAQHK2auXlvC8BLvWoW2JEMp1pYz/l6r5bgdld5jeNE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=0XSaNH1/2vL0Qgpwa8gVYBTnKj3hX+BcCmIk0gbO+D1brbV64kSJF1bfUDvV2abDG
         1clhpnM+uvHbsdFiFiWHSvAgUIVxEtbB4yCouBhqfPsCose1wt2Fua00dGUVnk/l7d
         ARY6C0u6X5YcbP61BOzICh6f1TaeXiuTdM03+VBvP3vdsQIRB/gROIYTQQaRlmCih+
         WWBlSH3IMRaWqhD/QZPkPfDMOzBeAe93Sp2j/vGZssQF61XBgRltfbKJWstCVj7NYC
         ngMhd8iL+Xt1PgHnOxiz1JYkxrO886HAEjOcNMqrtsu/JJgAQG9PI34pqq0BgihJSa
         abVk60B6wEeaA==
Message-ID: <4259c52a-b3f1-e063-209b-a0daa526234f@asahilina.net>
Date:   Sun, 16 Jul 2023 15:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, daniel@ffwll.ch,
        gary@garyguo.net, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        marcan@marcan.st, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, sven@svenpeter.dev,
        trix@redhat.com, wedsonaf@gmail.com
References: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
 <20230714135926.382695-1-aliceryhl@google.com>
 <ZLFn4RPiK3ig9I5M@Boquns-Mac-mini.home>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <ZLFn4RPiK3ig9I5M@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 00.21, Boqun Feng wrote:
> On Fri, Jul 14, 2023 at 01:59:26PM +0000, Alice Ryhl wrote:
>> Asahi Lina <lina@asahilina.net> writes:
>>> On 14/07/2023 19.13, Alice Ryhl wrote:
>>>> Asahi Lina <lina@asahilina.net> writes:
>>>>> Begone, lock classes!
>>>>>
>>>>> As discussed in meetings/etc, we would really like to support implicit
>>>>> lock class creation for Rust code. Right now, lock classes are created
> 
> Thanks for looking into this! Could you also copy locking maintainers in
> the next version?

Sure! Sorry, I totally forgot that I needed to do that manually since b4 
doesn't know about rust->C relations...

> 
>>>>> using macros and passed around (similar to C). Unfortunately, Rust
>>>>> macros don't look like Rust functions, which means adding lockdep to a
>>>>> type is a breaking API change. This makes Rust mutex creation rather
>>>>> ugly, with the new_mutex!() macro and friends.
>>>>>
>>>>> Implicit lock classes have to be unique per instantiation code site.
>>>>> Notably, with Rust generics and monomorphization, this is not the same
>>>>> as unique per generated code instance. If this weren't the case, we
>>>>> could use inline functions and asm!() magic to try to create lock
>>>>> classes that have the right uniqueness semantics. But that doesn't work,
>>>>> since it would create too many lock classes for the same actual lock
>>>>> creation in the source code.
>>>>>
>>>>> But Rust does have one trick we can use: it can track the caller
>>>>> location (as file:line:column), across multiple functions. This works
>>>>> using an implicit argument that gets passed around, which is exactly the
>>>>> thing we do for lock classes. The tricky bit is that, while the value of
>>>>> these Location objects has the semantics we want (unique value per
>>>>> source code location), there is no guarantee that they are deduplicated
>>>>> in memory.
>>>>>
>>>>> So we use a hash table, and map Location values to lock classes. Et
>>>>> voila, implicit lock class support!
>>>>>
>>>>> This lets us clean up the Mutex & co APIs and make them look a lot more
>>>>> Rust-like, but it also means we can now throw Lockdep into more APIs
>>>>> without breaking the API. And so we can pull a neat trick: adding
>>>>> Lockdep support into Arc<T>. This catches cases where the Arc Drop
>>>>> implementation could create a locking correctness violation only when
>>>>> the reference count drops to 0 at that particular drop site, which is
>>>>> otherwise not detectable unless that condition actually happens at
>>>>> runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
>>>>> to audit, this helps a lot.
>>>>>
>>>>> For the initial RFC, this implements the new API only for Mutex. If this
>>>>> looks good, I can extend it to CondVar & friends in the next version.
>>>>> This series also folds in a few related minor dependencies / changes
>>>>> (like the pin_init mutex stuff).
>>>>
>>>> I'm not convinced that this is the right compromise. Moving lockdep
>>>> class creation to runtime sounds unfortunate, especially since this
>>>> makes them fallible due to memory allocations (I think?).
>>>>
>>>> I would be inclined to keep using macros for this.
>>>
>>> Most people were very enthusiastic about this change in the meetings...
>>> it wasn't even my own idea ^^
>>
>> I don't think I was in that meeting. Anyway,
>>   
>>> I don't think the fallibility is an issue. Lockdep is a debugging tool,
>>> and it doesn't have to handle all possible circumstances perfectly. If
>>> you are debugging normal lock issues you probably shouldn't be running
>>> out of RAM, and if you are debugging OOM situations the lock keys would
>>> normally have been created long before you reach an OOM situation, since
>>> they would be created the first time a relevant lock class is used. More
>>> objects of the same class don't cause any more allocations. And the code
>>> has a fallback for the OOM case, where it just uses the Location object
>>> as a static lock class. That's not ideal and degrades the quality of the
>>> lockdep results, but it shouldn't completely break anything.
>>
>> If you have a fallback when the allocation fails, that helps ...
>>
>> You say that Location objects are not necessarily unique per file
>> location. In practice, how often are they not unique? Always just using
>> the Location object as a static lock class seems like it would
>> significantly simplify this proposal.

If a generic type is instantiated from different crates (e.g. kernel 
crate and a driver), it creates separate Location objects. But we also 
have a bigger problem: this breaks module unload, since that leaves lock 
classes dangling. Though that is yet another discussion to have (Rust's 
lifetime semantics kind of break down when you can unload modules!).

>>
> 
> Agreed. For example, `caller_lock_class_inner` has a Mutex critical
> section in it (for the hash table synchronization), that makes it
> impossible to be called in preemption disabled contexts, which limits
> the usage.

Maybe we can just make it a spinlock? The critical section is very short 
for lock classes that already exist (just iterating over the hash 
bucket, which will almost always be length 1), so it's probably more 
efficient to do that than use a mutex anyway. Lockdep itself uses a 
single global spinlock for a bunch of stuff too.

For the new class case it does do an allocation, but I think code 
probably shouldn't be creating locks and things like that with 
preemption disabled / in atomic context? That just seems like a recipe 
for trouble... though this ties into the whole execution context story 
for Rust, which we don't have a terribly good answer for yet, so I think 
it shouldn't block this approach. The macro style lock creation 
primitives still exist for code that really needs the static behavior.

~~ Lina

