Return-Path: <linux-kernel+bounces-131275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56C898595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D333228658C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC36811E0;
	Thu,  4 Apr 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SEMWZDLD"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA57F7DD;
	Thu,  4 Apr 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228386; cv=none; b=nY3UvfBL5ve9QwKpvgj/Jnt2GcApnLRr+R9uVm7AtTL2PngjORVx7aZGKlTnLLXdWWXTLHcMHmVxmdbioVaJMPYYVLrmvzVhPYONRm8Ne9H1QDrM21PP7v8XTkH1G4nDmEaYMFcy7LtiNqkyAf4cNYh7yQXxix9QclijRHMIAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228386; c=relaxed/simple;
	bh=VvLUiOhFmvi3p+J8M6u3niysa4qSqIvhg7uW5L/YSU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp36eB/GrYrqSZSGO3LVGWh/o2+e80FiQ11DdZSvlfGyWu0drnxkJIEoBZs9iC9spvdZfnD3tLKsGVocSyXLWo5uUzxx6BCfMZtVJgvN9QdUcs2OApYZCMXHq6EocqAV0nRhMWixPotk9mHbLYut2azn3mfJqzPZc5nNgVTqIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SEMWZDLD; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D2D1883339;
	Thu,  4 Apr 2024 12:52:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712227927;
	bh=H4P27d4njnyQUbPwQ1/Lu1Tg8ftGAXhaSall4PmQVJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SEMWZDLDYX2HChHz3gPBOyguVnX6xgNXbKTCBm6MfVgBTvHpgYHsvMWE+gIN4iwoF
	 glyE4lc4SHwC7KZ8GXHC2i7yywAYrAtWBw8MYRKk7ebuXbKEdU6W46kGD7v2FlmEY/
	 bXjVHP29tAsZsYZiBQiGShtEZgZ+//xJ/uYHzgdb6dhK7aI//gwHnkrd+n7m+oTgMQ
	 rqioDZ6n3/EW3k5bvLXmha80T+PFwx58ukZiUqvHGb0zGZLLlv5diqdrVWGSPLETmr
	 GgaHelY1xbnWvMijJAVbfC/Nlf507oQ+oaZ+umXTLJuFhZoP6rtEHnz5rEDkb327r3
	 83HLqAegrH1CA==
Date: Thu, 4 Apr 2024 12:51:59 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: hsr: Provide RedBox support (HSR-SAN)
Message-ID: <20240404125159.721fbc19@wsk>
In-Reply-To: <168c9226d2cac6a5a53ce33ef1f76b99a02bedcb.camel@redhat.com>
References: <20240402085850.229058-1-lukma@denx.de>
	<168c9226d2cac6a5a53ce33ef1f76b99a02bedcb.camel@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2tuYs_oCKZ5lyc/yz2.Ps0l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/2tuYs_oCKZ5lyc/yz2.Ps0l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On Tue, 2024-04-02 at 10:58 +0200, Lukasz Majewski wrote:
> > Introduce RedBox support (HSR-SAN to be more precise) for HSR
> > networks. Following traffic reduction optimizations have been
> > implemented:
> > - Do not send HSR supervisory frames to Port C (interlink)
> > - Do not forward to HSR ring frames addressed to Port C
> > - Do not forward to Port C frames from HSR ring
> > - Do not send duplicate HSR frame to HSR ring when destination is
> > Port C
> >=20
> > The corresponding patch to modify iptable2 sources has already been
> > sent:
> > https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
> >=20
> > Testing procedure:
> > ------------------
> > The EVB-KSZ9477 has been used for testing on net-next branch
> > (SHA1: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f).
> >=20
> > Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for
> > ports 1/2 (with HW offloading for ksz9477) was created. Port 3 has
> > been used as interlink port (single USB-ETH dongle).
> >=20
> > Configuration - RedBox (EVB-KSZ9477):
> > if link set lan1 down;ip link set lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > interlink lan3 supervision 45 version 1 ip link set lan4 up;ip link
> > set lan5 up ip link set lan3 up
> > ip addr add 192.168.0.11/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > Configuration - DAN-H (EVB-KSZ9477):
> >=20
> > ip link set lan1 down;ip link set lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > supervision 45 version 1 ip link set lan4 up;ip link set lan5 up
> > ip addr add 192.168.0.12/24 dev hsr1
> > ip link set hsr1 up
> >=20
> > This approach uses only SW based HSR devices (hsr1).
> >=20
> > --------------          -----------------       ------------
> > DAN-H  Port5 | <------> | Port5         |       |
> >        Port4 | <------> | Port4   Port3 | <---> | PC
> >              |          | (RedBox)      |       | (USB-ETH)
> > EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> > --------------          -----------------       ------------
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> This is 'net-next' patch, you must insert the target tree in the subj
> prefix.

Ok. I will add it in v5.

>=20
> Does not apply cleanly to 'net-next', please rebase.
>=20

This patch depends on:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D10e52ad5ced2

which already has been pulled to net-vanila/main
(git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net)

Apparently, I need to wait until net-next would is rebased on top of the
above tree.

> Introducing a new functionality, this deserve some paired self-tests.=20

I see. I can try to add something similar to
/tools/testing/selftests/net/hsr/hsr_ping.sh

to show the RedBox functionality.

> Does this have specific H/W requirement or can it run e.g. on top of
> veths?

I'm testing this code on two EVB-KSZ9477 boards. It _shall_ work also on
veths.

> If the latter applies, please bundle some basic test with the
> next revision (separate patch, same series).
>=20

Ok.

> > @@ -561,6 +582,37 @@ void hsr_prune_nodes(struct timer_list *t)
> >  		  jiffies + msecs_to_jiffies(PRUNE_PERIOD));
> >  }
> > =20
> > +void hsr_prune_proxy_nodes(struct timer_list *t)
> > +{
> > +	struct hsr_priv *hsr =3D from_timer(hsr, t,
> > prune_proxy_timer);
> > +	unsigned long timestamp;
> > +	struct hsr_node *node;
> > +	struct hsr_node *tmp;
> > +
> > +	spin_lock_bh(&hsr->list_lock);
> > +	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db,
> > mac_list) {
> > +		timestamp =3D node->time_in[HSR_PT_INTERLINK];
> > +
> > +		/* Prune old entries */
> > +		if (time_is_before_jiffies(timestamp +
> > +
> > msecs_to_jiffies(HSR_PROXY_NODE_FORGET_TIME))) {
> > +			hsr_nl_nodedown(hsr, node->macaddress_A);
> > +			if (!node->removed) {
> > +				list_del_rcu(&node->mac_list);
> > +				node->removed =3D true;
> > +				/* Note that we need to free this
> > entry later: */
> > +				kfree_rcu(node, rcu_head);
> > +			}
> > +		}
> > +	}
> > +
> > +	spin_unlock_bh(&hsr->list_lock);
> > +
> > +	/* Restart timer */
> > +	mod_timer(&hsr->prune_proxy_timer,
> > +		  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
> > =20
>=20
> AFAICS this timer not explicitly cancelled at hsr port tear-down time.
>=20
> What prevent it from expiring after a port has been deleted and
> causing UaF?
>=20

The purpose of this timer is to periodically call
hsr_prune_proxy_node() function (presented above your reply), which
internally uses list_for_each_entry_safe() to iterate over available
RedBox nodes.

If there are none available, the function just re-sets the timer to
the next PRUNE_PROXY_PERIOD.

In the same way works the timer for hsr_prune_node() function, which
removes stalled HSR nodes.

> Cheers,
>=20
> Paolo
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/2tuYs_oCKZ5lyc/yz2.Ps0l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYOhk8ACgkQAR8vZIA0
zr3xTAf/bb5rdgPpVrlVqowjRP6eM+4Haptg/NBK+ZLilY9NsJTsjNLMCorbZlKe
3ICvyAa4SoQyA8DZ2Q1826BnytlAGr4UgplAMyTWRMJpoJpDgl0WniiSJFRvPUAK
oAXVadGHx7JOcSooiiv5FQDFVwyxDkw6WNWK+AZnn+IpGym2O/eL5BnDMjQwJjjS
YUsPxXi5tKXGXQUslHj0Sor9zfJXvL4/oXcFiiVXLINf9nZbuVZ6KoznCPUOKbNk
4b+vwevnV/8UFqn+ztKVfVA+BhfsbyTfA1P8dUgnJ5cqECLIiCfpkr5fSz0L8voF
asODAcmz3JuZgSJrtBKhkAIfDyWKuQ==
=fm2p
-----END PGP SIGNATURE-----

--Sig_/2tuYs_oCKZ5lyc/yz2.Ps0l--

