Return-Path: <linux-kernel+bounces-132843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9C899B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C73B22820
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B3A15FCE7;
	Fri,  5 Apr 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO9Qz/2c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F818E02
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313764; cv=none; b=skQ2dbutOnZ68MvG7gLhKrLTOzHsGttSgwjj77+0okw4R1zi3NKYeWMR/N+Ui1QluVC+VdxTgIJier7JGTgs8LJ9Ros50Ql2jAZmnOwuxjzX3gkl1Cc1VDfUgbrBrP4dKbcjVNhJj6cUIo3pklYwZvDH2G1vOCk5z260oRB+vbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313764; c=relaxed/simple;
	bh=ZTkana/yuPXBRxKYkbvtxQO3wRMkHZJz8PI/k6g9ygo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkc+CIuxooQiklYFTod32MskWrOsU33W7Wc0TXTaXwP9gFRq1PPLjNuQ8I04OOspS3+3ugoFvLhtd3CLpBNmRR1La2HzhoejVjz8zwHe4T8/NE+3FxZ5yHGk/+w4Vhgl13EoO48+G02K5Iyxxum5UrC+H5DSYbT38G1Tc27ZaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO9Qz/2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712313761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1/wklP/lDOZR/Q+8YLfQhYyfaQF2tEo/8k6TCUYB3qY=;
	b=YO9Qz/2c+RaLDtuU0ciBi1wVvN2nTgEn2a1gQAR4nndWr7eb5m1vFhoQWFH96AKarN8Gq6
	+CyaWyuDBrFEh1aVTaHXq/1hAYddd7npxpQrlcCGti/vbboNB3Is571GCmUqNb7TjINc63
	+iEqLjxfIlVPufwKU75GwXrad9PYo3s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-a1uYIMO2MtCQTszvvJsa1g-1; Fri, 05 Apr 2024 06:42:40 -0400
X-MC-Unique: a1uYIMO2MtCQTszvvJsa1g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d86005189eso12724431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313759; x=1712918559;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1/wklP/lDOZR/Q+8YLfQhYyfaQF2tEo/8k6TCUYB3qY=;
        b=B9+7JeUw2JYtAONdKFpoP/cWcWsI3WlueIMOQeftM5LxBj05l26J4ghJ3V5Bt7ajQ7
         Zgjv1oG5l914vbv7kQ61PKKz5UNeV6ZiQSo8Az3d4BkSicURsVmwlCUNFuE0tEiV+yNg
         tNVAsW3BaKVVmSnGCGl8bTp5uhaxgtm0zzg6yOVjZL5URrBkirEc8HU/ZZf8enOV0jk7
         SvBfleCnPLjTrbCVj08N72M4sMHLudUiYFWP4A4vVomVONvGpBfm26y/WNxkQB4QShpC
         LqzobBWLHp2K7qNntfZQcYATKJpG3lhoUDYQKtTxMLuY6gCJSuanhdpMuiGOgLPrbXNp
         tVsA==
X-Forwarded-Encrypted: i=1; AJvYcCXMRHDziy1rGrunNhkUn7kHyO3ZIS025v0UE/PDn7zze7y2c3zMuJnY5XPmaTENCL4PmssJbiiIkQrbQc3iT8QfpHiRWH66Pfoib4jk
X-Gm-Message-State: AOJu0YyoJ3obFcfARxaG+axRytGXQVIMq+jC63YY9X/ogMcdOcTN1n9e
	gez+IWCf7iYWcf5gOBfQJS4pS+BDdyiw/Nj8KWlpYUy4vj2OMy0zTJySfYNTCw9RhBBAXX95SQi
	MjjUaf8KmDC9vKxc1lvY/gZAcwTyiPzmo+AtxE9VLAUlwFul/iLxAxfh9LpRUTA==
X-Received: by 2002:ac2:5f89:0:b0:516:10be:d7a9 with SMTP id r9-20020ac25f89000000b0051610bed7a9mr777551lfe.30.1712313758966;
        Fri, 05 Apr 2024 03:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowj3yR8WBce6p8iUACUcv22MtzbIp64Kbujwn41zHkCDL2eDbdKqqxXKo05O7BCigHSdoVw==
X-Received: by 2002:ac2:5f89:0:b0:516:10be:d7a9 with SMTP id r9-20020ac25f89000000b0051610bed7a9mr777530lfe.30.1712313758550;
        Fri, 05 Apr 2024 03:42:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id c10-20020a19760a000000b00513a0876870sm153555lff.267.2024.04.05.03.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 03:42:38 -0700 (PDT)
Message-ID: <6653ce52-53a2-4d91-b98f-50f1608ae59c@redhat.com>
Date: Fri, 5 Apr 2024 12:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-6-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403114032.1162100-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 13:40, Ryan Roberts wrote:
> Now that swap supports storing all mTHP sizes, avoid splitting large
> folios before swap-out. This benefits performance of the swap-out path
> by eliding split_folio_to_list(), which is expensive, and also sets us
> up for swapping in large folios in a future series.
> 
> If the folio is partially mapped, we continue to split it since we want
> to avoid the extra IO overhead and storage of writing out pages
> uneccessarily.
> 
> THP_SWPOUT and THP_SWPOUT_FALLBACK counters should continue to count
> events only for PMD-mappable folios to avoid user confusion. THP_SWPOUT
> already has the appropriate guard. Add a guard for THP_SWPOUT_FALLBACK.
> It may be appropriate to add per-size counters in future.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/vmscan.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 00adaf1cb2c3..ffc4553c8615 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   					if (!can_split_folio(folio, NULL))
>   						goto activate_locked;
>   					/*
> -					 * Split folios without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> +					 * Split partially mapped folios right
> +					 * away. We can free the unmapped pages
> +					 * without IO.
>   					 */
> -					if (!folio_entire_mapcount(folio) &&
> +					if (data_race(!list_empty(
> +						&folio->_deferred_list)) &&

Please violate the 80 chars rule where reasonable.

"
Statements longer than 80 columns should be broken into sensible chunks, 
unless exceeding 80 columns significantly increases readability and does 
not hide information.
"


Likely some of that code here should be refactored into readable 
sub-functions.

codingstyle also mentions

"The answer to that is that if you need more than 3 levels of 
indentation, you're screwed anyway, and should fix your program."

-- 
Cheers,

David / dhildenb


