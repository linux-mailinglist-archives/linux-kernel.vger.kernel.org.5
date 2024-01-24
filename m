Return-Path: <linux-kernel+bounces-37400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16F83AF47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22A228AA28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77086AF2;
	Wed, 24 Jan 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QNHpXucd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045586AD7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116141; cv=none; b=uj23sKNxviOVZvqV77NENeqUIgO3QP/UNO1Gg07YAh/AJVlaBmTG3wFcy/9iipM2I7zpvE/LTXMzNA/3/FLlu3XmEGjSmsX9xKcdvEbbFJaxzNq0/R1hvQZ7SlPA6gkOPeSgqftDlH13ClbSYH3i/XnJ8HiBg2d/8PMpAlbFW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116141; c=relaxed/simple;
	bh=romx/hMVnXU+YClTIP+lZWzqpiWykqr15lDUZgoS4EA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDvlzLisCD8PH6WDK50KG1bYIj8rsXflBQ9WhfVnurFmRmPGkRGcWekag0l+Jhozl4a4wsiTJJabKnSLa3zwopgIUXH/Xf1HuGXn3c7U7PY61/tDwz+ybZYDUSPJCLjBYeojnr96c9OYwOpgDp2xzR2s31ixQ+eu3JTSAKZ63rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QNHpXucd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08AE824000D;
	Wed, 24 Jan 2024 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706116131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=romx/hMVnXU+YClTIP+lZWzqpiWykqr15lDUZgoS4EA=;
	b=QNHpXucdZFKUH+WLTfvF90rOkNfXLjgudSf0YujzPsNFqCRFdlnOYITnw7FwgwAzwfnany
	rJru6oMuuk7LQtuIrcycjfXUIiqErr899+3mJ6PDDFXwWT7N26SvMeHBUoNVkLBV2w1lrW
	3WZ5A/bfMUJd9lwObX33vRQyZ84IEvXiRRV7/83OzO2bSyzqpK/p4GWoVXUClVqQ7zZmKt
	xt3cCvp0FDTFpz21scmoOfYenTt5hC3Ly8DM6S/x9Qo6qYtE1UpcqBT/DEspq+eAcI/Our
	UV9WFuL5o0WcLX0zay0GZQMecgpFxnppXok1ahg4uf32zTf4xdSXK60hh04jPg==
Date: Wed, 24 Jan 2024 18:08:48 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ezra Buehler <ezra@easyb.ch>
Cc: Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Mark Brown <broonie@kernel.org>, Daniel
 Palmer <daniel@0x0f.com>, open list <linux-kernel@vger.kernel.org>,
 quic_sridsn@quicinc.com, quic_mdalam@quicinc.com
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
Message-ID: <20240124180848.3647d5c9@xps-13>
In-Reply-To: <CAM1KZS=tvEi6fed=BoynpkjfzZqKGb-wv+CVbVmAPYz5tNaNkQ@mail.gmail.com>
References: <20220413083824.247136-1-gch981213@gmail.com>
	<20220413145843.46a3d9b5@xps13>
	<CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
	<CAM1KZS=tvEi6fed=BoynpkjfzZqKGb-wv+CVbVmAPYz5tNaNkQ@mail.gmail.com>
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

Hi Ezra,

ezra@easyb.ch wrote on Tue, 23 Jan 2024 19:54:06 +0200:

> Hi Chuanhong Guo,
>=20
> On Wed, 13 Apr 2022 22:50:43 +0800 Chuanhong Guo <gch981213@gmail.com> wr=
ote:
> > Their device ID aren't conflicting yet, so nothing will happen
> > at the moment. =20
>=20
> Since commit aa08bf187f32 ("mtd: spinand: esmt: add support for
> F50D2G41KA") we have a conflict with the GigaDevice GD5F1GQ5UExxG
> (manufacturer ID 0xC8, device ID 0x51), preventing our board from
> booting.
>=20
> > There is a solution for future conflict: Recent SPI-NAND chips
> > contain a parameter page which has the exact chip vendor
> > and model. We can do one more detection with the parameter
> > page content.
> > Winbond W25N01KV is a 2k+96 SPI-NAND with 4-bit ECC.
> > It uses the exact same chip id as the current W25N01GV
> > (2k+64 1-bit ECC). We need to support detection using
> > parameter page for this crazy decision by Winbond anyway.
> > I'll try to code something for this with my free time.
> >
> > My current idea is: We first do a detection based on chip id.
> > If that failed, try to read the parameter page. If we got a
> > valid one, match the chip vendor and model string. =20
>=20
> According to the datasheets, the ESMT chips actually have a 5 byte ID,
> the last 3 bytes being 0x7F (JEDEC Maker Code Continuation Code). Why
> can't we simply extend the ID in esmt.c (as you had it in your original
> patch) and increase SPINAND_MAX_ID_LEN to 5? Or, alternatively, only
> extend the ID to 4 bytes?
>=20
> If that is the way to go, I would be happy to provide the patches.

Please send the patches. Chuanhong can you test them?

Thanks,
Miqu=C3=A8l

