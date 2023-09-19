Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4357A6AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjISSeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:34:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD859E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:34:02 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ifXsqtgzsBLWLifXsqurP3; Tue, 19 Sep 2023 20:34:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695148440;
        bh=NX2r/u8WzOv2BoVre7uNYRZIJFKowdY5u4O/mbOCuJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WGm7uWVin9r4Wna0PwE4ZIC5PTxl5PjyJx35FAqiQJuAgi4DXA21jaMCcrZVILZ4C
         d8jcJA97sEeTxJBdA/xN0faODkPqyE/iebUfTH5OExfGtekUam6s2U+neQO9kv17Nn
         jAc2jOclTZYgtu/SA6LmJzks2IcqI348DqsDhtSabESh7YVuETU2MIDlBzbF2nqjl/
         lydDI4dOmPfssMNUs3mztSBW5bejhBnGgUBh25yiwpZ6px/kVxkyOa1y8rBTWd/gZP
         yeSF4t+xSNXp8hdN+4S6D46aw9N6qj54mstAHBN3ywzZVC1ez5sJFz5jgVt9pI9fTh
         ysH7iySBrUYgw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Sep 2023 20:34:00 +0200
X-ME-IP: 86.243.2.178
Message-ID: <2931c006-d987-2261-1c39-5c41a4b17f75@wanadoo.fr>
Date:   Tue, 19 Sep 2023 20:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bcachefs: Avoid a potential memory over-allocation in
 bch2_printbuf_make_room()
Content-Language: fr, en-US
To:     Brian Foster <bfoster@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <2e6a82a83d0ddd9ce7f36ea889dd7ffc30f5fbc9.1694853900.git.christophe.jaillet@wanadoo.fr>
 <ZQmfpzxX+qjLtJjm@bfoster>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZQmfpzxX+qjLtJjm@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/09/2023 à 15:18, Brian Foster a écrit :
> On Sat, Sep 16, 2023 at 10:45:23AM +0200, Christophe JAILLET wrote:
>> kmalloc() and co. don't always allocate a power of 2 number of bytes.
>> There are some special handling for 64<n<=96 and 128<n<=192 cases.
>>
> 
> It's not immediately clear to me what you mean by "special handling."
> Taking a quick look at slabinfo, it looks like what you mean is that
> slab rounding is a bit more granular than power of two, particularly in
> these ranges. Is that right? If so, JFYI it would be helpful to describe
> that more explicitly in the commit log.

That's what I tried to do with my 2 phrases.
Sound good and clear to the French speaking man I am :)

Would you mind updating the phrasing yourself?
A trial and error method about wording with a non native English 
speaking person can be somewhat a long and boring experience to me.

All what I could propose, with the help of google translate, is:

"
kmalloc() does not necessarily allocate a number of bytes equal to a 
power of two. There are special cases for sizes between 65 and 96 and 
between 129 and 192. In these cases, 96 and 192 bytes are allocated 
respectively.

So, instead of forcing an allocation always equal to a power of two, it 
may be interesting to use the same rounding rules as kmalloc(). This 
helps avoid over-allocating some memory.

Use kmalloc_size_roundup() instead of roundup_pow_of_two().
"

If this is fine to you I can send a v2 with this wording, otherwise, 
either tweak it to what sounds good to you, or just ignore this patch.

CJ

> 
>> So trust kmalloc() algorithm instead of forcing a power of 2 allocation.
>> This can saves a few bytes of memory and still make use of all the
>> memory allocated.
>>
>> On the other side, it may require an additional realloc() in some cases.
>>
> 
> Well, I feel like this isn't the only place I've seen the power of two
> buffer size realloc algorithm thing, but in thinking about it this seems
> fairly harmless and reasonable for printbufs. FWIW:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   fs/bcachefs/printbuf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
>> index 77bee9060bfe..34527407e950 100644
>> --- a/fs/bcachefs/printbuf.c
>> +++ b/fs/bcachefs/printbuf.c
>> @@ -28,7 +28,7 @@ int bch2_printbuf_make_room(struct printbuf *out, unsigned extra)
>>   	if (out->pos + extra < out->size)
>>   		return 0;
>>   
>> -	new_size = roundup_pow_of_two(out->size + extra);
>> +	new_size = kmalloc_size_roundup(out->size + extra);
>>   
>>   	/*
>>   	 * Note: output buffer must be freeable with kfree(), it's not required
>> -- 
>> 2.34.1
>>
> 
> 

