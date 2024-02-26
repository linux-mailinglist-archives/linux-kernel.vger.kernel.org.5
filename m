Return-Path: <linux-kernel+bounces-81308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE6F8673D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4896B1F2AE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558441EB35;
	Mon, 26 Feb 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxmJmakY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887C1DA37
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948199; cv=none; b=QZgbPkpSvh2ttWrGU0CJSWgFLcFP7jys5bZhjYzRtOYhfT5r+IWtbBUD9sQwr1vr5xE+aJLIlMKQ51qM9eJNTadx2I7k2v5TFQBvARZJUiOCrVL3wLW/tIZ7ExUwOl4JzQwo9qcxGaMDCdWTnz1vWnmpYRTQyqtj6vz0VylFWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948199; c=relaxed/simple;
	bh=+HDyUIV6bdJd57P3k+NiZP5o9EmZJVhYkjxqxy+5Wpc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NvnNTLmIyESIqhBFGe/jZUmwRzr31x8kousNCPF5/k/mWH7wfbhVAlLqEkhCenD+fhKUmHLVll+ysEt8jCGWfGTIJso+TcICcSfkq1ipY0QPbL74dmCGVyV5+zsz9KY9oXoldyXjWV1MzCCHI/CcLnwZ3QK0Eehf5zyyj0x38PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxmJmakY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bM1RhXRtAqamhwPA94UPAfqm7qE6DhOK+5WVyhTCsd8=;
	b=dxmJmakYAIOn9vXOW+63h1so97ZxNp4gTDu63hofa44HJjJRb1vd/QD35Ks9kk9VXFg2ro
	LoGgyZu9Txv2K4czl5WdcDnNJYA3GlUpJeen/Sy68hfueFggB+aUaENf6aXla06dM+YPhd
	Jn+cHa8SLSNS0K/ApMcY1OJgWGC8ZEA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-_0oCmRKYNfOHRg2DCA0iug-1; Mon, 26 Feb 2024 06:49:54 -0500
X-MC-Unique: _0oCmRKYNfOHRg2DCA0iug-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso16600515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948193; x=1709552993;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bM1RhXRtAqamhwPA94UPAfqm7qE6DhOK+5WVyhTCsd8=;
        b=waMDOMkwJMulno8KJFmG9IJJnUgsR/G2sLbGFM9aOm5KCMcbf8E/8eH7V2INlIEyIU
         B3DidG+klayC9blCaATgl+ccB70tXMu5oxcodi4AEnOOkLx36bVkUBbMF3gMGtFNFmAO
         AW61rrBdyskZAzijPlIz/HmSC+QjULDp+JUPCv0oHSaO9MCfw2+mTr6fiIlJtyTeBzbv
         O1hNyk+UtyMi8Ow8pWqaVmnhEBxyzBuH+QqIaRnw7ua9Onkqcqsy/24aOPxq47YzUnU1
         Rk9xOYibkJZInEk+qXVbo5pw8tpp6rMIuh863tcYog3yl6ZZ71BK/yXAOYEjqgLUuvJC
         4DKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJuOxnURvi6O8N8whNwMBuiZgCKQTTuRl9TwaoJwG95+j4pB42ex04ZSDsZuYd8WA5jXhxlS3bWCklDml36MSZjXuE/87Ng30AUh1U
X-Gm-Message-State: AOJu0Yx/jtgjXUqpxecwyUxt48QL5dYj+uIQ7JXGWiI4bdPVWZNQZA/z
	t6OOKp32i1P+vUng23EMz1mchuhLeKipvHyTxeOTZtZ733mLAwwHAxzeG43wUSWc1KytCHP2zie
	PNJcBJ1WsSQXSUOb0Ibdhl0fOFHrCTP3IEuRs0wkAswQUnBUS07b7E6P66+DYaA==
X-Received: by 2002:a05:600c:3ba1:b0:40f:df17:f0ce with SMTP id n33-20020a05600c3ba100b0040fdf17f0cemr5098277wms.28.1708948193136;
        Mon, 26 Feb 2024 03:49:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnMWMrlJIL7aWbXfRifpJYql99NIRdGJZZ+qnOvV+D5YoXZ92ohh5OM2yU+yrpL/O228FzTg==
X-Received: by 2002:a05:600c:3ba1:b0:40f:df17:f0ce with SMTP id n33-20020a05600c3ba100b0040fdf17f0cemr5098259wms.28.1708948192733;
        Mon, 26 Feb 2024 03:49:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id jg7-20020a05600ca00700b004129a858a7esm8097986wmb.9.2024.02.26.03.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:49:52 -0800 (PST)
Message-ID: <b44572f7-4aa9-45b4-94bd-6860bebec0cf@redhat.com>
Date: Mon, 26 Feb 2024 12:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, thp: display [never] for defrag when THP is set to
 never
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Liu Song <liusong@linux.alibaba.com>,
 Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
 <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
 <d9eb6672-788e-414d-8138-37a3038e3c47@linux.alibaba.com>
 <8a723092-347d-443a-82e1-4093f6a1ba0e@redhat.com>
 <e649d47c-16d5-4077-8327-b6f76aa099a5@linux.alibaba.com>
 <b1988f61-e68d-4268-911b-8352fb49ea15@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b1988f61-e68d-4268-911b-8352fb49ea15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.02.24 12:48, David Hildenbrand wrote:
> On 26.02.24 12:22, Liu Song wrote:
>>
>> 在 2024/2/26 16:54, David Hildenbrand 写道:
>>> On 23.02.24 12:01, Liu Song wrote:
>>>>
>>>> 在 2024/2/22 20:14, David Hildenbrand 写道:
>>>>> On 22.02.24 12:53, Yuanhe Shu wrote:
>>>>>> When transparent_hugepage is set to never by cmdline or echo, defrag
>>>>>> still show what it used to be and can be modified which makes user
>>>>>> confusing whether defrag would take effect.
>>>>>>
>>>>>> Actually if transparent_hugepage is set to never, defrag will not take
>>>>>> effect. Just Display never and remain unchangeable to for defrag when
>>>>>> transparent_hugepage is set to never.
>>>>>>
>>>>>> Suggested-by: Liu Song <liusong@linux.alibaba.com>
>>>>>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>>>>>> ---
>>>>>
>>>>> No, I don't think we want such a dependency between both options.
>>>>>
>>>>> You might just end up breaking existing scripts (enable defrag before
>>>>> enabling THP) for no good reason.
>>>>>
>>>> In certain situations where khugepaged_thread is NULL, it would be more
>>>> reasonable for the value of
>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/defrag to be 0. The patch
>>>> should include a fix for this case.
>>>
>>> Why?
>>>
>>> We have a bunch of THP toggles. They reside in
>>> "/sys/kernel/mm/transparent_hugepage/", indicating that they are THP
>>> specific.
>>>
>>> Some of them are only in effect if some other toggles are set.
>>>
>>> That is very common practice.
>>>
>>> If you think something could be confusing, maybe clarify the doc? I
>>> don't immediately see why any code changes are required, really.
>>
>> We should explain this in the documentation, but to be honest, many
>> people don't read the documentation, and even after we explicitly
>> disable THP with transparent_hugepage=never, khugepaged/defrag is still
>> set to 1, and users come asking why it's still defragging. We can't
>> expect all users to have technical expertise, or to diligently read
>> through the documentation; it would obviously be best if we could avoid
>> user confusion altogether.
> 
> Then tell your users if a feature is enabled

s/enabled/disabled/
s/1on1/101/

Time for a break :D

Anyhow, there has to be a pretty good reason to change the semantics of 
these toggles that have been around forever. "users could be confused" 
is a not sufficient.

-- 
Cheers,

David / dhildenb


