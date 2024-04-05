Return-Path: <linux-kernel+bounces-133372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B989A2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB371C22ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F3171E42;
	Fri,  5 Apr 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UQ3KEG96"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A216FF49
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336202; cv=none; b=ftND6z0zagnWEBwXRjOdq+omhAayY0DyS7UJvVJnR8HQ/9zWBD4tDj0aabwvU6oXT9qGEY1T1jWioz+7YV+FvEN1op/5zzoQGmeq7O3o3Ekzvc0E6/rLsJ+GdhEOGIE6DwBaEo4DCXY3xDs4aN/W66r5ajWPQcSKBFuYx4NYuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336202; c=relaxed/simple;
	bh=iWc/aEafglc63x0I0tFAYAdhaWyxDgZOl9FdWlRCvHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1RepVXrZ0pQc5amMZ9TuHVRWI1A7UbNgLxSDK6P8X/xG8b3BVstiHc3Nz79VY96IAoURVazhDyMn3cOwqff94PfZ0iK1Gj1CTnX3Td/nQVhu7BtHabDAYkLU2mH20sKCAzD9OTXlDFtDl/UpJTZrTjeqlemUzl0bgMEtyHSlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UQ3KEG96; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e89b6daa1fso1528233a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712336198; x=1712940998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohIubACEMqfpFhqHJzOrOyqb7k4hx5l2DO2JszCob+w=;
        b=UQ3KEG96f6vg8nHQXRfpt4Kc8GiPx1Avxs203DzM7Lu+xowolkJfxTd9B7C3FFUaKc
         YYdgivMceiTHaJ2PjwqWEAWOQ1/1m9HV2IOaplV0kxyvqkloXMlwjRLutA962ugM6Hlp
         KQc0Cpy8+ObwPViR/SFD9Jer1UNe0IM38Z3x0qpWRLJmO1tLeK+Ie6o47IZvH5if1x0I
         EbmuQ4E+2pwfc4qtNUUhwI/+/IhUuxUXFSrU8SZeP1q4HmSuL42mLrCK34Af13Q62xkQ
         LqbHYuqVWdLCvMQJe+AICe42GCXFmX6iGSLZj+X+3HmrYQUctB5SFTWTgr2jTvJvrRDt
         A5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336198; x=1712940998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohIubACEMqfpFhqHJzOrOyqb7k4hx5l2DO2JszCob+w=;
        b=PToKCDJrjIFmA+I885of4Y5ePyb6mXe4s6WzvBQPg6Xoh3kaxXGy5qK2frnHu6Uc3J
         CYqq+tTDhKSTAw7IqzSJFFhEX8M7vzPG+Cl+x+ufQlKKOFcOFofAJYyawuXIDQwHdt4J
         TlKuPoiQ/yQZYcJaRFzpP2UAxPlMq87xFOO/OFxJcTF8MNuB6r3BtmXVbOvR0QEVTWpe
         nkmTpq/quev3oxTMBzTeO4FNlLaGe32Rlb3XlI0Xf0LRTTTrcAcloyNDdFyZDw/YN4Pg
         5WcbD4KMtbkFI+9JXJCFAA+Pvwl+Uw1nOG5agoAE+QOtKY2ilH/cMux9q8E5LhKxS7QK
         9Hfg==
X-Forwarded-Encrypted: i=1; AJvYcCVxOa8qxJoknvDpfvp1/NVxgQNzuil0GUHTTJRjrCHVvOH9zawOtLnR6FS9AL8iacHbt+6WOkukDRi7svo2JJSgs4Irm8khmRtB2Jdx
X-Gm-Message-State: AOJu0YznA0ZEMagq3keFs0Redx72ZycV3rXeU6m7RZg2f+8TYPGmITu1
	RN1q48GKZ9EiGay/dpeki6TF7KoNhQWym2A+dMvPlfwMtIOqmITZ7I+pU3j66HI=
X-Google-Smtp-Source: AGHT+IGakITDK1e6MJJdG1G7doVOvxLMhuqD8/82B5UEd6Df7kliKIuuA82zI7ecR+7suaQ9ZP3OEw==
X-Received: by 2002:a05:6830:46:b0:6e6:e639:6f22 with SMTP id d6-20020a056830004600b006e6e6396f22mr1930021otp.21.1712336198014;
        Fri, 05 Apr 2024 09:56:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bdbd])
        by smtp.gmail.com with ESMTPSA id hb14-20020a05622a2b4e00b00430d494c75asm913892qtb.19.2024.04.05.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:56:36 -0700 (PDT)
Date: Fri, 5 Apr 2024 12:56:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
Message-ID: <20240405165632.GA870124@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
 <a97697e0-45b0-4f71-b087-fdc7a1d43c0e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97697e0-45b0-4f71-b087-fdc7a1d43c0e@linux.alibaba.com>

Hi Baolin,

On Fri, Apr 05, 2024 at 08:11:47PM +0800, Baolin Wang wrote:
> On 2024/3/21 02:02, Johannes Weiner wrote:
> > @@ -2127,15 +2165,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> >   				return page;
> >   		}
> >   	}
> > -retry:
> > +
> >   	page = __rmqueue_smallest(zone, order, migratetype);
> >   	if (unlikely(!page)) {
> >   		if (alloc_flags & ALLOC_CMA)
> >   			page = __rmqueue_cma_fallback(zone, order);
> > -
> > -		if (!page && __rmqueue_fallback(zone, order, migratetype,
> > -								alloc_flags))
> > -			goto retry;
> > +		else
> > +			page = __rmqueue_fallback(zone, order, migratetype,
> > +						  alloc_flags);
> 
> (Sorry for chim in late.)
> 
> I have some doubts about the changes here. The original code logic was 
> that if the 'migratetype' type allocation is failed, it would first try 
> CMA page allocation and then attempt to fallback to other migratetype 
> allocations. Now it has been changed so that if CMA allocation fails, it 
> will directly return. This change has caused a regression when I running 
> the thpcompact benchmark, resulting in a significant reduction in the 
> percentage of THPs like below:
> 
> thpcompact Percentage Faults Huge
>                           K6.9-rc2                K6.9-rc2 + this patch
> Percentage huge-1        78.18 (   0.00%)       42.49 ( -45.65%)
> Percentage huge-3        86.70 (   0.00%)       35.13 ( -59.49%)
> Percentage huge-5        90.26 (   0.00%)       52.35 ( -42.00%)
> Percentage huge-7        92.34 (   0.00%)       31.84 ( -65.52%)
> Percentage huge-12       91.18 (   0.00%)       45.85 ( -49.72%)
> Percentage huge-18       89.00 (   0.00%)       29.18 ( -67.22%)
> Percentage huge-24       90.52 (   0.00%)       46.68 ( -48.43%)
> Percentage huge-30       94.44 (   0.00%)       38.35 ( -59.39%)
> Percentage huge-32       93.09 (   0.00%)       39.37 ( -57.70%)

Ouch, sorry about that! I changed that specific part around later
during development and didn't retest with CMA. I'll be sure to
re-enable it again in my config.

> After making the following modifications, the regression is gone.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ce67dc6777fa..a7cfe65e45c1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2139,7 +2139,8 @@ __rmqueue(struct zone *zone, unsigned int order, 
> int migratetype,
>          if (unlikely(!page)) {
>                  if (alloc_flags & ALLOC_CMA)
>                          page = __rmqueue_cma_fallback(zone, order);
> -               else
> +
> +               if (!page)
>                          page = __rmqueue_fallback(zone, order, migratetype,
>                                                    alloc_flags);
>          }
> 
> But I am not sure your original change is intentional? IIUC, we still 
> need try fallbacking even though CMA allocation is failed, please 
> correct me if I misunderstand your code. Thanks.

No, this was accidental. I missed that CMA dependency when changing
things around for the new return type of __rmqueue_fallback(). Your
fix is good: just because the request qualifies for CMA doesn't mean
it will succeed from that region. We need the fallback for those.

Andrew, could you please pick up Baolin's change for this patch?

[baolin.wang@linux.alibaba.com: fix allocation failures with CONFIG_CMA]

Thanks for debugging this and the fix, Baolin.

