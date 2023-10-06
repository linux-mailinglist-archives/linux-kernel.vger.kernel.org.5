Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756597BB84E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjJFM5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjJFM5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B83CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696597023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTIMue2BJh1x+fgkokyKiJtKRYZH+rAu+t1lnyfa40A=;
        b=StFLrThTaWnzN3YBIMDad9PFIoMtsZOe/FoyKcoxfqYQnIAQWqnWhN9KiTdUHo8/1+8QDV
        bXVGxoP0Eve+moRxH3PSCd7yWSOnWZqA4Nug0f6XgqDh42UaLcRH7zUNQYWYc7DjhEbNRM
        zCT24hL7EVF/Dn0biccGHZqRjgLKKxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-j6FYhQvqNZe6baw5Hsa2Hg-1; Fri, 06 Oct 2023 08:57:02 -0400
X-MC-Unique: j6FYhQvqNZe6baw5Hsa2Hg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4065478afd3so13087805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696597021; x=1697201821;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTIMue2BJh1x+fgkokyKiJtKRYZH+rAu+t1lnyfa40A=;
        b=ASiRrfjIcgCJOHLKU3NMfVnY1q6ZcXrUThWFydmfw+PSFYEHbXVwK7b2gpdLnBk0Oh
         a7ynyrpQPblj9f4QKSbwiZBI+GWk5LqOk06Ld+LrZog7NQ8pOGfkkZEU2RKBSvoqXPza
         2Qnl9phtD+rVYBnazkNprRtCu/oK4XjdCnHAo/YADqnm46Nr1jniDcbqIyu6sbm9ttS7
         Toa0Ob7RMWg18ECeCUKHwlr08a7uRbkCWXh2Ewj0Q72UWPGjcgb5FZ2Ac2ADm6VkDofT
         PEnCs/wXCLTPBaXSWPLvFo18A/iDmcXTXJORofdeTbYtEEulDpXGMFGRZEyR5NDoxVcA
         VCWg==
X-Gm-Message-State: AOJu0Yy5ocet5OZVHhefEZ113LHF3QgL0GsuhqNO9iNfwrqhHjns9DvD
        cVtpUrdqojGvHkZZTh8/ghHfmCZKWV7SyaCqwwh0TJM0/BM1NeauB0UzHnIHRciVn8ZD6NdxCuQ
        o5VHnYUa3MTEl1sKFDSf9N4zC
X-Received: by 2002:adf:e383:0:b0:314:3e77:f210 with SMTP id e3-20020adfe383000000b003143e77f210mr7286853wrm.59.1696597021296;
        Fri, 06 Oct 2023 05:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqKkjRmvXXnN+OVsEEtVfWJ1EsrvpOddmuHiAxli8vg2y1gFk1oz8FO4TZ626WmOGr56P40g==
X-Received: by 2002:adf:e383:0:b0:314:3e77:f210 with SMTP id e3-20020adfe383000000b003143e77f210mr7286824wrm.59.1696597020848;
        Fri, 06 Oct 2023 05:57:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b00323287186b2sm1615554wrt.29.2023.10.06.05.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:57:00 -0700 (PDT)
Message-ID: <387a6703-b8fb-d2ed-16b1-5264b2c901aa@redhat.com>
Date:   Fri, 6 Oct 2023 14:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/4] mm/gup: make failure to pin an error if
 FOLL_NOWAIT not specified
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
References: <cover.1696288092.git.lstoakes@gmail.com>
 <2a42d96dd1e37163f90a0019a541163dafb7e4c3.1696288092.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2a42d96dd1e37163f90a0019a541163dafb7e4c3.1696288092.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.23 01:14, Lorenzo Stoakes wrote:
> There really should be no circumstances under which a non-FOLL_NOWAIT GUP
> operation fails to return any pages, so make this an error and warn on it.
> 
> To catch the trivial case, simply exit early if nr_pages == 0.
> 
> This brings __get_user_pages_locked() in line with the behaviour of its
> nommu variant.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

