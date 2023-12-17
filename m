Return-Path: <linux-kernel+bounces-2562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5964815ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D625D1C20FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183D32C6C;
	Sun, 17 Dec 2023 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ZP2lPxfB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2232C63;
	Sun, 17 Dec 2023 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0F3660005;
	Sun, 17 Dec 2023 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1702814469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lg07BUdOWLUb55sl4jY2nUVlLAz2wv5V6/HSrQCs+4=;
	b=ZP2lPxfBeruufnF1FkXf5EEupfSURUouUpZVNBWpt9hzX776i2vf0egCVk609emM5rwQOe
	8UyasLk7LJ7an88tcOqUzI2yU0vxxW42D08t6m7itnmaLDC+K0tGN2qiCzQNbvEsWBBsxY
	hwbmguqITa0CkysH9MJo59hXkNR7zXolm5/uBOaY9Cw7LgDEkeoON6AlnMZemUu+5XX1Fv
	XXaMWPBMk8nFhPY/753hBJQcplIOBFEgQ3MkD6wCJqDZjT/Ps4/jfwuqTadyGBFwrybnRh
	d41T+ISJmN+alFszpETgB4FvSKcitQEgrV19AO92Zg5aZdTaVoklFrvqBnAmLw==
Message-ID: <968d0374-2584-42dd-9ec4-c30fb01c5202@arinc9.com>
Date: Sun, 17 Dec 2023 15:01:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net: dsa: mt7530: improve code path for
 setting up port 5
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-6-arinc.unal@arinc9.com>
 <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
 <5e95a436-189f-412e-b409-89a003003292@arinc9.com>
 <20231207180332.ugfp33xcdkw3elrw@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231207180332.ugfp33xcdkw3elrw@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 7.12.2023 21:03, Vladimir Oltean wrote:
> On Sat, Dec 02, 2023 at 11:36:03AM +0300, Arınç ÜNAL wrote:
>> On 18.11.2023 17:41, Russell King (Oracle) wrote:
>>>> For the cases of PHY muxing or the port being disabled, call
>>>> mt7530_setup_port5() from mt7530_setup(). mt7530_setup_port5() from
>>>> mt753x_phylink_mac_config() won't run when port 5 is disabled or used for
>>>> PHY muxing as port 5 won't be defined on the devicetree.
>>>
>>> ... and this should state why this needs to happen - in other words,
>>> the commit message should state why is it critical that port 5 is
>>> always setup.
>>
>> Actually, port 5 must not always be setup. With patch 7, I explain this
>> while preventing mt7530_setup_port5() from running if port 5 is disabled.
>>
>> Arınç
> 
> Then change that last paragraph. You could say something like this:
> 
> To keep the cases where port 5 isn't controlled by phylink working as
> before, we need to preserve the mt7530_setup_port5() call from mt7530_setup().
> 
> I think it's a case of saying too much, which sparks too many unresolved
> questions in the reader's mind, which are irrelevant for the purpose of
> this specific change: eliminating the overlap between DSA's setup() time
> and phylink.

Will do, thanks.

