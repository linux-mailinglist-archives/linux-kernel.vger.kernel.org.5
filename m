Return-Path: <linux-kernel+bounces-40182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4883DBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1491C23C23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09401C693;
	Fri, 26 Jan 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ufuC/7VD"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EE1C688
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279290; cv=none; b=bRqaZ3mDaQJaZsiacj9gVMZmhmALiIeGxUhdXQHP7WPBOUQaQhqgsDjtulEiV1j8r+R+eGnBR6I+wTH/2vCEN3ZF8lXW/9RhSb4XrKDO8AMmxnKqgnnqNnXRb69/MVmbW0LB3gmJG2jGhdpAhmAEEf60N1l7GLQ3tqUKp6sITI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279290; c=relaxed/simple;
	bh=ptiHZ9JiNJrvYyw90aqyIDcKSMeMvz8HiF6qKLRFFeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XklxwiwU4/GEkeIDIC4R2cSFpnoltTeN84EKtNKjMChgiiqlctiTCE7ek6cEKGAXZAXEe3FyqSUcdMRddBfHX3dz7qWcUkWG3Nk9nyQqxxq/PO6Se8sk97t+JzJTXPMZFhLMHpJOeGW3VA0nA8QdvPSzsZ04rlT1CW4Y63X5Z7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ufuC/7VD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-429fc7a1eacso3205181cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706279285; x=1706884085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ09+VzJkKE1sXYVFB1gLtsc0+Fyosssz3eqam4UtCw=;
        b=ufuC/7VDr7JTIdb7scRiuo7FQpZ2VppRo3Feh8Bv9w3l5T6TjrUed8wInTxMNtPqGJ
         5rIwtvOlP11YTcnjElZgb7r/T7PlHYIt01/5rQGhDBNBsJIgUb4c0IAMYjywWPT+KWBz
         +sPQiaezIzB2GOqDygHkWBthC5NDNxQdSFzYdg53OW7dkuqJv0xxj5zzs8LolmHziLeS
         GLvE7FEv8VTeJC3D/QyKHktPyl1qlUJRKgxv9C/qmoGNWbdzGmQZGkfCwowKp0XBM8By
         nCl7Jj31Y3xuy0H9Ob7obfrQ4u1SsuGyLX5VMibJwCXneC/WBFAivk4GBqjIT16VPsdY
         RO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279285; x=1706884085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ09+VzJkKE1sXYVFB1gLtsc0+Fyosssz3eqam4UtCw=;
        b=GpsIuB07A92HRjg11AxKPAPKy6KkrQhoNHZf3Diifr/xQme2YEPtf/GdS/q11E8gS1
         L5+z3UCS9LqmmLydO/KU6WVAWaHi2NWWoty5UC3KI/1IrcqxhZq5j4j92xDUzb62IPwj
         WtBt/V2dXWHhKeqbz3yqGI7/4g+LTHp8Kpc9A0CF8sgdTcs+djsb86oUw6G2aSejWcyQ
         4CZHtiotJ7AhrVJyz1/vTAW6NJQjQHozYdPte0rW+sSYrqjVYITR7HcKBf2W7bnadH9f
         MyH7e79eujjp/rJJRD5rhm2X+v/Cz/6lXXtoexSaAIOPAlehGof6FSNRWIUptT2AS3Gf
         yFJw==
X-Gm-Message-State: AOJu0YyLgi1smzEeUK+CidPO8zGm/WkBUMfv9KyBnnjYhkTpjot8FACF
	xkRezzSMrr6MOnIX45BLgZ7KE2EsjmMJynKXgkMBS5zzM9ojy2jP+XFEilmD+Nw=
X-Google-Smtp-Source: AGHT+IGOoacJV/nAVA+Xd9yml5yt6vl2AMdy5wcj/Qx9AXefv3NvlySozCO2BWDBQ3YHL3N7SdEhAQ==
X-Received: by 2002:a05:6214:1bcc:b0:686:acfd:9e07 with SMTP id m12-20020a0562141bcc00b00686acfd9e07mr1839640qvc.32.1706279285394;
        Fri, 26 Jan 2024 06:28:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id nf6-20020a0562143b8600b0067cd5c86936sm540440qvb.79.2024.01.26.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:28:05 -0800 (PST)
Date: Fri, 26 Jan 2024 09:28:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: chengming.zhou@linux.dev
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
Message-ID: <20240126142800.GF1567330@cmpxchg.org>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126083015.3557006-1-chengming.zhou@linux.dev>

On Fri, Jan 26, 2024 at 08:30:14AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> LRU_SKIP can only be returned if we don't ever dropped lru lock, or
> we need to return LRU_RETRY to restart from the head of lru list.

Good catch. Can you mention the possible consequences in the log?

"Otherwise, the iteration might continue from a cursor position that
was freed while the locks were dropped."?

> Actually we may need to introduce another LRU_STOP to really terminate
> the ongoing shrinking scan process, when we encounter a warm page
> already in the swap cache. The current list_lru implementation
> doesn't have this function to early break from __list_lru_walk_one.
> 
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

