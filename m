Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA8801B8F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjLBIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:46:16 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A9313D;
        Sat,  2 Dec 2023 00:46:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32C6BE0002;
        Sat,  2 Dec 2023 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1701506780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3Cgz/RmVnXRaNyY/Ku+4ixDljoP++5AapC1K6OMFqY=;
        b=VN8OzUDCzkX2EwouK6RVqpAm1WMb/E2SxB+XQ9odyRUXx1f4MW6Srr0UzflTGIbL0+e7Pz
        yddypq6Hv6svDddCpBSIX2VGG2pIGQMenRwfXXv7jxvzvs68IVc8wZP+FST3N4pN7fJKyH
        U7+geOCU/iS4Smg2TOjkrwSCTNSRcF+hYrQDNRPOICDBrepKFLw7toluY0sciyvTPLKFhQ
        Qu6+cXck5UN8ZhBiK9zBaN4qNwUTxJ208m9xnTNTQkR+8X/UCWRgRqTP8eYgQxnL1z6z1y
        ck4JCS8QVK/DFsl/WhLgberYcK2p3evk8jER/W/kj4aPoMR/KB/uNi4584vIUw==
Message-ID: <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
Date:   Sat, 2 Dec 2023 11:45:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231121185358.GA16629@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon.

On 21.11.2023 21:53, Simon Horman wrote:
> On Sat, Nov 18, 2023 at 03:31:57PM +0300, Arınç ÜNAL wrote:
>> There's no need to run all the code on mt7530_setup_port5() if port 5 is
>> disabled. The only case for calling mt7530_setup_port5() from
>> mt7530_setup() is when PHY muxing is enabled. That is because port 5 is not
>> defined as a port on the devicetree, therefore, it cannot be controlled by
>> phylink.
>>
>> Because of this, run mt7530_setup_port5() if priv->p5_intf_sel is
>> P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4. Remove the P5_DISABLED case from
>> mt7530_setup_port5().
>>
>> Stop initialising the interface variable as the remaining cases will always
>> call mt7530_setup_port5() with it initialised.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>> ---
>>   drivers/net/dsa/mt7530.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index fc87ec817672..1aab4c3f28b0 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -942,9 +942,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>>   		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
>>   		val &= ~MHWTRAP_P5_DIS;
>>   		break;
>> -	case P5_DISABLED:
>> -		interface = PHY_INTERFACE_MODE_NA;
>> -		break;
>>   	default:
>>   		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
>>   			priv->p5_intf_sel);
>> @@ -2313,8 +2310,6 @@ mt7530_setup(struct dsa_switch *ds)
>>   		 * Set priv->p5_intf_sel to the appropriate value if PHY muxing
>>   		 * is detected.
>>   		 */
>> -		interface = PHY_INTERFACE_MODE_NA;
>> -
>>   		for_each_child_of_node(dn, mac_np) {
>>   			if (!of_device_is_compatible(mac_np,
>>   						     "mediatek,eth-mac"))
>> @@ -2346,7 +2341,9 @@ mt7530_setup(struct dsa_switch *ds)
>>   			break;
>>   		}
>>   
>> -		mt7530_setup_port5(ds, interface);
>> +		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
>> +		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
>> +			mt7530_setup_port5(ds, interface);
> 
> Hi Arınç,
> 
> It appears that interface is now uninitialised here.
> 
> Flagged by Smatch.

I'm not sure why it doesn't catch that for mt7530_setup_port5() to run
here, priv->p5_intf_sel must be either P5_INTF_SEL_PHY_P0 or
P5_INTF_SEL_PHY_P4. And for that to happen, the interface variable will be
initialised.

for_each_child_of_node(dn, mac_np) {
	if (!of_device_is_compatible(mac_np,
				     "mediatek,eth-mac"))
		continue;

	ret = of_property_read_u32(mac_np, "reg", &id);
	if (ret < 0 || id != 1)
		continue;

	phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
	if (!phy_node)
		continue;

	if (phy_node->parent == priv->dev->of_node->parent) {
		ret = of_get_phy_mode(mac_np, &interface);
		if (ret && ret != -ENODEV) {
			of_node_put(mac_np);
			of_node_put(phy_node);
			return ret;
		}
		id = of_mdio_parse_addr(ds->dev, phy_node);
		if (id == 0)
			priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
		if (id == 4)
			priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
	}
	of_node_put(mac_np);
	of_node_put(phy_node);
	break;
}

if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
     priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
	mt7530_setup_port5(ds, interface);

Arınç
