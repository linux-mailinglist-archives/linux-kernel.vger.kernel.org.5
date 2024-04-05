Return-Path: <linux-kernel+bounces-132549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32576899682
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BB6281E77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D013418B;
	Fri,  5 Apr 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ulfv7xEz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56082E84A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301969; cv=none; b=pmJMINMc55NSjdcD0qsLeU/l/TE1XB77ORAbi6LLrXMujEeeSImn85ZCAPR/kQ9D2gtm2zxbno1wr//BJlz4RwiUjjYfUompRJM2Ztc7f0pvUitz6Ev67f3UhcHJtgf5E/nBj4OwmroinwLYdpbq06Y6RgxcAxmHaX2/l+FEwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301969; c=relaxed/simple;
	bh=Nm3shNyBzYZPuxzpWxnSFjJcOv8HPO1J6H0nX1l01qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga1tscq1YcOaia/S/2vpHryZUnfrzOGKPVkBYs6Kh+g2NfEA/wpzRg6ECmQr18JbbfLPK+G0qXZZAuXcc3wHrnKQTPUsrhz55Ij4tpKJ6kXWMLmdleISqm60FZfy7xP6b1x9TrCwcjnnDZmaFhJ6ujfmZoF+x7FMAHHt6ap0uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ulfv7xEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712301966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YYPo6a8b/Dn1eaTm4AbhQo8T7X2EQn/bAkcPOcFyLUY=;
	b=Ulfv7xEzY/Y5PaVdCwehYO1HAqqrY251dreTNIul6K9y61LqqHOMI+QiHaBjjrnjzh/IB5
	AEKtSBWalGH1iij8K7IYZ71LcaZprMNUhj22koILEdT58jbp++EyEOE9QhCNU2CQA0KQBv
	gvI8Y8ZGTfE5j/j+VG6H1tghOkQqLWc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-EHgOUK7AMS2IAzLmrt_fKw-1; Fri, 05 Apr 2024 03:26:03 -0400
X-MC-Unique: EHgOUK7AMS2IAzLmrt_fKw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343cd240b2dso556900f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301962; x=1712906762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYPo6a8b/Dn1eaTm4AbhQo8T7X2EQn/bAkcPOcFyLUY=;
        b=QGz/X18Nv7AYZtFAMdb9rJJjWkTZaXvnZ0KDbb3mHmPRDy28N4DC9i7GcGM2PwXwTz
         4Yq9D1SOVxDt/G/uPrCxHHiy8eP4GAx1YCBsezn+eFjJzhClrgrcRatAw45PVBu9MGkX
         9vrZxP2bt397KfrcrJAKR0pRTcZxwc7z/DaNwUDboeHI03sSB2OlO4GjsV0FMg4cjghE
         iIE/UYXKPBZ6S/Vy34/jJE5YC8jKs89f43E8tfyslzo2ZgcC+KlgqFk4MvcfkryDjsBj
         GbMHbsMuQQGSTFZ5Em2vk4SLxoqMicfAFARghQBLb7JMPuTnYqgJXyyd8fGZXMFL8nKt
         OVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3TuZoqpvLxgy8QAVOEY2PRKv7qn0OVxfM0vWZfM84dQmAzXts5rZ5LKwjA9mdGWk3nY/hyHWli74+QseFqeQJoNZ9BTsf4ZL9gGi0
X-Gm-Message-State: AOJu0YxQ2oem5oF3pTsipbH6DZVwmNvzM3VXCU1poWAuJF4ha+5SUQCK
	PVWMMIqhIchQXdvc4mFpNOilDGinuCinQWMC0/34kHDwZNPfKzBrw/BzBQc/ZLakQqV7H62XH4c
	xNc2ucihTIqVD8F7x3OGqIwpehY/sEGxCetJcu66ywQxUOfTPxu4vqnEt48ckwg==
X-Received: by 2002:a5d:554c:0:b0:343:95b5:d306 with SMTP id g12-20020a5d554c000000b0034395b5d306mr517320wrw.19.1712301962360;
        Fri, 05 Apr 2024 00:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfmTEE1CYWHKQ9D/UYrvIiJd7rh/IYvVLbqiVU05PjRtqAm/a3almzv0RvQilY/hkN5wgHZw==
X-Received: by 2002:a5d:554c:0:b0:343:95b5:d306 with SMTP id g12-20020a5d554c000000b0034395b5d306mr517303wrw.19.1712301962023;
        Fri, 05 Apr 2024 00:26:02 -0700 (PDT)
Received: from [192.168.3.108] (p4ff2306b.dip0.t-ipconnect.de. [79.242.48.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b003439d2a5f99sm1300351wrv.55.2024.04.05.00.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:26:01 -0700 (PDT)
Message-ID: <38e17cb6-3337-4213-b1a5-297c9c28f27f@redhat.com>
Date: Fri, 5 Apr 2024 09:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] mm/ksm: use folio in remove_stable_node
To: alexs@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-5-alexs@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240325124904.398913-5-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 13:48, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> pages in stable tree are all single normal page, so uses ksm_get_folio()

.. "small folios"

> and folio_set_stable_node(), also saves 3 calls to compound_head().
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


