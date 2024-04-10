Return-Path: <linux-kernel+bounces-138913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAE889FBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D034CB23D11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C316F0EA;
	Wed, 10 Apr 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZU7KLDgS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFF16EC19
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764296; cv=none; b=atpZVmJYZSr1QbNRV4tHJsbPMKitZhSC9njTq+HFR/PaiJZFRBEIV2dOfL8qXnW9L8yti50sWorNdDNtJ6/P+Syn0xOfvJdmHJ6g3JQx9olMG9pWujT4oBB5uyQM+RI7eT6GeQ5SLf3PZceOL+q755R75FuvEuCJi5/ofR0KXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764296; c=relaxed/simple;
	bh=56IqxaPpF62Kz83w3WOuSNcCmkr/vL9JAqXALKtd7KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lce9z7ikgi63t9M32J92x7SYjIUwW42FY+rN2typ/LTJYbjaFasxSc7bXa783lKdAqE4W26GR9ikX54xWImR2QQLQT2gdHlkZoHAiodG/jeMyc7KCM1l1nEzfQNfuuL34jolDyhBYKNwroyqNn2n84xOQErsx8e+PTaZR2vDClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZU7KLDgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712764293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hSdS2v/hATr4/3u4hgjd9nxCs++wDV//OUkrAd628Is=;
	b=ZU7KLDgS4uZGuinhT263xgQqWmFfVx7oz0BflLzJDNEM/DThxoVYADRodVmUhid69wSkcq
	f7//kcRBJAY0g8jTjOXjXinmfFbDLQKpA2Z6brpI6cq+Sys5AKmo2/xkXltPFSjLy6UTuB
	ufFXZj5A/i+4iPpw14GfTKKhV0RKWEw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-OqJL_rJXP2O_DRTMwGWR-Q-1; Wed, 10 Apr 2024 11:51:32 -0400
X-MC-Unique: OqJL_rJXP2O_DRTMwGWR-Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d85e1bd6edso51551431fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764291; x=1713369091;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSdS2v/hATr4/3u4hgjd9nxCs++wDV//OUkrAd628Is=;
        b=FqoynHHWwqUd+o61wXFRFge200ZI17oURoU9gKLma7GNxYemycswK4pR6F6qaxIvar
         oiCbrPDRFptvW5LluE3hgEWs+bRsbEykfpWUuAR6Ucjm77oXev+maevKXDuSE0Kjdnma
         Ajy04FmwqF7iW+hsGUpYsW3rmeywqcj5qFg43q0t222ATaVaTGhPLDVxD81Ze/7EJupu
         QFmaph0QC4i9v2lBb8j9DXqzoKH3MGa6NOApGmCvCAUc++zrJaJ3NdsaLdcuwO8ia3hY
         Ji90kTeIBJ1kBj0fJRgXSpsl8FPXazvAipBC3I+LHJ6BUHtJT7rPwgOuCwCUyqSBCV7P
         bllg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ue1F6eYHwUzVyqQOk8IfF7V6rZMW7P9KjuIbmKGG2rmJ2vhOQ+eTr5Tsn+BkszuBwDvORbExCnwT6AEwZCRiWKpiB/UOi09JLfFH
X-Gm-Message-State: AOJu0YwUh4o33OXnHUr3KhXz9se4tRcg3PVAoObhng4nrFJ0nNsHEXy/
	zDZO85yPRkwnu4PDoE4lFxeo29HxmWiLq+gZ5ZoSJKZ9LztrAdK0QdLQKfevPXBt5KaTFWdgaHj
	zaTiPF6q7L7NkcXM8QIH4DzdDoxfYGAJ0KsqiMfw0QC6S1Td3cOYuSOKt+aCuqQ==
X-Received: by 2002:a2e:3801:0:b0:2d7:a1c8:71bd with SMTP id f1-20020a2e3801000000b002d7a1c871bdmr2141635lja.0.1712764290793;
        Wed, 10 Apr 2024 08:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSjjubjr0hC6WCig/jKnUEjp2ObInIt7086mDXKnWdThyKegr3q1EgiBE1PYHCGd1bpUdZ8g==
X-Received: by 2002:a2e:3801:0:b0:2d7:a1c8:71bd with SMTP id f1-20020a2e3801000000b002d7a1c871bdmr2141622lja.0.1712764290359;
        Wed, 10 Apr 2024 08:51:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041665b6e111sm2645572wmb.12.2024.04.10.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:51:29 -0700 (PDT)
Message-ID: <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
Date: Wed, 10 Apr 2024 17:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent
 hugepages
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hughd@google.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 iii@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 17:26, Sumanth Korikkar wrote:
> On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
>> On 09.04.24 17:54, Sumanth Korikkar wrote:
>>> In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
>>> compiler might choose to make a regular function call (out-of-line) for
>>> shmem_is_huge() instead of inlining it. When transparent hugepages are
>>> disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
>>> error.
>>>
>>> mm/shmem.c: In function ‘shmem_getattr’:
>>> ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
>>>     383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>>>         |                           ^~~~~~~~~
>>> mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>>>    1148 |                 stat->blksize = HPAGE_PMD_SIZE;
>>>
>>> To prevent the possible error, always inline shmem_is_huge() when
>>> transparent hugepages are disabled.
>>>
>>
>> Do you know which commit introduced that?
> Hi David,
> 
> Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
> -fPIC kernel compiler option, I could see this error on s390.

Got it. I assume on Linus' tree, not mm/unstable?

> 
> However, default kernel compiler options doesnt end up with the above
> pattern right now.

Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:

commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Mar 27 11:23:22 2024 -0400

     mm: make HPAGE_PXD_* macros even if !THP

Which is still in mm-unstable and not upstream.

-- 
Cheers,

David / dhildenb


