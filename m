Return-Path: <linux-kernel+bounces-149328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4038A8FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C91F21A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D412126F3F;
	Wed, 17 Apr 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2a30PBp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B085C62
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397604; cv=none; b=gDtkPNyPOD7g4dH9lkaSO2i3psRLdvOBsnrtYeab6dMM/DhWGKt/5G9iTvtvp3YCppdSV6HW1bUOH3Ag5+TQ5Lnl980w4inRWyt6B7xvxw1g0eHblgO4rYvKr3iNqOHBxIqTSUteBRlIgzJt/Gi0KxVkg049vWihmMT8DHIBzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397604; c=relaxed/simple;
	bh=h7rOwEih/ucDsKKl7fIUQANiya1peySLfSOCWewfqbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1Gk9oqWNyvmO9Rg58IFg1xIy8+k03BK+wOA4x7Dk321unsTs7ePU399zpPgPb3E+ZTG1EH7F15VqbHy5VsHANfRyUnXviNPImG38y26gzWCcFYrdllOCt2Nmn9yIaihZqMksKAw+xe5gWt2kDR6QGby/l27peVmlG5UD1H/vQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D2a30PBp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GZu6N4Ih5Zf7eZjzMh2GB1Dsou/X46+ClOTdb83epCo=; b=D2a30PBpa9rj4n1CfscbGjxtKt
	kntJY7McTn7wXqkSxV1gU9iu3JqahGQvflzCONtbu7LFqk4O6+0nEYsoda8wqPCnaCRs06yYYdxrr
	mgVDLovCE/VqS3AWNbx3s0wk8KXks7R8XHR9i0kngDIbYDY89VaUMCmw4WaCKRzahFiCLf+/OUEoe
	WAI4Kq+XnQ2Kf34Ww+Z4umeLlPw2y8djEwoK3RYElHZ3D1j/Ur1h1exCuxkGsyb7MO5Dl9iTYOz7d
	qbtGaaKQI5rmROAMJ3axZ3acB+x7xY29hrY+gTLD7G+aBT5901DbFJqoULdwkRkp3T8IGYvzTc8xM
	tGO96a4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxEz9-000000043XQ-0vlJ;
	Wed, 17 Apr 2024 23:46:39 +0000
Date: Thu, 18 Apr 2024 00:46:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/3] fixup! mm: always initialise folio->_deferred_list
Message-ID: <ZiBfX_kvVJQNsWCU@casper.infradead.org>
References: <20240417211836.2742593-1-peterx@redhat.com>
 <20240417211836.2742593-2-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417211836.2742593-2-peterx@redhat.com>

On Wed, Apr 17, 2024 at 05:18:34PM -0400, Peter Xu wrote:
> Current mm-unstable will hit this when running test_hugetlb_memcg.  This
> fixes the crash for me.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1840ba4c355d..7703ced535a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7529,6 +7529,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
>  
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> +			!folio_test_hugetlb(folio) &&
>  			!list_empty(&folio->_deferred_list), folio);

Hum.  I thought we didn't get here for hugetlb folios.  What
stacktrace did you get?

I'm basing it on comments like this:

                /* hugetlb has its own memcg */
                if (folio_test_hugetlb(folio)) {
                        if (lruvec) {
                                unlock_page_lruvec_irqrestore(lruvec, flags);
                                lruvec = NULL;
                        }
                        free_huge_folio(folio);
                        continue;
                }


