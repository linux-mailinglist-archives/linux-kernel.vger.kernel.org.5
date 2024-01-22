Return-Path: <linux-kernel+bounces-33087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA3836446
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913828DF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071683CF7E;
	Mon, 22 Jan 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fdfbwNxU"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5313CF59
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929471; cv=none; b=b4m36GqDK6NEv8yTIiRiTexOIIt5FqMOi8DFY4NrY7bR5x8X7BMzB7JHqcijDPNE/sVWsjKPLk87OTLELuXPpVFwiU1yt0YEtob6bNI1bHo/N4HSdwUocYwlga/nttzRN3btLvZNZ+qP1zcjzWJLWpSKrtSwixpyEd6cCuVDhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929471; c=relaxed/simple;
	bh=adhOBxAX1pnGbHkGlDUuuNqMcPJbfJRL5CYSh6J/Npc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mi3YotTE7ebOWCJ6W2xkq6GLK2ZcXj/hHNzgx2KjaSnvCYm09al8ZeE7pJ/j/CtSUBivUj/ZMDRCHcHPgWlJ4RKWbn12TeQJM4S3DBD2gYSMjWYO107pXXQLdhKip7kZwnldTyOxdPukhb86I099AtYiYzUrb/pIBqsXH6s65Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fdfbwNxU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6daa89a6452so1829964b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705929469; x=1706534269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDTywOhHts8IqwvBm49PSHeY+lSXu3apx9HFTNA8DEk=;
        b=fdfbwNxUCofIJS4BVn4ELYhLvqiHEvMS85EMbzhFmY+UoIhI6U0yuZ7YiaKdcucoEb
         ocS8gZP9jthCikftihU6Mp7HSd2VvrEnGRScEowq1JNBRowNt0+L9Rv6oM8hxUfsBxz9
         LaVy4KNMp7J/DgpKhqyfSFrGFg6+9KCnSHaw8mQVqqFFRYc3Z42ZS3QcAboF66lzYIgK
         2guMux7aKbnZ/eckPVfFcR30VUIh9sQ4aF4+NvO7XyQlM4xJCH9M7JDCMrvRulXSjaVb
         QXxXQOLv44e4Iw1J/87k7PwONPr80WxtiPSN2okhO3CrhGw+gN/SXyCpbUhJcHJVqZSH
         Vjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929469; x=1706534269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDTywOhHts8IqwvBm49PSHeY+lSXu3apx9HFTNA8DEk=;
        b=BuXE0+qWbZeBJ7bTS/xmUREXniKY66eUDXJJJaprYVPWbUAcbiNEQPf+p5K514JHvZ
         0n/e1gNyop6pEwrdreQ8mY1Kr38p4ZjxP2iX0Iy5TyqZ3G/ynLCcR1emQ682cnKXUvLc
         rq5UZ0WUtnpCBTLMQrjVGAAwMG7YYBRJ/J8ryyYNtyDlCi0gMGMYWDfIVQvF+QSAaMyq
         cXIyR8fT4U16xMSy/xRKVaBdV5GaCaBeujBWFWua5TNREQdVvSL1LU888VH2iIt6+myj
         gnd53Jwhpbb0xmqxgGSAb1gvBYGxVPV405N8FERztVmR4Sbsh23NOfuf3i9os9vwAOXM
         cXng==
X-Gm-Message-State: AOJu0YzOoAaaVbquq/ZCaXYhaKXLwwKRS2S7jiUtR3fe4FwPyrYiVm0s
	jcqYmfLRfzbvwHQUFPdNQWb3yxgWm9OREGpuSFUoAAVG7Y0rAJVrj2I7cSysglHz9BmLBVs88yc
	7
X-Google-Smtp-Source: AGHT+IHnnG1LTCWyeyfQF9XTntRevizIDxj1x4In4/yCM5suvQFuuw26YYyOOMLvIMF+SXNU3PPUYg==
X-Received: by 2002:a05:6a20:7353:b0:19b:42ea:3154 with SMTP id v19-20020a056a20735300b0019b42ea3154mr1552997pzc.76.1705929469055;
        Mon, 22 Jan 2024 05:17:49 -0800 (PST)
Received: from [10.4.246.34] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78104000000b006da022d1bc8sm9566352pfi.25.2024.01.22.05.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:17:48 -0800 (PST)
Message-ID: <bf10dcfb-8f21-4d0d-82fb-63efb167d169@bytedance.com>
Date: Mon, 22 Jan 2024 21:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are
 done
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-2-yosryahmed@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240120024007.2850671-2-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/20 10:40, Yosry Ahmed wrote:
> In swap_range_free(), we update inuse_pages then do some cleanups (arch
> invalidation, zswap invalidation, swap cache cleanups, etc). During
> swapoff, try_to_unuse() uses inuse_pages to make sure all swap entries
> are freed. Make sure we only update inuse_pages after we are done with
> the cleanups.
> 
> In practice, this shouldn't matter, because swap_range_free() is called
> with the swap info lock held, and the swapoff code will spin for that
> lock after try_to_unuse() anyway.
> 
> The goal is to make it obvious and more future proof that once
> try_to_unuse() returns, all cleanups are done. This also facilitates a
> following zswap cleanup patch which uses this fact to simplify
> zswap_swapoff().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> ---
>  mm/swapfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f0..2fedb148b9404 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		if (was_full && (si->flags & SWP_WRITEOK))
>  			add_to_avail_list(si);
>  	}
> -	atomic_long_add(nr_entries, &nr_swap_pages);
> -	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  	if (si->flags & SWP_BLKDEV)
>  		swap_slot_free_notify =
>  			si->bdev->bd_disk->fops->swap_slot_free_notify;
> @@ -752,6 +750,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		offset++;
>  	}
>  	clear_shadow_from_swap_cache(si->type, begin, end);
> +	atomic_long_add(nr_entries, &nr_swap_pages);
> +	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  }
>  
>  static void set_cluster_next(struct swap_info_struct *si, unsigned long next)

