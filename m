Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C927AA9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIVHA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:00:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B41192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:00:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05D031F38A;
        Fri, 22 Sep 2023 07:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695366046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzC90i38T7FBA12FfFnH5tEY2/bPD5iOP/QAXB6HLew=;
        b=mpg0WKy4e1LNUZ0O9RZBFgZG3LRiQOVOUFzGi6eudHfJf9xRXvkb2CNXkH9uupPBn1ZTsD
        WFyB8AqhoFCyBU9CMTq0ETaSWsu8quH+ekQNv3ufMj+tKStXqHrxFSIpSJPA8rB3Y1RFCb
        JoXkpHvkpxw2Uj5oLlWN0v2UyLUIUi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695366046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzC90i38T7FBA12FfFnH5tEY2/bPD5iOP/QAXB6HLew=;
        b=3RPCloKxh+Kl7Ij3jJpGTh4ew9VIdNDrcsxKs54eoWzjDikCQ5hmvisS4iQg7Jr3CW8HDa
        5m5Ed1ULPIj9mvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAF1813478;
        Fri, 22 Sep 2023 07:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y5vCMJ07DWXjEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 22 Sep 2023 07:00:45 +0000
Message-ID: <4662588e-fc8b-1854-57f8-d15e08a3c368@suse.cz>
Date:   Fri, 22 Sep 2023 09:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-10-vbabka@suse.cz> <ZQUE0e4i8HrGUthB@MiWiFi-R3L-srv>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZQUE0e4i8HrGUthB@MiWiFi-R3L-srv>
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

On 9/16/23 03:28, Baoquan He wrote:
> On 09/08/23 at 04:53pm, Vlastimil Babka wrote:
>> @@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
>>  		 * order on systems that appear larger than they are, and too
>>  		 * low order on systems that appear smaller than they are.
>>  		 */
>> -		nr_cpus = num_present_cpus();
>> +		unsigned int nr_cpus = num_present_cpus();
>>  		if (nr_cpus <= 1)
>>  			nr_cpus = nr_cpu_ids;
>>  		min_objects = 4 * (fls(nr_cpus) + 1);
> 
> A minor concern, should we change 'min_objects' to be a local static
> to avoid the "if (!min_objects) {" code block every time?  It's deducing
> the value from nr_cpus, we may not need do the calculation each time.

Maybe, although it's not a hot path. But we should make sure the
num_present_cpus() cannot change. Could it be e.g. low (1) very early when
we bootstrap the initial caches, but then update and at least most of the
caches then reflect the real number of cpus? With a static we would create
everything with 1.

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
> 

