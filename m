Return-Path: <linux-kernel+bounces-43454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3184140F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E30F1F21EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55476058;
	Mon, 29 Jan 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g61jrKQR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5A2C6AA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559156; cv=none; b=qkY/SkFMWfP+Vrg6qV67PtF5R5wzW3Ba86ldmPcEcqJxtAp3DHkGFRs3HloROC+uHlCFqsme3KeNcBm/nobUf4RMbWPiUKhUXlBz0ts92aNgItelIkk9f1/1uemw9PLr2YOdBAickr5MlEDLWgnORm90jB2Lgtgr2hF6PQnQQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559156; c=relaxed/simple;
	bh=WCbvnW9dMahO0e4Ry6XopkLNjudSEdxv5YHLtY1umvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a71paujSKX+wD6g+z1/QoiY9tw2CZJl1BRsyo4ZHrVgZo46hweXTn/INzAk9RdnvCnD0GYMzkG8U+O5tSl+R/rZp12C+AZTRuE5YwbFu9phBoCX/hVr7+eHBUp1PnCqBn41J/19g0XLgDxlS3jbRRWutr9aLVN7l4BCBI6xvG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g61jrKQR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706559153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qK9tbpAJWU+jCclBGn+oKppMC1R8LcdvjWspqD2gVlo=;
	b=g61jrKQRBtCyjblZmBlJ93H7meV4eZ1i1/+0gSeyRCl5ZH9DHDhBlKdyVAVNJtHdY5Iowx
	zQwmvfhUtZwaEMJvWY+pkGKl9DNWfIvf6By92Qfm0adVphMdWh9YhHFD3aRT7PCQ2KpVxn
	JghTdhknvWe79IS9g/7xja8Wpk13KmI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-J6DXV2dePT6btmWl161NIw-1; Mon, 29 Jan 2024 15:12:30 -0500
X-MC-Unique: J6DXV2dePT6btmWl161NIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 727D4837224;
	Mon, 29 Jan 2024 20:12:29 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E6433AD4;
	Mon, 29 Jan 2024 20:12:28 +0000 (UTC)
Date: Mon, 29 Jan 2024 15:13:47 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 06/19] writeback: Factor out writeback_finish()
Message-ID: <ZbgG+7QhHGMz/uMJ@bfoster>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085758.2393327-7-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Jan 25, 2024 at 09:57:45AM +0100, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Instead of having a 'done' variable that controls the nested loops,
> have a writeback_finish() that can be returned directly.  This involves
> keeping more things in writeback_control, but it's just moving stuff
> allocated on the stack to being allocated slightly earlier on the stack.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: heavily rebased, reordered and commented struct writeback_control]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/writeback.h |  6 +++
>  mm/page-writeback.c       | 79 ++++++++++++++++++++-------------------
>  2 files changed, 47 insertions(+), 38 deletions(-)
> 
..
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 437745a511c634..fcd90a176d806c 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
..
> @@ -2419,22 +2437,23 @@ int write_cache_pages(struct address_space *mapping,
>  	} else {
>  		tag = PAGECACHE_TAG_DIRTY;
>  	}
> -	done_index = index;
> -	while (!done && (index <= end)) {
> +
> +	folio_batch_init(&wbc->fbatch);
> +	wbc->err = 0;
> +
> +	while (index <= end) {
>  		int i;
>  
>  		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> -				tag, &fbatch);
> +				tag, &wbc->fbatch);
>  
>  		if (nr_folios == 0)
>  			break;
>  
>  		for (i = 0; i < nr_folios; i++) {
> -			struct folio *folio = fbatch.folios[i];
> +			struct folio *folio = wbc->fbatch.folios[i];
>  			unsigned long nr;
>  
> -			done_index = folio->index;
> -
>  			folio_lock(folio);
>  
>  			/*
> @@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
>  				folio_unlock(folio);
>  				error = 0;
>  			}
> +		

JFYI: whitespace damage on the above line.

> +			if (error && !wbc->err)
> +				wbc->err = error;
>  

Also what happened to the return of the above "first error encountered"
for the WB_SYNC_ALL case? Is that not needed for some reason (and so the
comment just below might require an update)?

Brian

>  			/*
>  			 * For integrity sync  we have to keep going until we
> @@ -2496,38 +2518,19 @@ int write_cache_pages(struct address_space *mapping,
>  			 * off and media errors won't choke writeout for the
>  			 * entire file.
>  			 */
> -			if (error && !ret)
> -				ret = error;
> -			if (wbc->sync_mode == WB_SYNC_NONE) {
> -				if (ret || wbc->nr_to_write <= 0) {
> -					done_index = folio->index + nr;
> -					done = 1;
> -					break;
> -				}
> +			if (wbc->sync_mode == WB_SYNC_NONE &&
> +			    (wbc->err || wbc->nr_to_write <= 0)) {
> +				writeback_finish(mapping, wbc,
> +						folio->index + nr);
> +				return error;
>  			}
>  		}
> -		folio_batch_release(&fbatch);
> +		folio_batch_release(&wbc->fbatch);
>  		cond_resched();
>  	}
>  
> -	/*
> -	 * For range cyclic writeback we need to remember where we stopped so
> -	 * that we can continue there next time we are called.  If  we hit the
> -	 * last page and there is more work to be done, wrap back to the start
> -	 * of the file.
> -	 *
> -	 * For non-cyclic writeback we always start looking up at the beginning
> -	 * of the file if we are called again, which can only happen due to
> -	 * -ENOMEM from the file system.
> -	 */
> -	if (wbc->range_cyclic) {
> -		if (done)
> -			mapping->writeback_index = done_index;
> -		else
> -			mapping->writeback_index = 0;
> -	}
> -
> -	return ret;
> +	writeback_finish(mapping, wbc, 0);
> +	return 0;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -- 
> 2.39.2
> 
> 


