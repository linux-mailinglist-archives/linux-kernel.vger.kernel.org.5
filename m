Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8078E5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjHaFcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbjHaFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:29 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76DEE43;
        Wed, 30 Aug 2023 22:32:21 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so436105a12.3;
        Wed, 30 Aug 2023 22:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693459940; x=1694064740;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWVU2emzKXoGwZDt9vJyrPNkV5rPwoUzokQnAVFFcdk=;
        b=j/bxe/J/h8og76bfu49y9jrnVxfMLzgjdmby1m6K+Jzv9QZK0FPvIvkOKK7f18FLjM
         t9N7ax0mHh9SNEKie23PBH66iRP2aW7VFokvt/3p5Qp+gsIFwVW0GbGCS4safwqQ6OP5
         T1yDwiw3I4yVvjE7Ct51r7GOAHp6u8wAMOH5XMv/Gd1ECMXwlDyVT0H82oeSzaj5Erci
         4plkq9+6FggccJZOzSr5rjYbkRxmFTq8/x5JIXQmSDcWSmJSiCSu3bhvQWpeRFCu178J
         ymltEeeSz+Q+OiNIdv5Swz9AqaRWegmi22AzAzhwcYyjB6kenXSaLMfnptwd6Pa9EnMr
         bKHA==
X-Gm-Message-State: AOJu0Yw2Ww5UDh5RKba6SA4K8S0sCjFBVohgvoIcMZ5VCH/mP7nWRPz+
        LA38xudAN8+r2eVGl/OcTtwG7Q1wNn4o7g==
X-Google-Smtp-Source: AGHT+IEerIrNC2i8KrayM6DoN13BvZp7dqB6SxVq5E6w4q5Lp4zn5tDbHt5z7LIRVBCL0epVyoHTGw==
X-Received: by 2002:a17:906:310d:b0:9a5:b875:d76 with SMTP id 13-20020a170906310d00b009a5b8750d76mr3157954ejx.28.1693459939968;
        Wed, 30 Aug 2023 22:32:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b009930308425csm339562ejr.31.2023.08.30.22.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 22:32:19 -0700 (PDT)
Message-ID: <c44d1f9f-90e0-3e83-8394-854feb449539@kernel.org>
Date:   Thu, 31 Aug 2023 07:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
In-Reply-To: <202308301421.997C4034B5@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 08. 23, 23:28, Kees Cook wrote:
> On Wed, Aug 30, 2023 at 03:25:54PM -0400, Azeem Shaikh wrote:
>> On Wed, Aug 30, 2023 at 1:57 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
>>>> strlcpy() reads the entire source buffer first.
>>>> This read may exceed the destination size limit if
>>>> a source string is not NUL-terminated [1].
>>>
>>> But that's not the case here, right?  So your "potential read overflow"
>>> isn't relevant here.
>>>
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
> First there is:
> 
> ssize_t len = sizeof(user_kdgkb->kb_string);
> 
> "struct user_kdgkb" is UAPI (therefore unlikely to change), and kb_string
> is 512:
> 
> struct kbsentry {
>          unsigned char kb_func;
>          unsigned char kb_string[512];
> };
> 
> Then we do:
> 
>                  len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> 
> This is the anti-pattern (take the length of the _source_) we need to
> remove.

But len is the length of kbs, i.e. the destination. Or what am I missing?

                 kbs = kmalloc(len, GFP_KERNEL);
                 len = strlcpy(kbs, func_table[kb_func] ? : "", len);

> However, func_table[] is made up of either %NUL-terminated
> strings:
> 
> char func_buf[] = {
>          '\033', '[', '[', 'A', 0,
>          '\033', '[', '[', 'B', 0,
> ...
> char *func_table[MAX_NR_FUNC] = {
>          func_buf + 0,
>          func_buf + 5,
> ...
> 
> Or a NULL address itself. The ?: operator handles the NULL case, so
> "len" can only ever be 0 through the longest string in func_buf. So it's
> what I'd call "accidentally correct". i.e. it's using a fragile
> anti-pattern, but in this case everything is hard-coded and less than
> 512.
> 
> Regardless, we need to swap for a sane pattern, which you've done. But
> the commit log is misleading, so it needs some more detail. :)

I am still missing what is wrong in the above code with strlcpy(). The 
dest is deliberately made as long as the source, so the returned len is 
never less then the passed len. No checking needed IMO. Perhaps, we 
might switch to strcpy()?

FWIW I introduced this in commit 82e61c3909db5. So if it needs fixing, 
the patch deserves a Fixes: 82e61c3909db5 tag.

thanks,
-- 
js
suse labs

