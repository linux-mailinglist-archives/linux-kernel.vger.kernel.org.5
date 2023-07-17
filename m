Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B87563B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjGQNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGQNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B71995
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689598812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnuLGRWli6sXUknfuf4qrEwuH/s76ur6qJ5Dm6192NE=;
        b=AzpjWPLufoGzjUpN6WkTwgy4lqs18BPWxDYR9AgyU11MmJwcsYYiRw4MbpDXU/bkr3LTLt
        K1QPQSgE7bJJU1RPMDIz1WXfYiDGPibZk15j4T6uwjiGRGk6EVgMPJQTrYSjN8ueC6QPyD
        PsG8v2Kt+95PrM29F8lIbs3rlBPQTv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-tjOmcLHgPcajrh5ZhTgvDQ-1; Mon, 17 Jul 2023 09:00:10 -0400
X-MC-Unique: tjOmcLHgPcajrh5ZhTgvDQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31421c900b7so2761902f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598809; x=1692190809;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnuLGRWli6sXUknfuf4qrEwuH/s76ur6qJ5Dm6192NE=;
        b=JpFcaxAvP+BLxNUnqN3L0KfdCaB3lvIa2UWsDVsB6pjyoCkwldtYNkVC48PL+DV4bZ
         X28mBwoZ/pWRSfS7GsCmpPUr5vzQ3XYNktyl3ldM5Z4bty+cRqZImUMVocM1tuXN6Zmm
         SMgezk2Y/OVG9VxUQjlBmr9GgJll4pnZieUdzjpY8+wch+4uY7CWlbQcRWucfi56CDR9
         LWXJL6xDZE713bvquGnhso248uqFKhOzkwdynY+rzVOpP5dpmRjwJ0htpRfRnsAYu9GR
         kqYF1mMzKsg5LUBlVIJQZMG74k52K6XNlb23FugYr9HvrlFx5so0OymAHB24D/hMCCOI
         QReQ==
X-Gm-Message-State: ABy/qLZMwYYDBLuXDvyS9TfOoAABYvU5TcmEQbfaLWz8j/gN0N8Cw31J
        hHeb0m/aaAPbYImYDF2z2MVsACmQZUROvSGRYWDZFhAcr9TzwXwswQzy4lNRb6/i+1y2K5x0i3F
        BZb8KIgjjf7Ef2Pf8LTYaFMiI
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10570196wrw.38.1689598809041;
        Mon, 17 Jul 2023 06:00:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXxUteG0PmbGskMHSW7jIayVLlodigjnmLKRFHB2z7Xg0ryChd5FqOFsiW8eVvFhIugTrl9Q==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10570169wrw.38.1689598808572;
        Mon, 17 Jul 2023 06:00:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4b82000000b0031432c2fb95sm19154039wrt.88.2023.07.17.06.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:00:08 -0700 (PDT)
Message-ID: <d85c0f04-1792-2a0f-d0be-7fffc7604797@redhat.com>
Date:   Mon, 17 Jul 2023 15:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/4] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-1-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230714161733.4144503-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 18:17, Ryan Roberts wrote:
> In preparation for FLEXIBLE_THP support, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> order-0 folio (or base page) scheme.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>   mm/rmap.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0c0d8857dfce..f293d072368a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1278,31 +1278,45 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>    * This means the inc-and-test can be bypassed.
>    * The folio does not have to be locked.
>    *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>    * is new, it's assumed to be mapped exclusively by a single process.
>    */
>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>   		unsigned long address)
>   {
> -	int nr;
> +	int nr = folio_nr_pages(folio);
> 
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>   	__folio_set_swapbacked(folio);
> 
> -	if (likely(!folio_test_pmd_mappable(folio))) {
> +	if (!folio_test_large(folio)) {

Why remove the "likely" here? The patch itself does not change anything 
about that condition.

>   		/* increment count (starts at -1) */
>   		atomic_set(&folio->_mapcount, 0);
> -		nr = 1;
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
> +	} else if (!folio_test_pmd_mappable(folio)) {
> +		int i;
> +
> +		for (i = 0; i < nr; i++) {
> +			struct page *page = folio_page(folio, i);
> +
> +			/* increment count (starts at -1) */
> +			atomic_set(&page->_mapcount, 0);
> +			__page_set_anon_rmap(folio, page, vma,
> +					address + (i << PAGE_SHIFT), 1);
> +		}
> +
> +		/* increment count (starts at 0) */

That comment is a bit misleading. We're not talking about a mapcount as 
in the other cases here.

> +		atomic_set(&folio->_nr_pages_mapped, nr);
>   	} else {
>   		/* increment count (starts at -1) */
>   		atomic_set(&folio->_entire_mapcount, 0);
>   		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -		nr = folio_nr_pages(folio);
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>   		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>   	}
> 

Apart from that, LGTM.

-- 
Cheers,

David / dhildenb

