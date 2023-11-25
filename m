Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952947F8C95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjKYRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68819106
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700931730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=r2m8MsdEA6I0cTu0yk+FCxltGAW5Bh00EQieM20jSRA=;
        b=ACiQPqGVrQ5ubwx8Rfln7AYRUgKnUGMmdHL5IPrb9/R8vXPKhgnKhCqrxo/h/Oaw/UMVUz
        JkYvP/hPNf33tbf9jJJ5NEh/CeT+WyqnyCYorHsWhPQ1HFl47NOP4QzQ7nOHdOIVU2e/3d
        yOZH9Qy2Vo5hHi0hc8Peeqt/WjTZh7E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-vzlNlMWiNzGCiNdU_DUEKg-1; Sat, 25 Nov 2023 12:02:08 -0500
X-MC-Unique: vzlNlMWiNzGCiNdU_DUEKg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c52cbb64c9so24767721fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700931727; x=1701536527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2m8MsdEA6I0cTu0yk+FCxltGAW5Bh00EQieM20jSRA=;
        b=FPHtAr12QyqMh7Tv1HBDkH2nTj0shj9/xqH2HhuQD6a9l7cQC4NvlX2YsYRAonvLyk
         yv/F9aBlnAMpPQrHQnUAZGnbzd03Pjm0JgC69gDg0w2QOXIHIflr/g6jPYvryuunXCKC
         G3cQ2T8hsDIB5i+kTGgEMphPO8JbwmgDyT8gXzmHGwsDuZweiNO+IBRpuvCJKxEeMXfg
         T3hoL4GMH4zPtIskFIZiX0BMnjGBuVAD2rKLiZ86FqIX0W0q1btCBwE6UaLQVbiRAZJW
         PKGqz5YwD+VXbwRutl46Re4EpvYVJ6SzDLUufjjy4MhZjA9nv1FosaEbdod8j0cQi76Q
         K7nw==
X-Gm-Message-State: AOJu0Yw8AfrJz/YGfGpHxyFuGPF7mKFeyxfeGpQTkeOd6mA8u01ozMSy
        8uaRB4rjgr6CBCn5EFj9X1kc5aXL8ERd7ijkSTYCjrku6/sp/rPV1YsX/MHy6SUMNLttJ1Lx0aO
        z6+y6PgjGNUiH30iM/pzO1bgFLViPBM4r
X-Received: by 2002:a2e:874f:0:b0:2c5:22c0:582c with SMTP id q15-20020a2e874f000000b002c522c0582cmr4170872ljj.11.1700931727058;
        Sat, 25 Nov 2023 09:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkSc9qNO/RU7x/979BuNlQWnXjB5B5aW1x7IS06s2SVfHqBlHyueZqyw4NKTX9LSbNddAQ+Q==
X-Received: by 2002:a2e:874f:0:b0:2c5:22c0:582c with SMTP id q15-20020a2e874f000000b002c522c0582cmr4170859ljj.11.1700931726505;
        Sat, 25 Nov 2023 09:02:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:f000:d472:dd67:5dd2:10bd? (p200300cbc72bf000d472dd675dd210bd.dip0.t-ipconnect.de. [2003:cb:c72b:f000:d472:dd67:5dd2:10bd])
        by smtp.gmail.com with ESMTPSA id c37-20020a05600c4a2500b003fee6e170f9sm8222933wmp.45.2023.11.25.09.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 09:02:06 -0800 (PST)
Message-ID: <a9922f58-8129-4f15-b160-e0ace581bcbe@redhat.com>
Date:   Sat, 25 Nov 2023 18:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH WIP v1 00/20] mm: precise "mapped shared" vs. "mapped
 exclusively" detection for PTE-mapped THP / partially-mappable folios
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20231124132626.235350-1-david@redhat.com>
 <CAHk-=wgFRaS9FLJZEv0pbASVJ8rPSrTWHkYTmj83vRJh9Ehepw@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wgFRaS9FLJZEv0pbASVJ8rPSrTWHkYTmj83vRJh9Ehepw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 24.11.23 21:55, Linus Torvalds wrote:
> On Fri, 24 Nov 2023 at 05:26, David Hildenbrand <david@redhat.com> wrote:
>>
>> Are you interested in some made-up math, new locking primitives and
>> slightly unpleasant performance numbers on first sight? :)

Hi Linus,

first of all -- wow -- thanks for that blazing fast feedback! You really 
had to work through quite some text+code to understand what's happening.

Thanks for prioritizing that over Black Friday shopping ;)

> 
> Ugh. I'm not loving the "I have a proof, but it's too big to fit in
> the margin" model  of VM development.
> 
> This does seem to be very subtle.

Yes, compared to other kernel subsystems, this level of math in the VM 
is really new.

The main reason I excluded the proof in this WIP series is not the size, 
though. I wanted to get the implementation out after talking about it 
(and optimizing it ...) for way too long and (a) proofs involving 
infinite sequences in pure ascii are just horrible to read; (b) I think 
the proof can be cleaned-up / simplified, especially after I came up 
with the "intuition" in the patch some days ago and decided to use that 
one instead for now.

No questions asked, if this ever gets discussed for actual merging, only 
with a public, reviewed proof available.

[most of the "magic" goes away once one simply uses one rmap value for 
each bit in the mm->mm_rmap_id; 22 bit -> 22 rmap values. Of course, 22 
values are undesirable.]

> 
> Also, please benchmark what your rmap changes do to just plain regular
> pages - it *looks* like maybe all you did was to add some
> VM_WARN_ON_FOLIO() for those cases, but I have this strong memory of
> that
> 
>          if (likely(!compound)) {
> 
> case being very critical on all the usual cases (and the cleanups by
> Hugh last year were nice).

Yes, indeed. I separated small vs. large folio handling cleanly, such 
that we always have a pattern like:

+       if (likely(!folio_test_large(folio)))
+               return atomic_add_negative(-1, &page->_mapcount);

So, the fast default path is "small folio".

As stated, I want to do much more benchmarking to better understand all 
performance impacts; especially, on top of Ryan's work of having THPs 
that are always PTE-mapped and we don't have to "artificially" force a 
PTE-mapped THP.

> 
> I get the feeling that you are trying to optimize a particular case
> that is special enough that some less complicated model might work.
> 
> Just by looking at your benchmarks, I *think* the case you actually
> want to optimize is "THP -> fork -> child exit/execve -> parent write
> COW reuse" where the THP page was really never in more than two VM's,
> and the second VM was an almost accidental temporary thing that is
> just about the whole "fork->exec/exit" model.

That's the most obvious/important case regarding COW reuse, agreed. And 
also where I originally started, because it looked like the low-hanging 
fruit (below).

For the benchmarks I have so far, I focused mostly on the 
performance/harm of individual operations. Conceptually, with rmap IDs, 
there is no performance difference if you end up reusing a THP in the 
parent or the child, the performance is the same, so I didn't add it 
manually to the micro benchmarks.

> 
> Which makes me really feel like your rmap_id is very over-engineered.
> It seems to be designed to handle all the generic cases, but it seems
> like the main cause for it is a very specific case that I _feel_
> should be something that could be tracked with *way* less information
> (eg just have a "pointer to owner vma, and a simple counter of
> non-owners").

That's precisely where I originally started [1], but quickly wondered 
(already in that mail):

(a) How to cleanly and safely stabilize refcount vs. mapcount. Without
     playing tricks such that it's just "obvious" how it's just correct
     and race-free in the COW reuse path.
(b) How to extend it to !anon folios, where we don't have a clean entry
     point like folio_add_new_anon_rmap(); primarily to
     get a sane replacement for folio_estimated_shares(), which I just
     dislike at this point.
(c) If it's possibly to easily and cleanly change owners (creators in my
     mail), without involving locks.

So I started thinking about the possibility of a precise and possibly 
more universal/cleaner way of handling it, that doesn't add too much 
runtime overhead. A way to just have what we have for small folios.

I was surprised to find an approach that gives a precise answer and 
simply changes the owner implicitly, primarily just by 
adding/subtracting numbers.

[I'll note that having a universal way to stabilize the mapcount vs. 
refcount could be quite valuable. But achieving that also for small 
folios would require e.g., having shared, hashed atomic seqcounts. And 
I'm not too interested in harming small-folio performance at this point :)]

Now, if we want all that sooner, later, or maybe never, is a different 
question. This WIP version primarily tries to show what's possible, at 
which price, and what the limitations are.

> 
> I dunno. I was cc'd, I looked at the patches, but I suspect I'm not
> really the target audience. If Hugh is ok with this kind of

Well, I really value your feedback, and you are always in my CC list 
when I'm messing with COW and mapcounts.

Having that said, it's encouraging that you went over the patches 
(thanks again!) and nothing immediately jumped at you (well, besides the 
proof, but that will be fixed if this ever gets merged).

> complexity, I bow to a higher authority. This *does* seem to add a lot
> of conceptual complexity to something that is already complicated.

I'll note that while it all sounds complicated, in the end it's "just" 
adding/subtracting numbers, and having a clean scheme to detect 
concurrent (un)mapping. Further, it's handled without any new rmap hooks.

But yes, there sure is added code and complexity, and personally I 
dislike having to go from 3 to 6 rmap values to support arm64 with 512 
MiB THP. If we could just squeeze it all into a single rmap value, it 
would all look much nicer: one total mapcount, one rmap value.

Before this would get merged a lot more has to happen, and most rmap 
batching (and possibly including the exclusive atomic seqcount) could be 
beneficial even without the rmap ID handling, so it's natural to start 
with that independently.

Thanks again!

[1] 
https://lore.kernel.org/all/6cec6f68-248e-63b4-5615-9e0f3f819a0a@redhat.com/T/#u

-- 
Cheers,

David / dhildenb

