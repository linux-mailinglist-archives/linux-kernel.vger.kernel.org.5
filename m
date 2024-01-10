Return-Path: <linux-kernel+bounces-21788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C05829448
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE50928942E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834039FC9;
	Wed, 10 Jan 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="T5qJ7b4x"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5C3A8CB;
	Wed, 10 Jan 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 203EFC0005;
	Wed, 10 Jan 2024 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704871623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FlQC5Q2ET2tc73S8vRew9D2w/9C51b4ONdPMKoY6Y=;
	b=T5qJ7b4xaA0GBYZYKmmBMQKQm9GhK5NqUzyB+rLGNLIeULaidw/I5/MEhJVsdwAAGmNJRz
	zzqorDR0yLw4ihEE+TL5uwC7cOAgwx3E53ERubOLFzmdBoQMbBgLfreaXTIKgoA26NChsG
	+QLDoHl0qkRTAdOskGqKY+qVf+aGId/cMXu2gnJAgP1/D5XH6782V5ZmyiFx2hRq57iRRs
	FAmZ2PdvdGIKBokpN+jYpGF4Zyf5Rchd5F6as+3sbWz4lT1Mpx38udHAUSaNI1TkW4iY8e
	UCcI47FhTkyGU53/+pFPLIaqPrpXfhZim+0Ad36Irl2RmE1xQP3PsaXBhsX7pQ==
Message-ID: <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>
Date: Wed, 10 Jan 2024 10:26:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman
 <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
 <20240109145740.3vbtkuowiwedz5hx@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240109145740.3vbtkuowiwedz5hx@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 9.01.2024 17:57, Vladimir Oltean wrote:
> Yes, well _now_ it is a false positive, probably because smatch cannot
> determine that when priv->p5_intf_sel has been set to P5_INTF_SEL_PHY_P0
> or P5_INTF_SEL_PHY_P4, "interface" should have been also initialized.
> But it doesn't matter, you can ignore a false positive. I'm also seeing it.
> Although you should check whether treating -ENODEV as a hard error is fine
> and won't cause regressions.
> 
>> Just so you know, I intend to remove this whole PHY muxing feature once I
>> bring changing DSA conduit support to this subdriver. I've got two strong
>> reasons for this.
>> - Changing the DSA conduit achieves the same result with the only overhead
>>    being the DSA header included on every frame.
>>
>> - There can't be proper dt-bindings for it as the nature of the feature
>>    shows that it represents an optional way to operate the hardware, it does
>>    not represent a hardware design. Overall, the implementation is a hack to
>>    make it work for specific hardware (switch must be connected to gmac1 of
>>    a MediaTek SoC, no PHY must be present at address 0 or 4 on the MDIO bus
>>    of the SoC. It should rather be configurable on userspace. Which will
>>    never happen as it is specific to this switch and the changing DSA
>>    conduit feature is the perfect substitute for this.
> 
> Is PHY muxing a "true" switch bypass, or is it just a route through the
> switch for all packets coming from GMAC5 to go to phy0 or phy4? If the
> latter, I agree that dynamic conduit changing is a more flexible option,
> not to mention the user space tooling is already there.

It's the latter, and that's exactly what I think.

> 
> Are there existing systems that use PHY muxing? The possible problem I
> see is breaking those boards which have a phy-handle on gmac5, if the
> mt7530 driver is no longer going to modify its HWTRAP register.

Ah see, for PHY muxing, the driver actually wants the phy-handle to be put
on the SoC MAC, and the PHY to be defined on the SoC ethernet's MDIO bus.
We don't even define gmac5 as a port on the switch dt-bindings.

While none of the DTs on the Linux repository utilise this, some of the
mt7621 DTs on OpenWrt do. The change in behaviour will only be that phy0/4
will be inaccessible from the SoC MAC's network interface. I de-facto
maintain the mt7621 device tree source files there. I intend to revert it
along with adding port 5 as a CPU port so that the conduit changing feature
becomes available.

> 
>>
>> Let me know if you've got any suggestions that can get rid of the warning
>> without reworking the whole code block. Otherwise, I'm just going to ignore
>> it until I get rid of the whole code block.
> 
> The obvious way would be to leave the initialization to PHY_INTERFACE_MODE_NA
> there. Or to just ignore the warning.

I'll ignore.

Arınç

