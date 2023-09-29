Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F357B3C97
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjI2W2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2W2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:28:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D078F1;
        Fri, 29 Sep 2023 15:28:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f7400cb74so13250113f8f.2;
        Fri, 29 Sep 2023 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696026524; x=1696631324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojq66DYQP0PdZxJFspae4896e0n9cWPdtlOpAHGIcv4=;
        b=l+PLUQDRgcoSw73UNf1H3vHUqvdEh2nmaLM2ilHr1zgkhscDZX9fKTr+rWYHTv4L6U
         FLQPBbgnRLIqHFxVA4uIvuGDmGpw+9Jatzc38jRzlI7wNRdyU0Hh3ZmF11hlKs47cIck
         6N2301oDMEFMO5FgxCzQ8aXjif+oG84K7NowdgEDE7njru7iCmnEqUWTzzFJAj0V+okG
         0LQpY1+rOdWUpZmXeFymopw12wYJenJEL1RVjrJ7Haw53gd/+6bl5gqt5vGNcn1/6Q8j
         3vRf1zlx2ucTCRv3huEXtmxdrdU2IALFk/tYYcT0wlcXhZ4N6SK2/gnKmKdN1pBd2LAD
         G1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696026524; x=1696631324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojq66DYQP0PdZxJFspae4896e0n9cWPdtlOpAHGIcv4=;
        b=sT2smLrJSYSE8Smof/A9jNJ2a18YZkowoFXqFyxAEfGfr/MQRfnEX3pgagEK2tLCR9
         ucbPa+F3RCMP9y0iPfGk/INQnKGP1+GYNviylMIdjasd76ThcTdHkDOAkVwp6xhTOss1
         SqEBL5Lery4lahW8/qAgMRwVCwTC9F2b3fj4v+85rvsZS3+IQ6wDyY1+G97ldvzCFwIV
         fgbt2Che2IFDq9D1dcCa9wscsWFkG2nrY5AsuSQ0Q6AJX2No9AjvJ4sjpvgPnUHktqnh
         LmYfjxbbHD70mSAuh9hW8RyCYDbuSq1ezdUdlVP2LVAMCnlnOvNtJ+D6Xpsgc+2NC2j1
         YeBg==
X-Gm-Message-State: AOJu0YzYAdC6ertUW6QI9tWRkJO927znzs04boHCQWQbhx2ySH8Rr+BC
        1LYiDD9+EBj6GOcar4VpsCQ=
X-Google-Smtp-Source: AGHT+IE/nRAGW3TuLc3zOGLZH8EsqMxQyvoagnVPerL5NY7ZyUeIJkuWzsTdAHMsxGMYMFkK1OqeBA==
X-Received: by 2002:a5d:4f8a:0:b0:317:5f13:5c2f with SMTP id d10-20020a5d4f8a000000b003175f135c2fmr5059956wru.0.1696026523393;
        Fri, 29 Sep 2023 15:28:43 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm22328639wru.105.2023.09.29.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 15:28:42 -0700 (PDT)
Date:   Fri, 29 Sep 2023 23:28:41 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Message-ID: <843f059f-dd54-4481-b46a-e87e56274db3@lucifer.local>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929183041.2835469-3-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:30:40PM -0400, Liam R. Howlett wrote:
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
>  mm/mmap.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index acb7dea49e23..f9f0a5fe4db4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
>   * dup_anon_vma() - Helper function to duplicate anon_vma
>   * @dst: The destination VMA
>   * @src: The source VMA
> + * @dup: Pointer to the destination VMA when successful.
>   *
>   * Returns: 0 on success.

Being a bit nitpicky/refactory here, but anon_vma_clone() appears to have
two possible return values - 0 for success, and -ENOMEM.

As a result, it's not really gaining us much passing through this value.

It'd be nice if dup_anon_vma() and anon_vma_clone() were therefore updated
to instead return NULL on ENOMEM and the dst otherwise.

Then we could de-clunk this whole code path, and the quite natural fact of
'thing didn't return a pointer therefore had no memory to allocate it' fals
out.

But this isn't exactly an earth-shattering concern :)

>   */
>  static inline int dup_anon_vma(struct vm_area_struct *dst,
> -			       struct vm_area_struct *src)
> +		struct vm_area_struct *src, struct vm_area_struct **dup)
>  {
>  	/*
>  	 * Easily overlooked: when mprotect shifts the boundary, make sure the
> @@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
>  	 * anon pages imported.
>  	 */
>  	if (src->anon_vma && !dst->anon_vma) {
> +		int ret;
> +
>  		vma_assert_write_locked(dst);
>  		dst->anon_vma = src->anon_vma;
> -		return anon_vma_clone(dst, src);
> +		ret = anon_vma_clone(dst, src);
> +		if (ret)
> +			return ret;
> +
> +		*dup = dst;
>  	}
>
>  	return 0;
> @@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff,
>  	       struct vm_area_struct *next)
>  {
> +	struct vm_area_struct *anon_dup = NULL;
>  	bool remove_next = false;
>  	struct vma_prepare vp;
>
> @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  		remove_next = true;
>  		vma_start_write(next);
> -		ret = dup_anon_vma(vma, next);
> +		ret = dup_anon_vma(vma, next, &anon_dup);
>  		if (ret)
>  			return ret;
>  	}
> @@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  nomem:
> +	if (anon_dup)
> +		unlink_anon_vmas(anon_dup);
>  	return -ENOMEM;
>  }
>
> @@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  {
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> +	struct vm_area_struct *anon_dup = NULL;
>  	struct vma_prepare vp;
>  	pgoff_t vma_pgoff;
>  	int err = 0;
> @@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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
> @@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_end = addr;
>  			adjust = next;
>  			adj_start = -(prev->vm_end - addr);
> -			err = dup_anon_vma(next, prev);
> +			err = dup_anon_vma(next, prev, &anon_dup);
>  		} else {
>  			/*
>  			 * Note that cases 3 and 8 are the ONLY ones where prev
> @@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				vma_pgoff = curr->vm_pgoff;
>  				vma_start_write(curr);
>  				remove = curr;
> -				err = dup_anon_vma(next, curr);
> +				err = dup_anon_vma(next, curr, &anon_dup);
>  			}
>  		}
>  	}
> @@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	return res;
>
>  prealloc_fail:
> +	if (anon_dup)
> +		unlink_anon_vmas(anon_dup);
> +
>  anon_vma_fail:
>  	vma_iter_set(vmi, addr);
>  	vma_iter_load(vmi);
> --
> 2.40.1
>

Other than the nice-to-have, this looks good to me:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
