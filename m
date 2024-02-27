Return-Path: <linux-kernel+bounces-83887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F7B869FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAC31C28520
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C614CAD1;
	Tue, 27 Feb 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Y5EXjVsb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC37524D0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060526; cv=none; b=sYT1VFFySH+MCjLEaoJvo9LQNAgRxnYl6H57R3pyFRUi4m983e71j6KS0lijpGw2SWXrc+vWXriTWA2gGWnEABbEA+uFRE4r+aTqs2VNK9Rgb2CdDgStvXQeWJNEHBBZY1f8V1NZ7+PV8qKjl/oim+CEa22Bgwz/+pR2Nm+JS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060526; c=relaxed/simple;
	bh=N5TI/RT7tSbHAzXpAE0y0CqGtG2+EVcPfWJWRQP7swc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sknbQb4dQKB32210ACJbA7dQuJmqcHq3RRZXFxoPhKchRAidFCqRd8JBsyArgeX0v66gZbCAr9OFf27YMdvlZwu8KH6UqkeW95YjKfapQLHQJM40C1VPRxxsbUqxY5ZS7URJ/kjXT0h+G5Y3aYWanMozzAS2K+N9LsQittt+/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Y5EXjVsb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a437a2a46b1so248697566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709060523; x=1709665323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1q+1nHGeN9JstdRCnM0oUNgt0RBGVjhiHcZGWKHHuo=;
        b=Y5EXjVsbMexqaWIYoQNT522i1UhtL0lOdTP8kzjbUDPrl2+DY3kwGBOZ6UyYfhQog1
         +SR9kSzqiIx1Z7Jz4s7jhtclrIYt/zfKThOAKMHSIX5AQtDkwgZ9SAOt3T1TiTFzBL1z
         T6DwVkqExuOicgwYdJ+SK2ctSY6HW9SVxlwGO9uo+fBaOANxFDI14fY+R0Vs/B+fvQFf
         omtC+DVWb2ubGWMuEKFJ3jVzJi+/dSfE8PL3IS8JJqyOB4BmfcXNPx29A8ugqWL+y14w
         HMWFzSdD5nkDJJCACUlRhIT47TQLKXq74YiHnOuXpVJDKFnJxun/RciUmmI45jShv9hA
         dcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060523; x=1709665323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1q+1nHGeN9JstdRCnM0oUNgt0RBGVjhiHcZGWKHHuo=;
        b=n3w81AAf6jArdc/vifbpzU7YPp7NLi/oaD/Cg31ewWGkO/69LdNPIEYRAVqyRB7PF7
         lE1aAbyxgm6peS9X8Ihj1NWJYI1HitfI4t3nz+rDLbV2DrIMxPZdRzkHt6ewAZWHINxs
         5vOBH8XWDkO5zM+HsEHUWw4XJGapId15EACczmcgg1QpEN0iweqFJS4bdvTQUQmR7Nen
         jkgCw713KV/vDe7T4OLPeUG2WSw9j5Abha/1IoPX7J62U8hvFTx4byrXSsenwyia8uGr
         Gpn26H139zHB1zR4RAqRzm3DnzchqYSCk5/AHM4Hypq/KIrPEaBuwAmecFrXckyr8iGJ
         OwAg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Tmty61iLR3sTZOck2xNwmGDkHAfwnjeKkYAqXUS7lOCK/t55ye82p4lTXTbMtc0ry0yFmR+yiWMXuQEXYb19/sLjbkhtbZLhWmXF
X-Gm-Message-State: AOJu0Yzcg2ggehBrIBC6bgJPVitbli0qfsG8BTb7+5sk9PHGAA/Wk00V
	DTPNaZ428hXgGbBOAKqk+EW/mEtchMtgrJdW5uD/ex5Qq1eLqhE9fw/v5HX1isI=
X-Google-Smtp-Source: AGHT+IE1XNkbUpSjMjOpcuNNOXVkGSXvQ7nVK4Av1jceNHUmxdsvrz5REIHtRQD4V8RvdGQwkhuNgQ==
X-Received: by 2002:a17:906:a38b:b0:a3f:721f:a7ac with SMTP id k11-20020a170906a38b00b00a3f721fa7acmr7129987ejz.45.1709060523141;
        Tue, 27 Feb 2024 11:02:03 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a43e6c2e107sm91703ejc.189.2024.02.27.11.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:02 -0800 (PST)
Message-ID: <a7d6e651-998a-4996-9b03-40d95edc84b5@blackwall.org>
Date: Tue, 27 Feb 2024 21:02:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Do not allocate stats in the
 driver
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20240227182338.2739884-1-leitao@debian.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227182338.2739884-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 20:23, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the bridge driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/bridge/br_device.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


