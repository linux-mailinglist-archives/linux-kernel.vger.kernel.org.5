Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6979B0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379211AbjIKWl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbjIKVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:36:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47413A8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:23:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26ef24b8e5aso4011341a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694467313; x=1695072113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nc86XBgLo7ErF3UUFAsbqP+wWaEBHhyzI9ZZPJ5hAA=;
        b=up3zPXxFMLPCksPyGfhPnN/XlIb1wxeKu01LEeRemntsX7hyZwbiukt8fpmDvjhVHx
         ttsPo+59WVS4dG4lbLZXqEfFX0JFmNwOvRUU5b4mbhSLWq6ROFAFv22/rxjPF6QZweuM
         Xm55i6mFTSCsxI/Cd9c2yoL40Q3nRBl+ISHZnz9nKaPu1HJ54M763zzjKiacx6xhdV7I
         O/uZB+IhZxRT+BwfvmdD1xl47o4kw20DQXMTOOvBfB6TiUsGI5IS5BjE1xh5hUHAc746
         hoz7zeLvJ0IbdVCF1akb/p9LdhFbrXTpfdnRbPd/7b7HV+Caf3OdV/Iwj6wXegUwzDtg
         +6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694467313; x=1695072113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nc86XBgLo7ErF3UUFAsbqP+wWaEBHhyzI9ZZPJ5hAA=;
        b=wpa3EF5KGKDH8qYAeWeaDHw3K2Wd93sfn3vNDIe68MtZ74V1H0RWReRUUdjKuQOSr/
         lhWCJKeHbBUyWtPNNlWeo/Dr6oc1n1yY8JnStPOuonXSWM3TGN+vVYpLyOduWuNR/jkM
         /52zMpIkMNNBECIKBfNJF9sn3WT9BeVOzOYwEgUKV0K9572/si9P1ChIu6YhtBroVaPk
         xCU36snPnlHBSZjO30q00G0ghkdis3vbA44573Fq4Gy5E237hJxrpg9F2cLv+A4B3De/
         CanlMPuXMDmxyc+hz1TIHwNSstTSmuDofaf6Onb31Wr0hJe6hS1qSc4rvttSCYIS3vrY
         nZnQ==
X-Gm-Message-State: AOJu0YwiJ+4hEHw2reUBTx9pUjbkUWY0LI2PUg4CGfLBB/ZeYpNRiMiX
        G4rjdO75LVeS1JxguQBmw5jePKEC88oa2dh1j6c=
X-Google-Smtp-Source: AGHT+IEVhNYzRVmY9EXHxYD1+XBVn/eWB+0jTvTfNWuLbix5EQD4YubcV4K6gRAWBbRQLKJN2uxKHQ==
X-Received: by 2002:a0c:ec09:0:b0:64f:5b21:f162 with SMTP id y9-20020a0cec09000000b0064f5b21f162mr10475558qvo.61.1694465272771;
        Mon, 11 Sep 2023 13:47:52 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id u1-20020a0cdd01000000b0063d316af55csm3183284qvk.3.2023.09.11.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:47:52 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:47:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: page_alloc: move free pages when converting
 block during isolation
Message-ID: <20230911204751.GA134811@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-4-hannes@cmpxchg.org>
 <23206152-6E36-453B-B118-6BBAA913441B@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23206152-6E36-453B-B118-6BBAA913441B@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:17:07PM -0400, Zi Yan wrote:
> On 11 Sep 2023, at 15:41, Johannes Weiner wrote:
> 
> > When claiming a block during compaction isolation, move any remaining
> > free pages to the correct freelists as well, instead of stranding them
> > on the wrong list. Otherwise, this encourages incompatible page mixing
> > down the line, and thus long-term fragmentation.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/page_alloc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3db405414174..f6f658c3d394 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2548,9 +2548,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
> >  			 * Only change normal pageblocks (i.e., they can merge
> >  			 * with others)
> >  			 */
> > -			if (migratetype_is_mergeable(mt))
> > +			if (migratetype_is_mergeable(mt)) {
> >  				set_pageblock_migratetype(page,
> >  							  MIGRATE_MOVABLE);
> > +				move_freepages_block(zone, page,
> > +						     MIGRATE_MOVABLE, NULL);
> > +			}
> >  		}
> >  	}
> >
> > -- 
> > 2.42.0
> 
> Is this needed?

Yes, the problem is if we e.g. isolate half a block, then we'll
convert the type of the whole block but strand the half we're not
isolating. This can be a couple of hundred pages on the wrong list.

> And is this correct?
> 
> __isolate_free_page() removes the free page from a free list, but the added
> move_freepages_block() puts the page back to another free list, making
> __isolate_free_page() not do its work. OK. the for loop is going through
> the pages within the pageblock, so move_freepages_block() should be used
> on the rest of the pages on the pageblock.
> 
> So to make this correct, the easies change might be move
> del_page_from_free_list(page, zone, order) below this code chunk.

There is a del_page_from_freelist() just above this diff hunk. That
takes the page off the list and clears its PageBuddy.

move_freepages_block() will then move only the remainder of the block
that's still on the freelist with a mismatched type (move_freepages()
only moves buddies).
