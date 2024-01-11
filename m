Return-Path: <linux-kernel+bounces-23437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A291782ACB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F8F1F23ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB114F9E;
	Thu, 11 Jan 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Ik5y72Sy"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4914F60;
	Thu, 11 Jan 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B8181BF20F;
	Thu, 11 Jan 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704970760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnarWtqoAs82gLTcu+JfpQz2WRb849FNnw7B0aiWd04=;
	b=Ik5y72Syp/Es1qKGg8RGffSk4Z8K0lLV7Ywkliibu7CbsQ8txkCqoVH41f6A1hjxlIqrqu
	gHNmbYuC8nhup4V+BIV2dtuYD0Aefme9NlRPLb+88b/6HVULRSFb6dpLv0okcRyxn7vjrB
	b/lxKNhWVJfNyKmojWb/wg/TaLa/4SVUbPsgsHv9i+3YtI08mH8cIWgrKj7iQLzd+DsNdz
	gn2N653pqp4g3g1NMSGTsJRozMJgM0u4truZ1K/GWw27vOjIyeqTL+EAdjjR5HMYPNB0fz
	yWIf45Tn8Aj5xDQFbWo/hnZBBXi8AfDO6izxzTIIMpi3dMTKiaJ+OhEBkMLfjQ==
Message-ID: <94a63ea3-29e8-4387-9a1a-0f6321f15b60@arinc9.com>
Date: Thu, 11 Jan 2024 13:59:13 +0300
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
References: <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
 <20240109145740.3vbtkuowiwedz5hx@skbuf>
 <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>
 <20240110182358.ci7pg7ipcbsjxqjf@skbuf>
 <009fec43-0669-419e-a3a9-ce54c676a324@arinc9.com>
 <20240111103146.t5fzr2wlw2tyrkkb@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240111103146.t5fzr2wlw2tyrkkb@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 11.01.2024 13:31, Vladimir Oltean wrote:
> On Thu, Jan 11, 2024 at 01:22:12PM +0300, Arınç ÜNAL wrote:
>>> BTW, besides OpenWrt, what other software is deployed on these SoCs
>>> typically?
>>
>> Other than OpenWrt which is widely used for these SoCs for its ease of
>> flashing and upgrading, compatibility with legacy U-boot versions that
>> usually come with any vendor making a product out of these SoCs, I can only
>> talk about what I deploy to run Linux. I use mainline U-Boot along with the
>> device trees from the Linux repository to boot mainline Linux kernels with
>> Buildroot as the filesystem.
>>
>> Arınç
> 
> I meant what other software (operating system) _instead_ of OpenWRT.
> I'm trying to figure out what other users of PHY muxing there might be.

I'm not aware of any other projects that utilise PHY muxing of MT7530. It
was me spending a few months bringing the feature to OpenWrt in the first
place.

Arınç

