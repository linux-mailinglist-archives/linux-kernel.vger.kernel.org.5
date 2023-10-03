Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6377B7260
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbjJCUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjJCUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:12:42 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5C9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:12:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 37B5360173;
        Tue,  3 Oct 2023 22:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696363954; bh=3amMaq29morJQRBmN64tOmRcaqhD62RaH1xvx+cR1e0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b7wJT2lQaOePEHifofzZV4vw7ihkuu9WfSDvCIfMaTAHwyaAP1yZvEuJQYwrdr0EV
         S4324oclvyMrQ+HMr8g8wDXW++BMOymZoTu4Cj865Q6J3tsEGCZKtnDWoaWwd5CzE6
         AQkUAaFiqWKtabtiZFaS4oZ2OiPdcF5FAGMUemqAw0vTMtdSa3Vg+nWDx4WslAX23q
         Jc8/wv6nrpugFYDP7OWVyoMk/jroBqZvRVLoOpMbAAVZNu7OkCLiA0CqBWeOUyVVXJ
         ZFM2Qq7ycfzYYrEWOd4kAVFs0dNS3Q4pb05oKlTF9rY8DD0CUklHxe2vNawHT1snjH
         HCtfeVIa9XxnA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hTZSUGvs4RVA; Tue,  3 Oct 2023 22:12:32 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-17.adsl.net.t-com.hr [78.3.40.17])
        by domac.alu.hr (Postfix) with ESMTPSA id 9D98F6016E;
        Tue,  3 Oct 2023 22:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696363952; bh=3amMaq29morJQRBmN64tOmRcaqhD62RaH1xvx+cR1e0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mOLmS3EywplYJ7mYRpFqCh3womwAu8/RGYwouma+OP4IVjJIss7Ug5n1WqZDjQuIB
         pEcBfv6PDsWEXF2/7eku6xfABnSgkxxeVPXbVrxxgv+w7j1xcu2deIOI+dax/tGbSr
         IYkfGO8jrv4SB9oaf3Gg1/M6cnLOim98N+dUnDPqmRJlKIPLRzvB0V8bGo0qakCLpK
         Sq/pEtpa6hdgKamh4K+1ZHai7LPLIH37twRn6JZZ/YWDZKftKzaV+UpbWpASuYdWJ8
         ucnagf4Pwfbb1rJxF6c+TRoPeB8PW4D/UE8im0n8o+fwphF/N+rT28DG+o6UNb1/gl
         flLSLXJhycC5g==
Message-ID: <d7ff01cf-6681-4470-a6d1-d7d1081edef1@alu.unizg.hr>
Date:   Tue, 3 Oct 2023 22:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
 <ZPs8+sLv5oaubrKj@casper.infradead.org>
 <22a42774-ebe1-081a-c9b9-e11f4d74bc3a@alu.unizg.hr>
 <ZQhkfIqwcuTrKxK+@casper.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZQhkfIqwcuTrKxK+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 16:53, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 02:15:05PM +0200, Mirsad Todorovac wrote:
>>> This is what I'm currently running with, and it doesn't trigger.
>>> I'd expect it to if we were going to hit the KCSAN bug.
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 0c5be12f9336..d22e8798c326 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>>>    	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
>>>    out:
>>> +	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
>>>    	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>>>    	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
>>>    		__free_pages(page, order);
>>
>> Hi,
>>
>> Caught another instance of this bug involving folio_batch_move_lru: I don't seem that I can make it
>> happen reliably by the nature of the data racing conditions if I understood them well.
> 
> Were you running with this patch at the time, or was this actually
> vanilla?  The problem is that, if my diagnosis is correct, both of the
> tasks mentioned are victims; we have a prematurely freed page.  While
> btrfs is clearly a user, it may not be btrfs's fault that the
> page was also allocated as an anon page.
> 
> I'm trying to gather more data, and running with this patch will give
> us more -- because it'll dump the entire struct page instead of just
> the page->flags, like KCSAN is currently doing.

As my learning curve adapts, I seem to be more aware of what you are talking about.

I still have to learn to cope with patches, diffs, fixes and pulls all together and
consistent.

Sometimes I feel like in the BORG maturation chamber when I try to learn the Linux kernel,
and I wonder if this is the Author of my story trying to make up "for the years that locust
had eaten". Or is it that I am just losing the plot.

I learn that I was conceited and not respecting the work you guys have done in thirty years
I wasted for one reason or another: objective difficulties and personal weaknesses.

Forgive me this moment of truth.

I certainly feel more motivated to catch the real culprit, rather than just the symptoms.

I will rebuild with your patch again and try to reproduce the problem.

Best regards
Mirsad Todorovac


