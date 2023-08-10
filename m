Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F991777593
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjHJKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjHJKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:16:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034362133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E10621867;
        Thu, 10 Aug 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691662585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHufn1qzvhw+lYkS+8BVJIOJlgyOqsBjGf2jcyrbwrs=;
        b=idSfT6UJ/DcmWXG8oZq/71L1nXeNfpAVfhHNiY7LbwkZZVT8kkQW9wmo5431H/oyo6qFLj
        bb52AEvkisR7ZFFS9yKvGdMDvwf7uoqksxuT1tVhTWnY0LuLRfynKyRemkOFSFN3wHxyO6
        Oy/bbH9+0Dn0YlzqqYOgxQcClFO6eg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691662585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHufn1qzvhw+lYkS+8BVJIOJlgyOqsBjGf2jcyrbwrs=;
        b=ESg8ETSzCdzouowDLKb3Kl2h7ooB6/JyLlMiu9opacpM2cCQlvlaDuF6CyBLo96qWB0G61
        5Yd2vkF6tvQyOsCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E91B138E0;
        Thu, 10 Aug 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y/5TGvm41GTYFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 10:16:25 +0000
Message-ID: <79deae0c-eeef-2370-9d8a-b2746389d38c@suse.cz>
Date:   Thu, 10 Aug 2023 12:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized in
 set_track_prepare()
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-3-xiaolei.wang@windriver.com>
 <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
In-Reply-To: <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 12:03, Vlastimil Babka wrote:
> On 8/10/23 09:47, Xiaolei Wang wrote:
>> The kmemleak_late_init() is defined as a late_initcall. The current
>> implementation of set_track_prepare() depends on the kmemleak init.
>> That also means there is no call trace for the memory leak which object
>> is created before the kmemleak_late_init().
> 
> So if I understand correctly, we have the following sequence of events durin
> boot
> 
> ...
> A: stack_depot is initialized
> ...
> B: kmemleak is initialized
> ...
> 
> before this patchset, we can miss allocations before B, aftewards only
> before A (which can't be helped), so we now have between A and B.
> 
> That's nice, but it's weird that can record kmemleak when
> !kmemleak_initialized. Why can't it be initialized sooner in that case?

Looking closer, I think what you want could be achieved by kmemleak_init()
setting a variable that is checked in kmemleak_initialized() instead of the
kmemleak_initialized that's set too late.

I think this should work because:
- I assume kmemleak can't record anything before kmemleak_init()
- stack depot early init is requested one way or the other
- mm_core_init() calls stack_depot_early_init() before kmemleak_init()

But I also wonder how kmemleak can even reach set_track_prepare() before
kmemleak_init(), maybe that's the issue?

>> In a previous patch, we have fixed a bug in stack_depot_save() so that
>> it can be invoked even before stack depot is initialized. So there is
>> no reason to check the kmemleak_initialized in set_track_prepare().
>> So delete the kmemleak_initialized judgment in set_track_prepare()
>> 
>> unreferenced object 0xc674ca80 (size 64):
>>   comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
>>   hex dump (first 32 bytes):
>>     80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
>>     00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........
>> 
>> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>  mm/kmemleak.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index a2d34226e3c8..c9f2f816db19 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -610,8 +610,6 @@ static noinline depot_stack_handle_t set_track_prepare(void)
>>  	unsigned long entries[MAX_TRACE];
>>  	unsigned int nr_entries;
>>  
>> -	if (!kmemleak_initialized)
>> -		return 0;
>>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>>  	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>>  
> 

