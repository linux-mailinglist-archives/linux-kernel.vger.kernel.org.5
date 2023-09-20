Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6040C7A728F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjITGIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjITGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:08:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA476CA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:07:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D66331F45B;
        Wed, 20 Sep 2023 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695190073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=se+KZYftOIBUnwMWyj6AIrStZz8EeoGJhUCJe5qxccM=;
        b=i6wTg7u3h8G4w3VCeriFi2y8sONvVPDvRw8npOymVr3S+O2Misb8wuhDIvlZq935VPzqbL
        /lGaopi8TtPP4ZUhrW1/ugQyP3OO8ZB9vfMHzg4pxU5jS1WSKDlMhXbmWrqB7hQdQiNwkM
        rATEZSsx0GH+t0SSjS9t0joWT2UTu04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695190073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=se+KZYftOIBUnwMWyj6AIrStZz8EeoGJhUCJe5qxccM=;
        b=1SZIr55G08CSCrHOvzVZqzG9EJuGpQsUPUnWrQO5aEOQQLp8YMS0PkAvmyPVFeW3Q44v/7
        3S1CaBRembpSejBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1D2E132C7;
        Wed, 20 Sep 2023 06:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJieKjmMCmW0CgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 06:07:53 +0000
Message-ID: <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
Date:   Wed, 20 Sep 2023 08:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
To:     Zi Yan <ziy@nvidia.com>, Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 03:38, Zi Yan wrote:
> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
> 
>> On 09/19/23 16:57, Zi Yan wrote:
>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>
>>>> 	--- a/mm/page_alloc.c
>>>> 	+++ b/mm/page_alloc.c
>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
>>>>  		end = pageblock_end_pfn(pfn) - 1;
>>>>
>>>>  		/* Do not cross zone boundaries */
>>>> 	+#if 0
>>>>  		if (!zone_spans_pfn(zone, start))
>>>> 			start = zone->zone_start_pfn;
>>>> 	+#else
>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>> 	+		start = pfn;
>>>> 	+#endif
>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>> 	 		return false;
>>>> 	I can still trigger warnings.
>>>
>>> OK. One thing to note is that the page type in the warning changed from
>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
>>>
>>
>> Just to be really clear,
>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
>>   path WITHOUT your change.
>>
>> I am guessing the difference here has more to do with the allocation path?
>>
>> I went back and reran focusing on the specific migrate type.
>> Without your patch, and coming from the alloc_contig_range call path,
>> I got two warnings of 'page type is 0, passed migratetype is 1' as above.
>> With your patch I got one 'page type is 0, passed migratetype is 1'
>> warning and one 'page type is 1, passed migratetype is 0' warning.
>>
>> I could be wrong, but I do not think your patch changes things.
> 
> Got it. Thanks for the clarification.
>>
>>>>
>>>> One idea about recreating the issue is that it may have to do with size
>>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tried
>>>> to really stress the allocations by increasing the number of hugetlb
>>>> pages requested and that did not help.  I also noticed that I only seem
>>>> to get two warnings and then they stop, even if I continue to run the
>>>> script.
>>>>
>>>> Zi asked about my config, so it is attached.
>>>
>>> With your config, I still have no luck reproducing the issue. I will keep
>>> trying. Thanks.
>>>
>>
>> Perhaps try running both scripts in parallel?
> 
> Yes. It seems to do the trick.
> 
>> Adjust the number of hugetlb pages allocated to equal 25% of memory?
> 
> I am able to reproduce it with the script below:
> 
> while true; do
>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
>  echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
>  wait
>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>  echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> done
> 
> I will look into the issue.

With migratetypes 0 and 1 and somewhat harder to reproduce scenario (= less
deterministic, more racy) it's possible we now see what I suspected can
happen here:
https://lore.kernel.org/all/37dbd4d0-c125-6694-dec4-6322ae5b6dee@suse.cz/
In that there are places reading the migratetype outside of zone lock.
