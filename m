Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0577E917
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjHPSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjHPSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE226AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692211913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWMUD9VRtXw5rrwEDxNTidyXxZLugXghgZFLCJyJsoc=;
        b=FCM5/foJc0tU9nEI/Wdb34NaS2PA6nBGedqlYyxW7YTsoUKp4SvboIXonvcohp5Ammlyik
        xvhwz84IJGhbM+o+QG0OGPlsuDzVynjz+28k/BuMee06Ci3A6wN8Lk9JfAcxGysunaZar0
        YFMAsoPq54vToZS5C2OPUolIjZ4n8W0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-4hDNJ4DxNgeQtmVzTRFHgA-1; Wed, 16 Aug 2023 14:51:52 -0400
X-MC-Unique: 4hDNJ4DxNgeQtmVzTRFHgA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317b30fedb0so4029939f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211911; x=1692816711;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWMUD9VRtXw5rrwEDxNTidyXxZLugXghgZFLCJyJsoc=;
        b=GeDJUi3Sd1ukEnwZ8qPRuXgJHXD5CKochMHzIelBhiIJgQYJyWnlSkwcK3wgaO2VuR
         itiVYPbccQqQEzcXfyo5IX5tr/HMFk/RN3nbpcdMy5gjv8vrsaVNVHi+qPKVCXzkZ0eM
         yfE08YhW5K2q26Nx6d1nEUZ9Hz6fxwNLormkx3rJUn9BCZ/xBRms3IPf7Ay5K00g9mQV
         inpU7lrjB0AWX/ZtiZ4NXI/Xo/qmC6q61ohaL5CfC8dpjfkmopGr/pGrK285Pg9gNbgd
         zhubqYEk5j2Hw8gefpb408imkR10/8ciJH1DEn3aQiC1NnTHp4XC/sqQnRCZilXv24F7
         vWig==
X-Gm-Message-State: AOJu0YzFN/HLsUWFwMz7qz+Th2NyXSjFGqfjxjWbd03Ax/xu/UXivwcE
        FrYOomFSD9LCYg/p4kj0kixEQa7NDF1zxpzOYRhMRFw9k4eq0UMElF0LoekpFFY91spq4a8vEbd
        ehvfLvJZArFbeCAL2FiBDHGKh
X-Received: by 2002:a5d:61cb:0:b0:319:72f8:7244 with SMTP id q11-20020a5d61cb000000b0031972f87244mr2417296wrv.45.1692211911088;
        Wed, 16 Aug 2023 11:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkw36gfcTqZLfGe6fvzuvk3c/0RMFriiw5wDtDf1AXCImRHO+Rgy+5/Lzlo6c2Vejeu3Bgcw==
X-Received: by 2002:a5d:61cb:0:b0:319:72f8:7244 with SMTP id q11-20020a5d61cb000000b0031972f87244mr2417280wrv.45.1692211910741;
        Wed, 16 Aug 2023 11:51:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:8b00:5520:fa3c:c527:592f? (p200300cbc74b8b005520fa3cc527592f.dip0.t-ipconnect.de. [2003:cb:c74b:8b00:5520:fa3c:c527:592f])
        by smtp.gmail.com with ESMTPSA id t18-20020adff612000000b00317b0155502sm22222551wrp.8.2023.08.16.11.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:51:50 -0700 (PDT)
Message-ID: <ae8ea59e-3081-072b-faa0-b67a5d5af047@redhat.com>
Date:   Wed, 16 Aug 2023 20:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
 <ZN0YSOQmSR/voPVO@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN0YSOQmSR/voPVO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.23 20:41, Matthew Wilcox wrote:
> On Wed, Aug 16, 2023 at 03:33:30PM +0200, David Hildenbrand wrote:
>> My simple tests passed so far. If there isn't something obvious missing,
>> I can do more testing and send this as an official patch.
> 
> I think you missed one:
> 
> +++ b/mm/swapfile.c
> @@ -1490,7 +1490,7 @@ int swp_swapcount(swp_entry_t entry)
> 
>          page = vmalloc_to_page(p->swap_map + offset);
>          offset &= ~PAGE_MASK;
> -       VM_BUG_ON(page_private(page) != SWP_CONTINUED);
> +       VM_BUG_ON(page_swap_entry(page).val != SWP_CONTINUED);

That falls under the "weird handling of SWP_CONTINUED using vmalloced 
pages". So different user of page_private().

Note that we don't even store swap entries in there but extended swap 
counts.

> 
>          do {
>                  page = list_next_entry(page, lru);
> 
> I'm not smart enough to understand the use of the one in
> add_swap_count_continuation().  Maybe that also needs to be fixed?

No, that's independent of THP_SWAP, we're not working on the memmap of 
the THP but some weird extension of swap counts.

Thanks for having a look!

-- 
Cheers,

David / dhildenb

