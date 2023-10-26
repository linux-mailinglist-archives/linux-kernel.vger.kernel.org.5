Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9B7D8BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjJZW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjJZW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:56:59 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B0D5E;
        Thu, 26 Oct 2023 15:56:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E0761C0002;
        Thu, 26 Oct 2023 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698361008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4iMNNFDpPe3Cb5T/lk7jSfq+yjOSHn3ci74jniqpZE=;
        b=LisFS7jaZYobsyxbFL312K6hzRJtyJEQY8+Uip538B4Wg30QUyk6EU4doL5EaRXVsZaDvl
        No4Nsi2rU7jtW0OD5kxhTHu0OiVqhh2k7hHyGmLaXiZ3/ywPRCakFQrzCFX7NwYll+HTJG
        vd/1EvnvaD2+qOSHyBg4Hf0E0Nij1BlVRqH58TFdfdgUCee92PXKmzE6uuJG/d3glSevnI
        2rVFAupWhRBr0Ikr9oJaOWDPZGcSbca4W5mG+s2B2OzZv+pcbSMVeBYBmD92fgbf4FT8q2
        598G/1hzB5eGzqpQVG57f/5NSBg7nqxXcMk5jsIAsru7dKaOlIP2DuSqs79Ybw==
Date:   Fri, 27 Oct 2023 00:56:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Eberhard Stoll <estl@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <20231027005643.4b95f17e@xps-13>
In-Reply-To: <20231026152316.2729575-2-estl@gmx.net>
References: <20231026152316.2729575-1-estl@gmx.net>
        <20231026152316.2729575-2-estl@gmx.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

estl@gmx.net wrote on Thu, 26 Oct 2023 17:23:02 +0200:

> From: Eberhard Stoll <eberhard.stoll@kontron.de>
>=20
> For spi devices the master clock output defines the sampling point
> for receive data input stream (rising or falling edge). The receive
> data stream from the device is delayed in relation to the master
> clock output.
>=20
> For some devices this delay is larger than one half clock period,

Can you be more specific? I am wondering how big the need is.

> which is normally the sampling point for receive data. In this case
> receive data is sampled too early and the device fails to operate.
> In consequence the spi clock has to be reduced to match the delay
> characteristics and this reduces performance and is therefore not
> recommended.
>=20
> Some spi controllers implement a 'clock to receive data delay'
> compensation which shifts the receive sampling point. So we need
> a property to set this value for each spi device.

What if the spi controller does not support this feature? Shall we add
a capability? Shall we refuse to probe if the controller is not capable
of sampling at the right moment?

> Add a parameter 'rx_sample_delay_ns' to enable setting the clock
> to rx data delay for each spi device separately.
>=20
> The 'clock to receive data delay' value is often referenced as tCLQV
> in spi device data sheets.
>=20
> Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  include/linux/spi/spi.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7f8b478fdeb3..14622d47f44f 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -166,6 +166,7 @@ extern void spi_transfer_cs_change_delay_exec(struct =
spi_message *msg,
>   * @cs_inactive: delay to be introduced by the controller after CS is
>   *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
>   *	two delays will be added up.
> + * @rx_sample_delay_ns: spi clk to spi rx data delay
>   * @pcpu_statistics: statistics for the spi_device
>   *
>   * A @spi_device is used to interchange data between an SPI slave
> @@ -219,6 +220,8 @@ struct spi_device {
>  	struct spi_delay	cs_setup;
>  	struct spi_delay	cs_hold;
>  	struct spi_delay	cs_inactive;
> +	/* Transfer characteristics */
> +	u32			rx_sample_delay_ns; /* Clock to RX data delay */
>=20
>  	/* The statistics */
>  	struct spi_statistics __percpu	*pcpu_statistics;
> --
> 2.25.1
>=20


Thanks,
Miqu=C3=A8l
