Return-Path: <linux-kernel+bounces-72678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38885B71F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98369B221A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B85F49E;
	Tue, 20 Feb 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0/EgpDA"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D145F48B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420702; cv=none; b=mExRpfx0I18w15yRAgu/d5mwrnJqi2FFfYnptu8QtxAYRYRpnyN4vsAl4VtBQM+KKTsm4kLUVbTxLrouZpMvVs9AHbF+BOq5QzyBIV87MX42kLBNS4fM1nNlbQlLdISyhpV01zVC0pKML4hxqUuFSychu4wKII1q+ljlPWp9AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420702; c=relaxed/simple;
	bh=jyLisBBsUsR2S+kPcIwoLOu5UYzsXpqRAZDHmhO3JZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPpXU+REXxJ3c8A2FdVVzC6EHHz6OBqidHqWX31wPGjoGVC2/jogo7GX8ESDllBTnGw0l8BpAfPZfUXzldeCPcP5HrZmUMaHD+X/LVe9vO1fI5xMao6ML2fXVAq7/PtcR1OIcrKxh45pQso2buSd9BYxb9NS0eAqPgV0zm3a5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0/EgpDA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44C7AC0002;
	Tue, 20 Feb 2024 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708420692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JPIFRzlGA21yLmZ0slFed1Pl8wlBq4KTEtX5lFQVNQ=;
	b=Y0/EgpDAoWnQiXAIoL9STSqLvFb0muwWJHYQpvzL2vtdA4T/Duf3fmT6Qy9vFS+JjJ5des
	ev/vklnf4aUY0v16XxuUIzXkW7NDQM2lKRcZzkCWtS3VSmSPTkvTpyISkCct/wzha9UAm3
	+WMO2HNdo6ELlxlDI6hH2bjZGdwlMm4WcbcB+732/4l+NvvCrOLaWNa5A94TdslvAsrLRc
	DX7+6VdXHHIxApYtp4HhkI8CBdU5SF8Ks4WxM2auql6Z2CCdSLcbxie4zb4y0Vkos2lc+v
	N7PTPa5BL8PQgg4fHhOlB2FZNqsJ8f8nTWnvS4LaydguNZ+E6iPW6uayFoYsGw==
Date: Tue, 20 Feb 2024 10:18:11 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <michael@walle.cc>
Cc: "Marco Felsch" <m.felsch@pengutronix.de>,
 <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
 <rafal@milecki.pl>, <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240220101811.6ae23f2e@xps-13>
In-Reply-To: <CZ938PEUZ1JQ.2DJE7C03HI9OO@walle.cc>
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
	<CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
	<20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
	<20240219120414.32395299@xps-13>
	<20240219115358.xui5fpoisvsubdyb@pengutronix.de>
	<CZ938PEUZ1JQ.2DJE7C03HI9OO@walle.cc>
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

Hi,

michael@walle.cc wrote on Mon, 19 Feb 2024 14:26:16 +0100:

> On Mon Feb 19, 2024 at 12:53 PM CET, Marco Felsch wrote:
> > On 24-02-19, Miquel Raynal wrote: =20
> > > Hi Marco,
> > >=20
> > > m.felsch@pengutronix.de wrote on Fri, 16 Feb 2024 11:07:50 +0100:
> > >  =20
> > > > Hi Michael,
> > > >=20
> > > > On 24-02-16, Michael Walle wrote: =20
> > > > > Hi,
> > > > >=20
> > > > > On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote:   =20
> > > > > > @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struc=
t nvmem_device *nvmem)
> > > > > >  	struct bin_attribute **cells_attrs, *attrs;
> > > > > >  	struct nvmem_cell_entry *entry;
> > > > > >  	unsigned int ncells =3D 0, i =3D 0;
> > > > > > +	umode_t mode;
> > > > > >  	int ret =3D 0;
> > > > > > =20
> > > > > >  	mutex_lock(&nvmem_mutex);
> > > > > > @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(str=
uct nvmem_device *nvmem)
> > > > > >  		goto unlock_mutex;
> > > > > >  	}
> > > > > > =20
> > > > > > +	mode =3D nvmem_bin_attr_get_umode(nvmem);
> > > > > > +
> > > > > >  	/* Initialize each attribute to take the name and size of the=
 cell */
> > > > > >  	list_for_each_entry(entry, &nvmem->cells, node) {
> > > > > >  		sysfs_bin_attr_init(&attrs[i]);
> > > > > >  		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNE=
L,
> > > > > >  						    "%s@%x", entry->name,
> > > > > >  						    entry->offset);
> > > > > > -		attrs[i].attr.mode =3D 0444;   =20
> > > > >=20
> > > > > cells are not writable if there is a read post process hook, see
> > > > > __nvmem_cell_entry_write().
> > > > >=20
> > > > > if (entry->read_post_processing)
> > > > > 	mode &=3D ~0222;   =20
> > > >=20
> > > > good point, thanks for the hint :) I will add this and send a non-r=
fc
> > > > version if write-support is something you would like to have. =20
> > >=20
> > > I like the idea but, what about mtd devices (and soon maybe UBI
> > > devices)? This may only work on EEPROM-like devices I guess, where ea=
ch
> > > area is fully independent and where no erasure is actually expected. =
=20
> >
> > For MTD I would say that you need to ensure that you need to align the
> > cells correctly. The cell-write should handle the page erase/write cycle
> > properly. E.g. an SPI-NOR need to align the cells to erase-page size or
> > the nvmem-cell-write need to read-copy-update the cells if they are not
> > erase-paged aligned.
> >
> > Regarding UBI(FS) I'm not sure if this is required at all since you have
> > an filesystem. IMHO nvmem-cells are very lowelevel and are not made for
> > filesystem backed backends.

I'm really talking about UBI, not UBIFS. UBI is just like MTD but
handles wear leveling. There is a pending series for enabling nvmem
cells on top of UBI.

> > That beeing said: I have no problem if we provide write support for
> > EEPROMs only and adapt it later on to cover spi-nor/nand devices as
> > well. =20
>=20
> Agreed. Honestly, I don't know how much sense this makes for MTD
> devices. First, the operation itself, seems really dangerous, as
> you'll have to delete the whole sector. Second, during initial
> provisioning, I don't think it will make much sense to use the sysfs
> cells because you cannot combine multiple writes into one. You'll
> always end up with unnecessary erases.

One cell per erase block would be an immense waste.
Read-copy-update would probably work but would as well be very
sub-optimal. I guess we could live with it, but as for now there has
not been any real request for it, I'd also advise to keep this feature
out of the mtd world in general.

Thanks,
Miqu=C3=A8l

