Return-Path: <linux-kernel+bounces-43908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57051841AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F7E287900
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7F374EC;
	Tue, 30 Jan 2024 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jFww0mj6"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A9374C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585999; cv=none; b=GOoLZWmG/IEpIPCtH6FitJ0d5q6It4kG1w+bF5+N15ZE61kP0i2XZzRtvrSo/Bd0KrOJriyW5VgAYX189WVMxSqWbbVcpv69+iikopccPr7RsJiGW1/s/EGbZqPicZD4aXZxZr2A8W0kqzJo/6OgUqsF/x1F/NmF0rf3ETiWxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585999; c=relaxed/simple;
	bh=BPG92zZrqLWOj1ZH1OKSxI+4UlSHlE4jZb0IeRt/EIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDr5vhCbXyUh08dU1/ViaUh+xR/j+9sU6Ge5UmHNIw5xgpstiWGiDfTbvG5XWWie/Ho1KTTkgzNeQBNr03mv3+i8D4JWMDRAAD3jLMlIyc8KSEUoan49lc7W18u1bHq4Ngvo8StcrT8QlLsstxWV5cMLHx8NNtkBe4xqa6KupXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jFww0mj6; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5961a2726aaso1998042eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585997; x=1707190797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAvFPVh6nfNVf1UYTTCYgzPrdH003MiVnVgbfyX/N3o=;
        b=jFww0mj63xI9FGnrPaAAG07x6ipQAbWeTuNj7gcWCFld97uJgm0s8aLeu/aJoUY7FW
         PnMcFgLtmVL38dmBY+0ZZxpx3JpbSWgA9DsrXXbc+Hrn5rrplEBKvW7I0yq7f7pTJvjO
         R92OQuWBy/PCHSUws94wi/kCM89iw2+sqTdJG//Mw4ieD/EgDmKQVaPkeVRRly7w3/I8
         WL572m1bNYpgD8FQjvpwUsaPRo/mBddsoSPpwpQpOqfj7s+j9a/koychObX8QEx0Q2+Z
         Ohr0tO5tWilH+3TPy4+z04cTWmxkE+rxCjVWpa5UpyS+jyI0OJvHiXUaWDSk9BvctRzt
         BVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585997; x=1707190797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAvFPVh6nfNVf1UYTTCYgzPrdH003MiVnVgbfyX/N3o=;
        b=U6F8K70ExHYF8iwBrwgNvgDYwa/eLNd25koRe1aU3G1rr03Q73RnXvNIQJKsvXJ7PW
         i/ePlpbZSeaGCoU6ZAcYX7/SMbfX0QcYyi/FGGuAWctLtOZH/X3MrLO2TKK4SrpHfVgL
         uBzSEHehpAFBljaiXswi8igWeDx183zsWYaEf1o60iVjwZM//k3dArSWNTSnNd86n0JP
         0lU/kXkT4pYgJk+U8Tcv+f2+AbVvWjaJXGMViZFfBqJ7moY/h4hqQ5KyMHXihaiGKFKu
         nK9WwLZu9ut3R/82FMj/P9tHTScRb19m3514aBxyPeH9CLaJIArObGNP9xMe2+a3+cYQ
         +YlA==
X-Gm-Message-State: AOJu0Yx1SqsGd4PAw8lso3QeyBtRgmdvRtXJt7JTWAYIjExPeK2ZGEAt
	oYShSW7Idy+yNt7PQpY4s/T1YbrShtWXn4Ef8s9nl35YZet4NBnY9Dffl0nh0GE=
X-Google-Smtp-Source: AGHT+IGfJ8xTHLEOmB9kZ3CLuaBn2PeBoooqOTYuXKJOOgfm4fhIOAzoNNbUUvkLZjEtUZIRBDQG2w==
X-Received: by 2002:a05:6358:8a9:b0:176:8263:9a71 with SMTP id m41-20020a05635808a900b0017682639a71mr4424336rwj.13.1706585997173;
        Mon, 29 Jan 2024 19:39:57 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:39:56 -0800 (PST)
Message-ID: <1eaf2a35-3b8b-4f40-96ab-3eb499a2aede@bytedance.com>
Date: Tue, 30 Jan 2024 11:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-6-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> Remove stale comment and unnecessary local variable.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0c6adaf2fdb6..7a7e8da2b4f8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -546,15 +546,11 @@ static void zswap_entry_get(struct zswap_entry *entry)
>  	entry->refcount++;
>  }
>  
> -/* caller must hold the tree lock
> -* remove from the tree and free it, if nobody reference the entry
> -*/
> +/* caller must hold the tree lock */
>  static void zswap_entry_put(struct zswap_entry *entry)
>  {
> -	int refcount = --entry->refcount;
> -
> -	WARN_ON_ONCE(refcount < 0);
> -	if (refcount == 0) {
> +	WARN_ON_ONCE(!entry->refcount);
> +	if (--entry->refcount == 0) {
>  		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
>  		zswap_entry_free(entry);
>  	}

