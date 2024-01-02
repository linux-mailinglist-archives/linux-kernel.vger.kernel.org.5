Return-Path: <linux-kernel+bounces-14435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C31821D06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4BF282589
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D679FBEF;
	Tue,  2 Jan 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fgh8a228"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2FFBFC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 691EFC0004;
	Tue,  2 Jan 2024 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704203193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpdNSC5IuCY+6e4r3FqtxNS/g1BqEmZKastPqwFh5Xo=;
	b=fgh8a228/bJLZra8H3LDG7kknxSZI4RlqxWmYqAhLoh0+BMb/bVcimgLcIV8xiebmcOD5a
	RHx8AoESPPzsTE6a3iXCU3nYYFWEMlMR2DSt6OgXAhQnfnS9rNtHYHJHzfRvNnatt3WRl9
	+rFd/bA7wv9aZycwT9FdHhI36Kmw39DV37U7/cVCeNkjwKt/Qn6Lvssmlkdy82lR+pX/eE
	5OgxCWitSKsljwRuQP96NcSMGlRiPxz1mG+YYV8YumNFCp8O38eGd1YQuZYMN5MrKIEJb8
	+COlcklEkgBT2IgTPq+uDWOxms8NmD5Q2ARtmU9mkW/Srl55yfTCbqwWjmomGA==
Date: Tue, 2 Jan 2024 14:46:31 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, =?UTF-8?Q?Rafa=C5=82_Mi?=
 =?UTF-8?Q?=C5=82ecki?= <rafal@milecki.pl>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: fix nvmem cells not being available in
 notifiers
Message-ID: <20240102144631.18fda3dc@booty>
In-Reply-To: <20240102103503.5310aa4b@xps-13>
References: <20231229-nvmem-cell-add-notification-v1-1-8d8b426be9f9@bootlin.com>
	<20240102103503.5310aa4b@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

On Tue, 2 Jan 2024 10:35:03 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > Solve this by adding a flag in struct nvmem_device to block all
> > notifications before calling device_add(), and keep track of whether ea=
ch
> > cell got notified or not, so that exactly one notification is sent ber =
=20
>=20
> 								     per?

Sure.

> > +/*
> > + * Send cell add/remove notification unless it has been already sent.
> > + *
> > + * Uses and updates cell->notified_add to avoid duplicates.
> > + *
> > + * Must never be called with NVMEM_CELL_ADD after being called with
> > + * NVMEM_CELL_REMOVE.
> > + *
> > + * @cell: the cell just added or going to be removed
> > + * @event: NVMEM_CELL_ADD or NVMEM_CELL_REMOVE
> > + */
> > +static void nvmem_cell_notify(struct nvmem_cell_entry *cell, unsigned =
long event)
> > +{
> > +	int new_notified =3D (event =3D=3D NVMEM_CELL_ADD) ? 1 : 0; =20
>=20
> The ternary operator is not needed here, (event =3D=3D VAL) will return t=
he
> correct value.

OK.

> Could we rename new_notified into something like "is_addition"? It took
> me a bit of time understanding what this boolean meant.

Let me explain better the idea. This is the value that
cell->notified_add gets over time:

 1. at initialization: 0
 2. when calling nvmem_cell_notify(cell, NVMEM_CELL_ADD): 1
    and ADD notifier functions are called
 3. if calling nvmem_cell_notify(cell, NVMEM_CELL_ADD) again
    nothing happens
 4. when calling nvmem_cell_notify(cell, NVMEM_CELL_REMOVE): 0
    and REMOVE notifier functions are called
 5. if calling nvmem_cell_notify(cell, NVMEM_CELL_REMOVE) again
    nothing happens

So it avoids calling multiple notifiers both for addition, which is the
main goal, but also for removal. I understand there is probably no code
path for multiple removal calls, so maybe this is not useful.

I tried to find a good variable name to express this, and failed. :)

> > +	int was_notified =3D atomic_xchg(&cell->notified_add, new_notified);
> > +
> > +	if (new_notified !=3D was_notified) =20

The "{was,new}_notified" names in my mind mean "{old,new} value of the
atomic flag". Thus "if (new_notified !=3D was_notified)" means "if there
is a change of state, then notify it".

> I believe what you want is (with my terms):
>=20
> 	if ((is_addition && !was_notified) || !is_addition)
>=20
> > +		blocking_notifier_call_chain(&nvmem_notifier, event, cell); =20
>=20
> I believe your if condition works, but is a bit complex to read. Is
> there a reason for the following condition ?
>=20
> 	(new_notified :=3D 0) /*removal */ !=3D (was_notified :=3D 1)

=46rom my explanation above, it is hopefully now clear that this means:

 (new_notified :=3D 0, i.e. we are having a removal event) !=3D
 (was_notified :=3D 1, i.e. the last even notified was not a removal)

That said, I'm open to remove this logic, and on cell removal just
unconditionally send a notifier, probably without changing the variable
value:

  if (removal || !notify_cell_additions(&cell->notified_add, 1)

> > @@ -1033,6 +1057,13 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> > =20
> >  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> > =20
> > +	/* After device_add() it is now OK to notify of new cells */
> > +	nvmem->do_notify_cell_add =3D true; =20
>=20
> Could we rename this as well to be simpler? Like
> "notify_cell_additions" or "cells_can_be_notified"?

"notify_cell_additions" seems the best, thanks for the suggestion.

> I am actually
> asking myself whether this boolean is useful. In practice we call the
> notifier after setting this to true. On the other hand, the layouts
> will only probe after the device_add(), so they should be safe?

What if the module implementing the layout is loaded after
nvmem_register() finished? of_nvmem_cell_get() ->
nvmem_layout_module_get_optional() -> try_module_get() should allow
that, but I may be missing something.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

