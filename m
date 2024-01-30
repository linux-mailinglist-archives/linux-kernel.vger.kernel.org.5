Return-Path: <linux-kernel+bounces-44729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006C84269B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917151C25098
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7B6DD04;
	Tue, 30 Jan 2024 14:05:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38106D1CF;
	Tue, 30 Jan 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623508; cv=none; b=KNPXDuNCgfSmDheDfKIsvojFThBUf23M0ECYgoOiFk4GuXPeRLEsGpoxr3noJxmjPm6mrhDgIYUwjxAqxDyhwN0qTmco9+MNU+APinI4pcIgH0fWnqvjQJA/Bw1i3/agoiIg9kIPVX9730YauCVIsxtrNu0uQ0BEXJ0hlOLIq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623508; c=relaxed/simple;
	bh=h/0PsSn6SlbvjgMVOf5o+PaEpIM/8IyIENj99pKY8d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKYkhFhTToTe8rldnqFqpRyJIC9zsV2JDxUNIjuCAdD1RWNYzwDwKgLepgOy0uS/un+uBn8GfOJQhC8pUBzigmN+lwosi8QtutOQxPUrqydGqC5aduJaD/CZ2+o0YKGrRViDEKm1OphnzMmifozPAfHqm9Oggru5yMHhbS1wyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C684227A87; Tue, 30 Jan 2024 15:05:00 +0100 (CET)
Date: Tue, 30 Jan 2024 15:04:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 06/19] writeback: Factor out writeback_finish()
Message-ID: <20240130140459.GA31126@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-7-hch@lst.de> <ZbgG+7QhHGMz/uMJ@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbgG+7QhHGMz/uMJ@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 03:13:47PM -0500, Brian Foster wrote:
> > @@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
> >  				folio_unlock(folio);
> >  				error = 0;
> >  			}
> > +		
> 
> JFYI: whitespace damage on the above line.

Thanks, fixed.

> 
> > +			if (error && !wbc->err)
> > +				wbc->err = error;
> >  
> 
> Also what happened to the return of the above "first error encountered"
> for the WB_SYNC_ALL case? Is that not needed for some reason (and so the
> comment just below might require an update)?

No, this got broken during the various rebases (and is fixed again later
in the series).  We need to return wbc->err from write_cache_pages at
this stage, I'll fix it.

