Return-Path: <linux-kernel+bounces-158828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385088B256E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16595B22CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414A14B083;
	Thu, 25 Apr 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXdrB2Af"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03012BEBF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059740; cv=none; b=r19hCLxO31fNW0LvWZFa65O8q0yeRXAE9f/QzI/Fwqf86Yb7CEEDydRQzm9ABQ2xQas6QuDWcQBgMvwh4GxKn9C+jVXHJh1aC+a2kiK4uN+ckofCH1RQPWIUkzbYsfyx5e9fyq9NlmiAnOnYatwxLKSHe2vMPf3WR4LfYHRWHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059740; c=relaxed/simple;
	bh=MVKM6RX3bwPDnzKTUq1ZTuaz+pJ2MynYCrrgb3/OpfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9x04ggo2DaXVzBRUD8C9E52whPh2xoMrDE2hdgruenjBiC+Al0wEtlW7fDmH45yKIIihp1yGQW0eYx9lpFrlpiA/RQeWFp5CqZ21yK1Z601bsg9bIklhT074Nu5wyvg3dkOaeli5BT9iLF83Veu2qdK8XLlcPVITLaNitP137I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXdrB2Af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714059738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8IZ5smypooJ/WccD/kv55Bp02VmcxVizAK5uLItzlgE=;
	b=PXdrB2AfrHiYDGaC8QDpCEKV1qmN/osT8g1btqwusNnWQdrx+HDinUv6fTBIvQ09pG9SM1
	9e2TPgslqnEkYbwa7Y6nuUeKsaQSKoSp6rSJ6sZn0MtwZJApqOjl9N10FdD++2j/7oc2Ja
	h8BR1HnYoAilplZghoQ48Tch1t+bGWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-BC5PYM2BP_y0xzY21RPemA-1; Thu, 25 Apr 2024 11:42:15 -0400
X-MC-Unique: BC5PYM2BP_y0xzY21RPemA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-347ddb973dcso612969f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059734; x=1714664534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IZ5smypooJ/WccD/kv55Bp02VmcxVizAK5uLItzlgE=;
        b=oEH1qPLPFUHKXUjVb8hKrtfdqXMLSya50/C4TK6o8pa4nzedMmzhRv9wZFRJZ0Q5aQ
         HebNAnzpUZFLnrHil0VS9kwuGJBeK5r7DQhU1w1Bg9OgpFKhm05Pm/wlSVf2NT8xA8f+
         OapXbnZi9nePw1vDqVa8H1WFMMgwHTjNCjPFj67uS/xm9ErFsyg5jlWBxQaH3DLSalzE
         OO3dWbIX+RPfnF9+IFr7mqvrZkuEYVLj+SLLEwarVMYqhp6h3be1+/xMfACWbV80BFRu
         AOpm+65Crrf/eKVOGROj29Evz73tPb8Cwhrg8dgoly33TB3PSgBtug/3OgNOW2gM/L2A
         EKJg==
X-Forwarded-Encrypted: i=1; AJvYcCVNmGy9p+DGomxzoFuQNi+fxgpqaPCvyhgX58Xf8DVaZ/0ojTH4smqK/xXXUgQK77ZLhKCa1B+0F8G7xX4SeI2iw7eY1ENwhJ+Bo4cX
X-Gm-Message-State: AOJu0YxF2iHuQ63PEBZQlGryGMPuVW1H2u9ayf73pxIyOrs3+bGevL1Y
	WNqkKB47ZqSyiTCRPnSlu7hW0YgafpK14psQ51V/sVTHXxN8BXXX+cvNStwJg94kRtIPWBAWK2O
	1UHxNVb5tydnO+9ha1qephRj96rJTW6MBHlT2zdXapCZablr4paXtJyeRvGORLw==
X-Received: by 2002:a05:6000:141:b0:33e:c307:a00a with SMTP id r1-20020a056000014100b0033ec307a00amr3814035wrx.43.1714059734587;
        Thu, 25 Apr 2024 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr2kagnVb9NJrsyXNuzo5wbN8gc8+USKKkbgBMkuWFtVPUqzRvfFsG8eluJIHEGWrGuxdbOg==
X-Received: by 2002:a05:6000:141:b0:33e:c307:a00a with SMTP id r1-20020a056000014100b0033ec307a00amr3814020wrx.43.1714059734125;
        Thu, 25 Apr 2024 08:42:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d434b000000b0034a2d0b9a4fsm19000977wrr.17.2024.04.25.08.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:42:13 -0700 (PDT)
Message-ID: <854511e0-d00c-477b-813a-3785baea846a@redhat.com>
Date: Thu, 25 Apr 2024 17:42:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zip0fEliGeL0qmID@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 17:19, Guillaume Morin wrote:
> On 24 Apr 23:00, David Hildenbrand wrote:
>>> One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
>>> hugetlb mappings. However this was also on my TODO and I have a draft
>>> patch that implements it.
>>
>> Yes, I documented it back then and added sanity checks in GUP code to fence
>> it off. Shouldn't be too hard to implement (famous last words) and would be
>> the cleaner thing to use here once I manage to switch over to
>> FOLL_WRITE|FOLL_FORCE to break COW.
> 
> Yes, my patch seems to be working. The hugetlb code is pretty simple.
> And it allows ptrace and the proc pid mem file to work on the executable
> private hugetlb mappings.
> 
> There is one thing I am unclear about though. hugetlb enforces that
> huge_pte_write() is true on FOLL_WRITE in both the fault and
> follow_page_mask paths. I am not sure if we can simply assume in the
> hugetlb code that if the pte is not writable and this is a write fault
> then we're in the FOLL_FORCE|FOLL_WRITE case.  Or do we want to keep the
> checks simply not enforce it for FOLL_FORCE|FOLL_WRITE?
> 
> The latter is more complicated in the fault path because there is no
> FAULT_FLAG_FORCE flag.
> 

handle_mm_fault()->sanitize_fault_flags() makes sure that we'll only 
proceed with a fault either if
* we have VM_WRITE set
* we are in a COW mapping (MAP_PRIVATE with at least VM_MAYWRITE)

Once you see FAULT_FLAG_WRITE and you do have VM_WRITE, you don't care 
about FOLL_FORCE, it's simply a write fault.

Once you see FAULT_FLAG_WRITE and you *don't* have VM_WRITE, you must 
have VM_MAYWRITE and are essentially in FOLL_FORCE.

In a VMA without VM_WRITE, you must never map a PTE writable. In 
ordinary COW code, that's done in wp_page_copy(), where we *always* use 
maybe_mkwrite(), to do exactly what a write fault would do, but without 
mapping the PTE writable.

That's what the whole can_follow_write_pmd()/can_follow_write_pte() is 
about: writing to PTEs that are not writable.

You'll have to follow the exact same model in hugetlb 
(can_follow_write_pmd(), hugetlb_maybe_mkwrite(), ...).

-- 
Cheers,

David / dhildenb


