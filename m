Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188D5777A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHJOSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHJOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:18:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E8212B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:18:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b974031aeaso15226691fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691677080; x=1692281880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScQPJVFmfG5yKGg5DsOWT7+SxQjEiPcmHkfk8PrKVuE=;
        b=iWBAAYJfmjFD5t+dtx0d3vEi3Mw0nihzMfBWohPon6ZlKKGGwxLvfK+suOec7m4WYZ
         ErSucSfxivToXSksb8WAS9Cz/Spoa8SxUjY7H5/FpLbwjoxAkKaVX/Aozzju+V0I3ahN
         g48KVvDqN8QtrU9OMaA1kvnUxRW7wBb8b302E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677080; x=1692281880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScQPJVFmfG5yKGg5DsOWT7+SxQjEiPcmHkfk8PrKVuE=;
        b=hkzhm8h7xtUjKyv5o1K39PqNWRVLukaOkKKMlTXjniDud9JeDa1I0T4votr66nK3vx
         EZQwrSp9LbsBsbmhLKNz3WKDZe7BcMUrHaVr3mdik85RNVxe1A+t0wjqaL+888O+FjdG
         6TbIkBO4Nj3pD//nBan8wYuTvursHXuw2U3sII964a1W30KTHN1UM0PBelSL0R74yVX0
         E3GDe4wR4NL1o8/X0XKCMaRqYdnJlZlZVRI9FBNqePQFku3d9CTkK4aOcOEaq8EG4hHJ
         caEwE1xk1zPRMQgc6oxKQUoqlVaz+J2iOWsvtdG72xhbifHXuDQziqtwid1wSAxShaZj
         xF8Q==
X-Gm-Message-State: AOJu0YxYWxFgAX1S19ZxBSaZPlOvlB9cnmHRLIEfbb5Prje3j4p32F5S
        0VzgnwpalB/H961QxV493OBNLg==
X-Google-Smtp-Source: AGHT+IGpHiNGH9i5ecq3yxubAnt6FGtsthT0WiEcuVXtQK4exQp9jozLOhix+OOPMl0MZcKTn0zomw==
X-Received: by 2002:a2e:920f:0:b0:2b9:eeaa:1072 with SMTP id k15-20020a2e920f000000b002b9eeaa1072mr2261035ljg.18.1691677079446;
        Thu, 10 Aug 2023 07:17:59 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l19-20020a2eb693000000b002b9b9fd0f92sm363615ljo.105.2023.08.10.07.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:17:58 -0700 (PDT)
Message-ID: <37faa9c7-94a3-3ea1-f116-6ff5cdf021cd@rasmusvillemoes.dk>
Date:   Thu, 10 Aug 2023 16:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley> <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com> <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley> <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
 <ZNScla_5FXc28k32@alley>
 <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
 <ZNTjbtNhWts5i8Q0@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZNTjbtNhWts5i8Q0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15.17, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 11:09:20AM +0200, Rasmus Villemoes wrote:
>> On 10/08/2023 10.15, Petr Mladek wrote:
> 
> ...
> 
>>>     + prolonging the list of #include lines in .c file. It will
>>>       not help with maintainability which was one of the motivation
>>>       in this patchset.
>>
>> We really have to stop pretending it's ok to rely on header a.h
>> automatically pulling in b.h, if a .c file actually uses something
>> declared in b.h. [Of course, the reality is more complicated; e.g. we
>> have many cases where one must include linux/foo.h, not asm/foo.h, but
>> the actual declarations are in the appropriate arch-specific file.
>> However, we should not rely on linux/bar.h pulling in linux/foo.h.]
> 
> Btw, it's easy to enforce IIUC, i.e. by dropping
> 
>   #ifndef _FOO_H
>   #define _FOO_H
>   #endif
> 
> mantra from the headers.
> 

No, you can't do that, because some headers legitimately include other
headers, often for type definitions. Say some struct definition where
one of the members is another struct (struct list_head being an obvious
example). Or a static inline function.

We _also_ don't want to force everybody who includes a.h to ensure that
they first include b.h because something in a.h needs stuff from b.h.

So include guards must be used. They are a so well-known idiom that gcc
even has special code for handling them: If everything in a foo.h file
except comments is inside an ifndef/define/endif, gcc remembers that
that foo.h file has such an include guard, so when gcc then encounters
some #include directive that would again resolve to that same foo.h, and
the include guard hasn't been #undef'ed, it doesn't even do the syscalls
to open/read/close the file again.

Rasmus

