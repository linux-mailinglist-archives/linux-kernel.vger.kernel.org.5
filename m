Return-Path: <linux-kernel+bounces-23380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8E82ABDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B879282399
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171BD13ACC;
	Thu, 11 Jan 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="LM8IrbNh"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4A12E60;
	Thu, 11 Jan 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E659120004;
	Thu, 11 Jan 2024 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704968539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfFonYRVFf4urM+5uJF5QuqNz9TM00Eh0PPfAvORzBU=;
	b=LM8IrbNhBB6sP+VNXbhM/PMiu4yRl818gZZJ2Uuv1XoKpUImGDyCEGSTwITmoLBFH07xp/
	FTFrteUc/sgwpLwBvoojN1UOrcw2xcKO/Mc8sKAz5zRMotIXyoVv7DxUStr3nQa0by/U2F
	mfP2OBVLlfn7Y6D8l0jww9ni/ocSVACBj2fGg8IpmKFGuVQtKeQD3/N2nCOGKjZI9C/2A6
	ZiiQJCYnfxpywkEkFxlrEnmCd8kPy3tTCIwgvblyvvyomd9+q1uqW6fp5cylAEAUwcxBDx
	U2T1LspaH3ve+YGxBV8WFhuVO8BJdPR6c8TBGgTDYkWW25ibWX9MKa2fWD5h0Q==
Message-ID: <009fec43-0669-419e-a3a9-ce54c676a324@arinc9.com>
Date: Thu, 11 Jan 2024 13:22:12 +0300
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
References: <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
 <20240109145740.3vbtkuowiwedz5hx@skbuf>
 <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>
 <20240110182358.ci7pg7ipcbsjxqjf@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240110182358.ci7pg7ipcbsjxqjf@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 10.01.2024 21:23, Vladimir Oltean wrote:
> On Wed, Jan 10, 2024 at 10:26:54AM +0300, Arınç ÜNAL wrote:
>>> Are there existing systems that use PHY muxing? The possible problem I
>>> see is breaking those boards which have a phy-handle on gmac5, if the
>>> mt7530 driver is no longer going to modify its HWTRAP register.
>>
>> Ah see, for PHY muxing, the driver actually wants the phy-handle to be put
>> on the SoC MAC, and the PHY to be defined on the SoC ethernet's MDIO bus.
>> We don't even define gmac5 as a port on the switch dt-bindings.
> 
> I noticed that from the code already. Maybe I shouldn't have said
> "gmac5" when I meant "the GMAC attached to switch port 5, aka GMAC0".
> I was under the impression that you were also using this slightly
> incorrect terminology, to keep a numerical association between the CPU
> port number and its directly attached GMAC.
> 
>> While none of the DTs on the Linux repository utilise this, some of the
>> mt7621 DTs on OpenWrt do. The change in behaviour will only be that phy0/4
>> will be inaccessible from the SoC MAC's network interface. I de-facto
>> maintain the mt7621 device tree source files there. I intend to revert it
>> along with adding port 5 as a CPU port so that the conduit changing feature
>> becomes available.
> 
> If OpenWrt kernels are always shipped in tandem with updated device
> trees (i.e. no Arm SystemReady IR platforms, where the DT is provided by
> U-Boot), I won't oppose to retracting features described via DT if their
> platform maintainers agree in a wide enough circle that the breakage is
> manageable.

I will see to this when the time comes.

> 
> BTW, besides OpenWrt, what other software is deployed on these SoCs
> typically?

Other than OpenWrt which is widely used for these SoCs for its ease of
flashing and upgrading, compatibility with legacy U-boot versions that
usually come with any vendor making a product out of these SoCs, I can only
talk about what I deploy to run Linux. I use mainline U-Boot along with the
device trees from the Linux repository to boot mainline Linux kernels with
Buildroot as the filesystem.

Arınç

