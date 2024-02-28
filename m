Return-Path: <linux-kernel+bounces-84773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB486AB63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FD728352D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09BC364A0;
	Wed, 28 Feb 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmjy6xO5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56713364D2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112852; cv=none; b=Jh2RSpmJHMkomK+85lyVoZVFUgLHiCE7FNiepG7Lb100VNOGk4+7ZWEktXEXuckQPctzdJdpH1ud50C4UayCAgLKMG1+qfeStr6XXz+suhdi4uwhQ+oct+fuzSXirocK0AJbyFYWz8o2MuG6OMpYTE3BiM9So+NT2vh4Zvhdx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112852; c=relaxed/simple;
	bh=Q5S+Njdd8bhurIgDL9WzuaaudyzxUAeJaL4OgP1h1nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dm1eGAxuiW7cB/Y5wPK9e0lPFbgsAp6df4l/1Cq3MEX659C0+UgMh/bUroBr0WsOkJ9habsZ2ujfZAP/65NDPVDZmHYi+dpAMVeRn+D3Gk7S3eWEd15HgQR4DVy8SFnUm5jVYdt8KoE+DItBpDgEni7rdcP3u87VlUpEsJvQiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmjy6xO5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709112849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=paHRAJ44zReBwEf+4/MpQO07yBq5PB+a0frjdqqTm0E=;
	b=Mmjy6xO5/jbhbkQW4yZxGYOsOso5rxXz5iPu46//UU7ekYn9MexdK02rF1KleF7rgj9tPY
	9u2wjLdPMpoWS1eNn2F7UL74ZiaCg0WMrrON6ObqC9e2IaXWtmF9UV6fWYyJ7TkA9Zlcbm
	FkdDa/hA+rO+a2FEj2Mva4M04glM92g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-WThbEDvYPh-aBsAImqnZ1Q-1; Wed, 28 Feb 2024 04:34:07 -0500
X-MC-Unique: WThbEDvYPh-aBsAImqnZ1Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-566195392eeso584722a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112846; x=1709717646;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paHRAJ44zReBwEf+4/MpQO07yBq5PB+a0frjdqqTm0E=;
        b=r+A/DuplAoj24tJrU8K5BwH1k9arIYiIUGMSLCar8UBV/tzcqjYDtSHDZk7X3TTJeU
         VtAPbXArrPGUfc0d0EzGXfCKl3EU7nCapvVCeqYKYr0aTnH8PQJ/GUeRzqR+fHJ1zd8i
         vk277yNIn0UQAig/pLi97MagLurmSxPORkQ2aJhj8sJKZPWwJxxRU8/3B5q2dVhEFcyG
         VRkmIA2RL4OAuZtiyUq/YzDvdQ00YnMQlLtRtuLirx3vb93mBGBf5hfEgsH1Oywtj+lH
         XCfxIsDPrqwE/HvRl0XbEqoTsf6NSzTU2XpfRebjDD6Gp88QtvmbxgbrHVOcW3VV+o6k
         gIdA==
X-Forwarded-Encrypted: i=1; AJvYcCWMRiDzqG4PczywmP0Us3Hp1gbj0MfrT7ueSckwCBNXLE2nf78hTlfRoorCHrQwvTGFvTstrmpc/Mpl+fUKUkt1cu7H5NF95qod4dWh
X-Gm-Message-State: AOJu0YyQahYPKJHilYYaZ7x0CozIEwsWDu1HsqBJIjiQjLc3/I35Tw/e
	/ycLHmKGFc4C9I/FyjmJGzLFyACwrB2/n/PWEBdbxgBVZkZn2HXbnOcnf618RsIW9Wcg/aTt3rK
	jQBxs83hILsBYQKjHNvYYVL1sKG5+XF/Rz8NPsvrzIWmG6dDgTRzN+b17/ly1LQ==
X-Received: by 2002:a05:6402:4022:b0:566:72b0:286a with SMTP id d34-20020a056402402200b0056672b0286amr762882eda.2.1709112846667;
        Wed, 28 Feb 2024 01:34:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU8C7gERAJhILIISLEBoy8Jl60VJcu/2Dgsco6+wq67tJ/NqqNO3ZzUBw8tfaMzB4vq2zhsA==
X-Received: by 2002:a05:6402:4022:b0:566:72b0:286a with SMTP id d34-20020a056402402200b0056672b0286amr762854eda.2.1709112846261;
        Wed, 28 Feb 2024 01:34:06 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7cd93000000b0056486eaa669sm1610116edv.50.2024.02.28.01.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:34:05 -0800 (PST)
Message-ID: <1d9b85ce-63d1-43b4-a4ad-b9c1d89f952b@redhat.com>
Date: Wed, 28 Feb 2024 10:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org,
 surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240222070544.133673-1-21cnbao@gmail.com>
 <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com>
 <CAGsJ_4zWU91J_71zVjKua-RTO4hDUJMkL7z_RP1GnYf3W1dNEA@mail.gmail.com>
 <a4a9054f-2040-4f70-8d10-a5af4972e5aa@arm.com>
 <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>>
>>>>> To me, it seems safer to split or do some other similar optimization if we find a
>>>>> large folio has partial map and unmap.
>>>>
>>>> I'm hoping that we can avoid any new direct users of _nr_pages_mapped if
>>>> possible.
>>>>
>>>
>>> Is _nr_pages_mapped < nr_pages a reasonable case to split as we
>>> have known the folio has at least some subpages zapped?
>>
>> I'm not sure we need this - the folio's presence on the split list will tell us
>> everything we need to know I think?
> 
> I agree, this is just one question to David, not my proposal.  if
> deferred_list is sufficient,
> I prefer we use deferred_list.
> 
> I actually don't quite understand why David dislikes _nr_pages_mapped being used
> though I do think _nr_pages_mapped cannot precisely reflect how a
> folio is mapped
> by multi-processes. but _nr_pages_mapped < nr_pages seems be safe to
> tell the folio
> is partially unmapped :-)

I'm hoping we can get rid of _nr_pages_mapped in some kernel configs in 
the future (that's what I am working on). So the less we depend on it 
the better.

With the total mapcount patch I'll revive shortly, _nr_pages_mapped will 
only be used inside rmap code. I'm hoping we won't have to introduce 
other users that will be harder to get rid of.

So please, if avoidable, no usage of _nr_pages_mapped outside of core 
rmap code.

-- 
Cheers,

David / dhildenb


