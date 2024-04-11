Return-Path: <linux-kernel+bounces-141610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF688A20AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4334F1C21444
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2522C68F;
	Thu, 11 Apr 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyhQYHVV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93115E8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869710; cv=none; b=V3cs5OEC2Ma6MP3Bn4DAXxl2KV265MkH/eWXaVdYxnIiezmYRPe4wz/dOpngZ/NPtvj6NjwOYH1wd7C/rqX5i8pAqo3XWoN6Ke70CS87qms9XDS7+V4VtwpVTa41c2qZbmYcIU7IAb/FPWWagmOSfornay4kA2PbfGg8j8ybSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869710; c=relaxed/simple;
	bh=0akUsYDcyt55BCShwGmo1e69/S8koAo8yeIQVg0G1RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN/jjlSRiez/YKPrUyAVtp4L2kx/os+ZbyXYJEpMPp3SSf0dDGU75obdCcI7gm6Jneyf0u9UhnnC3pwuyCH1MHmxUvkTe/Ekkks+1LdxbgtOP3YKxVuX6Pg3IVSmYHzVCel9KUAr4KWxH372PwolGox0dXLNaHmgLdss1Y4OXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyhQYHVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712869707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSBmVxyJ6JVsrZaKrB/JKr84S8u2TKiWCHnDr9Q6xus=;
	b=eyhQYHVVPkYYPuQkRaVQPtSkGQ8qPFwtz6HrRYb+aIOBcfDlVp6DkG6u8ZYuni0yoj5IFs
	1Se1HnpsjVN17klMCKRiWJVS/7QFcBNYIUlXrBTqV+CZb2ghR9WK8NVsrCtq15f+5cYIWX
	nZp5PfRzXamLKjddd4lWYwqCKle/YmM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-VaapUww3NZCRHD-FpIxa2A-1; Thu, 11 Apr 2024 17:08:26 -0400
X-MC-Unique: VaapUww3NZCRHD-FpIxa2A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343c8e87a74so153544f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869704; x=1713474504;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gSBmVxyJ6JVsrZaKrB/JKr84S8u2TKiWCHnDr9Q6xus=;
        b=BhIq5uOxAFBKyqXpg4iVN4y4q9ljpcHlIHMWkNn940JtRiLYYArV/oJDEVxE9IkPQ5
         Rz74SnlHBj5G7/v712OpcdpozxRRLOqMJWoqjt+awcPnn+zB+5bSeQYbtlfuTwHpFcme
         Z+iBQpE4L44rpJztA8987bH7zJ83M29naVVyItix5lVYwPLDupku9zZkWh/crJ9GWDey
         4IaojzOzp80WmKebywNodI/13coNjhJYXG1AaJZSIPgR138bqKwfSulaFVvX781cnsKP
         4lAAPXtvfi5YE4nhv/urxX/H1IPUJDv+K+eaT6czDFdwiOkgoR8UxuDeYe8l76YZh9o+
         E0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUYo/ab0E7P1O0NIEU/YYlSBh4jvTT68bM5rG4YszFoN2OLkKQLb8ucMW3X56t8nrQJnW1yDATshi6QigeXrcJbCHAI/xuDiPn3EEd
X-Gm-Message-State: AOJu0YxEY1I4QNysbhb2PrQOnN7edtgcx88Y+RgRxPhV8xRSa6y78A50
	b3kMB0Wt4J8UprM/NFhKkmjvgYwpaOUU6KH+Jx1oVjVioZ3fMX7kz8+LtZOgYW1/5DSMkRkzcj1
	NCCu+WtjLfU70VmFS/muH6KofXQcVJti1BYSlQgpi1PfW1wMRfT87wvP9HPoaXA==
X-Received: by 2002:adf:eb03:0:b0:346:b8cf:b620 with SMTP id s3-20020adfeb03000000b00346b8cfb620mr515426wrn.53.1712869704726;
        Thu, 11 Apr 2024 14:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSSmIkNgIsFLkyck8REIEfGp1Ax08GdESLG7JWWH3sJp2cfh7JDrj55So4VUNVf3d9gcoDcw==
X-Received: by 2002:adf:eb03:0:b0:346:b8cf:b620 with SMTP id s3-20020adfeb03000000b00346b8cfb620mr515403wrn.53.1712869704263;
        Thu, 11 Apr 2024 14:08:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6245000000b0034334af2957sm2616594wrv.37.2024.04.11.14.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:08:23 -0700 (PDT)
Message-ID: <c9957321-b307-49b2-a593-b99eb83eac51@redhat.com>
Date: Thu, 11 Apr 2024 23:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-10-alexs@kernel.org>
 <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
 <add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
 <47686d5e-efd3-4431-b72c-620f749faeaa@redhat.com>
 <20240411134234.09920cdb641b3aa001526284@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240411134234.09920cdb641b3aa001526284@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 22:42, Andrew Morton wrote:
> On Thu, 11 Apr 2024 13:46:23 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 11.04.24 13:42, Alex Shi wrote:
>>>
>>>
>>> On 4/11/24 3:51 PM, David Hildenbrand wrote:
>>>> On 11.04.24 08:17, alexs@kernel.org wrote:
>>>>> From: David Hildenbrand <david@redhat.com>
>>>>>
>>>>> As we are removing get_ksm_page_flags(), make the flags match the new
>>>>> function name.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> Reviewed-by: Alex Shi <alexs@kernel.org>
>>>>> ---
>>>>
>>>> s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.
>>>>
>>>
>>> Uh, for this trivial issue, do I need to sent a new version? or left to maintainer for a quick fix?
>>
>> I'm sure Andrew can fix that up :)
> 
> He indeed can.  Although he prefers foo() to foo.  Those two characters
> have a good information-per-byte ratio.

I prefer that information as well, if it's correct -- but 
get_ksm_page_flags is not a function but the name of an enum :)

-- 
Cheers,

David / dhildenb


