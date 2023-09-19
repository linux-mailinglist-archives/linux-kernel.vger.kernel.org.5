Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF47D7A6A92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjISSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjISSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:18:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EC99
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:18:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ifJBqJadip9IzifJBqxwF4; Tue, 19 Sep 2023 20:18:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695147529;
        bh=sQOOjOR6EK78uepakJco6y634UwxpbcVIJU4ZkM1xMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QwWwTSgW9XqXCIQeKkJ5J1hU5ZUS5GDgXWDm1+RaipTzsuwDOcG1YxKsVLx1/W5Ox
         bvpuYzc8chfQE92kLzbn2OlZIBRsIKZ4dS7fBE7VZD5LvisJ3lF2hJ+XbxVXm4FK1d
         JO0Lcr0FRwngg6lSzrj39DtkM9lrd3n2cY/NvawhplfhY+RrtCIGq2zOuHA6dI8Lj1
         IS/XZJfQyUsviAP47NrPWKM24Ox5whJGvjXvOjFhMb44p0AvqH89tVNAMglxq6xSRN
         1hAvsnBNr3qFhmOK1XMa6/WjqJ84zIKEZCeAWtOkL/0Q0eHtQxDzuntUL29B1F0idD
         3NgdXGiFWu3KA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Sep 2023 20:18:49 +0200
X-ME-IP: 86.243.2.178
Message-ID: <490d4bac-3c0f-32f7-6bbf-4bf9418729fc@wanadoo.fr>
Date:   Tue, 19 Sep 2023 20:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bcachefs: Avoid a potential useless over memory
 allocation in bch2_prt_vprintf()
To:     Brian Foster <bfoster@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <0f40108bed3e084057223bdbe32c4b37f8500ff3.1694845203.git.christophe.jaillet@wanadoo.fr>
 <ZQmfWbIgPM0Oo8Jg@bfoster>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZQmfWbIgPM0Oo8Jg@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/09/2023 à 15:17, Brian Foster a écrit :
> On Sat, Sep 16, 2023 at 08:20:24AM +0200, Christophe JAILLET wrote:
>> printbuf_remaining() returns the number of characters we can print to the
>> output buffer - i.e. excluding the terminating null.
>>
>> vsnprintf() takes the size of the buffer, including the trailing null
>> space.
>> It is truncated if the returned value is greater than or equal to the size
>> of the buffer.
>>
>> Knowing all that, buffer sizes and overflow checks can be fixed in order
>> to potentially avoid a useless memory over-allocation.
>>
> 
> For whatever reason I had a hard time parsing this last sentence.  Do
> you mean to say there's an off by one here that leads to an unnecessary
> overallocation?

An off-by-two in fact, IIUC.
But yes, that's my point.

We consider that the string is truncated when it may not be (len+1 vs 
len) and we under-estimate the available space (printbuf_remaining() vs 
printbuf_remaining()+1 or printbuf_remaining_size())

> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Un-tested
>> ---
>>   fs/bcachefs/printbuf.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
>> index de41f9a14492..77bee9060bfe 100644
>> --- a/fs/bcachefs/printbuf.c
>> +++ b/fs/bcachefs/printbuf.c
>> @@ -54,8 +54,9 @@ void bch2_prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
>>   		va_list args2;
>>   
>>   		va_copy(args2, args);
>> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args2);
>> -	} while (len + 1 >= printbuf_remaining(out) &&
>> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out) + 1,
>> +				fmt, args2);
>> +	} while (len >= printbuf_remaining(out) + 1 &&
>>   		 !bch2_printbuf_make_room(out, len + 1));
> 
> It's amazing how simple arithmetic can make my eyes cross at times. :) I
> think I follow the fix after reading the commit log a couple times, but
> could we use printbuf_remaining_size() appropriately in these places
> that want to check actual buffer size (i.e. including terminating null)
> instead of doing the manual size fixup?

Sure, it would be much better.
I had not seen this function.

CJ

> 
> Brian
> 
>>   
>>   	len = min_t(size_t, len,
>> @@ -70,9 +71,10 @@ void bch2_prt_printf(struct printbuf *out, const char *fmt, ...)
>>   
>>   	do {
>>   		va_start(args, fmt);
>> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args);
>> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out) + 1,
>> +				fmt, args);
>>   		va_end(args);
>> -	} while (len + 1 >= printbuf_remaining(out) &&
>> +	} while (len >= printbuf_remaining(out) + 1 &&
>>   		 !bch2_printbuf_make_room(out, len + 1));
>>   
>>   	len = min_t(size_t, len,
>> -- 
>> 2.34.1
>>
> 
> 

