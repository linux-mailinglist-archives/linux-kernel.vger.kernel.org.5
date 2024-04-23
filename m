Return-Path: <linux-kernel+bounces-154957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CE8AE398
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE63F1F23353
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963907E101;
	Tue, 23 Apr 2024 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gkBB9/09"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A778C9A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870770; cv=none; b=uMxZTUjpFhLiUgwqaBtY3DT8uwSYx84HVVenEAOgxtS/izDauH1vJ3vioPIjaDfHsLr/NGV598iTJOF3UuajsqrKca4y0KfuDqnUAAFs4jGcop81zOLncUCZ1hgszRgK2rJsXM6bcoq3mubxrHZw6YVdE1HeU0misA/LyIYje90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870770; c=relaxed/simple;
	bh=WK4EztFBVAHg7eYRzkCerijhdminORv97CA/HPtekR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2fWKfoDSv9BoEW9I0WkWr0PUfR+dhWMZBOxAmQhReWjK/e0dmYKZE/r6SwlP1f/0EK/OT93SVL60WfxVwkb7YtDZekR+pkKFezZfSlZCPnfsjctzHsikwtOdgsmnSpAv6kkDYmbLmExw2lgGB+MW7jEB06+sP9LZoyp6W8hVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gkBB9/09; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so10460541a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713870768; x=1714475568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=gkBB9/09VmOcjQeiyZJnWiz8KUF59wHyDdJVu8uIHybYWzikm3us1PYKBlsR62sT6f
         TyuLhEWVd/ZM01OhqIpymd58GiWuC9QSINMaQGqKNaZ0PDtebqP032xWH/gC5bR/bdP8
         mMtW/wxOGnUHvfMot9tqY9q0OY3hX1RKbvnfKw2LLKDnLfUaN0ZYEAmYSkm6TWFC3KjB
         yZRjNqiOWSqBCsK3At3aJMmKPbGSazOBwdbSK+ygybKkseecdDKCZQ8z8wT2kiSIZJjz
         rE7XxukzxxXgu16rdLRdzaknu3pzDtrAcbFmXnM8t4L7laEGN9TX88hzenifQf67fbqw
         hH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870768; x=1714475568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=AgDtMjj8mdth4+n0NeNrUuiSbadFVD1i0PC0lXXGzars7jCRKp9EBOjvHX0xkm/lJj
         uoKV1RcuHBlexNHgxifQnO07GIJau06c2t+C+K7HPcwpXFQ6B4B6Eej1sF5nCYu8Ofxn
         YQtvHG3S8ine/sDXrzPZMFQVZEXOHspaJeTysV50PnndrHPaPLA/jrkE1R72ThMWOTzX
         D11q0I7HQJZDybRxzdL79BPOfK1KqvLMSFtf4NwTk0CY41MNbWdAu4UyJMzW3p+AyVEP
         7AV9xCfq7JzgsUKM1perkk3DdpYppymsRQi0S5GthAsLik/YQQKouYLJPBzpg1i/VrPq
         zNIA==
X-Forwarded-Encrypted: i=1; AJvYcCXWWGR1e6w296tlPYS0FPqJcJ0b/0Vyww7cuvayFJOu4cWuOblEcSsGYVp8iIN/msJyix0X70k7M1yP6FAQeKrjmcbad8qaMBYV2p4o
X-Gm-Message-State: AOJu0YyKuAama2qlveEWWPO4iw1RHkEOKgjVFekFJT7j8ku3/Qdem0Qj
	HK+y8NMXT6MiO8cRtLXKecB677+Fp0/o620FlFNzmeI4YpOH86idLQ5Xifd5Eqo=
X-Google-Smtp-Source: AGHT+IG+TtGWysDfdlawCem0S3HMY9EM/WsGwW7MbhgDMk8j9ZqeCViVLQ5g4hfRsmjhInG+O7du1A==
X-Received: by 2002:a17:906:af79:b0:a58:8602:ffa1 with SMTP id os25-20020a170906af7900b00a588602ffa1mr351273ejb.19.1713870767677;
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Received: from [10.100.1.125] (ip.82.144.213.21.stat.volia.net. [82.144.213.21])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a5209dc79c1sm7006898eji.146.2024.04.23.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Message-ID: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
Date: Tue, 23 Apr 2024 14:12:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 13:53, linke li wrote:
> In br_fill_forward_path(), f->dst is checked not to be NULL, then
> immediately read using READ_ONCE and checked again. The first check is
> useless, so this patch aims to remove the redundant check of f->dst.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>   net/bridge/br_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 65cee0ad3c1b..ae33b30ff87c 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -405,7 +405,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
>   	br_vlan_fill_forward_path_pvid(br, ctx, path);
>   
>   	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
> -	if (!f || !f->dst)
> +	if (!f)
>   		return -1;
>   
>   	dst = READ_ONCE(f->dst);

This patch should target net-next (PATCH net-next in subject).
Other than that the patch seems fine.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


