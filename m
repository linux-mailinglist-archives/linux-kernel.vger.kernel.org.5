Return-Path: <linux-kernel+bounces-157339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2798B1007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336132854A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5691635D1;
	Wed, 24 Apr 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlnRzFgC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248C1598EA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976600; cv=none; b=a39VcX5RXofE+KyRmSoSzDs/2GXS7Nkh9fnYUulmHXRzZ/37lOmMoPoOsECDac8dFwMLYDgEFSqrTTjwEBM6DDP/EcnAgC2u57qlYF2yfMzjw7M58xKLn64dEahicwsq5Emk7qv8f0DQq0r8/PrKaws79CqKu0kGjZZ3up2dtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976600; c=relaxed/simple;
	bh=mlR0fc1EwPI5kZWszxzybpq+nSLIaU1hJmMjqk5+Cek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQoou6qrQbnfCCsrNL1sNN1wxTCwbq/11gDK5WCQYW2hRxv9EvU8kB0EZW0Mf0RnlMl+sgWfuR8uKFoAwCduwZJ5CvdbiImHp1aFVXGcg6Uw8ICo7ptyLeHa2ue9Ob6FeqTqkIgqLOFHt+u/xUfz/JxCBUg59At5CO5gqfpWC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlnRzFgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713976598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Jrk4gtHl8qK5/GSsCNisBJDr3mbiNNfApp9drceM6U=;
	b=dlnRzFgCMYbXQ55DC6FAR8kpIrxussBPkaC4u8PNskJtfEbinXITORb2GG3CgcO25C81wH
	z39zRCC1Ujp0Kw7u2m/HeuPCdWJil5be5BsmKIUPNsTr9h9ayXIs5IwPqUYsww6/t9do9l
	FzqvjwhSsC3lbtJvR7m1No22dk0mB/0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-0sA_jYonORO4QgpCVskzTg-1; Wed, 24 Apr 2024 12:36:36 -0400
X-MC-Unique: 0sA_jYonORO4QgpCVskzTg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-417fb8195d7so421405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976594; x=1714581394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Jrk4gtHl8qK5/GSsCNisBJDr3mbiNNfApp9drceM6U=;
        b=gxV62PRZ6pHHgU7DqhD/V6tvLN01iyWohE7wcd/PWnJ3cHrwk2RLhWA5FzlzvOOwL+
         YSxPvpxj4F12KfsucJcgfeGwKtOJWb+pq73l83Xn12wgFWzhdNizWPy83EC/k68qXmC6
         5DpaPsCnDVTa2X6bRUh1hZQGjxunQYqGzgOdsQ/ia9QwD9jk9/P7mkqJ86pkme8djfu0
         ubTzoOAlNfHH8Bq6kttAj93tk8OV3qrs3xRG+Zgmrfv8F7OzGzw505QJJEoYwTzF++mt
         /+1qPbc1JzFcQ2s98JlRkfDF7KzS1W9GUfmS2KuYKTMqHJ83/t1c3SunkDfQ+5b8UeJr
         Zg6Q==
X-Gm-Message-State: AOJu0Yzs0V0fbjBkZaRHWAC4gL2eK5i1F1yRFHAFaYilDx98kGkGpmZZ
	tvidWSV44uiN5ZMwgYHSW4ldB1noCw3W8tJCZCfiXwfYUNxZF6sUW8VN+aFaeanKi2eBVXmRPwF
	6sQy9f9oq3gbTFZPr3ct/nvPVxc5j7nQBlb2WwJ8qvgnGCklcz2X4zdK2Llj+WA==
X-Received: by 2002:a05:600c:3d8a:b0:41b:144a:f0c3 with SMTP id bi10-20020a05600c3d8a00b0041b144af0c3mr1065275wmb.20.1713976594093;
        Wed, 24 Apr 2024 09:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgmkfHI6kdz/k8WpzKlP6Ihl1I1xBPf6WTZ0J7t762mXEb4w+GJI6DHiNacD+q2oVRiDDNuw==
X-Received: by 2002:a05:600c:3d8a:b0:41b:144a:f0c3 with SMTP id bi10-20020a05600c3d8a00b0041b144af0c3mr1065264wmb.20.1713976593666;
        Wed, 24 Apr 2024 09:36:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm24396011wmq.10.2024.04.24.09.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:36:33 -0700 (PDT)
Message-ID: <2a33880e-4e7a-4de1-846a-e81f8de82088@redhat.com>
Date: Wed, 24 Apr 2024 18:36:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
To: Yang Shi <shy828301@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240424122630.495788-1-david@redhat.com>
 <CAHbLzkrAW0RK81ABnveJf98besYHaAaA7nJzrqWYm=hf382s2g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkrAW0RK81ABnveJf98besYHaAaA7nJzrqWYm=hf382s2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.04.24 18:28, Yang Shi wrote:
> On Wed, Apr 24, 2024 at 5:26 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> We want to limit the use of page_mapcount() to places where absolutely
>> required, to prepare for kernel configs where we won't keep track of
>> per-page mapcounts in large folios.
>>
>> khugepaged is one of the remaining "more challenging" page_mapcount()
>> users, but we might be able to move away from page_mapcount() without
>> resulting in a significant behavior change that would warrant
>> special-casing based on kernel configs.
>>
>> In 2020, we first added support to khugepaged for collapsing COW-shared
>> pages via commit 9445689f3b61 ("khugepaged: allow to collapse a page shared
>> across fork"), followed by support for collapsing PTE-mapped THP in commit
>> 5503fbf2b0b8 ("khugepaged: allow to collapse PTE-mapped compound pages")
>> and limiting the memory waste via the "page_count() > 1" check in commit
>> 71a2c112a0f6 ("khugepaged: introduce 'max_ptes_shared' tunable").
>>
>> As a default, khugepaged will allow up to half of the PTEs to map shared
>> pages: where page_mapcount() > 1. MADV_COLLAPSE ignores the khugepaged
>> setting.
>>
>> khugepaged does currently not care about swapcache page references, and
>> does not check under folio lock: so in some corner cases the "shared vs.
>> exclusive" detection might be a bit off, making us detect "exclusive" when
>> it's actually "shared".
>>
>> Most of our anonymous folios in the system are usually exclusive. We
>> frequently see sharing of anonymous folios for a short period of time,
>> after which our short-lived suprocesses either quit or exec().
>>
>> There are some famous examples, though, where child processes exist for a
>> long time, and where memory is COW-shared with a lot of processes
>> (webservers, webbrowsers, sshd, ...) and COW-sharing is crucial for
>> reducing the memory footprint. We don't want to suddenly change the
>> behavior to result in a significant increase in memory waste.
>>
>> Interestingly, khugepaged will only collapse an anonymous THP if at least
>> one PTE is writable. After fork(), that means that something (usually a
>> page fault) populated at least a single exclusive anonymous THP in that PMD
>> range.
>>
>> So ... what happens when we switch to "is this folio mapped shared"
>> instead of "is this page mapped shared" by using
>> folio_likely_mapped_shared()?
>>
>> For "not-COW-shared" folios, small folios and for THPs (large
>> folios) that are completely mapped into at least one process,
>> switching to folio_likely_mapped_shared() will not result in a change.
>>
>> We'll only see a change for COW-shared PTE-mapped THPs that are
>> partially mapped into all involved processes.
>>
>> There are two cases to consider:
>>
>> (A) folio_likely_mapped_shared() returns "false" for a PTE-mapped THP
>>
>>    If the folio is detected as exclusive, and it actually is exclusive,
>>    there is no change: page_mapcount() == 1. This is the common case
>>    without fork() or with short-lived child processes.
>>
>>    folio_likely_mapped_shared() might currently still detect a folio as
>>    exclusive although it is shared (false negatives): if the first page is
>>    not mapped multiple times and if the average per-page mapcount is smaller
>>    than 1, implying that (1) the folio is partially mapped and (2) if we are
>>    responsible for many mapcounts by mapping many pages others can't
>>    ("mostly exclusive") (3) if we are not responsible for many mapcounts by
>>    mapping little pages ("mostly shared") it won't make a big impact on the
>>    end result.
>>
>>    So while we might now detect a page as "exclusive" although it isn't,
>>    it's not expected to make a big difference in common cases.
>>
>> (B) folio_likely_mapped_shared() returns "true" for a PTE-mapped THP
>>
>>    folio_likely_mapped_shared() will never detect a large anonymous folio
>>    as shared although it is exclusive: there are no false positives.
>>
>>    If we detect a THP as shared, at least one page of the THP is mapped by
>>    another process. It could well be that some pages are actually exclusive.
>>    For example, our child processes could have unmapped/COW'ed some pages
>>    such that they would now be exclusive to out process, which we now
>>    would treat as still-shared.
> 
> IIUC, case A may under-count shared PTEs, however on the opposite side
> case B may over-count shared PTEs, right? So the impact may depend on
> what value is used by max_shared_ptes tunable. It may have a more
> noticeable impact on a very conservative setting (i.e. max_shared_ptes
> == 1) if it is under-counted or on a very aggressive setting (i.e.
> max_shared_ptes == 510) if it is over-counted.

Thanks for reading all of that!

Right, and mostly affecting corner cases. I'm not concerned about (B) 
really. I was more concerned about (A) before I optimized 
folio_likely_mapped_shared() using the large mapcount.

> 
> So I agree it should not matter much for common cases. AFAIK, the
> usecase for aggressive setting should be very rare, but conservative
> setting may be more usual, so improving the under-count for
> conservative setting may be worth it.

Yes, sorting out A completely is what I 'm working on, but it will 
likely not be available on all kernel configs, at least initially.

And unless there is a good reason, I want to avoid having 
config-dependent stuff all over the kernel -- and just move 
page_mapcount() to task_mmu.c where it can no longer be (ab)used.

Thanks!

-- 
Cheers,

David / dhildenb


