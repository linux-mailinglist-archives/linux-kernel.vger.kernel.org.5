Return-Path: <linux-kernel+bounces-135855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01C89CC13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B311F26D49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E528145FF1;
	Mon,  8 Apr 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtYK70Sk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F61448FB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602602; cv=none; b=HjG5yJ47oV9Cb915JaE8vS9t9/BbDQSyjVGyOyOcGkKW95ylZXZY1gT06lxf9WH3Fn34XoflOMH5GxChSa98iU6QhZYYDSLxmvoxM65eK09KWTe957W17YOhCPl1mWx9iy5AmUuaPebpB7Mi8dvsSql+01cdHAin/2Xx7YuaMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602602; c=relaxed/simple;
	bh=0sm047tsUkzETs1iK6aSkfw2VHkL1ldxu9FZiFdqKio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4AypIK8EUY8gqDPXLkQ6IZDsdO7SSvz82eSgJ9HFTYHEojdhQKVZDuHzV/N5NZlgT6IhqDvV97ZKYnJi8dE5EBgeg/rUq/U+m3PgzJeb+0nu6GWk7MdJlHAN923Z39N9+7B2zOIktnuU63S44BrIwth2fp5iPqJk1+t0LjDGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtYK70Sk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712602599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xnWH4wk34YOPWZxVPibW9ohz3Q4MqphqfBTi5y0aS9I=;
	b=PtYK70SktuigMBl2PNDjhD1vIDl3LS4m0KsO5bNePGm7bilL/kETioL0jrhc8sIliCFjhc
	kUBXJgk6Re0x4ZnPkFVQT9sLJIXtMwGmBm4Rqbe0n/Eq5mTnREj7IzfFyjhLjnMBJ4OOaF
	OM/6AwQ3CZjpL5EwZyzUL4jyS8k9OOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-J5GW7T_YOWuSpeiDHqPcrQ-1; Mon, 08 Apr 2024 14:56:37 -0400
X-MC-Unique: J5GW7T_YOWuSpeiDHqPcrQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4162b9b1702so21378875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602597; x=1713207397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnWH4wk34YOPWZxVPibW9ohz3Q4MqphqfBTi5y0aS9I=;
        b=VRH6IIRZbG+xRqpUTrzZfTbp15I3OO/EoT4PI5XymPH9qZrfGFoSSSJCcrnERwlRAF
         XgorvSH2bjnxJ+C3thACj2r7BEr0XD9uQpfbJOSkZjX7rHvic6oQjmmVlmRdqW+1SKv/
         PV4SYHHUGZBh22r+OZNEiTfIjiRAffLM66D8m8KHLQhsKEL2LKbHB/6UmN1j3bF9rKgc
         Ffexmhw6K8WCFkfiJE2Fjn6eK2XI+rmlWKFi1q9QcjmcA23SYRsIC35HQSfgnSbWSlkr
         SKyASzS0THsjbDaBjn7cIsrLPV70UhAnYIbph9UVas0Bo3w0RlceEYkqM5GXtbq3UyKc
         AwKw==
X-Forwarded-Encrypted: i=1; AJvYcCWyipZokMbZ//cVBwsF8KH8fD/ZWKCfZ3Gf8eL99fpFAOdmz4qOzfpqFebi2db0lJif3G2OR4PA3pyY212bu7v8LyXIPVd3yD4BuRjw
X-Gm-Message-State: AOJu0Yzf0SquPQw2iVpgyEuf7tqZv6GMSTscQnrGrsn4l8170pJKIdAi
	i2fPrQNXmjKE8pXXbbTVGZPgWwjpqWL0+GdvQ0pUju+I29n1cVUMfkXLKnopMruStzTkLVJ24Zu
	x0wbYE8UM2geynLtOQRmu7b3EdhjDu0s5zDwKwBvwhhm6i2w25x0W6mLGo46ryQXL5KcGsw==
X-Received: by 2002:a05:600c:5493:b0:416:70e5:d0dd with SMTP id iv19-20020a05600c549300b0041670e5d0ddmr2755860wmb.41.1712602596828;
        Mon, 08 Apr 2024 11:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4JH7cstceNmzXy/Op0NscY1rfDSNjbbFfhzEpJ2L2Uv+rebsORg9I8TLcHwdof94cBT6Vg==
X-Received: by 2002:a05:600c:5493:b0:416:70e5:d0dd with SMTP id iv19-20020a05600c549300b0041670e5d0ddmr2755845wmb.41.1712602596409;
        Mon, 08 Apr 2024 11:56:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b00414688af147sm17475960wmb.20.2024.04.08.11.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:56:36 -0700 (PDT)
Message-ID: <e5920cb1-73c7-48fa-b7d1-dce1510a24cf@redhat.com>
Date: Mon, 8 Apr 2024 20:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: set pageblock_order to HPAGE_PMD_ORDER in case with
 !CONFIG_HUGETLB_PAGE but THP enabled
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 14:24, Baolin Wang wrote:
> As Vlastimil suggested in previous discussion[1], it doesn't make sense to set
> pageblock_order as MAX_PAGE_ORDER when hugetlbfs is not enabled and THP is enabled.
> Instead, it should be set to HPAGE_PMD_ORDER.
> 
> [1] https://lore.kernel.org/all/76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz/
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   include/linux/pageblock-flags.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 3f2409b968ec..547e82cdc89a 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -28,7 +28,7 @@ enum pageblock_bits {
>   	NR_PAGEBLOCK_BITS
>   };
>   
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE)
>   
>   #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
>   
> @@ -45,7 +45,11 @@ extern unsigned int pageblock_order;
>   
>   #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
>   
> -#else /* CONFIG_HUGETLB_PAGE */
> +#elif defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +
> +#define pageblock_order		min_t(unsigned int, HPAGE_PMD_ORDER, MAX_PAGE_ORDER)
> +
> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
>   /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
>   #define pageblock_order		MAX_PAGE_ORDER


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


