Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799F7C7185
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379229AbjJLPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjJLPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D2BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697124638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFdUa2CPCu3i7sYwk8S5CwMezdoReJ8iWYq2uB+Ck3s=;
        b=NkGUI6kA1RHeH3/0xehleX7Qw70dyhhf+GARfm7q7J+WT1LnYFgGt8WfBaR2W+uAyok80s
        9b7Rn23ohbcfv4I0dDjUflm9YTLF9k0IHa/C5UcsuJGPjODnuB3RXOrQa+OAZ3v6tG9qji
        fg7FZUfGYO1Vt8sE41zTVHXd0iAU6LM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Ki_0HSg2ODCi6M3MCAwg7w-1; Thu, 12 Oct 2023 11:30:37 -0400
X-MC-Unique: Ki_0HSg2ODCi6M3MCAwg7w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4065d52a83aso7480085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124636; x=1697729436;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFdUa2CPCu3i7sYwk8S5CwMezdoReJ8iWYq2uB+Ck3s=;
        b=d1FDyvHLBVqcFDYS8sw8f5ES9NLJ6IBSqRh4y7kdv3Siz+t/jOH/8G9ozT0etOdB+O
         wrV9VFfCWJFCvEev+rVWDFRb07niVJGscz2Rx26IenFl85TFREM8+SQyYcIM7Wn++Dxf
         08PNoUzatB+WlYKKklR98MavFtdQIHra/J0V2V36RrPuPZoLVcukGLo72Yi4bDFDNvhT
         PZZNlZy/yH32hrpXm+ibFGr5Dun1HYh4KT9+o645soiV20D+rfZcI8yFpvGO5Xfb55dd
         eTVpQlFa8NpV6XqFXSZ9S2cPXvUIt8T/VweccCnaH2MEF9FFQHkm861/RMDdIL9jORPU
         bI+A==
X-Gm-Message-State: AOJu0YwQkmZ9OHQP6ma+JNhblUeiuIubrU8hvDo94HSuRX6z+5IfREWf
        7M3RCAH2EVb9HiO/k/p+/Z2P1nMZQFZyYKWbVuRjkJpE8mLcY6Kcp7HhcI4BCSmzzmmnRcqRKRZ
        47FaQENQU2jgcUcvIAdguy/gE
X-Received: by 2002:a7b:c3d2:0:b0:405:75f0:fd31 with SMTP id t18-20020a7bc3d2000000b0040575f0fd31mr20064794wmj.31.1697124636156;
        Thu, 12 Oct 2023 08:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtJtQTMnQG+Tsh4UL3W3AKqxit8Jw3iKnOAMoNj4iNXQxpEZQFCuOeLvDRfbf79nwAtAIy0w==
X-Received: by 2002:a7b:c3d2:0:b0:405:75f0:fd31 with SMTP id t18-20020a7bc3d2000000b0040575f0fd31mr20064764wmj.31.1697124635646;
        Thu, 12 Oct 2023 08:30:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:ee00:b271:fb6c:a931:4769? (p200300cbc70dee00b271fb6ca9314769.dip0.t-ipconnect.de. [2003:cb:c70d:ee00:b271:fb6c:a931:4769])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004067e905f44sm141868wmi.9.2023.10.12.08.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:30:35 -0700 (PDT)
Message-ID: <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
Date:   Thu, 12 Oct 2023 17:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
 <20231012150226.GA473412@u2004>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
In-Reply-To: <20231012150226.GA473412@u2004>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.23 17:02, Naoya Horiguchi wrote:
> On Thu, Oct 12, 2023 at 10:33:04AM +0200, David Hildenbrand wrote:
>> On 10.10.23 16:27, Naoya Horiguchi wrote:
>>> Hi everyone,
>>>
>>> This patchset addresses 2 issues in /proc/kpageflags.
>>>
>>>     1. We can't easily tell folio from thp, because currently both pages are
>>>        judged as thp, and
>>>     2. we see some garbage data in records of compound tail pages because
>>>        we use tail pages to store some internal data.
>>>
>>> These issues require userspace programs to do additional work to understand
>>> the page status, which makes situation more complicated.
>>>
>>> This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
>>> by hiding part of page flag info on tail pages of compound pages for issue 2.
>>>
>>> I think that technically some compound pages like thp/hugetlb/slab could be
>>> considered as folio, but in this version KPF_FOLIO is set only on folios
>>
>> At least thp+hugetlb are most certainly folios. Regarding slab, I suspect we
>> no longer call them folios (cannot be mapped to user space). But Im not sure
>> about the type hierarchy.
> 
> I'm not sure about the exact definition of "folio", and I think it's better
> to make KPF_FOLIO set based on the definition.

Me neither. But in any case a THP *is* a folio. So you'd have to set 
that flag in any case.

And any order-0 page (i.e., anon, pagecache) is also a folio. What you 
seem to imply with folio is "large folio". So KPF_FOLIO is really wrong 
as far as I can tell.

> "being mapped to userspace" can be one possible criteria for the definition.
> But reading source code, folio_slab() and slab_folio() convert between
> struct slab and struct folio, so I feel that someone might think a slab is
> a kind of folio.

I keep forgetting if "folio" is just the generic term for any order-0 or 
compound page, or only for some of them. I usually live in the "anon" 
world, so I don't get reminded that often :)


>>> in pagecache (so "folios in narrower meaning").  I'm not confident about
>>> this choice, so if you have any idea about this, please let me know.
>>
>> It does sound inconsistent. What exactly do you want to tell user space with
>> the new flag?
> 
> The current most problematic behavior is to report folio as thp (order-2
> pagecache page is definitely a folio but not a thp), and this is what the
> new flag is intended to tell.

We are currently considering calling these sub-PMD sized THPs 
"small-sized THP". [1] Arguably, we're starting with the anon part where 
we won't get around exposing them to the user in sysfs.

So I wouldn't immediately say that these things are not THPs. They are 
not PMD-sized THP. A slab/hugetlb is certainly not a thp but a folio. 
Whereby slabs can also be order-0 folios, but hugetlb can't.


Looking at other interfaces, we do expose:

include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_HEAD        15
include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_TAIL        16

So maybe we should just continue talking about compound pages or do we 
have to use both terms here in this interface?

[1] https://lkml.kernel.org/r/20230929114421.3761121-1-ryan.roberts@arm.com

-- 
Cheers,

David / dhildenb

