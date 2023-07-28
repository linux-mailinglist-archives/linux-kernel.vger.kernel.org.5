Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC076624F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjG1DNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG1DNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:13:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8342686;
        Thu, 27 Jul 2023 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vxH+Ar3Pm3xjODXON89Eu2OP8Ll5EmsHBUYLyH6aHso=; b=TrUoJjZUv7PjKwfiYd4aYJ/CJK
        umPzc4eqwlVu0zGZ9JATn/Zf0zo1ET7jVxj7dflohQoaIgvp91h2IsrhIeNlAaKlrHMdAni0hMCvU
        blVoQ58//jiwJlljYa3gF/7ObUNmlLzY2Qiee3az2gstEpX/NtwsuQZg896Qc/djUiFBr6nPW76db
        4wkLSQlmpoQCm4HCBVyI5+Mnu7c7vrxMz82AFp7LdHzrkvqXV0GBgb+mfHPZ+SKLPocXKI7WNThEZ
        qU6wHXhYhwp4SMZJ+u+GJi+39FsEURm3N5MEq3loNmvnEftCkQb7xK1ASrQwdOWpoeRtDhMkiNy3+
        kX4l0zsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPDv0-0087wb-DO; Fri, 28 Jul 2023 03:13:31 +0000
Date:   Fri, 28 Jul 2023 04:13:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <ZMMyWmyC8EvFIL/G@casper.infradead.org>
References: <20230728091849.7f32259d@canb.auug.org.au>
 <20230728092915.732d4115@canb.auug.org.au>
 <20230728100047.4f9cd375@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728100047.4f9cd375@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 10:00:47AM +1000, Stephen Rothwell wrote:
> I have gone with below.  Again, please check.

LGTM

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
> ++	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
>  +		goto inval_end_read;
>  +
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

If Andrew wants to rebase on Linus' tree, I'll be happy to respin
on top of that.
