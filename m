Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780977F6388
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjKWQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjKWQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4525D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700755542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RRtIFBoPBzE/FobRQYYxz246Ah3qVNy0JGp2H8XHqkc=;
        b=P1Wob+J9aX0NcokTZSVc7OnE41FNWl+tpC3ankrRmiVnrGa7Htl1LMF698kH34pJGI7Tpt
        yqDbj6Q1IqhEV6gEklhHusfDq+U1J/XXh7/rwSEu7cQwzEnSKD3GCBfoRyMv/48cjkJ+fY
        vQQu3oattiFvHUdyRD+PtWdFfA7skjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WaCPyg30Pm-5ChaB8jjaAw-1; Thu, 23 Nov 2023 11:05:41 -0500
X-MC-Unique: WaCPyg30Pm-5ChaB8jjaAw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b346a11d9so4969085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755540; x=1701360340;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRtIFBoPBzE/FobRQYYxz246Ah3qVNy0JGp2H8XHqkc=;
        b=gkNGx2wiEIr0izbKmZjXnUA+fmRMVKMLounCm6f7yKCD1iWq8GzG1aU0RnOm7WxXw2
         910J9G1ExfPJXtMeM9HBcG6xHESA1SQ3q5drfe2swTZhdTAvB5XTTgYPTwA6TdcZeGqn
         LGAZ0ZoAdW9YA5GnivUUTTXWaTlI4Z4X6y4JrumDZ9nhq9DAAwVkNeIwL+y/w15oTQqy
         QJjojXiv/0kToHJyNk0gqiI3ARDTmg6IQmYGg4MWGHefa31cnW32LM71wS0M3nLhaBAF
         DS8Fm5+d8GjWx+rVIQujz+aIHy6OFfZOr45ZKXHGtUPyktpwKMRAeSAOUIuIIPSZllG6
         ztJQ==
X-Gm-Message-State: AOJu0Yy4bU/XUXbiNTKDHlswXq0FYVIUvHSuf8ROitQiFfGjhW4n8guB
        fSaqHEMOpTGBihMkOKPJfQ2/zj0XPZN3JmkLN9tT8RSLzLkoPkxxrMVoGEsPlkDFIRVkAxRxVnK
        huw4PlEwM6Rs3k5L+YdgvkSHl
X-Received: by 2002:a05:600c:1f8c:b0:40b:2baa:6a0d with SMTP id je12-20020a05600c1f8c00b0040b2baa6a0dmr54091wmb.1.1700755540217;
        Thu, 23 Nov 2023 08:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAF3u8rCobw+yzzf0l1YTdcsLEiCyiCdIieHFhT5mscofTHpYupA4UEDHjOxJfYI41C+sGBA==
X-Received: by 2002:a05:600c:1f8c:b0:40b:2baa:6a0d with SMTP id je12-20020a05600c1f8c00b0040b2baa6a0dmr54066wmb.1.1700755539833;
        Thu, 23 Nov 2023 08:05:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:c800:ed2f:91bf:8c46:7078? (p200300cbc716c800ed2f91bf8c467078.dip0.t-ipconnect.de. [2003:cb:c716:c800:ed2f:91bf:8c46:7078])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm2005552wrc.95.2023.11.23.08.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 08:05:39 -0800 (PST)
Message-ID: <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
Date:   Thu, 23 Nov 2023 17:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZV9267tQEhoPzCru@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 16:59, Matthew Wilcox wrote:
> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>> Note: I'm resending this at Andrew's suggestion due to having originally sent
>> it during LPC. I'm hoping its in a position where the feedback is minor enough
>> that I can rework in time for v6.8, but so far haven't had any.
>>
>> Hi All,
>>
>> This is v7 of a series to implement small-sized THP for anonymous memory
>> (previously called "large anonymous folios"). The objective of this is to
> 
> I'm still against small-sized THP.  We've now got people asking whether
> the THP counters should be updated when dealing with large folios that
> are smaller than PMD sized.  It's sowing confusion, and we should go
> back to large anon folios as a name.
> 

I disagree.

https://lore.kernel.org/all/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com/

-- 
Cheers,

David / dhildenb

