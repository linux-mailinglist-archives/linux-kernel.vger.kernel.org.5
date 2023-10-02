Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6497B4C45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjJBHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJBHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:09:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5218E;
        Mon,  2 Oct 2023 00:09:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD2C121853;
        Mon,  2 Oct 2023 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696230562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vcbNq67Xl3f2iKsCH4we0sJgW4X2ca2S7bOAsiex1Q=;
        b=sYBuE9DmG1frwKtVsSRTG3Ale2r5OTm85xqfZD4SMQgyARAWCQuqkgePAMH2qt5USeFSzU
        +3vTGLz702iOSggMMRZMufC+M6m+JAsB/esv//AAAKxAUUcVtuITmwd1siIpONwABSppuA
        O+ZYuCQ4dJgnDNq4hb0wZ7Qj8p6sC3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696230562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vcbNq67Xl3f2iKsCH4we0sJgW4X2ca2S7bOAsiex1Q=;
        b=Je9vocE06l6uaNRhWqNdvU+Sf0X8KCDs3p9+1pNsnpesOSRzY1tacE+DfjZuDBsZ5JmuP6
        Mk1KJum7qrwXhKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92F6613456;
        Mon,  2 Oct 2023 07:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xE9RI6JsGmWqeAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Oct 2023 07:09:22 +0000
Message-ID: <8055dadf-a8ee-6706-79b3-6fc61d77c71e@suse.cz>
Date:   Mon, 2 Oct 2023 09:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/3] mmap: Fix vma_iterator in error path of
 vma_merge()
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-2-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230929183041.2835469-2-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 20:30, Liam R. Howlett wrote:
> During the error path, the vma iterator may not be correctly positioned
> or set to the correct range.  Undo the vma_prev() call by resetting to
> the passed in address.  Re-walking to the same range will fix the range
> to the area previously passed in.
> 
> Users would notice increased cycles as vma_merge() would be called an
> extra time with vma == prev, and thus would fail to merge and return.
> 
> Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b56a7f0c9f85..acb7dea49e23 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -975,7 +975,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  
>  	/* Error in anon_vma clone. */
>  	if (err)
> -		return NULL;
> +		goto anon_vma_fail;
>  
>  	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
>  		vma_expanded = true;
> @@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	}
>  
>  	if (vma_iter_prealloc(vmi, vma))
> -		return NULL;
> +		goto prealloc_fail;
>  
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> @@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	vma_complete(&vp, vmi, mm);
>  	khugepaged_enter_vma(res, vm_flags);
>  	return res;
> +
> +prealloc_fail:
> +anon_vma_fail:
> +	vma_iter_set(vmi, addr);
> +	vma_iter_load(vmi);
> +	return NULL;
>  }
>  
>  /*

