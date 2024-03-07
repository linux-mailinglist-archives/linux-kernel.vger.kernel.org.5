Return-Path: <linux-kernel+bounces-95924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1322875507
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58356284BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5856130AFD;
	Thu,  7 Mar 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+B/vQUL"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3C1EB41
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831985; cv=none; b=Pu7zzSdUjFSv7KQurJEZh85CcIoN45Fr+aauVPWR6iGyzewVMF/uqzlDdawsTesMhtRODDb4KZlk2BTE0uFTKDFX2V3Q7n36eJy/hR6bGaIZCvIXyJLBF01dlS5xIyASI7IycdhfcjdRstOxX4cvvf3VNxHQ+3LMPzAQZAVci0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831985; c=relaxed/simple;
	bh=UYN3fJKqIzd0UJvMQfudjlaLr1S5s1O0o0j/Q8krGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGO44ek1/sVK+qhWBqoelWHr+2/NyD1Z27hxZXD7y2IpscwcdHjiQ0wR9quz0OARtITwBUBFQvRuh2APMIohXDtoSehnqYt3BVqHfHWFAl5SThOuMODKFDrA2ctGK45vvL9w5xBBanOxG2eSNeBV7yd9TgyEMx6yM8cPCQ+1g2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+B/vQUL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF46120009;
	Thu,  7 Mar 2024 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709831975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsvVKkm2Eq4sRDhn6wHLtPPoTtBKjkIYcjnZcnmXCvA=;
	b=V+B/vQULtwzwIAJB97EDZWe0axXUQ0UUXt33krajqUQ61dmdA0J9cZ2N5rsmnddecE0/XU
	W+BHhFz7Cz6A6AlcNludhWK+0nDLms0G/PHTNIwWODqTcBFuYOysu2iX8tMeXgfxVBN2xD
	RrznmU/nqiJzHXkIti0Cq5nZU92grRupdftwPuvIwNrGx0xwA1wf8K01zzH/uUes8l0yle
	urURw8u8uhMwfopUpuu9+33hg5fwYNZO6kOseTI8vQquU2UYJRdm9a3m0stB2vRBHjIn9P
	1VDDCSqTJHBeVXRvFoQ/vX2HvbxvEw+E70QSwSGgo1zUCMTfuXmZLHJlYpqLYw==
Date: Thu, 7 Mar 2024 18:19:31 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240307181931.440c9c3f@xps-13>
In-Reply-To: <20240307-pantry-deceit-78ce20f47899@thorsis.com>
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
	<20240306164831.29eed907@xps-13>
	<20240307-pantry-deceit-78ce20f47899@thorsis.com>
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

Hi Alexander,

ada@thorsis.com wrote on Thu, 7 Mar 2024 17:02:16 +0100:

> Hello Miquel,
>=20
> thanks for looking into this, see my remarks below.
>=20
> Am Wed, Mar 06, 2024 at 04:48:31PM +0100 schrieb Miquel Raynal:
> > Hi Alexander,
> >=20
> > ada@thorsis.com wrote on Wed, 6 Mar 2024 15:36:04 +0100:
> >  =20
> > > Hello everyone,
> > >=20
> > > I think I found a bug in nand_onfi_detect() which was introduced with
> > > commit c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page
> > > read to constraint controllers") back in 2020. =20
> >=20
> > Interesting. I don't think this patch did broke anything, as
> > constrained controllers would just not support the read_data_op() call
> > anyway.
> >=20
> > That being said, I don't see why the atmel controller would
> > refuse this operation, as it is supposed to support all
> > operations without limitation. This is one of the three issues
> > you have, that probably needs fixing. =20
>=20
> I found a flaw in my debug messages hiding the underlying issue for
> this.  I'm afraid this is another bug introduced by you with commit
> 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only
> once").  See this line in rawnand_check_data_only_read_support():
>=20
>     if (!nand_read_data_op(chip, NULL, SZ_512, true, true))
>=20
> This leads to nand_read_data_op() returning -EINVAL, because it checks
> if its second argument is non-NULL.

Ah, finally. Yes, this makes more sense. I was already notified in
private of something there, I think the contributor (I cannot find the
original mail) told me he would get back on it and did not, but I am
unable to find the thread again in my mailer. Anyhow, this is ringing a
bell, and I am pretty convinced about the bug raised now. Can you
please propose a fix?

You can propose two fixes actually, one for the NULL value and another
one for mtd->writesize being unset at this stage.

IIRC the original reporter told me about bitflips in his parameter page
(which cannot be generated on demand, and this is rather uncommon).

> I guess not only the atmel nand controller is affected here, but _all_
> nand controllers?  The flag can never be set, and so use_datain is
> false here?
>=20
> > > Background on how I found this: I'm currently struggling getting raw
> > > nand flash access to fly with an at91 sam9x60 SoC and a S34ML02G1
> > > Spansion SLC raw NAND flash on a custom board.  The setup is
> > > comparable to the sam9x60 curiosity board and can be reproduced with
> > > that one.
> > >=20
> > > NAND flash on sam9x60 curiosity board works fine with what is in
> > > mainline Linux kernel.  However after removing the line 'rb-gpios =3D
> > > <&pioD 5 GPIO_ACTIVE_HIGH>;' from at91-sam9x60_curiosity.dts all data
> > > read from the flash appears to be zeros only.  (I did not add that
> > > line to the dts of my custom board first, this is how I stumbled over
> > > this.)
> > >=20
> > > I have no explanation for that behaviour, it should work without R/B#
> > > by reading the status register, maybe we investigate that
> > > in depth later. =20
> >=20
> > I don't see why at a first look. The default is "no RB" if no property
> > is given in the DT so it should work. =20
>=20
> Correct, nand_soft_waitrdy() is used in that case.
>=20
> > Tracing the wait ready function calls might help. =20
>=20
> Did that already.  On each call here the status register read contains
> E0h and nand_soft_waitrdy() returns without error, because the
> NAND_STATUS_READY flag is set.  It just looks fine, although it is
> not afterwards.

Strange. Just to be sure, how are you testing? Please make a single
page read (minimal length with mtd_debug or any length with nanddump) to
be sure you're not affected by the continuous reads bugs (also mine).

> > >  However those all zeros data reads happens when
> > > reading the ONFI param page as well es data read from OOB/spare area
> > > later and I bet it's the same with usual data. =20
> >=20
> > Reading data without observing tWB + tR may lead to this. =20
>=20
> I already suspected some timing issue.  Deeper investigation will have
> to wait until we soldered some wires to the chip and connect a logic
> analyzer however.  At least that's the plan, but this will have to
> wait some days until after I finished some other tasks.

Sure.

>=20
> > > This read error reveals a bug in nand_onfi_detect().  After setting
> > > up some things there's this for loop:
> > >=20
> > >     for (i =3D 0; i < ONFI_PARAM_PAGES; i++) {
> > >=20
> > > For i =3D 0 nand_read_param_page_op() is called and in my case all ze=
ros
> > > are returned and thus the CRC calculated does not match the all zeros
> > > CRC read.  So the usual break on successful reading the first page is
> > > skipped and for reading the second page nand_change_read_column_op()
> > > is called.  I think that one always fails on this line:
> > >=20
> > >     if (offset_in_page + len > mtd->writesize + mtd->oobsize) {
> > >=20
> > > Those variables contain the following values:
> > >=20
> > >     offset_in_page: 256
> > >     len: 256
> > >     mtd->writesize: 0
> > >     mtd->oobsize: 0 =20
> >=20
> > Indeed. We probably need some kind of extra check that does not perform
> > the if clause above if !mtd->writesize.
> >  =20
> > > The condition is true and nand_change_read_column_op() returns with
> > > -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> > > that code path.  Those are probably initialized later, maybe with
> > > parameters read from that ONFI param page?
> > >=20
> > > Returning with error from nand_change_read_column_op() leads to
> > > jumping out of nand_onfi_detect() early, and no ONFI param page is
> > > evaluated at all, although the second or third page could be intact.
> > >=20
> > > I guess this would also fail with any other reason for not matching
> > > CRCs in the first page, but I have not faulty NAND flash chip to
> > > confirm that. =20
> >=20
> > Thanks for the whole report, it is interesting and should lead to fixes:
> > - why does the controller refuses the datain op? =20
>=20
> See above.
>=20
> > - why nand_soft_waitrdy is not enough? =20
>=20
> I don't know.  That's one reason I asked here.
>=20
> > - changing the condition in nand_change_read_column_op()
> >=20
> > Can you take care of these? =20
>=20
> The last one probably after in depth reading of the code again, unsure
> for the other two.

First one is "easy" now I guess?

For the middle one we need more investigation of course.

Thanks for the debugging and sorry for the troubles.

Miqu=C3=A8l

