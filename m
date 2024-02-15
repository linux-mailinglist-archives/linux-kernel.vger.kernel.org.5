Return-Path: <linux-kernel+bounces-66863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019548562BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262EA1C226FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3F12BF1E;
	Thu, 15 Feb 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="oiYv1KhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQF7E91Y"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92B12BEA6;
	Thu, 15 Feb 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999085; cv=none; b=cPoQt2XinWYyNF9l4EWf6cpzlYIlD6OtDwGonjgJEtykqFffz33rPENjAownQ4tjvkCG+DyoDnrPtLmNGaEV1tl0LFYDqs55XeqfVfSngS6lAgA2ECcrLX87Ph0OL1Maagt4gB77a/Z9Nr+VAV9UOLHlnz6nzQtSb85D4o/4bKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999085; c=relaxed/simple;
	bh=B9coxTR34G9S5wt1MlXuYGtAfSkjGgIF3CYmaIXdyHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzUS8zWf51fd8im066jjV8pmCAe/V4E7bXbMVWBYNop42eTbvPjRoKnPoSbW1b/woq3S0gcFMDBM01LZ9NoPwqo9KioNfiVfbDGkDQ5Gfah/EWXS98ApjMnCZuRLF5NT5RH0nfgWPDaF2L81wLM4/YUuVF1HKGu3odBi5wZzrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=oiYv1KhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQF7E91Y; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3258B5C0098;
	Thu, 15 Feb 2024 07:11:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 07:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707999081;
	 x=1708085481; bh=p2UamaqXBXvUpQwr3HNRfbWJwi3dY+qN7AALQra+c3w=; b=
	oiYv1KhDBIeVCZaXSwSZZB7OvHK6Qu07FrN35RfPyXBo+NB3dkN6+u+Om9Oq3Jn5
	TdCBwb6USnBqjEUdrSKusY2khT6mYn0RUsDOL+JBFZA3k8ejscKq0mh/P2fu6ict
	BYrGWcKngzzOt/HBwv7IGityeozqdEnFUf7h0zXFeAvdhq8mHN4kDfNVhmDIxQmF
	ATFoC9KBn1iQCicEKldIIHxQAOp+kEEwDtgYT5ihSmNokQAwOYKZAywc0UFrKG2D
	AgobPRW0jKvlJTSDHeMjWd/bb0bHi7OaSmU0kI5n1p0YICCj/Xrwg/nhaZv4aaJe
	3FKDlWvmH7wcu+YZgYAjjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1707999081; x=
	1708085481; bh=p2UamaqXBXvUpQwr3HNRfbWJwi3dY+qN7AALQra+c3w=; b=C
	QF7E91YM+mIf76zRjJlnjZxt3YRF0xvBcOg8HNcYnz/1CUvkszAmO4iKKFRkdPae
	TOMFUq52X2FLRZ8kWOmmx8yfvoXsq2XKbI390sOM681uTGdVjVFLkibLjRktGqdg
	ROuNWLOsnWRmjvjAJrAv+lpwDzzfcoP9pS1U1T+vkJAJRh7fyKWY5FqKHJJDmX7M
	WX4VXD+gpB1SC8IYvPsXqDyNsDTU2dKsJimY0f3ySnXLDQhWCZV/ZHdRbx/6i234
	5b4BFcZDYd6Zr1X642NmM3+8EIM85NiTYDHllbUho3uDfunmmMktMVK9Sl2a+J4M
	ZzpeEqdMMAvM1NI0rgWLQ==
X-ME-Sender: <xms:aP_NZdeC7zAFYHPDrLuMSEGDbit4WhvjPM39VsEgriOGKbD9fl04Nw>
    <xme:aP_NZbP7sV39YDVBUebguPXyJEDDmjHqWkHXnfubh-21eCQwF1UbT52oNmNs1SnCT
    T1z2x90ZCBhUf-qGNU>
X-ME-Received: <xmr:aP_NZWhVTwfSn5LkQhkng2xTd3pS0e7tfjaM3FodOcHYYF8rYwfJdWGL2-QtoKk7WFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgrfhgr
    vghluceuvghimhhsuceorhgrfhgrvghlsegsvghimhhsrdhmvgeqnecuggftrfgrthhtvg
    hrnhepjeeijedvleegudevjeegledtveeifeetjeelieeijeegiefhleelhedtgeduieei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfh
    grvghlsegsvghimhhsrdhmvg
X-ME-Proxy: <xmx:aP_NZW85RpQFlSbNPy_6_JypuPopjFH3Z_bUXVsoEUYpdV7XKNbvTA>
    <xmx:aP_NZZvyF6qkrDPmjulVYFRBUYdQxhUvC3-kpUMBTuk86YrIl0hOGw>
    <xmx:aP_NZVEq9IFHdrV9dP9uBisGlfQqyyK-sosqyk44Psfbf1FDFjUxPQ>
    <xmx:af_NZXWf-kEg7psXBTIwrUsV13EnCp9M_91ONwFQIYtBAqSNAETnoQ>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 07:11:19 -0500 (EST)
Message-ID: <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
Date: Thu, 15 Feb 2024 09:11:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Content-Language: pt-BR
To: David Lin <yu-hao.lin@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 23:07, David Lin wrote:
>> From: Francesco Dolcini <francesco@dolcini.it>
>> Sent: Thursday, February 8, 2024 3:25 PM
>> To: Rafael Beims <rafael@beims.me>
>> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
>> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
>> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
>> mlme
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
>>> On 30/01/2024 04:19, David Lin wrote:
>>>>> From: Rafael Beims <rafael@beims.me> On 22/12/2023 00:21, David
>>>>> Lin wrote:
>>>>>> This series add host based MLME support to the mwifiex driver,
>>>>>> this enables WPA3 support in both client and AP mode.
>>>>>> To enable WPA3, a firmware with corresponding V2 Key API support
>>>>>> is required.
>>>>>> The feature is currently only enabled on NXP IW416 (SD8978), and
>>>>>> it was internally validated by the NXP QA team. Other NXP Wi-Fi
>>>>>> chips supported in current mwifiex are not affected by this change.
>> ...
>>
>>>>>> David Lin (2):
>>>>>>      wifi: mwifiex: add host mlme for client mode
>>>>>>      wifi: mwifiex: add host mlme for AP mode
>> ...
>>
>>>>> I applied the two commits of this series on top of v6.7 but
>>>>> unfortunately the AP is failing to start with the patches. I get
>>>>> this output from "hostapd -d" (running on a Verdin AM62 with IW416):
>>>>>
>>>>> nl80211: kernel reports: Match already configured
>>>>> nl80211: Register frame command failed (type=176): ret=-114
>>>>> (Operation already in progress)
>>>>> nl80211: Register frame match - hexdump(len=0): [NULL]
>>>>>
>>>>> If I run the same hostapd on v6.7 without the patches, the AP is
>>>>> started with no issues.
>>>>>
>>>>> Is there anything else that should be done in order to test this?
>>>>>
>>>>>
>>>> I applied patch v8 (mbox from patch work) to Linux stable repository (tag
>> v6.7.2).
>>>> Both client and AP mode can work with and without WPA3.
>>>>
>>> I went back and executed the tests again. I re-applied the pach on top
>>> of tag v6.7.2 to make sure we're seeing exactly the same thing.
>>>
>>> At first, the behavior I was seeing was exactly the same I reported before.
>>> Upon starting hostapd with our basic example configuration, it would
>>> fail to start the AP with the error:
>>>
>>> nl80211: kernel reports: Match already configured
>>> nl80211: Could not configure driver mode
>>>
>>> After some investigation of what could cause this error, I found out
>>> that it was connman that was interfering with this somehow. After
>>> killing the connman service, the AP would start correctly.
>>>
>>> I want to point out that this behavior is different from the unpatched
>>> driver. With that one we don't need to kill connman in order to start
>>> the AP with hostapd.
>> Any idea what's going on in this regard? Is such a change in behavior expected?
>>
>> Francesco
> When I tried to test v6.7.2+ (with patch v8) on NB + SDIO IW416, it needs to issue "sudo systemctl stop NetworkManager" in order to test AP mode.

The issue I reported is that the kernel with the patch is behaving 
differently when compared to the kernel without the patch. I kept all 
the test conditions the same, just replacing the kernel. It seems that 
you can reproduce this on your end using NetworkManager.

This is a change in behavior on userspace that's not currently explained.

> For i.MX + SDIO IW416, it needs to install following two files for client and AP mode to "/lib/systemd/network" for systemd-networkd:
>
> <<Client mode: 80-wifi-station.network>>
>
> [Match]
> Type=wlan
> WLANInterfaceType=station
>
> [Network]
> DHCP=yes
>
> <<AP mode: 80-wifi-ap.network>>
>
> [Match]
> Type=wlan
> WLANInterfaceType=ap
>
> [Network]
> Address=192.168.100.1/24
> DHCPServer=yes
>
> [DHCPServer]
> PoolOffset=100
> PoolSize=20
>
> I think this is not related to driver.
>
> David

I didn't really understand what systemd-networkd has to do with anything 
being discussed here. We could use it to create an AP, but that's not 
the test I did. In my case I used hostapd directly.


Rafael


