Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1336279E7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjIMMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjIMMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:16:03 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516419B6;
        Wed, 13 Sep 2023 05:15:58 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 36C3986A02;
        Wed, 13 Sep 2023 14:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694607355;
        bh=MFzjb7ZZZhPrmmMBPvo2PsdGAeg6ErQa2ILm3+uk39U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYKEbUyxAdoCwpfQGR6C6e+NpC4F78661vLZc1LYaog0Gb7k9lIRZBi1YjP2N3Eov
         6q119AF4V2vcgVVMhnpLKQfBkUfGrtxchBcEZookdRMxtb2Cxp/UZoUJ/Aci/1rU7l
         rJr3uWLP5zpCbrLfVgGM3zM8RQ6TqWMwIRx0PcEhYcrM7o/wmt3pguLS3sA1TElwg9
         9qkR5srjww/K9HwoHVAQQhX/QwruWhureHWKYKFl34+CqSkqVjF2M8Mnlv2F5gmsMs
         7AozDOdaTmwNSWwzL1Ho//Ru7VnwrJmaq8n03YutvSmiopC8Fxzkb3YMyaX2OhR5ka
         /fH/FflayyOzg==
Date:   Wed, 13 Sep 2023 14:15:48 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
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
Message-ID: <20230913141548.70658940@wsk>
In-Reply-To: <20230913105806.g5p3wck675gbw5fo@skbuf>
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
        <20230913105806.g5p3wck675gbw5fo@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k7hWuP6m82vv+1jJ3La+DJk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k7hWuP6m82vv+1jJ3La+DJk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Sep 13, 2023 at 10:22:19AM +0200, Lukasz Majewski wrote:
> > Why we cannot have even simpler solution - in the HSR/Wol code we
> > read content of REG_SW_MAC_ADDR_0 (the actually programmed MAC) and:
> >=20
> > - If not programmed - use DSA master one (like done in mine
> > patches) =20
>=20
> You said here
> https://lore.kernel.org/netdev/20230912160326.188e1d13@wsk/ that
> using the DSA master address is a complication that can be avoided,
> no? So why is it now part of the solution that you propose?

The patch v4 uses DSA master (HSR device) MAC address as you advised.

My suggestion was to just use the value (single) if already written
there. If it differs at join time - then just bail out.

>=20
> I thought we were in agreement to program the actual DSA user ports'
> MAC addresses to hardware.

No - v4 of this solution uses HSR net device MAC address, which is
supposed to be the same as DSA master.

>=20
> > - If already programmed:
> > 	 - check if equal to DSA master - proceed with HSR.
> > 	 - if not equal to DSA master (e.g. WoL altered) - exit HSR
> > join with information that offloading is not possible =20
>=20
> With KSZ switches, a single CPU port is supported, so all ports share
> the same DSA master. So if the contents of REG_SW_MAC_ADDR_0 is
> different from the DSA master (the same DSA master that was used for
> an earlier HSR offload), why do you infer that it was altered by WoL?
> It makes no sense.

So where is the issue? The only issue is that somebody would change DSA
master (and hence HSR) MAC address, so the REG_SW_MAC_ADDR_0 would not
be changed. Or do I miss something?

>=20
> > Then, the content of REG_SW_MAC_ADDR_X would determine what to do
> > with it.
> >  =20
> > > There are probably hundreds of implementations of this idea in the
> > > kernel, but the one that comes to my mind is ocelot_mirror_get() +
> > > ocelot_mirror_put(). Again, I need to mention that I know that
> > > port mirroring !=3D HSR - I'm just talking about the technique.
> > >=20
> > > There is one more thing that your reply to my observation fails to
> > > address. Even with this refcount thing, you will still need to add
> > > code to dsa_slave_set_mac_address() which notifies the ksz
> > > driver, so that the driver can refuse MAC address changes, which
> > > would break the offloads. Ack? =20
> >=20
> > And the above problem is not related to the DSA slave address change
> > discussed earlier? =20
>=20
> "Discussed earlier" is a bit imprecise and I don't know what you're
> talking about.
>=20
> There are 3 netdev kinds at play here: (a) DSA master, (b) DSA user
> port, (c) HSR device.
>=20
> - Changing the MAC address of (a) triggers a pre-existing bug. That
> bug can be separated from the HSR offload discussion if the HSR
> offload decides to not program the DSA master's MAC address to
> hardware, but a different MAC address. The pre-existence of the DSA
> bug is not a strong enough argument per se to avoid programming the
> DSA master's address to hardware.

And this is how v4 is implemented. Or not?

> But there may be others. Like the
> fact that DSA user ports may inherit the DSA master's MAC address, or
> they may have their own. Limiting HSR offload and WoL to just the
> "inherit" case may seem a bit arbitrary, considering that the
> self-address filtering from hsr_handle_frame() looks at the port_A
> and port_B MAC addresses.

As described earlier - the self-address mac filtering to work must have
lan1, lan2, HSR, eth0 MAC address equal. HSR HW offloading will just not
work if they differ.

>=20
> - Changing the MAC address of (c) does not seem directly possible,
> but:
>=20
> - Changing the MAC address of (b) also triggers (c) - see
> hsr_netdev_notify(). This is because the HSR driver makes sure that
> the addresses of port_A, port_B and the HSR device are equal at all
> times.

Why changing HSR port would affect HSR device MAC address? Shouldn't it
be forbidden, and HSR ports shall inherit MAC address of HSR device
(hsr0) ?

>=20
> The simple matter is: if you program the MAC address of a netdev (any
> netdev) to hardware

Which netdev in this case? lan1, lan2, hsr0 or eth0 ?

> , then for a correct and robust implementation, you
> need to make sure that the hardware will always be in sync with that
> address, keeping in mind that the user may change it. Either you deny
> changes, or you update the hardware when the address is updated.
>=20

Why I cannot just:

1. Check on hsr_join if lan1, lan2, hsr0 and eth0 MAC is equal and
write it to REG_SW_MAC_ADDR_0?

2. Forbid the change of lan1/lan2/eth0/hsr0 if it may affect HSR HW
offloading? If user want to change it - then one shall delete hsr0 net
device, change MAC and create it again.

How point 2 can be achieved (if possible) ?

> It's not quite clear to me that you're making a distinction between
> changing (a) and (b).
>=20
> > > In principle it sounds like a plan. It just needs to be
> > > implemented. =20
> >=20
> > To clarify:
> >=20
> > 0. It looks like described above prevention from REG_SW_MAC_ADDR_X
> > overwriting and DSA slave port MAC address change are needed.
> >=20
> > Then questions about time line:
> >=20
> > 1. The HSR code is accepted without fixes from 0. and then when
> > other user (WoL) patches are posted problems from 0. needs to be
> > addressed.
> >=20
> > or=20
> >=20
> > 2. To accept the HSR code you (and other community members? Russell,
> > Andrew) require the fixes from 0. first.  =20
>=20
> If the DSA user port MAC address changes,

You mean lan1, lan2, which are joined with hsr0?

> and REG_SW_MAC_ADDR_0 was
> previously programmed with it, and nothing is done in reaction to
> this, then this is a problem with the HSR offload.=20

This shall be just forbidden?

> So no, it's not
> just a problem with upcoming WoL patches as you imply. You need to
> integrate a solution to that problem as part of your HSR patches.

I'm really stunned, how much extra work is required to add two
callbacks to DSA subsystem (to have already implemented feature) for a
single chip IC.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/k7hWuP6m82vv+1jJ3La+DJk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUBp/QACgkQAR8vZIA0
zr18wwgA0GmvFFm/rs8t4n/2ZdIYNwYYrtY/p8ldXO6L7HIVnL/U3BeiOdrrFn00
kJkUoGpYqcqCR8ay0DaoNfgqYJqbP9vExOK7u7UnxvldMOqv1nbAA4n0kjnlhqLf
UvcfbVKbRI66SA7GiOiqWVQqlqnLqYUIKMOrOXlIopwRlUFu7k24Ydy4wp+9eZnv
I2S/8JNaginNbAZL+OOo1fT5yzGasIlmCOPTCXKagbItH8sQCowlMSTqyJ62OKFl
LqpwuMl1GwYAyJcsa3/CDNw/99XSpPyt37XICap2Jr7LOBdmEJ9cO5vA7mjbbZpH
bGpTifWvwdkKSbhVZmvifeqIeTOYfg==
=0bg4
-----END PGP SIGNATURE-----

--Sig_/k7hWuP6m82vv+1jJ3La+DJk--
