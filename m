Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D67EC0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjKOKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653F9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700045235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UqM8vrIxhwo/R/jUTHmCzXfFqE4PtPDapCucvQc/cDA=;
        b=Eh+MPJxNRzbVGPyENohL8+5Z2HtYsp1QZojjygSLsr2NuRJdmZaWIlKfR35aDO6SNQwpfe
        d3qh3Tm6ZyI09Oacid6GWfjIqIZ9/cgWhbgBv6IKYE/Nl6Wje1WEeZelb6AEsZyGyjxhPr
        ApGhQTpsI8clE5pOicMEH1okp9RlyQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-8hGfBN7aOlm7_i24LzuLPA-1; Wed, 15 Nov 2023 05:47:13 -0500
X-MC-Unique: 8hGfBN7aOlm7_i24LzuLPA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso3420725e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700045233; x=1700650033;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UqM8vrIxhwo/R/jUTHmCzXfFqE4PtPDapCucvQc/cDA=;
        b=vtoKjU2gX5Eki4LOrSUbcODo7xufwTFn4KqnQAGvzOywEzFqJNNQFpif7vhOVK5O2V
         Q2+/4BaJeHWKxedhi+M7RRyzqvqHNIKhurXJ+AbE/NJLZXTZ92jauqjKKE7X33e07NQ7
         tzwX/RrzIcS5FnLQun/YjKQDwcejb0M5LIJg+B1fYr0J/Aj2TQDFD8WlKk57IgcDrKXn
         nM+RGjbzmEHjTt2H5h/VB915GO0JtKaNJqtpbSMsKMQ2y0nkBl2Zls+hjvfmSTvdnwvh
         oEwIy7so8C7j7dCQ3BIuAOinxCDajjry6glH+3lYaWHFnqYjhGSieqw7FMDZRGt35R54
         w/pg==
X-Gm-Message-State: AOJu0Yx4C3uwds4Anp0lQ5jWo+bY5AMyl/CiKCFe2hSA0w7hmKK5l4s0
        i0eNGwqcObg4inMPCPz9I9iDvhsjCxsJ2gHgoIkm9xG4TeH28UvHatiYmaSW92rZPwasMutbo0g
        KLZGsnQol5L5QdtKoToQibZ09
X-Received: by 2002:a05:600c:1f88:b0:406:51a0:17ea with SMTP id je8-20020a05600c1f8800b0040651a017eamr5104019wmb.10.1700045232734;
        Wed, 15 Nov 2023 02:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKnqmmL2A34wBOdooqU6W/s7ASRNRrGRAY763BPARxvQhcHgEpYuEF983uY5RVyY1NQMZfaA==
X-Received: by 2002:a05:600c:1f88:b0:406:51a0:17ea with SMTP id je8-20020a05600c1f8800b0040651a017eamr5103993wmb.10.1700045232262;
        Wed, 15 Nov 2023 02:47:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:ed00:59ee:f048:4ed9:62a6? (p200300cbc706ed0059eef0484ed962a6.dip0.t-ipconnect.de. [2003:cb:c706:ed00:59ee:f048:4ed9:62a6])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b0040a507f546fsm11482421wmq.8.2023.11.15.02.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 02:47:11 -0800 (PST)
Message-ID: <ad7c3a3d-58d8-4edd-859e-4ed5a35145dd@redhat.com>
Date:   Wed, 15 Nov 2023 11:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ying.huang@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <05dbc7b8-2e4a-4762-a6a6-278985d89928@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <05dbc7b8-2e4a-4762-a6a6-278985d89928@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 11:46, David Hildenbrand wrote:
> On 13.11.23 11:45, Baolin Wang wrote:
>> Currently, the file pages already support large folio, and supporting for
>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>> code are converted to use a folio by previous thread[2], and the migrate_pages
>> function also already supports the large folio migration.
>>
>> So now I did not see any reason to continue restricting NUMA balancing for
>> large folio.
>>
>> [1] https://lkml.org/lkml/2023/9/29/342
>> [2] https://lore.kernel.org/all/20230921074417.24004-4-wangkefeng.wang@huawei.com/T/#md9d10fe34587229a72801f0d731f7457ab3f4a6e
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
> 
> I'll note that another piece is missing, and I'd be curious how you
> tested your patch set or what I am missing. (no anonymous pages?)
> 
> change_pte_range() contains:
> 
> if (prot_numa) {
> 	...
> 	/* Also skip shared copy-on-write pages */
> 	if (is_cow_mapping(vma->vm_flags) &&
> 	    folio_ref_count(folio) != 1)
> 		continue;
> 
> So we'll never end up mapping an anon PTE-mapped THP prot-none (well, unless a
> single PTE remains) and consequently never trigger NUMA hinting faults.
> 
> Now, that change has some history [1], but the original problem has been
> sorted out in the meantime. But we should consider Linus' original feedback.
> 
> For pte-mapped THP, we might want to do something like the following
> (completely untested):
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 81991102f785..c4e6b9032e40 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>    
>                                   /* Also skip shared copy-on-write pages */
>                                   if (is_cow_mapping(vma->vm_flags) &&
> -                                   folio_ref_count(folio) != 1)
> +                                   (folio_maybe_dma_pinned(folio) ||
> +                                    folio_estimated_sharers(folio) != 1))

Actually, > 1 might be better if the first subpage is not mapped; it's a 
mess.

-- 
Cheers,

David / dhildenb

