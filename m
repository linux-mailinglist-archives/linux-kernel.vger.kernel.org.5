Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FEE7EAF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjKNLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjKNLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EB1AB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699961744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=bVhyNZ0G5164xFB605BhIfrLVXL/nBTiRBKL0B9zBdg=;
        b=OcW0EkdOikOUl2aCwncG+bwcQDGKShF6cL6SRxjCkORyk1urLN/qbf8v/PNxiBP8/gFCt+
        GxyPWS3CZi1dAcxhhc+uGjUVw3w0Z0YDadoB0gItVyYdQ6AVCs5ldFEfufVIDX1nl4L0S8
        5sPYxdknRdv/sRGGpgTCJPTufgPUMYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-C9cmiblANm-z4myX-2Mt4Q-1; Tue, 14 Nov 2023 06:35:43 -0500
X-MC-Unique: C9cmiblANm-z4myX-2Mt4Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4091c9bdb8eso35245905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699961742; x=1700566542;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVhyNZ0G5164xFB605BhIfrLVXL/nBTiRBKL0B9zBdg=;
        b=c/25jVE7RnGBZYUSLe4nxxlYvJvMUgVLYz6S8eno9V/SIWI6Ycj9Knehet40tAK8G8
         Ga/6s5gy5Mn/Go77WD5i9vuM5rbfBWBwV9NoXWHuP6ZmZVJqA01ThWObBIkBl0NfUddT
         xF8g56EfvPjDQuGPGa6slLBQiHWQHTV43wJO3Vhh3+5gOjB09EiAwVGvwHvfiIap6hpS
         DI8DLtHaJJUtWjgU0F2ZWLnvFsgPEv2P01eaFA84ztC5nDhRyg44dnlDY2nhzC8F/0BQ
         CUFKoKAeMYbCtO/MKQxT3k8U71A5XGz0dxCIxL7fd6H8wy26NzyDKhS9mgHlcPxnIMt2
         G7ig==
X-Gm-Message-State: AOJu0YxzHbMAK308LK9lL/xvYyhRmf+gMqlUdiOURvqRIsfex4fyrIs1
        89a+yo8yIr4BAVb8yNhvxD8VVasne+R2ZY/S1Dj4Nuul1EDVd1mDpgGm+qmp+IOJJT150+fulp4
        iFbgiRQ2deVce1SxOlpuvLAQnMu8UhFY0
X-Received: by 2002:a05:600c:1d27:b0:407:5de2:ea4d with SMTP id l39-20020a05600c1d2700b004075de2ea4dmr2002095wms.13.1699961741803;
        Tue, 14 Nov 2023 03:35:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA+I5BsO3udq6KqoJEmND0H9RYnHu3UJArFQ75bp0XSbo+i2Dqhq/5BIV7glcmig/3o2D/Wg==
X-Received: by 2002:a05:600c:1d27:b0:407:5de2:ea4d with SMTP id l39-20020a05600c1d2700b004075de2ea4dmr2002071wms.13.1699961741389;
        Tue, 14 Nov 2023 03:35:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd? (p200300cbc73e890002d8c9f0f3fbd4fd.dip0.t-ipconnect.de. [2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b0040839fcb217sm11233236wms.8.2023.11.14.03.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 03:35:40 -0800 (PST)
Message-ID: <1b4de866-df27-46fa-81fa-6818a48d8cc1@redhat.com>
Date:   Tue, 14 Nov 2023 12:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org
Cc:     ying.huang@intel.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <70973a55-63a0-4a85-abe5-d8681fdb3886@huawei.com>
 <e75ce7a4-1294-435c-86eb-d6cf55281a39@linux.alibaba.com>
 <00372b9e-6020-64b7-1381-e88d9744ed05@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <00372b9e-6020-64b7-1381-e88d9744ed05@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.23 23:15, John Hubbard wrote:
> On 11/13/23 5:01 AM, Baolin Wang wrote:
>>
>>
>> On 11/13/2023 8:10 PM, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/11/13 18:53, David Hildenbrand wrote:
>>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>>> Currently, the file pages already support large folio, and
>>>>> supporting for
>>>>> anonymous pages is also under discussion[1]. Moreover, the numa
>>>>> balancing
>>>>> code are converted to use a folio by previous thread[2], and the
>>>>> migrate_pages
>>>>> function also already supports the large folio migration.
>>>>>
>>>>> So now I did not see any reason to continue restricting NUMA
>>>>> balancing for
>>>>> large folio.
>>>>
>>>> I recall John wanted to look into that. CCing him.
>>>>
>>>> I'll note that the "head page mapcount" heuristic to detect sharers will
>>>> now strike on the PTE path and make us believe that a large folios is
>>>> exclusive, although it isn't.
>>>>
>>>> As spelled out in the commit you are referencing:
>>>>
>>>> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
>>>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Date:   Thu Sep 21 15:44:14 2023 +0800
>>>>
>>>>       mm: memory: use a folio in do_numa_page()
>>>>       Numa balancing only try to migrate non-compound page in
>>>> do_numa_page(),
>>>>       use a folio in it to save several compound_head calls, note we use
>>>>       folio_estimated_sharers(), it is enough to check the folio
>>>> sharers since
>>>>       only normal page is handled, if large folio numa balancing is
>>>> supported, a
>>>>       precise folio sharers check would be used, no functional change
>>>> intended.
>>>>
>>>>
>>>> I'll send WIP patches for one approach that can improve the situation
>>>> soonish.
> 
> To be honest, I'm still catching up on the approximate vs. exact
> sharers case. It wasn't clear to me why a precise sharers count
> is needed in order to do this. Perhaps the cost of making a wrong
> decision is considered just too high?

Good question, I didn't really look into the impact for the NUMA hinting 
case where we might end up not setting TNF_SHARED although it is shared. 
For other folio_estimate_sharers() users it's more obvious.

As a side note, it could have happened already in corner cases (e.g., 
concurrent page migration of a small folio).

If precision as documented in that commit is really required remains to 
be seen -- just wanted to spell it out.

-- 
Cheers,

David / dhildenb

