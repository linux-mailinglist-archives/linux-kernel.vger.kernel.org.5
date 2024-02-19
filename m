Return-Path: <linux-kernel+bounces-71172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6085A19A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836AA1F228BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF028E39;
	Mon, 19 Feb 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XoPxeI8r"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED861C10
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340666; cv=none; b=DKW2omc7c1WbLDcEl5SYsc0K72yQ1M5iLVUYTWhcXlu9hNHpChq/o4CDs7MlVqpY+u53sQLbYoaKNGbvlQ/K6gt/h6cuDG1e7zIaaejN/vGzrVBw5zP9WX37Sft8IPYYLIXyeypMlgxiRvRDicQ5WH060om+0wneVHtR/3+4wKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340666; c=relaxed/simple;
	bh=/w0iYygLzqoKWkoa611dONSmQSfaIjtKlgKCivWQdS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBvb3zHCXB83QcjYn+uEFfs4P7grfjJVXCizRZsCrKj0wK70Ua9U7Lwi90QLzeQH/FfeU08vycyAQKaTDNMbYaS6nRD1G/lXq76ACNVg7HwUH6fBRmhOWottp7qiO3a5q+yV+kA24uS/tzlovJP2+L8AW0VfGtmq0WShUmRt5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XoPxeI8r; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97AD4E000E;
	Mon, 19 Feb 2024 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708340656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8NgPd3ichHUKUe1/b2p+TzQDwQB7pbYETz/ptF4PXI=;
	b=XoPxeI8rJLGBVbcQ6ynl63IreWXv4XK5NDJha/2Xm5BetwHusMR0B8bUU87kdPC+3i2VW9
	wYF+jzFrrzbrAH1d3iimT/oAb0HJko4hmhyKvtEkZUSdqyy2+P9seIiuFqETb+w1ZXGNl1
	SIPtsa+2fwlowOpH/G9dTu/JLTMlPxBQ63p7Qaa2G8A6qiy7cSZV1/RJDXi0Q8BDmQDuo6
	C2lZp3T9l1sQYdd6YzzjjnW4NYMLex3rrktEeQoTOmoU/ECONU7VjC5T9JiLSf1m4BF++w
	YgmsMBuhSMt1GeTjH8vf30JOPqyM4f/xcjyW9XSDAIs6OqrXW9Scg1pBUvRXnw==
Date: Mon, 19 Feb 2024 12:04:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Walle <michael@walle.cc>, srinivas.kandagatla@linaro.org,
 gregkh@linuxfoundation.org, rafal@milecki.pl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240219120414.32395299@xps-13>
In-Reply-To: <20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
	<CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
	<20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
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

Hi Marco,

m.felsch@pengutronix.de wrote on Fri, 16 Feb 2024 11:07:50 +0100:

> Hi Michael,
>=20
> On 24-02-16, Michael Walle wrote:
> > Hi,
> >=20
> > On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote: =20
> > > @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct nvme=
m_device *nvmem)
> > >  	struct bin_attribute **cells_attrs, *attrs;
> > >  	struct nvmem_cell_entry *entry;
> > >  	unsigned int ncells =3D 0, i =3D 0;
> > > +	umode_t mode;
> > >  	int ret =3D 0;
> > > =20
> > >  	mutex_lock(&nvmem_mutex);
> > > @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struct nv=
mem_device *nvmem)
> > >  		goto unlock_mutex;
> > >  	}
> > > =20
> > > +	mode =3D nvmem_bin_attr_get_umode(nvmem);
> > > +
> > >  	/* Initialize each attribute to take the name and size of the cell =
*/
> > >  	list_for_each_entry(entry, &nvmem->cells, node) {
> > >  		sysfs_bin_attr_init(&attrs[i]);
> > >  		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> > >  						    "%s@%x", entry->name,
> > >  						    entry->offset);
> > > -		attrs[i].attr.mode =3D 0444; =20
> >=20
> > cells are not writable if there is a read post process hook, see
> > __nvmem_cell_entry_write().
> >=20
> > if (entry->read_post_processing)
> > 	mode &=3D ~0222; =20
>=20
> good point, thanks for the hint :) I will add this and send a non-rfc
> version if write-support is something you would like to have.

I like the idea but, what about mtd devices (and soon maybe UBI
devices)? This may only work on EEPROM-like devices I guess, where each
area is fully independent and where no erasure is actually expected.

Thanks,
Miqu=C3=A8l

