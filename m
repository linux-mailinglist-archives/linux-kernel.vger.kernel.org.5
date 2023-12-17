Return-Path: <linux-kernel+bounces-2553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD50815EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E01C20E87
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3255328B5;
	Sun, 17 Dec 2023 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="AotpPxBH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999C32182;
	Sun, 17 Dec 2023 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C85F4240002;
	Sun, 17 Dec 2023 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1702813194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4He4n0DzWvLNUZxrPx6E5UwZ3AuWsmZrkJP+8TMI2w=;
	b=AotpPxBHyFGKqHJYvd9MmKT2FKBlONx9kf7SiXRNmpI9EgzQgnwMlvRUeadb/naXzG/siw
	fPvNSWDGK9s+xYj2aqed6J0cdWkADg/AjD6WMo1/sirYFKL2FcdilRsj1laHhZlAH5RKrJ
	8GrKf2CluYuDGVx5/Wv92Z/sK5MeDpvODebonZ7oAAgMhBeig/EXCWDKU6RJj0QnlaJdsW
	pGHhNmuEZnK0SFmNG6M/xI4890zHirxZP9IQPBUdHYqKWvjSJfgOUs/dkeMRkwDFCViH9A
	d2zRddjRzts/VocHXRM++CO/UA4fu+Ql7De6DnKwdC8dioumOjnKEQDueI7cvQ==
Message-ID: <f830ac10-8ab3-4660-8e9f-762bb41aca78@arinc9.com>
Date: Sun, 17 Dec 2023 14:39:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
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
 <20231118123205.266819-2-arinc.unal@arinc9.com>
 <ZVjLj6/iCL/muzmH@shell.armlinux.org.uk>
 <ffaa26b3-eb25-47cc-8891-fe3cbcc724da@arinc9.com>
 <20231207174829.jccyws7myhxbgr5k@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231207174829.jccyws7myhxbgr5k@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 7.12.2023 20:48, Vladimir Oltean wrote:
> On Sat, Dec 02, 2023 at 11:29:18AM +0300, Arınç ÜNAL wrote:
>>>>    struct mt7530_priv {
>>>>    	struct device		*dev;
>>>> @@ -786,6 +787,7 @@ struct mt7530_priv {
>>>>    	struct irq_domain *irq_domain;
>>>>    	u32 irq_enable;
>>>>    	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
>>>> +	unsigned long active_cpu_ports;
>>>
>>> So this will be 32 or 64 bit in size. Presumably you know how many CPU
>>> ports there can be, which looking at this code must be less than 8 as
>>> CPU_PORT_MASK is only 3 bits in size. So, maybe use a u8, and check
>>> that cpu_dp->index <= 7 ?
> 
> We picked "unsigned long" as storage because that's also the size of the
> argument that __ffs() takes. But admittedly, we could have also stored a
> smaller variable and promote it to unsigned long when we pass it to __ffs().
> 
>> Aren't there other mechanisms to check that cpu_dp->index is a valid port?
> 
> cpu_dp->index is guaranteed by DSA to be valid (according to the "reg"
> value from the device tree and smaller than ds->num_ports). It's just a
> question of balancing this kind of optimization with the possibility
> that a future switch appears which has more than MT7530_NUM_PORTS (7) ports.

If this was to happen - as unlikely as I find it - I would suggest adding a
new MTXXXX_NUM_PORTS and set priv->ds->num_ports to it after checking
priv->id. I'm a maintainer here so I'll keep an eye out.

> 
>>
>> 	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
>> }
>>
>> struct mt7530_priv {
>> 	[...]
>> 	u8 active_cpu_ports;
>> };
> 
> Actually, looking at the code now, I don't understand why we even keep
> track of the active_cpu_ports mask in the driver. We could read the
> MT7530_MFC register in mt753x_conduit_state_change(), flip the bit
> corresponding just to cpu_dp->index (rather than rmw all of CPU_PORT_MASK),
> and write back the result. And to address Russell's concern, we could test
> whether the resulting CPU_PORT_MASK portion of what we're going to write
> back is all-zeroes or not, and if it is, clear the CPU_EN bit, otherwise
> set it.

Correct me if I'm wrong, we introduced priv->active_cpu_ports because
CPU_PORT_MASK from the MT7530_MFC register is a 3-bit mask, meant to keep a
single port number ranging from 0 to 7. There's no single bit corresponding
to cpu_dp->index on the MT7530_MFC register. So I don't see how what you
suggest here would work.

This is what I've got right now:

static void
mt753x_conduit_state_change(struct dsa_switch *ds,
			    const struct net_device *conduit,
			    bool operational)
{
	struct dsa_port *cpu_dp = conduit->dsa_ptr;
	struct mt7530_priv *priv = ds->priv;
	u8 mask;
	int val = 0;

	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
	 * forwarded to the numerically smallest CPU port which the DSA conduit
	 * interface its affine to is up.
	 */
	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
		return;

	mask = BIT(cpu_dp->index);

	if (operational)
		priv->active_cpu_ports |= mask;
	else
		priv->active_cpu_ports &= ~mask;

	if (priv->active_cpu_ports)
		val =
		    CPU_EN |
		    CPU_PORT(__ffs((unsigned long)priv->active_cpu_ports));

	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
}

> 
>>
>>>
>>> I would also suggest moving irq_enable after create_sgmii, to avoid
>>> holes in the struct.
>>
>> Sorry, I've got no idea about this. Could you explain why would there
>> possibly be holes in the struct with the current ordering of the members of
>> the mt7530_priv structure?
>>
>> Arınç
> 
> FWIW:
> 
> $ pahole -C mt7530_priv $KBUILD_OUTPUT/drivers/net/dsa/mt7530.o
> struct mt7530_priv {
>          struct device *            dev;                  /*     0     8 */
>          struct dsa_switch *        ds;                   /*     8     8 */
>          struct mii_bus *           bus;                  /*    16     8 */
>          struct regmap *            regmap;               /*    24     8 */
>          struct reset_control *     rstc;                 /*    32     8 */
>          struct regulator *         core_pwr;             /*    40     8 */
>          struct regulator *         io_pwr;               /*    48     8 */
>          struct gpio_desc *         reset;                /*    56     8 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          const struct mt753x_info  * info;                /*    64     8 */
>          unsigned int               id;                   /*    72     4 */
>          bool                       mcm;                  /*    76     1 */
> 
>          /* XXX 3 bytes hole, try to pack */
> 
>          phy_interface_t            p6_interface;         /*    80     4 */
>          phy_interface_t            p5_interface;         /*    84     4 */
>          unsigned int               p5_intf_sel;          /*    88     4 */
>          u8                         mirror_rx;            /*    92     1 */
>          u8                         mirror_tx;            /*    93     1 */
> 
>          /* XXX 2 bytes hole, try to pack */
> 
>          struct mt7530_port         ports[7];             /*    96   168 */
>          /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
>          struct mt753x_pcs          pcs[7];               /*   264   280 */
>          /* --- cacheline 8 boundary (512 bytes) was 32 bytes ago --- */
>          struct mutex               reg_mutex;            /*   544    32 */
>          /* --- cacheline 9 boundary (576 bytes) --- */
>          int                        irq;                  /*   576     4 */
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          struct irq_domain *        irq_domain;           /*   584     8 */
>          u32                        irq_enable;           /*   592     4 */
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          int                        (*create_sgmii)(struct mt7530_priv *, bool); /*   600     8 */
>          unsigned long              active_cpu_ports;     /*   608     8 */
> 
>          /* size: 616, cachelines: 10, members: 24 */
>          /* sum members: 603, holes: 4, sum holes: 13 */
>          /* last cacheline: 40 bytes */
> };
> 
> It's not like this makes any practical difference, as struct mt7530_priv
> isn't used from hot paths, but tidying it up is a good sign of clean,
> careful development, and of understanding memory alignment.

Got it, thanks. I've got a few patches that introduce changes to the
mt7530_priv structure. I'll make sure that, in the end, mt7530_priv won't
have any holes.

Arınç

