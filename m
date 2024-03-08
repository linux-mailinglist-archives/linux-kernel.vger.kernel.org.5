Return-Path: <linux-kernel+bounces-96512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90151875D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FEFFB21A19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919E2E62B;
	Fri,  8 Mar 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4CRU/Hk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B721CFB2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873813; cv=none; b=seXkI+W0bvCkAvYnQ1btB+NyBI2ylVJF/x6RZNyYEJM3DDaXvVRLfVUPRJFQYYSj8+DNUMKNySUUUwhLPmSbGiZRhtsZzWxlgSvWKiEMbWrzyWUbhotxtnZnclOVwzEde8JAkHxMuOHTxap+RThJdfnBNRmdARipye5szC7qO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873813; c=relaxed/simple;
	bh=3wClNudqM5whTwW4VLZGzH3ML+XgAjUTBLrIe1VPYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBXOqQYMx24FYDIfbzlnpI8m7XYLx9ROFCcJksZpORxpcc3qgDdj7Eysq3NgE4XrAEEPddsIdGm3zJzpFgnBkPbZupIDGrB6W1Y3SyNiymeYvrFGNDaiedWo6MrLwSZcHULtZ1wyWFUmUUV7uAfG/1PE5zRt983O6l5UW5QErds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4CRU/Hk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FpAzxbK4c61fYlxUcROxFoZVfcD/2ddhJfA1Sk/q7Y8=; b=T4CRU/HkppN1YdmOI1o79jRpwo
	8lkIaoPUIavYephzeW+DqvejzhfiF5EF43G7i1t+h2z6ka+Lc96wTIyzWCa1CAPous7m/tXQ5J9lq
	BrjbbugCuMC+/GkVcdo3JQVAKYK1PNFdvf2rEWumSzjWTXa3cS+vY7wQpUok92Jbq2iiEbJSoKg6J
	UeJL2RBHTm2cPMzZOA+rUA6JqjFN42qIoG//W0xDFuc9pc4pzrpxNsbLEBg43dOwHIS+DPR3WI1wB
	6abFKCRW0cO9s63i+/7r9pGbf0ihv/z8l3hnYmhcYFQzbtGGza9hraeK4VitikeroWg3L75ENcxUg
	0bqU2JqA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riSHm-0000000Akts-1dMG;
	Fri, 08 Mar 2024 04:56:46 +0000
Date: Fri, 8 Mar 2024 04:56:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lipeifeng@oppo.com
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
	osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/2] reclaim contended folios asynchronously instead
 of promoting them
Message-ID: <ZeqajmATLj5gm6Bv@casper.infradead.org>
References: <20240308031126.750-1-lipeifeng@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308031126.750-1-lipeifeng@oppo.com>

On Fri, Mar 08, 2024 at 11:11:24AM +0800, lipeifeng@oppo.com wrote:
> Commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")
> prevents the reclaim path from becoming stuck on the rmap lock. However,
> it reinserts those folios at the head of the LRU during shrink_folio_list,
> even if those folios are very cold.

This seems like a lot of new code.  Did you consider something simpler
like this?

Also, this is Minchan's patch you're complaining about.  Add him to the
cc.

+++ b/mm/vmscan.c
@@ -817,6 +817,7 @@ enum folio_references {
        FOLIOREF_RECLAIM,
        FOLIOREF_RECLAIM_CLEAN,
        FOLIOREF_KEEP,
+       FOLIOREF_RESCAN,
        FOLIOREF_ACTIVATE,
 };

@@ -837,9 +838,9 @@ static enum folio_references folio_check_references(struct folio *folio,
        if (vm_flags & VM_LOCKED)
                return FOLIOREF_ACTIVATE;

-       /* rmap lock contention: rotate */
+       /* rmap lock contention: keep at the tail */
        if (referenced_ptes == -1)
-               return FOLIOREF_KEEP;
+               return FOLIOREF_RESCAN;

        if (referenced_ptes) {
                /*
@@ -1164,6 +1165,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
                case FOLIOREF_ACTIVATE:
                        goto activate_locked;
                case FOLIOREF_KEEP:
+               case FOLIOREF_RESCAN:
                        stat->nr_ref_keep += nr_pages;
                        goto keep_locked;
                case FOLIOREF_RECLAIM:
@@ -1446,7 +1448,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 keep_locked:
                folio_unlock(folio);
 keep:
-               list_add(&folio->lru, &ret_folios);
+               if (references == FOLIOREF_RESCAN)
+                       list_add(&folio->lru, &rescan_folios);
+               else
+                       list_add(&folio->lru, &ret_folios);
                VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
                                folio_test_unevictable(folio), folio);
        }


