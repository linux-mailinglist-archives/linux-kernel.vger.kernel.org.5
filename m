Return-Path: <linux-kernel+bounces-135512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7AC89C6ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251D9284F27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202581272C4;
	Mon,  8 Apr 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="P+xK2Ycj"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085A126F07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586231; cv=none; b=OfsAnRFBClvMe/jxPB8eunR8F/ELI6XYEC/iKAISKV/YTu6lVIAnfjxmmrXmnJ0+rpcUm+YjBpY3lLSawdgJqxpeszoMkQVECiiGcNYXY/3UHKlcx1XdCBWoc3K7ruquYgMpa4XZS3MvgAGyOri6uXJwUmgdeD8PnMYsKGHF0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586231; c=relaxed/simple;
	bh=QiwfYNDaU4WTrNIkSJltExXeAK0+rZy9Z02cd6twh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj4Mefz0gTD4sMfYgmRLSjIqMa6n2v12oBVt1/KaWS/tSa0EzCo50u6yEgWz4RurKBRTnN/7Nd7sPCCY0r5viUMS4UqGNutrYqrCizajiFK2H1SodxHTadnw8w0DPbYdMidAMxp+VJ3D/J8eAeO0lZJzsdM8hDd3/qVSiaPxRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=P+xK2Ycj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4347dadc2cfso9557741cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712586226; x=1713191026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEVpmUFr/QX1uwVzNDuqt+LyFWtd2iR3AzPxRhcceaY=;
        b=P+xK2Ycj5X/fEuKKbmD1E7Y/LlSZyBg42w+dBS0WlB5SH2apq5oSxI0KHy1J8qeYkY
         9nN6FhidUYcu8LYQRFvIO2BBznwz32yzhtdoyH33vFpwwLMK5QDBV2nawX33jQnMzHMJ
         MtmRVKJIBLhOE/vxCXijplsVurC3MS4VMrOs8AV9w2aGUyeiN0HsxxerTJi+XaOL3BUt
         hw32iNO0ej2sV6FR1hPjphnBKfAMtHUzOV2nfbtEYBarUqx8Sqa5Xnbbi2REwN0t9EyI
         KKRvnr01kpGbcluCk81jaILn42sYnMTnkzZaQVso2d+e4wpdYHC4wizNL6jiNHP7/eie
         NvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586226; x=1713191026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEVpmUFr/QX1uwVzNDuqt+LyFWtd2iR3AzPxRhcceaY=;
        b=kCFTr4tz1ce5Qzq+38vDXI6WhSLcKDS5tb2eSZjXXK5KiOv+ebYHmWqfS643r7WiVQ
         g+QoM11aDPMrfVXe8bD3f/Pq3ULXIpoADroPD9LtQlbDKSW2nzo93DtE8B4Qmbayw6GR
         3K9M2dPQ8gBa6KgJvEzJaWI/oxR2ayCbX4pfoq7ngHvaUXD2vdYSVVhJDTinSrchpRFU
         7YkhUKFHiysNqlQ/MmF6ZH96BkvGS4HGSVmnoOCp+v5C3uj4IXkcxUzfBaWbNzu4Gxn5
         YJ5ofm50O28BNvwK5Fl4pjL5DKOBpLftrgl6KZD22m7l0PmB4TCFowZaS5Bu9zcVyg3n
         2Ixg==
X-Forwarded-Encrypted: i=1; AJvYcCVNpFxdyARCFPk/fh4V52Aubz+5F96FSxNncyrWzkcUqvlQyhYK3wUOEERGgdbozuO19Hu9mkWIa2hG++iVqRmH//+j+kAZpGVi8BSg
X-Gm-Message-State: AOJu0YwEt3xl9eNxN8gAxvpQP2oW3KAmRKZ1xblV522TUErMrj9BwXg6
	dmJRvVb/WmPdVE+GFIxZQ7JSZvucdEcBF0M1uFcz/8uzomgZqyerlQXUQmmsva0=
X-Google-Smtp-Source: AGHT+IHhi7atJ1Hb/6KDmXmfIEnnCqao5WVXm8HXjj+8zwQJy6VWOp26z68yRrf8ADPs5t31dI2GtQ==
X-Received: by 2002:ac8:738f:0:b0:434:7dbe:9549 with SMTP id t15-20020ac8738f000000b004347dbe9549mr4758485qtp.39.1712586226346;
        Mon, 08 Apr 2024 07:23:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:3ad2])
        by smtp.gmail.com with ESMTPSA id bz7-20020a05622a1e8700b00430a67b3437sm3724002qtb.17.2024.04.08.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:23:45 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:23:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Message-ID: <20240408142340.GA1057805@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>

On Mon, Apr 08, 2024 at 09:38:20AM +0200, Vlastimil Babka wrote:
> On 4/7/24 12:19 PM, Baolin Wang wrote:
> > On 2024/3/21 02:02, Johannes Weiner wrote:
> >>   
> >> +	account_freepages(page, zone, 1 << order, migratetype);
> >> +
> >>   	while (order < MAX_PAGE_ORDER) {
> >> -		if (compaction_capture(capc, page, order, migratetype)) {
> >> -			__mod_zone_freepage_state(zone, -(1 << order),
> >> -								migratetype);
> >> +		int buddy_mt = migratetype;
> >> +
> >> +		if (compaction_capture(capc, page, order, migratetype))
> >>   			return;
> >> -		}
> > 
> > IIUC, if the released page is captured by compaction, then the 
> > statistics for free pages should be correspondingly decreased, 
> > otherwise, there will be a slight regression for my thpcompact benchmark.
> > 
> > thpcompact Percentage Faults Huge
> >                            k6.9-rc2-base        base + patch10 + 2 fixes	
> > Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
> > Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
> > Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
> > Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
> > Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
> > Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
> > Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
> > Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
> > Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
> > 
> > I add below fix based on your fix 2, then the thpcompact Percentage 
> > looks good. How do you think for the fix?
> 
> Yeah another well spotted, thanks. "slight regression" is an understatement,
> this affects not just a "statistics" but very important counter
> NR_FREE_PAGES which IIUC would eventually become larger than reality, make
> the watermark checks false positive and result in depleted reserves etc etc.
> Actually wondering why we're not seeing -next failures already (or maybe I
> just haven't noticed).

Good catch indeed.

Trying to understand why I didn't notice this during testing, and I
think it's because I had order-10 pageblocks in my config. There is
this in compaction_capture():

	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
		return false;

Most compaction is for order-9 THPs on movable blocks, so I didn't get
much capturing in practice in order for that leak to be noticable.

In earlier versions of the patches I had more aggressive capturing,
but also did the accounting in add_page_to/del_page_from_freelist(),
so capturing only steals what's already accounted to be off list.

With the __add/__del and the consolidated account_freepages()
optimization, compaction_capture() needs explicit accounting again.

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 8330c5c2de6b..2facf844ef84 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
> >          while (order < MAX_PAGE_ORDER) {
> >                  int buddy_mt = migratetype;
> > 
> > -               if (compaction_capture(capc, page, order, migratetype))
> > +               if (compaction_capture(capc, page, order, migratetype)) {
> > +                       account_freepages(zone, -(1 << order), migratetype);
> >                          return;
> > +               }
> > 
> >                  buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
> >                  if (!buddy)
> > 
> > With my fix, the THP percentage looks better:
> >                        k6.9-rc2-base          base + patch10 + 2 fixes	+ 
> > my fix
> > Percentage huge-1        78.18 (   0.00%)       82.83 (   5.94%)
> > Percentage huge-3        86.70 (   0.00%)       93.47 (   7.81%)
> > Percentage huge-5        90.26 (   0.00%)       94.73 (   4.95%)
> > Percentage huge-7        92.34 (   0.00%)       95.22 (   3.12%)
> > Percentage huge-12       91.18 (   0.00%)       92.40 (   1.34%)
> > Percentage huge-18       89.00 (   0.00%)       85.39 (  -4.06%)
> > Percentage huge-24       90.52 (   0.00%)       94.70 (   4.61%)
> > Percentage huge-30       94.44 (   0.00%)       97.00 (   2.71%)
> > Percentage huge-32       93.09 (   0.00%)       92.87 (  -0.24%)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

With fixed indentation:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 70f82635f650..96815e3c22f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
 
-		if (compaction_capture(capc, page, order, migratetype))
+		if (compaction_capture(capc, page, order, migratetype)) {
+			account_freepages(zone, -(1 << order), migratetype);
 			return;
+		}
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
 		if (!buddy)

