Return-Path: <linux-kernel+bounces-98975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D18781C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF31B1C21314
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CCC446B5;
	Mon, 11 Mar 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LymvdqT2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884A446A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167850; cv=none; b=Adp8yRVI0qAVg/eg4jam9pzUvi1WPvnLdG4vriXEwmDZEPm5v8q5tgd3qyS4U8g85gq697djizgwt0VYOn3ERXdHZzUVObOxX7m+nYWYFYzkHOaFg3VDfeQPptiWj367xhU8wzvlc37IerZgqq4kC9QKsBwfXCWgGL1OoJ7ooC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167850; c=relaxed/simple;
	bh=mpjY5NOHc1Zg9CoSnpdOreceCOpsXOdSUu3SC/nFSVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKBLEdhCWMMLgOGnIy5arMSd/n4GXudLRZdH3Zi9a7WWmlS3/sW6eoIH0Ol4oUrLT+Whcn8GD5yYTqK6sRH7g/nYa2OOeICfNSu9QXOnbG2sD54k1f47vk6FnTyvabIvnsgF4WFhlAJpRw0WxGiZKNq4VYokJ29H3uxLCTOZuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LymvdqT2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710167848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xjgTlRBcANKTS8u7LrnaDTM5LH7l1lTCLO3tZTyV0Ys=;
	b=LymvdqT2ayyOrXeo22c8llB71952oRfiTUlI5aCTE7Z67umik+72Zn3GPJfpFovjqFFcxT
	vp225dRdTT3Qrzw43VdeL0XscmxOdIlcmYp+tdsf885ik21/fTLgASIJo1XQprL2SyTm0F
	f4JSumllVPk3dwc8AzVAI8B1O740mf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-WEH4bipvMaGn5NoHtH-VCA-1; Mon, 11 Mar 2024 10:37:25 -0400
X-MC-Unique: WEH4bipvMaGn5NoHtH-VCA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e8c89cbd9so804437f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167844; x=1710772644;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjgTlRBcANKTS8u7LrnaDTM5LH7l1lTCLO3tZTyV0Ys=;
        b=w95UnUkaw0qjdzmLf2aeLqmzWCmf5l+ksruYil8jXcTWdM8dvHdFd5Z5E1worEJ2rE
         UOfTVuGwIhcAP/Q7LXOEWptDfm9YMFyoI2JmgbNT1R8KE/dcrp7cas5T34TNnVTNXdbW
         kaZHIrCFSPPpt5q9dNN9v7V3fQdOnPnZ8op+VIOHZbMHzympzUa6c9ao0eFw2FBigQkL
         GGWGD2vtkKzmEZ2HtdD8aWNC922QCr/1XRaMgl0L2AwSAHOLSe5mwUX/O+bAqDtOUEKg
         fxuWOLKZTrigOTiXt8NAHXa8L+U7NNujHI3yLjLTy/GsyDI9B2ZUFH2pdmU6Rhn1TEAx
         bd/w==
X-Gm-Message-State: AOJu0Yxd9BvNl+2KVvcgv0PRDKLFwCpz3YnEf2UVDcuxCX3NctxR5jHO
	13pKBvu89ahSYDIMf0C7RpHeMAjGcJVWA8JhEtMlrM823N1GQZlr2AnjUiSNiE4rhgFWhFvln4G
	XW+pOVsFKyrypY5NciGIxmmVTK8RPHnG6uCWQcFzDFMehRlV1+wxZUZ4pdS9h3Q==
X-Received: by 2002:adf:f60f:0:b0:33e:76dc:d8ed with SMTP id t15-20020adff60f000000b0033e76dcd8edmr5483294wrp.41.1710167844583;
        Mon, 11 Mar 2024 07:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4xkA+sJzGuebT6FnVplGOhHKkIfnwLQDa5lF2sw9k6LFlokNvMmIL3JapXqmhra5Eo4NP5g==
X-Received: by 2002:adf:f60f:0:b0:33e:76dc:d8ed with SMTP id t15-20020adff60f000000b0033e76dcd8edmr5483277wrp.41.1710167844161;
        Mon, 11 Mar 2024 07:37:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:6100:aae:4b84:887c:15bb? (p200300cbc72f61000aae4b84887c15bb.dip0.t-ipconnect.de. [2003:cb:c72f:6100:aae:4b84:887c:15bb])
        by smtp.gmail.com with ESMTPSA id co11-20020a0560000a0b00b0033e94233284sm3437527wrb.78.2024.03.11.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:37:23 -0700 (PDT)
Message-ID: <3439a693-753e-4293-a0fe-eefd7b3cdf53@redhat.com>
Date: Mon, 11 Mar 2024 15:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/swapfile:__swap_duplicate: drop redundant
 WRITE_ONCE on swap_map for err cases
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240221210845.13488-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240221210845.13488-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.24 22:08, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The code is quite hard to read, we are still writing swap_map after
> errors happen. Though the written value is as before,
> 
>   has_cache = count & SWAP_HAS_CACHE;
>   count &= ~SWAP_HAS_CACHE;
>   [snipped]
>   WRITE_ONCE(p->swap_map[offset], count | has_cache);
> 
> It would be better to entirely drop the WRITE_ONCE for both
> performance and readability.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   -v2: drop goto according to Andrew, Thanks!
> 
>   mm/swapfile.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..7cb6d9a2d51d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3320,7 +3320,8 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>   	} else
>   		err = -ENOENT;			/* unused swap entry */
>   
> -	WRITE_ONCE(p->swap_map[offset], count | has_cache);
> +	if (!err)
> +		WRITE_ONCE(p->swap_map[offset], count | has_cache);
>   
>   unlock_out:
>   	unlock_cluster_or_swap_info(p, ci);

Maybe too late, but LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


