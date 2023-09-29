Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B869C7B2FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjI2KIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjI2KH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:07:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E0199;
        Fri, 29 Sep 2023 03:07:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 385091F390;
        Fri, 29 Sep 2023 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695982074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP27RjshjL1KIEOKtQj2rsOmdqwjCeXDZ2XS9nnjPxk=;
        b=jgC4hodI36kBtyUgQ90FUnGcpwVkK+BYwH3LsdSL3wTjWCN4U0gN0fHoWpwjUuiwE8rcCN
        B7aQAnIn2MzJZZyMvrGiYLLSMbtQCGi4lLZCeEredW+cfLz9MmBkcQmiMCrgCZ7idj7ADn
        wkrtJbsl1rsi1aQeb4i1wo5cwMLac0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695982074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP27RjshjL1KIEOKtQj2rsOmdqwjCeXDZ2XS9nnjPxk=;
        b=quDPbF5KwxD1lPn4oS1Y0e6lyTlb4+GsLzJQXWhcybTZ8V+JiKd++t2An1D55TPYKezVX3
        TJulFFAUnydJkaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 119B31390A;
        Fri, 29 Sep 2023 10:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iVZ9A/qhFmWKHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Sep 2023 10:07:54 +0000
Message-ID: <437896e6-c54e-4c5a-f1af-46d91ea6f155@suse.cz>
Date:   Fri, 29 Sep 2023 12:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] mmap: Fix error paths with dup_anon_vma()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-3-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230927160746.1928098-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 18:07, Liam R. Howlett wrote:
> When the calling function fails after the dup_anon_vma(), the
> duplication of the anon_vma is not being undone.  Add the necessary
> unlink_anon_vma() call to the error paths that are missing them.
> 
> This issue showed up during inspection of the error path in vma_merge()
> for an unrelated vma iterator issue.
> 
> Users may experience increased memory usage, which may be problematic as
> the failure would likely be caused by a low memory situation.
> 
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b5bc4ca9bdc4..2f0ee489db8a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -587,7 +587,7 @@ static inline void vma_complete(struct vma_prepare *vp,
>   * Returns: 0 on success.
>   */
>  static inline int dup_anon_vma(struct vm_area_struct *dst,
> -			       struct vm_area_struct *src)
> +		struct vm_area_struct *src, struct vm_area_struct **dup)
>  {
>  	/*
>  	 * Easily overlooked: when mprotect shifts the boundary, make sure the
> @@ -597,6 +597,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
>  	if (src->anon_vma && !dst->anon_vma) {
>  		vma_assert_write_locked(dst);
>  		dst->anon_vma = src->anon_vma;
> +		*dup = dst;
>  		return anon_vma_clone(dst, src);

So the code is simpler that way and seems current callers are fine, but
shouldn't we rather only assign *dup if the clone succeeds?

>  	}
>  
> @@ -624,6 +625,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff,
>  	       struct vm_area_struct *next)
>  {
> +	struct vm_area_struct *anon_dup = NULL;
>  	bool remove_next = false;
>  	struct vma_prepare vp;
>  
> @@ -633,7 +635,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  		remove_next = true;
>  		vma_start_write(next);
> -		ret = dup_anon_vma(vma, next);
> +		ret = dup_anon_vma(vma, next, &anon_dup);
>  		if (ret)
>  			return ret;
>  	}
> @@ -661,6 +663,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>  
>  nomem:
> +	if (anon_dup)
> +		unlink_anon_vmas(anon_dup);
>  	return -ENOMEM;
>  }
>  
> @@ -860,6 +864,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  {
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> +	struct vm_area_struct *anon_dup = NULL;
>  	struct vma_prepare vp;
>  	pgoff_t vma_pgoff;
>  	int err = 0;
> @@ -927,18 +932,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		vma_start_write(next);
>  		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
> -		err = dup_anon_vma(prev, next);
> +		err = dup_anon_vma(prev, next, &anon_dup);
>  		if (curr) {				/* case 6 */
>  			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
>  			if (!next->anon_vma)
> -				err = dup_anon_vma(prev, curr);
> +				err = dup_anon_vma(prev, curr, &anon_dup);
>  		}
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
>  			vma_start_write(curr);
> -			err = dup_anon_vma(prev, curr);
> +			err = dup_anon_vma(prev, curr, &anon_dup);
>  			if (end == curr->vm_end) {	/* case 7 */
>  				remove = curr;
>  			} else {			/* case 5 */
> @@ -954,7 +959,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_end = addr;
>  			adjust = next;
>  			adj_start = -(prev->vm_end - addr);
> -			err = dup_anon_vma(next, prev);
> +			err = dup_anon_vma(next, prev, &anon_dup);
>  		} else {
>  			/*
>  			 * Note that cases 3 and 8 are the ONLY ones where prev
> @@ -1018,6 +1023,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	return res;
>  
>  prealloc_fail:
> +	if (anon_dup)
> +		unlink_anon_vmas(anon_dup);
> +
>  anon_vma_fail:
>  	if (merge_prev)
>  		vma_next(vmi);

