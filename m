Return-Path: <linux-kernel+bounces-50917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680D8483BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C31F25E8A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C90101FA;
	Sat,  3 Feb 2024 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="agCDKt48"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E0847E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934838; cv=none; b=EXiroeoYr6/ziTcGL6nKGrXle70SwtRjjAFL7rWxeOuKF5rxqgHFppGi+4aTO8YWw9pC7Aood9mh5z5WQrv7hTlIQzGDWsccY1rjvDsR6cAoUPIPiSThCcp0UsvNXuuNClZ3FqD9wU/W5XS+OuBiULa/Cg3/WebiQrpprXVahNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934838; c=relaxed/simple;
	bh=muinc+muTDvP66Z/unHVgr9NV9HT4I3ebanyQt4EKlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7wCUdvsoKfcTv2Rc7G78qttU7fQhobiBJLp7VzGNwJ0vhFkk/fxTMBKYRFkBKh/vU9RVkuBKYUDnF92bnyi7y0tVeG9Vb0Gxv3P4nLOs9cU+qal7fHea9/+W5/AG3Hj00YHFgz9HcZOz+is06msowp5ktx7VKVVIyyisu4D9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=agCDKt48; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2183908a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706934835; x=1707539635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nuiv03HcSNjIM1+hCP8lhQ3FlZeCD1OJRMjdxuvBL2Y=;
        b=agCDKt48jtMmgZj+m3BTi5AkWzAK4LhPhKqfzk3m1lMMhb8b6Kro6XxpyAxTpxr+rN
         kxLXjarKRuUAeCYqmwj/xHAMzUDi6Iysb9yV76gEHgLYAEsuo/NGHdgp7cHMPHLJMTHx
         hJ6MX3G8VoXWxwpF2D5RArAfCIcPFwKukpNANLPPPXduGCr6kyXNJzYCG+wCqe7gwL56
         DJJ+qWjzSBnso93rsfk9RBVVQ+Q+4Goo9R//MiBaTYcyDWiqApk2ANjpiBtJ3HJzxO5r
         bq6aNC1Ku0fRdPX9vgv3ObqZXARMFdxzEy4u29FijAZbLbYgg5m275I9S9ymj1Kt35JA
         WsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706934835; x=1707539635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nuiv03HcSNjIM1+hCP8lhQ3FlZeCD1OJRMjdxuvBL2Y=;
        b=xSYKBMrzU3Gi8nPFUm+8iPDfctcHs39n1OmLGF4Uw1tTxiLelzn2zzqhvhRN7gpE6b
         mJ4P03e3lAOt/LKeowB/X/+hQTxltVCk1yxQOQ+PrOGxOqkS1v+WJ6dyvburq/h0yM2/
         tu9w8hWExBazIfBsbG8qJk97kj9cpkFv6S1sA/4nnxJz5byUTFH3Xv5TNzwE2zJSt2ZX
         /ML82zSrTasT6HNuNkRion8swpOf711oRKt2OHnjWBq19XVNnUVaZOtXNxO/jot+9Xs9
         xG7Dg1FyZ/PC1Pu6E6ydT1iEdhRG8fIoPW5K5KIXDePY956PMxOzqsoJpFPMY3YIZKy6
         xtTA==
X-Gm-Message-State: AOJu0YydtRuRWzcvJq0Be0phwz6tMw32zMZfwiw45Gj47lRcuF02B2KN
	+GpDRgb3Hdg0ps/AUO2li4qZEvFNIudns0dw51lt+hDRJUoKqnr+Gi0ToCIMYYM=
X-Google-Smtp-Source: AGHT+IFQD/CkFtp3Qzg0FqH3IX1EqeR1CVYDzP3nkWAMtrC77i5GpJ/17TZMvdHUbtoD8JswIFBbJg==
X-Received: by 2002:a17:902:ba98:b0:1d9:620b:89cb with SMTP id k24-20020a170902ba9800b001d9620b89cbmr5416553pls.13.1706934835371;
        Fri, 02 Feb 2024 20:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4fQLXwQyYMQZyr8DkPUwiJI2qdSM4MiZgNDsyWv7XG2ndUtN15OB7n3y4C5tarfTl2TFzkG01rm7QKInRM7WsZmI8ZYIuSuzwzs9sZDyvVBgUrKhZAeQ4/O3cz5st1yjjTi3P+gzWbWTG3mLny7zzxy0RXd6yUBtg3nExDj9GqrMsByzrnQE2o1+Db2t5bPAokQ==
Received: from [10.4.12.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170903088500b001d70af5be17sm2399344plb.229.2024.02.02.20.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 20:33:55 -0800 (PST)
Message-ID: <49a073bd-cb59-45c0-baf7-fcb1bc8af22e@bytedance.com>
Date: Sat, 3 Feb 2024 12:33:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
 <20240201181240.GE321148@cmpxchg.org>
 <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
 <20240202162635.GF1227330@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240202162635.GF1227330@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/3 00:26, Johannes Weiner wrote:
> On Fri, Feb 02, 2024 at 08:57:38PM +0800, Chengming Zhou wrote:
>> On 2024/2/2 02:12, Johannes Weiner wrote:
>>> Caching "swapout work" is helpful when the system is thrashing. Then
>>> recently swapped in pages might get swapped out again very soon. It
>>> certainly makes sense with conventional swap, because keeping a clean
>>> copy on the disk saves IO work and doesn't cost any additional memory.
>>>
>>> But with zswap, it's different. It saves some compression work on a
>>> thrashing page. But the act of keeping compressed memory contributes
>>> to a higher rate of thrashing. And that can cause IO in other places
>>> like zswap writeback and file memory.
>>
>> [...] A/B test kernel building in tmpfs directory, memory.max=2GB.
>> (zswap writeback enabled and shrinker_enabled, one 50GB swapfile)
>>
>> From the below results, exclusive mode has fewer scan and refault.
>>
>>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
>> real                          63.80                         63.01                         
>> user                          1063.83                       1061.32                       
>> sys                           290.31                        266.15                        
>>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
>> workingset_refault_anon       2383084.40                    1976397.40                    
>> workingset_refault_file       44134.00                      45689.40                      
>> workingset_activate_anon      837878.00                     728441.20                     
>> workingset_activate_file      4710.00                       4085.20                       
>> workingset_restore_anon       732622.60                     639428.40                     
>> workingset_restore_file       1007.00                       926.80                        
>> workingset_nodereclaim        0.00                          0.00                          
>> pgscan                        14343003.40                   12409570.20                   
>> pgscan_kswapd                 0.00                          0.00                          
>> pgscan_direct                 14343003.40                   12409570.20                   
>> pgscan_khugepaged             0.00                          0.00                         
> 
> That's perfect. Thanks!
> 
> Would you mind adding all of the above into the changelog?
Yeah, will do. Thanks!

> 
> With that,
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

