Return-Path: <linux-kernel+bounces-142669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9338A2E98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C068B21675
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA059170;
	Fri, 12 Apr 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWD4Rad4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6859151
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926457; cv=none; b=mI7Truy9KkLgKbbexA4ssZsVpwhvqCCMJND8egT58kGBMGlKxNNuTKLCG1TCOy31eIP/udRciEBmCe1RBWfTuh0EWhWopg+UTLuVo9niHvS2tfgnnZFL33Eka0JfwOBXH4p37JI/JFwQizQqfjpgnqgC9NEB1bUS62swOyb7sOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926457; c=relaxed/simple;
	bh=kxIeUBBRqd7jDmoyRRK0Lyomq3z8Dh99hgD0N22kb7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSLUBdqJ4kTbN6jtDQgBUmDNwJoS0+8zfFoIxKGtAYE8qH8lw7LWyh5fouGnigfpQuyAa9mys5LX9QNMNF8OgzD/5XWrDzNM034yyH+7Q4Hm7LhUUO6t+pCX7exsYUj2hVm14a1j+xvsYjy9Usqgx+2e3OoJd57ZOkXkn2f0JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWD4Rad4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712926455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mqYWIcV1gjcgAg3ixtte8scUjNY/E9W4ASBcBW6QoeY=;
	b=ZWD4Rad4I8Sk1q4ef5w37wumvxms4Fv893dpcVkriD+xLljJ4d6w4q5p8T6innYT+fVrsE
	jwjZs3DhriqlRFVAlJtKifr56GMlNw6ywaKn6qiBtxeb31AF5azisUKbDIqc+Jfw3F/uCD
	1PzL0saaEZNdCdmhjz0iBFg73FTKuIo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-IE11BCbUON6b-jUTxRlgtw-1; Fri, 12 Apr 2024 08:54:13 -0400
X-MC-Unique: IE11BCbUON6b-jUTxRlgtw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416664de900so6358105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712926452; x=1713531252;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqYWIcV1gjcgAg3ixtte8scUjNY/E9W4ASBcBW6QoeY=;
        b=uMqachiVRCsFjp6VvGMIGolgFaN6vTO01GEiAGTyOtBa8YrEhq8hDIPL1a2Se6Kk27
         D3AnefNE9UEKfFiyodT1/9kTOW+RNkhkfD327TVFfQbRS5s3Yxl6P1HpMBimpZ6nhiVW
         cXSLrmVFOrl9a2UGfC5pWX1fSqcGkeJxl7cMiH0uZgh6Z84fK5BuLr3CKb9pt/wKWxue
         u6FChWI436GgWsSoieXXohnQMiBhw7j1a954voCXq2Us4UAQQN9Wk9aLle57wjE7IZNZ
         WA3iEimUhNWzgjyK/YB8DNrJG2qrA7+Rde7ePis7waJXwijxOcDGHDA7dZDaIRInGgsN
         cz4A==
X-Forwarded-Encrypted: i=1; AJvYcCUO46KQ3SpzeYsxgv7ecCqeJuVYTbT9asyc73a4xXAVe2Ci0MMNMjAv2CZvyU7ccSrnvkxGETewrpEglJxCC1wOuHESV5Mv36YcaquX
X-Gm-Message-State: AOJu0Yyp2Q8LWEdofW90PU9KgxaToAr6ZFafgzxwR5oNSsgdiqkhNRRm
	XoMvSE/fOZtNte3fgBE+CUjabDjOgpPAY2oTcv8diDrRq4guXuVoOEEaKEE532OBk4dJFqqQ6Wn
	YjR9lkZEVTkUiIJfRv2ynSP/dOZo+ldFyLpt1ByJIRTgVY45h/aqM8LTaeoqxv3Go1AW2oQ==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d801 with SMTP id h12-20020a05600c314c00b00417e4add801mr2599176wmo.31.1712926452376;
        Fri, 12 Apr 2024 05:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr/eOkg933BDIbNCu49+VfolGPqBXhALiVh3BLlF87UBDv4CEhFtLQvOIIlqhB0tP2pVvGaw==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d801 with SMTP id h12-20020a05600c314c00b00417e4add801mr2599157wmo.31.1712926452016;
        Fri, 12 Apr 2024 05:54:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:f600:afa2:4e8a:448a:9831? (p200300cbc730f600afa24e8a448a9831.dip0.t-ipconnect.de. [2003:cb:c730:f600:afa2:4e8a:448a:9831])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c358100b00416b28651e1sm5593384wmq.36.2024.04.12.05.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 05:54:11 -0700 (PDT)
Message-ID: <20e36996-0c78-4b81-8e91-1035d5ce0652@redhat.com>
Date: Fri, 12 Apr 2024 14:54:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] mm: add per-order mTHP alloc and swpout counters
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240412114858.407208-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 13:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The patchset introduces a framework to facilitate mTHP counters, starting
> with the allocation and swap-out counters. Currently, only four new nodes
> are appended to the stats directory for each mTHP size.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> 	anon_fault_alloc
> 	anon_fault_fallback
> 	anon_fault_fallback_charge
> 	anon_swpout
> 	anon_swpout_fallback
> 
> These nodes are crucial for us to monitor the fragmentation levels of
> both the buddy system and the swap partitions. In the future, we may
> consider adding additional nodes for further insights.
> 
> -v6:
>    * collect reviewed-by tags for patch2/4, 3/4, 4/4, Ryan;
>    * move back to static array by using MAX_PTRS_PER_PTE, Ryan;
>    * move to for_each_possible_cpu to handle cpu hotplug, Ryan;
>    * other minor cleanups according to Ryan;

Please *really* not multiple versions of the same patch set on one a 
single day.

-- 
Cheers,

David / dhildenb


