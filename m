Return-Path: <linux-kernel+bounces-108982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A58812F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4376286765
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1C4207B;
	Wed, 20 Mar 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQRK5s6x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464141C92
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943762; cv=none; b=f6YUAY4cv6vUeCNgiovJjhKJIVw/F3H6X/jFkUvF5vUWoarABPOoFDrqjNRWhYAEP6jfPzWP+ZhpKXIHsGebO9z7skOqMGjhPbPGlocLbfz7fllrlzmehxOT4tOr+hOchJbnvly3MC08WP79dv3NLw6SLoyqhL9r8uQGPDKMsa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943762; c=relaxed/simple;
	bh=6ZPfT78qPoC70GtAEJtOOEGawqYWEcMbQF5I2JTYNog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFPsAhMt9Oznu4ksupbk4cADQ0rNYIWqWP/ZZa8A4TghTBSYeuU3W6Y2wXEIsnZuJ8X6voZOkTDRFfSMvX+naOJ0GYisLyiV+3g5n4WnIAmLx6X0KcmJCnKvPXSr8DXzSVDZHIrDgfpCy3lL0OOWhlid/ipO5/nFTpF3Nb5+334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQRK5s6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710943760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IRvqxmMSsEU1UbdY8gpToz+TWcSUE9yP2hNLdT2PgOY=;
	b=eQRK5s6xfDB49CTq8GwdrDG9/HbdpZAKTrk+tcUvmQ5PLWDy2azKu2NZHdej9+/04toKjM
	K3jraWKXtgN4CxeT+3WuZLGWdDP9L0P5TePyr0e/28OvEt+9LHzeVqVf/RZFqZGvfIsaxO
	0L5nEnOAi7SJPRWoP4Dc6xMu0UtCAv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-b8d-Wmq4M7ekC9yDEk3ZlA-1; Wed, 20 Mar 2024 10:09:18 -0400
X-MC-Unique: b8d-Wmq4M7ekC9yDEk3ZlA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ed489edcaso2680256f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943757; x=1711548557;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRvqxmMSsEU1UbdY8gpToz+TWcSUE9yP2hNLdT2PgOY=;
        b=TeYkHxegNyBgG/O4MH2PcD0dJ8e2q3io61OfkspSfLC1M9qb+EEWQ5VR+BYMlVpZ7w
         JOntjSy2MAbKt24ZXbCjUy8rfjyeTAfer/obiEb2vR78EpNSlOkWCKnq2RJzD0qvmFY3
         RvRg6EcUSI0ye8s3wiIwn3uBTWDNstz7fbDK/SdZ0OVgpnFMPfAKiJcQF8olCSVeWhQY
         yLJX3btCukcNg21KN89AwnofwJGDppu+i7sczXVgHbpTi4cU00M5e+8wgjJgdb7oxBwN
         mnRnfOYFILDSns5j5I2NQCidok9Szn2iVqMtznmYXm7JtZH7pNYDtZF4QbgGVE1vnE/y
         APsw==
X-Forwarded-Encrypted: i=1; AJvYcCWLwG/pnouQFUuTXkuxomQ52WwxJgnnFsOKUrSYIAziUc0AZsfTVDfGFcYSaDJmA1tXiUEzZ0RdF3y7IMGtqyKBYevTyeNUokt+xWv9
X-Gm-Message-State: AOJu0YzQ6+2KkeFDnF/722P+BpOwZkhb4DrxFZhM72ytpd9wm0f730KR
	tgARB+1Stk8GXDGD/sTvS/1z239f3Ok3vscoQwMhdhjumKAdLwV8h+XDbRegwgzwQUVe/PWjVvA
	Zm57AadKAFRw74PF2kUHrb2HZc5Evw37Daz8phLoJpSt83DpU/ZuVnJwngBweNQ==
X-Received: by 2002:a5d:6645:0:b0:33e:b78b:5831 with SMTP id f5-20020a5d6645000000b0033eb78b5831mr1578686wrw.52.1710943757385;
        Wed, 20 Mar 2024 07:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA3Yxa+dHzherfiMY+Rq9ZcrubT8x74pqFkK320EoIxNXxG/3cL8Sg0WfmVhxdCZts7f03IQ==
X-Received: by 2002:a5d:6645:0:b0:33e:b78b:5831 with SMTP id f5-20020a5d6645000000b0033eb78b5831mr1578666wrw.52.1710943756923;
        Wed, 20 Mar 2024 07:09:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc? (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de. [2003:cb:c709:c400:9a2:3872:9372:fbc])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b0034180f6d3cfsm5378763wrr.73.2024.03.20.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:09:16 -0700 (PDT)
Message-ID: <3987659f-2adc-477b-b507-ead2f10c1849@redhat.com>
Date: Wed, 20 Mar 2024 15:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com>
 <ffeee7da-e625-40dc-8da8-b70e4e6ef935@redhat.com>
 <9ce7b66f-f84e-4e94-863c-2f02dcff4bd3@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9ce7b66f-f84e-4e94-863c-2f02dcff4bd3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.03.24 14:57, Ryan Roberts wrote:
> On 15/03/2024 10:35, David Hildenbrand wrote:
>>> -        if (!pageout && pte_young(ptent)) {
>>> -            ptent = ptep_get_and_clear_full(mm, addr, pte,
>>> -                            tlb->fullmm);
>>> -            ptent = pte_mkold(ptent);
>>> -            set_pte_at(mm, addr, pte, ptent);
>>> -            tlb_remove_tlb_entry(tlb, pte, addr);
>>> +        if (!pageout) {
>>> +            for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
>>> +                if (ptep_test_and_clear_young(vma, addr, pte))
>>> +                    tlb_remove_tlb_entry(tlb, pte, addr);
>>> +            }
>>>            }
>>
>>
>> The following might turn out a bit nicer: Make folio_pte_batch() collect
>> "any_young", then doing something like we do with "any_writable" in the fork()
>> case:
>>
>> ...
>>      nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>>                   fpb_flags, NULL, any_young);
>>      if (any_young)
>>          pte_mkyoung(ptent)
>> ...
>>
>> if (!pageout && pte_young(ptent)) {
>>      mkold_full_ptes(mm, addr, pte, nr, tlb->fullmm);
> 
> I don't think tlb->fullmm makes sense here because we are not clearing the pte,
> so there is no chance of optimization? So planning to call this mkold_ptes() and
> remove that param. Have I missed something?

Agreed.

-- 
Cheers,

David / dhildenb


