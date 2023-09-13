Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CC79E57E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbjIMK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbjIMK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:58:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833819B4;
        Wed, 13 Sep 2023 03:58:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso106900581fa.2;
        Wed, 13 Sep 2023 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602689; x=1695207489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4TLaPjJGYtbUUUt+F/f79z+dkxxZ0mIyqX82iiNHCQ=;
        b=MdLwo/5VdbXxKQ4WGN7kCw7GubUS/dCRh6cXWzO7BFioKy9ONzVNuScE7Rfxy/98kn
         YuMWJQhbswTTLYhYBK5Va9nxurRXByj+ywoe50yZtlnq3gvxoK2MMUJbTa1O3FKp+D3V
         NrMIukbMBnPNtm1sVesegegWFKBKde9g+QAjSiL2qoth0fzxynxehX+vScj/XWzRQ7XP
         rJoGZJtg0nU3wqmzhtvYqEgJV/CQzg26yV/aCqOBsbup5e23NS8rb6/KR3FSANhjtM06
         tbe5IOVE8pLph7i27QAHqrlMUeYU53gaLBYSjlAvoW5djPvGXDdyOpTea94tl3+7PEcs
         LRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602689; x=1695207489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4TLaPjJGYtbUUUt+F/f79z+dkxxZ0mIyqX82iiNHCQ=;
        b=cqFT2hgwZH0K5W939tyPxNUNns1ZOe8CtX+rbzrMUSIhlpKh98jFKp7e3RAJge8Ap7
         8U3ARWnm9zEL44aIYuoiYDwBKwgMvJnk++yqw96DNuwjLKXEbwdmIuRUVIvYGYIei0r7
         iaf18WYodqyeR6GVkEPVaXfwkUKG6w8qYtE96qLs+QP5m6E672Mnti8A4ej2Byfu7oFJ
         CuoJPQM2Q3jOjoG+5BNWNwu4ptn6/FsbOslaxY1gnbUfAtvtJz998f/P0ri2Im2EQc36
         g3A/l86+757KNbU+opzjZOF/vnMRhl31YayKtXRogPxqUpLS8wrF4vKRxBmphc1hPEC0
         NK9g==
X-Gm-Message-State: AOJu0YzD6nXMbMfEyTji+ZbowMgQURDzQDUOBdEERZZJSfQRmEhC/zBV
        VsGmPqdUP1E91huQ/fbW554=
X-Google-Smtp-Source: AGHT+IFFyJ3lay9NUjZa8DkRXOc64IKh4AwAlNwAsNz+WvyuperImNu9KHg1tt3Nsri2FStsctBAPA==
X-Received: by 2002:a2e:8349:0:b0:2bc:be93:6d3c with SMTP id l9-20020a2e8349000000b002bcbe936d3cmr1961460ljh.32.1694602688771;
        Wed, 13 Sep 2023 03:58:08 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id ga17-20020a170906b85100b009a1e0349c4csm8211559ejb.23.2023.09.13.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:58:08 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:58:06 +0300
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
Message-ID: <20230913105806.g5p3wck675gbw5fo@skbuf>
References: <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230912101748.0ca4eec8@wsk>
 <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
 <20230912142644.u4sdkveei3e5hwaf@skbuf>
 <20230912170641.5bfc3cfe@wsk>
 <20230912215523.as4puqamj65dikip@skbuf>
 <20230913102219.773e38f8@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913102219.773e38f8@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:22:19AM +0200, Lukasz Majewski wrote:
> Why we cannot have even simpler solution - in the HSR/Wol code we read
> content of REG_SW_MAC_ADDR_0 (the actually programmed MAC) and:
> 
> - If not programmed - use DSA master one (like done in mine patches)

You said here https://lore.kernel.org/netdev/20230912160326.188e1d13@wsk/
that using the DSA master address is a complication that can be avoided,
no? So why is it now part of the solution that you propose?

I thought we were in agreement to program the actual DSA user ports' MAC
addresses to hardware.

> - If already programmed:
> 	 - check if equal to DSA master - proceed with HSR.
> 	 - if not equal to DSA master (e.g. WoL altered) - exit HSR join
> 	   with information that offloading is not possible

With KSZ switches, a single CPU port is supported, so all ports share
the same DSA master. So if the contents of REG_SW_MAC_ADDR_0 is different
from the DSA master (the same DSA master that was used for an earlier
HSR offload), why do you infer that it was altered by WoL? It makes no
sense.

> Then, the content of REG_SW_MAC_ADDR_X would determine what to do with
> it.
> 
> > There are probably hundreds of implementations of this idea in the
> > kernel, but the one that comes to my mind is ocelot_mirror_get() +
> > ocelot_mirror_put(). Again, I need to mention that I know that port
> > mirroring != HSR - I'm just talking about the technique.
> > 
> > There is one more thing that your reply to my observation fails to
> > address. Even with this refcount thing, you will still need to add
> > code to dsa_slave_set_mac_address() which notifies the ksz driver, so
> > that the driver can refuse MAC address changes, which would break the
> > offloads. Ack?
> 
> And the above problem is not related to the DSA slave address change
> discussed earlier?

"Discussed earlier" is a bit imprecise and I don't know what you're
talking about.

There are 3 netdev kinds at play here: (a) DSA master, (b) DSA user port, (c) HSR device.

- Changing the MAC address of (a) triggers a pre-existing bug. That bug
  can be separated from the HSR offload discussion if the HSR offload
  decides to not program the DSA master's MAC address to hardware, but a
  different MAC address. The pre-existence of the DSA bug is not a strong
  enough argument per se to avoid programming the DSA master's address to
  hardware. But there may be others. Like the fact that DSA user ports may
  inherit the DSA master's MAC address, or they may have their own.
  Limiting HSR offload and WoL to just the "inherit" case may seem a bit
  arbitrary, considering that the self-address filtering from
  hsr_handle_frame() looks at the port_A and port_B MAC addresses.

- Changing the MAC address of (c) does not seem directly possible, but:

- Changing the MAC address of (b) also triggers (c) - see hsr_netdev_notify().
  This is because the HSR driver makes sure that the addresses of
  port_A, port_B and the HSR device are equal at all times.

The simple matter is: if you program the MAC address of a netdev (any
netdev) to hardware, then for a correct and robust implementation, you
need to make sure that the hardware will always be in sync with that
address, keeping in mind that the user may change it. Either you deny
changes, or you update the hardware when the address is updated.

It's not quite clear to me that you're making a distinction between
changing (a) and (b).

> > In principle it sounds like a plan. It just needs to be implemented.
> 
> To clarify:
> 
> 0. It looks like described above prevention from REG_SW_MAC_ADDR_X
> overwriting and DSA slave port MAC address change are needed.
> 
> Then questions about time line:
> 
> 1. The HSR code is accepted without fixes from 0. and then when other
> user (WoL) patches are posted problems from 0. needs to be addressed.
> 
> or 
> 
> 2. To accept the HSR code you (and other community members? Russell,
> Andrew) require the fixes from 0. first. 

If the DSA user port MAC address changes, and REG_SW_MAC_ADDR_0 was
previously programmed with it, and nothing is done in reaction to this,
then this is a problem with the HSR offload. So no, it's not just a
problem with upcoming WoL patches as you imply. You need to integrate a
solution to that problem as part of your HSR patches.
