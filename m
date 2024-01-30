Return-Path: <linux-kernel+bounces-43903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9D841A99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479A0B21CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B083374F8;
	Tue, 30 Jan 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VIyNPG9w"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19B374C2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585803; cv=none; b=D4DNdzAUbcFRZQTW9btWXZrt0cKJ1tkaL13XNCGNmtt2IXipEbHOrf+PKw9oTQHaGXTauDwH3FHzvViKOb7efBb6OpB2KQeRrUHlIGWDiZvDuF6KSFmc6//1+03lOU5KnGxFHxQK/YyxLHmesE8mxGRunS4IcaWxHoPke9NcVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585803; c=relaxed/simple;
	bh=zj0nZQlVM5cwdz68bsEI8QIya8LQBEd905LxUX+p478=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L67v4oj2jqHFgrcHavwHpR3LNYTfsat/27XVeqwNILMWNEzttPiiNfdRhz0oPtWKcabH+j+m9Ti/2yedLJG/Z1T07rqQDVVfwJtqfZIQXKzCe/yKOJHUhlzmu0YdL/Ke/un9ggwscJ6nysPs3ukt/CmdhkGPsWxLewA/e5Kmb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VIyNPG9w; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21499c9650cso1224477fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585801; x=1707190601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkSLJRp1f0GwczdGFgnBAEqAFYQupxf3SUPmnpRy8AM=;
        b=VIyNPG9wUka1B4OMBxwCuNgyp/ojHH5/qekfC3/3Hojk4stHV23o3axAUP1/HQUnrO
         t6NB9moG1Wc58UTg0nnB3SD4U3G4WSGLVjQC6Cn3l5KFPBpnRnHnwhjdYH9hjRkmtGOI
         F6WZpTrDwoZ75hUIv4wHhjixyMy4zDQUbjcPf/GefekzcnlKgQFFou65aZA0/iY6dHdQ
         O3WYdBH4y1F7aMJk+mwY419B3w3Z8076M+XknmFKPxMp4IX34vkhxMfvCNI6fVjpdBcp
         Qht1wIlAuUl17aT6iqPWfDBKlDSj7sRtf7zDncLUgUJPMBFAbWEnow8/wgE/4bec5R7E
         CHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585801; x=1707190601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkSLJRp1f0GwczdGFgnBAEqAFYQupxf3SUPmnpRy8AM=;
        b=Ofi8pBmng9Ba/gV2HDkYJNE4sk6QF8jCTZIWYXJQP6KAp1Nk+xkn2A41bbvZNbeIIL
         kyHC43LJ1+O5++6I2TlLxCd8Ewz1Ry3cILB52H6nyJM10WMUwEYgEFVjtzoX9TqvhiHe
         kEzXAL60CpMEXTvPMg8G0fCoGNZ67Xj8c+GJTZPK1hkeCX3aB1Qp4O5x+37rbgQCYHAP
         /8h48GT1tFDEk/Cs6YcUFR822xCyUnNEQCIzQxE2AOxU2HBvH2KCOVWN7joI3lZGmltH
         bjsJ3f/8Te1mkwCR0To0k4P2XBGo2hJH6HJtw0vZq6RHjA8mRPPf8hFdzBlHRM0GgSg5
         kXrQ==
X-Gm-Message-State: AOJu0YyDtzWIVUswr+r1WD9bhj04S8A7cMLAMasrTOob0Vj8f03QGQKa
	0IfyZetdcjxChj8PkbCOwWcA+nSqkPfkaDapjSGGWQZa29VibDISxeFLKZnXgqM=
X-Google-Smtp-Source: AGHT+IGhejiwxqUrfIq7Qwbr9y9UAsaa9m0NcDmC3zPYmk95tMEjPTt/WMFF2//2tHkkjTICnb2+uQ==
X-Received: by 2002:a05:6870:47a4:b0:206:a798:8d88 with SMTP id c36-20020a05687047a400b00206a7988d88mr3337698oaq.29.1706585801353;
        Mon, 29 Jan 2024 19:36:41 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:36:41 -0800 (PST)
Message-ID: <a5a69097-9ebd-4d97-b32c-301628d914d3@bytedance.com>
Date: Tue, 30 Jan 2024 11:36:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to
 zswap_entry_free
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-2-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> There is a zswap_entry_ namespace with multiple functions already.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7f88b3a77e4a..173f2e6657de 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -520,7 +520,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>   * Carries out the common pattern of freeing and entry's zpool allocation,
>   * freeing the entry itself, and decrementing the number of stored pages.
>   */
> -static void zswap_free_entry(struct zswap_entry *entry)
> +static void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	if (!entry->length)
>  		atomic_dec(&zswap_same_filled_pages);
> @@ -555,7 +555,7 @@ static void zswap_entry_put(struct zswap_entry *entry)
>  	WARN_ON_ONCE(refcount < 0);
>  	if (refcount == 0) {
>  		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> -		zswap_free_entry(entry);
> +		zswap_entry_free(entry);
>  	}
>  }
>  

