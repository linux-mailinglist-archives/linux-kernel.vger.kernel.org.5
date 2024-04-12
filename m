Return-Path: <linux-kernel+bounces-142128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43018A27E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A87E1F243B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FF4AEE3;
	Fri, 12 Apr 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HzWs55Ev"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D64C601;
	Fri, 12 Apr 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906610; cv=none; b=uxi9NJM+Mcz9uysjje1pcjVhttyxrgqT+SJTljqTtT8hCLMCT0Y3VdZJXF2z6d9gI8cuYIhqKKJXDqn58aCEeAW5WMAxu+fGSIUUhoJ9d4wmE1xMkKBLFZiWCeg3V7/ffyJVjvcWuspKNNKlvLJMyBlB/fPUnqgV7U+5Q8tuXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906610; c=relaxed/simple;
	bh=1fc5upaR2iFu8NVfwysFTXyLTjx4c8uQC6JiE1ZPOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLSGpDVVnORckSmR1X41gZFtaIm53E050TjOUWeYgdzWCs534S+GetpHwGAEn4XuC/bVbYDg3nf8NN4FUixNAQt9W7Aj9aNDf2xonV6PbY/vGmWR/ZV/XZeB4wNsZaJIjRHVEkxaUMbcVQKgNQn+rXlMUpuuaTHhFR7KGX/wYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HzWs55Ev; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAF7840006;
	Fri, 12 Apr 2024 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712906606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fc5upaR2iFu8NVfwysFTXyLTjx4c8uQC6JiE1ZPOKw=;
	b=HzWs55EvfTYHhIFrcIzo60HEKpMapdpKXMJI7FZG8U3WsFPXc5H6erNObA1mKvRlwfMnn5
	WZ6yZIEfanPNP519QB3J5xHWB+PdnWrjEgN9QiYsK7baEhGzHNh3rk3ZGzRHwFcIJ38R71
	tmv7gnRvi1W8GxMBJlPFqwaxTqvMU2+xWohDJtS6IXIrbA6lzzaNf3OgMJliNhuCaulF3k
	HAVgi8lP7HkKoA6yOYS7nAnCgNXZijFoKiPnM+YtH/QKBkI86WeZZ5630V2ogu03GG19Vv
	hEz3afEaWLOGE8iS/8/0CO3oWl3vJ6SyjDFAae8b/s04Qn/Fo1PIjYOFZc7X2Q==
Date: Fri, 12 Apr 2024 09:23:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <michael@walle.cc>
Cc: "Christian Marangi" <ansuelsmth@gmail.com>, =?UTF-8?B?UmFmYcWCICBNacWC?=
 =?UTF-8?B?ZWNraQ==?= <rafal@milecki.pl>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240412092323.07b8de3d@xps-13>
In-Reply-To: <D0FHRJG05LJN.1GU1N7J0BH6S4@walle.cc>
References: <20240402212331.27328-1-ansuelsmth@gmail.com>
	<D0FHRJG05LJN.1GU1N7J0BH6S4@walle.cc>
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

Hi Michael,

michael@walle.cc wrote on Tue, 09 Apr 2024 11:41:06 +0200:

> Hi,
>=20
> just a quick (non-technical) nitpick if you do a new version or
> maybe Miquel will fix it during applying:
>=20
> > Subject: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices=
 =20
>=20
> subject should be "non-NAND", also cell could be lower case :)

Yes I can. I was waiting for some feedback from Rafa=C5=82 but he must be
busy. I'll fix this. We need to move forward and send the fixes PR now.

Thanks,
Miqu=C3=A8l

