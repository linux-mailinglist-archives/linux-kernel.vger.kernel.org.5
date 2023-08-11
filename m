Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C57793E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHKQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E910DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691770088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wnNWC3leEd4YQ5EPgUFxw6Yj6kDHVhdCPp1VE/clPHc=;
        b=DHrVEijfECJOLYapIGGNGN0fRvTkNIACeKdL38cmnUy/5OH8eCYzEVJ7ARyFz8uqxZ0/Rx
        MGxUII2Wtlm6pCzEBXLzRWbgMMuNZemiffdDnlBaD/lzg4dJFxADlVXUFaPPmGd9gESd4X
        6oEqztsPl9fKSrTxJJmd5x2A/lf0ffs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-DdGX9aFCOqSHFmo39VrI8g-1; Fri, 11 Aug 2023 12:08:07 -0400
X-MC-Unique: DdGX9aFCOqSHFmo39VrI8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3180237cef3so1365967f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770086; x=1692374886;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnNWC3leEd4YQ5EPgUFxw6Yj6kDHVhdCPp1VE/clPHc=;
        b=mFElJcEBg8Z3tsXeZiZOGXkBeiclxg/vcjfODOgQsYefiTVF8HnpE9N4e0Ag9OFPEO
         pGcRwyAqbHHQoDfu8NehTveplzrejzq2gF5V4oQ+tn23PBHCeO6rZKLaAJJSTSepns7O
         3odp4b4pkeCYc3umvvWNW0R/O2ur1Jm+QDrwRBqk/6b6B4rK5zvWrmfAYe0FtUCqZmqL
         AJRlAxv+A0JTGLukE1FIupQOu88xfC60kCseOoqWRiKF8TwS+7G8a5nkY2dyMNzcdVq7
         120xNxv3BIRphIVfbZDGea9ATisyPxaMPuuzYQ2YMC+y0WJEDabqyckrjvzzSCv6j0wP
         vm5w==
X-Gm-Message-State: AOJu0YyJsq6zyPRfDB2T9967tbftyXlrcpE6X9nD1cTFGB/Y0+9DUwK0
        BTSzk7puiv38cxtbie0NH87ue7CtKGuotRGhu7Kv2sQLr5g3h5wS/0LcWubqrQgdoyZZ62T+hYI
        KfT/I5AHEzqgh8k1+U5SezMT0
X-Received: by 2002:adf:fd48:0:b0:314:350a:6912 with SMTP id h8-20020adffd48000000b00314350a6912mr1715852wrs.36.1691770085771;
        Fri, 11 Aug 2023 09:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrCVHHy0keAZNZlWvZJqO3gdTTnGDDr1UiranO3vu16FZrqFM7gBospavYb2z52DyfR80sA==
X-Received: by 2002:adf:fd48:0:b0:314:350a:6912 with SMTP id h8-20020adffd48000000b00314350a6912mr1715830wrs.36.1691770085388;
        Fri, 11 Aug 2023 09:08:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20? (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de. [2003:cb:c71a:3000:973c:c367:3012:8b20])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b003142c85fbcdsm5839243wrv.11.2023.08.11.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:08:04 -0700 (PDT)
Message-ID: <8aac858e-0f12-4b32-e9df-63c76bdf2377@redhat.com>
Date:   Fri, 11 Aug 2023 18:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com> <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com> <ZNVPJ9xxd2oarR3I@x1n>
 <ZNVbObUGbos73ZJ5@casper.infradead.org>
 <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com> <ZNZRTmvkAlm4yeAd@x1n>
 <b001adf2-238d-1708-673d-6f512a53e1e9@redhat.com> <ZNZarsR7cVn/QH+H@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNZarsR7cVn/QH+H@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 17:58, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 05:32:37PM +0200, David Hildenbrand wrote:
>> On 11.08.23 17:18, Peter Xu wrote:
>>> On Fri, Aug 11, 2023 at 12:27:13AM +0200, David Hildenbrand wrote:
>>>> On 10.08.23 23:48, Matthew Wilcox wrote:
>>>>> On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
>>>>>> AFAICS if that patch was all correct (while I'm not yet sure..), you can
>>>>>> actually fit your new total mapcount field into page 1 so even avoid the
>>>>>> extra cacheline access.  You can have a look: the trick is refcount for
>>>>>> tail page 1 is still seems to be free on 32 bits (if that was your worry
>>>>>> before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.
>>>>>
>>>>> No, refcount must be 0 on all tail pages.  We rely on this in many places
>>>>> in the MM.
>>>>
>>>> Very right.
>>>
>>> Obviously I could have missed this in the past.. can I ask for an example
>>> explaining why refcount will be referenced before knowing it's a head?
>>
>> I think the issue is, when coming from a PFN walker (or GUP-fast), you might
>> see "oh, this is a folio, let's lookup the head page". And you do that.
>>
>> Then, you try taking a reference on that head page. (see try_get_folio()).
>>
>> But as you didn't hold a reference on the folio yet, it can happily get
>> freed + repurposed in the meantime, so maybe it's not a head page anymore.
>>
>> So if the field would get reused for something else, grabbing a reference
>> would corrupt whatever is now stored in there.
> 
> Not an issue before large folios, am I right?  Because having a head page
> reused as tail cannot happen iiuc with current thps if only pmd-sized,
> because the head page is guaranteed to be pmd aligned physically.

There are other users of compound pages, no? THP and hugetlb are just 
two examples I think. For example, I can spot __GFP_COMP in slab code.

Must such compound pages would not be applicable to GUP, though, but to 
PFN walkers could end up trying to grab them.

> 
> I don't really know, where a hugetlb 2M head can be reused by a 1G huge
> later right during the window of fast-gup walking. But obviously that's not
> common either if that could ever happen.
> 
> Maybe Matthew was referring to something else (per "in many places")?

There are some other cases where PFN walkers want to identify tail pages 
to skip over them. See the comment in has_unmovable_pages().

-- 
Cheers,

David / dhildenb

