Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923A7834C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjHUVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHUVUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:20:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A256C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76dae6f75ddso43106685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692652820; x=1693257620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRnUH0Y/cJ9krwZiEtlKN0GB1/YkkellcYchzKtezu4=;
        b=BaZjqyX2dFCUFHqFfRZTzPmnvFoqNb5X0rn7NZ3hKFilhQ/s+owk8mpWojzte/aQH7
         9QMNYYFJfU5a9rS1ZTp/Fo6MCTQPlxVHMCpnNDbq91GtgGwfeTSLUUI7iLIggxAyq2W+
         BlOYXIRJESm7JR707y2+hCIj0ZmzLlm/4nR1Gs2il2MivrVWlSMEfZQJXqXatATswdbK
         Rhxn/z/eFHLEaHygttvfaJNx4IlXlPMBAhZiaHzONRkgKLOkhX7SsPt7ifttzlabLAAb
         HSvnOCBlMT2LKoLEvu/l41zj71rCD3pXiejA8hVG/pVuqnuap7MNmckeGEQ8H88w8wAB
         mlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652820; x=1693257620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRnUH0Y/cJ9krwZiEtlKN0GB1/YkkellcYchzKtezu4=;
        b=K0Zsoybh4modST9SWzGyFvT8Z9EFuw5M/oaQKqdTfL22iQM0sNDP0MBVwVW86UaWed
         8nZDOipQ5QE8sxfwippTFMVjRnJ078mrki53uW8ggAhfjmpwbISVxBTAFrzCmoRnH31V
         zn5duiq3rfDLn9a3slC5FIBHM0t7z9xYQ5bO1a5ZqxYUAeRNPZiT1440tI2lfzqffReU
         sw1I7KL/pYj535wu6GeVUPiju7QabXOtwVbE2TQMvXzQgP8z7XEvgaCP+mpPkvQ/3KZ3
         /rp1ok53xruFodrOAQ4XhpXwaOVhJmyTQihMjBgAu3MzygVlkXxWS0jwfv8b4u3Lp1So
         odZw==
X-Gm-Message-State: AOJu0YxqLEPILPhG9BwYc76q3ZsD4Fs3Pay8TOWum3/9+uEx/cfziA7p
        Kq6AsDDSMpiGJ51afBV+5sBqCQ==
X-Google-Smtp-Source: AGHT+IE+ONzVYzhjBw6oS/mHY7oaHz4X6cTo0zP2x+u/rlu2t8OLFTRCP9txXsMFV1DOXt1F+slDvw==
X-Received: by 2002:a05:620a:31a7:b0:765:9f15:c324 with SMTP id bi39-20020a05620a31a700b007659f15c324mr9734068qkb.48.1692652820023;
        Mon, 21 Aug 2023 14:20:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a142600b0076c9cc1e107sm1502639qkj.54.2023.08.21.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:20:19 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:20:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mm: page_alloc: fix up block types when merging
 compatible blocks
Message-ID: <20230821212018.GB106501@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
 <20230821183733.106619-5-hannes@cmpxchg.org>
 <F585906E-69BB-40E6-92AB-37D4E82CD381@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F585906E-69BB-40E6-92AB-37D4E82CD381@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:41:44PM -0400, Zi Yan wrote:
> On 21 Aug 2023, at 14:33, Johannes Weiner wrote:
> 
> > The buddy allocator coalesces compatible blocks during freeing, but it
> > doesn't update the types of the subblocks to match. When an allocation
> > later breaks the chunk down again, its pieces will be put on freelists
> > of the wrong type. This encourages incompatible page mixing (ask for
> > one type, get another), and thus long-term fragmentation.
> >
> > Update the subblocks when merging a larger chunk, such that a later
> > expand() will maintain freelist type hygiene.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/page_alloc.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a5e36d186893..6c9f565b2613 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -438,6 +438,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
> >  				page_to_pfn(page), MIGRATETYPE_MASK);
> >  }
> >
> > +static void change_pageblock_range(struct page *pageblock_page,
> > +					int start_order, int migratetype)
> > +{
> > +	int nr_pageblocks = 1 << (start_order - pageblock_order);
> > +
> > +	while (nr_pageblocks--) {
> > +		set_pageblock_migratetype(pageblock_page, migratetype);
> > +		pageblock_page += pageblock_nr_pages;
> > +	}
> > +}
> > +
> 
> Is this code move included by accident?

Ah, yes, my bad.

I used to call change_pageblock_range() at the end of the merge,
before adding the coalesced chunk to the freelist, for which I needed
this further up. Then I changed it to dealing with individual buddies
instead, and forgot to drop this part.

I'll remove it in the next version.
