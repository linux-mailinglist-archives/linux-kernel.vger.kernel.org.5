Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45346753A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjGNMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjGNMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:20:49 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA2AA;
        Fri, 14 Jul 2023 05:20:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5BCE45BC3A;
        Fri, 14 Jul 2023 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689337243;
        bh=q12Qwj+UFcN/hmM9dyysrsMJNXrCP5EuxwmiEGdWI7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dGoxRgj4JUtxeGGNaBqKEc54nT4JcDtePc4VRm5fhtcYMtYe5mRAHViK6uxX+SYOP
         FKqiOewThyJJMVmuZy4v9+bvPZAGwflij8DGkuyDt53SM0uSOD5Wly/7DOQ0hjv5QX
         IRllewRErO3nCmmx4QQHeogtx2exf/owP1ucRFL3ICH7k+zvKVewAPBWVE/tRSUZzw
         GGOqhMznaH1mrnwV0G9Hgbfw3ZnhxzAUBRf+sxpih2Jlj0M4/mi/r3T1tXObKkJqBf
         rUOpznp47PQwSA9ZVN+JHs5+Y3l1/Hzn33ORXVNf1wKJOzkhKr/cyIV6sSK3t+ubCd
         SgsfFDNHmbynw==
Message-ID: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
Date:   Fri, 14 Jul 2023 21:20:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, daniel@ffwll.ch, gary@garyguo.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, marcan@marcan.st, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sven@svenpeter.dev, trix@redhat.com, wedsonaf@gmail.com
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
 <20230714101337.2193665-1-aliceryhl@google.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230714101337.2193665-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 19.13, Alice Ryhl wrote:
> Asahi Lina <lina@asahilina.net> writes:
>> Begone, lock classes!
>>
>> As discussed in meetings/etc, we would really like to support implicit
>> lock class creation for Rust code. Right now, lock classes are created
>> using macros and passed around (similar to C). Unfortunately, Rust
>> macros don't look like Rust functions, which means adding lockdep to a
>> type is a breaking API change. This makes Rust mutex creation rather
>> ugly, with the new_mutex!() macro and friends.
>>
>> Implicit lock classes have to be unique per instantiation code site.
>> Notably, with Rust generics and monomorphization, this is not the same
>> as unique per generated code instance. If this weren't the case, we
>> could use inline functions and asm!() magic to try to create lock
>> classes that have the right uniqueness semantics. But that doesn't work,
>> since it would create too many lock classes for the same actual lock
>> creation in the source code.
>>
>> But Rust does have one trick we can use: it can track the caller
>> location (as file:line:column), across multiple functions. This works
>> using an implicit argument that gets passed around, which is exactly the
>> thing we do for lock classes. The tricky bit is that, while the value of
>> these Location objects has the semantics we want (unique value per
>> source code location), there is no guarantee that they are deduplicated
>> in memory.
>>
>> So we use a hash table, and map Location values to lock classes. Et
>> voila, implicit lock class support!
>>
>> This lets us clean up the Mutex & co APIs and make them look a lot more
>> Rust-like, but it also means we can now throw Lockdep into more APIs
>> without breaking the API. And so we can pull a neat trick: adding
>> Lockdep support into Arc<T>. This catches cases where the Arc Drop
>> implementation could create a locking correctness violation only when
>> the reference count drops to 0 at that particular drop site, which is
>> otherwise not detectable unless that condition actually happens at
>> runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
>> to audit, this helps a lot.
>>
>> For the initial RFC, this implements the new API only for Mutex. If this
>> looks good, I can extend it to CondVar & friends in the next version.
>> This series also folds in a few related minor dependencies / changes
>> (like the pin_init mutex stuff).
> 
> I'm not convinced that this is the right compromise. Moving lockdep
> class creation to runtime sounds unfortunate, especially since this
> makes them fallible due to memory allocations (I think?).
> 
> I would be inclined to keep using macros for this.

Most people were very enthusiastic about this change in the meetings... 
it wasn't even my own idea ^^

I don't think the fallibility is an issue. Lockdep is a debugging tool, 
and it doesn't have to handle all possible circumstances perfectly. If 
you are debugging normal lock issues you probably shouldn't be running 
out of RAM, and if you are debugging OOM situations the lock keys would 
normally have been created long before you reach an OOM situation, since 
they would be created the first time a relevant lock class is used. More 
objects of the same class don't cause any more allocations. And the code 
has a fallback for the OOM case, where it just uses the Location object 
as a static lock class. That's not ideal and degrades the quality of the 
lockdep results, but it shouldn't completely break anything.

The advantages of being able to throw lockdep checking into arbitrary 
types, like the Arc<T> thing, are pretty significant. It closes a major 
correctness checking issue we have with Rust and its automagic Drop 
implementations that are almost impossible to properly audit for 
potential locking issues. I think that alone makes this worth it, even 
if you don't use it for normal mutex creation...

~~ Lina

