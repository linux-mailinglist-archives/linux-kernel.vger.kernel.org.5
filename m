Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA77AE71F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjIZHuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BC92
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695714561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYUMFabCqShOqg91SXlnQ/MBxB7SPueU7zs/KEePW1U=;
        b=hWxYGDQFOVrWbIScNZ+nG8Nw9RSL0kPaKFOlZmpb9UXmTVnkiieOemuW81/5Gorkmk54hz
        Pe4R6r+GD2UOQkerzXr3JM7Vvu4JBS+aunfQ1Ig+dcjdbkpuntNyiofAZDj9aS0tWG6j+z
        /MRA4Fdq3Syv2ysb36OCC8JmOJrRpqU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-OQ0OxelxN4OwyAIqhPY6wA-1; Tue, 26 Sep 2023 03:49:19 -0400
X-MC-Unique: OQ0OxelxN4OwyAIqhPY6wA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-323334992fbso1328962f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695714558; x=1696319358;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYUMFabCqShOqg91SXlnQ/MBxB7SPueU7zs/KEePW1U=;
        b=KtsC/7k94Gd882yB8N4+3hp39hCFQkRfKd7epAI0wz9YwqwHxnmwhFwUASCLa1l7ZB
         ZRMhU8XFUO0US1WzVoPmXUTnG269TYPFgAGvZz0rlTaoHlI4mZl3yr1lj6Zm+0KtYaaU
         ukAvzXgY0FiTnHC/UqkFqr6K+s9cVq4mX5NKS2Xtf95QHEzC1embbTCTGAVECW2TsoXb
         59FOpq22ObD2eUCy+puM6Oq37Z7+ukYvEoAvS8nprFi/FhpgraFxoORRBbcEsvS9Iyz3
         e9RznstXKpmNkcbmycLAm8DgByYwJQCoYY0eoh3zUF9jPelgJIOWcuxRsNMTCRkdzp8i
         bNYA==
X-Gm-Message-State: AOJu0YxccxXdzqUJSc7EvlY5z6tDWuLPzCsZ16ov001qdBKPFb7E0Pxw
        xT/bWosoj30X9udtbZ41k0kAaRGv/uIkyzuEpDXFyImAPdlQ54v8I0F0hP2PNM1KaJw0R253CVA
        yBCmud11uL8rSkg52LHgLVBw2
X-Received: by 2002:adf:cd81:0:b0:319:755c:3c1e with SMTP id q1-20020adfcd81000000b00319755c3c1emr8170018wrj.11.1695714558555;
        Tue, 26 Sep 2023 00:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGExJDSP5L0Rs54wrMlcjvXXpaJBWHcVuvht4vXnT5kqrem65CKuIyx4A5vO7PM+ZqBaoWCdQ==
X-Received: by 2002:adf:cd81:0:b0:319:755c:3c1e with SMTP id q1-20020adfcd81000000b00319755c3c1emr8170001wrj.11.1695714558169;
        Tue, 26 Sep 2023 00:49:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d? (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de. [2003:cb:c73f:600:933b:ca69:5a80:230d])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004058e6379d8sm5661368wmz.23.2023.09.26.00.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 00:49:17 -0700 (PDT)
Message-ID: <b7818a38-d991-6cdd-c908-fe0ebc3677c6@redhat.com>
Date:   Tue, 26 Sep 2023 09:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next 8/9] mm: page_alloc: use a folio in
 free_pages_prepare()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        Zi Yan <ziy@nvidia.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
 <20230926005254.2861577-9-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230926005254.2861577-9-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.23 02:52, Kefeng Wang wrote:
> The page should not a tail page in free_pages_prepare(), let's use
> a folio in free_pages_prepare() to save several compound_head() calls.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/page_alloc.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 06be8821d833..a888b9d57751 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1070,6 +1070,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   			unsigned int order, fpi_t fpi_flags)
>   {
>   	int bad = 0;
> +	struct folio *folio = page_folio(page);

We might have higher-order pages here that are not folios (not compound 
pages). It looks a bit like this function really shouldn't be working 
with folios in the generic way, for that reason.

Wrong level of abstraction in that function.

What am I missing?

-- 
Cheers,

David / dhildenb

