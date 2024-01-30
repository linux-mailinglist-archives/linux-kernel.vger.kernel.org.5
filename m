Return-Path: <linux-kernel+bounces-43884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E34841A60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFCB2532B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677B7374FB;
	Tue, 30 Jan 2024 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eMxXlbRG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB637147
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584773; cv=none; b=nhH+NTeHQltXmClSywBxxNT9aAS16RF1cuR+/fYEol7BWx/FUpmFVV5pt9TNVlR7yMbkq10/DcxupWf/EICNoLPEyFPC5QBAUe6QhHD5no27uUeHCBROjpDbRDQM6zu+S7sPK48u9Kj15/aZcuWbeadJg6cT6movVg0EaWljbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584773; c=relaxed/simple;
	bh=CHhGECNi2t3OryC64t81I4nI0dXAE/V7YmWKA4rGFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7Q3pCqzS8i1MLDkQ4oMTcDmY3A3IGYDF0AtmHqiOI7p3FSDZf/uO+EHUM4v2C8sl50YXxDW56EKtWRrhZkM15ZJXAOb3t7aV5qI2cjlQEsPya3phtXG0w71rQ+sxfZPkHCzxsulRRy+2hFRsXecrVhxn5+2LR1aOcmbG0gIA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eMxXlbRG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de029f88d8so2475443b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706584771; x=1707189571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so4m4az6mOqkmU0JQqmlPq2+I4lK36pSq8Vc85kD/oE=;
        b=eMxXlbRGWp4IKElIaG3Rjm5UBfyVKPgWfIna/PPzo8A4YcZeilF/07sKPcNSy67sA6
         rPIHByahrOMBortO/dJr4GqgIX/bMioGRL/aU/qr252OHxqeNaPK2Ud3cBGrBRtgsPY2
         nNKNXOPmi+lVgtX8WwvdzxP0y6Mv4+ZxgI4/w5AwUmLdLfhnnUfEFjup6WmN9Or1bMGP
         yN3hwXsHlSD+bJtW2QXETR214hmAGdIU5UoYUlBjyMQfxt7VBCiqTYvNKxwdfpeEjkly
         ueQyp9XxMsO/6Nk21uyBbw+rdbeVOapGr5kDMZvgbKckq3Vr5D+goL1nseXTSXJWeNQS
         r7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584771; x=1707189571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so4m4az6mOqkmU0JQqmlPq2+I4lK36pSq8Vc85kD/oE=;
        b=saB31/s8ohOicoObxuQYS6depZC4D18gz9Jylpdbd4A0ExA5ZiN1q7+ZXiGtPzir/q
         +v9GWhsvDNzhkJs7zQ6u87udK5mefZk+K9HRK1XOybdzmsNjvnZBWcpOqptSB51rXS3U
         v5gTJ9xm+hc+QNw4V7B+30I/5H8G8UqL2bjDGq8SP38PJGq1o3F2NppAGAs5SodqSi7L
         Im9H9KHmuC2Abw+Kg1DunHBd5mcs9WsPD1CYzP4dQpQVqxtyodxFv/bQavj3q63TJTL6
         xz9lL4xRYQhAniRSkGCODsGaDUQxums8w8Md9q6SImnMoWJPE3GTxhqSspdlvWaZDChF
         4fCQ==
X-Gm-Message-State: AOJu0Yxjvr6xdQzyPuHDHESD9x5xgNMy8kwJqxM/1//rBGSoR76hupEZ
	yYQeFU7ZZ9IOupuUhrQi6OFSoyrBJ2oQPs212pxXzj4ApCkVxNxe4MGiUTs6zDs=
X-Google-Smtp-Source: AGHT+IFSKWvJKRawGYZ8jvIAhhb6bggBAjvzIB5n4zApCOjIEVVhMc+O8NSLC8fJjtP+5szXERefQQ==
X-Received: by 2002:a62:cdcd:0:b0:6db:ca49:9ce3 with SMTP id o196-20020a62cdcd000000b006dbca499ce3mr5589811pfg.6.1706584771474;
        Mon, 29 Jan 2024 19:19:31 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fb8-20020a056a002d8800b006dd8148efd8sm6551867pfb.103.2024.01.29.19.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:19:31 -0800 (PST)
Message-ID: <285afb68-64e3-4adf-b6d2-9b13de46a62b@bytedance.com>
Date: Tue, 30 Jan 2024 11:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] mm: zswap: rename __zswap_load() to
 zswap_decompress()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-7-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7a7e8da2b4f8..bdc9f82fe4b9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1316,7 +1316,7 @@ static int zswap_enabled_param_set(const char *val,
>  	return ret;
>  }
>  
> -static void __zswap_load(struct zswap_entry *entry, struct page *page)
> +static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>  {
>  	struct zpool *zpool = zswap_find_zpool(entry);
>  	struct scatterlist input, output;
> @@ -1411,7 +1411,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	zswap_entry_get(entry);
>  	spin_unlock(&tree->lock);
>  
> -	__zswap_load(entry, &folio->page);
> +	zswap_decompress(entry, &folio->page);
>  
>  	count_vm_event(ZSWPWB);
>  	if (entry->objcg)
> @@ -1702,7 +1702,7 @@ bool zswap_load(struct folio *folio)
>  	spin_unlock(&tree->lock);
>  
>  	if (entry->length)
> -		__zswap_load(entry, page);
> +		zswap_decompress(entry, page);
>  	else {
>  		dst = kmap_local_page(page);
>  		zswap_fill_page(dst, entry->value);

