Return-Path: <linux-kernel+bounces-5410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7E818A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07921C20EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864221C29F;
	Tue, 19 Dec 2023 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="drhoG56F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999051BDD8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00BB840002;
	Tue, 19 Dec 2023 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702997084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcC1UPq/cCcwskYFv7lgPr4ovzsPPufTTXEYRTZJPi8=;
	b=drhoG56F5u53THaINE7HgunFSjNNF7X9b6BJxp9dNLp2azlG6tks0evoML1e2Z0jdEQEGZ
	LV7IilQ9oqIzjaXs8Ir8XtmwQAShLAQf+Ojn9ClGoMftbo58jAr+OPyzAN/oq/DwrV1ZpF
	7LOOSNqlw0MJyZpsjo3b6qNYc78LfFilWxqUQ2hma523rQOp2mV+srpeS3M2oqsfBnCi6K
	l7r6YqiZlfAQwylz0S2lCL77iiKhgMIaZg4lhH7//ujtuswrpAy+CUZP8ADQ/dg2O1rxga
	ZtxJOWsTfLneD4xAAJmHwgsI51vAl8cXkUm+C8MGTl5GG43LJo0NH0XRMSBU3Q==
Date: Tue, 19 Dec 2023 15:44:38 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
 dpervushin <dpervushin@embeddedalley.com>, linux-mtd
 <linux-mtd@lists.infradead.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, chengzhihao1 <chengzhihao1@huawei.com>, yi
 zhang <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by
 ftl notifier
Message-ID: <20231219154438.2bc1820e@xps-13>
In-Reply-To: <04b4c375-d890-9458-5d62-0a9ba74b8c68@huawei.com>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
	<20231027194026.1bc32dfe@xps-13>
	<174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
	<20231029145033.0ad2682a@xps-13>
	<142222867.20038.1698593973984.JavaMail.zimbra@nod.at>
	<04b4c375-d890-9458-5d62-0a9ba74b8c68@huawei.com>
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

Hi ZhaoLong,

wangzhaolong1@huawei.com wrote on Tue, 19 Dec 2023 22:36:50 +0800:

> Friendly ping...
>=20
> I'd like to know what the current status of this patch is. Is there a nee=
d for further programme improvements?

Easy, see below.

>=20
> Bast regards,
> ZhaoLong Wang
>=20
>=20
> > ----- Urspr=C3=BCngliche Mail ----- =20
> >> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> >> Ack. I'll queue this once the log fixed and your official Ack-by
> >> received for mtd/next after -rc1 is out. =20

Here I depict two conditions.

> > Acked-by: Richard Weinberger <richard@nod.at>

And here one of them is fulfilled, which means the other one is still
not AFAIK :)

Thanks,
Miqu=C3=A8l

