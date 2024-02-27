Return-Path: <linux-kernel+bounces-83911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF786A002
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306691F244D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86F51C39;
	Tue, 27 Feb 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4/gX0zE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39B1E894
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061533; cv=none; b=gHmqJLPT2rwFXE53944Vy8n05CVUJqX+wphH+Q2rQTKo0nyDHiRt4B3OsfbnbKYPWo2sg5e1R2XZwrJxq/e1h4gSsH7+UFE0c/L0I/qXRMaIqkbWmb1Ofz/WO6c3kI4+7y5euuJPOOrRdSTrwdSCqF9VJkNdMpCrCnPHrRzowsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061533; c=relaxed/simple;
	bh=Di4+elfKU6EGn8Y4YoS2wbPGOva6v8hMJ0TNqKbgtLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr2OiWmd8i7Dg0sUIPGUZXgJhQUFa72Ff3QAiHG+uARX8I9MQeg/DLJF3H5PbtWdYbLeQJjEdGX9SVWVfb3RbfrOd9x/YOqSA5dvBy6X7iAZzQiiWDA97EoHaLiPrJKTNUbCjKs8A5WE1/q6nldYftvNw3vpzKzqFF2A8mr0SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4/gX0zE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709061530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MTnvb4aSINmKS0HiM26zCq9VBIsJZUhhZ4YmUUMSqXE=;
	b=D4/gX0zE4v02aWb0pXZBdFchY0vFuY+I0FNM3R238Bi4WXPopT+hnWLnER/HDhdT5PRRLT
	GyoJB1qXzsJFDCgfquOmvX5vl3csQ5FZB9WCcNb1zRfwKO05UCGvBVgJ+c61LlXcf64LTP
	dKGKOJQlWvbybpaymZiMU+gOKAL69nM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-rN0cn8bdNcSoJWEL0qoS_Q-1; Tue, 27 Feb 2024 14:18:47 -0500
X-MC-Unique: rN0cn8bdNcSoJWEL0qoS_Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso1172560f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061526; x=1709666326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTnvb4aSINmKS0HiM26zCq9VBIsJZUhhZ4YmUUMSqXE=;
        b=w1OFrrGtUbpgOswfunHAvvLDY39ECuoN7NUUBQIacxazhYe+FockZ6vNVEYZtKU7gg
         dU5efhupNoBxE0I7Jg+lOfrx7NRoghgzdCn6PKRo9b2CdaFYP18q+S+b3WuImZVnbJaD
         DipLye0wtMaCEhV6159IEwehF+u4BC76hIaDxXjIYMbl+dVNGhTzo6d1GmUoq8JALUTz
         inTYIr2uUNtj26v2T/tdcKCRbIo0vETvoOov1ABkg4N6e25Xx+ovwE1GW5cigXIZhE8a
         Ah44UXreXIa2WBhlUzqMh2V284Dt4XtQIGLQEqf5mgLT4EBsZ0eOlFje03H8AijASlPQ
         dgVA==
X-Forwarded-Encrypted: i=1; AJvYcCUkX1412QKlLBVwvF1esIh6OrnmrFZ/ZbQCx9aS1uLzJQilDa8u/Ef/eDV8eAVebLETLG61zixn5wwgl5cITsLueU1mu4h7nI3ss8Oz
X-Gm-Message-State: AOJu0Yyzf55ua78hrlyM3OnoyjveXikSrIrHQDka7h5EYxYgf19ayzTj
	UmEnatcVg89edLxrpkTzNk/ek51UuzBFcBflYirmg4ogkszi9la9YS79YizPof/RUbYFsatbyCo
	RbVu+BykzjCGxjMbGBcQXHNG5tHMvOCPFuChTLg2tOlMjbPlR2+amVB8kCV90Lg==
X-Received: by 2002:a05:600c:4588:b0:412:8d98:34d0 with SMTP id r8-20020a05600c458800b004128d9834d0mr10403659wmo.33.1709061526456;
        Tue, 27 Feb 2024 11:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7mjbNqKXgNj2T2OoodCLkN+fc2bA1t2BKOP+BSGum3YXcnYMIVck15pqR1NnKk/MALqk3+Q==
X-Received: by 2002:a05:600c:4588:b0:412:8d98:34d0 with SMTP id r8-20020a05600c458800b004128d9834d0mr10403645wmo.33.1709061526037;
        Tue, 27 Feb 2024 11:18:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0033d56aa4f45sm11925656wri.112.2024.02.27.11.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:18:45 -0800 (PST)
Message-ID: <4b6b6f11-f9fe-401f-a1c9-0c6074bb5f84@redhat.com>
Date: Tue, 27 Feb 2024 20:18:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: keep mm in mm_slot without
 MMF_DISABLE_THP check
Content-Language: en-US
To: Yang Shi <shy828301@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240227035135.54593-1-ioworker0@gmail.com>
 <CAHbLzkoQ1wFjA5aR51K-XMW+shSVFgujJjKK+-OG4OfVFvgOyQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkoQ1wFjA5aR51K-XMW+shSVFgujJjKK+-OG4OfVFvgOyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.02.24 20:13, Yang Shi wrote:
> On Mon, Feb 26, 2024 at 7:51 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Previously, we removed the mm from mm_slot and dropped mm_count
>> if the MMF_THP_DISABLE flag was set. However, we didn't re-add
>> the mm back after clearing the MMF_THP_DISABLE flag. Additionally,
>> We add a check for the MMF_THP_DISABLE flag in hugepage_vma_revalidate().
>>
>> Fixes: 879c6000e191 ("mm/khugepaged: bypassing unnecessary scans with MMF_DISABLE_THP check")
> 
> I think Andrew will fold this fix into your original patch.


Unlikely, it's already in mm-stable.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


