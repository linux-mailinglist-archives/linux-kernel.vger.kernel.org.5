Return-Path: <linux-kernel+bounces-48026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B8845668
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A50F1C21CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F915D5AA;
	Thu,  1 Feb 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSjfsA12"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B212CDB4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787700; cv=none; b=BqjUdHAJs/Y/A2VpohFsac/pm5To3WO7xARIRsjFZFh4LjHahCE/SfoAmHJz+EZJRj0BwPVPYRBhkbwM+hROeESNGwBhi+BSq5M9f2BkIAewL/C1bTar3ESpOhyKcxUjyjm+XYNu5Du40p0cI+P04rEupfSoKhE10kyOrIcNz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787700; c=relaxed/simple;
	bh=Ux8SuwL61Ofpis/ocKtz5vvNMncUkzaMBLUvh5TxVl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=olFYxUfuwY/tS/F7pvIOmQ9Z60ECtTigmFGJ2qCyenKIjwoMSiX7wRYdLsYL/3P1oCj8OwfCgVGI7fdaflV0u2nmnOFKCKYcvOtmHlyCnwJNPLyJESVLEGHbEwsDhyKo+zO4RvvzBzKRKMPiIv0q2VY98pBARq6heCy693VSUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSjfsA12; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706787697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Po/nHRCuG70ZslkVkUZB2if3wnt/DtEf/hbKhv1YQ2c=;
	b=FSjfsA12eI28JKiYydjt52KSGg2rCZ/OppVF7VLlFiDxSAHYc8TNDThOIYUM3XNA+HzrmL
	ztqU8UhEWImk+rZVDNnYHmk5ExsU3ZcKN+2QmIIkEScLLWMZm56IBPsx+2jlC6xHfJiMan
	T6OZB3zwVvlkbKhlcUSflihbzQGCJY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-O4nJnr2CMXOciDraSi3BRA-1; Thu, 01 Feb 2024 06:41:35 -0500
X-MC-Unique: O4nJnr2CMXOciDraSi3BRA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso878315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787694; x=1707392494;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po/nHRCuG70ZslkVkUZB2if3wnt/DtEf/hbKhv1YQ2c=;
        b=JVCE/n2SMdUm+14yX5/xJTXnr8GfHIZiiZH2atHwgXkiKMK9608A6FtHrfIYOepXZ5
         YVJz1RjMjvHY1QoM2bCOa6KKqjOa1w6FSrrBOdWXt09MOyhimS7oIanMR0BUD/m3+t4R
         dT/Mv+rbRC2yW3bSc62TV95bFUvEZK2dCoGZAkEI+4NMvJpZzX9HjoEDjgJorJXXaDK6
         FIQ9OVoAKT5rQYCm6KStz1b7xcJ6kvdo/JCEPR7uTbuRtb136pgArThO23X8XT+uAEtX
         9fqzR5GhLWbD1A7v2BjknEW3UQXFo+qCimvrGa/4RzAYV41ab2uVLWogTW0Emu7P0Rwb
         05ow==
X-Gm-Message-State: AOJu0Yxg4U9c9I+rBmvWwBrVL9CZBYldO0oGuPJwpkyeZCQydeRao4ZK
	Kuu2vVCBqAeVn8pAAyw7zdbflpgxlrdN+WCjTcXI7t/Ii4b4HEXjsrTAHuqY6G3vnHV2wEIhXDt
	Qfor9tBaOHeO95Zbl+z1eV2kVRwexIpOT/CzLq/VK048dHwnQdnva95y1XhayXg==
X-Received: by 2002:a05:600c:5199:b0:40f:befe:9b52 with SMTP id fa25-20020a05600c519900b0040fbefe9b52mr710265wmb.3.1706787694606;
        Thu, 01 Feb 2024 03:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Pk0soFcf5+nMPfUxGPS2zjBnMym71rihGaqLn8Yk8QvqQ55k7qONdT2pMHMGwHFf9tVAmA==
X-Received: by 2002:a05:600c:5199:b0:40f:befe:9b52 with SMTP id fa25-20020a05600c519900b0040fbefe9b52mr710251wmb.3.1706787694206;
        Thu, 01 Feb 2024 03:41:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWeOyCjpaHQhydCBnZcczJSSO99KotjeNaVtdOhGnDhLqZNUi4XBQIZwQrsQPwn0lpznTSyTEC3rMyWbOC0uEQISJBtJh5gjEptELPZOS7KmpgnXLSi4iXnfDAIho5unKP7VspkU5+uGdDIe8BEr2ey5Uz8vGd/6PvpLIHUrEgetvAQ6z94hdyRyJsCP9bU2saSR9gpffvoAEoSS8CO/LXcYzqE+SzDLHog7T0FA16+xrIJXqEOEsbjA3p3o11KZvAwacJ/SJx39FLD47lruzRavtvq1aWZoEHF9vIdZvbnVmDBdERLtNbIWRi5r7l0obejJ23SPpvc/oJ6gLTm1Cj90dBjq2CnZCthlBQHR3WmlvYlHU9EUD2CUNM=
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b0040ef8aa4822sm4136433wmg.38.2024.02.01.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:41:33 -0800 (PST)
Message-ID: <b1968b5c7e88edd448d5f55b57dfa40257b2b06c.camel@redhat.com>
Subject: Re: [PATCH v2 1/6] net: wan: Add support for QMC HDLC
From: Paolo Abeni <pabeni@redhat.com>
To: Herve Codina <herve.codina@bootlin.com>, Vadim Fedorenko
	 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Thu, 01 Feb 2024 12:41:32 +0100
In-Reply-To: <20240130084035.115086-2-herve.codina@bootlin.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
	 <20240130084035.115086-2-herve.codina@bootlin.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 09:40 +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/wan/Kconfig        |  12 +
>  drivers/net/wan/Makefile       |   1 +
>  drivers/net/wan/fsl_qmc_hdlc.c | 422 +++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+)
>  create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c
>=20
> diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
> index 7dda87756d3f..31ab2136cdf1 100644
> --- a/drivers/net/wan/Kconfig
> +++ b/drivers/net/wan/Kconfig
> @@ -197,6 +197,18 @@ config FARSYNC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called farsync.
> =20
> +config FSL_QMC_HDLC
> +	tristate "Freescale QMC HDLC support"
> +	depends on HDLC
> +	depends on CPM_QMC
> +	help
> +	  HDLC support using the Freescale QUICC Multichannel Controller (QMC).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called fsl_qmc_hdlc.
> +
> +	  If unsure, say N.
> +
>  config FSL_UCC_HDLC
>  	tristate "Freescale QUICC Engine HDLC support"
>  	depends on HDLC
> diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
> index 8119b49d1da9..00e9b7ee1e01 100644
> --- a/drivers/net/wan/Makefile
> +++ b/drivers/net/wan/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_WANXL)		+=3D wanxl.o
>  obj-$(CONFIG_PCI200SYN)		+=3D pci200syn.o
>  obj-$(CONFIG_PC300TOO)		+=3D pc300too.o
>  obj-$(CONFIG_IXP4XX_HSS)	+=3D ixp4xx_hss.o
> +obj-$(CONFIG_FSL_QMC_HDLC)	+=3D fsl_qmc_hdlc.o
>  obj-$(CONFIG_FSL_UCC_HDLC)	+=3D fsl_ucc_hdlc.o
>  obj-$(CONFIG_SLIC_DS26522)	+=3D slic_ds26522.o
> =20
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdl=
c.c
> new file mode 100644
> index 000000000000..e7b2b72a6050
> --- /dev/null
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Freescale QMC HDLC Device Driver
> + *
> + * Copyright 2023 CS GROUP France
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/hdlc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <soc/fsl/qe/qmc.h>
> +
> +struct qmc_hdlc_desc {
> +	struct net_device *netdev;
> +	struct sk_buff *skb; /* NULL if the descriptor is not in use */
> +	dma_addr_t dma_addr;
> +	size_t dma_size;
> +};
> +
> +struct qmc_hdlc {
> +	struct device *dev;
> +	struct qmc_chan *qmc_chan;
> +	struct net_device *netdev;
> +	bool is_crc32;
> +	spinlock_t tx_lock; /* Protect tx descriptors */
> +	struct qmc_hdlc_desc tx_descs[8];
> +	unsigned int tx_out;
> +	struct qmc_hdlc_desc rx_descs[4];
> +};
> +
> +static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *net=
dev)
> +{
> +	return dev_to_hdlc(netdev)->priv;
> +}

Please, no 'inline' function in c files. You could move this function
and the struct definition into a new, local, header file.

> +static int qmc_hdlc_recv_queue(struct qmc_hdlc *qmc_hdlc, struct qmc_hdl=
c_desc *desc, size_t size);
> +
> +#define QMC_HDLC_RX_ERROR_FLAGS (QMC_RX_FLAG_HDLC_OVF | \
> +				 QMC_RX_FLAG_HDLC_UNA | \
> +				 QMC_RX_FLAG_HDLC_ABORT | \
> +				 QMC_RX_FLAG_HDLC_CRC)
> +
> +static void qmc_hcld_recv_complete(void *context, size_t length, unsigne=
d int flags)
> +{
> +	struct qmc_hdlc_desc *desc =3D context;
> +	struct net_device *netdev =3D desc->netdev;
> +	struct qmc_hdlc *qmc_hdlc =3D netdev_to_qmc_hdlc(netdev);
> +	int ret;

Please, respect the reverse x-mas tree order for local variable
definition.

> +	dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size, DMA_FRO=
M_DEVICE);
> +
> +	if (flags & QMC_HDLC_RX_ERROR_FLAGS) {
> +		netdev->stats.rx_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_OVF) /* Data overflow */
> +			netdev->stats.rx_over_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_UNA) /* bits received not multiple of 8 *=
/
> +			netdev->stats.rx_frame_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_ABORT) /* Received an abort sequence */
> +			netdev->stats.rx_frame_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_CRC) /* CRC error */
> +			netdev->stats.rx_crc_errors++;
> +		kfree_skb(desc->skb);
> +	} else {
> +		netdev->stats.rx_packets++;
> +		netdev->stats.rx_bytes +=3D length;
> +
> +		skb_put(desc->skb, length);
> +		desc->skb->protocol =3D hdlc_type_trans(desc->skb, netdev);
> +		netif_rx(desc->skb);
> +	}
> +
> +	/* Re-queue a transfer using the same descriptor */
> +	ret =3D qmc_hdlc_recv_queue(qmc_hdlc, desc, desc->dma_size);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "queue recv desc failed (%d)\n", ret);
> +		netdev->stats.rx_errors++;
> +	}
> +}

[...]

> +static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device =
*netdev)
> +{
> +	struct qmc_hdlc *qmc_hdlc =3D netdev_to_qmc_hdlc(netdev);
> +	struct qmc_hdlc_desc *desc;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);
> +	desc =3D &qmc_hdlc->tx_descs[qmc_hdlc->tx_out];
> +	if (WARN_ONCE(!desc->skb, "No tx descriptors available\n")) {
> +		/* Should never happen.
> +		 * Previous xmit should have already stopped the queue.
> +		 */
> +		netif_stop_queue(netdev);
> +		spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> +		return NETDEV_TX_BUSY;
> +	}
> +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> +
> +	desc->netdev =3D netdev;
> +	desc->dma_size =3D skb->len;
> +	desc->skb =3D skb;
> +	ret =3D qmc_hdlc_xmit_queue(qmc_hdlc, desc);
> +	if (ret) {
> +		desc->skb =3D NULL; /* Release the descriptor */
> +		if (ret =3D=3D -EBUSY) {
> +			netif_stop_queue(netdev);
> +			return NETDEV_TX_BUSY;
> +		}
> +		dev_kfree_skb(skb);
> +		netdev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	qmc_hdlc->tx_out =3D (qmc_hdlc->tx_out + 1) % ARRAY_SIZE(qmc_hdlc->tx_d=
escs);
> +
> +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);
> +	if (qmc_hdlc->tx_descs[qmc_hdlc->tx_out].skb)
> +		netif_stop_queue(netdev);
> +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);

The locking schema is quite bad, as the drivers acquires and releases 3
locks for each tx packet. You could improve that using the qmc_chan-
>tx_lock to protect the whole qmc_hdlc_xmit() function, factoring out a
lockless variant of qmc_hdlc_xmit_queue(),=C2=A0and using it here.

In general is quite bad that the existing infra does not allow
leveraging NAPI. Have you considered expanding the QMC to accomodate
such user?

Cheers,

Paolo


