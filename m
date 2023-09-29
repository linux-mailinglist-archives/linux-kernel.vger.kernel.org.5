Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D207B2F91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjI2JwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjI2JwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:52:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F8195;
        Fri, 29 Sep 2023 02:52:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3768D1F390;
        Fri, 29 Sep 2023 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695981139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMsbfT1iiLhFJ5psMInzAT4e3IKJNDrYEthOLA4QNSg=;
        b=iZMe9PNqSNqDN3zSXu4MrqLTDaM7SqOWPzC08rCOaeEPRJgrQdkF23t78ewCO/+mcq55ks
        tVSiWGfdhD+76CYgKzCmsoI7dZZjaV5U3KW3AIvcrWeBQPn1oBNE+nFoczytB2tNV7z1Jx
        gdQ3kEabRbYS/Atu10H9/zvZzy9j670=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695981139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMsbfT1iiLhFJ5psMInzAT4e3IKJNDrYEthOLA4QNSg=;
        b=ZD4JJm3tY1+IR60rXfQV2pYyXFKLAo6biPwYRbaYhWylrlC8pJ1G6Xwam5mhpxEcQEC6o5
        A0gOv02lW1BL0ABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1471D1390A;
        Fri, 29 Sep 2023 09:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XLluBFOeFmVYFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Sep 2023 09:52:19 +0000
Message-ID: <1c8488e1-1776-f21e-bafd-3892f0894392@suse.cz>
Date:   Fri, 29 Sep 2023 11:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230927160746.1928098-2-Liam.Howlett@oracle.com>
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
> When merging of the previous VMA fails after the vma iterator has been
> moved to the previous entry, the vma iterator must be advanced to ensure
> the caller takes the correct action on the next vma iterator event.  Fix
> this by adding a vma_next() call to the error path.
> 
> Users may experience higher CPU usage, most likely in very low memory
> situations.

Maybe we could say explicitly that before this fix, vma_merge will be called
twice on the same vma, which to the best of our knowledge does not cause
anything worse than some wasted cycles because vma == prev, but it's fragile?

> Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b56a7f0c9f85..b5bc4ca9bdc4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -968,14 +968,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				vma_pgoff = curr->vm_pgoff;
>  				vma_start_write(curr);
>  				remove = curr;
> -				err = dup_anon_vma(next, curr);
> +				err = dup_anon_vma(next, curr, &anon_dup);
>  			}
>  		}
>  	}
>  
>  	/* Error in anon_vma clone. */
>  	if (err)
> -		return NULL;
> +		goto anon_vma_fail;
>  
>  	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
>  		vma_expanded = true;

The vma_iter_config() actions done in this part are something we don't need
to undo?

> @@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	}
>  
>  	if (vma_iter_prealloc(vmi, vma))
> -		return NULL;
> +		goto prealloc_fail;



>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> @@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	vma_complete(&vp, vmi, mm);
>  	khugepaged_enter_vma(res, vm_flags);
>  	return res;
> +
> +prealloc_fail:
> +anon_vma_fail:
> +	if (merge_prev)
> +		vma_next(vmi);
> +	return NULL;
>  }
>  
>  /*

