Return-Path: <linux-kernel+bounces-140027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3162C8A0A91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FA628306D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986213E8A6;
	Thu, 11 Apr 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgfJa+bp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4813E412
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821900; cv=none; b=nvsOw1S9+m9vqDIi4RzxJ/L/sui496nvmrPu+XFku0fX1Dc0HUYzVqyp1Azrmh86B9u4K1blz/OIuXdNDxz2PqpqbIgPNvt3jQ55XdjnNqh9EGpAL/XAGiEcUqR43x7VTgAixHoOFVhPd5LjdqIy+a5rt6BAr1MWBFv5Linb7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821900; c=relaxed/simple;
	bh=cI95dgsCiTK1Yw4Hx/d/zyGUHqCVQL6SOwWPCbPDKwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RUcSHQn3B4ibL8cZ7rJrQx5eTS1b3Uu7Ljj0Mf/IThryVAflGifFibMAVIAArDVnPfkdGtj5Wy1ZYw8fRlWssmRJMoZXeC0wHbHWLOLLUc570Ogw70TCS4vNWG91FbIZeWpd9XdqBI1cCskIhl4ARq2dm3hK9MI6GXtZ/gy830M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgfJa+bp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712821897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BG/PUWioAy4nN57y3efpjqkEhJFL579DB5StNZCE/eY=;
	b=UgfJa+bp83iO0dB9IH6kcfK6aw3XNQvd9CeED6FMMBvPmZg6p9XyaNmwpoWjf9Qj5W4pGL
	/jXYa+xBjaRQ/jMs1N29TavE8oSCLSqQVMyDcvfMXKhkU3cCpDEJo19q6+ScbQhpOLoLNY
	pqGauf8Gv0BlQxX41gkKDEg0NoV6t4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-s6ebTJUDMoiPq2spVkpadg-1; Thu, 11 Apr 2024 03:51:35 -0400
X-MC-Unique: s6ebTJUDMoiPq2spVkpadg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41401f598cfso43262315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821895; x=1713426695;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG/PUWioAy4nN57y3efpjqkEhJFL579DB5StNZCE/eY=;
        b=VjMGKC976rskxYbxp7mVAuErAmIxzIuGscr83EHZ48vtBIO+meaQCBIEue/mU8Cuiu
         kvofK8GMZQfvO0qk6gkQzgsHxBM8TJ3YLs/SQ4ybjLCKgOp209/4H1s7cSt1fZEZwQ0T
         N1n0OHpuxUsIZaaQnZQHcL/oovp5IlhiBd29qkzn+ylFwAmQhDunW5JbkkKnpg3eZRBn
         5vArc9hx2m0Fh10+6cstpgBkkw+s81kow+DKQgsyJnTFtLXXhIaikkoZC84UqOULcRlk
         13rS/OYwpgQU/8TG27Y7tWFHp9XbTytZyTxqbVut47ThUV1Rm2j9Wp5h7+hyCnzawALk
         jnHA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGrB6WjxzeW8Hj32n/nr0+tVhaqR7/AYUs/n8LRAnQPOzX1XEpvg9bk2wb4LchdnMsDtQbONczZcW2v4kALh3BwUYioL6Wejz/Zc0
X-Gm-Message-State: AOJu0Yynse+GCtjTAEMEaCLMa0qOXaYz4Fi+OlLuhrO6nFviCfeYGacE
	ySDfLL3uDsH/genM6cA+k97vY7RihZsa6IOmrSP1bKUWX2pRuDTnDxFxyPpuy5y3tqkvKyFv3mk
	biJLL9/1CtU3gH8uDbBO3ksygGbLLKYWXK/PxtMN3pgQQjPpqIdcq0XATl30ZzQ==
X-Received: by 2002:a05:600c:22d0:b0:416:a5aa:c9af with SMTP id 16-20020a05600c22d000b00416a5aac9afmr3414420wmg.40.1712821894839;
        Thu, 11 Apr 2024 00:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkdGoLrBrkP8Zh2zs9GnS8LwhGFWKp584Zsm88r88JZGSK30dvF9DGLk8kxHxlT7DM3cc7jw==
X-Received: by 2002:a05:600c:22d0:b0:416:a5aa:c9af with SMTP id 16-20020a05600c22d000b00416a5aac9afmr3414402wmg.40.1712821894396;
        Thu, 11 Apr 2024 00:51:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6245000000b0034334af2957sm1138107wrv.37.2024.04.11.00.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:51:33 -0700 (PDT)
Message-ID: <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
Date: Thu, 11 Apr 2024 09:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 hughd@google.com, chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-10-alexs@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240411061713.1847574-10-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 08:17, alexs@kernel.org wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> As we are removing get_ksm_page_flags(), make the flags match the new
> function name.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> ---

s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.

-- 
Cheers,

David / dhildenb


