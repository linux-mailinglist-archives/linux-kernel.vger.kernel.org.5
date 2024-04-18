Return-Path: <linux-kernel+bounces-149410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFEC8A90C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DA1F22957
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C98C1F;
	Thu, 18 Apr 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbbiaDg1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A63A1C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404363; cv=none; b=eACwHyTSEoIj6WZCMZCQOXaN0t9O+tT98sWBs3CXQnTr2t8UwUJsA6UTIsaMyHXg9LCcOvdfCIHKGfJgPo6AxUzCAr6iSRTyWg9O2r5aRK08DWUeJiYJC1Ylnqm3rWJMqH4MB7o9gIEqZSvu7LcUn4F7BSjTnD1DnNNcwmOr8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404363; c=relaxed/simple;
	bh=nHiyetDo2B44/flQ6ykxWhoLDh4pvP0US5t0m21RbVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecMrxBL/BdHNkgC791s0tm4L1+BSJavdLlpmVuGedugA4N0rh+e7hpl2nH9RIz4aRH5zTG0QWrz/3C2y5R30+1IjoVebHJ06+E6MalCQP4wce7IZ0OscFVd+ES93slvMCcx4YE/PgLDuyVFTWL85B/YDQ9nfWltLUsUTe25Sih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbbiaDg1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713404360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmFzcHIDhodaRZf7iyyCLecUojTiVoweHmp7N2hAiSg=;
	b=VbbiaDg18u/znvce30ipjDiz87gyIm5wtJUGwKbT5yeJAzPmHNErm+daD5ZMyPJ8PJgBqF
	DEILYqVfTzQYYPq6rBdTZYV9BxAycO9GmNqdu/cxHrxPXWbFXb4NEvU0+afN3pCAi0YTn6
	9bNq0DAvtv2DClZ16woTj2OZMbYbWJI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-zba_676EO_6VktV9a2Ax_g-1; Wed, 17 Apr 2024 21:39:19 -0400
X-MC-Unique: zba_676EO_6VktV9a2Ax_g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69b147e856aso1072796d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713404359; x=1714009159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmFzcHIDhodaRZf7iyyCLecUojTiVoweHmp7N2hAiSg=;
        b=Uq5EehIf97uIUk2XNWQK9oRWM/3h4N1QC8otnFGeXmZJDlKAUBv95EcGszpFVDy9UV
         /1p+/Al2r9laXUxHdkSk4bUy0lQS81Oa96DLJJv1cmMUYO9Hd9rBD4UUJ9vxNzX7Pnfm
         JBe7WiP9ct/hVA7rn7jvNaKCoOOo6+dXUAy/auLmrNCVtAUqOYFnZSAVehKjLvpYoMz9
         sBg06KMUa3HuNLAOsBJ0iGUlMRZn996tUZUdamkiOY6AjgU6yc8JmbH6FnXydgHC92/p
         K7KTX8kX2E2Rj0vTN4cjQc6AZ4xgdUav6BClHPSkd2lswrA0hcF7dNKQpuoe95HB14Im
         2+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW30jnh8pnRk/Z0VEKS78dTIPlQMmpyoI/I2Bnkzzm3UwObmzWZZqoGaWK0RgO+SfgirDXLRxLV/3pNtZz48a5MnPrQsnu3nxViKpFk
X-Gm-Message-State: AOJu0Yxn36HrSO757QDaoLeEQovIBrjBUVtFZYPNUSLbiGPQBcR+SKYi
	bGra+M7weDMnppKnKvkvh4f7kIT21ZIA3q2yCyPSpzpgFc0jlUs8W3ilW+3v5Makq42EYTqx+t4
	tvF46250f7y72CbrzeG2IBEFFCtB8Ngn0kRWKsPcYbBtgphZ7JElej2ugHW2JWw==
X-Received: by 2002:a05:6214:23ce:b0:69b:1c5c:28fb with SMTP id hr14-20020a05621423ce00b0069b1c5c28fbmr1350874qvb.0.1713404358522;
        Wed, 17 Apr 2024 18:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzst+VoT0qxzY7uHN9ZSAXS5GpsjpMHRaQwmEWQAr4SL6aYNGnbRO933Jy1Xs5umEQIbZ1Iw==
X-Received: by 2002:a05:6214:23ce:b0:69b:1c5c:28fb with SMTP id hr14-20020a05621423ce00b0069b1c5c28fbmr1350854qvb.0.1713404357972;
        Wed, 17 Apr 2024 18:39:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cf04a000000b006986c3f3d21sm186936qvl.116.2024.04.17.18.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 18:39:17 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:39:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/3] fixup! mm: always initialise folio->_deferred_list
Message-ID: <ZiB5wwHpJTCSQb3h@x1n>
References: <20240417211836.2742593-1-peterx@redhat.com>
 <20240417211836.2742593-2-peterx@redhat.com>
 <ZiBfX_kvVJQNsWCU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiBfX_kvVJQNsWCU@casper.infradead.org>

On Thu, Apr 18, 2024 at 12:46:39AM +0100, Matthew Wilcox wrote:
> On Wed, Apr 17, 2024 at 05:18:34PM -0400, Peter Xu wrote:
> > Current mm-unstable will hit this when running test_hugetlb_memcg.  This
> > fixes the crash for me.

[1]

> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/memcontrol.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1840ba4c355d..7703ced535a3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7529,6 +7529,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
> >  
> >  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >  	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> > +			!folio_test_hugetlb(folio) &&
> >  			!list_empty(&folio->_deferred_list), folio);
> 
> Hum.  I thought we didn't get here for hugetlb folios.  What
> stacktrace did you get?

A normal hugetlb free path iirc.  You can try the test case, I mentioned
the reproducer [1] above.  It crashes constantly.

> 
> I'm basing it on comments like this:
> 
>                 /* hugetlb has its own memcg */
>                 if (folio_test_hugetlb(folio)) {
>                         if (lruvec) {
>                                 unlock_page_lruvec_irqrestore(lruvec, flags);
>                                 lruvec = NULL;
>                         }
>                         free_huge_folio(folio);
>                         continue;
>                 }

Hugetlb does have its own memcg but I guess now it's even more than that,
see the patch merged months ago:

https://lore.kernel.org/all/20231006184629.155543-4-nphamcs@gmail.com/

Especially:

@@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
 				     pages_per_huge_page(h), folio);
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
+	mem_cgroup_uncharge(folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;

The comment above looks a bit confusing to me, as memcg is not the only
thing special for hugetlb pages.  Explicitly mentioning it there made me
feel like hugetlb can be freed like a normal compound page if memcg is not
a problem, but looks like not yet?

-- 
Peter Xu


