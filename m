Return-Path: <linux-kernel+bounces-120238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4488D4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6185F1F3092B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEBE21101;
	Wed, 27 Mar 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTZ+xcvy"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7A171AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507462; cv=none; b=Phh49u4IW91zouaz1eYRa+DgmQAKT2NhcFVcNtBhMrIq6SJc4byZ4uWP6byfouPPCwmPRMQBcmBT645qWwTrXg+xsAakMLrizmCvpc2XXe2tFiKzbM4GAqY2Wf0T2/HRt7H6LziMJjsgydaA2vB7MBU4efPXUqGhsqbEx8VREB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507462; c=relaxed/simple;
	bh=/nMN9bGkyVCXT67rKhoWoGALr6/KJ3zxKEc+pwvCYUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HI/tGs1ORicTuSiQcGb5vMb8qM9dmzTDjXWGeB1GNrnhi5KbeEtFMVJIrcArZEjhDwxEdVLEdLbbSvboDnGOBeA4ZH9Ib16NkFXZxtlBgXXaBHxHr2w2zHrvoDjupSyqpkFcbIpVTfSE8OK8NgFp3w57c31Wm0ncj+SFnktU9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTZ+xcvy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e1eedef-5e4c-448f-95ea-d50b431c4265@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711507458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YV9H8m8+M/zUWvTG1qNucKVLnNsHNqSeiCVsLZ0jiZY=;
	b=cTZ+xcvyv/fKg+yi81sxZkRCkjFqaUAHzDZ1hrlBPH1XAZ/4IKg97CGVzN6PK+HSGNkiT5
	U5eKUmTFF27fJfnrwHSaLXTASqRuwHd/u8yb9JHHJdBJ62RypfYOVkdK8cVNwsUwWdgfKA
	TBXKcFBErfo+Cz3FokjtYa0q1hfii0c=
Date: Wed, 27 Mar 2024 10:44:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-6-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> There is no logical reason to refuse storing same-filled pages more
> efficiently and opt for compression. Remove the userspace knob.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, should we also remove zswap_non_same_filled_pages_enabled?
Not sure if it has real usage...

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 498a6c5839bef..0fc27ae950c74 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -123,14 +123,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>  		   uint, 0644);
>  
> -/*
> - * Enable/disable handling same-value filled pages (enabled by default).
> - * If disabled every page is considered non-same-value filled.
> - */
> -static bool zswap_same_filled_pages_enabled = true;
> -module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
> -		   bool, 0644);
> -
>  /* Enable/disable handling non-same-value filled pages (enabled by default) */
>  static bool zswap_non_same_filled_pages_enabled = true;
>  module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
> @@ -1392,9 +1384,6 @@ static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value
>  	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
>  	bool ret;
>  
> -	if (!zswap_same_filled_pages_enabled)
> -		return false;
> -
>  	page = kmap_local_folio(folio, 0);
>  	val = page[0];
>  

