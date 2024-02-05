Return-Path: <linux-kernel+bounces-52909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F88849E29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B81D1F2315D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96136124;
	Mon,  5 Feb 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOJCgcRU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210C33CD4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147061; cv=none; b=OPGL82rVh1DU4mXdgX6AE4cOs/oKeByqqioocuPnyGpftsEVZsT9p92yry+e0C2taShE8zUyAT9DysGbjykbrHFDTRkkSykAitvnmZ/qt38dz73DKbOv4xm5PkpAgcjv7neI9T/VolZa+nMbIYWAr7WMpxZbCYojaU/lsjBiiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147061; c=relaxed/simple;
	bh=AHlRoEB/SRxV3CHCLl9onAt50PBYe29hjbMuK23GTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSaPPzKMVeAmTHMJmjJb23XnhlakFJNVmkKy3jTbkhlIjjdU9cjqJUsNuLQLIS64vmcKsBscfAPWnkDzqaHbPtwj6sOFql6m3aXhcl1tUIZlhaMkkgUvmCYGbQqFzOX80VlgqKDCkFr+iN5tMF9j+bSGBTyVJPKiXROiegUcz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOJCgcRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707147057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JTCo85pVLToNTQneWe34tWLYUrb02reZxLGls+V2O1E=;
	b=OOJCgcRUJ/wMFV95+0RNjiJ20ozHLK7HVNwK8J/4BdytOGZceq6gm9zMMWlU09OangLfNf
	ih0JHaIDQWPAsRY4am+cAU/8+AS9CL9VBWpX9Ew/TL2tQ+jq1RJyf8hWtLR513iUOtovXh
	hisI0G4Ih8OQpUjN+SgUhLRoVK2Y4rY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-4WPZpIx9PXuaNxqotKV2ZA-1; Mon,
 05 Feb 2024 10:30:53 -0500
X-MC-Unique: 4WPZpIx9PXuaNxqotKV2ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E7A3C11C63;
	Mon,  5 Feb 2024 15:30:52 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5336112131D;
	Mon,  5 Feb 2024 15:30:51 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:32:10 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] writeback: rework the loop termination condition
 in write_cache_pages
Message-ID: <ZcD/ekc09A+Z3EHE@bfoster>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203071147.862076-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, Feb 03, 2024 at 08:11:39AM +0100, Christoph Hellwig wrote:
> Rework the way we deal with the cleanup after the writepage call.
> 
> First handle the magic AOP_WRITEPAGE_ACTIVATE separately from real error
> returns to get it out of the way of the actual error handling path.
> 
> The split the handling on intgrity vs non-integrity branches first,
> and return early using a goto for the non-ingegrity early loop condition
> to remove the need for the done and done_index local variables, and for
> assigning the error to ret when we can just return error directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page-writeback.c | 84 ++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 51 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c7c494526bc650..88b2c4c111c01b 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
..
> @@ -2524,14 +2505,15 @@ int write_cache_pages(struct address_space *mapping,
>  	 * of the file if we are called again, which can only happen due to
>  	 * -ENOMEM from the file system.
>  	 */
> -	if (wbc->range_cyclic) {
> -		if (done)
> -			mapping->writeback_index = done_index;
> -		else
> -			mapping->writeback_index = 0;
> -	}
> -
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = 0;
>  	return ret;
> +
> +done:
> +	folio_batch_release(&fbatch);
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = folio->index + folio_nr_pages(folio);

Shouldn't this release the batch after we're done accessing folio? With
that addressed:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> +	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -- 
> 2.39.2
> 
> 


