Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B67DC6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbjJaHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJaHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:04:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C59DB;
        Tue, 31 Oct 2023 00:04:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3DC1F38A;
        Tue, 31 Oct 2023 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698735845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uYnrLXiUnb54kRt3R0VsUK9uL16N6yJSyjoGJOu1qs=;
        b=CM2miGhUrdbZ4KaKz4ZKz4KfhWel4XKNq1I1MYfqvnMq17bm2lNDP4hyzMeRO4UvZ/hPrP
        JLOoMp3HK8GR/4wtcUB1weu13Pj7B/dJwIVSgpSgB/Hfg50FOceWh0wFcQ0/limdZi7yJ3
        g1XV02LX/HWhWy+j8vudNs+LCpBy4B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698735845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uYnrLXiUnb54kRt3R0VsUK9uL16N6yJSyjoGJOu1qs=;
        b=fu4mqHKKtb5ROaJmYvb7VLOtwGR6dRopNgQERe9Oz4vGWK6uvh/1c6JvcJ8w2buXCPKMHS
        IZTk+KCWYuaiwmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279A7138EF;
        Tue, 31 Oct 2023 07:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jYwPCOWmQGVTFQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 31 Oct 2023 07:04:05 +0000
Message-ID: <735f3692-2932-4986-abec-c217da182f71@suse.de>
Date:   Tue, 31 Oct 2023 08:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/11] shmem: add order arg to shmem_alloc_folio()
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef@eucas1p1.samsung.com>
 <20231028211518.3424020-10-da.gomez@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231028211518.3424020-10-da.gomez@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 23:15, Daniel Gomez wrote:
> Add folio order argument to the shmem_alloc_folio() and merge it with
> the shmem_alloc_folio_huge(). Return will make use of the new
> page_rmappable_folio() where order-0 and high order folios are
> both supported.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>   mm/shmem.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d8dc2ceaba18..fc7605da4316 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1614,40 +1614,27 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>   	return result;
>   }
>   
> -static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
> -		struct shmem_inode_info *info, pgoff_t index)
> +static struct folio *shmem_alloc_folio(gfp_t gfp, struct shmem_inode_info *info,
> +				       pgoff_t index, unsigned int order)
>   {
>   	struct mempolicy *mpol;
>   	pgoff_t ilx;
>   	struct page *page;
>   
> -	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
> -	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
> +	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
> +	page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
>   	mpol_cond_put(mpol);
>   
>   	return page_rmappable_folio(page);
>   }
>   
> -static struct folio *shmem_alloc_folio(gfp_t gfp,
> -		struct shmem_inode_info *info, pgoff_t index)
> -{
> -	struct mempolicy *mpol;
> -	pgoff_t ilx;
> -	struct page *page;
> -
> -	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
> -	page = alloc_pages_mpol(gfp, 0, mpol, ilx, numa_node_id());
> -	mpol_cond_put(mpol);
> -
> -	return (struct folio *)page;
> -}
> -
>   static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   		struct inode *inode, pgoff_t index,
>   		struct mm_struct *fault_mm, size_t len)
>   {
>   	struct address_space *mapping = inode->i_mapping;
>   	struct shmem_inode_info *info = SHMEM_I(inode);
> +	unsigned int order = 0;
>   	struct folio *folio;
>   	long pages;
>   	int error;
> @@ -1668,12 +1655,12 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   				index + HPAGE_PMD_NR - 1, XA_PRESENT))
>   			return ERR_PTR(-E2BIG);
>   
> -		folio = shmem_alloc_hugefolio(gfp, info, index);
> +		folio = shmem_alloc_folio(gfp, info, index, HPAGE_PMD_ORDER);
>   		if (!folio)
>   			count_vm_event(THP_FILE_FALLBACK);
>   	} else {
> -		pages = 1;
> -		folio = shmem_alloc_folio(gfp, info, index);
> +		pages = 1UL << order;
> +		folio = shmem_alloc_folio(gfp, info, index, order);
>   	}
>   	if (!folio)
>   		return ERR_PTR(-ENOMEM);
> @@ -1774,7 +1761,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>   	 */
>   	gfp &= ~GFP_CONSTRAINT_MASK;
>   	VM_BUG_ON_FOLIO(folio_test_large(old), old);
> -	new = shmem_alloc_folio(gfp, info, index);
> +	new = shmem_alloc_folio(gfp, info, index, 0);

Shouldn't you use folio_order(old) here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

