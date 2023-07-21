Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C908E75BCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGUDvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUDvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:51:35 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88520272C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:51:33 -0700 (PDT)
Message-ID: <2488062c-6338-824e-8cbe-fe1bc3add18e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689911491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4i4U/M0fx3Xeq5rYBiHpxK6Qf9rrIRbvjKGXG1sBggU=;
        b=KsADIoJbC2KpaGx/byvlS7rfTn9k3V3au/wDj6i0MvaO75+CAHzc0JBA2k38HTL8KzrQI4
        ++jdPnuuD/tidvL32dEs+n/i7mIPxgBYZ8S01ATfL479QpcOoGW5AgsQcuoZZLzsh9H9ds
        GzHMaxNOy64BgkiZWp66Irfr4P+00G0=
Date:   Fri, 21 Jul 2023 11:51:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] sbitmap: fix hint wrap in the failure case
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, zhouchengming@bytedance.com
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
 <20230720094555.1397621-2-chengming.zhou@linux.dev> <87r0p24d2l.fsf@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <87r0p24d2l.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/21 03:06, Gabriel Krisman Bertazi wrote:
> chengming.zhou@linux.dev writes:
> 
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> ```
>> hint = nr + 1;
>> if (hint >= depth - 1)
>> 	hint = 0;
>> ```
>>
>> Now we wrap the hint to 0 in the failure case, but:
>> 1. hint == depth - 1, is actually an available offset hint, which
>>    we shouldn't wrap hint to 0.
>> 2. In the strict round_robin non-wrap case, we shouldn't wrap at all.
>>
>> ```
>> wrap = wrap && hint;
>> ```
>>
>> We only need to check wrap based on the original hint ( > 0), don't need
>> to recheck the new hint which maybe updated in the failure case.
>> Also delete the mismatched comments by the way.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  lib/sbitmap.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index eff4e42c425a..5ed6c2adf58e 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -144,12 +144,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>>  	while (1) {
>>  		nr = find_next_zero_bit(word, depth, hint);
>>  		if (unlikely(nr >= depth)) {
>> -			/*
>> -			 * We started with an offset, and we didn't reset the
>> -			 * offset to 0 in a failure case, so start from 0 to
>> -			 * exhaust the map.
>> -			 */
>> -			if (hint && wrap) {
>> +			if (wrap) {
>>  				hint = 0;
>>  				continue;
> 
> I think this is wrong.  If you start with an offset in the wrap case and
> the bitmap is completely full this will become busy wait until a bit is
> available. The hint check is what make you break out of the loop early,
> after wrapping, re-walking the entire bitmap and failing to find any
> available space.

Ah yes, you are right, thanks for your explanation. Here we need to check
"hint && wrap" to avoid wrap repeatedly.

Will drop this change in the next version.

> 
>> @@ -160,8 +155,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>>  			break;
>>  
>>  		hint = nr + 1;

Here we overwrite hint, may cause repeated wrap. So I think it's clearer that
we set "wrap" to false after we wrap?

```
if (wrap) {
	wrap = false;
	hint = 0;
	continue;
}
```

Thanks!

>> -		if (hint >= depth - 1)
>> -			hint = 0;
>> +		if (hint >= depth) {
>> +			if (wrap) {
>> +				hint = 0;
>> +				continue;
>> +			}
>> +			return -1;
>> +		}
>>  	}
>>  
>>  	return nr;
> 
