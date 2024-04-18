Return-Path: <linux-kernel+bounces-149815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459758A9638
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A32B22D73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E515AD99;
	Thu, 18 Apr 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ms9IXqwj"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CD152E12
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432778; cv=none; b=JR/rjYQsvYNN8/1beZGy5tnWXIVJ+KO3SjyfooqRsMYNocnFgF9M7BSjjIFJqh590kgb8HB0SA4MTZ+Gq0bfa0V+MaCwdx3jXFCtRwq2b0qataqib6/DP7b/rSDw2SO96eEtcig1RPpungss73TVjiXL4MXVd7Nja+su9ualobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432778; c=relaxed/simple;
	bh=czpHuSfmFmq28Juu4Px/29sZ1qqoPkDuOD9pxx2kfWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bedl/l3tzHZgq2vZHQLsccVh0pPrmFpX/Ctrv69np6sRGO45XOtkP3P78xfYb8TZppKN1k8m2xS7zpA8PQcrZjZx7SQXJKTO5lNGrucZTPWDtcvrgh9P/NiLeXwRIX5SWqceIctCmwZS0GLSI/oFa+X5PL8psse7ppFkPs0lX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ms9IXqwj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BEFD1BF213;
	Thu, 18 Apr 2024 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713432767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnS9+FdxrmLsw9rMPbFlN43vqt5uCeXtLqiiBEoSh30=;
	b=Ms9IXqwjiQ5l+EkNE1vgQWTvVP35KHoPgVFEBgMmV800y18fc3DGmOKwuVNs9cF9+h1tuo
	AlnZumBLSJMvscZODtx9c/ZuuOHBU8DYD94GRBELVp5MVAMNwj761/xQbaKbnb0dXRtFyp
	YYGJ7SLo6EPqZbSWmqLss5mWR5QE5wHXQ8M4aD/KKvgeUKIbQ48z6bhAsLN1iZNO8dMnTq
	K0oHZ9oto3u83m47CXvsbUAcR2SI5U9fNR0D6fRBDFYDdI6q4/SmW6gEMOGgx/gY6m5amP
	Wpzz0ok4Va28Li30uYOyT2da+gjulRsI5jwy+jYpDleGicMausXUsd9BlJNbEw==
Date: Thu, 18 Apr 2024 11:32:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <20240418113244.6e535d3f@xps-13>
In-Reply-To: <ZiDCKGlG4MZ23Tqo@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
	<ZiDCKGlG4MZ23Tqo@pengutronix.de>
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

s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 08:48:08 +0200:

> On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote:
> > The NAND core enabled subpage reads when a largepage NAND is used with
> > SOFT_ECC. The i.MX NAND controller doesn't support subpage reads, so
> > clear the flag again.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc=
_nand.c
> > index f44c130dca18d..19b46210bd194 100644
> > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_device *pd=
ev)
> >  	if (err)
> >  		goto escan;
> > =20
> > +	this->options &=3D ~NAND_SUBPAGE_READ;
> > + =20
>=20
> Nah, it doesn't work like this. It turns out the BBT is read using
> subpage reads before we can disable them here.
>
> This is the code in nand_scan_tail() we stumble upon:
>=20
> 	/* Large page NAND with SOFT_ECC should support subpage reads */
> 	switch (ecc->engine_type) {
> 	case NAND_ECC_ENGINE_TYPE_SOFT:
> 		if (chip->page_shift > 9)
> 			chip->options |=3D NAND_SUBPAGE_READ;
> 		break;
>=20
> 	default:
> 		break;
> 	}
>=20
> So the code assumes subpage reads are ok when SOFT_ECC is in use, which
> in my case is not true. I guess some drivers depend on the
> NAND_SUBPAGE_READ bit magically be set, so simply removing this code is
> likely not an option.  Any ideas what to do?

Can you elaborate why subpage reads are not an option in your
situation? While subpage writes depend on chip capabilities, reads
however should always work: it's just the controller selecting the
column where to start and then reading less data than it could from the
NAND cache. It's a very basic NAND controller feature, and I remember
this was working on eg. an i.MX27.

Thanks,
Miqu=C3=A8l

