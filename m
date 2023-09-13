Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EF79EA11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbjIMNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIMNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:51:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED719BB;
        Wed, 13 Sep 2023 06:51:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2159501a12.0;
        Wed, 13 Sep 2023 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694613066; x=1695217866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb+LM+ZDdQI9OIeprWbW5Lt9+J1VMC934dt3tpSk4bQ=;
        b=JcSwK72MCW4vXucxb8ogFiRwaTnovAARfc4tDeu0AeBB4uT+3TOFsaeLzgj6Ph6f8q
         jdebxsdmjywG+Pa5/yohy+Zn2mvCHSpPWu7uZknrOyuMCkWdOe9oVJpK+B7tvw67L145
         I9JDLGFjpWqQSkCEjmUd3750KkGJtqlabbjsR0fxzEHWi43Be+s+G5izH+ydtePhtrFF
         adCcRjuMVSslPwjDgXga6s3dM7ETviegFCC+GZXIoAFYC5cQ1VjU5jrN9vtMBKntqyDo
         2P/xkitBswLUwdQK9ltuz8YnXucnPubyPi//AVTReITHi7TYtnBmKyxyJRyHhphO9y5O
         D9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613066; x=1695217866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb+LM+ZDdQI9OIeprWbW5Lt9+J1VMC934dt3tpSk4bQ=;
        b=YnFqEafy6zgH76QXvW2I+krDEDrYXj7OzEI2fhRuLHXygQN9RIZebBG8AKXOOhxWJ2
         0k+4Z7OvM5kC0EpI1SKTXnALRIVWIaalT1qqoIDTcWYvG6t5FBk6e2eMeLRZAFvg3jBk
         4lvI91kb9U/jG0sEx4dDgx7XU5WTb6e7QF4E//aXNWZsvBHH8zsPmFIYiV/TmT6zcFEd
         MjMl2RVFhHJqpG+lm0MS9izty5RF0hzkHGWtNPMKrwAn7kKy0WvkELecAqOEfbP7DLk5
         u/cIH/1xx9/j8MxV3UUSXrK33sz9HYL8lMnmZ13E3AOuaJkzJ8Y5kRu4W1UErE8O+cZk
         0e/w==
X-Gm-Message-State: AOJu0YxyNmA/n8huihDkG4Ul7Z8KJC97zHFS1nb25y4XnJfz7o4nka+M
        DKEbC5hT2f908Mmox3sJ3Vs=
X-Google-Smtp-Source: AGHT+IG1406b7TTyghxC15ezkviidLxqJA+81L0g0HplA0o6MWKwbaEiP1CVBcEBjbX59rvhxlMhyg==
X-Received: by 2002:a17:906:5a42:b0:9a1:b528:d0f6 with SMTP id my2-20020a1709065a4200b009a1b528d0f6mr3223359ejc.27.1694613066466;
        Wed, 13 Sep 2023 06:51:06 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b009ada9f7217asm643778ejc.88.2023.09.13.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 06:51:05 -0700 (PDT)
Date:   Wed, 13 Sep 2023 16:51:02 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230913135102.hoyl4tifyf77kdo2@skbuf>
References: <20230912101748.0ca4eec8@wsk>
 <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
 <20230912142644.u4sdkveei3e5hwaf@skbuf>
 <20230912170641.5bfc3cfe@wsk>
 <20230912215523.as4puqamj65dikip@skbuf>
 <20230913102219.773e38f8@wsk>
 <20230913105806.g5p3wck675gbw5fo@skbuf>
 <20230913141548.70658940@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913141548.70658940@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:15:48PM +0200, Lukasz Majewski wrote:
> > I thought we were in agreement to program the actual DSA user ports'
> > MAC addresses to hardware.
> 
> No - v4 of this solution uses HSR net device MAC address, which is
> supposed to be the same as DSA master.

By "in agreement" I mean "as a result of the discussion on v4 [ this discussion ],
where it became obvious that the DSA master solution is not so robust".
I hope the 12 emails already exchanged on this patch set weren't for nothing.

> > With KSZ switches, a single CPU port is supported, so all ports share
> > the same DSA master. So if the contents of REG_SW_MAC_ADDR_0 is
> > different from the DSA master (the same DSA master that was used for
> > an earlier HSR offload), why do you infer that it was altered by WoL?
> > It makes no sense.
> 
> So where is the issue? The only issue is that somebody would change DSA
> master (and hence HSR) MAC address, so the REG_SW_MAC_ADDR_0 would not
> be changed. Or do I miss something?

Changing the DSA master address and changing the HSR MAC address
(indirectly through the ports' address) are different operations.
The DSA master's address and the user ports' address are not necessarily
in sync.

Each address change is problematic in its own way, and each problem
needs to be tackled in its own way, depending on which MAC address you
desire for REG_SW_MAC_ADDR_0 to track.

But yes, the only issue is that the MAC address can be changed at
runtime, after the initial offload.

> > - Changing the MAC address of (a) triggers a pre-existing bug. That
> > bug can be separated from the HSR offload discussion if the HSR
> > offload decides to not program the DSA master's MAC address to
> > hardware, but a different MAC address. The pre-existence of the DSA
> > bug is not a strong enough argument per se to avoid programming the
> > DSA master's address to hardware.
> 
> And this is how v4 is implemented. Or not?

If A == B initially, then there are 2 ways you can change that condition.
You can change A, or you can change B. Replace "A" with "the DSA
master's address" and "B" with "the HSR device's address".

> > - Changing the MAC address of (c) does not seem directly possible,
> > but:
> > 
> > - Changing the MAC address of (b) also triggers (c) - see
> > hsr_netdev_notify(). This is because the HSR driver makes sure that
> > the addresses of port_A, port_B and the HSR device are equal at all
> > times.
> 
> Why changing HSR port would affect HSR device MAC address?

I don't have a simpler answer than "because that's what the code does".

If you don't have time to experiment to convince yourself that this is
the case, below is a set of commands that should hopefully clarify.

$ ip link
6: eno2: <BROADCAST,MULTICAST> mtu 1508 qdisc noop state DOWN group default qlen 1000
    link/ether 2a:af:42:b7:73:11 brd ff:ff:ff:ff:ff:ff
    altname end0
    altname enp0s0f2
7: swp0@eno2: <BROADCAST,MULTICAST,M-DOWN> mtu 1504 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
8: swp1@eno2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
9: swp2@eno2: <BROADCAST,MULTICAST,M-DOWN> mtu 1504 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
10: sw0p0@swp0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
11: sw0p1@swp0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
12: sw0p2@swp0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
13: sw2p0@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
14: sw2p1@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
15: sw2p2@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
16: sw2p3@swp2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether a6:f4:af:fd:fc:73 brd ff:ff:ff:ff:ff:ff
# Simplified in a table for brevity. The format will be kept below
$ ip link show ...
     sw0p0              sw0p1              DSA master          hsr0
addr a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73   n/a

$ ip link add hsr0 type hsr slave1 sw0p0 slave2 sw0p1 version 1
[   70.033711] sja1105 spi2.0 sw0p0: entered promiscuous mode
[   70.058066] sja1105 spi2.0 sw0p1: entered promiscuous mode
Warning: dsa_core: Offloading not supported.

$ ip link show ...
     sw0p0              sw0p1              DSA master          hsr0
addr a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73   a6:f4:af:fd:fc:73

$ ip link set swp0 address 00:01:02:03:04:05 # DSA master

$ ip link show ...
     sw0p0              sw0p1              DSA master          hsr0
addr a6:f4:af:fd:fc:73  a6:f4:af:fd:fc:73  00:01:02:03:04:05   a6:f4:af:fd:fc:73

$ ip link set sw0p0 address 00:01:02:03:04:06

$ ip link show ...
     sw0p0              sw0p1              DSA master          hsr0
addr 00:01:02:03:04:06  a6:f4:af:fd:fc:73  00:01:02:03:04:05   00:01:02:03:04:06

$ ip link set sw0p1 address 00:01:02:03:04:07

$ ip link show ...
     sw0p0              sw0p1              DSA master          hsr0
addr 00:01:02:03:04:06  00:01:02:03:04:07  00:01:02:03:04:05   00:01:02:03:04:06

> Shouldn't it be forbidden, and HSR ports shall inherit MAC address of
> HSR device (hsr0) ?

Since HSR does _actually_ track the MAC address of port_A (sw0p0 above),
I guess it would be best if the API introduced would always program
REG_SW_MAC_ADDR_0 with the MAC address of the first port that joins the
HSR (and requests a reference to REG_SW_MAC_ADDR_0). That way, the API
should work with no changing for WoL as well. Anyway - minor difference
between first user port and HSR dev_addr.

> > The simple matter is: if you program the MAC address of a netdev (any
> > netdev) to hardware
> 
> Which netdev in this case? lan1, lan2, hsr0 or eth0 ?

Any netdev. It is a general statement which had a continuation, which
you've interrupted.

> > , then for a correct and robust implementation, you
> > need to make sure that the hardware will always be in sync with that
> > address, keeping in mind that the user may change it. Either you deny
> > changes, or you update the hardware when the address is updated.
> > 
> 
> Why I cannot just:
> 
> 1. Check on hsr_join if lan1, lan2, hsr0 and eth0 MAC is equal and
> write it to REG_SW_MAC_ADDR_0?

This is actually unnecessary if you implement the reference scheme on
REG_SW_MAC_ADDR_0 that I've suggested. Checking the MAC address of eth0
is unnecessary in any case, if you don't program it to hardware.

> 2. Forbid the change of lan1/lan2/eth0/hsr0 if it may affect HSR HW
> offloading? If user want to change it - then one shall delete hsr0 net
> device, change MAC and create it again.

I've been saying since yesterday that you should do this.

> How point 2 can be achieved (if possible) ?

Re-read earlier emails.

> > If the DSA user port MAC address changes,
> 
> You mean lan1, lan2, which are joined with hsr0?

Yup. I've been saying this for a number of emails already:
https://lore.kernel.org/netdev/20230912092909.4yj4b2b4xrhzdztu@skbuf/

| The ports which hold a reference on REG_SW_MAC_ADDR_0 cannot have their
| MAC address changed - and for this, you'd have to add a hook to
| dsa_switch_ops (and thus to the driver) from
| dsa_slave_set_mac_address().

> > and REG_SW_MAC_ADDR_0 was
> > previously programmed with it, and nothing is done in reaction to
> > this, then this is a problem with the HSR offload. 
> 
> This shall be just forbidden?

Yup.

> > So no, it's not
> > just a problem with upcoming WoL patches as you imply. You need to
> > integrate a solution to that problem as part of your HSR patches.
> 
> I'm really stunned, how much extra work is required to add two
> callbacks to DSA subsystem (to have already implemented feature) for a
> single chip IC.

Some observations are best kept to yourself. This is only the second HSR
offload in the entire kernel. To complain that the infrastructure needs
some extensions, for something that wasn't even needed for the first
implementation (tracking a MAC address), is unrealistic.
