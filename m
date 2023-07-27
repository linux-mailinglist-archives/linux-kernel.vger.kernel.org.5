Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655A766065
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjG0XuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjG0XuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:50:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78630F9;
        Thu, 27 Jul 2023 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dDKW57DuKsQQ6wWR5XrMKt3UcRI5urTH+VZ5eCSrvyA=; b=kdBy7GEUxIVNyMDS69VXIaBCb5
        7m5vxdRhAto2HIOduUMJ8tjMjBLK0E+NXPYJGQRos9AIKwyXLm9121yGS894LzH3LG1JUNGFb05eO
        0IAr8LNxr/Lk6xzTbzOyQwJV/2tVB9pEUyvHdVP9wCD4z3yf+zwgofRsDAOBfEJGU9GRJbYTZp3Ja
        DpA5pq+NgvmAlbemoMhD2Hfey8/WOXBb4QBMTKco1gOmNAnYgznTRgLAnLApx83+rwAsGbL4kfs3O
        +v5vTSiTle1lbk62tfDGEmmWoBQ+idWD3dlUpZsRzcVAv3J22IGmCzFwNYPKKuiZwvK/wo6lRiu9Z
        Vx4icKvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPAju-007yk0-EE; Thu, 27 Jul 2023 23:49:50 +0000
Date:   Fri, 28 Jul 2023 00:49:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <ZMMCnvc3h7XT/NM2@casper.infradead.org>
References: <20230728091849.7f32259d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728091849.7f32259d@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:18:49AM +1000, Stephen Rothwell wrote:
> diff --cc mm/memory.c
> index ca632b58f792,271982fab2b8..000000000000
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@@ -5392,32 -5597,18 +5597,21 @@@ retry
>   	if (!vma)
>   		goto inval;
>   
> - 	/* Only anonymous and tcp vmas are supported for now */
> - 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
>  -	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
>  -	if (vma_is_anonymous(vma) && !vma->anon_vma)
> --		goto inval;
> --
>   	if (!vma_start_read(vma))
>   		goto inval;
>   
>  +	/*
>  +	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
>  +	 * This check must happen after vma_start_read(); otherwise, a
>  +	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
>  +	 * from its anon_vma.
>  +	 */
> - 	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> - 		goto inval_end_read;
> - 
> - 	/*
> - 	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
> - 	 * it for now and fall back to page fault handling under mmap_lock.
> - 	 */
> - 	if (userfaultfd_armed(vma))
> ++	if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
>  +		goto inval_end_read;
>  +

No, this isn't right.  It should be:

	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
		goto inval_end_read;

I'm not sure about the userfaultfd_armed() clause.  My patch wasn't
intended to affect that.

>   	/* Check since vm_start/vm_end might change before we lock the VMA */
>  -	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
>  -		vma_end_read(vma);
>  -		goto inval;
>  -	}
>  +	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
>  +		goto inval_end_read;
>   
>   	/* Check if the VMA got isolated after we found it */
>   	if (vma->detached) {


