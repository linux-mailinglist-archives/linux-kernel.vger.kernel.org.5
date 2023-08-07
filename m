Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28808772EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHGTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjHGTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:31:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD171715
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:31:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so1451138e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691436700; x=1692041500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLrESuDnsmXF0LnLVgvvKKzxJ74Ji/f7/0NisgyaeNY=;
        b=XWXEoDjwIoxLdSnNQYBFSi1jX94xWwYgs4i714OjShNXUvW43/woTznr3IeaCP1HKu
         j7i6M7GAtPEl0AdM0vYHMdp7T+eY1avUVJNuM1YRuyBTsjdxorB0QYXqd1Mww7keuXhp
         5PwS1WTmAuEkxJN7z9ApJON4oKGgEXGh2AoV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436700; x=1692041500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLrESuDnsmXF0LnLVgvvKKzxJ74Ji/f7/0NisgyaeNY=;
        b=ffdi3TUP1ZVP0EYzyV1PoqhsFC1QNv+RJpM/xcuxGtcYLJPVp37NNhNKok9Zj0RFPy
         n1Hm85ehKBbI7yxCnwQolbtS0Qbab+AJ4vjiDEo8AN8vKmdnpZwAxh5an/8HzxST5eU8
         uJfD5azbvAY8Cp4VdHohFAsaPA5/Z8VQaXce6xmbMvhnPwxJ4WY5lg0MU3rv7EM+31l1
         HW+s+yUXs9RdNo64lVEKnFQsNxVm8tGr69wsnSfo1NzEZ9C+INhvDyRR1KF6eQxqsSBp
         JUuuJyBjDl1J2iATkqqnuWgeJwRsFGwLDTh7FIqgAJxRggaCTOayIxNpRQ2rSb8MsLjK
         4klA==
X-Gm-Message-State: AOJu0YzEaAuh8WGBB1tYCnc76zhCsOUHJZZRCV3YbY6Z6HLVxGGX0YOk
        blOJbtn2hFC0+02IgibuYFXt2g==
X-Google-Smtp-Source: AGHT+IFk3+ohzmOe6boF0ZZ2cAYTtOL4Ql9DEH7mbY5LEm16+hpE8IoUOk6elVbSrPdVAbdqOb6hUA==
X-Received: by 2002:a05:6512:3696:b0:4fe:61f:3025 with SMTP id d22-20020a056512369600b004fe061f3025mr5912246lfs.61.1691436700291;
        Mon, 07 Aug 2023 12:31:40 -0700 (PDT)
Received: from [192.168.1.128] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b0052228721f84sm5609359eds.77.2023.08.07.12.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 12:31:39 -0700 (PDT)
Message-ID: <fdd7eb5d-2b76-d326-f059-5cdf652b5848@rasmusvillemoes.dk>
Date:   Mon, 7 Aug 2023 21:31:38 +0200
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
 <ZNEHt564a8RCLWon@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZNEHt564a8RCLWon@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 17.03, Petr Mladek wrote:

> I agree that kernel.h is not the right place. But are there any
> numbers how much separate sprintf.h might safe?
> 
> Maybe, we should not reinvent the wheel and get inspired by
> userspace.
> 
> sprintf() and friends are basic functions which most people know
> from userspace. And it is pretty handy that the kernel variants
> are are mostly compatible as well.
> 
> IMHO, it might be handful when they are also included similar way
> as in userspace. From my POV printk.h is like stdio.h. And we already
> have include/linux/stdarg.h where the v*print*() function might
> fit nicely.
> 
> How does this sound, please?

No, please. Let's have a separate header for the functions defined in
vsprintf.c. We really need to trim our headers down to something more
manageable, and stop including everything from everywhere just because
$this little macro needs $that little inline function.

I did https://wildmoose.dk/header-bloat/ many moons ago, I'm sure it
looks even worse today. I also did some sparse-hackery to let it tell me
which macros/functions/types were declared/defined in a given .h file,
and then if some .c file included that .h file but didn't use any of
those, the #include could go away.

Sure, individually, moving the sprintf family out of kernel.h won't save
much (and, of course, nothing at all initially when we're forced to add
an include of that new header from kernel.h). But this technical debt
has crept in over many years, it's not going away in one or two
releases. And use of the sprintf family is very easy to grep for, so
it's a good low-hanging fruit where we should be able to make everybody
who needs one of them include the proper header, and then drop the
include from kernel.h.

Rasmus

