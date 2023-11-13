Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373A7EA3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKMTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:30:59 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB4D6F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:30:56 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b6d88dbaa3so1544188b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699903855; x=1700508655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtsDd0lIOvoRQSEHQSqxkag10z8/tuV0tSNv0afMBPQ=;
        b=UGzChAmtDT7iAL1sakZtvMYN0kTHQUkCJ7HT8eFvS43AR1z4Tdirp1StGUw4cVmHiW
         wD9d9/IAYX+v5xL7PFP5tu1Y/Uk9nSVcfF+VUKMmEObIxZMPdXkTAhFmFB6PWdAY7JBE
         mZyS+Yb6drnTqC5MGrpYx9Upkg6YOpzcHhJUCm/9mgjrpwtzykiRd3GXAJWz2n45wWUs
         i4iDpEfYwonQR8N50qrD4O9JVGxOFh4NKu1FSqVUtCO5B8JRc+x9GuQMcVoOxjBF5XC1
         gWIRXDXXWJ9f8U/xuIlpghxADKC0mw0/jq7oVWt6sDxevSXWuURVlFqJHQD0r9YOBgp+
         Wy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903855; x=1700508655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtsDd0lIOvoRQSEHQSqxkag10z8/tuV0tSNv0afMBPQ=;
        b=w0nkrF6seDV13GakvGjzILBRAbSvFC1BD1XQ+UtkMlpDXIh7Nwh4OyhjHs/AxXUHWx
         DE3h2HgNoK3Zy6EUcHKZwAq8aYLGEcAaVjUe9YZ301FU30zsR7FIOkn6Q74WB9Wp7hMm
         wkh1ASmUcuOYVKUaOwl6qV5V8tEvGDABRvmdGqrCEXO75J7oXSCuxaXqy0gPsb2pzXKE
         5wsuHwVokLDf7IMePTKc+Vr+z2SJ48g2U5FbAIERnHOrpMFbuBlKxzIh+EmLCr6wZ9GA
         EMuhvqxxzAaOmJ5WtXzo8ZmLfNsjsIjkmf0E5TzRbfO74dvXYKP5dxSItPotF46wdVKE
         eMbQ==
X-Gm-Message-State: AOJu0YwEDmE+mCkawnc4GXBs3w+NANiZlW6uGeUv+OxjjNPWa5JmbdnV
        YQEi9nEHLHDN7e7TC3N+u0A=
X-Google-Smtp-Source: AGHT+IFblfdl9cev2v5CX0G/uLny8IBr2/VTvhViSAocpgEIDfS3dgJCm+QxC29VaJvatU0xlvT0fw==
X-Received: by 2002:a05:6808:1585:b0:3a7:26fd:b229 with SMTP id t5-20020a056808158500b003a726fdb229mr12006278oiw.48.1699903855475;
        Mon, 13 Nov 2023 11:30:55 -0800 (PST)
Received: from fedora ([2600:1700:2f7d:1800::46])
        by smtp.gmail.com with ESMTPSA id n21-20020a05680803b500b003a78d196acasm887092oie.32.2023.11.13.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:30:55 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:30:50 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 2/6] mm: memory: use a folio in
 validate_page_before_insert()
Message-ID: <ZVJ5akp29W2gxDR8@fedora>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
 <20231113152222.3495908-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113152222.3495908-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:22:18PM +0800, Kefeng Wang wrote:
> Use a folio in validate_page_before_insert() to save two
> compound_head() calls.
> 

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c32954e16b28..379354b35891 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1841,9 +1841,12 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
>  
>  static int validate_page_before_insert(struct page *page)
>  {
> -	if (PageAnon(page) || PageSlab(page) || page_has_type(page))
> +	struct folio *folio = page_folio(page);
> +
> +	if (folio_test_anon(folio) || folio_test_slab(folio) ||
> +	    page_has_type(page))
>  		return -EINVAL;
> -	flush_dcache_page(page);
> +	flush_dcache_folio(folio);
>  	return 0;
>  }
>  
> -- 
> 2.27.0
