Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778657AA98E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIVGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:55:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D0102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:55:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D647321C47;
        Fri, 22 Sep 2023 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695365727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1UXkIX7PgB9a+J0veY2Drx28CRiXF/v4BDQq2G9vDY=;
        b=ks8tfM2/+BomuV8RcvIe/Ay38m9ZdkBwdHui++JtBxgfdkW0JViPTsA7Z4SRs6Wdkqp5+k
        7E65RV7En0sr6SPG6RZl1adkp+qfDKIByDutAivXLBFE97HwETUhCSdE3V5Wl0694DxA/I
        EkWVe+0BRVoUu0ISWNcyUu09b2ozUSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695365727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1UXkIX7PgB9a+J0veY2Drx28CRiXF/v4BDQq2G9vDY=;
        b=Xh0TFS/ebPdUHJUOI9aYVIZO0vbCwA8PqqC9P3wmyPtbIBjYiUX/jheFptxcWPalHUsBpe
        /IAvAjSO/lAcJ+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD49E13478;
        Fri, 22 Sep 2023 06:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5AWrKV86DWU5DwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 22 Sep 2023 06:55:27 +0000
Message-ID: <210044a1-1f07-b579-bdf5-3f9ac8fbdc8c@suse.cz>
Date:   Fri, 22 Sep 2023 08:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-10-vbabka@suse.cz> <ZQr1SwNeNA+nTpzW@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZQr1SwNeNA+nTpzW@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 15:36, Feng Tang wrote:
> On Fri, Sep 08, 2023 at 10:53:07PM +0800, Vlastimil Babka wrote:
>> After the previous cleanups, we can now move some code from
>> calc_slab_order() to calculate_order() so it's executed just once, and
>> do some more cleanups.
>> 
>> - move the min_order and MAX_OBJS_PER_PAGE evaluation to
>>   calc_slab_order().
> 
> Nit: here is to 'move ... to calculate_order()'?

Oops, right, fixed.

> I tried this patch series with normal boot on a desktop and one 2
> socket server: patch 2/4 doesn't change order of any slab, and patch
> 3/4 does make the slab order of big objects more consistent.
> 
> Thanks for making the code much cleaner! And for the whole series, 
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks! Applied.

> 
>> - change calc_slab_order() parameter min_objects to min_order
>> 
>> Also make MAX_OBJS_PER_PAGE check more robust by considering also
>> min_objects in addition to slub_min_order. Otherwise this is not a
>> functional change.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index f04eb029d85a..1c91f72c7239 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4110,17 +4110,12 @@ static unsigned int slub_min_objects;
>>   * the smallest order which will fit the object.
>>   */
>>  static inline unsigned int calc_slab_order(unsigned int size,
>> -		unsigned int min_objects, unsigned int max_order,
>> +		unsigned int min_order, unsigned int max_order,
>>  		unsigned int fract_leftover)
>>  {
>> -	unsigned int min_order = slub_min_order;
>>  	unsigned int order;
>>  
>> -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
>> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
>> -
>> -	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
>> -			order <= max_order; order++) {
>> +	for (order = min_order; order <= max_order; order++) {
>>  
>>  		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
>>  		unsigned int rem;
>> @@ -4139,7 +4134,7 @@ static inline int calculate_order(unsigned int size)
>>  	unsigned int order;
>>  	unsigned int min_objects;
>>  	unsigned int max_objects;
>> -	unsigned int nr_cpus;
>> +	unsigned int min_order;
>>  
>>  	min_objects = slub_min_objects;
>>  	if (!min_objects) {
>> @@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
>>  		 * order on systems that appear larger than they are, and too
>>  		 * low order on systems that appear smaller than they are.
>>  		 */
>> -		nr_cpus = num_present_cpus();
>> +		unsigned int nr_cpus = num_present_cpus();
>>  		if (nr_cpus <= 1)
>>  			nr_cpus = nr_cpu_ids;
>>  		min_objects = 4 * (fls(nr_cpus) + 1);
>> @@ -4160,6 +4155,10 @@ static inline int calculate_order(unsigned int size)
>>  	max_objects = order_objects(slub_max_order, size);
>>  	min_objects = min(min_objects, max_objects);
>>  
>> +	min_order = max(slub_min_order, (unsigned int)get_order(min_objects * size));
>> +	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
>> +		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
>> +
>>  	/*
>>  	 * Attempt to find best configuration for a slab. This works by first
>>  	 * attempting to generate a layout with the best possible configuration and
>> @@ -4176,7 +4175,7 @@ static inline int calculate_order(unsigned int size)
>>  	 * long as at least single object fits within slub_max_order.
>>  	 */
>>  	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
>> -		order = calc_slab_order(size, min_objects, slub_max_order,
>> +		order = calc_slab_order(size, min_order, slub_max_order,
>>  					fraction);
>>  		if (order <= slub_max_order)
>>  			return order;
>> -- 
>> 2.42.0
>> 
>> 

