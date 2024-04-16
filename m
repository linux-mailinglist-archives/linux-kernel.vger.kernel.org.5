Return-Path: <linux-kernel+bounces-146472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70D8A65BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B13F1F23DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE5215B557;
	Tue, 16 Apr 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYnMtTOX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5815B12A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254924; cv=none; b=noipMh23PryzCN7VsmVB3k8Ya9Bo4v6Lk5aez0M3vlnJrWD1t+eBKud7JaPS8khwWqWh/elGaInYdanE2YQZtC85hUkwegnH/45ZlYmrzqkmk/ovnzS7O33amMUCB01HN/7tWFhST3co0PYFLnEVL1i1sSwdrXtLDN4IhH72agA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254924; c=relaxed/simple;
	bh=wwOZ7bDEA+cDJm6hqSBe+LL8OiTxCriSAU4oNstUdcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4RRB5iDLFDRDkRYD2yyukqTSW2JlNubIa8lUdvQPEEzpTaD/65fPARjqJZOrQ9BOO7ESVOET0ksvhguFv+T2/97gvi4BuMBAKJt1hvJAU+E0Q6KMR6by1z9HtlRaRlL+uPyFzpzE/OCgHihKfk2AHqsFiTygTqcAcaN2R9RvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYnMtTOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713254920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kRMxAGGEN2RAcxRu7sfhDGVjuRPZCZT+ee13DyyY9Ls=;
	b=EYnMtTOXr6kkWLXgvDL8Dwl8BV1a4vFa2/mCJPWmIinv5IDxkJtAovH10fbNobBgwjIYDj
	QiOj4wW/pczJsmUwHgXBFGclIzZz9TmgM/aVXTLpXiy8NVMHQJ36CFMPEcRp1wSQ6wNcEf
	VF7xx4PfN9l/qspnHE8Q5xUMOoH61b0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-zeOsc_aPMzeb8p3f_iMbnw-1; Tue, 16 Apr 2024 04:08:38 -0400
X-MC-Unique: zeOsc_aPMzeb8p3f_iMbnw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343c6a990dbso1388928f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254917; x=1713859717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kRMxAGGEN2RAcxRu7sfhDGVjuRPZCZT+ee13DyyY9Ls=;
        b=w7I/+buPBGgTXoKbLn/jzq3H6nUp0Fdoo1dm7GTkQefwDbk9XE2wI7tVCXx5Gs6Cjh
         +8ZoErevg+9DF5LBTpvVCSlHCvTdwQ/2YaQUYhK6Y+jZ0aqcRiDkpTgI7b0WbwsXBJXL
         pYhkpAaultvs248mYuE/NraOJGEL6nE3DZZ2G9dJKc83iCwo34Ic0F5QLJhbNsZZncDl
         lb0mSVdcg2+O72B9e1xJsm4nD9Ts0r3o0o1DATOlr0/HrIl3SMr/+Z5CZwKZ8ARvPyms
         OlD/9WfAq2FiOf9yCM0SlUzrG+nzTw2hxmC/fq0CUQq20ZyvWymmsq41kn1CPHQmr2Cn
         151A==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ue57EpnvSUzvoAd8iee401OL0Zo6hvG1IMk0NPDW+PHcQomj895iMSXidahNtENyG+fvNDxl3Uibnmi+c63n3gEGM31VY3FY2m+i
X-Gm-Message-State: AOJu0YwpjHC1ju2hHmXSJkfSaR3tBRCEoLt/vL8PwT35veCI3Mw7F6rM
	v1HilNIawSvyGtu+PPKOR0/ZijM2U7nc1S4c4cHnVr4B45GxclyFBtpYIBfE0B5S4PF6809L+7l
	8A982g2WZ7N4T6Vlp5Su55bojXWPFjJotaiY8P0jwH+kBrCUTOGWVBbZf+R3CMg==
X-Received: by 2002:adf:ce0c:0:b0:348:870:bbe4 with SMTP id p12-20020adfce0c000000b003480870bbe4mr1841213wrn.7.1713254917104;
        Tue, 16 Apr 2024 01:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe+v7feIVgCErAd2IBoOshgKG3VboOOWr9znYKfQJXsP9jRSjM5wgNQfe8h39+XLRTlt66eg==
X-Received: by 2002:adf:ce0c:0:b0:348:870:bbe4 with SMTP id p12-20020adfce0c000000b003480870bbe4mr1841177wrn.7.1713254916619;
        Tue, 16 Apr 2024 01:08:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id q10-20020adffeca000000b0033dd2a7167fsm14156995wrs.29.2024.04.16.01.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:08:36 -0700 (PDT)
Message-ID: <43def405-a55c-4bea-9caf-220408ddac40@redhat.com>
Date: Tue, 16 Apr 2024 10:08:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] mm: add per-order mTHP alloc and swpout counters
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20e36996-0c78-4b81-8e91-1035d5ce0652@redhat.com>
 <CAGsJ_4wk7RWiiNGVKdzMgD==tDmeWVBqpm-kRUFMHSz_rUVqXw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wk7RWiiNGVKdzMgD==tDmeWVBqpm-kRUFMHSz_rUVqXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.04.24 15:16, Barry Song wrote:
> On Sat, Apr 13, 2024 at 12:54 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.04.24 13:48, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> The patchset introduces a framework to facilitate mTHP counters, starting
>>> with the allocation and swap-out counters. Currently, only four new nodes
>>> are appended to the stats directory for each mTHP size.
>>>
>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>>        anon_fault_alloc
>>>        anon_fault_fallback
>>>        anon_fault_fallback_charge
>>>        anon_swpout
>>>        anon_swpout_fallback
>>>
>>> These nodes are crucial for us to monitor the fragmentation levels of
>>> both the buddy system and the swap partitions. In the future, we may
>>> consider adding additional nodes for further insights.
>>>
>>> -v6:
>>>     * collect reviewed-by tags for patch2/4, 3/4, 4/4, Ryan;
>>>     * move back to static array by using MAX_PTRS_PER_PTE, Ryan;
>>>     * move to for_each_possible_cpu to handle cpu hotplug, Ryan;
>>>     * other minor cleanups according to Ryan;
>>
>> Please *really* not multiple versions of the same patch set on one a
>> single day.
> 
> Ok. I will leave more time for you to review the older versions before moving
> to a new version.

Yes please. There is not anything gained from sending out stuff to fast, 
besides mixing discussions, same questions/comments ... and effectively 
more work for reviewers.

-- 
Cheers,

David / dhildenb


