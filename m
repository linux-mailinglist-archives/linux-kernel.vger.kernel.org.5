Return-Path: <linux-kernel+bounces-132074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E3898F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD16B28D5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61E134CC6;
	Thu,  4 Apr 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvuX51sm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F66D1AB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261135; cv=none; b=sbMeYvooH98VWdf+KDEvkezXwR3Hq6gaEqHoCh2Qrjl8VkE/eP+pHa1zm8Ad/ritCMsRGxmn6fsYS/jtdL/5qdnVUFdoLm4js5queVPhZfNXgNKjaTc86VUmynaHvPPLExARlSGKrPeBP1KHwKdpkaJe7/pY3q0jWl9AZR/FN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261135; c=relaxed/simple;
	bh=8n/T9hyPyS54afK6Zfjx8HBUKaYLYnIIsUUdIOmrnpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FicP014C29MiAFzuoLH2934zmSqFS7dHYQ9k9Biag0P08DpqXoRJhzFV/PayINjYqNbVi7aFQKFunjgWFPy7sYl4NgpKIjGgpxb7ikIeFTYABhwELoU+LPPu4OWkoxlBcenCa9gEgHFY2qisdQux2VDh1V5yd3+YQUK77qsdoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvuX51sm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FxAOCFYq8xXAQuGIrBvi8bfCel68rn6aPmSoJ9ZeqVw=;
	b=UvuX51smP+ouIzNbyQUeSj1RVFzuK9o0Wk0fjqED2o3NpNEeKbf8XsFiIqt8QDQLXQIvnj
	2rfH9xNav0/Ocfq1Bn9+U4+agZ10QR66z59fX0XTgqbZAZ7+Dp5DxQT49eHK9mueh1HsUu
	kYnSsoUYw3hoIz+M/z7qcmmr5U7X2iA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-xoZ7KiVIOK2teBSnyyaKXg-1; Thu, 04 Apr 2024 16:05:30 -0400
X-MC-Unique: xoZ7KiVIOK2teBSnyyaKXg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41624c1137fso8693925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261129; x=1712865929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxAOCFYq8xXAQuGIrBvi8bfCel68rn6aPmSoJ9ZeqVw=;
        b=oMJ1D52MHVbjoQa6OHzlJY68kGFpVu7avfLCZCo+bZG21X6IviT8ThNgWz8QUeTDBF
         ARmeaahb0sqXkRaGSCGZwoK2iJf1+aYNDGjQxBfPVQ320yc+cMGTVNVZUwUD67Dx8Ddc
         sJekEy38oEESWfklV2qeF4LHqYPgMQ9uzfXgO0nkWKGXdCFjKhxAyTY3at31L3smexEI
         V1HnymS0dkebixInphFzK9b+Pbm8KchxmCjW6WKgxu55y07mNzUSvhodmBt2JmuUjMou
         q21Y34rn0V/+JVaXktUfmqq9Gk6YN6EIxoiURrJQPi0IJnqfPYoxRB+fmnQ+JyWGSmJh
         z6QQ==
X-Gm-Message-State: AOJu0YxUamoQCkzdjNnFNIIPzPv6/UfkWyWZpisObHxyueqepquCZU2P
	IdW+0KGYgDzBhVlPP+WGInj5pTUG2sgQn0iltYont988JmianPIMUAV1mAlXIhHpVUitazDUZbU
	JLy7NgCRzTdn0jk7h2cQ/pPH2LCs6+iyOeMv3xT4U1IU/SBEIlSa7e/vWxLofEoBCM2BG7Q==
X-Received: by 2002:a05:600c:4592:b0:414:102f:27b8 with SMTP id r18-20020a05600c459200b00414102f27b8mr2537371wmo.32.1712261128776;
        Thu, 04 Apr 2024 13:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt0ARs18EM7tsworSyqk4LRe7lyyAThx3KKRsxAewFog+t5TTselJV103F2EacFlGukzTiAA==
X-Received: by 2002:a05:600c:4592:b0:414:102f:27b8 with SMTP id r18-20020a05600c459200b00414102f27b8mr2537358wmo.32.1712261128423;
        Thu, 04 Apr 2024 13:05:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b00343daeddcb2sm193270wrs.45.2024.04.04.13.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:05:28 -0700 (PDT)
Message-ID: <93eccef7-a559-4ad8-be0f-8cc99c00bd09@redhat.com>
Date: Thu, 4 Apr 2024 22:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/cma: drop incorrect alignment check in
 cma_init_reserved_mem
To: Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
 muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20240404162515.527802-1-fvdl@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240404162515.527802-1-fvdl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 18:25, Frank van der Linden wrote:
> cma_init_reserved_mem uses IS_ALIGNED to check if the size
> represented by one bit in the cma allocation bitmask is
> aligned with CMA_MIN_ALIGNMENT_BYTES (pageblock size).

I recall the important part is that our area always covers full 
pageblocks (CMA_MIN_ALIGNMENT_BYTES), because we cannot have "partial 
CMA" pageblocks.

Internally, allocating from multiple pageblock should just work.

It's late in Germany, hopefully I am not missing something

Acked-by: David Hildenbrand <david@redhat.com>

> 
> However, this is too strict, as this will fail if
> order_per_bit > pageblock_order, which is a valid configuration.
> 
> We could check IS_ALIGNED both ways, but since both numbers are
> powers of two, no check is needed at all.
> 
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: de9e14eebf33 ("drivers: dma-contiguous: add initialization from device tree")

Is there are real setup/BUG we are fixing? Why did we not stumble over 
that earlier?

If so, please describe that in the patch description.

-- 
Cheers,

David / dhildenb


