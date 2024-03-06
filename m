Return-Path: <linux-kernel+bounces-94192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89D873B19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13515281934
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8B135A6F;
	Wed,  6 Mar 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FuUw0xVi"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445F1350FA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740123; cv=none; b=IswU1doaKLRnJzM9hb2by8N1czGxyrSaNmMgu5np+4uUGosE6OZN//kE9tXzT135tsuUAIAdka2FvW4nsdl3whetW383WsEAyWGR3ky2nH+WkLFPA2m/6soqP3gC8GNia0SHnb0FkuhZt1o/KxWY+D/rHsq84DA/jvn6rnxhqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740123; c=relaxed/simple;
	bh=QVVQ1xiFKyBJFe9o+x5uoUD6TLmjiI/YhYSrY81aKUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCXMfxlv6vdr2bxiiObaLjVX0ln/BJ5qrUiy6urR1NnE4c8d9D2DrxcO7bbkyYjSH+CKmwyX88vbSjDENbXzB3kCWm4w8uR6A4CWUSj/lmIhKovxqKh5CZm4skJ6knyd4PuLS3QJoE8fwk4hqVcxFmX2Ct1H7kLbMtEcpCLcML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FuUw0xVi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF22360006;
	Wed,  6 Mar 2024 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709740113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEOdzOBUr0WjDYq1EsFLRmuHaeXeVKpnjrYhZumWSoY=;
	b=FuUw0xViG3lOaqo8K0khqMdjuEJkKhWsTlZRVgouI1do0kSU1DKGfXs5nFNZHW1yGpH9Uo
	PEQjvcE2Re4bOI+mkSQKdT/h9NIxLO8tJB9xqFohVt5izWYPxDWUoUUTJqyQbq/MyIotEb
	DanxzGkhZeY6Ug7rJLmkWD3+jHgG7KGOoT+ObXPHU8mLvHW/dFJKvmgYIR+ku3+Pw7OtzP
	b3wsAa6DttaVZuLIeCscvTvYQTKjrfksKdjQgCqnplp8l8Myu2mfSAOgoEmZEQhIocMnjL
	5f3B+JveaOEy7QAyV+21G/CsKFSySXEXPNHeZI0uMSuWa29QVc6UgoQFXRMADw==
Date: Wed, 6 Mar 2024 16:48:31 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240306164831.29eed907@xps-13>
In-Reply-To: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
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

ada@thorsis.com wrote on Wed, 6 Mar 2024 15:36:04 +0100:

> Hello everyone,
>=20
> I think I found a bug in nand_onfi_detect() which was introduced with
> commit c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page
> read to constraint controllers") back in 2020.

Interesting. I don't think this patch did broke anything, as
constrained controllers would just not support the read_data_op() call
anyway.

That being said, I don't see why the atmel controller would
refuse this operation, as it is supposed to support all
operations without limitation. This is one of the three issues
you have, that probably needs fixing.

> Background on how I found this: I'm currently struggling getting raw
> nand flash access to fly with an at91 sam9x60 SoC and a S34ML02G1
> Spansion SLC raw NAND flash on a custom board.  The setup is
> comparable to the sam9x60 curiosity board and can be reproduced with
> that one.
>=20
> NAND flash on sam9x60 curiosity board works fine with what is in
> mainline Linux kernel.  However after removing the line 'rb-gpios =3D
> <&pioD 5 GPIO_ACTIVE_HIGH>;' from at91-sam9x60_curiosity.dts all data
> read from the flash appears to be zeros only.  (I did not add that
> line to the dts of my custom board first, this is how I stumbled over
> this.)
>=20
> I have no explanation for that behaviour, it should work without R/B#
> by reading the status register, maybe we investigate that
> in depth later.

I don't see why at a first look. The default is "no RB" if no property
is given in the DT so it should work. Tracing the wait ready function
calls might help.

>  However those all zeros data reads happens when
> reading the ONFI param page as well es data read from OOB/spare area
> later and I bet it's the same with usual data.

Reading data without observing tWB + tR may lead to this.

> This read error reveals a bug in nand_onfi_detect().  After setting
> up some things there's this for loop:
>=20
>     for (i =3D 0; i < ONFI_PARAM_PAGES; i++) {
>=20
> For i =3D 0 nand_read_param_page_op() is called and in my case all zeros
> are returned and thus the CRC calculated does not match the all zeros
> CRC read.  So the usual break on successful reading the first page is
> skipped and for reading the second page nand_change_read_column_op()
> is called.  I think that one always fails on this line:
>=20
>     if (offset_in_page + len > mtd->writesize + mtd->oobsize) {
>=20
> Those variables contain the following values:
>=20
>     offset_in_page: 256
>     len: 256
>     mtd->writesize: 0
>     mtd->oobsize: 0

Indeed. We probably need some kind of extra check that does not perform
the if clause above if !mtd->writesize.

> The condition is true and nand_change_read_column_op() returns with
> -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> that code path.  Those are probably initialized later, maybe with
> parameters read from that ONFI param page?
>=20
> Returning with error from nand_change_read_column_op() leads to
> jumping out of nand_onfi_detect() early, and no ONFI param page is
> evaluated at all, although the second or third page could be intact.
>=20
> I guess this would also fail with any other reason for not matching
> CRCs in the first page, but I have not faulty NAND flash chip to
> confirm that.

Thanks for the whole report, it is interesting and should lead to fixes:
- why does the controller refuses the datain op?
- why nand_soft_waitrdy is not enough?
- changing the condition in nand_change_read_column_op()

Can you take care of these?

Thanks,
Miqu=C3=A8l

