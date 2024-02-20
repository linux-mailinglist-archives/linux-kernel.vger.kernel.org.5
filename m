Return-Path: <linux-kernel+bounces-72854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C2485B98A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC23283748
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6D64A94;
	Tue, 20 Feb 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC6xylOM"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F657AA;
	Tue, 20 Feb 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426245; cv=none; b=CKhddexuxMzcyLi9lvpvzY8faergkIzWOVapFJXg/DkqCTQdLILtx/FttAYX8bj/BypsVxO+7NwSdsPEYdp/0l0+22GN1MpSEwy8/pM8WO91YSgJsonqnMQFs6368RvoGDnnxaqtrnlT2z6Kclr/DTa6s5E1PSDntbHG2RiswTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426245; c=relaxed/simple;
	bh=WPzxkD3EoI5jul+DFT/7yjVpWmDmZ73Y0P1fqeocIOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEzcao9/Fppdpo4+ssiebUJge4TBH3R87O3EicdhxE6tIV3hVg382gOLLt9G4luU2P/F9qR5n/1upiscAXio3WY4MNpyBnyq66a2wyB7U4Pj3Rur2yF3vcOJuYFyGYlttaZ/JchW5otiwH8P/BaCTY5xbZSJ8x/10+TXiFnkgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC6xylOM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso7418021a12.1;
        Tue, 20 Feb 2024 02:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426241; x=1709031041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=exAcQ8hd3pfK/VT0lsqz2Rx4G6poxL7RUx54/PgzT+I=;
        b=DC6xylOMbyTYac9E2HB44KsxGz98GrqMKfI0SsBY4YG/hpxXHTsWTFeQx7aHhu9Dzh
         jqq6btluWXUZUw5O8sGlTkrMHimPJg8DtDytTaJ3ERomXVXm4PuZlCqe8myc6KeKu7Go
         QJcjwRNxz/9WztHpU/DefRDHzG6amfmIoHRbS5TemEOZrtCqNKVSqLrM+FK0owt3gDds
         65L9OyYXGw6+1AXqpixyLnLaNis2JWXjAakttkimDv8qxqnHLLvW01yi7sIsQJsiYkMm
         pHpX7rpeQSsux+8ttnbXb92NRCkPrd3agQ1zm5KMjNiW4GHucFzX3Gfz5mCXD0RnSy0h
         Mimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426241; x=1709031041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exAcQ8hd3pfK/VT0lsqz2Rx4G6poxL7RUx54/PgzT+I=;
        b=RLD0plvCGu3SilUGZEsfiCtMBIYQ9WvPTXmvhMW7w+9Cm4X3rTCl79JbqsfRe/p/+/
         4okhKRsrMvhi8en40Wqi49HQZwdIMMaT7MlKnQj9CWbAWo9KfyggFUgUabKZFjPVFLF5
         BkzSo6+Pyq56GyXXtUWks/jLJnbT4qHbP/BWCMPFWlmjVCRDAtkZLM4tXUyMhlPMQWx9
         ogzqhJPPtCEZ3upoB/skCpOkp4Vt8H4HEAQDL5eP6XZHPFAjEj6279Y/CB1dZCpQSaXn
         9O9Y9D4sPyPt8KIjrnCrXvhydlFjF9PFB0J8Wva/RaaQ+yWKZqNwBvrhSR/ZtnI1rKq5
         Ttyg==
X-Forwarded-Encrypted: i=1; AJvYcCW9FP8OaQr8V8Mi1Z6xI6X+fTYxTsRbl7G0WbVBSbtjXiydbaRiv4JjLv8FCrI7ipJwrtOHWmxj324JUF2PR2qnkloZvEr6wfFCxCjzpRazmemX0M4qutSD2g8VkovQlNSdUw1W+ayi7yMt5ujUzhL9PjhqD2zten/QG57UH4n8ISux
X-Gm-Message-State: AOJu0YwF/QSstsXvl6Q0MScHEW4A+yxxdYyKTjfINBTqkdKOfVAZzR/N
	2tOtrj1HVQ40l/w6A48KUHT1o1U9lcoxqEBHO/XZGxY3aXJoBmnZ
X-Google-Smtp-Source: AGHT+IGE+XXRoZfdf9m+H4h8aUUhvlJDR54bjKCSJpCqHOj/lUuJF2x7nUF3e3v1rlgSM8Y7BZUaOQ==
X-Received: by 2002:a17:906:40cb:b0:a3e:405c:d5d1 with SMTP id a11-20020a17090640cb00b00a3e405cd5d1mr4695537ejk.50.1708426241096;
        Tue, 20 Feb 2024 02:50:41 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b00a3e786d8729sm2338011ejs.168.2024.02.20.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:50:40 -0800 (PST)
Message-ID: <42bc659ddda05f3d4ece7e4a65e4548da17d17ad.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] spi: add spi_optimize_message() APIs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org
Date: Tue, 20 Feb 2024 11:50:40 +0100
In-Reply-To: <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
References: 
	<20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	 <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 16:33 -0600, David Lechner wrote:
> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.
>=20
> Internally, the SPI core will also call this function for each message
> if the peripheral driver did not explicitly call it. This is done to so
> that controller drivers don't have to have multiple code paths for
> optimized and non-optimized messages.
>=20
> A hook is provided for controller drivers to perform controller-specific
> optimizations.
>=20
> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> Link:
> https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@ma=
rtin.sperl.org/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v2 changes:
> - Removed pre_optimized parameter from __spi_optimize_message()
> - Added comment explaining purpose of pre_optimized flag
> - Fixed missing doc comment for @pre_optimized
> - Removed kernel doc inclusion (/** -> /*) from static members
> - Removed unrelated comment about calling spi_finalize_current_message()
>=20
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 151 +++++++=
+++++++++++++++++++++++++++++++++++++++--
> =C2=A0include/linux/spi/spi.h |=C2=A0 20 +++++++
> =C2=A02 files changed, 167 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c2b10e2c75f0..f68d92b57543 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2106,6 +2106,41 @@ struct spi_message *spi_get_next_queued_message(st=
ruct
> spi_controller *ctlr)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
> =C2=A0
> +/*
> + * __spi_unoptimize_message - shared implementation of spi_unoptimize_me=
ssage()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 and spi_maybe_unoptimize_message()
> + * @msg: the message to unoptimize
> + *
> + * Peripheral drivers should use spi_unoptimize_message() and callers in=
side
> + * core should use spi_maybe_unoptimize_message() rather than calling th=
is
> + * function directly.
> + *
> + * It is not valid to call this on a message that is not currently optim=
ized.
> + */
> +static void __spi_unoptimize_message(struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr =3D msg->spi->controller;
> +
> +	if (ctlr->unoptimize_message)
> +		ctlr->unoptimize_message(msg);
> +
> +	msg->optimized =3D false;
> +	msg->opt_state =3D NULL;
> +}
> +
> +/*
> + * spi_maybe_unoptimize_message - unoptimize msg not managed by a periph=
eral
> + * @msg: the message to unoptimize
> + *
> + * This function is used to unoptimize a message if and only if it was
> + * optimized by the core (via spi_maybe_optimize_message()).
> + */
> +static void spi_maybe_unoptimize_message(struct spi_message *msg)
> +{
> +	if (!msg->pre_optimized && msg->optimized)
> +		__spi_unoptimize_message(msg);
> +}
> +
> =C2=A0/**
> =C2=A0 * spi_finalize_current_message() - the current message is complete
> =C2=A0 * @ctlr: the controller to return the message to
> @@ -2153,6 +2188,8 @@ void spi_finalize_current_message(struct spi_contro=
ller
> *ctlr)
> =C2=A0
> =C2=A0	mesg->prepared =3D false;
> =C2=A0
> +	spi_maybe_unoptimize_message(mesg);
> +
> =C2=A0	WRITE_ONCE(ctlr->cur_msg_incomplete, false);
> =C2=A0	smp_mb(); /* See __spi_pump_transfer_message()... */
> =C2=A0	if (READ_ONCE(ctlr->cur_msg_need_completion))
> @@ -4194,6 +4231,110 @@ static int __spi_validate(struct spi_device *spi,=
 struct
> spi_message *message)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * __spi_optimize_message - shared implementation for spi_optimize_messa=
ge()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and spi_maybe_optimize_message()
> + * @spi: the device that will be used for the message
> + * @msg: the message to optimize
> + *
> + * Peripheral drivers will call spi_optimize_message() and the spi core =
will
> + * call spi_maybe_optimize_message() instead of calling this directly.
> + *
> + * It is not valid to call this on a message that has already been optim=
ized.
> + *
> + * Return: zero on success, else a negative error code
> + */
> +static int __spi_optimize_message(struct spi_device *spi,
> +				=C2=A0 struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr =3D spi->controller;
> +	int ret;
> +
> +	ret =3D __spi_validate(spi, msg);
> +	if (ret)
> +		return ret;
> +
> +	if (ctlr->optimize_message) {
> +		ret =3D ctlr->optimize_message(msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	msg->optimized =3D true;
> +
> +	return 0;
> +}
> +
> +/*
> + * spi_maybe_optimize_message - optimize message if it isn't already pre=
-optimized
> + * @spi: the device that will be used for the message
> + * @msg: the message to optimize
> + * Return: zero on success, else a negative error code
> + */
> +static int spi_maybe_optimize_message(struct spi_device *spi,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg)
> +{
> +	if (msg->pre_optimized)
> +		return 0;
> +
> +	return __spi_optimize_message(spi, msg);
> +}
> +
> +/**
> + * spi_optimize_message - do any one-time validation and setup for a SPI=
 message
> + * @spi: the device that will be used for the message
> + * @msg: the message to optimize
> + *
> + * Peripheral drivers that reuse the same message repeatedly may call th=
is to
> + * perform as much message prep as possible once, rather than repeating =
it each
> + * time a message transfer is performed to improve throughput and reduce=
 CPU
> + * usage.
> + *
> + * Once a message has been optimized, it cannot be modified with the exc=
eption
> + * of updating the contents of any xfer->tx_buf (the pointer can't be ch=
anged,
> + * only the data in the memory it points to).
> + *
> + * Calls to this function must be balanced with calls to spi_unoptimize_=
message()
> + * to avoid leaking resources.
> + *
> + * Context: can sleep
> + * Return: zero on success, else a negative error code
> + */
> +int spi_optimize_message(struct spi_device *spi, struct spi_message *msg=
)
> +{
> +	int ret;
> +
> +	ret =3D __spi_optimize_message(spi, msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This flag indicates that the peripheral driver called
> spi_optimize_message()
> +	 * and therefore we shouldn't unoptimize message automatically when
> finalizing
> +	 * the message but rather wait until spi_unoptimize_message() is called
> +	 * by the peripheral driver.
> +	 */
> +	msg->pre_optimized =3D true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_optimize_message);
> +
> +/**
> + * spi_unoptimize_message - releases any resources allocated by
> spi_optimize_message()
> + * @msg: the message to unoptimize
> + *
> + * Calls to this function must be balanced with calls to spi_optimize_me=
ssage().
> + *
> + * Context: can sleep
> + */
> +void spi_unoptimize_message(struct spi_message *msg)
> +{
> +	__spi_unoptimize_message(msg);
> +	msg->pre_optimized =3D false;
> +}
> +EXPORT_SYMBOL_GPL(spi_unoptimize_message);
> +
> =C2=A0static int __spi_async(struct spi_device *spi, struct spi_message *=
message)
> =C2=A0{
> =C2=A0	struct spi_controller *ctlr =3D spi->controller;
> @@ -4258,8 +4399,8 @@ int spi_async(struct spi_device *spi, struct spi_me=
ssage
> *message)
> =C2=A0	int ret;
> =C2=A0	unsigned long flags;
> =C2=A0
> -	ret =3D __spi_validate(spi, message);
> -	if (ret !=3D 0)
> +	ret =3D spi_maybe_optimize_message(spi, message);
> +	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
> @@ -4271,6 +4412,8 @@ int spi_async(struct spi_device *spi, struct spi_me=
ssage
> *message)
> =C2=A0
> =C2=A0	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
> =C2=A0
> +	spi_maybe_unoptimize_message(message);
> +
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_async);
> @@ -4331,8 +4474,8 @@ static int __spi_sync(struct spi_device *spi, struc=
t
> spi_message *message)
> =C2=A0		return -ESHUTDOWN;
> =C2=A0	}
> =C2=A0
> -	status =3D __spi_validate(spi, message);
> -	if (status !=3D 0)
> +	status =3D spi_maybe_optimize_message(spi, message);
> +	if (status)
> =C2=A0		return status;
> =C2=A0
> =C2=A0	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 2b8e2746769a..ddfb66dd4caf 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -475,6 +475,8 @@ extern struct spi_device *spi_new_ancillary_device(st=
ruct
> spi_device *spi, u8 ch
> =C2=A0 *
> =C2=A0 * @set_cs: set the logic level of the chip select line.=C2=A0 May =
be called
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from inter=
rupt context.
> + * @optimize_message: optimize the message for reuse
> + * @unoptimize_message: release resources allocated by optimize_message
> =C2=A0 * @prepare_message: set up the controller to transfer a single mes=
sage,
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for example doing DMA mapping=
=C2=A0 Called from threaded
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context.
> @@ -715,6 +717,8 @@ struct spi_controller {
> =C2=A0	struct completion=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfer_completion;
> =C2=A0	size_t				max_dma_len;
> =C2=A0
> +	int (*optimize_message)(struct spi_message *msg);
> +	int (*unoptimize_message)(struct spi_message *msg);
> =C2=A0	int (*prepare_transfer_hardware)(struct spi_controller *ctlr);
> =C2=A0	int (*transfer_one_message)(struct spi_controller *ctlr,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct spi_message *mesg);
> @@ -1111,6 +1115,8 @@ struct spi_transfer {
> =C2=A0 * @spi: SPI device to which the transaction is queued
> =C2=A0 * @is_dma_mapped: if true, the caller provided both DMA and CPU vi=
rtual
> =C2=A0 *	addresses for each transfer buffer
> + * @pre_optimized: peripheral driver pre-optimized the message
> + * @optimized: the message is in the optimized state
> =C2=A0 * @prepared: spi_prepare_message was called for the this message
> =C2=A0 * @status: zero for success, else negative errno
> =C2=A0 * @complete: called to report transaction completions
> @@ -1120,6 +1126,7 @@ struct spi_transfer {
> =C2=A0 *	successful segments
> =C2=A0 * @queue: for use by whichever driver currently owns the message
> =C2=A0 * @state: for use by whichever driver currently owns the message
> + * @opt_state: for use by whichever driver currently owns the message
> =C2=A0 * @resources: for resource management when the SPI message is proc=
essed
> =C2=A0 *
> =C2=A0 * A @spi_message is used to execute an atomic sequence of data tra=
nsfers,
> @@ -1143,6 +1150,11 @@ struct spi_message {
> =C2=A0
> =C2=A0	unsigned		is_dma_mapped:1;
> =C2=A0
> +	/* spi_optimize_message() was called for this message */
> +	bool			pre_optimized;
> +	/* __spi_optimize_message() was called for this message */
> +	bool			optimized;
> +
> =C2=A0	/* spi_prepare_message() was called for this message */
> =C2=A0	bool			prepared;
> =C2=A0
> @@ -1172,6 +1184,11 @@ struct spi_message {
> =C2=A0	 */
> =C2=A0	struct list_head	queue;
> =C2=A0	void			*state;
> +	/*
> +	 * Optional state for use by controller driver between calls to
> +	 * __spi_optimize_message() and __spi_unoptimize_message().
> +	 */
> +	void			*opt_state;
> =C2=A0
> =C2=A0	/* List of spi_res resources when the SPI message is processed */
> =C2=A0	struct list_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resourc=
es;
> @@ -1255,6 +1272,9 @@ static inline void spi_message_free(struct spi_mess=
age *m)
> =C2=A0	kfree(m);
> =C2=A0}
> =C2=A0
> +extern int spi_optimize_message(struct spi_device *spi, struct spi_messa=
ge *msg);
> +extern void spi_unoptimize_message(struct spi_message *msg);
> +
> =C2=A0extern int spi_setup(struct spi_device *spi);
> =C2=A0extern int spi_async(struct spi_device *spi, struct spi_message *me=
ssage);
> =C2=A0extern int spi_slave_abort(struct spi_device *spi);
>=20


