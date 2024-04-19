Return-Path: <linux-kernel+bounces-151246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D068AABB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DE1282517
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723257BB07;
	Fri, 19 Apr 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WXBK3ije"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA42AE75
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520028; cv=none; b=IBwJkqaZlYjKPun+FMR6D5Iy9umO8EvhH0wTenvkw53KFj4T//weLVivq5qR1w6GKJj0nM6SoqcR98q18mT14b88yay4jd3mgQ6Ez6YJoHuyc0/p0ETmkd3vk3re/rYpoWji8rzc39xA9csSecr9ZuYMFIeujzMjHz/WcsNreBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520028; c=relaxed/simple;
	bh=N/f1o95G/VJkj66uEFyQmlLCwLdEPKRS4xZy8zzcA38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgWZ0av0yAYtwxBW4LtRjzuibztfsuG+FNZsLBaQSFJt0Ew8PrOyIss8SN1XjiRKkGgygACYK4nfqulMa5k8u+YJqmWQMD1ygBCX7eLsVA4UlHdGOHj2aZiZ/ZAeFeJqj1zTk4dgpPUUaFzfYjCvmOrEfYOhiASYBr7gYsl/o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WXBK3ije; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AADA240006;
	Fri, 19 Apr 2024 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713520023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhQrAdSZcWxsBtjX37nSDsEa6NJe/8r/3/BaJkYjzC4=;
	b=WXBK3ije6R0FhQbdMrBFErkSb3k8NZ67kO495uQot5nnroYCpmMt1l8CZEakJR8AuVAUKl
	kRzCJkkuDztiiaISHw8tCV0pYmmLQ+ERKZnKCxLPELDq2NLwdb2D3Tt1h3QMCnwUR8nNbU
	mGp+lRX7YhVT5RNCAoZogu+oT9FFJPGJuWCHkjLtLTCjZ0L2AWJMEL5yB0tV1dSgdaLMpo
	xBYCPGoQ/UWiW94fErvRP9hTKDucgOajnznqh4bnB4nCS+rJXCR19tE9wiE8nsLOhPrp8s
	6o2K9uTMQqof0WfzCkF70dDCl/3fVzFYAH3vLIj0pVuBQwaFqFaG+1i9h+9eQg==
Date: Fri, 19 Apr 2024 11:46:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <20240419114507.5d25d8cd@xps-13>
In-Reply-To: <ZiEHUz3wicDJscGP@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
	<ZiDCKGlG4MZ23Tqo@pengutronix.de>
	<20240418113244.6e535d3f@xps-13>
	<ZiEHUz3wicDJscGP@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Sascha,

s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 13:43:15 +0200:

> On Thu, Apr 18, 2024 at 11:32:44AM +0200, Miquel Raynal wrote:
> > Hi Sascha,
> >=20
> > s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 08:48:08 +0200:
> >  =20
> > > On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote: =20
> > > > The NAND core enabled subpage reads when a largepage NAND is used w=
ith
> > > > SOFT_ECC. The i.MX NAND controller doesn't support subpage reads, so
> > > > clear the flag again.
> > > >=20
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw=
/mxc_nand.c
> > > > index f44c130dca18d..19b46210bd194 100644
> > > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > > @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_device=
 *pdev)
> > > >  	if (err)
> > > >  		goto escan;
> > > > =20
> > > > +	this->options &=3D ~NAND_SUBPAGE_READ;
> > > > +   =20
> > >=20
> > > Nah, it doesn't work like this. It turns out the BBT is read using
> > > subpage reads before we can disable them here.
> > >
> > > This is the code in nand_scan_tail() we stumble upon:
> > >=20
> > > 	/* Large page NAND with SOFT_ECC should support subpage reads */
> > > 	switch (ecc->engine_type) {
> > > 	case NAND_ECC_ENGINE_TYPE_SOFT:
> > > 		if (chip->page_shift > 9)
> > > 			chip->options |=3D NAND_SUBPAGE_READ;
> > > 		break;
> > >=20
> > > 	default:
> > > 		break;
> > > 	}
> > >=20
> > > So the code assumes subpage reads are ok when SOFT_ECC is in use, whi=
ch
> > > in my case is not true. I guess some drivers depend on the
> > > NAND_SUBPAGE_READ bit magically be set, so simply removing this code =
is
> > > likely not an option.  Any ideas what to do? =20
> >=20
> > Can you elaborate why subpage reads are not an option in your
> > situation? While subpage writes depend on chip capabilities, reads
> > however should always work: it's just the controller selecting the
> > column where to start and then reading less data than it could from the
> > NAND cache. It's a very basic NAND controller feature, and I remember
> > this was working on eg. an i.MX27. =20
>=20
> On the i.MX27 reading a full 2k page means triggering one read operation
> per 512 bytes in the NAND controller, so it would be possible to read
> subpages by triggering only one read operation instead of four in a row.
>=20
> The newer SoCs like i.MX25 always read a full page with a single read
> operation. We could likely read subpages by temporarily configuring the
> controller for a 512b page size NAND.
>=20
> I just realized the real problem comes with reading the OOB data. With
> software BCH the NAND layer hardcodes the read_subpage hook to
> nand_read_subpage() which uses nand_change_read_column_op() to read the
> OOB data. This uses NAND_CMD_RNDOUT and I have now idea if/how this can
> be implemented in the i.MX NAND driver. Right now the controller indeed
> reads some data and then the SRAM buffer really contains part of the
> desired OOB data, but also part of the user data.

NAND_CMD_RNDOUT is impossible to avoid, the controller surely supports
it and the core really need it anyway. Basically reading from a NAND
chip is a matter of:

- asking the chip to "sample" the NAND array and store a full page
  (data+OOB) in its internal SRAM
- waiting for it to happen
- reading from the chip's SRAM, any length, any offset. Of course the
  offset and length must be aligned with the on-host ECC engine when
  there is one.

Supporting this command must be straightforward with ->exec_op(), here
is the pattern:
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_ba=
se.c#L1454

> We might overcome these problems, but I am not sure if it's worth it.
> It's ancient hardware that I don't want to put too much effort into and
> I doubt that the end result would have a better performance when we need
> one operation to read the subpage and another one to read OOB as opposed
> to always read full pages

We shall definitely avoid doing several read operations, but as
explained above, you can move the internal SRAM pointer at no cost
("read from cache" commands, named "changed_column" in the core), so the
performance penalty is negligible.

> (which is only one operation, say one
> interrupt latency, for each page read).

The mxc_nand.c driver was my first ever NAND controller driver re-write
but unfortunately the quality was too bad for being submitted at that
time. My goal was the same as yours. Quickly after we introduced
->exec_op() and thus my initial re-work was trash. But I think it was
close to this:
https://github.com/miquelraynal/linux/blob/perso/mtd-next/mxc-nand/drivers/=
mtd/nand/mxc_nand_v2.c
Maybe that can help.

Thanks,
Miqu=C3=A8l

