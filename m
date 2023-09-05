Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B16792B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbjIEQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354629AbjIENEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:04:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE312E;
        Tue,  5 Sep 2023 06:04:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso383353866b.2;
        Tue, 05 Sep 2023 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693919038; x=1694523838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHvfGxDciDTH06pq4bTlZo2uCTCkpAd8V1AM1e/muUA=;
        b=rfHwB149aAayB2aBrx6vkRsdoFHwEyWFkp9gG94EUSNy8M+TgtLLWHtz54UFlaN7It
         EX60KA5yXdvttC8QYITq8szUQm1ap1cC21CSff0Xo1hjHt3MW313AxsX+mhiSIOP4JrH
         LKFRp8z8kKYtqNhYERq0rjPe6Q0/gwY7NyicSzaaVI9ApBP7zpEQbElb2mITZwqu6TMI
         +h+TVwfN+4vbbXBK0G4iuE4/LiC2B4enCvnMff0FSEXuVPaOTQF8ImtCkC7cqkZpN7zu
         ltQgJvjwAVLFD8pgcPcruGxoN3iuQx3YSIkjN/dJgkxXx+jWDLkLZ7HDr+AC0Xa/gk/h
         CA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919038; x=1694523838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHvfGxDciDTH06pq4bTlZo2uCTCkpAd8V1AM1e/muUA=;
        b=UgZDKtWy7pULQ4s4h34YX7tpzCpUkr/k8ezxhKngL8arJbTT/7+O7v5PBRFhXjJ29g
         a9sNdBEq7K2nRG7kFJyyIamt+vqayJveLMvLymuq7w8VF7yZVd4MvjoQ+NVhwy4SAVbo
         HwwJm4MOEOnYPsmU3YAQ8TZoCONiPrvyG00f72TxHTGGZG00c9bLgpYyg72BfTTvtvw/
         GBypR5OGWcwLHulkCxD7DKo2y806GD3yVBvlgCzrOmOxfCGSQpQDI3xi0c+pum8D1FGj
         XiiAIqOZ5Dq73JLRbNdNrGHU+bnfTQ3CzMngPDebZrt8fXRpy4swJiNYwAiShZ0Igb5u
         zL8g==
X-Gm-Message-State: AOJu0YyDC10vBLyXOv+hrL0V0UeemLkaEOYmQYkKOoMuZVF6Pw0psFDg
        c5a0lPN1Bzn9W6zLu4aHUbo=
X-Google-Smtp-Source: AGHT+IEeHdfeiGoA2IpNlbRg7m43FRRjhp/tOkQR7lhcdDejxN9dbBemf9yKFi9319iaM9xx7z1FGQ==
X-Received: by 2002:a17:906:20d0:b0:9a1:e994:3444 with SMTP id c16-20020a17090620d000b009a1e9943444mr5749881ejc.3.1693919038282;
        Tue, 05 Sep 2023 06:03:58 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709061e0e00b00988b8ff849csm7542881ejj.108.2023.09.05.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:03:57 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:03:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905130355.7x3vpgdlmdzg6skz@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230905103750.u3hbn6xmgthgdpnw@skbuf>
 <20230905131103.67f41c13@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905131103.67f41c13@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:11:03PM +0200, Lukasz Majewski wrote:
> > > +/* The KSZ9477 provides following HW features to accelerate
> > > + * HSR frames handling:
> > > + *
> > > + * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
> > > + * 2. RX PACKET DUPLICATION DISCARDING
> > > + * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS FILTERING
> > > + *
> > > + * Only one from point 1. has the NETIF_F* flag available.
> > > + *
> > > + * Ones from point 2 and 3 are "best effort" - i.e. those will
> > > + * work correctly most of the time, but it may happen that some
> > > + * frames will not be caught. Hence, the SW needs to handle those
> > > + * special cases. However, the speed up gain is considerable when
> > > + * above features are used.
> > > + *
> > > + * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR frames
> > > + * can be forwarded in the switch fabric between HSR ports.  
> > 
> > How do these 2 concepts (autonomous forwarding + software-based
> > elimination of some frames) work together? If software is not the sole
> > receiver of traffic which needs to be filtered further, and duplicates
> > also get forwarded to the network, does this not break the HSR ring?
> > 
> 
> Autonomous forwarding is based on KSZ9477, having the HSR ports
> "bridged" to send frames between them.
> 
> Then, there is also based on HSR tag, and SA in-KSZ9477 feature RX
> packet duplication discarding which will discard duplicated frames.
> 
> Last but not least the - packet loop prevention.
> 
> My understanding is as follows:
> 
> 1. RX packet duplication removes copy of a frame, which is addressed to
> cpu port of switch.

Does the duplicate elimination function only do that, as you say, or is
it supposed to also eliminate duplicates for packets flooded to 2 ports
as well (the host port, and the other ring port)?

If the latter, then it will fail to eliminate duplicates for packets
that didn't visit the CPU. So the ring will rely on the self-address
filtering capability of the other devices, in order not to collapse.
I see that the software implementation also offers self-address
filtering in hsr_handle_frame() -> hsr_addr_is_self(), but I don't see
anything making that mandatory in IEC 62439-3:2018. Can we assume that
the other ring members will know how to deal with it?

> 2. The "bridge" of HSR passes frames in-KSZ9477, which are not
> addressed to this cpu host (between other HSR nodes).

How is the switch supposed to know which packets are addressed to this
CPU port and which are not? I expect separate answers for unicast,
multicast and broadcast.

> 3. Packet loop prevention - the HSR packet with SA of note which sent
> it - is not further forwarded.
> 
> > What are the causes due to which self-address filtering and duplicate
> > elimination only work "most of the time"?
> 
> Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
> https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf

Ok, so the limitation is a race condition in hardware such that, when
duplicate packets are received on member ports very close in time to
each other, the hardware fails to detect that they're duplicates.

> > > +	/* Enable discarding of received HSR frames */
> > > +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> > > +	data |= HSR_DUPLICATE_DISCARD;
> > > +	data &= ~HSR_NODE_UNICAST;
> > > +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> > > +
> > > +	/* Self MAC address filtering for HSR frames to avoid
> > > +	 * traverse of the HSR ring more than once.
> > > +	 *
> > > +	 * The HSR port (i.e. hsr0) MAC address is used.
> > > +	 */
> > > +	for (i = 0; i < ETH_ALEN; i++) {
> > > +		ret = ksz_write8(dev, REG_SW_MAC_ADDR_0 + i, hsr->dev_addr[i]);
> > > +		if (ret)
> > > +			return ret;  
> > 
> > FWIW:
> > https://lore.kernel.org/netdev/155ff37f-43d5-5fe0-6de4-c4639909553d@gmail.com/
> > Some coordination will be required regarding the MAC address that the
> > switch driver needs to program to these registers. 
> 
> Writing of this MAC address is _required_ for PREVENTING PACKET LOOP IN
> THE RING BY SELF-ADDRESS FILTERING feature.

In case it was not clear, I was talking about coordination between you
and Oleksij. He needs to program the same register for Wake on LAN.

> In the ifconfig output - the lan1, lan2 and hsr0 shall all have the
> same MAC address assigned.
> 
> I simply take the hsr0 mac address.
> 
> > It seems that it is not single purpose.
> 
> At least in the case of HSR it looks like single purpose (for the loop
> prevention).

And for WoL, REG_SW_MAC_ADDR_0 is also single purpose. And for the MAC SA
in the generated PAUSE frames, also single purpose. Single + single + single = ?

Being a common register for multiple functions, I hope that it won't be
the users who discover than when multiple functionalities are used in
tandem (like WoL+HSR), they partially overwrite what the other has done.

So, by coordination, I mean something like a cohesive way of thinking
out the driver.

For WoL/pause frames, the linked discussion suggested that the switch
MAC address could be kept in sync with the DSA master's MAC address.

Could that also work here, and could we add a restriction to say
"Offload not supported for HSR device with a MAC address different from the DSA master"
and return -EOPNOTSUPP in ksz_hsr_join()? Then ksz9477_hsr_join() would
not modify this register.

> > > +	/* Enable per port self-address filtering */
> > > +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
> > > PORT_SRC_ADDR_FILTER, true);
> > > +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> > > +		     PORT_SRC_ADDR_FILTER, true);
> > > +
> > > +	/* Setup HW supported features for lan HSR ports */
> > > +	slave = dsa_to_port(ds, port)->slave;
> > > +	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
> > > +
> > > +	slave = dsa_to_port(ds, partner->index)->slave;
> > > +	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;  
> > 
> > Can the code that is duplicated for the partner port be moved to the
> > caller?
> 
> I've followed the convention from xrs700x driver, where we only make
> setup when we are sure that on both HSR ports the "join" has been
> called.

If code that is duplicated for both member ports can be moved to code
paths that get executed for each individual port, then the resulting
driver code may turn out to be less complex.

It's not a big deal if it can't, and maintaining a sane operating mode
in that transient state (HSR device with a single member port) is
obviously much more important. But the question was if it can, and I
don't think you've answered that?
