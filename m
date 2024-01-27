Return-Path: <linux-kernel+bounces-41373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476CC83EFC2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE0FB2290B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE72E647;
	Sat, 27 Jan 2024 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1gf57pjy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9432EAF9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383951; cv=none; b=Wj2Zbc56ID9SNZTJia3kfbJ2QkIXcHN/eEYFd92SaghmX4hRw6N7cd6HoLRO/NiwVNUWh+2cdF0dF2hvtw83eJDRZIVBvr62An2N3ZnM6STCDdchYK7xGMFJbF6eM1pkgdNGTEjN4bgNqwTN20hNjAaATKsvo7BbrXerz8EX/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383951; c=relaxed/simple;
	bh=OFosktua+nK1lqL1BScwNQWTYhvw0nvKXrNIUt/Ki8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBvB7xTggv6X0zP7MKtn5NmUkTi8PlGACkbrYGMxiPU8VVz1JgRQOzsaZR4h5p4z6PfQGd+8g2ufu0pcloiPZ7WM9AO1FxJPfDAS8YtEgrJ40Jl0yCx/3LAps2aqRLjkvqeY1YuMWKQe0nhoKeb5u7szOz6wHcnYFLIzvq6GWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1gf57pjy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef0643722so4143195e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706383947; x=1706988747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=1gf57pjy7tEUx1Chg08s81C4tQa2d+Rro1DSGA9fitH4uYeb7fZZh2d/nnFMRL07As
         W/9HsVT8/ngJNKtnLmmx/0BLgqljmzTKFPToVEe2gMXI5Jgi/2AMpMH7uFVKNgUmD3aV
         MDcEk6/F2XoSMDfvbwCmm5JqEEm3lKfl3IzB59HEaLhFufnK4+6F+n8kQQ0VW6377HYz
         VAiwVSiPozRIExjW+xFO/k6YOcDIq7eBjLm6xG/3jnE9zvOtIjRW5bgtTJvQG5ChV0h3
         6yVql69ze5ipRydSah9ZukK5VHxYAAJcj0hUWzpi5Qf5I7X6FD6aOnFi8JVlis7Ce3t3
         N4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706383947; x=1706988747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=ZydCGCAfEsrgbKDlwoH3AaQDK66rb95We8BN9U5kA28yOdxcz/xI5akCPeAgs7t7ya
         uieaVnNp+07KQYAk8u3SIthBP/e56MhtlPqVDqwOxcBX3dk3BezQJ5BRDkVc/wfhN8sE
         2MmU4/6MYwPJyKejONRkRfsKJ4maTvDl+9u83o8InW0briqedpBUxMlBEPdAjnAIVABT
         R3PMJPTm48+Wf/CgVBP4bgIq1NdIOEwPWl8xMCwV+gOthkdiJmLZlHBXxIm/JI3OyM6h
         loBdS0Sew3f0XtfNnGcyy3qGb1QPKdQG73nrUxEsIHYFUWdCB8TvrSYOP0GWXeUoweMf
         9UwA==
X-Gm-Message-State: AOJu0Yx/0pGJ5reWgxvw2sWFa0QROUGx7ZQJlElDmkntJ/1LM/wDnhRx
	T8RYLb/8ph+PgnuSGKf2H+Pwj5tcFHZZtcAogdAv+B3LaeE+Hehnu8W/IznRgEA=
X-Google-Smtp-Source: AGHT+IFIburJoW4BFrmc+K2ya7vO19XpEC4+2WG74/eThfZcJLQyym2s9GswrAXPsaEejM+mq4MJwg==
X-Received: by 2002:a05:600c:3493:b0:40e:ef00:af57 with SMTP id a19-20020a05600c349300b0040eef00af57mr1308153wmq.36.1706383947218;
        Sat, 27 Jan 2024 11:32:27 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c348b00b0040eef2aed28sm1999515wmq.23.2024.01.27.11.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 11:32:26 -0800 (PST)
Message-ID: <43a266e9-7cde-472a-9846-c16756be8c09@blackwall.org>
Date: Sat, 27 Jan 2024 21:32:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bridge: mcast: fix disabled snooping after long
 uptime
Content-Language: en-US
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240127175033.9640-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240127175033.9640-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/01/2024 19:50, Linus Lüssing wrote:
> The original idea of the delay_time check was to not apply multicast
> snooping too early when an MLD querier appears. And to instead wait at
> least for MLD reports to arrive before switching from flooding to group
> based, MLD snooped forwarding, to avoid temporary packet loss.
> 
> However in a batman-adv mesh network it was noticed that after 248 days of
> uptime 32bit MIPS based devices would start to signal that they had
> stopped applying multicast snooping due to missing queriers - even though
> they were the elected querier and still sending MLD queries themselves.
> 
> While time_is_before_jiffies() generally is safe against jiffies
> wrap-arounds, like the code comments in jiffies.h explain, it won't
> be able to track a difference larger than ULONG_MAX/2. With a 32bit
> large jiffies and one jiffies tick every 10ms (CONFIG_HZ=100) on these MIPS
> devices running OpenWrt this would result in a difference larger than
> ULONG_MAX/2 after 248 (= 2^32/100/60/60/24/2) days and
> time_is_before_jiffies() would then start to return false instead of
> true. Leading to multicast snooping not being applied to multicast
> packets anymore.
> 
> Fix this issue by using a proper timer_list object which won't have this
> ULONG_MAX/2 difference limitation.
> 
> Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
> Changelog v2:
> * removed "inline" from br_multicast_query_delay_expired()
> 
>  net/bridge/br_multicast.c | 20 +++++++++++++++-----
>  net/bridge/br_private.h   |  4 ++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


