Return-Path: <linux-kernel+bounces-49871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9958470B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C33288DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83812FB34;
	Fri,  2 Feb 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IT09P49j"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5F1FAE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878667; cv=none; b=O6C9FkGdNRQ+7FiJvonYLnglrJajoHY4BNzUaeLKNwE/Wgua8zRHIGydcZuiOOg0f5C48IebCsHmKylwchIGL59UvFbPmAQp+/VdpyUUfY+QjLaXnvx51ymOa6+iwtmoSHNgzRGQZI0zYqI3t2JI7BWNAXaPIn8uKnP8NADAEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878667; c=relaxed/simple;
	bh=lVRUePqSlREkQMHTuSsLg7Y7N4Ayp8EN8zqNzsmGNdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVjritADAiZiEfyt1buXT0+fUW780fIbNiqHhLGbyn4yUMXou1zy5PyJ7AGB/nUB0jQcWdyNjvhRT0gkeCt+eGDOhe8zWzeGfbrmkNd74dD36Sy7jjtp1RMbjfneHo7jWow1/eteU0R1ynLRA0ys2C8d2nOcM/PlslcP7JUAJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IT09P49j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1701676a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706878664; x=1707483464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsW8Dk1o9bsbV3Vb7IbQbusPN3ry+IgXo47UpIKTbrA=;
        b=IT09P49jV2KndOasLIB+rk2HKgQ6RhS6Ttq8bWgyCQUWxs4Aua6D3YFhWi7ubsO6Uv
         T/BiHjX6XT7Li0PEbRgi9oQMl7ZO5dvW26eAnAKDmXs6hKI27Xv7N1wddoyZj8i0M4QD
         lZkFnq57VYK8bnHd3mLToufww0gYLujf83Z0InQ+P6sBCMTJHnNp+vHR2IMbnbPKes+G
         EYwNddol0sznG5vGSiPyaD+80JG3iRM/d72UswzVaTJs893tbqOeAcqRCJtUoIoz+CbC
         FVYHEoatY6i3+id4ZUYDU1SAivNcUZp6VfBUnPjYfZccKbSAHGclc8Z6QExMVPnNfBBH
         FwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878664; x=1707483464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsW8Dk1o9bsbV3Vb7IbQbusPN3ry+IgXo47UpIKTbrA=;
        b=nuWCelQS5n6bM5ysdSvHZg+SXUG+u9b1+U2Ga0MU6Yde8XFIOw0aWQ/q7uQHV+brTF
         49Sh3CuFHV73PdLd9eAu7VT/83tuyr8HZsINIqwkz1h78Yd8kQLZKWWHMOvNgJZh2DJB
         h0XGF7p6RWuBjJ+uGyYcWJGXMILK4VGew+cgoDS3TY6cV51dzamyQOLbTtVXq5CA9NUL
         J3Taaf4pTZ9c2oQ6XtnN3sNqR3Jd0epBj3D6y8i0n3SpiXHCue176RtIxPWfkU0J2SKW
         Eyqy7DlCv0wpaCPkVIhKm2ILF8deiaCRYvlB5q1GJeaTxMnqeUXUnluiDuNB3lRu+kD7
         5dlQ==
X-Gm-Message-State: AOJu0YxH0MNn02egYbp6q22gAkSRQ+DBUIMRTnGpyQ5eLunTGzyOczOa
	ExX5fX7lLdh8Q3/bP92hai8DGhsAvU3CjXevG0nLB78akC5lLxVr/ySzvN6X0Pg=
X-Google-Smtp-Source: AGHT+IGWW9Hoi/4/LJTWVSRQ7rIcOqbmVxoPE3T2xJYK4L/lSWtt5qNm62jLDFpkJ/zS5VzSbD1G3Q==
X-Received: by 2002:a17:902:ce8c:b0:1d9:7412:834 with SMTP id f12-20020a170902ce8c00b001d974120834mr1734009plg.8.1706878663788;
        Fri, 02 Feb 2024 04:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCULSxMhAwPJO3U6ooCD+Fkc+VZxPIeIMjdrABIKtoDN7IyTpqM3RTVnOErBifu88v9zNK2fR++p9I6yyydVhl0EqpDcP57FzHJXoz1LB0dgkx+FHJIepfxqsiSrhF0+FKBa1HabX19FKoxeK41C1Uk4ZAVGRA4eWCljXbBkh0UMpvRS3vU0RoJTHhPQ6he0eZ37nw==
Received: from [10.255.208.99] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id kg13-20020a170903060d00b001d97fe26d47sm296367plb.34.2024.02.02.04.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:57:43 -0800 (PST)
Message-ID: <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
Date: Fri, 2 Feb 2024 20:57:38 +0800
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
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240201181240.GE321148@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/2 02:12, Johannes Weiner wrote:
> On Thu, Feb 01, 2024 at 03:49:05PM +0000, Chengming Zhou wrote:
>> The !zswap_exclusive_loads_enabled mode will leave compressed copy in
>> the zswap tree and lru list after the folio swapin.
>>
>> There are some disadvantages in this mode:
>> 1. It's a waste of memory since there are two copies of data, one is
>>    folio, the other one is compressed data in zswap. And it's unlikely
>>    the compressed data is useful in the near future.
>>
>> 2. If that folio is dirtied, the compressed data must be not useful,
>>    but we don't know and don't invalidate the trashy memory in zswap.
>>
>> 3. It's not reclaimable from zswap shrinker since zswap_writeback_entry()
>>    will always return -EEXIST and terminate the shrinking process.
>>
>> On the other hand, the only downside of zswap_exclusive_loads_enabled
>> is a little more cpu usage/latency when compression, and the same if
>> the folio is removed from swapcache or dirtied.
>>
>> Not sure if we should accept the above disadvantages in the case of
>> !zswap_exclusive_loads_enabled, so send this out for disscusion.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This is interesting.
> 
> First, I will say that I never liked this config option, because it's
> nearly impossible for a user to answer this question. Much better to
> just pick a reasonable default.

Agree.

> 
> What should the default be?
> 
> Caching "swapout work" is helpful when the system is thrashing. Then
> recently swapped in pages might get swapped out again very soon. It
> certainly makes sense with conventional swap, because keeping a clean
> copy on the disk saves IO work and doesn't cost any additional memory.
> 
> But with zswap, it's different. It saves some compression work on a
> thrashing page. But the act of keeping compressed memory contributes
> to a higher rate of thrashing. And that can cause IO in other places
> like zswap writeback and file memory.
> 
> It would be useful to have an A/B test to confirm that not caching is
> better. Can you run your test with and without keeping the cache, and
> in addition to the timings also compare the deltas for pgscan_anon,
> pgscan_file, workingset_refault_anon, workingset_refault_file?

I just A/B test kernel building in tmpfs directory, memory.max=2GB.
(zswap writeback enabled and shrinker_enabled, one 50GB swapfile)

From the below results, exclusive mode has fewer scan and refault.

                              zswap-invalidate-entry        zswap-invalidate-entry-exclusive
real                          63.80                         63.01                         
user                          1063.83                       1061.32                       
sys                           290.31                        266.15                        
                              zswap-invalidate-entry        zswap-invalidate-entry-exclusive
workingset_refault_anon       2383084.40                    1976397.40                    
workingset_refault_file       44134.00                      45689.40                      
workingset_activate_anon      837878.00                     728441.20                     
workingset_activate_file      4710.00                       4085.20                       
workingset_restore_anon       732622.60                     639428.40                     
workingset_restore_file       1007.00                       926.80                        
workingset_nodereclaim        0.00                          0.00                          
pgscan                        14343003.40                   12409570.20                   
pgscan_kswapd                 0.00                          0.00                          
pgscan_direct                 14343003.40                   12409570.20                   
pgscan_khugepaged             0.00                          0.00                         

