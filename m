Return-Path: <linux-kernel+bounces-110320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D3885D25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA10281836
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EB12C551;
	Thu, 21 Mar 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAeSEQ0r"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C476052;
	Thu, 21 Mar 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037635; cv=none; b=Xn+ZXBXyMrNxR01ykdQ+PCb+/5erdtIBojLiFPrxKb5miXejetgestPaPtJNLrSDnEG2N3gQhRZ4JXZc5W8jhq6dVN1wVB5AzBylRW96I/wxHO2jqxNcNHln63S+e+VYPRsblbQdJQ1wVDtVHs5nBg/wIegekADqXOW9msjxZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037635; c=relaxed/simple;
	bh=oASwL/PgwUD/4abxd0/ORGbj3E5k4hjmJ3AEMCvTDoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8RNAdKE4+koooqBEOOD2A4oXKhkjCoPIIKpMl/pGnhfbu6MnPHq2PWRuxvN88gm/mZjAr51xIdgd0+UGoi549U6RZRu//EEPP4Z0E9pj4hXvrxkIPReFR5o7jzhopmPJAA6O7pdYUskeh97548baxcGGktL5N+uMl5eaaDBwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAeSEQ0r; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def142ae7bso10341455ad.3;
        Thu, 21 Mar 2024 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711037633; x=1711642433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GW64LuAsGL+unoYbPHIchcWLAmK0GoNFhelOtjVluTk=;
        b=MAeSEQ0r2UkvFwFZcw+csnMJmHGv87DJUwZfJAaHtWebiC8R8PgI+xNGNrJ6tOwsbG
         nCiXGv/6CRZFHUXIllK4mUuUQbarIYwVJ/AJc3Y0+WOYekc+M7Rm7o8unPAMO/VAyx3O
         zQj/J3f9S+m+/xt7qXAM6bD/7N/sudtMtoR6PtVrckPWP3iGkMQLZulGd/VBuJLnaUZB
         X95Wdbh8237xuu1BvUU8izX6WhjnCEOWnidKaDOBqwVZIcpRGFxWnzZhF+LTJx+a45qM
         kIpxTz95ERMHU1BDrPHTMVDw0cUpM7fxhC+VPeNd+XY6l+OqXgmD5yr0e+xQ4bBLijbR
         qjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037633; x=1711642433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW64LuAsGL+unoYbPHIchcWLAmK0GoNFhelOtjVluTk=;
        b=sdTlxkHmfJrYz+1fEULv7W/U8R3sUk7i8SEKnuao5hjMaJmcyfcNb03lvpKjcjL0C8
         Mz4xMfd/fGp7UmDblLSBT+iXsqs0Rjwv5rThVdt7TQLL4l49+eAEz2vN/Q/SyiSpbva6
         GcM3XQoRZPH7NfZZtnsN5i5BXRjhLl8BWqN7WA2rDpXF/vlTNHysWIlO6GvnIgfriCOA
         wuu+d9oyPMLl5NgtClLg8CxbUFMJoohXWc7ZDnF3SNIIar4a+OEfEHQ0HbBKd3QzhVHE
         CFgcqXrVX025BoQneKlsFpp6Jr0c1vMbzVOplbB3DOJo3CbvwfACEs3nDciZKbQNJG95
         K/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9R1GzOv0XUlfSTDhQC5SQHZc4gyacG+0XjLkrpVyyH16Norfv0jcXXnVeuBxgRFg1/RAqPIfGKMYw/jxGgsM/ro4/Yt38PxEVADcI8tEg08nrnQI5A3ChqW32bi9AnlVk/4ne
X-Gm-Message-State: AOJu0Yz9Jq0mqYLh4xeDEHCSkFmP0tnqDL0k2E4JH/AqWE3n25Jqlv5p
	sZxH57AHnbufOdowa+AQEmH2VBDItqIMvZEbB6lqo2dvip/Jc3u2
X-Google-Smtp-Source: AGHT+IFhm9HMJpCT0iz48M7y31D98OBXpFlctUp0rBnzVwB3HEAY37Oe7XeXCXw+di0JpB6m9uxQ5A==
X-Received: by 2002:a17:902:d489:b0:1e0:342b:af6f with SMTP id c9-20020a170902d48900b001e0342baf6fmr13029588plg.16.1711037633024;
        Thu, 21 Mar 2024 09:13:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k15-20020a170902c40f00b001defa82b994sm12772580plk.123.2024.03.21.09.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 09:13:52 -0700 (PDT)
Message-ID: <27453913-d4a3-4535-8cf5-2f5f3eb6c7b7@gmail.com>
Date: Thu, 21 Mar 2024 09:13:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Content-Language: en-US
To: John Ernberg <john.ernberg@actia.se>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
 <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
 <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
 <ZfsUvm9YC5O7il3h@shell.armlinux.org.uk>
 <7f0e5f8b-fb85-4f2b-8d77-4170366a1b55@gmail.com>
 <Zfs8hWo/aVbvuAgm@shell.armlinux.org.uk>
 <efffa6e6-f519-4424-8d58-0951e7c68f27@actia.se>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <efffa6e6-f519-4424-8d58-0951e7c68f27@actia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 09:02, John Ernberg wrote:
> Hi Russell,
> 
> On 3/20/24 20:44, Russell King (Oracle) wrote:
>> On Wed, Mar 20, 2024 at 10:13:55AM -0700, Florian Fainelli wrote:
>>>
>>>
>>> On 3/20/2024 9:54 AM, Russell King (Oracle) wrote:
>>>> On Wed, Mar 20, 2024 at 03:25:54PM +0000, John Ernberg wrote:
>>>>> Hi Russel,
>>>>
>>>> Growl. Hi Peter.
>>>>
>>>>> What we really want is the PHY to be suspended on suspend to RAM
>>>>> regardless of us having had an initial link up or not.
>>>>
>>>> So what you're asking is for the PHY to be suspended when the system
>>>> is entering suspend, which is a long time after the system booted and
>>>> thus phy_probe() was called, and could be some time before the system
>>>> resumes.
>>>>
>>>> I'm not sure what the relevance is of phy_probe() that was brought up
>>>> previously then.
>>>>
>>>>> This worked prior to 4c0d2e96ba05 ("net: phy: consider that suspend2ram
>>>>> may cut
>>>>> off PHY power") which was added in Linux 5.11, and 557d5dc83f68 ("net:
>>>>> fec: use
>>>>> mac-managed PHY PM") which was added in Linux 5.12.
>>>>
>>>> Looking at the former commit, that looks to me like it is only
>>>> affecting the resume paths, not the suspend paths, so wouldn't have
>>>> any impact itself on what happens when suspend happens.
>>>>
>>>> The latter commit states that it is a work around for an issue with a
>>>> particular PHY. What happens if you revert just this commit, does your
>>>> problem then go away?
> 
> Our PHY does not begin working again without reverting both. phy_init_hw()
> will remain an issue if it occurs after phy_start().
> 
> The commit message in 557d5dc83f68 is not explaining nearly enough, I
> spent a
> few days on it before I proved that commit to be nearly correct (See whole
> thread at [1]), it happened to just explode with that PHY. The issue is a
> sequencing issue that was made more prominent by 4c0d2e96ba05, but it
> existed
> since around 2008. Because FEC is both MDIO controller and MAC, meaning the
> resume of the link in a link up case runs phy_start() in the FEC resume
> function, which will trigger a mdio bus resume when it completes, in turn
> calling phy_init_hw() (before 4c0d2e96ba05 it was phy_resume() which
> wasn't a
> problem but still wrong sequence wise).
> 
>>>>
>>>> Also, please clarify. It seems that you are reporting a regression -
>>>> it used to work for you prior to 557d5dc83f68, but 557d5dc83f68 stops
>>>> it working for you?
>>>>
>>>>> Since FEC requires mac_managed_pm the generic PM suspend-resume paths
>>>>> are not
>>>>> taken. The resume sequencing with generic PM has been broken with the
>>>>> FEC since
>>>>> generic PM of the mdio bus was added, as the FEC will do phy_start()
>>>>> (via FEC
>>>>> resume) and then generic PM runs phy_init_hw() via mdio bus resume
>>>>> (previously:
>>>>> less damaging phy_resume()) due to how the FEC IP block works.
>>>>
>>>> That suggests that even with 557d5dc83f68 reverted, it's broken.
>>>> Digging into the history, what you're referring to dates from January
>>>> 2016, so are you reporting a regression that occured 8 _years_ ago,
>>>> at which point I'd question why it's taken 8 years.
> 
> A revert of those is absolutely wrong. Those commits are fixing bigger
> issues.
> 
>>>>
>>>> Given the time that has passed, I don't think reverting commits is
>>>> a sane approach. Quite what the right solution is though, I'm not
>>>> sure.
>>>>
>>>>    From the description and the commits pointed to, I just don't see
>>>> that there is anything that could've changed with respect to the first
>>>> boot - if that has changed, then I think more research into what caused
>>>> it is needed.
>>>>
>>>> If it's the subsequent state after a suspend-resume cycle, then yes,
>>>> I would agree that its possible that these changes broke this for you.
>>>> Would clearing ndev->phydev->mac_managed_pm just before
>>>> phy_disconnect() in fec_enet_close() fix it for you, so the suspend/
>>>> resume paths for the PHY get used when the network interface is down?
>>>>
>>>> Maybe, however, that's something that should happen in any case inside
>>>> phylib on phy_disconnect() as a matter of course, since the PHY will
>>>> at that point be no longer under the control of the network driver for
>>>> PM purposes. Could you give this idea a try please?
>>>>
>>>
>>> On phy_disconnect() we will do a phy_detach() which calls phy_suspend().
>>> Given that phy_disconnect() is called from fec_enet_close(), we still have a
>>> MDIO bus registered and we are not trying to suspend the MDIO bus, so we
>>> should have an effective phy_suspend() call here, what am I missing?
>>
>> I didn't look there, but if that is the case, then what is John's
>> problem - I can't figure it out, something isn't adding up here.
>>
> 
> I could instead add extra phy_suspend() in the suspend path if the link is
> down and the FEC is up and running. I rejected it originally thinking it was
> a much dirtier fix, but maybe that is the more correct thing to do?

This does not seem like the proper solution, the only time where an 
explicit phy_suspend() should be done in the Ethernet MAC's ->suspend() 
routine is if the network device was brought up at the time 
(netif_runninng() returns true) *and* you set mac_managed_pm = true 
because you must precisely control the order in which the MAC and the 
PHY get suspended with respect to each other (typically because the PHY 
supplies a RX clock back to the MAC, and some of the MAC logic depends 
upon it to operate properly, e.g.: perform a proper FIFO flush etc.).

 From there, I see two distinct cases:

- the network device driver probed, but the network device was never 
brought up in the first place in that case, I do not see a path whereby 
the PHY would have been suspended, unless the boot firmware already took 
care of that (which arguably it should if you are trying to be as power 
efficient as possible), although arguably there could be a path within 
the kernel where this is also done. It could get really complicated however

- the network device driver probed, and the network device was brought 
up at least once (regardless of whether a link state was detected or 
not), such that the PHY has gone through a phy_start()/phy_stop() cycle, 
and upon phy_stop() a phy_suspend() has been called

It is safe to assume you fall in the first case only, or do you also see 
a problem in the second case as well?

If the first case, I am a bit torn as to how to best go about it. The 
initial state of the PHY upon kernel boot can be a tad difficult to work 
with:

- some people want to conserve power as much as possible (like you, like 
me) and would not mind seeing a link break to achieve that state, nor do 
they mind a partial or full reconfiguration of the PHY by its driver

- some people want to avoid a link break and just inherit the existing 
operational mode of the PHY such that they can have a working link as 
quickly as possible
-- 
Florian


