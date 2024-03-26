Return-Path: <linux-kernel+bounces-119638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9988CB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7193FB23305
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BFA1F947;
	Tue, 26 Mar 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqoAWdje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FE1F944
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475945; cv=none; b=brzbRdBbDfXJ6lCN3aW9ADsmhfEuVHyx2RIzXSW6ZwKTV+Y69xWyQpNlMAChi3IJJq0C/MPuTmWMMG0/GRy7+UQt8UArP8S13fBfiUKLfJJRymvMaSBURSDxbgBDTP60Ov1a2P7KWaqRh8kBLGVIkh9wMGZqf0p369JOJgmG91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475945; c=relaxed/simple;
	bh=tmPGEgdUK27xky54HkFAUNUQN/vYIqSXy6s4QscWAwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2WSBXr+6x1hBkoSTuZSMO+JjkBJCYjuG+qLvp5cmfuzX2OhIXMtr1xgFdyDfpbHB4kNxXmiLryrzsaxoS3130ovzHs6DLbhspx8nbV2hqepjwq5AmuheUSxE1M04RIT/yY1KXUHHVX2sizhY2eFWN2MvApNAcEXR3ZLpyV87Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqoAWdje; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711475942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Y7VBG4ygfrnBA4XCI0T2D0w/4nJq2EyCdqIcC5EnuA=;
	b=NqoAWdje/+RPHALLK30Gfc0Qe7kr4M2l9fTthlPqnz0+ak4JopyO9M86qH45gDKNfa1Wv3
	hjOTEsZ92RIxCK0rvJluRTIeFg7gG6xj+f3kTWH6B0uZBEbxDwwEuX35wocyN7AD07UxQS
	Wh/rcr0ICi6O/7G3QayT5hNWfkfX2gU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-J7uaMDyeOFCNKFmbdnHzpw-1; Tue, 26 Mar 2024 13:58:59 -0400
X-MC-Unique: J7uaMDyeOFCNKFmbdnHzpw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-414042da713so331935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475937; x=1712080737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y7VBG4ygfrnBA4XCI0T2D0w/4nJq2EyCdqIcC5EnuA=;
        b=PcQDASaSMO8W77sf1r+8CXSTlKuqTpt9RIph34owzPDq6VnUBxbJy4k6lKBTNrLj+/
         0bmuIuGZgOlcMswte6r2LzYqzhilumeOxkQDry5d2FABDD74dFCh8Sm5t7b8ap5xVe6Y
         Nbm8P815QCNJ4QAuywvAFEqap2E45YY0oTPqc+CYH+YGJLvuoQ+Z8p6W5iEjRZCKhbHO
         06d991P/ifdnhUHK8LKSh263DIuFCOYqy8TvlnQrbJuNOu7C6AHkm2pP0bJqBrmKjJ1x
         CiTOADrYGvJImpqEVunn6GsaX8xEt/pjBalP5EmCEcd2jvK+0107ldsXK4hr3X3ralyC
         /Hng==
X-Forwarded-Encrypted: i=1; AJvYcCUHPuXQqrhRcagqWCeg/v2YH7VIhnQ9sIegBE0Y5P8jOz2+mIUjIhacrThOJwonW13Le+hGd3tgV8YYARomQhglbLmBP34LB69xzURT
X-Gm-Message-State: AOJu0Ywj32UeG300+vPa4NOKf9EmKcjRDOqxc7ZURf61CSz1ijM9j9tx
	TvW1vC0feNhFWn5MjEO/jGw1bPl+Iz8xueLBNoWmjrfoYgYsuIXLTC3JQmvcpaEdcoBcbnXrAnw
	R/kTfC7v0VXVtRfe3HOTr3mm9vi7Lz2mphKXg/T+C7dzbINV4ZMX5OiUsnM/wTBaEYkL6fA==
X-Received: by 2002:a5d:46c6:0:b0:33e:12a4:8619 with SMTP id g6-20020a5d46c6000000b0033e12a48619mr2246254wrs.24.1711475937452;
        Tue, 26 Mar 2024 10:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaBM/jugsTQNqF86M1LRBrbghtNQJQQiswffATP6ews5KYozNQUqXwbRTyE292wiJdAz0FNw==
X-Received: by 2002:a5d:46c6:0:b0:33e:12a4:8619 with SMTP id g6-20020a5d46c6000000b0033e12a48619mr2246238wrs.24.1711475937079;
        Tue, 26 Mar 2024 10:58:57 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6b40.dip0.t-ipconnect.de. [91.12.107.64])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b004148a5e3188sm6115521wms.25.2024.03.26.10.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:58:56 -0700 (PDT)
Message-ID: <6aaff470-c510-469b-8f4f-2e4c5cf07d56@redhat.com>
Date: Tue, 26 Mar 2024 18:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm/memory: Use ptep_get_lockless_norecency()
 for orig_pte
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-4-ryan.roberts@arm.com>
 <e0bdbd5e-a098-422a-90af-9cf07ce378a4@redhat.com>
 <febd0c97-8869-4ce5-bd37-cbbdf5be0a43@arm.com>
 <f6996c4f-da60-4267-bcf1-09e4fd40c91b@redhat.com>
 <fb101fd1-e28a-4278-bf5f-e2dca0215a90@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fb101fd1-e28a-4278-bf5f-e2dca0215a90@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>
>>>> vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
>>>> /* not dirty */
>>>>
>>>> /* Now, thread 2 ends up setting the PTE dirty under PT lock. */
> 
> Ahh, this comment about thread 2 is not referring to the code immediately below
> it. It all makes much more sense now. :)

Sorry :)

> 
>>>>
>>>> spin_lock(vmf->ptl);
>>>> entry = vmf->orig_pte;
>>>> if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>>>>       ...
>>>> }
>>>> ...
>>>> entry = pte_mkyoung(entry);
>>>
>>> Do you mean pte_mkdirty() here? You're talking about dirty everywhere else.
>>
>> No, that is just thread 1 seeing "oh, nothing to do" and then goes ahead and
>> unconditionally does that in handle_pte_fault().
>>
>>>
>>>> if (ptep_set_access_flags(vmf->vma, ...)
>>>> ...
>>>> pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>
>>>>
>>>> Generic ptep_set_access_flags() will do another pte_same() check and realize
>>>> "hey, there was a change!" let's update the PTE!
>>>>
>>>> set_pte_at(vma->vm_mm, address, ptep, entry);
>>>
>>> This is called from the generic ptep_set_access_flags() in your example, right?
>>>
>>
>> Yes.
>>
>>>>
>>>> would overwrite the dirty bit set by thread 2.
>>>
>>> I'm not really sure what you are getting at... Is your concern that there is a
>>> race where the page could become dirty in the meantime and it now gets lost? I
>>> think that's why arm64 overrides ptep_set_access_flags(); since the hw can
>>> update access/dirty we have to deal with the races.
>>
>> My concern is that your patch can in subtle ways lead to use losing PTE dirty
>> bits on architectures that don't have the HW-managed dirty bit. They do exist ;)
> 
> But I think the example you give can already happen today? Thread 1 reads
> orig_pte = ptep_get_lockless(). So that's already racy, if thread 2 is going to
> set dirty just after the get, then thread 1 is going to set the PTE back to (a
> modified version of) orig_pte. Isn't it already broken?

No, because the pte_same() check under PTL would have detected it, and 
we would have backed out. And I think the problem comes to live when we 
convert pte_same()->pte_same_norecency(), because we fail to protect PTE 
access/dirty changes that happend under PTL from another thread.

But could be I am missing something :)

>> Arm64 should be fine in that regard.
>>
> 
> There is plenty of arm64 HW that doesn't do HW access/dirty update. But our
> ptep_set_access_flags() can always deal with a racing update, even if that
> update originates from SW.
> 
> Why do I have the feeling you're about to explain (very patiently) exactly why
> I'm wrong?... :)

heh ... or you'll tell me (vary patiently) why I am wrong :)

-- 
Cheers,

David / dhildenb


