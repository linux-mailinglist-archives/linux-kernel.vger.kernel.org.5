Return-Path: <linux-kernel+bounces-33970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B9837112
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E0F1C29752
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C89482FF;
	Mon, 22 Jan 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ro4C+lyC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F625A797;
	Mon, 22 Jan 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947603; cv=none; b=mgCxzp0pFv9ZoOuOehuNwQjzOwuZYbPN8Bp3iHeQ2gyHnw0hCaDHs1eLLH491C6qugAIgJ1WeMKy+OzX3trYAPt4ilXcl5bw31xA9DL15bBS6n1SuIOb/pxkzqdVsDHh9LOazI+XkXHbo85KLSZyRasem2RGQJ6VDNOkLZaUmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947603; c=relaxed/simple;
	bh=8W7nuPtHrC/Hj56hA90mhHUdLtjrN9XFg/luUGKxfNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4FXts2abBdkOIcenBP+ZCvzKJiFX/62W590tnOrf5EUX8kfHCwSy0cE/RJGif7hNLSomNagfw57wyCqmESXrSqCg7VafRrQ4DSa+hMf591JQOnRbS4KO0t0UDDVfNW+l668HkFZ19Do82/VF43+KfFmr5xMgRjPNoYMlrBWUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ro4C+lyC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60DD4C0008;
	Mon, 22 Jan 2024 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705947599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8W7nuPtHrC/Hj56hA90mhHUdLtjrN9XFg/luUGKxfNs=;
	b=Ro4C+lyC8DiYanjVguhp0jyVAhJRO3/nU2DF3V6l2G05sVRSDem+FwD8i/jNbYm6dOZKVQ
	I53bR8QwRykQwviL/3BbGimvK44PLL79jrJqyYehK93nErBoMNSkIFp9YRT93Spq4Exfmf
	JHhNjlGR+OWnLvN0P7JXmWML9Zb8461P3HefBu9/K3KR7Fa72C/xfloGtPZw+XommQ56eb
	dRexUiUhhc90KZdotFbwsNRIoy1wv9hQbyOGOJjmNvpWbRrEHakErzeSYz54oZJkQyJL1q
	kWclhMjHSIhiq6SlhgAX2LqNXe7fg9DPkO1uIFndWqWcUAcFjS79Irron+UmZA==
Date: Mon, 22 Jan 2024 19:19:44 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 13/33] mtd: rawnand: fsl_elbc: Let .probe retry if
 local bus is missing
Message-ID: <20240122191931.17807644@xps-13>
In-Reply-To: <41a042207ef791c4c5bcb46f09f63c40c6aa321b.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
	<41a042207ef791c4c5bcb46f09f63c40c6aa321b.1705944943.git.u.kleine-koenig@pengutronix.de>
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

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Mon, 22 Jan 2024 19:07:08 +0100:

> If during probe fsl_lbc_ctrl_dev is NULL that might just be because the
> fsl_lbc driver didn't bind yet. So return -EPROBE_DEFER in this case to
> make the driver core retry probing later.

Despite the probable usefulness of this change, I don't see any
relationship with the current series. So unless there is a good reason
I might take this one through the nand tree.

Also, what about a Fixes/Cc: stable tag here?

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks,
Miqu=C3=A8l

