Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079907B50C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjJBLBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjJBLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AEBD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696244428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sE/fioVyndoiPfLD2q8BtFGyullYe2NKQu6+go3HzhA=;
        b=IuVHAjrxnQlnmOtwh5cRWK2czD4AMnp5obp/95vUwFNfmh0Alee06jv59NYBSQGCY6TtLq
        Fa9IrpCA7xAugjnkAf4LiFOoSUN/5BSHtka7g9hjUyId70Csy1sNQ2WTWAC5X0yROVfMCR
        En1Fm2jLZHTmB+7ArmnIWpC3GSXHpRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-CASPoCAGMY63-ixC9YROLA-1; Mon, 02 Oct 2023 07:00:26 -0400
X-MC-Unique: CASPoCAGMY63-ixC9YROLA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4063dd6729bso68636285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244425; x=1696849225;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE/fioVyndoiPfLD2q8BtFGyullYe2NKQu6+go3HzhA=;
        b=wcbf+LtaMoxsIgGWbO3XoeCEjlgI12GMMSgqhUCJiigaFEcJgx/MVU0H82b3vN0MGA
         HToD5RonrQLMEgDG+4NexEXdqG6c4DQgkgcoxmFoxir9I68xKmMquCnPe32cCmHd/SsN
         CVNCteU3WRKUXKtqHyAHEF6svHY4ZxGqyfC1uhDjv6qsEorbmGRsg7eL9cBubXITU40r
         z5VD64R8/R2nOPTTVVFEyQ/f2ZAjom/etr/TfyuEMR7rTRWw2DvF1uZiOoqn7XP21sAc
         GNr5+y4j4QRg2pLF3nEzn6dgAx/A6wTBIYU0Hc/ws8Ddmv+9ZnF825OyLNE2mK2CY29L
         OdZw==
X-Gm-Message-State: AOJu0YzoBQSR7+2WO7/SHm7nwLNa9pwWpq6Ky916hU1LFlxFmST/eT0p
        4P5WQT6zrTFS3+uWz0D6NqV+vx57pedEtJj2SnOKajb/IBrOcPrRLfluxzakkifzuYG6bd4m91g
        YC9WCgY/T9CgL9/4Wbnnlfb7d
X-Received: by 2002:a05:600c:520c:b0:406:7232:1431 with SMTP id fb12-20020a05600c520c00b0040672321431mr2380547wmb.33.1696244425570;
        Mon, 02 Oct 2023 04:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpz5EnA7VUhjf8bxBaFi8Q2J/OIhu65nFbWQC3K6Vf2VMyOLsEW2oCO85ItfFHZ33XdZIETQ==
X-Received: by 2002:a05:600c:520c:b0:406:7232:1431 with SMTP id fb12-20020a05600c520c00b0040672321431mr2380515wmb.33.1696244425233;
        Mon, 02 Oct 2023 04:00:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c248b00b003fefe70ec9csm6996004wms.10.2023.10.02.04.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:00:24 -0700 (PDT)
Message-ID: <a221bab2-d4f6-eb55-7406-31b71b5b4def@redhat.com>
Date:   Mon, 2 Oct 2023 13:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] mm/gup: explicitly define and check internal GUP
 flags, disallow FOLL_TOUCH
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <5b20f3cda7cd841555c2626f98d23aa25a039828.1696174961.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5b20f3cda7cd841555c2626f98d23aa25a039828.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.23 18:00, Lorenzo Stoakes wrote:
> Rather than open-coding a list of internal GUP flags in
> is_valid_gup_args(), define which ones are internal.
> 
> In addition, we were not explicitly checking to see if the user passed in
> FOLL_TOUCH somehow, this patch fixes that.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   mm/gup.c      | 5 ++---
>   mm/internal.h | 3 +++
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2f8a2d89fde1..b21b33d1787e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2227,12 +2227,11 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>   	/*
>   	 * These flags not allowed to be specified externally to the gup
>   	 * interfaces:
> -	 * - FOLL_PIN/FOLL_TRIED/FOLL_FAST_ONLY are internal only
> +	 * - FOLL_TOUCH/FOLL_PIN/FOLL_TRIED/FOLL_FAST_ONLY are internal only
>   	 * - FOLL_REMOTE is internal only and used on follow_page()
>   	 * - FOLL_UNLOCKABLE is internal only and used if locked is !NULL
>   	 */
> -	if (WARN_ON_ONCE(gup_flags & (FOLL_PIN | FOLL_TRIED | FOLL_UNLOCKABLE |
> -				      FOLL_REMOTE | FOLL_FAST_ONLY)))
> +	if (WARN_ON_ONCE(gup_flags & INTERNAL_GUP_FLAGS))
>   		return false;
>   
>   	gup_flags |= to_set;
> diff --git a/mm/internal.h b/mm/internal.h
> index 449891ad7fdb..499016c6b01d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1018,6 +1018,9 @@ enum {
>   	FOLL_UNLOCKABLE = 1 << 21,
>   };
>   
> +#define INTERNAL_GUP_FLAGS (FOLL_TOUCH | FOLL_TRIED | FOLL_REMOTE | FOLL_PIN | \
> +			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE)
> +
>   /*
>    * Indicates for which pages that are write-protected in the page table,
>    * whether GUP has to trigger unsharing via FAULT_FLAG_UNSHARE such that the

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

