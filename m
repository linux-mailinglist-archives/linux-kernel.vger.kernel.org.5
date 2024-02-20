Return-Path: <linux-kernel+bounces-72329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB585B20A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C8E1C2222E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B70535B4;
	Tue, 20 Feb 2024 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gI3nQWCM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA191E49F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405200; cv=none; b=U7Uh+IxLC1QxxjWjh64RkIauC1ZbvEl2qGTabNQdHhXK9mvSMaqxDBuZS1Zl0vg3GcfTI5aYWO6E5olC624IVcvGbmQkU09WI6fbbE9DyikUW+1GNVOTaxEe+qzi5Zmlcrnr+xkmhObJuX64jDq3I+ZHsSJN+aAWUStmPvPiPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405200; c=relaxed/simple;
	bh=bfq9r/FwJ6Vjtye0uqYAAX9eXYUmFqBiTHaf99LhLD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePYn9YT9/JKF5WD1GMQiM6dhcO8+FsmEAa1wVv0EO22iDa7saPay+0qqJSSogERveSv+agVEcn0jzC3dRxSET7YgvrFeztJPyOX1Tljea2/Oy6vySlAhF2KPtsjqd33yojqWR91oHOzW83ogR98Wi7H3UfGsGUzbSwhqkbPwCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gI3nQWCM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7393de183so39834345ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708405198; x=1709009998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmfkLuOZGRlJcYuRzNNhWOooi71NhJh+zOe71aSAaNU=;
        b=gI3nQWCMc0K0KTdfzjwJXR0t8OYzNaEX06GrU0u3ErX0IBxPz+Qu2S/xL37qpBn1td
         No+T/hdOUCAal7gZETICJfJfln/DFwtbZIcq94h0V9lQjdX1YS5bbRRvLAC+7E4TN85I
         U1X9tmDWjqgVupbbFYDIrucetNaEDryVtkMuKWPwH2uVaZPi2Czc8eaJozzXUCz2289Z
         CfE0+GY3kQdk4yG/UgV56VMF5aIQOQrp6Y4nbsUWZkjMpvFnq7to77AQb+OfZH0XIeGO
         kq62bwSLucCLWalPH2XAj28XRltrHR0ixBCvH/17zw3qrNiLk7dsJmqR236rTSDSiTSM
         0SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708405198; x=1709009998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmfkLuOZGRlJcYuRzNNhWOooi71NhJh+zOe71aSAaNU=;
        b=IgZBk0e+yoezRn7CbFIG+Hy4vmceA2RD5dM6fPhGjpQJ4sgmPrljIx3b/voP7RZnuK
         AzqTqnaYAJLSiDuAVSaaVqeejjewentfVobLnXDInI62gyn0mu0NLOJoygE1HYl+F4kc
         Zvfc6idyOTC9foOy7e4uB+X6xjfcUWfwI5j/Kh2aunDlpIUgSkx4FQFn/JmpuRKgHBas
         IQe2MYQMGQpFwoKZcD08HRN9YkHzmhynkGtDvUgwCmyXB5MVfzTYp43h9/Xa5UmHYcXr
         lsk6i9j/F1D3zloeCzBLCzlI+K+b4MFpmTmL7VA126EvGSwS+8Nxfh89B2yl6Z0OhU6H
         5Dqw==
X-Forwarded-Encrypted: i=1; AJvYcCW0rCRPjwwK1I2VkSH3jOXm5uyeb7WKD+L+n9J97Mi/gcfhE7+tePywQpvXnVanxyjzcPEuUDho84cqDX9bAJyBSoMaE7j/ALobgLW0
X-Gm-Message-State: AOJu0Yz4z6r0GbIUOW+JEv+tJiD+BHH/mZKm2MsY91OZaPXM3ZsjraKU
	ne78BrFgNqWB/9bDrLoGbeZY36iHX6e8rib+dR17wZ9Hm4i9zqA1BaZObxLele4=
X-Google-Smtp-Source: AGHT+IGcgHQKBdYsumZ9p9EwZ9OT2Vm52iRT9Bn95nkv/sNY/YZC3wBRaeyvMR8/9/UbdN4UPVXfXA==
X-Received: by 2002:a17:902:d382:b0:1db:c704:97d with SMTP id e2-20020a170902d38200b001dbc704097dmr7182876pld.16.1708405198123;
        Mon, 19 Feb 2024 20:59:58 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y11-20020a170903010b00b001db8f7720e2sm5255001plc.288.2024.02.19.20.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 20:59:57 -0800 (PST)
Message-ID: <a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com>
Date: Tue, 20 Feb 2024 12:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim
 <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
 <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
 <20240220044825.GD11472@google.com>
 <4f3c6c96-3bea-4369-a2de-e3c559505bba@bytedance.com>
 <20240220045340.GE11472@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240220045340.GE11472@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/20 12:53, Sergey Senozhatsky wrote:
> On (24/02/20 12:51), Chengming Zhou wrote:
>> On 2024/2/20 12:48, Sergey Senozhatsky wrote:
>>> On (24/02/19 13:33), Chengming Zhou wrote:
>>>>  static void migrate_write_unlock(struct zspage *zspage)
>>>>  {
>>>>  	write_unlock(&zspage->lock);
>>>> @@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>>>>  			dst_zspage = isolate_dst_zspage(class);
>>>>  			if (!dst_zspage)
>>>>  				break;
>>>> -			migrate_write_lock(dst_zspage);
>>>>  		}
>>>>  
>>>>  		src_zspage = isolate_src_zspage(class);
>>>>  		if (!src_zspage)
>>>>  			break;
>>>>  
>>>> -		migrate_write_lock_nested(src_zspage);
>>>> -
>>>> +		migrate_write_lock(src_zspage);
>>>>  		migrate_zspage(pool, src_zspage, dst_zspage);
>>>> -		fg = putback_zspage(class, src_zspage);
>>>>  		migrate_write_unlock(src_zspage);
>>>>  
>>>> +		fg = putback_zspage(class, src_zspage);
>>>
>>> Hmm. Lockless putback doesn't look right to me. We modify critical
>>> zspage fileds in putback_zspage().
>>
>> Which I think is protected by pool->lock, right? We already held it.
> 
> Not really. We have, for example, the following patterns:
> 
> 	get_zspage_mapping()
> 	spin_lock(&pool->lock)

Right, this pattern is not safe actually, since we can't get stable fullness
value of zspage outside pool->lock.

But this pattern usage is only used in free_zspage path, so should be ok.
Actually we don't use the fullness value returned from get_zspage_mapping()
in the free_zspage() path, only use the class value to get the class.

Anyway, this pattern is confusing, I think we should clean up that?

Thanks.

