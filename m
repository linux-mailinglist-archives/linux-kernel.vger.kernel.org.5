Return-Path: <linux-kernel+bounces-121872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DD88EECA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38FB1F33E66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04814F9FF;
	Wed, 27 Mar 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Dkmp2OPr"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67B137C2A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566076; cv=none; b=Rg5ubYmiLQXsTeM5HGduiZGII6gKvgP4jYUM2xDaC5HVVTlQ4TNHUQYlaxgJ7dP+ur2YfFZ5yVR5a0ESfwUKpCe+wUPK9Iis4U55NtVq8Fj8Tgij/7Yhk8FkXVjSVw04v13Km1qXcLWWPo+gXAkHCB+/iDq+fOsXPaaZwaXjPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566076; c=relaxed/simple;
	bh=0xDg5IGU2fptrvRGCEYpwmMvi+bDQMQ2MpEW+h2oemg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx1egpGFWjSyQ4ty6uKpnN66+l3QTA17q6l29CaC5/TFqSwZzTPdQ9X7VueXnev4AgUkqM462fXcoZgzmYYs76kr3C+OaTXPd6rHE3g/lXfupCnUfrZqcLRriGWA0RlYeAm1XN115Wy/5+KbtaV7mwWvTOsZNePTDn+oysdUhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Dkmp2OPr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42f2d02fbdeso546461cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711566073; x=1712170873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GxQ/m2i2KHb6JEyfIRJnzrg7z0UGo5xSQekII3ANKE=;
        b=Dkmp2OPrfVlMpBownJn590M/pOiTyrJCvBGvNrgQ4CsZTgCpCdfMMpsCBWjSVudNvB
         wptOaFKHye1DAmUY+VLmPuB9riWZmQ3sDY98YQ/MrarGdPRywrpZx9qGJV0MnGaNJFiB
         ZqeNjdSZSWXLvbtTDn/cYsXnkTJlmvGrq+3M0Sk9v3PgyEgKoBO8ILAygyw5EGj1SyH5
         P/WYomzED5rqLYG+G8iQrKbJawJses3HZSYAqSxXk1ZlFsX8kRwVPzdFyVIF9IExJ5+m
         kAz64j2dJWxxwrI7hQWlQFPlYmEmN4p6OryOO1I9TEXjCDd0iqqAzISUTLN5C8yhVpy/
         aisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566073; x=1712170873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GxQ/m2i2KHb6JEyfIRJnzrg7z0UGo5xSQekII3ANKE=;
        b=DFJ+oBCZ2lBVWmZYQKBwEIn8cyCOMWqr8C2lxelyRRTDrgpZ0zreHQ/pxnGyFP0EYA
         szbpOETxbTQpuNLfdMeVharJzalmg+ZYA4hBRXmDT/qT4YqoRriIvK3+9yjYdelMCGui
         ELgg2YkPOD5QZuvHLrvF4SoMUO8PluDAmIQP2UWnWlOLzozg1JTphSIqOp7P5B3ICfsf
         5h14+lZ1jrxXVi/GhwekCpTO6li8QS0mIqkM5IbVwdgKy5LaC0TGxyXDl9q8McjpSGyv
         a2YCfHvcgreZGVuVfv28Zw3vb+zwZ0uLTKQozX/+K02fDrVZqxk/jHMQQlRjwTE+4aP/
         NAOw==
X-Forwarded-Encrypted: i=1; AJvYcCW4peG6jtMcQMQm2dRVAUZYaxc2hhGwbXWELXNDtT0Wa6/+7NKv4YmQQSdM5h3S7SHXuBuHo7zBVzju09TMGGy1SawD7wQ0NNzEMzKp
X-Gm-Message-State: AOJu0Yx44zTYFTIFuFQzQ8K59tFbZa6E6wmHckXVi5/XSsbR75dA2Dfm
	RnURMK51o3s3o2OzR7QKjNDpj0dUzSJNL7/q3TujA6Yru3jhxFIGAtXa29eHLxo=
X-Google-Smtp-Source: AGHT+IEMWc0z3NWlQR8No9ANDoskQvZ+0Bj532IQLCTNjDCCjXJTlv4aoJ+acHAsX68VVMDqZgNiCg==
X-Received: by 2002:a0c:f085:0:b0:690:734e:50c9 with SMTP id g5-20020a0cf085000000b00690734e50c9mr540594qvk.24.1711566073038;
        Wed, 27 Mar 2024 12:01:13 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 2-20020a0562140d6200b0069778761fb4sm154033qvs.73.2024.03.27.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:01:12 -0700 (PDT)
Date: Wed, 27 Mar 2024 15:01:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: page_alloc: batch vmstat updates in expand()
Message-ID: <20240327190111.GC7597@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>

On Wed, Mar 27, 2024 at 09:54:01AM +0100, Vlastimil Babka wrote:
> > @@ -1314,10 +1349,10 @@ static inline void expand(struct zone *zone, struct page *page,
> >  		 * Corresponding page table entries will not be touched,
> >  		 * pages will stay not present in virtual address space
> >  		 */
> > -		if (set_page_guard(zone, &page[size], high, migratetype))
> > +		if (set_page_guard(zone, &page[size], high))
> >  			continue;
> >  
> > -		add_to_free_list(&page[size], zone, high, migratetype);
> > +		add_to_free_list(&page[size], zone, high, migratetype, false);
> 
> This is account_freepages() in the hot loop, what if we instead used
> __add_to_free_list(), sum up nr_pages and called account_freepages() once
> outside of the loop?

How about this on top of the series? Could be folded into
mm-page_alloc-consolidate-free-page-accounting, but for credit and
bisectability (just in case) I think stand-alone makes sense.

---

From 361f5df28183d85c7718fe0b579438d3d58777be Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 27 Mar 2024 12:29:25 -0400
Subject: [PATCH 3/3] mm: page_alloc: batch vmstat updates in expand()

expand() currently updates vmstat for every subpage. This is
unnecessary, since they're all of the same zone and migratetype.

Count added pages locally, then do a single vmstat update.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8987e8869f6d..13fe5c612fbe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1341,6 +1341,7 @@ static inline void expand(struct zone *zone, struct page *page,
 	int low, int high, int migratetype)
 {
 	unsigned long size = 1 << high;
+	unsigned long nr_added = 0;
 
 	while (high > low) {
 		high--;
@@ -1356,9 +1357,11 @@ static inline void expand(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, &page[size], high))
 			continue;
 
-		add_to_free_list(&page[size], zone, high, migratetype, false);
+		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
+		nr_added += size;
 	}
+	account_freepages(zone, nr_added, migratetype);
 }
 
 static void check_new_page_bad(struct page *page)
-- 
2.44.0


