Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A37BA128
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbjJEOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbjJEOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5AF8260
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696515630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8OERLt30v5GuP5/A96MP1RVbcyVg7KG0iqkYYWA2oU=;
        b=HIPIsEqsUDpS4W9iFh8d/zaKEihj1+rZe3doPvQKMyAzGGTjbh6HB2mAQrUIzjKZuU06TF
        3loYAV9WH3CZEEXkuG8c6ru9YAxg/EgNt0KG0l1O6Lqko9j7Nrc97XNBnhipGErvnCeGT4
        CXvIqN9cYTvGgr5WwpGALUedoc6EUGo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-WDI6V2-5OzCW3Y0OIWeEUQ-1; Thu, 05 Oct 2023 04:19:10 -0400
X-MC-Unique: WDI6V2-5OzCW3Y0OIWeEUQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso5272845e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493949; x=1697098749;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8OERLt30v5GuP5/A96MP1RVbcyVg7KG0iqkYYWA2oU=;
        b=SAHWa8mZD0Jbeeyl870a5EapJdA79DlUk1DV4ZGj0qCRnn2NoGIDdDV2BGEK5Avzmf
         FeZEXr1opmKa72pC97a5ZeH4BDPZBX4TP1AyMUK9bkrap8cu4zNv1edQ7YkFo6/C6wH2
         LqrRowTDX8Jjn363r/BDtOPLLa0lTfvJQFT2bpAA99N8MOmesKaPus/jgNf7nZHXAOri
         EEHR52K5ooQoPv7du+4FgEYIRop3O5AD7PMQPUT1O3E56SndEMS23eRocvMybgrcOTY3
         TH0XNuq9EEE6awVYsrF8cvvrAUYmzuCIGhQr6DTBBOHJ80GBH0v73MZBefxKCuZTXQtB
         561g==
X-Gm-Message-State: AOJu0YxZDEqjSVy/koC5njMKAuKGB3SKbD6PsTdLK5Duah/OFQYdVRIn
        Yv6ZavCHCdKshtic3Mcjv/YTPAFMWcgNe0yFr/0lIpNLe6k3EJjt66fv2Ip7HWHIZ4NTzWDdkF7
        JqVQuHCylz4/QFogN/qHJ/xVj
X-Received: by 2002:a1c:7918:0:b0:406:5303:9be2 with SMTP id l24-20020a1c7918000000b0040653039be2mr4592409wme.0.1696493949045;
        Thu, 05 Oct 2023 01:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBbWTEjl1tZ+K+VDxwydJ2ZY8lKhMy6qbI1xCWeBAJWf0ILuqBVCgDtEPtvwMduKSwmGhbgQ==
X-Received: by 2002:a1c:7918:0:b0:406:5303:9be2 with SMTP id l24-20020a1c7918000000b0040653039be2mr4592381wme.0.1696493948671;
        Thu, 05 Oct 2023 01:19:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:d000:419d:b58e:720e:5890? (p200300cbc707d000419db58e720e5890.dip0.t-ipconnect.de. [2003:cb:c707:d000:419d:b58e:720e:5890])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d67c5000000b00317f70240afsm1165396wrw.27.2023.10.05.01.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 01:19:08 -0700 (PDT)
Message-ID: <65867977-ac07-092e-6831-91543bb2da77@redhat.com>
Date:   Thu, 5 Oct 2023 10:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/9] mm: Allow deferred splitting of arbitrary anon
 large folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-2-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230929114421.3761121-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.23 13:44, Ryan Roberts wrote:
> In preparation for the introduction of large folios for anonymous
> memory, we would like to be able to split them when they have unmapped
> subpages, in order to free those unused pages under memory pressure. So
> remove the artificial requirement that the large folio needed to be at
> least PMD-sized.
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/rmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 9f795b93cf40..8600bd029acf 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1446,11 +1446,11 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>   		__lruvec_stat_mod_folio(folio, idx, -nr);
>   
>   		/*
> -		 * Queue anon THP for deferred split if at least one
> +		 * Queue anon large folio for deferred split if at least one
>   		 * page of the folio is unmapped and at least one page
>   		 * is still mapped.
>   		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>   			if (!compound || nr < nr_pmdmapped)
>   				deferred_split_folio(folio);
>   	}

This patch can be picked up early I think.

-- 
Cheers,

David / dhildenb

