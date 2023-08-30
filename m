Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833378E34B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbjH3XeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjH3XeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:34:20 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 16:34:08 PDT
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 002D1BC;
        Wed, 30 Aug 2023 16:34:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 485BE40042;
        Wed, 30 Aug 2023 18:17:15 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yCER6PakFvS6; Wed, 30 Aug 2023 18:17:15 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id E0AE840ED1;
        Wed, 30 Aug 2023 18:17:14 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TgOiTnypPo9S; Wed, 30 Aug 2023 18:17:14 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 73E6C40042;
        Wed, 30 Aug 2023 18:17:14 -0500 (CDT)
Message-ID: <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
Date:   Wed, 30 Aug 2023 17:17:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
Content-Language: en-US
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <202308301421.997C4034B5@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> The copy_to_user() call uses @len returned from strlcpy() directly
>>>> without checking its value. This could potentially lead to read
>>>> overflow.
>>>
>>> But can it?  How?
>>>
>>
>> The case I was considering is when the null-terminated hardcoded
>> string @func_table[kb_func] has length @new_len > @len. In this case,
>> strlcpy() will assign @len = @new_len and copy_to_user() would read
>> @new_len from the kmalloc-ed memory of @len. This is the potential
>> read overflow I was referring to. Let me know if I'm mistaken.
> 
> ..it's what I'd call "accidentally correct". i.e. it's using a fragile> anti-pattern, but in this case everything is hard-coded and less than
> 512.
> 
> Regardless, we need to swap for a sane pattern, which you've done. But
> the commit log is misleading, so it needs some more detail. :)
> 
> -Kees

In my opinion strlcpy() is being used correctly here as a defensive
precaution.  If the source string is larger than the destination buffer
it will truncate rather than corrupt kernel memory.  However the
return value of strlcpy() is being misused.  If truncation occurred
the copy_to_user() call will corrupt user memory instead.

I also agree that this is not currently a bug.  It is fragile and it
could break if someone added a very large string to the table.

Why not fix this by avoiding the redundant string copy?  How about
something like this:

ptr = func_table[kb_func] ? : "";
len = strlen(ptr);

if (len >= sizeof(user_kdgkb->kb_string))
	return -ENOSPC;

if (copy_to_user(user_kdgkb->kb_string, ptr, len + 1))
	return -EFAULT;
