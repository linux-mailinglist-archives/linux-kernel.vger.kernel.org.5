Return-Path: <linux-kernel+bounces-83637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C1869C99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAACA284BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D425F20B38;
	Tue, 27 Feb 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RGuGLMKl"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E022C688
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052249; cv=none; b=tqslgSv6tDPJB23agl13scL5oQpgDbRZtzxajycMElToYVYDhrQbBLBnIqHCDV2epqr0d16rejEkTbuMFAVdswVD2jFeZfSRSjZBHlGwPDGfllli31J40xh/RAl0Jnq32RLZ4Razf8iuDjDEf7HOs9olYzA0jRrpYAgG7Gr2uKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052249; c=relaxed/simple;
	bh=R5Z1nfb4rp2iS0jTSNix4fLmmprNlcKBtCaKntrzuGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJ2hzydIqVW/bE2Japt0h0q6nORsVQ+l8WYAa7lwEYO+jH4aAR0KhEBPktfhgN8aScEGrVrZFzKQnAIFMR1CEw5K22ERpzwdlvrtpwPyv7s45rmts0n9ts6CQ76gb77MF3vrvuYlmv+NyxA+cL6O8PlueL37gBb5I8SeJhAKTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RGuGLMKl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3F6A20002;
	Tue, 27 Feb 2024 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709052245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76mZ13DHESmZTVSHEaVoshFTsFCTogrCRWvywDtKTWE=;
	b=RGuGLMKlcnyRzk7Ze4to/gJfeKNYw9LJvr5cm5DiUHmlR2n3X0/rk93nu7DP00MOxMrZ8m
	jxiv6bMj7wrMRgzFRmkmSZveRWikAa6pqdL0Sr+yoEBoGFy38VoW9wJIYDbTyXs2xZ2kVa
	7Qty6dttcX32k+zkRIbjaYFPunVj23pEd7w5IonQDcZ9TpVqbNPVrX/QGFM4pMYDu6roVd
	XbGjLrZS8G8XWaMBj4FFXY5U6XlNeUyi3vA6jKlildBe10In8ry5Okluvap9TGck09eXZU
	82QKnp9AmhLzhmMhy1nx1hcVYlojf67M4gTi6GwEnE32TkdG/ukdoZV8s293bA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thomas Gleixner
 <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 07/13] irqchip/mvebu-pic: Convert to platform remove
 callback returning void
In-Reply-To: <df977ad4c02ff913b01cdd6c348e7fae3e08e651.1703284359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
 <df977ad4c02ff913b01cdd6c348e7fae3e08e651.1703284359.git.u.kleine-koenig@pengutronix.de>
Date: Tue, 27 Feb 2024 17:44:04 +0100
Message-ID: <87r0gxj1rf.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  drivers/irqchip/irq-mvebu-pic.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-=
pic.c
> index ef3d3646ccc2..57e3f99b61f5 100644
> --- a/drivers/irqchip/irq-mvebu-pic.c
> +++ b/drivers/irqchip/irq-mvebu-pic.c
> @@ -167,14 +167,12 @@ static int mvebu_pic_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
>=20=20
> -static int mvebu_pic_remove(struct platform_device *pdev)
> +static void mvebu_pic_remove(struct platform_device *pdev)
>  {
>  	struct mvebu_pic *pic =3D platform_get_drvdata(pdev);
>=20=20
>  	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
>  	irq_domain_remove(pic->domain);
> -
> -	return 0;
>  }
>=20=20
>  static const struct of_device_id mvebu_pic_of_match[] =3D {
> @@ -185,7 +183,7 @@ MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
>=20=20
>  static struct platform_driver mvebu_pic_driver =3D {
>  	.probe  =3D mvebu_pic_probe,
> -	.remove =3D mvebu_pic_remove,
> +	.remove_new =3D mvebu_pic_remove,
>  	.driver =3D {
>  		.name =3D "mvebu-pic",
>  		.of_match_table =3D mvebu_pic_of_match,
> --=20
> 2.42.0
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

