Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C17773BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHJJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjHJJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:09:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2472123
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:09:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so956021e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691658563; x=1692263363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAppfDze+b0mlNksRhfLMmF8syWDm1cJ2oYz5chDViw=;
        b=HuwTeeroDJ144764rUZdAJTutbWPyr1EQqYweC8pKf4+Rg2BTcj/BJbC24+eni6mAk
         5idUuBHZ1vUCEFc0Juw2K1QIJbVBUfEC3lrqmG3fR4utT5q3xejsWOj1hYt5pmknt4Sb
         YCid8dLFG4e0swHy+K5AoNMQIR1DhanTuupmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658563; x=1692263363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAppfDze+b0mlNksRhfLMmF8syWDm1cJ2oYz5chDViw=;
        b=hKLyeAPeWxlek9Hp/rG6a0su8bYOqZRWyU9t1JXHt2obtX0rY3WvKGHXdkcV4RH8ly
         1BGqHx0qQhzw/DpXeIJ+P1E/6wP2F8I/yI2SKFXEbHgQY1YC/U0B7TJ5nHnsr4gVHoTg
         cytPh+w6+W0+xHxHaEfpGma3afabufzc1lTOQ5n33vJ5ovvZckLN87CNwsNqdFTYMEFJ
         wSn+CyfYitwfdrOqWzH80Tnvgfm7cqtamD2VlNXj8wh6tYJt1ju7tAPk5GPX8nSFbCHo
         YLrtlI3Zsy+faydtm5gShp35jVbYNwW12fTTWD85qzyDDFTIWs49fuZtw1hnmcwMz3Ke
         0YZQ==
X-Gm-Message-State: AOJu0YyIWCZBUCOg7l3sB/Did4UuJEdtnIWVGjmc7uNAKSHgrI9QhYeS
        Tnf1fCIQ+r2kVwnkj3vkcJFv/w==
X-Google-Smtp-Source: AGHT+IHVxHBRMDm6vKLkC2APmFhnCS1PrzaDVfdNO9/9mK9FQAj2LNwbF7TYoRq5+aHvJ1byifkwvg==
X-Received: by 2002:a05:6512:3194:b0:4fb:242:6dfa with SMTP id i20-20020a056512319400b004fb02426dfamr1689323lfe.57.1691658562818;
        Thu, 10 Aug 2023 02:09:22 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7c14b000000b0051e26c7a154sm530135edp.18.2023.08.10.02.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 02:09:22 -0700 (PDT)
Message-ID: <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
Date:   Thu, 10 Aug 2023 11:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Content-Language: en-US, da
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZNScla_5FXc28k32@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 10.15, Petr Mladek wrote:

> Everyone agrees that kernel.h should be removed. But there are always
> more possibilities where to move the definitions. For this, the use
> in C files must be considered. Otherwise, it is just a try&hope approach.
> 
>> Also, please, go through all of them and tell, how many of them are using
>> stuff from kernel.h besides sprintf.h and ARRAY_SIZE() (which I plan
>> for a long time to split from kernel.h)?
> 
> I am all for removing vsprintf declarations from linux.h.
> 
> I provided the above numbers to support the idea of moving them
> into printk.h.
> 
> The numbers show that the vsprintf function famility is used
> quite frequently. IMHO, creating an extra tiny include file
> will create more harm then good. By the harm I mean:
> 
>     + churn when updating 1/6 of source files

Well, we probably shouldn't do 5000 single-line patches to add that
sprintf.h include, and another 10000 to add an array-macros.h include
(just as an example). Some tooling and reasonable batching would
probably be required. Churn it will be, but how many thousands of
patches were done to make i2c drivers' probe methods lose a parameter
(first converting them all to .probe_new, then another round to again
assign to .probe when that prototype was changed). That's just the cost
of any tree-wide change in a tree our size.

>     + prolonging the list of #include lines in .c file. It will
>       not help with maintainability which was one of the motivation
>       in this patchset.

We really have to stop pretending it's ok to rely on header a.h
automatically pulling in b.h, if a .c file actually uses something
declared in b.h. [Of course, the reality is more complicated; e.g. we
have many cases where one must include linux/foo.h, not asm/foo.h, but
the actual declarations are in the appropriate arch-specific file.
However, we should not rely on linux/bar.h pulling in linux/foo.h.]

>     + an extra work for people using vsprintf function family in
>       new .c files. People are used to get them for free,
>       together with printk().

This is flawed. Not every C source file does a printk, or uses anything
else from printk.h. E.g. a lot of drivers only do the dev_err() family,
some subsystems have their own wrappers, etc. So by moving the
declarations to printk.h you just replace the kernel.h with something
equally bad (essentially all existing headers are bad because they all
include each other recursively). Also, by not moving the declarations to
a separate header, you're ignoring the fact that your own numbers show
that 5/6 of the kernel's TUs would become _smaller_ by not having to
parse those declarations. And the 1/6 that do use sprintf() may become
smaller by thousands of lines once they can avoid kernel.h and all that
that includes recursively.

But those gains can never be achieved if we don't start somewhere, and
if every such baby step results in 20+ message threads.

Rasmus

