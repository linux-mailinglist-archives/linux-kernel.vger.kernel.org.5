Return-Path: <linux-kernel+bounces-52914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D8849E34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A4E288DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388482E417;
	Mon,  5 Feb 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjI2KZc5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920732C96
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147161; cv=none; b=hHidRJD9Pjwaj4zQOCAfl01Rj9r3r5FGZFZZBi/zVBsMmfFJjaLWA2X0onAGt1hhVG4BacN9YL3sAy3WXq3flCKvva2/GA2ul83LAcApfMC3/WypxhdBeF1nAi9u8nRpF6e6dNyG+0QQsxYohwJq0bkbdAVPH7Z0mwqlyQ1M7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147161; c=relaxed/simple;
	bh=9bNvqhkhk0hgNPvm02QW9K6FFqQQ/OqVqpmrf5HDtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDR4I2iBWqLaPIM+pnxq5WNKwcqneYkiCD0vh6RcYPZHXC3OdOpUiyE/bEei5rw9GZD9xT9h+ZxIQ7DKC1LXshcVQt1mrHe+VSGHRiyEzTo/izwnLTZCGAynaJFOdVrda0EutLXnK7b5WrSUolTX2/5RfpyK67tVgJjA1aUrK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjI2KZc5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707147158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuCUqP9VPCjxaxcw8wTI5AE/DcSSjnaMSJU0S80AB1k=;
	b=LjI2KZc5nuuM0ULqWq3QfRtsh75JpYoew4d92AfWQRE670BKX+lgWsH5ejS77F9EqK9OxW
	tz5wIi9ZuiS3r9bWAJ03MVHCLhfy0mF3hBdHPc5GDjfwCxwZNap11I7XTBC/QUIPixjaAh
	fisqPBg8khN+6W461uKaqWh/KvP+GUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-6iy0J4kcNSKioiYaSvkCBg-1; Mon, 05 Feb 2024 10:32:35 -0500
X-MC-Unique: 6iy0J4kcNSKioiYaSvkCBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE66085A58B;
	Mon,  5 Feb 2024 15:32:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 483A72166B31;
	Mon,  5 Feb 2024 15:32:34 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:33:52 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] writeback: add a writeback iterator
Message-ID: <ZcD/4HNZt1zu2eZF@bfoster>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203071147.862076-13-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, Feb 03, 2024 at 08:11:46AM +0100, Christoph Hellwig wrote:
> Refactor the code left in write_cache_pages into an iterator that the
> file system can call to get the next folio for a writeback operation:
> 
> 	struct folio *folio = NULL;
> 
> 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> 		error = <do per-foli writeback>;
> 	}
> 
> The twist here is that the error value is passed by reference, so that
> the iterator can restore it when breaking out of the loop.
> 
> Handling of the magic AOP_WRITEPAGE_ACTIVATE value stays outside the
> iterator and needs is just kept in the write_cache_pages legacy wrapper.
> in preparation for eventually killing it off.
> 
> Heavily based on a for_each* based iterator from Matthew Wilcox.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/writeback.h |   4 +
>  mm/page-writeback.c       | 192 ++++++++++++++++++++++----------------
>  2 files changed, 118 insertions(+), 78 deletions(-)
> 
..
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3abb053e70580e..5fe4cdb7dbd61a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
..
> @@ -2434,69 +2434,68 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  }
>  
>  /**
..
>   */
> -int write_cache_pages(struct address_space *mapping,
> -		      struct writeback_control *wbc, writepage_t writepage,
> -		      void *data)
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error)
>  {
..
> +	} else {
>  		wbc->nr_to_write -= folio_nr_pages(folio);
>  
> -		if (error == AOP_WRITEPAGE_ACTIVATE) {
> -			folio_unlock(folio);
> -			error = 0;
> -		}
> +		WARN_ON_ONCE(*error > 0);

Why the warning on writeback error here? It looks like new behavior, but
maybe I missed something. Otherwise the factoring LGTM.

Brian

>  
>  		/*
>  		 * For integrity writeback we have to keep going until we have
> @@ -2510,33 +2509,70 @@ int write_cache_pages(struct address_space *mapping,
>  		 * wbc->nr_to_write or encounter the first error.
>  		 */
>  		if (wbc->sync_mode == WB_SYNC_ALL) {
> -			if (error && !ret)
> -				ret = error;
> +			if (*error && !wbc->saved_err)
> +				wbc->saved_err = *error;
>  		} else {
> -			if (error || wbc->nr_to_write <= 0)
> +			if (*error || wbc->nr_to_write <= 0)
>  				goto done;
>  		}
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
> -	folio_batch_release(&wbc->fbatch);
> -	if (wbc->range_cyclic)
> -		mapping->writeback_index = 0;
> -	return ret;
> +	folio = writeback_get_folio(mapping, wbc);
> +	if (!folio) {
> +		/*
> +		 * To avoid deadlocks between range_cyclic writeback and callers
> +		 * that hold pages in PageWriteback to aggregate I/O until
> +		 * the writeback iteration finishes, we do not loop back to the
> +		 * start of the file.  Doing so causes a page lock/page
> +		 * writeback access order inversion - we should only ever lock
> +		 * multiple pages in ascending page->index order, and looping
> +		 * back to the start of the file violates that rule and causes
> +		 * deadlocks.
> +		 */
> +		if (wbc->range_cyclic)
> +			mapping->writeback_index = 0;
> +
> +		/*
> +		 * Return the first error we encountered (if there was any) to
> +		 * the caller.
> +		 */
> +		*error = wbc->saved_err;
> +	}
> +	return folio;
>  
>  done:
>  	folio_batch_release(&wbc->fbatch);
>  	if (wbc->range_cyclic)
>  		mapping->writeback_index = folio->index + folio_nr_pages(folio);
> +	return NULL;
> +}
> +
> +/**
> + * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
> + * @mapping: address space structure to write
> + * @wbc: subtract the number of written pages from *@wbc->nr_to_write
> + * @writepage: function called for each page
> + * @data: data passed to writepage function
> + *
> + * Return: %0 on success, negative error code otherwise
> + *
> + * Note: please use writeback_iter() instead.
> + */
> +int write_cache_pages(struct address_space *mapping,
> +		      struct writeback_control *wbc, writepage_t writepage,
> +		      void *data)
> +{
> +	struct folio *folio = NULL;
> +	int error;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> +		error = writepage(folio, wbc, data);
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;
> +		}
> +	}
> +
>  	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
> -- 
> 2.39.2
> 
> 


