Return-Path: <linux-kernel+bounces-139224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13718A0012
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E26D1F243AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DD1802D1;
	Wed, 10 Apr 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxRlRSCQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D2168D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775143; cv=none; b=h45hwUZAF8YC/1usVNHDHpT4cAB78tNz/OFyfkeld9IU69Bpid7lSEp5cTcneWJFUxy/wkfLJubuVIvEQZW6hi7Ub7+f8ZPFRGnwPeBqWqPgrXb4N/ZpvnilOFcQgc73mkmwtL7XQR12TxFS507zVIkZnTDnjr0V+TapgSlmSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775143; c=relaxed/simple;
	bh=bgeNqKKDFNVE2g4BL0ob14S3E2t26nti9t5qsTsF0W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mj7IJRww4oLiu73Y0HBqQYUOSIO2CVO4ERivf5fGJ010tDAD/oUGh041fsK4gKM1d3fGKeqp6MQdLO0XpoBkILcH4fMnlH7R8zFjF4QGFo9Wn8BrE0DnKpxpF+WUMVMz4R5pOtHgrdJ2vQ7N/DM4CA4Xo6AaIwToJls87i+6B8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxRlRSCQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712775140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dpcZLw76LIR56GIqHDiCzppCNN/JqkgmvUZ9GFBgLhI=;
	b=SxRlRSCQxojmV55XVa8WR1J/PToTZ57h7CG9A6jcgSoOd3FlwMOmYa73zx+ZCkVVFSRleh
	QdU3BPF70piuIrbkDwfLhuAoxQs2eu+WL3MkZRCJ5IJdwwdKBt5itH4SdiQacBC7rCmmn0
	8No0mnFbSsTPkG0+e/hYWV7r2fRz+vs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-En30eCV6P12TJe5xsw3ntw-1; Wed, 10 Apr 2024 14:52:17 -0400
X-MC-Unique: En30eCV6P12TJe5xsw3ntw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5199cc13b2so11354766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775136; x=1713379936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpcZLw76LIR56GIqHDiCzppCNN/JqkgmvUZ9GFBgLhI=;
        b=p+4wodVuFlAUa8R+2BBdVm9OlNOB5gR9Twan7Knz37f/xqc9on3dOuUtfDAAiRT+kh
         OXhmu54so5hADT473mfITtuhrp1OmTV0f2ooj0qvs2kDCf0RfUD88VAZWS1tcw7MbhHQ
         RtwCttk3U6NBii3FHYDz3tdXkmHm4TPR4vRULcVQE4BRCFKS3mLFqXTCkJnDpnNNBZld
         /dZEdZjgy1cogzp2HxwnFMkfEGyYNsM2LKwUlHcSq7bINsTpFACvOP1ZK6s1votJSV8R
         c4jDr7MwvNQOMmMxdOwndINkL0s+AXcUAUJrz4GpLLSPJ7KlQbN91cWlSfjGx946sMXO
         SJKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZUGxZ16/JQIjCeMsGRjSIO22g5ZIjKs1bVbzqtjDg59ubhp5BGVwmfRg70wDROBqksXbNDnNJVvexZyzGHE3pSJdtEnx+tyqBxWv3
X-Gm-Message-State: AOJu0YwqkHgc2W+bl2c4yZPW61/9nL2oeecXwX9nQt11kAM2QVqr21sE
	OgcU6PEnokavoa0X9JEA9dxCGLJrGCoNSv5OppEZguqGB2/iz6A7GSGrgquTy/t0xdkFmOQch/l
	vRSZARS1p90JsFdgUTVw+fhXSDj3BNvtS3wcjIfLchKL0sKyUuGo80Cmj3ONlRg==
X-Received: by 2002:a17:906:6d6:b0:a51:9c84:452a with SMTP id v22-20020a17090606d600b00a519c84452amr370369ejb.32.1712775136360;
        Wed, 10 Apr 2024 11:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1iFYjQA8OwfFC6VX0bBrJyiQxPUlS2gTGbMCNuytFyfhjITYLIoqbcfKI0qJUO2jG4uTADA==
X-Received: by 2002:a17:906:6d6:b0:a51:9c84:452a with SMTP id v22-20020a17090606d600b00a519c84452amr370347ejb.32.1712775135919;
        Wed, 10 Apr 2024 11:52:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id qx3-20020a170906fcc300b00a4e26377bf1sm7332917ejb.175.2024.04.10.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:52:15 -0700 (PDT)
Message-ID: <6218ebd9-b5b7-4065-99b2-a742df6197d1@redhat.com>
Date: Wed, 10 Apr 2024 20:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com>
 <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
 <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
 <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
 <20240409062504.26cfcdde@kernel.org>
 <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
 <6517b5ae-e302-4cbe-8a4c-716e604822ce@redhat.com>
 <CAKgT0UcAw8tENoS7r2YYV2vQ562PPUcgQwfJXhzi8aS+ujZEYA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKgT0UcAw8tENoS7r2YYV2vQ562PPUcgQwfJXhzi8aS+ujZEYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 20:19, Alexander Duyck wrote:
> On Wed, Apr 10, 2024 at 9:06 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.04.24 17:11, Alexander Duyck wrote:
>>> On Tue, Apr 9, 2024 at 6:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
>>>>>> Just to be clear this isn't an Ack, but if you are going to list
>>>>>> maintainers for this my name should be on the list so this is the
>>>>>> preferred format. There are still some things to be cleaned up in this
>>>>>> patch.
>>>>>
>>>>> Sure, I was talking about "Alexander seems to be the orginal author for
>>>>> page_frag, we can add him to the MAINTAINERS later if we have an ack from
>>>>> him." in the commit log.
>>>>
>>>> Do we have to have a MAINTAINERS entry for every 1000 lines of code?
>>>> It really feels forced :/
>>>
>>> I don't disagree. However, if nothing else I think it gets used as a
>>> part of get_maintainers.pl that tells you who to email about changes
>>> doesn't it? It might make sense in my case since I am still
>>> maintaining it using my gmail account, but I think the commits for
>>> that were mostly from my Intel account weren't they? So if nothing
>>> else it might be a way to provide a trail of breadcrumbs on how to
>>> find a maintainer who changed employers..
>>
>> Would a .mailmap entry also help for your case, such that the mail
>> address might get mapped to the new one? (note, I never edited .mailmap
>> myself)
> 
> Not sure. My concern is that it might undo the existing tracking for
> contributions by employer as I know they use the emails for the most
> basic setup for that. I suppose that is one downside of being a job
> hopper.. :-P

I wouldn't be concerned about undoing existing tracking. I can spot 
people in .mailmap with more than 5 entries / different employers, so it 
is quite common!

> 
> I'd rather not make more work for someone like Jon Corbet or Jakub who
> I know maintain statistics based on the emails used and such.

 From what I recall, they do have their own mapping of mail addresses to 
employers, for example for people that just don't use corporate mail 
addresses.

-- 
Cheers,

David / dhildenb


