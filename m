Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00857FECB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjK3KUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjK3KT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:19:58 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9710D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF88124000B;
        Thu, 30 Nov 2023 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701339602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxeX2wy4DYJyBHFFmjfGARbNkbZtBHOZlxHLk2Rp2VQ=;
        b=SzsJiaOHAQP9sp5gZ+zR81XoshHOseb+8oXeDl1RCkHAzNJ68S1q73PKpRl+AoMxS0aHIF
        vq/qJlTVWyE2FPOQdgAV+6fOr2ifbXHP9h7QuzYn/7vxdfz1bA+vFqEd44x9008qz7k9G3
        bpQe3BkalvPYk+j7teQklvpV4k7yLJ5mTwyydgNOxn4A46ZEo8dG/xV8gm0xiGTPUbmTbG
        cS3PZx8fTmgffK6P5UUrzhhOtI3eXJ9A1Xhu8M80vgejYMx7ox4IyEDfmf9PlrCfPJkFHH
        2WUwYsBNAM4L5W1YCRy+X+mDS311DYBfmRIkkpG2eBb+H4WF6CWDVB14qX45QQ==
Date:   Thu, 30 Nov 2023 11:19:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 6/6] i3c: add API i3c_dev_gettstatus_format1() to get
 target device status
Message-ID: <20231130111959.11afd8a8@xps-13>
In-Reply-To: <20231129221225.387952-7-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-7-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:25 -0500:

> I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
> Get request for one I3C Target Device to return its current status.
>=20
> Add API to fetch it with format1.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
>  drivers/i3c/internals.h    |  1 +
>  drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
>  include/linux/i3c/device.h |  1 +
>  4 files changed, 52 insertions(+)
>=20
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 1a6a8703dbc3a..aa26cf50ab9c6 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
> =20
> +/**
> + * i3c_device_getstatus_format1() - Get device status with format 1.
> + * @dev: device for which you want to get status.
> + * @status: I3C status format 1
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)

I'm not a big fan of the opposition between "i3c_device" and "i3c_dev".
Could we clarify the prefixes?

> +{
> +	int ret =3D -EINVAL;

Init not useful

> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc)
> +		ret =3D i3c_dev_getstatus_format1_locked(dev->desc, status);
> +
> +	i3c_bus_normaluse_unlock(dev->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);

There is no user yet. Maybe this needs to be done in another series?
Same below.

...

> +int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *stat=
us)

...

Thanks,
Miqu=C3=A8l
