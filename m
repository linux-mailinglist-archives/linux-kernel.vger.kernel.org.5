Return-Path: <linux-kernel+bounces-166427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B08B9A83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7322F1C20C25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC57E56B;
	Thu,  2 May 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bAB/Edq8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1E604B3
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651976; cv=none; b=Wsx/u+I4netkTzPVRd18aOSwKe+zN0QjQKnekiNZfiGWnxyLH/U4trjZS516QYeHbgzv0dYTbOMLHcDMXTHWoeEKbsT3zywUeirI1StTTfRcBynwevdDKxsyS/pArVkubxB08gCZ/gO9zTHtjJHYwAVOle4dwStHNr0JjwcPEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651976; c=relaxed/simple;
	bh=U0+9t/DUTI7wv+JhYa4+yvPwHRkQr5ZuSHZ6s20Plk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcO2l+ufy7/flf36ydGuZgPHmIy88o6RUFVyKCZDGk2pjzSH9xu54jUyboCxN738Eus6lR4PlRxoxSwipruEO3KUbg9gv8TeFNDe3JK0SIorWstfTqBGPYbZ0epxm1/z8O8lWQbW6DJqf1oM1e1hrIxWIUbp6Z883ty4fQUEyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bAB/Edq8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572babec735so298444a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714651974; x=1715256774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=672JpQGQxN2adDtGURkG6O93oWu5Ah9pxezBGrFTATk=;
        b=bAB/Edq82jw0GDpMTAoGjUX/tIU1rWtbBmRWpckZNd2ZUZdYo0opynVSn8aCykSQjp
         mbH6FOJs9mGQKRFdCc5cLn0OXcrpAZTy6OY91bJ0UL2XMkZaTLBR2/P9eMv2ihtQ56iF
         1cB6UA5/VnVTPrkHA+9Fx8J2SFEzrETV5f3lkdAA5uvYf3Cm5LXx7MJ2IJGnUk04c2tV
         u5Sl/ACh8p70Qky96Gohp2SvcHnMM2QaWBkG5a/+bmPRYeAD4HjmzkPoR86TnVybGT4O
         f6nctDOy+HX2L4rmBpA5rAwXWG/fxYqGeXIT1HbYDy8lwVqK4igdCEUQMCnJHwWTSXpo
         E06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651974; x=1715256774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=672JpQGQxN2adDtGURkG6O93oWu5Ah9pxezBGrFTATk=;
        b=k4lpuxpGEJTHGeN6q4IZxBUorMCKR+zHW49S6KYaeYj2xnG6HOsjC3GW1eCfIE0v5L
         cotYZMDJMtF0eHt8/xXtI/HvloakHvz1gwSBMGymCV2ePt6+/+ScjUO/FHzedj2mXcw8
         nbzId/dA55WojLERXE5AiIASJLJISOPCOsyaTQW2F1OQnEG5LBuW/oNNP5xtV783xBuj
         ReLkYcNTeL1R49WJd89JfnIH9n1wvQEWa8IXnl05yon7JVzIUH5VdUcDotNQgDepDrHO
         Q8KBMSiM89nXBma1foXV9DegqixUC418h8V5eBoTDKIv1Pqfrcjbm4da7RyzVNEWYbB6
         gDvw==
X-Forwarded-Encrypted: i=1; AJvYcCW61S4zuhrxSPe3RBkP5NqogWhEpkPKMNeEwMpwHNoQCXI9sIgUdLPq7FIwpL4KnZWV6XdYcNhranRt17Xe3XcogkTP6Szf2FjuGJOd
X-Gm-Message-State: AOJu0Yx5gwEdf+oug5ccmwCiM2d9i9zC9qBggQ0/7CMrw6meEp6xXTux
	c8YKZRRY5PmRAaGefP/a43pWNLvd6aOivN/aKM7x1tJmvaHHoC5fRmg92vLD64U=
X-Google-Smtp-Source: AGHT+IGBveCIDdwRLjqeRHzu8Xwq+nwSoG7CgDOi9YvahOmP7DijvF4W2bSeOpwFts4MR/jGuXktPw==
X-Received: by 2002:a50:d613:0:b0:572:a198:49ca with SMTP id x19-20020a50d613000000b00572a19849camr1953208edi.20.1714651973540;
        Thu, 02 May 2024 05:12:53 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id t17-20020a05640203d100b00572c15aba54sm465190edw.17.2024.05.02.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 05:12:53 -0700 (PDT)
Message-ID: <431e1af1-6043-4e3e-bc3b-5998ec366de7@blackwall.org>
Date: Thu, 2 May 2024 15:12:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
 <20240430012159.rmllu5s5gcdepjnc@skbuf>
 <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b90caf5f-fa1e-41e6-a7c2-5af042b0828e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2024 20:01, Joseph Huang wrote:
> On 4/29/2024 9:21 PM, Vladimir Oltean wrote:
>> On Mon, Apr 29, 2024 at 04:14:03PM -0400, Joseph Huang wrote:
>>> How about the following syntax? I think it satisfies all the "not breaking
>>> existing behavior" requirements (new option defaults to off, and missing
>>> user space netlink attributes does not change the existing behavior):
>>>
>>> mcast_flood off
>>>    all off
>>> mcast_flood off mcast_flood_rfc4541 off
>>>    all off
>>> mcast_flood off mcast_flood_rfc4541 on
>>>    224.0.0.X and ff02::1 on, the rest off
>>> mcast_flood on
>>>    all on
>>> mcast_flood on mcast_flood_rfc4541 off
>>>    all on (mcast_flood on overrides mcast_flood_rfc4541)
>>> mcast_flood on mcast_flood_rfc4541 on
>>>    all on
>>> mcast_flood_rfc4541 off
>>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>>> specified first)
>>> mcast_flood_rfc4541 on
>>>    invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
>>> specified first)
>>
>> A bridge port defaults to having BR_MCAST_FLOOD set - see new_nbp().
>> Netlink attributes are only there to _change_ the state of properties in
>> the kernel. They don't need to be specified by user space if there's
>> nothing to be changed. "Only valid if another netlink attribute comes
>> first" makes no sense. You can alter 2 bridge port flags as part of the
>> same netlink message, or as part of different netlink messages (sent
>> over sockets of other processes).
>>
>>>
>>> Think of mcast_flood_rfc4541 like a pet door if you will.
>>
>> Ultimately, as far as I see it, both the OR-based and the AND-based UAPI
>> addition could be made to work in a way that's perhaps similarly backwards
>> compatible. It needs to be worked out with the bridge maintainers. Given
>> that I'm not doing great with my spare time, I will take a back seat on
>> that.
> 
> Nik, do you have any objection to the following proposal?
> 
> mcast_flood ->          default/    off         on
> (existing flag)         missing     (specified/ (specified/
>                         (on)        nlmsg)      nlmsg)
> 
> mcast_flood_rfc4541
> (proposed new flag)
>      |
>      v
> default/                flood all   no flood    flood all
> missing
> (off)
> 
> off                     flood all   no flood    flood all
> (specified/nlmsg)
> 
> on                      flood all   flood 4541  flood all
> (specified/nlmsg)                   ^^^^^^^^^^
>                                     only behavior change
> 
> 
> Basically the attributes are OR'ed together to form the final flooding decision.
> 
> 

Looks good to me. Please make use of the boolopt uapi to avoid adding new
nl attributes.

Thanks,
 Nik



