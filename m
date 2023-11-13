Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294BE7EA44C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKMUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjKMUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:07:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13DED5D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:07:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6cf65093780so2918843a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699906060; x=1700510860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEByVYW3w3u8i6rxkJh2qboL9UB0XJt7vpSFoPdqZFU=;
        b=mno0UQ8dS3uO27U3dE2Oh1DS9z/rXecgg/654UoU1JG34J07P4k63V5Fkr4PqDAVpU
         MtTLBxGhWfoO84gSjs/GfUHE4anOR1ofW00bghxLZAHZB0YhdG6T+fDw64SYkNQDvMSZ
         mI4UA1toAj/MvCaq//lffSv6UTRUQ6p5NATmDy9aMPoH199a8JxS+BwCGLM9kjISYt1X
         XszQUgLTAtQLkuGIvUYsrknBCKC8tQqqGv+MbCdaZS3XoGZWyIldoUCE3iBrw9e+Apzi
         y31kyixclsjJ9nAmHCu3jhfBhKny7e3nu9PVuA2gIYbfnZPERoj9ZekvHp1t+K4+N/d7
         vLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906060; x=1700510860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEByVYW3w3u8i6rxkJh2qboL9UB0XJt7vpSFoPdqZFU=;
        b=BJiXhagNezxQwVsWU2PDYtSITNFgTTf1RRczMB/3vuzKkCGQE9K0N0fr4dmLwkptSU
         4F69crkdA1nTB5g8lVHMcsQOzsRzvA3LGKyDSPcoeGRaXBlK5WKdgi0FE9AIe849cgK5
         pFzID8sMr8N8CRcRwUQNvRNDMRqJtYtIrP3s1YjJknlLI49aYkxBJBZkumpI6/aX/U9t
         Fjq+ygpQZGb51SV1epTSkKsW+GKAXKhIaNuwttSbgCiSlQo270Fg1WwSWaCbMeuqACfG
         F25d4cCECxFrLQbHXzcxI0/DiYNhKz7OU4m4uG6xAQaCZ07/W3lgPzCDjBMlzByF8FHm
         UzEA==
X-Gm-Message-State: AOJu0YzYzSfk2UumTz58dsS3UG2nF7s7nao1Tb8F3Xlt7JkaxloOXmYe
        LNRZOtd1QQv+NwVwqROEvv8=
X-Google-Smtp-Source: AGHT+IEIOvonU09L3k1xVPZZ80bxCzc769XtxO+lg9jyKZOvLWkuvuhJ/Npd6TRTMPRkdfH95nWhlw==
X-Received: by 2002:a9d:6f89:0:b0:6d6:4cf3:d908 with SMTP id h9-20020a9d6f89000000b006d64cf3d908mr163151otq.33.1699906059975;
        Mon, 13 Nov 2023 12:07:39 -0800 (PST)
Received: from fedora ([2600:1700:2f7d:1800::46])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683011cd00b006d2e04a55e8sm883574otq.14.2023.11.13.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:07:39 -0800 (PST)
Date:   Mon, 13 Nov 2023 12:07:37 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 5/6] mm: memory: use folio_prealloc() in wp_page_copy()
Message-ID: <ZVKCCceuuNhJrP19@fedora>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
 <20231113152222.3495908-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113152222.3495908-6-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:22:21PM +0800, Kefeng Wang wrote:
> Use folio_prealloc() helper to simplify code a bit.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f350ab2a324f..03226566bf8e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3114,6 +3114,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  	int page_copied = 0;
>  	struct mmu_notifier_range range;
>  	vm_fault_t ret;
> +	bool pfn_is_zero;
>  
>  	delayacct_wpcopy_start();
>  
> @@ -3123,16 +3124,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  	if (unlikely(ret))
>  		goto out;
>  
> -	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
> -		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> -		if (!new_folio)
> -			goto oom;
> -	} else {
> +	pfn_is_zero = is_zero_pfn(pte_pfn(vmf->orig_pte));
> +	new_folio = folio_prealloc(mm, vma, vmf->address, pfn_is_zero);
> +	if (!new_folio)
> +		goto oom;
> +
> +	if (!pfn_is_zero) {
>  		int err;
> -		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> -				vmf->address, false);
> -		if (!new_folio)
> -			goto oom;
>  
>  		err = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
>  		if (err) {
> @@ -3153,10 +3151,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		kmsan_copy_page_meta(&new_folio->page, vmf->page);
>  	}
>  
> -	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
> -		goto oom_free_new;
> -	folio_throttle_swaprate(new_folio, GFP_KERNEL);
> -
>  	__folio_mark_uptodate(new_folio);
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> @@ -3255,8 +3249,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  
>  	delayacct_wpcopy_end();
>  	return 0;
> -oom_free_new:
> -	folio_put(new_folio);
>  oom:
>  	ret = VM_FAULT_OOM;
>  out:
> -- 
> 2.27.0
