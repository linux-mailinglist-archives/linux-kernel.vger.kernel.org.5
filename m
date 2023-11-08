Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540197E4F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjKHD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjKHD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:26:34 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 19:26:31 PST
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B72A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:26:31 -0800 (PST)
Message-ID: <b87ff5e2-156f-4bf8-9001-9cfbb79871ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699413415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJayWB9Gx8SRyr0qvwZO08eAjm1AFxboWshwi5jryBE=;
        b=k7si3DRAlTYR76IlM8Foxg/xOS7CSJNt6iPTDW8Hr1YB/CpE28GHALleNHLXLSaTnjjTMe
        6e+SDy3sB9MSrfbcaVaewXnQ2YMDx4acuMcVDX0EyjOybQNBrjD1h4yMfHMUUuRuL+QLsk
        W8JirEu/utOEjmdzW0Pg2gYK3SWNZuI=
Date:   Wed, 8 Nov 2023 06:16:52 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, zhouxianrong <zhouxianrong@huawei.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
 <20231108024924.GG11577@google.com>
Content-Language: en-US
In-Reply-To: <20231108024924.GG11577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 05:49, Sergey Senozhatsky wrote:
> On (23/11/06 22:55), Vasily Averin wrote:
>>
>> 'element' and 'handle' are union in struct zram_table_entry.
>>
>> Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
> 
> Sorry, what exactly does it fix?

It removes unneeded call of zram_get_element() and unneeded variable 'value'.
zram_get_element() == zram_get_handle(), they both access the same field of the same struct zram_table_entry,
no need to read it 2nd time. 
'value' variable is not required, 'handle' can be used instead.

I hope this explain why element/handle union should be removed: it confuses reviewers.

> [..]
>> @@ -1318,12 +1318,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>>  
>>  	handle = zram_get_handle(zram, index);
>>  	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
>> -		unsigned long value;
>>  		void *mem;
>>  
>> -		value = handle ? zram_get_element(zram, index) : 0;
>>  		mem = kmap_atomic(page);
>> -		zram_fill_page(mem, PAGE_SIZE, value);
>> +		zram_fill_page(mem, PAGE_SIZE, handle);
>>  		kunmap_atomic(mem);
>>  		return 0;
>>  	}

