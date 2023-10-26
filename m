Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B804B7D85D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJZPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FCD7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698333553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UQTE/uZhwruB06To4tgPtgPqKLZ44cEicp3yc0ToX6I=;
        b=RUoKcMSJNekXI9qYeEKienSuWBvPNeXGNUuZCiJd3nZ/zESZUcTMUSpjBldZhzH+hTSOYG
        rrd1dlnLggqaGGmLmJHk35+FqJk1EbzxFcDtDm+Z/h5dzd3E+OhXfSHv+bC1EQRZ0iKwV3
        Xp2aiypFo+gQLGqXojIF8CKW+tUVMEQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-9UskHWXONW6W0ZvAtz4s4g-1; Thu, 26 Oct 2023 11:19:11 -0400
X-MC-Unique: 9UskHWXONW6W0ZvAtz4s4g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c50d4a1a33so10038901fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333550; x=1698938350;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQTE/uZhwruB06To4tgPtgPqKLZ44cEicp3yc0ToX6I=;
        b=mzINetK06niRBiJ5E3vaifDOvctNK/T6CJA8bYb96zFbedRu0oFwtM0D8L8ScwjS29
         rAzaff0CGoA6NEy8QrMQnhE4yH01QdKX1QJq4ALIU8Rsk18v72acwf/UpbxTnF1ptSTV
         5zdmeSZCh8dpilqS/TK/QRVgHHJvoS3VlilI3BzpqKD40YL9cyWOZD0LyLxclGCg6hrx
         GhjMBZ/++/JOYASqjBQ4VBNRea1AHdbk2VfeI+0e8fhi1ggwYhozrXYy2vMXMIDyBNNg
         M+c6bRAxrvXo2UguDur3R0qaowP4suMpl5oyrsNkL/zhvONuMIbsvwgJw0iKHFq3F/3j
         B9WQ==
X-Gm-Message-State: AOJu0YwGXWcgdiEPRDcenswUgnfYiKZ35PpN1UibsC9/t4w3cH4MBrVk
        YzWEukzBU7avqxn3LTsBF+4ZN/DawQdnY9N4IJM+1cfpYnrhgIbnxAu2RFldvnA72+yULKXj2Ei
        7aBbNl6Y71dDlLo3GtuN9tE2v
X-Received: by 2002:a05:651c:1986:b0:2c0:afd:e7ed with SMTP id bx6-20020a05651c198600b002c00afde7edmr16240974ljb.10.1698333550229;
        Thu, 26 Oct 2023 08:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfU2mribSa6z2ETboNhISsyPqjSF0pufFDYe0wqUQpcIX33OSr/AHoV1EO7y2II36o9a5FqA==
X-Received: by 2002:a05:651c:1986:b0:2c0:afd:e7ed with SMTP id bx6-20020a05651c198600b002c00afde7edmr16240950ljb.10.1698333549643;
        Thu, 26 Oct 2023 08:19:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:a900:cf04:d43b:114c:655a? (p200300cbc70da900cf04d43b114c655a.dip0.t-ipconnect.de. [2003:cb:c70d:a900:cf04:d43b:114c:655a])
        by smtp.gmail.com with ESMTPSA id r4-20020adff704000000b0032d88e370basm14491435wrp.34.2023.10.26.08.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 08:19:09 -0700 (PDT)
Message-ID: <f83b6fcd-71d8-442f-87d9-f95dd2ab2344@redhat.com>
Date:   Thu, 26 Oct 2023 17:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
 <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
 <a2e11353-fad8-475c-a4d1-dc1de22dde11@redhat.com>
 <CAOUHufa9CyfRaMFXWtFWPG22Z9Zf9hZZWbZdTke6THimtbPzRQ@mail.gmail.com>
 <ce723223-9751-4d57-af2d-86d30b2dd16a@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ce723223-9751-4d57-af2d-86d30b2dd16a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>> Hi,
>>>
>>> I wanted to remind people in the THP cabal meeting, but that either
>>> didn't happen or zoomed decided to not let me join :)
> 
> I didn't make it yesterday either - was having to juggle child care.

I think it didn't happen, or started quite late (>20 min).

> 
>>>
>>>>
>>>> It's been a week since the mm alignment meeting discussion we had around
>>>> prerequisites and the ABI. I haven't heard any further feedback on the ABI
>>>> proposal, so I'm going to be optimistic and assume that nobody has found any
>>>> fatal flaws in it :).
>>>
>>> After saying in the call probably 10 times that people should comment
>>> here if there are reasonable alternatives worth discussing, call me
>>> "optimistic" as well; but, it's only been a week and people might still
>>> be thinking about this/
>>>
>>> There were two things discussed in the call:
>>>
>>> * Yu brought up "lists" so we can have priorities. As briefly discussed
>>>     in the  call, this (a) might not be needed right now in an initial
>>>     version;  (b) the kernel might be able to handle that (or many cases)
>>>     automatically, TBD. Adding lists now would kind-of set the semantics
>>>     of that interface in stone. As you describe below, the approach
>>>     discussed here could easily be extended to cover priorities, if need
>>>     be.
>>
>> I want to expand on this: the argument that "if you could allocate a
>> higher order you should use it" is too simplistic. There are many
>> reasons in addition to the one above that we want to "fall back" to
>> higher orders, e.g., those higher orders are not on PCP or from the
>> local node. When we consider the sequence of orders to try, user
>> preference is just one of the parameters to the cost function. The
>> bottom line is that I think we should all agree that there needs to be
>> a cost function down the road, whatever it looks like. Otherwise I
>> don't know how we can make "auto" happen.

I agree that there needs to be a cost function, and as pagecache showed 
that's independent of initial enablement.

> 
> I don't dispute that this sounds like it could be beneficial, but I see it as
> research to happen further down the road (as you say), and we don't know what
> that research might conclude. Also, I think the scope of this is bigger than
> anonymous memory - you would also likely want to look at the policy for page
> cache folio order too, since today that's based solely on readahead. So I see it
> as an optimization that is somewhat orthogonal to small-sized THP.

Exactly my thoughts.

The important thing is that we should plan ahead that we still have the 
option to let the admin configure if we cannot make this work 
automatically in the kernel.

What we'll need, nobody knows. Maybe it's a per-size priority, maybe 
it's a single global toggle.

> 
> The proposed interface does not imply any preference order - it only states
> which sizes the user wants the kernel to select from, so I think there is lots
> of freedom to change this down the track if the kernel wants to start using the
> buddy allocator's state as a signal to make its decisions.

Yes.

[..]

>>> Jup, same opinion here. But again, I'm very happy to hear other
>>> alternatives and why they are better.
>>
>> I'm not against David's proposal but I want to hear a lot more about
>> "lots of flexibility for growth" before I'm fully convinced.
> 
> My point was that in an abstract sense, there are properties a user may wish to
> apply individually to a size, which is catered for by having a per-size
> directory into which we can add more files if/when requirements for new per-size
> properties arise. There are also properties that may be applied globally, for
> which we have the top-level transparent_hugepage directory where properties can
> be extended or added.

Exactly, well said.

> 
> For your case around tighter integration with the buddy allocator, I could
> imagine a per-size file allowing the user to specify if the kernel should allow
> splitting a higher order to make a THP of that size (I'm not suggesting that's a
> good idea, I'm just pointing out that this sort of thing is possible with the
> interface). And we have discussed how the global enabled prpoerty could be
> extended to support "auto" [1].
> 
> But perhaps what we really need are lots more ideas for future directions for
> small-sized THP to allow us to evaluate this interface more widely.

David R. motivated a future size-aware setting of the defrag option. As 
discussed we might want something similar to shmem_enable. What will 
happen with khugepaged, nobody knows yet :)

I could imagine exposing per-size boolean read-only properties like 
"native-hw-size" (PMD, cont-pte). But these things require much more 
thought.

-- 
Cheers,

David / dhildenb

