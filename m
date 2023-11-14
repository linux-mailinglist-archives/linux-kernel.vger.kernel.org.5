Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3FC7EB923
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjKNWAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjKNWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:00:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44BD3;
        Tue, 14 Nov 2023 14:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BRTuQdIa5HtWbYMOvlhzixWLNqFYsEx/oaqaQAbGh6A=; b=Fp+acjjG/DYcBilWTOxTuPpRaJ
        0a3KrxrqzSUpuIOk0lpBlWe4UekfWIONEbg2gLCbQunukeK+Dae+i0SmNI317r3P+PapKdf68/3iP
        aFj1NmgPHeiR9fU0bcRtSGzoCH/LLfFlekyMbuUd+SDRQ0sBCHBsFSPdhMq4RSHHHAQ1IUEJBcGjV
        WS0Im/GCS64Ciia8zLhJsFg68lA1aqDIYz5YkTrOJuZS42ItxKYFtjv7rTgXIEcL6c2VS1SozIDJu
        T2wlYlY6dL7NniFvobzGzvhvvlReZSXmfTvdsxOtn0WKMsA9w+D8tSxxuzxmNNk3ky/Bauw+jsNLq
        uSujOs/A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r31Sf-00Gt1d-0t;
        Tue, 14 Nov 2023 22:00:45 +0000
Message-ID: <cc6ecb91-3c3a-4ca8-9123-f030f8eee31d@infradead.org>
Date:   Tue, 14 Nov 2023 14:00:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] /proc/sysrq-trigger: accept multiple keys at once
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20231114124152.97010-1-tomas.mudrunka@gmail.com>
 <20231114151252.117575-1-tomas.mudrunka@gmail.com>
 <5da1d0d3-9677-4c9a-8568-d24db389465c@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5da1d0d3-9677-4c9a-8568-d24db389465c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 10:04, Jiri Slaby wrote:
> On 14. 11. 23, 16:12, Tomas Mudrunka wrote:
>> Just for convenience.
>> This way we can do:
>> `echo _reisub > /proc/sysrq-trigger`
>> Instead of:
>> `for i in r e i s u b; do echo "$i" > /proc/sysrq-trigger; done;`
>>
>> This can be very useful when trying to execute sysrq combo remotely
>> or from userspace. When sending keys in multiple separate writes,
>> userspace can be killed before whole combo is completed.
>> Therefore putting all keys in single write is more robust approach.
>>
>> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
>> ---
>> V5 -> V6: Documentation now has notice about undefined behavior
>> V4 -> V5: Added this list of changes
>> V3 -> V4: Bulk is now bool instead of char (and fixed typo)
>> V2 -> V3: Fixed code styling (and introduced typo)
>> V1 -> V2: Bulk mode only activated by underscore now, added docs
>>
>>   Documentation/admin-guide/sysrq.rst | 11 ++++++++++-
>>   drivers/tty/sysrq.c                 | 17 ++++++++++++++---
>>   2 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
>> index 51906e473..e7a82cba7 100644
>> --- a/Documentation/admin-guide/sysrq.rst
>> +++ b/Documentation/admin-guide/sysrq.rst
>> @@ -75,10 +75,19 @@ On other
>>       submit a patch to be included in this section.
>>     On all
>> -    Write a character to /proc/sysrq-trigger.  e.g.::
>> +    Write single character to /proc/sysrq-trigger.
> 
> a single
> 
>> +    Only first character is interpreted, rest of string is ignored.
> 
> the first; the rest of the string
> 
>> +    However it is not reccomended to write any extra characters
> 
> However, <- comma
> recommended
> 
>> +    as the behavior is undefined and might change in the future versions.
>> +    e.g.::
> 
> Even the original was lowercase. But it should be "E.g.::", right -- Greg/Jon?
> 

or Randy?
Yes, you are correct.
All of your recommendations look good.
Thanks.

>>             echo t > /proc/sysrq-trigger
>>   +    Alternatively write multiple keys combo prepended by underscore.
> 
> Alternatively, <- comma
> s/keys/characters/
> an underscore
> 
>> +    All characters are interpreted this way. e.g.::
> 
> This way, all characters are interpreted. (IMO this has a different meaning, but natives would have to tell us.)
> 
>> +
>> +        echo _reisub > /proc/sysrq-trigger
>> +
>>   The :kbd:`<command key>` is case sensitive.
>>     What are the 'command' keys?
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index 6b4a28bcf..ad07bc812 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -1150,16 +1150,27 @@ EXPORT_SYMBOL(unregister_sysrq_key);
>>   #ifdef CONFIG_PROC_FS
>>   /*
>>    * writing 'C' to /proc/sysrq-trigger is like sysrq-C
>> + * If first character in write is underscore, all characters are interpreted.
> 
> If the first character written is
> 
> thanks,

-- 
~Randy
