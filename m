Return-Path: <linux-kernel+bounces-14191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6878218F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D2B1F22167
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775ACA7F;
	Tue,  2 Jan 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VnPLnCPO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77ACA69
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE1D324000C;
	Tue,  2 Jan 2024 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704188106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2u1ijxtzEf9eyCDKw75vOC2uuAgptQFEeMQnFDeZaw=;
	b=VnPLnCPO1pSpAiic78DSPUogwKa7/7tz0vmrpHKLGE6YDkkiHKr7s+VPRPJV/OKR3Ps/KK
	RpkDlNYRN0JYuUYBndVKz4DolWIjbHHT9uJ7L/Duua2rlxoV7VtWJRpTjjrTY6VVam289V
	Wem9+h55x86lp0GlvOUUvPy/Zh6dxrfpxUTNoV0BgdK+sBZ54XjNFZPVxynNehLCEA6dhk
	t4kPdfbPbApnKgpBHIm7InFzSDk+7rbpus10feT5R3PuhGdzar+tu+V2iV03HGPPXxfiqD
	+/GmZZQP0Smli8kVDhAIDBMwzIOlGvhL4xPwiLghIoK+T8aiusdPzoaaQLK8tQ==
Date: Tue, 2 Jan 2024 10:35:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, =?UTF-8?B?UmFmYcWCIE1pxYJl?=
 =?UTF-8?B?Y2tp?= <rafal@milecki.pl>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: fix nvmem cells not being available in
 notifiers
Message-ID: <20240102103503.5310aa4b@xps-13>
In-Reply-To: <20231229-nvmem-cell-add-notification-v1-1-8d8b426be9f9@bootlin.com>
References: <20231229-nvmem-cell-add-notification-v1-1-8d8b426be9f9@bootlin.com>
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

Hi Luca,

luca.ceresoli@bootlin.com wrote on Fri, 29 Dec 2023 11:26:26 +0100:

> With current code, when an NVMEM notifier for NVMEM_CELL_ADD is called, t=
he
> cell is not accessible within the notifier call function.
>=20

Nice commit log :) a few minor comments below.

...

>=20
> Solve this by adding a flag in struct nvmem_device to block all
> notifications before calling device_add(), and keep track of whether each
> cell got notified or not, so that exactly one notification is sent ber

								     per?

> cell.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/nvmem/core.c      | 35 +++++++++++++++++++++++++++++++++--
>  drivers/nvmem/internals.h |  2 ++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ba559e81f77f..42f8edbfb39c 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -36,6 +36,7 @@ struct nvmem_cell_entry {
>  	struct device_node	*np;
>  	struct nvmem_device	*nvmem;
>  	struct list_head	node;
> +	atomic_t		notified_add;
>  };
> =20
>  struct nvmem_cell {
> @@ -520,9 +521,29 @@ static struct bus_type nvmem_bus_type =3D {
>  	.name		=3D "nvmem",
>  };
> =20
> +/*
> + * Send cell add/remove notification unless it has been already sent.
> + *
> + * Uses and updates cell->notified_add to avoid duplicates.
> + *
> + * Must never be called with NVMEM_CELL_ADD after being called with
> + * NVMEM_CELL_REMOVE.
> + *
> + * @cell: the cell just added or going to be removed
> + * @event: NVMEM_CELL_ADD or NVMEM_CELL_REMOVE
> + */
> +static void nvmem_cell_notify(struct nvmem_cell_entry *cell, unsigned lo=
ng event)
> +{
> +	int new_notified =3D (event =3D=3D NVMEM_CELL_ADD) ? 1 : 0;

The ternary operator is not needed here, (event =3D=3D VAL) will return the
correct value.

Could we rename new_notified into something like "is_addition"? It took
me a bit of time understanding what this boolean meant.

> +	int was_notified =3D atomic_xchg(&cell->notified_add, new_notified);
> +
> +	if (new_notified !=3D was_notified)

I believe what you want is (with my terms):

	if ((is_addition && !was_notified) || !is_addition)

> +		blocking_notifier_call_chain(&nvmem_notifier, event, cell);

I believe your if condition works, but is a bit complex to read. Is
there a reason for the following condition ?

	(new_notified :=3D 0) /*removal */ !=3D (was_notified :=3D 1)

I see no use to this, but I am probably over looking something.

> +}
> +
>  static void nvmem_cell_entry_drop(struct nvmem_cell_entry *cell)
>  {
> -	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
> +	nvmem_cell_notify(cell, NVMEM_CELL_REMOVE);
>  	mutex_lock(&nvmem_mutex);
>  	list_del(&cell->node);
>  	mutex_unlock(&nvmem_mutex);
> @@ -544,7 +565,9 @@ static void nvmem_cell_entry_add(struct nvmem_cell_en=
try *cell)
>  	mutex_lock(&nvmem_mutex);
>  	list_add_tail(&cell->node, &cell->nvmem->cells);
>  	mutex_unlock(&nvmem_mutex);
> -	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
> +
> +	if (cell->nvmem->do_notify_cell_add)
> +		nvmem_cell_notify(cell, NVMEM_CELL_ADD);
>  }
> =20
>  static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device=
 *nvmem,
> @@ -902,6 +925,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
>  struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  {
>  	struct nvmem_device *nvmem;
> +	struct nvmem_cell_entry *cell;
>  	int rval;
> =20
>  	if (!config->dev)
> @@ -1033,6 +1057,13 @@ struct nvmem_device *nvmem_register(const struct n=
vmem_config *config)
> =20
>  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> =20
> +	/* After device_add() it is now OK to notify of new cells */
> +	nvmem->do_notify_cell_add =3D true;

Could we rename this as well to be simpler? Like
"notify_cell_additions" or "cells_can_be_notified"? I am actually
asking myself whether this boolean is useful. In practice we call the
notifier after setting this to true. On the other hand, the layouts
will only probe after the device_add(), so they should be safe?

> +
> +	/* Notify about cells previously added but not notified */
> +	list_for_each_entry(cell, &nvmem->cells, node)
> +		nvmem_cell_notify(cell, NVMEM_CELL_ADD);
> +
>  	return nvmem;
> =20
>  #ifdef CONFIG_NVMEM_SYSFS
> diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
> index 18fed57270e5..3dbaa8523530 100644
> --- a/drivers/nvmem/internals.h
> +++ b/drivers/nvmem/internals.h
> @@ -33,6 +33,8 @@ struct nvmem_device {
>  	struct nvmem_layout	*layout;
>  	void *priv;
>  	bool			sysfs_cells_populated;
> +	/* Enable sending NVMEM_CELL_ADD notifications */
> +	bool			do_notify_cell_add;
>  };
> =20
>  #if IS_ENABLED(CONFIG_OF)
>=20
> ---
> base-commit: 399769c2014d2aa0463636d50f2bc6431b377331
> change-id: 20231229-nvmem-cell-add-notification-feb857742f0a
>=20
> Best regards,


Thanks,
Miqu=C3=A8l

