Return-Path: <linux-kernel+bounces-93034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232678729EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBC9289049
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BA12D1EF;
	Tue,  5 Mar 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJbPIMrL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D812C544
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676322; cv=none; b=Rv45mvtDQrYg8Fz9jpRA14V9kYtwFz2+d92ilygsRTNjseOj1aQi+KZXx8Ny0L4MGqfYa1zlIANh7T0XjyVbP5xKZsrn9xNqiafOy2XLcyk3BOR4zU1lPYKRI86niueJx1KE6BbFGDrECX2wmvFXUhE0JhhJN3oNC1MzlrOgfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676322; c=relaxed/simple;
	bh=+amvZSJ73Ak7qUWNWMkUOkQqMjcSn512iRVvJk0yx6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Owv0PbJd+4Na0Fb7o3yv5s0l/Gt9SVXysBwpPvBf6HwFeXa0CsMsrSgVweLW5zgLVcpkaCghbe5j64rIAb0Yl3rgN5FPkhjUc4yAFbXIKH618UNIpDZCUo94XPANLEbCJq6ej6eVrqCHpGjUGmhvcD5ptgDRFd5qsZoYrDveg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJbPIMrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709676316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DzluRZS8Cm/GFP3w8cOcmLM2pAOUgthF701QClSkUA4=;
	b=WJbPIMrLN6zHxMMWzKqhI6kM0Ge+xqzBLBGR2HBetcgyLH6/qSQOr5dhY4G5VmW8aRqLDp
	dZmlBCLXGHvtAHowz4FJJryvifUlDJb1jTkuN/L8ltXE0xgw0qnbHlOn8+IFfILfOPX/eF
	1569f9FTzjXCG/hPFwnGVeGwc2Z2A60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-pLvbZ_6wN5WIRNVXTxKNYA-1; Tue, 05 Mar 2024 17:05:14 -0500
X-MC-Unique: pLvbZ_6wN5WIRNVXTxKNYA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412f02c0204so3769575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676313; x=1710281113;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzluRZS8Cm/GFP3w8cOcmLM2pAOUgthF701QClSkUA4=;
        b=C7Z5woxd1OF8he2zt8bQzzNJQGasgWft9FFktPMHu59z7xnDXqjwCksyz8pg8Jy3sn
         IZ00COA8rdztFuT8FaSYWbp9OI9Fjr4/N/cEg+TgkiTrdM7i1ZdiueC0yGGEcH4RR+ZY
         uEKIgHjjgP4MAroIosAK+lAKwpRUTh+Tg/MdlT1hts+VaAF/xPt+Wwf8nZvxcyS39RQ2
         hKi9bHhE7/r4C7vLCBxMTyB/o/SadQBzcz+zBdskbH4M4/QCjKW2mNqo5LjPXSOKu1lz
         5+sVJdcl4dfjE8XBrMZwEEwkH2SrOD53oRyFM+Xjrk3h/nomhJnJsAaWcqKee+yOEMmA
         DUlA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdtRt3mTPCdT8ZGIwwLuo9I9ghSHDFLsjoVHDWX/1cPwcG1IwWEUt/s6ezTclL0bA+iyr2+zPdWV7Rf/8GlMqGo3vDjxJhOe+uOAs
X-Gm-Message-State: AOJu0YzbbgGe1e//vni4U0LrhvYI0UigmEgj6s44v//rFTWrkoRqD7xC
	2ABDVReT/MwHcMTaTFtOh0v3s6SiJwzsSlpfwIPIucgxqXr2KKOg5z/Xep0Ijh16MSjB7R4dhwf
	hKuaGQptGhV2vr6EHtjEUALZV2Hfrriv8cL0rSVpUr37dNtu0+WxgPL6MH0kxUQ==
X-Received: by 2002:a05:600c:1550:b0:412:eef2:f972 with SMTP id f16-20020a05600c155000b00412eef2f972mr1680276wmg.36.1709676313182;
        Tue, 05 Mar 2024 14:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEccOZTzYunDsM+vNXuQrx4USnVo5MJLdF/Q+aVrijQcyOt2IUcUE3EnE4NNRPsZaaw4tgwTg==
X-Received: by 2002:a05:600c:1550:b0:412:eef2:f972 with SMTP id f16-20020a05600c155000b00412eef2f972mr1680267wmg.36.1709676312793;
        Tue, 05 Mar 2024 14:05:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0033e48db23bdsm3004511wrb.100.2024.03.05.14.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:05:12 -0800 (PST)
Message-ID: <017414bc-78cd-4aa1-9edf-6ce947b9e4e4@redhat.com>
Date: Tue, 5 Mar 2024 23:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
 <8989df79-84f5-488c-bd74-c11d2241eff1@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8989df79-84f5-488c-bd74-c11d2241eff1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 17:33, Ryan Roberts wrote:
> On 05/03/2024 15:50, David Hildenbrand wrote:
>> On 05.03.24 16:13, Ryan Roberts wrote:
>>> There was previously a theoretical window where swapoff() could run and
>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>> running in another thread. This could cause, amongst other bad
>>> possibilities, swap_page_trans_huge_swapped() (called by
>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>
>>> This is a theoretical problem and I haven't been able to provoke it from
>>> a test case. But there has been agreement based on code review that this
>>> is possible (see link below).
>>>
>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>> where this extra check would cause any false alarms.
>>>
>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>> for deriving this):
>>
>> Almost
>>
>> "s/Hilenbrand/Hildenbrand/" :)
> 
> Ahh sorry... I even explicitly checked it against your name on emails... fat
> fingers...

No need to be sorry. Even your average German person would get it wrong,
because there are other (more common) variants :)

[...]

>>>
>>
>> LGTM
>>
>> Are you planning on sending a doc extension for get_swap_device()?
> 
> I saw your comment:
> 
> We should likely update the documentation of get_swap_device(), that after
> decrementing the refcount, the SI might become stale and should not be touched
> without a prior get_swap_device().
> 
> But when I went to make the changes, I saw the documentation already said:
> 
> ...we need to enclose all swap related functions with get_swap_device() and
> put_swap_device()... Notice that swapoff ... can still happen before the
> percpu_ref_tryget_live() in get_swap_device() or after the percpu_ref_put() in
> put_swap_device()... The caller must be prepared for that.
> 
> I thought that already covered it? I'm sure as usual, I've misunderstood your
> point. Happy to respin if you have something in mind?

No need to respin, we could clarify on top, if we decide it makes sense.

I was thinking about something like this, making it clearer that the PTL
discussion above does not express the corner case we discovered:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2b3a2d85e350b..646a436581eee 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1232,6 +1232,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
   * with get_swap_device() and put_swap_device(), unless the swap
   * functions call get/put_swap_device() by themselves.
   *
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
   * Check whether swap entry is valid in the swap device.  If so,
   * return pointer to swap_info_struct, and keep the swap entry valid
   * via preventing the swap device from being swapoff, until


-- 
Cheers,

David / dhildenb


