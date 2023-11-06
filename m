Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4037E2606
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjKFNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjKFNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:49:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A9D8;
        Mon,  6 Nov 2023 05:48:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F1C433C8;
        Mon,  6 Nov 2023 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699278537;
        bh=0oKTtQUIuA/UNh7BlgWnSQNzeQifRGq3xhGewAMVSxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRpXWwPy9u6MeGKGXxbWlU1WmJgV3hbnixx9QtvllDEtK3uII8EB2C7+THkh7RBMg
         m2bWGSP5/Er6O1+LGoMxqVScHzLlnAxOY6bgFZPhyDnCfDEfecjCR5YEvKdPB+iX3B
         CgVCqlQvge0l6sU4P416040LhEUbQvizBDduzgwycPXXleAfbc0IP3ZZrLwaGn1/r0
         1R0et4621CUs8/YVzqR6kPYV/wBMDaukvLWGaxC74ayR6T7Pwj3vFBPWFZ32hSUoxg
         ywGkBpIqRPnj+EvefMCG7ulBSBuldyYWt51BvTDIeLCWyrdqXyGHLhMtSM2cLNC4eH
         jU5bJjBQF9zEw==
Date:   Mon, 6 Nov 2023 13:48:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald.Mommer@gmail.com, quic_ztu@quicinc.com,
        Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4 draft
 specification).
Message-ID: <ZUjuxfKdwRQgbfdb@finisterre.sirena.org.uk>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0TlT5yIZ49HmuB9r"
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0TlT5yIZ49HmuB9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 06:10:16PM +0200, Harald Mommer wrote:

> +config SPI_VIRTIO
> +	tristate "Virtio SPI SPI Controller"
> +	depends on VIRTIO
> +	help
> +	  This enables the Virtio SPI driver.
> +
> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
> +
> +	  If your Linux is a virtual machine using Virtio, say Y here.
> +

This advice is going to be inappropriate for the majortiy of guests.

> +	// clang-format off
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;
> +	uint8_t *rx_buf				____cacheline_aligned;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +	// clang-format on

Remove this clang-format stuff.

> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +	.max_speed_hz = 125000000, /* Arbitrary very high limit */
> +	.bus_num = 0, /* Patched later during initialization */
> +	.chip_select = 0, /* Patched later during initialization */
> +	.mode = SPI_MODE_0,
> +};

> +/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */

In what way is one supposed to compare with the i2c driver?  What
happens if the I2C driver changes?  It would be better to ensure that
the code can be read and understood as a standalone thing.

> +	/* Fill struct spi_transfer_head */
> +	th->slave_id = spi->chip_select;

If the spec just copied the Linux terminology it'd have few issues :(

> +	th->bits_per_word = spi->bits_per_word;
> +	th->cs_change = xfer->cs_change;

The virtio spec for cs_change is *not* what the Linux cs_change field
does, this will not do the right thing.

> +	th->tx_nbits = xfer->tx_nbits;
> +	th->rx_nbits = xfer->rx_nbits;
> +	th->reserved[0] = 0;
> +	th->reserved[1] = 0;
> +	th->reserved[2] = 0;
> +
> +#if (VIRTIO_SPI_CPHA != SPI_CPHA)
> +#error VIRTIO_SPI_CPHA != SPI_CPHA
> +#endif

BUILD_BUG_ON()


--0TlT5yIZ49HmuB9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVI7sUACgkQJNaLcl1U
h9AZlQf/Ve5Bnp+BSp6duxDV3rwHEnTdISxriTPwTP6X5GCiAyuO0ExccnmmTkMD
78KimEB+hAUqR5t7BLAjmA/7D61cBteKtHBk7hetDNIngdT7INOFqaAsxQOk0eaE
gyD98W7pF3Rb+aji1fkTCHi3GuwSCHitrLPNx6SxIfvlw9ghR8oz9O+10XcCNk2+
t2yKYMR2zG0vvExIDiaavW9WCWOJsGt+F4y8Q/5eMS2RkSg18SBPY3EA96eOVAU3
1jpkO6O2RQ0m/3lZURcRiq4HaPA13tfW6X8EzMtcop5nQtwSSufzZK0Vr/HbWF1T
NGxwslv7oXq/I5gDxAxXrRDvgWrbUw==
=mAr1
-----END PGP SIGNATURE-----

--0TlT5yIZ49HmuB9r--
