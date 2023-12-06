Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368FD806BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377337AbjLFKXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377335AbjLFKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB439D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701858185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jq8nL+CD+mR1CiAuFz6mufGPWoKHMp+SCfReE8TYqDk=;
        b=QuHyRZOFNtkTE/XG9e5S5VtnCNCFRs4JTyD7HzDn0jd3nw/jQmfILLbgFPv9nb8Cljkbpt
        IyzCfj0l4sXjilrG0oUI99XM+8ps4hfSjl2vPi9yTuTdDOhj+aDLW6TzbAh/irbcQFy29o
        48J9+VCR5ws8aKegitxtxeMP7WHL5ak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-gFphZPQmMHuBoKNpYvrJsA-1; Wed, 06 Dec 2023 05:23:03 -0500
X-MC-Unique: gFphZPQmMHuBoKNpYvrJsA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3334b1055fbso521446f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858182; x=1702462982;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq8nL+CD+mR1CiAuFz6mufGPWoKHMp+SCfReE8TYqDk=;
        b=YVb2udLW+4H30F+5WukMc7cepR/mDYq2ANxofG7HAFYuUhUVV27vru1YBurbgkoC7J
         3BmhRLKjBAIbSLXCBuJvn8Y7j3umAkzSubLyyO52bbaaxRtJBHb6V4sCWVIBqn9y6O1x
         5Jj/9rjH6wflyhJVD01KXTSUMH5WYRGR7fW7Z+2blosJIkhWNTk8+i34MIqb4SWEjo/e
         yWEBJN272yMgNiuJWIjudeuNg2imR4gTrrL+ivAt3bu91nhb+/3HKRHuOiPNXbp4Srvb
         q7+Ty3n4cISAlz9eKtpF9OdFl9wzj6of540cUNCBlVfn87+eFbNDYL+R2KLuNXJ1Ltq5
         k0kg==
X-Gm-Message-State: AOJu0YwKvS83/hR34WfNUj2e6gIwcfxGQXC9xw0qL+rCpbcdR0AEJ8ZT
        pRwGTq0Nrj8qluc1Mf+N+HffV84nvS5Ya1m+WC25L2OM/a0jzndlo73V4R/ovthrxxI4GlI5C5i
        IvcrhkhWKo4oAyzY+TgX7dX6k
X-Received: by 2002:adf:fd06:0:b0:333:14ff:a33f with SMTP id e6-20020adffd06000000b0033314ffa33fmr233718wrr.21.1701858181881;
        Wed, 06 Dec 2023 02:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0uRN+5iInKq4TWIHFK/wkcE5T+JAgNGBJBNSzj7PtS29sgQtALyPAB3Oxl0HE8kWOXAwyHw==
X-Received: by 2002:adf:fd06:0:b0:333:14ff:a33f with SMTP id e6-20020adffd06000000b0033314ffa33fmr233696wrr.21.1701858181243;
        Wed, 06 Dec 2023 02:23:01 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id y5-20020adffa45000000b00333320cf08bsm13753878wrr.102.2023.12.06.02.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 02:23:00 -0800 (PST)
Message-ID: <7d3457cd-5e3d-42a7-8113-545da646d7c8@redhat.com>
Date:   Wed, 6 Dec 2023 11:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <8d5fdb17-c670-4814-8f48-4b90062668fc@redhat.com>
 <f65baa0c-3f5a-45ad-80dd-c240fe166877@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f65baa0c-3f5a-45ad-80dd-c240fe166877@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.23 11:13, Ryan Roberts wrote:
> On 05/12/2023 17:21, David Hildenbrand wrote:
>> On 04.12.23 11:20, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> A new week, a new version, a new name... This is v8 of a series to implement
>>> multi-size THP (mTHP) for anonymous memory (previously called "small-sized THP"
>>> and "large anonymous folios"). Matthew objected to "small huge" so hopefully
>>> this fares better.
>>>
>>> The objective of this is to improve performance by allocating larger chunks of
>>> memory during anonymous page faults:
>>>
>>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>>      pages, there are efficiency savings to be had; fewer page faults, batched PTE
>>>      and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>>      overhead. This should benefit all architectures.
>>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>>      advantage of HW TLB compression techniques. A reduction in TLB pressure
>>>      speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>>>      TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>>
>>> This version changes the name and tidies up some of the kernel code and test
>>> code, based on feedback against v7 (see change log for details).
>>>
>>> By default, the existing behaviour (and performance) is maintained. The user
>>> must explicitly enable multi-size THP to see the performance benefit. This is
>>> done via a new sysfs interface (as recommended by David Hildenbrand - thanks to
>>> David for the suggestion)! This interface is inspired by the existing
>>> per-hugepage-size sysfs interface used by hugetlb, provides full backwards
>>> compatibility with the existing PMD-size THP interface, and provides a base for
>>> future extensibility. See [8] for detailed discussion of the interface.
>>>
>>> This series is based on mm-unstable (715b67adf4c8).
>>
>> I took a look at the core pieces. Some things might want some smaller tweaks,
>> but nothing that should stop this from having fun in mm-unstable, and replacing
>> the smaller things as we move forward.
>>
> 
> Thanks! I'll address your comments and see if I can post another (final??)
> version next week.

It's always possible to do incremental changes on top that Andrew will 
squash in the end. I even recall that he prefers that way once a series 
has been in mm-unstable for a bit, so one can better observe the diff 
and which effects they have.

-- 
Cheers,

David / dhildenb

