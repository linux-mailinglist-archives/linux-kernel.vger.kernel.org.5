Return-Path: <linux-kernel+bounces-147264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788938A71B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF69287893
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012DF12BE89;
	Tue, 16 Apr 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TntBDXit"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C71F956
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286368; cv=none; b=hwhMR711oCiBB8BF6N3BuP86MywLR/CZTHndASnhIJbH7gSO9vpnDE4QbrYw9+ClY2XF4zIn+s5cYo9Xj9FYEtj+27Jozy8UTB2lDFuYInArM/6HYON6KOP2G96iSFAfxkMJ3+ygb/zbARKfbdg5wQa5v+PtOCx6+/poBeKRcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286368; c=relaxed/simple;
	bh=RTEmi/5LugeTmU9hFk75B+TANcPU6ccds0lzeEbvEfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdQfbpU1826VcnRmC9E7WQoq5e8OHilma4+wR0FmKLEyQcah09PglDxUA994Fr86SURBHgOLZjDRtARQEjzuUww1R2EFi9eOYmDZ0kTae1z6dYNZApsAUDeiShi+Iwx0aAHdA04TAOSe9aWVYOYF/li9AgEemGl/qqRiWAAIEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TntBDXit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713286365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZaYh7W+PZzizPKq4sMptVOZC/Y/YJezfimS2uwkDH8Q=;
	b=TntBDXitBJnl8Pgx96Lym8EKWLOrhIjyy0aUJTq95EJ049MVZHXawAyWRmKtSF9xF7ynEo
	BQuIYRXXAGIV4U667NZ15Tf1vMfN8MdxN9Zm8Y6Xn1tEYynFtZ+jDzGKSc/6uBO48RJH0Y
	rn8uGUDjIUtExGJXnZVBYhjQnutB50g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-eH-98_ftMGq1Mu0wwscCNA-1; Tue, 16 Apr 2024 12:52:44 -0400
X-MC-Unique: eH-98_ftMGq1Mu0wwscCNA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d8ce90e337so28499711fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286362; x=1713891162;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZaYh7W+PZzizPKq4sMptVOZC/Y/YJezfimS2uwkDH8Q=;
        b=wl3GTo8D0IzsyOmVQsPqbGDp0lCwDKUAUSRuGR9pG/7zJcHRyzInKrPTCrfVySdUSv
         nP5/AHPP1mf6yO4COYDnZQ5vgXnnZV52RhmN6u1rHoe5TsjAVdMzAhStx3E5IASpCawL
         tg2uAqzlZnHt8j6UNnFcEZSSXGsFG9KyUhr8IH0qNkkQaCoA5BYpvoqt9D+hV0XhjYo9
         yV1WlKpJl0nC/+4jfcZEG6JTxuqJKev9nOUOd4fXsOBjTKV7CRm+07DumRblcOLDDVwh
         jGEa4vY868y6u/PCYR9wMXIrVVE54YU3mTroTQii/9sy3SKbJ7D6GbkQcj29F8ugrjeI
         7xYw==
X-Forwarded-Encrypted: i=1; AJvYcCVoRBFUh92OcmlMoQyaNag2JHpCl0zL3d1bVIJnT4VhVwFKK5kIVYOCCOMgbPifU++QFgcSITzeNt/61NMUP2ZB6NISsuiqt7aPwWsx
X-Gm-Message-State: AOJu0Yzs+pSxjYlKT76pbELyyjDGf81BCmZQCAq6+a8bfd2I3732Zd92
	R9tnrVvJ96F54tsc/BYqeZlct4Jlx9K6QL04g+PwU1IEs8LER+RrBMs+XWy5EEMwDgVrzeX+LIj
	czsV3xWiRNjdsYvPSNrjQIYbJcR/HlVALVVuCYfcoPjPC23oAC5VS1HA66ikYkhExDf1MtA==
X-Received: by 2002:a2e:91cd:0:b0:2db:7b:1a7b with SMTP id u13-20020a2e91cd000000b002db007b1a7bmr653809ljg.46.1713286362635;
        Tue, 16 Apr 2024 09:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfPvL0GTh3f7hVBIxV4NNUxpa7nI2Y0TRfQBVAejBYoRFKGtutagthTWHw9zoPg2UFWZhCFA==
X-Received: by 2002:a2e:91cd:0:b0:2db:7b:1a7b with SMTP id u13-20020a2e91cd000000b002db007b1a7bmr653783ljg.46.1713286362203;
        Tue, 16 Apr 2024 09:52:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id f12-20020a0560001a8c00b0034744966ff0sm10717796wry.59.2024.04.16.09.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 09:52:41 -0700 (PDT)
Message-ID: <3a0d1d1c-97f4-4c9d-bc25-9de3f3659b67@redhat.com>
Date: Tue, 16 Apr 2024 18:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-4-ioworker0@gmail.com>
 <d833efd7-28fd-42f0-83cd-e29f0f343909@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d833efd7-28fd-42f0-83cd-e29f0f343909@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +			nr = madvise_folio_pte_batch(addr, end, folio, pte,
>> +						     ptent, &any_young, &any_dirty);
>> +
>> +			if (nr < folio_nr_pages(folio)) {
>> +				if (folio_likely_mapped_shared(folio))
>> +					continue;
>> +
>> +				arch_leave_lazy_mmu_mode();
>> +				if (madvise_pte_split_folio(mm, pmd, addr,
>> +							    folio, &start_pte, &ptl))
>> +					nr = 0;
>> +				if (!start_pte)
>> +					break;
>> +				pte = start_pte;
>> +				arch_enter_lazy_mmu_mode();
>> +				continue;
>> +			}
>> +
>> +			if (any_young)
>> +				ptent = pte_mkyoung(ptent);
>> +			if (any_dirty)
>> +				ptent = pte_mkdirty(ptent);
>>   		}
>>   
>> +		if (folio_mapcount(folio) != folio_nr_pages(folio))
>> +			continue;
> 
> Why is this here? I thought we had previously concluded to only do this test
> inside the below if statement (where you have it duplicated).

I stumbled over these same while reviewing. It's not exactly duplicate, 
because it's unreliable without the folio lock. It looks more like an 
best-effort early check.

But then, we also add it to cases where we previously wouldn't check the 
mapcount at all: when the folio was added to the swapcache or is already 
dirty.

In that case, we would even see a change for order-0 folios with that 
new check.

-- 
Cheers,

David / dhildenb


