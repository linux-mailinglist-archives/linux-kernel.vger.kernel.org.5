Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE47A6193
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjISLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:44:36 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565B2E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:44:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1337D60173;
        Tue, 19 Sep 2023 13:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1695123867; bh=R4zE8eMPjuUOaCwfRsjqIdOLLocNdjk0b1Esnw4mmJw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ttKmYOTJgHktlhgxKta2KcZh9iJjhVSjpzLtxh8EukggzFpxluS3QIGxlCCuT47ds
         6RILjdZmc1qg4v3TOEtSYacMv1jCJrQ5tWlFTlKhO1YsrsHaeojjZpCKnUF6HtgDly
         FSYQHDMHrslEW3z5XIIYWKFlZhNEgXdW7Wkc0cUyiLJ/MAezxwr4eAyvzsrZGXWte4
         wKEwNvT0ZRxjHvuEYBabbs9Oa2lHicp0Z/YVxHGkdo9OZwq5a1epjhRc0oNviliZoJ
         TjJTvWN3ppVikygvpnT7FALboJyD8OYxIfKTVN9RZVPWFzHzMB/K7zhCSC6AQriaYf
         NQcWHXgaGLJ9A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0StH1V1M6SlU; Tue, 19 Sep 2023 13:44:24 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:847a:a5b8:fda0:5de5] (unknown [IPv6:2001:b68:2:2600:847a:a5b8:fda0:5de5])
        by domac.alu.hr (Postfix) with ESMTPSA id B351360157;
        Tue, 19 Sep 2023 13:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695123864; bh=R4zE8eMPjuUOaCwfRsjqIdOLLocNdjk0b1Esnw4mmJw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=djvULSYtqp+qfPMTus3D0NCsJubztH9dXVR0Z7tnEuXgeurWiIfCFO5TtNaAxHQaM
         iuwmMmoTV8Wn0/OgiRXDR04hgpnxVmxI8zxJiglXuF61QbleHIBK6wfFZs8b9T4aku
         1es9Jd4x0DPUlvyp2FhjXlUq9fI+tc+C67HyytP3FDRzXvkPMPvtS4WPceO0dYBdh1
         584LPdCawzpxGCSFGkjToxw0TjsFoDWhpqqaQCDrIX4h7p9KuQKhrI90LIi2vhbQUO
         zHOTYUR3XLBxv6UVz0nZ+UDW9KwpIsxFYyMw1dexe17Q/lnArYDg3ARchPa+tp8dRh
         PK40T2ZOfzELA==
Message-ID: <5716ec93-e6c6-4286-ad7d-9fe6faa68c7e@alu.unizg.hr>
Date:   Tue, 19 Sep 2023 13:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <ZQhkfIqwcuTrKxK+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2023 4:53 PM, Matthew Wilcox wrote:

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
>> Hi,
>>
>> Caught another instance of this bug involving folio_batch_move_lru: I don't seem that I can make it
>> happen reliably by the nature of the data racing conditions if I understood them well.
> Were you running with this patch at the time, or was this actually
> vanilla?  The problem is that, if my diagnosis is correct, both of the
> tasks mentioned are victims; we have a prematurely freed page.  While
> btrfs is clearly a user, it may not be btrfs's fault that the
> page was also allocated as an anon page.
>
> I'm trying to gather more data, and running with this patch will give
> us more -- because it'll dump the entire struct page instead of just
> the page->flags, like KCSAN is currently doing.

Hi, Mr. Matthew,

Yes, I am using "vanilla with your VM_BUG_ON_PAGE()" patch all the time, 
as it seems non-disruptive and I am hoping to catch this spurious page 
alloc.

Best regards, Mirsad Todorovac

