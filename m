Return-Path: <linux-kernel+bounces-95415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC34874D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052861F25F10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C0128366;
	Thu,  7 Mar 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/sIndlI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5630127B62
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810731; cv=none; b=u6GkYCjkznbn8GIpQ8iRJx9Rh9mV5ycADkjnmALeGvDRohWEz6pWxE1WZC+2UXV7cdt9Gs+jCCwkPgfzPkzJCN2/hQ4VvJerKdUh0JzWeJuVw0C8k29YCAQ6J0ozVZOyRpzdUwBmuPuPTl+E5rSnt2LxEaIEMu3DkAWvWgJRLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810731; c=relaxed/simple;
	bh=fJBOKVWu3kgpC3Rdw5yG6kODOEKg/+upYsBKSvbp+6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDgpe0tJFDNQKjnB/1F+ZSCAeQxAgsP+iUYfyKbG/X+QNn51veXXoxuIsIQRuPLD3iHBlruXM4Obf6q190ID1WOhsRfDLzPSd8a+lEu9mcLFYxgJ9rnRs4AEm8qq/a8xjsttoooyrdA0n8BTPkEaDtWrxKNRBGyyIckY561vd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/sIndlI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709810728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3S+gBBiGC+cC9yPoPCyuB6+zTSWw3v8rgYOSL8U7bE=;
	b=d/sIndlIH0he4mn0VCtUh20XoUEnIzEBe+J3jhcVV7WjFCucY2Otwfvhub8tokLtglYj5e
	7bB0dbr24TFt7c8+On5hpedaXv3VebduRW+VhcOjXMLFjFSm6y8S0ttMkWF81qMwdBnFFA
	FrHVUN631sJACPVJW6PlhxLqfAkQxCA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-PJYVVju5NoOJwCoohGEoZA-1; Thu, 07 Mar 2024 06:25:27 -0500
X-MC-Unique: PJYVVju5NoOJwCoohGEoZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412de852c6bso4475925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810419; x=1710415219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3S+gBBiGC+cC9yPoPCyuB6+zTSWw3v8rgYOSL8U7bE=;
        b=VZ0oZ4G+P9zgFNfN1Z3SvKnokgrgwK/DDWPgEPV3eAfjjQfnANwfQOjnlLk8gMcEJr
         wxN7aVPMlJMpu5QH873d/CJm6jmMXitf/+NOLXHoPJp4QAqOBbAL9V2TmKLGQCVfcDAk
         WTBrPnOOZCJWfrr4t1+M7Xy4aiGqV2qHN6pJKS16SnrTpqR0Z9rceihc7vEE8lSIAHZw
         8QLX9nNkyjacAZGKgLxJeUZshD6rNxNkBJhVFz6YDv7OMSzHuMla8vZBIQZH7Uiz5CYP
         rgvEykw/OdPw/0cipXRKh2LlDlL8pfaV2lBcwVxdrmtfASs3fhloLu0i7ToWU+td3Bpk
         n+jA==
X-Forwarded-Encrypted: i=1; AJvYcCVhnCPhxXSe6F7mhKE3xNOlOyRYKaNyhojl/b/27sSP+9z40lT0KJjTES+WopYgmH24vdZYtXaYBuzJvq0H0cszphxFTxYpwpqAmktl
X-Gm-Message-State: AOJu0YwsI/U3joNuz4E1PdcWbSgI99NxXAfqIPEqhG8yMKkdHoyU0lcc
	laXLgTcTm+Dj4YaNADsy27fXMKOe8frCJGN1Ind/BTjejiZXqOMOaZ8tAJhtv91UsupTVKEECfG
	4k8EQsBRPp/4MlpYwrQ6a2NfCwM2AD1dVdAkJ3/I7Htbkzjr4c2N8k0C3R1Sfbg==
X-Received: by 2002:a05:600c:34d4:b0:412:eddd:12ad with SMTP id d20-20020a05600c34d400b00412eddd12admr5559550wmq.33.1709810419383;
        Thu, 07 Mar 2024 03:20:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5DAdcAYEJic676KLzGOBvUMTYZ0gt2jHmHrLssTtgX9xQo7uLXszebrBAe+xRJuODn/1+lw==
X-Received: by 2002:a05:600c:34d4:b0:412:eddd:12ad with SMTP id d20-20020a05600c34d400b00412eddd12admr5559532wmq.33.1709810418997;
        Thu, 07 Mar 2024 03:20:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b0041312bdcd6fsm845702wmo.40.2024.03.07.03.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:20:18 -0800 (PST)
Message-ID: <7d9321db-a3c1-4593-91fa-c7f97bd9eecd@redhat.com>
Date: Thu, 7 Mar 2024 12:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm <linux-mm@kvack.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 upstream+pagemap@sigma-star.at, adobriyan@gmail.com,
 wangkefeng wang <wangkefeng.wang@huawei.com>,
 ryan roberts <ryan.roberts@arm.com>, hughd@google.com, peterx@redhat.com,
 avagin@google.com, lstoakes@gmail.com, vbabka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 usama anjum <usama.anjum@collabora.com>, Jonathan Corbet <corbet@lwn.net>
References: <20240306232339.29659-1-richard@nod.at>
 <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com>
 <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 12:10, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "David Hildenbrand" <david@redhat.com>
>> But why is that required? What is the target use case? (I did not get
>> the cover letter in my inbox)
>>
>> We're running slowly but steadily out of bits, so we better make wise
>> decisions.
>>
>> Also, consider: Architectures where the dirty/access bit is not HW
>> managed could indicate "writable" here although we *will* get a page
>> fault to set the page dirty/accessed.
> 
> I'm currently investigating why a real-time application faces unexpected
> page faults. Page faults are usually fatal for real-time work loads because
> the latency constraints are no longer met.

Are you concerned about any type of page fault, or are things like a 
simple remapping of the same page from "read-only to writable" 
acceptable? ("very minor fault")

> 
> So, I wrote a small tool to inspect the memory mappings of a process to find
> areas which are not correctly pre-faulted. While doing so I noticed that
> there is currently no way to detect CoW mappings.
> Exposing the writable property of a PTE seemed like a good start to me.

Is it just about "detection" for debugging purposes or about "fixup" in 
running applications?

If it's the latter, MADV_POPULATE_WRITE might do what you want (in 
writable mappings).

-- 
Cheers,

David / dhildenb


