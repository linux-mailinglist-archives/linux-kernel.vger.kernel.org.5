Return-Path: <linux-kernel+bounces-18598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD4825FE0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE001C21376
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7F79F4;
	Sat,  6 Jan 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Be2kNutc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47B8820;
	Sat,  6 Jan 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B016FF803;
	Sat,  6 Jan 2024 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704551644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9f0inLiNdvMCgAXDzTOMFJm8AwgD4xAovOKS/w8Rdk=;
	b=Be2kNutcdju7oMbb8ncEf8YM/PrItPtdRjqrlnG7cw6TyUUav9PHvJ6jwQbyfXhTgsJO8W
	k1LoS4yVcy+iNJ4cEeBnHsSiKt1iflrelvfXAjxc7P8q9E292mPmfUkZWlTpcohM/dgEe3
	q6ELEjoYY4JU9TEE8gYio88A7Vq5WRmZo3vEaN69Cbhjy5jaF+dFOIK0zXsnf9EJlZL8NB
	pQLt99kLI7XB3BYcD45A8ZtaQ9l+AnW33Ex0iqDP2kqQdTIMIsRB7WRki4bebDi4g3xK3f
	U11zqQdYEUpWVwWKVep6KvzPtSPXtR9ivGJlF8uQj5hRCCvnSRSpeo456xLi+A==
Message-ID: <6d6169bc-ce33-46e2-8226-0fef9f92949b@arinc9.com>
Date: Sat, 6 Jan 2024 17:33:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-2-arinc.unal@arinc9.com>
 <20231227044347.107291-2-arinc.unal@arinc9.com>
 <20240104152232.jkoqiuwk3rd24rpm@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240104152232.jkoqiuwk3rd24rpm@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4.01.2024 18:22, Vladimir Oltean wrote:
> On Wed, Dec 27, 2023 at 07:43:41AM +0300, Arınç ÜNAL wrote:
>> @@ -3075,6 +3071,38 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
>>   	return 0;
>>   }
>>   
>> +static void
>> +mt753x_conduit_state_change(struct dsa_switch *ds,
>> +			    const struct net_device *conduit,
>> +			    bool operational)
>> +{
>> +	struct dsa_port *cpu_dp = conduit->dsa_ptr;
>> +	struct mt7530_priv *priv = ds->priv;
>> +	u8 mask;
>> +	int val = 0;
> 
> Longest line first.
> 
>> +
>> +	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
>> +	 * forwarded to the numerically smallest CPU port which the DSA conduit
>> +	 * interface its affine to is up.
> 
> "first CPU port whose conduit interface is up"
> 
>> +	 */
>> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
>> +		return;
>> +
>> +	mask = BIT(cpu_dp->index);
>> +
>> +	if (operational)
>> +		priv->active_cpu_ports |= mask;
>> +	else
>> +		priv->active_cpu_ports &= ~mask;
>> +
>> +	if (priv->active_cpu_ports)
>> +		val =
>> +		    CPU_EN |
>> +		    CPU_PORT(__ffs((unsigned long)priv->active_cpu_ports));
> 
> I don't think the type cast is necessary (implicit type promotion takes place).
> 
> Also, it is customary to put {} for multi-line "if" blocks, even if they are
> made up of a single expression.
> 
> But without the type cast, it could look like this.
> 
> 	if (priv->active_cpu_ports)
> 		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));

Will do. Thanks for dealing with my rookie mistakes. :)

Arınç

