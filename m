Return-Path: <linux-kernel+bounces-128523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3917895C02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D92826D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4F915B571;
	Tue,  2 Apr 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xJYhnlJD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89E15B54B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083857; cv=none; b=IG7sriOtbCSNkPWjkoA7uhAvKk70rGM1taJgnTxDZBbIKKwhqcEhtIM1mY+eWoFiPzy61fLAEqZh65RSHRregj1rYc2Fdo2T7n3Mj1RVQuxL7gWeKJjsvEamNtXpb9Pgv07yE8XFrgnbblwFZKuiJwJk0AXrl4RXF0MYqclRaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083857; c=relaxed/simple;
	bh=vHE3t0v0uJDbSjef7CvRAdHduwYUH2/WlskUw+Mt/ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSjkLwllNlGEnYiHHqsxcF0jH81B6JShsl45B+8ArQxHC4ZAC6B1zCQNviFzgRMIO6e5JlJWjvmBySkp9OKxrQJkRxbtcG5YYZH85w8seNQj9ad/iolCrvDSbHay14UA6M8vc9HqrzrdRORRFS+1Y+xTyMGwG9G9N1z5k82GsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xJYhnlJD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4161bd0a4ecso7205365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712083854; x=1712688654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIEcfz25WWX1hRcC//+GqxXzgFgNZ4EfTxo56dpiUx4=;
        b=xJYhnlJDeDWcKbQ9VzQGWG0xFWJY6GN0P+fZmF3irpcmVqxQd9lHvbQn+/FTpXPc5f
         GmQLIuTQfLg7oEyFM/OJwTciw+/0DOQE751QlKexzQ7ueYQOA8Glc/s7+OFChUjE2Zvl
         CGkOoRIgPkhNnjoJcYRQMkyYjtW6woULPWFa/1nmT+DzAdasjgaYgC7CcceZm9VKP5Z4
         c1CHDgeSpfHMuM+3v/5HLHwVFqLwSx/oIduyHAe6gnHQDNPpnzpynGhlrikVxyTGhuC4
         AwQsaq1o18LNa0f6d0cbMcl7EEdEbOwn1+E0LnZjC7OtUXi6EueLOUhB3NGS7C2oV6t7
         o2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083854; x=1712688654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIEcfz25WWX1hRcC//+GqxXzgFgNZ4EfTxo56dpiUx4=;
        b=C5F5cYfxpcTpJueHgAZB2iJer+BLSbY6iGeBUKXRPwC05kIEx+sfvV+VEDPGaCBeBb
         whSX01xFemHDDXe0q6FkiwpHhzplWlTdYprjy933QBmqxUMzK1HeLLqlvx+QxlUDK28t
         vIuwYWMJrYhofB+MBLFSGapg8iLjx7a+6bU3vqQVH05nx9X+VhiZnt0U61AIjIey+f1l
         wTUjj1Rnb6YAW6Ltdt+XmbzLmDb4yat3aBCs9d4C9+eKWT2XM5yPUx3gr/gw9MOvPiPA
         nNbocHoEprhoOtP/qVRfFyPBrN2CcHaqsqrG8pVMXPpnrAwj0n3gDY1TkdLVb/bMrWLn
         W9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpC2tuXdb8qMRCuB4mriGS6ycysxJBFhqbMokcYNbAtIv6+vNTMGA7pwvrqyPkDd8ThsPkJXujhrW1ay+dwaPVme5GPFrBZpu7LkmC
X-Gm-Message-State: AOJu0Yw0cNHRdc/TjLF3sdW3f0S/AHj9rEOQSKwKdeRUKzXR7cLj//1d
	1POSdR++kcfH87ejnBNXQ9d1sXf3dwNQN7vRW2aR1+Lnc9g7Kv1De4Mm6ljY0Ak=
X-Google-Smtp-Source: AGHT+IHG2reakJAyifG34eCuPd2NY3AzmwK7mxJCbjBZSYQSbzpq8u6Qjn1bt7FV9hXw5WZDvMX8ZQ==
X-Received: by 2002:a05:600c:3393:b0:414:9463:d4c3 with SMTP id o19-20020a05600c339300b004149463d4c3mr504116wmp.0.1712083853740;
        Tue, 02 Apr 2024 11:50:53 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0041488978873sm22171138wmo.44.2024.04.02.11.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 11:50:53 -0700 (PDT)
Message-ID: <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
Date: Tue, 2 Apr 2024 21:50:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240402174348.wosc37adyub5o7xu@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 20:43, Vladimir Oltean wrote:
> Hi Nikolai,
> 
> On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
>> For the bridge patches:
>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>
>> You cannot break the multicast flood flag to add support for a custom
>> use-case. This is unacceptable. The current bridge behaviour is correct
>> your patch 02 doesn't fix anything, you should configure the bridge
>> properly to avoid all those problems, not break protocols.
>>
>> Your special use case can easily be solved by a user-space helper or
>> eBPF and nftables. You can set the mcast flood flag and bypass the
>> bridge for these packets. I basically said the same in 2021, if this is
>> going to be in the bridge it should be hidden behind an option that is
>> default off. But in my opinion adding an option to solve such special
>> cases is undesirable, they can be easily solved with what's currently
>> available.
> 
> I appreciate your time is limited, but could you please translate your
> suggestion, and detail your proposed alternative a bit, for those of us
> who are not very familiar with IP multicast snooping?
> 

My suggestion is not related to snooping really, but to the goal of
patches 01-03. The bridge patches in this set are trying to forward
traffic that is not supposed to be forwarded with the proposed
configuration, so that can be done by a user-space helper that installs
rules to bypass the bridge specifically for those packets while
monitoring the bridge state to implement a policy and manage these rules
in order to keep snooping working.

> Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
> that break snooping? And then do what with the packets, forward them in
> another software layer than the bridge?
> 

The ones that are not supposed to be forwarded in the proposed config
and are needed for this use case (control traffic and link-local). 
Obviously to have proper snooping you'd need to manage these bypass
rules and use them only while needed.

> I also don't quite understand the suggestion of turning on mcast flooding:
> isn't Joseph saying that he wants it off for the unregistered multicast
> data traffic?

Ah my bad, I meant to turn off flooding and bypass the bridge for those
packets and ports while necessary, under necessary can be any policy
that the user-space helper wants to implement.

In any case, if this is going to be yet another kernel solution then it
must be a new option that is default off, and doesn't break current 
mcast flood flag behaviour.

In general my opinion is that the whole snooping control must be in
user-space and only have the dataplane in the kernel, but that is beyond
the scope of this set.


