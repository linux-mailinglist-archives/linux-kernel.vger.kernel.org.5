Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37A87C8E31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJMUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjJMUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1EB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697228095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqkyuKTLeif6mbOtJo/ug3/H7Xljs9fGbBdrTOe8vqc=;
        b=KTZ/mVr2495Yns8+xhvhLfAKBEMEvGBto8DpMFpukvIBwkKMWmDNRSUNZAbBYn7YcEkAg9
        LWikVbf125B1MLeaJekcNKytGl1puVLUEsf3gSVSsZeL7n2abXuME5kMzmHjRXb5qjpFNf
        fKxXRZJ7QJaEJwRdN3r5kWBU56t/8tE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-2vvZ9Yh0NFCbEXLoUJ1xAQ-1; Fri, 13 Oct 2023 16:14:43 -0400
X-MC-Unique: 2vvZ9Yh0NFCbEXLoUJ1xAQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d879cac50so1460190f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697228082; x=1697832882;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqkyuKTLeif6mbOtJo/ug3/H7Xljs9fGbBdrTOe8vqc=;
        b=jzmkAAJhEwWlZxGAdTqu039gi+EhhkYrWpt4x54dwAJTip5oZwM+mOkLVbbMIb/llY
         ja0EGuktowCVih2zDFe1leQsSDI7LykCUOTR2s3GLlNviyppS07ys+it/f+TAgJkdU2D
         A509HiVMWpzDCWiYJz1yoneNk7EdFGh+SJQwkq2tq6UQZ29Fzjuvfdm4k7kZfPM+B5o5
         8fRcF4KnthskQRWQ6nXrS9UKN0crOkKPmjT53Jrypqd10CfOpy5YJ+h9vIOtLog3Wyj6
         yK2tZO0we0P3yu4o9BFlVTvQ+xqGa1Bifa+X+lEkH0BOhApa0kOcJqVRzYUafcUpFIkt
         DB7Q==
X-Gm-Message-State: AOJu0YyVxNNMbp8CBVetnYUJ5NBtbt1xBGl0mrPyzGM47+bLhzVQOtSl
        aVsK8WrnASeWBRXc1f2/jYlF0DwaAy6yWYUNlBGnbSNPqx2DDk8F5rA/ulosKEAPqx5lzhPJPWU
        7/gScGkCzLcoPRA7eNsOhUq7b
X-Received: by 2002:a5d:46ca:0:b0:32d:9df1:6f68 with SMTP id g10-20020a5d46ca000000b0032d9df16f68mr2155123wrs.22.1697228081841;
        Fri, 13 Oct 2023 13:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvcCrvmO9S0f+ou/Lb5JoNjHQYcvMkd/qs+BghB6/pfa8BnKb5+wcuGyKUhPpRNY7cZiBgMQ==
X-Received: by 2002:a5d:46ca:0:b0:32d:9df1:6f68 with SMTP id g10-20020a5d46ca000000b0032d9df16f68mr2155113wrs.22.1697228081281;
        Fri, 13 Oct 2023 13:14:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9300:1381:43e2:7c78:b68f? (p200300cbc7189300138143e27c78b68f.dip0.t-ipconnect.de. [2003:cb:c718:9300:1381:43e2:7c78:b68f])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b0040644e699a0sm72387wmq.45.2023.10.13.13.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 13:14:40 -0700 (PDT)
Message-ID: <5b457c48-d600-c4be-72d4-2cd8213e9307@redhat.com>
Date:   Fri, 13 Oct 2023 22:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <c603a458-21b5-4028-93c3-2b1bf8a12047@arm.com>
 <99f8294b-b4e5-424f-d761-24a70a82cc1a@redhat.com>
 <15a52c3d-9584-449b-8228-1335e0753b04@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
In-Reply-To: <15a52c3d-9584-449b-8228-1335e0753b04@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Yes, I think there are various ways forward regarding that. Or to enable "auto"
>> mode only once all are "auto", and as soon as one is not "auto", just disable
>> it. A simple
>>
>> echo "auto" > /sys/kernel/mm/transparent_hugepage/hugepages-*/enabled
> 
> I'm not really a fan, because this implies that you have a period where "auto"
> is reported for a size, but its not really in "auto" mode yet.

I think there are various alternatives that are feasible.

For most systems later, you'd want to just "auto" via compile-time 
CONFIG option as default or via some cmdline option like 
"transparent_hugepage=auto".

> 
>>
>> Would do to enable it. Or, have them all be "global" and have a global "auto"
>> mode as you raised.
>>
>> echo "global" > /sys/kernel/mm/transparent_hugepage/hugepages-*/enabled
>> echo "auto" > /sys/kernel/mm/transparent_hugepage/enabled
>>
> 
> Again, this isn't atomic either. I tend to prefer my proposal because it
> switches atomically - there are no weird intermediate states. Anyway, I guess
> the important point is we have demonstrated that your proposed interface could
> be extended to support "auto" in future, should we need it.

I don't think the atomic switch is really relevant. But that's probably 
a separate discussion.

[...]

>>
>> Just because a small-sized THP is PTE-mapped doesn't tell you anything, really.
>> What you want to know is if it is "completely" and "consecutively" mapped such
>> that the HW can actually benefit from it -- if HW even supports it. So
>> "PTE-mapped THP" is just part of the story. And that's where it gets tricky I
>> think.
>>
>> I agree that it's good for debugging, but then maybe it should a) live somewhere
>> else (debugfs, bucketing below) and b) be consistent with other THPs, meaning we
>> also want similar stats somewhere.
>>
>> One idea would be to expose such stats in a R/O fashion like "nr_allocated" or
>> "nr_hugepages" in /sys/kernel/mm/transparent_hugepage/hugepages-64kB/ and
>> friends. Of course, maybe tagging them with "anon" prefix.
> 
> I see your point, but I don't completely agree with it all. That said, given
> your conclusion at the bottom, perhaps we should park the discussion about the
> accounting for a separate series in future? Then we can focus on the ABI?

Yes!

> 
>>
>>>
>>> I would actually argue for adding similar counters for file-backed memory too
>>> for the same reasons. (I actually posted an independent patch a while back that
>>> did this for file- and anon- memory, bucketted by size. But I think the idea of
>>> the bucketting was NAKed.
>> For debugging, I *think* it might be valuable to see how many THP of each size
>> are allocated. Tracking exactly "how is it mapped" is not easy to achieve as we
>> learned. PMD-mapped was easy, but also requires us to keep doing that tracking
>> for all eternity ...
>>
>> Do you have a pointer to the patch set? Did it try to squeeze it into
>> /proc/meminfo?
> 
> I was actually only working on smaps/smaps_rollup, which has been my main tool
> for debugging. patches at [1].
> 
> [1] https://lore.kernel.org/linux-mm/20230613160950.3554675-1-ryan.roberts@arm.com/
> 

Thanks for the pointer!

[...]

>>>
>>> I'll need some help with clasifying them, so showing my working. Final list that
>>> I would propose as strict requirements at bottom.
>>>
>>> This is my list with status, as per response to Yu in other thread:
>>>
>>>     - David is working on "shared vs exclusive mappings"
>>
>> Probably "COW reuse support" is a separate item, although my approach would
>> cover that.
> 
> Yeah that's the in the original thread as (2), but I thought we were all agreed
> that is not a prerequisite so didn't bring it over here.

Agreed. Having a full list of todo items might be reasonable.

> 
>>
>> The question is, if the estimate we're using in most code for now would at least
>> be sufficient to merge it. The estimate is easily wrong, but we do have that
>> issue with PTE-mapped THP already.
> 
> Well as I understand it, at least the NUMA balancing code and khugepaged are
> ignoring all folios > order-0. That's probably ok for the occasional PTE-mapped
> THP, but I assume it becomes untenable if large folios are the norm. Perhaps we
> can modify those paths to work with the current estimators in order to remove
> your work from the critical path - is that what you are getting at?

IMHO most of the code that now uses the estimate-logic is really 
suboptimal, but it's all we have. It's probably interesting to see where 
the false negative/positives are tolerable for now ... I hate to be at 
the critical path ;) But I'm getting somewhere slowly but steadily 
(slowly, because I'm constantly distracted -- and apparently sick).

[...]

>>
>>
>>> Although, since sending that, I've determined that when running kernel
>>> compilation across high number of cores on arm64, the cost of splitting the
>>> folios gets large due to needing to broadcast the extra TLBIs. So I think the
>>> last point on that list may be a prerequisite after all. (I've been able to fix
>>> this by adding support for allocating large folios in the swap file, and
>>> avoiding the split - planning to send RFC this week).
>>>
>>> There is also this set of things that you mentioned against "shared vs exclusive
>>> mappings", which I'm not sure if you are planning to cover as part of your work
>>> or if they are follow on things that will need to be done:
>>>
>>> (1) Detecting shared folios, to not mess with them while they are shared.
>>>       MADV_PAGEOUT, user-triggered page migration, NUMA hinting, khugepaged ...
>>>       replace cases where folio_estimated_sharers() == 1 would currently be the
>>>       best we can do (and in some cases, page_mapcount() == 1).
>>>
>>> And I recently discovered that khugepaged doesn't collapse file-backed pages to
>>> a PMD-size THP if they belong to a large folio, so I'm guessing it may also
>>> suffer the same behaviour for anon memory. I'm not sure if that's what your
>>> "khugepaged ..." comment refers to?
>>
>> Yes. But I did not look into all the details yet.
>>
>> "kuhepaged" collapse support to small-sized THP is probably also a very imporant
>> item, although it might be less relevant than for PMD -- and I consider it
>> future work. See below.
> 
> Yes I agree that it's definitely future work. Nothing regresses from today's
> performance if you don't have that.
> 
>>
>>>
>>> So taking all that and trying to put together a complete outstanding list for
>>> strict requirements:
>>>
>>>     - Shared vs Exclusive Mappings (DavidH)
>>>         - user-triggered page migration
>>>         - NUMA hinting/balancing
>>>         - Enhance khugepaged to collapse to PMD-size from PTE-mapped large folios
>>>     - Compaction of Large Folios (Zi Yan)
>>>     - Swap out small-size THP without Split (Ryan Roberts)
>>
>> ^ that's going to be tough, I can promise. And the only way to live without that
>> would be khugepaged support. (because that's how it's all working for PMD-sized
>> THP after all!)
> 
> Are you referring specifically to the "swap out" line there? If so, it wasn't my
> plan that we would *swap in* large folios - only swap them *out* as large folios

Ah!

> to avoid the cost of splitting. Then when they come back in, the come in as
> single pages, just like PMD-sized THP, if I've understood things correctly. I
> have a patch working and showing the perf improvement as a result. I'm planning
> to post an RFC today, hopefully.
> 
> I don't see the swap-in side as a problem for the initial patch set. OK, they
> come in as single pages, so you lost the potential TLB benefits. But that's no
> worse than today's performance so not a regression. And the ratio of SW savings
> on THP allocation to HW savings from the TLB is very different for small-sized
> THP; much more of the benefit comes from the SW and that's still there.
> 
>>
>> Once a PMD-sized THP was swapped out and evicted, it will always come back in
>> order-0 folios. khugeged will re-collapse into PMD-sized chunks. If we could do
>> that for PTE-sized THP as well ...
> 
> Yes, sure, but that's a future improvement, not a requirement to prevent
> regression vs today, right?

Yes. You can't just currently assume: as soon as you swap, the whole 
benefit is gone because you end up will all order-0 pages.

These are certainly not limiting "merge" factors IMHO, but it's 
certainly one of the things users of distributions will heavily complain 
about ;)

PMD-sized THP are mostly self-healing in that sense.

> 
>>
>>>
>>>
>>>>
>>>>
>>>> Now, these are just my thoughts, and I'm happy about other thoughts.
>>>
>>> As always, thanks for taking the time - I really appreciate it.
>>
>> Sure. Hoping others can comment.
>>
>> My gut feeling is that it's best to focus on getting the sysfs interface
>> right+future proof and handling the stats independently. While being a good
>> debug mechanism, I wouldn't consider these stats a requirement: we don't have
>> them for file/shmem small-sized thp so far as well.
>>
>> So maybe really better to handle the stats in meminfo and friends separately.
>>
> 
> I'd be very happy with that approach if others are bought in.

Yeah. I'm expecting there still to be discussions, but then we shall 
also here other proposals. memcg controls are IMHO certainly future work.

-- 
Cheers,

David / dhildenb

