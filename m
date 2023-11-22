Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AB7F479A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbjKVNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbjKVNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:19:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F410C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:19:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 912B81F8D9;
        Wed, 22 Nov 2023 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700659182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLqBv8oF126IhYb29Z2maZ8qb7QVe0h4mTUAUg7saLc=;
        b=NP/rQh8YBKnlXzFFA/HrqfhFr/vyxOHYpqShCuD7AMAcpZMFZlBxaUgy1fBtWhav5dDeVz
        37OiN3XopmxbDkV3zf6bHlvk982B08UzInPwPXfNuxhawgmamXS0tB8BA06Ot3dy4U/SNR
        LfMX7Xy34rJgNeIyoEAqxGoz8Fi716I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700659182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLqBv8oF126IhYb29Z2maZ8qb7QVe0h4mTUAUg7saLc=;
        b=tBbLkN5/JtT2iqFRXGGH2h+AzWw7GVuOtWz1BfEEZYaDt7oLq82JEQdjk7PENY91j8fF6K
        UdVMMyLe4bqBnACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6211A13467;
        Wed, 22 Nov 2023 13:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B5QiF+7/XWXhZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Nov 2023 13:19:42 +0000
Message-ID: <42867716-5d3d-0252-5fd2-0f8b62498523@suse.cz>
Date:   Wed, 22 Nov 2023 14:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
 <b62a6eee-6823-47e0-a18a-964b60d247cd@linux.dev>
 <4ebc67be-8286-17e9-da33-225ed75509a6@suse.cz>
 <2af8c92f-0de8-4528-af43-6c6e8c1ebdf3@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2af8c92f-0de8-4528-af43-6c6e8c1ebdf3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_TWELVE(0.00)[13];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com,infradead.org];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 12:54, Chengming Zhou wrote:
> On 2023/11/22 19:40, Vlastimil Babka wrote:
>> On 11/22/23 12:35, Chengming Zhou wrote:
>>> On 2023/11/22 17:37, Vlastimil Babka wrote:
>>>> On 11/20/23 19:49, Mark Brown wrote:
>>>>> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>>>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>>
>>>>>> Now we will freeze slabs when moving them out of node partial list to
>>>>>> cpu partial list, this method needs two cmpxchg_double operations:
>>>>>>
>>>>>> 1. freeze slab (acquire_slab()) under the node list_lock
>>>>>> 2. get_freelist() when pick used in ___slab_alloc()
>>>>>
>>>>> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
>>>>> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
>>>>> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
>>>>> introduced the issue.  I've included the full bisect log below.
>>>>>
>>>>> When we see problems we see RCU stalls while logging in, for example:
>>>>
>>>> Can you try this, please?
>>>>
>>>
>>> Great! I manually disabled __CMPXCHG_DOUBLE to reproduce the problem,
>>> and this patch can solve the machine hang problem.
>>>
>>> BTW, I also did the performance testcase on the machine with 128 CPUs.
>>>
>>> stress-ng --rawpkt 128 --rawpkt-ops 100000000
>>>
>>> base    patched
>>> 2.22s   2.35s
>>> 2.21s   3.14s
>>> 2.19s   4.75s
>>>
>>> Found this atomic version performance numbers are not stable.
>> 
>> That's weirdly too bad. Is that measured also with __CMPXCHG_DOUBLE
>> disabled, or just the patch? The PG_workingset flag change should be
> 
> The performance test is just the patch.
> 
>> uncontended as we are doing it under list_lock, and with __CMPXCHG_DOUBLE
>> there should be no interfering PG_locked interference.
>> 
> 
> Yes, I don't know. Maybe it's related with my kernel config, making the
> atomic operation much expensive? Will look again..

I doubt it can explain going from 2.19s to 4.75s, must have been some
interference on the machine?

> And I also tested the atomic-optional version like below, found the
> performance numbers are much stable.

This gets rather ugly and fragile so I'd maybe rather go back to the
__unused field approach :/

> diff --git a/mm/slub.c b/mm/slub.c
> index a307d319e82c..e11d34d51a14 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -531,7 +531,7 @@ static __always_inline void slab_unlock(struct slab *slab)
>         struct page *page = slab_page(slab);
> 
>         VM_BUG_ON_PAGE(PageTail(page), page);
> -       __bit_spin_unlock(PG_locked, &page->flags);
> +       bit_spin_unlock(PG_locked, &page->flags);
>  }
> 
>  static inline bool
> @@ -2136,12 +2136,18 @@ static inline bool slab_test_node_partial(const struct slab *slab)
> 
>  static inline void slab_set_node_partial(struct slab *slab)
>  {
> -       __set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +       if (slab->slab_cache->flags & __CMPXCHG_DOUBLE)
> +               __set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +       else
> +               set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
>  }
> 
>  static inline void slab_clear_node_partial(struct slab *slab)
>  {
> -       __clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +       if (slab->slab_cache->flags & __CMPXCHG_DOUBLE)
> +               __clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +       else
> +               clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
>  }

