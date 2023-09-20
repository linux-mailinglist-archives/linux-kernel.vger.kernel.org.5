Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA927A72E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjITGiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjITGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:38:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF349E8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:38:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 069761F45B;
        Wed, 20 Sep 2023 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695191886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YezYBQ1zDqyBKiujkdR1sa0QaGIAFcnQoX6o2DR4Zfk=;
        b=mO+y89IKVJp2Ve0tZI8BE8fc6PzPRMHzP43J3bNj6Tk6byaIS6a8MVAmTIBxIKdxRSUHK7
        E3Ci/ykK7jqJ8PTuvJ+z6p5f/caPXhAfiPbGkEHbxnPJ3B9Oq+mXkZxXuOhcLUPGJhxffw
        8Vvn4chmVeDeDQX3XQcrSXk2ZdHI/pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695191886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YezYBQ1zDqyBKiujkdR1sa0QaGIAFcnQoX6o2DR4Zfk=;
        b=AGZq26ZMKrknwaS6Ii6+YpktlkH8CeK0QOrcOM8u+OzfH5syy9HPPboVgsXbdua07sGepI
        yjAmZ3vi4jWX+qDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBB331333E;
        Wed, 20 Sep 2023 06:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1o0BMU2TCmUWGQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 06:38:05 +0000
Message-ID: <9f0ac6a5-7b13-7ce0-ead3-03746a31040e@suse.cz>
Date:   Wed, 20 Sep 2023 08:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mm/slub: simplify the last resort slab order
 calculation
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
 <20230908145302.30320-7-vbabka@suse.cz> <ZQlUKJXKYYY5fxL4@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZQlUKJXKYYY5fxL4@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 09:56, Feng Tang wrote:
> Hi Vlastimil,
> 
> On Fri, Sep 08, 2023 at 10:53:04PM +0800, Vlastimil Babka wrote:
>> If calculate_order() can't fit even a single large object within
>> slub_max_order, it will try using the smallest necessary order that may
>> exceed slub_max_order but not MAX_ORDER.
>> 
>> Currently this is done with a call to calc_slab_order() which is
>> unecessary. We can simply use get_order(size). No functional change.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index f7940048138c..c6e694cb17b9 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4193,7 +4193,7 @@ static inline int calculate_order(unsigned int size)
>>  	/*
>>  	 * Doh this slab cannot be placed using slub_max_order.
>>  	 */
>> -	order = calc_slab_order(size, 1, MAX_ORDER, 1);
>> +	order = get_order(size);
> 
> 
> This patchset is a nice cleanup, and my previous test all looked fine. 
> And one 'slub_min_order' setup reminded by Christopher [1] doesn't
> work as not taking affect with this 1/4 patch.

Hmm I see. Well the trick should keep working if you pass both
slab_min_order=9 slab_max_order=9 ? Maybe Christopher actually does that,
but didn't type it fully in the mail.

> The root cause seems to be, in current kernel, the 'slub_max_order'
> is not ajusted  accordingly with 'slub_min_order', so there is case
> that 'slub_min_order' is bigger than the default 'slub_max_order' (3).
> 
> And it could be fixed by the below patch 
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1c91f72c7239..dbe950783105 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4702,6 +4702,9 @@ static int __init setup_slub_min_order(char *str)
>  {
>  	get_option(&str, (int *)&slub_min_order);
>  
> +	if (slub_min_order > slub_max_order)
> +		slub_max_order = slub_min_order;
> +
>  	return 1;
>  }

Sounds like a good idea. Would also do analogous thing in setup_slub_max_order.

> Though the formal fix may also need to cover case like this kind of
> crazy setting "slub_min_order=6 slub_max_order=5" 

Doing both should cover even this, and AFAICS how param processing works the
last one passed would "win" so it would set min=max=5 in that case. That's
probably the most sane way we can handle such scenarios.

Want to set a full patch or should I finalize it? I would put it as a new
1/5 before the rest. Thanks!

> [1]. https://lore.kernel.org/lkml/21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com/
> 
> Thanks,
> Feng
> 
>>  	if (order <= MAX_ORDER)
>>  		return order;
>>  	return -ENOSYS;
>> -- 
>> 2.42.0
>> 
>> 

