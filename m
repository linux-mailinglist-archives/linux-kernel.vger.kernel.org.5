Return-Path: <linux-kernel+bounces-158317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326328B1E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DFE1C2191A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95E84E13;
	Thu, 25 Apr 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ7XluEL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD784D3B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038056; cv=none; b=Jh7SW3UgDsixI8mTIeC+9e209dwZG2a0rWJ68V9fniAAjP5Gk7KBbVxu/2PKrg6Ga6HkHQdpStJ7vU0Kv7KuAf/wmLlix3UoR27i1uy6k5RSQlp8WZHhSTbB9ei183ckKoDU9mLtVuAJeTQvLrNgWqugESNwfUPTKjauDhsBG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038056; c=relaxed/simple;
	bh=B0UaMrfggGcH0NuJgBoeH/FZELb8DvPiOgF/+f2euR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiYksWJIvFMBoXSO+V0tnbKkhkJBlYgTa8ZqAQ4fhEcdStyCL5IkG3A1VHkKzrlY0VmorF97AnYYC0BaqGQSufN/CvtDkGPoFNn9hS3IR0NkevoNR4py3+u1qMP55qAN0lqkkkDK1/nRcP8AfOADP95NjmPS39Iy+fnl8tWk6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ7XluEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714038054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v38K8DHxFEe4iXrXoGabe9MWX7Uzru577IllYM1Hxig=;
	b=JZ7XluEL7yXYkvnpuTsCDeyZ/+dJb2UnNnfLyo4CU3iJZwQaQ16WdU5XVA5t+uByeXIbsg
	/DFnoGVEJ4uMgSmXAURVKCJ3zzzJf+5tDNjTpUnl6B4002jpbFnmCgOMBs5dLQfY9aanaU
	dkjNE+ZVC2DR7WWsV3yTxFK+WclNpTw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-1VOS2cIiPM-o7AbPesiScA-1; Thu, 25 Apr 2024 05:40:51 -0400
X-MC-Unique: 1VOS2cIiPM-o7AbPesiScA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343e46df264so503314f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038051; x=1714642851;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v38K8DHxFEe4iXrXoGabe9MWX7Uzru577IllYM1Hxig=;
        b=HMhknNehwwZuUZtIOd9LITliqtrTCBs0Ek1eF8LBkYpECBrThHR6qFvirYfw1nYWiZ
         tHBTHFfIsuvukr8E3AN4NgBgruYOa+hKpIn106c5SfXml5Xj2UA/SlirdXXhmxsnBndZ
         yyByhNthst4vFugnENu+ilLV1RiS3X2DgVb4O6VBys0LvVhMZ6Qznll0Ev8G1X+MuLRE
         9Z7ThKm6/sFIeT6hscl9BxOzq131r+icqYrdKocOP3cp1WJnFG2dfcmDZa9w0QnzHIGd
         9szZ+sIVp1KV42eWAypVNP2Ht8Y1Bi7vq5iXLmrJ77H2touXDkwLsjpXHykgwMKTBvu+
         SKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVbIhGLeSnPXQZktLW0gth8HbICcbhyuMI9nkCVb8q9wC/sVYDwCNPxJrxuFwM1jM01CBJgVL5M8oImrMlgEKu40wTzIcCc85g3R1P/
X-Gm-Message-State: AOJu0Yxbj9I+oB2GScdD7kZIrDF7MQag4c//CQzGUPvbVyTfsMxqPOlV
	Qx18DbubPyDAKE/n1LZauv/+6hTKcx3niKvc3hbBW0mqA1dWxola3+BgvCxHutNrh6IP5cvNXU7
	a1tJ1wxPG/886ptaEoQJbyyzF7+E1bvT9OGR7wwJvO/NZR3eff8bNDNXGhIGnsA==
X-Received: by 2002:adf:ed0b:0:b0:349:fc93:1dc with SMTP id a11-20020adfed0b000000b00349fc9301dcmr3572198wro.8.1714038050809;
        Thu, 25 Apr 2024 02:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXrnyfBd1VmrKlXc5UDNH3YOWGt4ItpbfDi7CcurW+2K9XvvVA34hnoa6v1pHskx7y6GGFg==
X-Received: by 2002:adf:ed0b:0:b0:349:fc93:1dc with SMTP id a11-20020adfed0b000000b00349fc9301dcmr3572175wro.8.1714038050414;
        Thu, 25 Apr 2024 02:40:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b0034349225fbcsm19331393wrp.114.2024.04.25.02.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:40:50 -0700 (PDT)
Message-ID: <37374089-895f-4c6f-a2f5-33859eb02b13@redhat.com>
Date: Thu, 25 Apr 2024 11:40:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: move writeback and truncation checks
 early
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
 ziy@nvidia.com, linux-mm@kvack.org
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, hare@suse.de,
 john.g.garry@oracle.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20240424225736.1501030-1-mcgrof@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240424225736.1501030-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 00:57, Luis Chamberlain wrote:
> We should check as early as possible if we should bail due to writeback
> or truncation. This will allow us to add further sanity checks earlier
> as well.
> 
> This introduces no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/huge_memory.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> While working on min order support for LBS this came up as an improvement
> as we can check for the min order early earlier, so this sets the stage
> up for that.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 86a8c7b3b8dc..32c701821e0d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3055,8 +3055,17 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	if (new_order >= folio_order(folio))
>   		return -EINVAL;
>   
> -	/* Cannot split anonymous THP to order-1 */
> -	if (new_order == 1 && folio_test_anon(folio)) {
> +	if (folio_test_writeback(folio))
> +		return -EBUSY;
> +

Why earlier than basic input parameter checks (new_order?

Sorry, but I don't see the reason for that change. It's all happening 
extremely early, what are we concerned about?

It's likely better to send that patch with the actual patch "to add 
further sanity checks earlier as well", and why they have to be that early.

-- 
Cheers,

David / dhildenb


