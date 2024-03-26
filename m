Return-Path: <linux-kernel+bounces-119545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40A88CA37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14406B27AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A713D61D;
	Tue, 26 Mar 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyc1dPoa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6751C697
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472693; cv=none; b=KZwLXOMpjOrSmJuZjj+R7qoRmohYTz8Vq2bgANZ7IixrSJSQzrkeJKj7a4GiDq5ztV9oC710cXmWFBs3mFg+wzAcFSpCf6oqCQwNKC28rPED30N/zNKk9zGyeR0W7LM06BQ0Cgs8IAlvc20DUospULG6hkTavuA8X3CWz8LZt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472693; c=relaxed/simple;
	bh=kpsWRkeiV8YzMY2AI1vNmodJ9g81fNrq7YQw6sCWt+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/xCNx8v5DDubDJms9tyCo02e3UYLfFmAuSCWPgiQIjL4OMzin4kDN5jCaOOkZXAsfNnBHCkP9gCAn05p+eq1DXHqu5/s+TJyRpALkbYdEWMDc8EdiFkbGeI9wmf3c/Vt161yPLMccP+73r2006RmTXWBFJ6dHfUNRZqju0WcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zyc1dPoa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711472690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=03P2aTLfOU4JI8jvZfElyWjm8J8f3fb9SGZBFQXPDVg=;
	b=Zyc1dPoaXVATyiWkbAd3P2hRqx2v6DOt6zh5TDrsJ6iy1D0EaeZpj2A0b2WrC+qOj6WoUx
	VtTMbOGNiqO2WAY5r79W1ziW79V28pAr6uMKaQrLuRu5SSXnABEJm1AXdaAgY3mg5zq24C
	NwxlTKh4XhWShDd4qK3QxR7uH2QzDX4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-avhHloy4MwiZ4yV8PlC9JA-1; Tue, 26 Mar 2024 13:04:49 -0400
X-MC-Unique: avhHloy4MwiZ4yV8PlC9JA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d48d13b3c9so51830571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472687; x=1712077487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03P2aTLfOU4JI8jvZfElyWjm8J8f3fb9SGZBFQXPDVg=;
        b=NiZhgCGiJBUCxx+sRMiJnxC45XGccOAM1CDGD4UcxxtQImOZhbR9dBXL4TlM4xL+fi
         F3z4Xn4IIVNK2PdyCgAl7g3hI7rpH773aYYh2MvCleBWIICDq11yI/J/aaZiv6yrFYeV
         Xl+Wm78fL1goFhzwGZKrO38emaZfqeMsKkyUOjYy30I4BiDrEZqnyH3Sa9wcWJetJwaE
         fo2OmVcZkJzGwxRaEHRtb56TCnenvcD92atQUyjmm4irtUWqQ4oklOEHefF3L3222m5R
         EGM5HI6OfTJkLA2Ov4QOF21HrpuH5C0K1sDpO2VHKTYVlRGMFbFUYkbA2/fT8eHN3cp9
         dsmg==
X-Forwarded-Encrypted: i=1; AJvYcCVGaFafuDO46xR+bTlhf2gJc2CijWtXvrIYwY5wzgXXyXy9sY33XbAXiGE2duDtimoqDcrL5QOc7XbcOBfQC4dxMOAtxE9Grn/W7oYm
X-Gm-Message-State: AOJu0YwVjynqTKEGZ8oj8UWuZp9LRqjOt9wMWZ/9Wjq8VukjUxA/qYH7
	/xu3bTEudYXXUrXJDlKYKuZt9DfuUP6di0BMiNvzJF/5bPUTXbVVqaliFqw6qc6HiEjlhQ1azFm
	2v6jrNx3RWU+1AbC3Abg3uU0BshN4l1Yf4cH5s+M0IAdsZj02Q981hI4FRiudncEGBYFyyg==
X-Received: by 2002:a2e:824a:0:b0:2d4:5ce6:a98b with SMTP id j10-20020a2e824a000000b002d45ce6a98bmr1535685ljh.22.1711472687624;
        Tue, 26 Mar 2024 10:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhLvwcE9L0qlrL+TvSqfSActOYPZmwun2UKHtr7kk/ptfNYv2QauPlfqH7AHvVZxqgyZQzMw==
X-Received: by 2002:a2e:824a:0:b0:2d4:5ce6:a98b with SMTP id j10-20020a2e824a000000b002d45ce6a98bmr1535665ljh.22.1711472687197;
        Tue, 26 Mar 2024 10:04:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id n12-20020a056000170c00b00341ddd7db5csm192186wrc.75.2024.03.26.10.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:04:46 -0700 (PDT)
Message-ID: <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
Date: Tue, 26 Mar 2024 18:04:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
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
 <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
 <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
 <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
 <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>
>>>> Likely, we just want to read "the real deal" on both sides of the pte_same()
>>>> handling.
>>>
>>> Sorry I'm not sure I understand? You mean read the full pte including
>>> access/dirty? That's the same as dropping the patch, right? Of course if we do
>>> that, we still have to keep pte_get_lockless() around for this case. In an ideal
>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>
>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect any
>> architecture.
>>
>> I do wonder if pte_same_norecency() should be defined per architecture and the
>> default would be pte_same(). So we could avoid the mkold etc on all other
>> architectures.
> 
> Wouldn't that break it's semantics? The "norecency" of
> ptep_get_lockless_norecency() means "recency information in the returned pte may
> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
> access and dirty bits when you do the comparison".

My idea was that ptep_get_lockless_norecency() would return the actual 
result on these architectures. So e.g., on x86, there would be no actual 
change in generated code.

But yes, the documentation of these functions would have to be improved.

Now I wonder if ptep_get_lockless_norecency() should actively clear 
dirty/accessed bits to more easily find any actual issues where the bits 
still matter ...

> 
> I think you could only do the optimization you describe if you required that
> pte_same_norecency() would only be given values returned by
> ptep_get_lockless_norecency() (or ptep_get_norecency()). Even then, its not
> quite the same; if a page is accessed between gets one will return true and the
> other false.

Right.

-- 
Cheers,

David / dhildenb


