Return-Path: <linux-kernel+bounces-14560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D7821EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A0B2213A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9814A82;
	Tue,  2 Jan 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SpiV+e8P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76E1428F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6B84E0004;
	Tue,  2 Jan 2024 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704209456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVkUZtCoJ0PLxbT31hNw8JIujnmgBU1jb9uMipLskIY=;
	b=SpiV+e8P1G8/5jZ6/W7DIVFBorfUsfCAMKC9BL+/hjUWxQwY+OZ/GIoQLe3MIkpSLcmjqw
	cc5N2Xvcw7jQ4mDgo0AMDT6c3XAztEwuSb3p8YqvywbMh8rUArvju8boimN1f35mCyTBEH
	KkPfX+lTiAQI+ehX+/ToljnFyh7YNyi81ZpfSNA+s6ziSyuSaWOiozTsZahaUs7nDb3HiX
	3Ld4GnkMcfRqfZ/KRa+7TJqvN8fKsJ+z4ZHLNmMNu9DN+C/5dmI47gDbCcqxdhLWsvwgsW
	jNAxNxxv4RN9d+KI8YOWXq2KNzjHZNXckHqeO534egdp/CXwYC3h1VOvzFiRcg==
Date: Tue, 2 Jan 2024 16:30:54 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, =?UTF-8?B?UmFmYcWCIE1pxYJl?=
 =?UTF-8?B?Y2tp?= <rafal@milecki.pl>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: fix nvmem cells not being available in
 notifiers
Message-ID: <20240102163054.4c45d2e4@xps-13>
In-Reply-To: <20240102144631.18fda3dc@booty>
References: <20231229-nvmem-cell-add-notification-v1-1-8d8b426be9f9@bootlin.com>
	<20240102103503.5310aa4b@xps-13>
	<20240102144631.18fda3dc@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Luca,

[...]

> > Could we rename new_notified into something like "is_addition"? It took
> > me a bit of time understanding what this boolean meant. =20
>=20
> Let me explain better the idea. This is the value that
> cell->notified_add gets over time:
>=20
>  1. at initialization: 0
>  2. when calling nvmem_cell_notify(cell, NVMEM_CELL_ADD): 1
>     and ADD notifier functions are called
>  3. if calling nvmem_cell_notify(cell, NVMEM_CELL_ADD) again
>     nothing happens
>  4. when calling nvmem_cell_notify(cell, NVMEM_CELL_REMOVE): 0
>     and REMOVE notifier functions are called
>  5. if calling nvmem_cell_notify(cell, NVMEM_CELL_REMOVE) again
>     nothing happens
>=20
> So it avoids calling multiple notifiers both for addition, which is the
> main goal, but also for removal. I understand there is probably no code
> path for multiple removal calls, so maybe this is not useful.

Ok, that's clear now, I was on the wrong path, not because of the
naming, but because you also focused on the REMOVE, while I was not
expecting anything on that side.

> I tried to find a good variable name to express this, and failed. :)
>=20
> > > +	int was_notified =3D atomic_xchg(&cell->notified_add, new_notified);
> > > +
> > > +	if (new_notified !=3D was_notified)   =20
>=20
> The "{was,new}_notified" names in my mind mean "{old,new} value of the
> atomic flag". Thus "if (new_notified !=3D was_notified)" means "if there
> is a change of state, then notify it".
>=20
> > I believe what you want is (with my terms):
> >=20
> > 	if ((is_addition && !was_notified) || !is_addition)
> >  =20
> > > +		blocking_notifier_call_chain(&nvmem_notifier, event, cell);   =20
> >=20
> > I believe your if condition works, but is a bit complex to read. Is
> > there a reason for the following condition ?
> >=20
> > 	(new_notified :=3D 0) /*removal */ !=3D (was_notified :=3D 1) =20
>=20
> From my explanation above, it is hopefully now clear that this means:
>=20
>  (new_notified :=3D 0, i.e. we are having a removal event) !=3D
>  (was_notified :=3D 1, i.e. the last even notified was not a removal)
>=20
> That said, I'm open to remove this logic, and on cell removal just
> unconditionally send a notifier, probably without changing the variable
> value:
>=20
>   if (removal || !notify_cell_additions(&cell->notified_add, 1)

Yes, I see no use of the atomic counter in the right path for now, so
I'd suggest to keep the logic simpler for now, if you don't mind.

> > > @@ -1033,6 +1057,13 @@ struct nvmem_device *nvmem_register(const stru=
ct nvmem_config *config)
> > > =20
> > >  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> > > =20
> > > +	/* After device_add() it is now OK to notify of new cells */
> > > +	nvmem->do_notify_cell_add =3D true;   =20
> >=20
> > Could we rename this as well to be simpler? Like
> > "notify_cell_additions" or "cells_can_be_notified"? =20
>=20
> "notify_cell_additions" seems the best, thanks for the suggestion.
>=20
> > I am actually
> > asking myself whether this boolean is useful. In practice we call the
> > notifier after setting this to true. On the other hand, the layouts
> > will only probe after the device_add(), so they should be safe? =20
>=20
> What if the module implementing the layout is loaded after
> nvmem_register() finished? of_nvmem_cell_get() ->
> nvmem_layout_module_get_optional() -> try_module_get() should allow
> that, but I may be missing something.

Consumers should get -EPROBE_DEFER in this case. They can either try it
later or... wait on the notifier :)

Thanks,
Miqu=C3=A8l

