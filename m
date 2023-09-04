Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051E791A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjIDPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbjIDPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:23:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406610F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:23:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qdBPB-00058K-P3; Mon, 04 Sep 2023 17:22:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 97AFF218726;
        Mon,  4 Sep 2023 15:22:20 +0000 (UTC)
Date:   Mon, 4 Sep 2023 17:22:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v4 3/3] can: xilinx_can: Add ethtool stats interface for
 ECC errors
Message-ID: <20230904-unbiased-putt-a1a2919b02c7-mkl@pengutronix.de>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
 <1693557645-2728466-4-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5dk3iq2kvsfzpmv"
Content-Disposition: inline
In-Reply-To: <1693557645-2728466-4-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5dk3iq2kvsfzpmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2023 14:10:45, Srinivas Goud wrote:
> Add ethtool stats interface for reading FIFO 1bit/2bit
> ECC errors information.
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v4:
> None
>=20
> Changes in v3:
> None
>=20
> Changes in v2:
> Add ethtool stats interface
>=20
>  drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 798b32b..50e0c9d 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -219,6 +219,7 @@ struct xcan_devtype_data {
>   * @transceiver:		Optional pointer to associated CAN transceiver
>   * @rstc:			Pointer to reset control
>   * @ecc_enable:			ECC enable flag
> + * @stats_lock:			Lock for synchronizing hardware stats

To be precise: The lock is about the access of the 64 bit variables not
about the hardware access:
"Lock for accessing the "ecc_*bit_*fifo_cnt" stats"

>   * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
>   * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
>   * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
> @@ -245,6 +246,7 @@ struct xcan_priv {
>  	struct phy *transceiver;
>  	struct reset_control *rstc;
>  	bool ecc_enable;
> +	spinlock_t stats_lock; /* Lock for synchronizing hardware stats */
>  	u64 ecc_2bit_rxfifo_cnt;
>  	u64 ecc_1bit_rxfifo_cnt;
>  	u64 ecc_2bit_txolfifo_cnt;
> @@ -1164,6 +1166,9 @@ static void xcan_err_interrupt(struct net_device *n=
dev, u32 isr)
> =20
>  	if (priv->ecc_enable) {
>  		u32 reg_ecc;
> +		unsigned long flags;

nitpick: move the flags before the reg_ecc.

> +
> +		spin_lock_irqsave(&priv->stats_lock, flags);
> =20
>  		reg_ecc =3D priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
>  		if (isr & XCAN_IXR_E2BERX_MASK) {
> @@ -1212,6 +1217,8 @@ static void xcan_err_interrupt(struct net_device *n=
dev, u32 isr)
>  		 */
>  		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
>  				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
> +
> +		spin_unlock_irqrestore(&priv->stats_lock, flags);
>  	}
> =20
>  	if (cf.can_id) {
> @@ -1639,6 +1646,23 @@ static int xcan_get_auto_tdcv(const struct net_dev=
ice *ndev, u32 *tdcv)
>  	return 0;
>  }
> =20
> +static void ethtool_get_ethtool_stats(struct net_device *ndev,
> +				      struct ethtool_stats *stats, u64 *data)
> +{
> +	struct xcan_priv *priv =3D netdev_priv(ndev);
> +	unsigned long flags;
> +	int i =3D 0;
> +
> +	spin_lock_irqsave(&priv->stats_lock, flags);
> +	data[i++] =3D priv->ecc_2bit_rxfifo_cnt;
> +	data[i++] =3D priv->ecc_1bit_rxfifo_cnt;
> +	data[i++] =3D priv->ecc_2bit_txolfifo_cnt;
> +	data[i++] =3D priv->ecc_1bit_txolfifo_cnt;
> +	data[i++] =3D priv->ecc_2bit_txtlfifo_cnt;
> +	data[i++] =3D priv->ecc_1bit_txtlfifo_cnt;
> +	spin_unlock_irqrestore(&priv->stats_lock, flags);
> +}
> +
>  static const struct net_device_ops xcan_netdev_ops =3D {
>  	.ndo_open	=3D xcan_open,
>  	.ndo_stop	=3D xcan_close,
> @@ -1648,6 +1672,7 @@ static const struct net_device_ops xcan_netdev_ops =
=3D {
> =20
>  static const struct ethtool_ops xcan_ethtool_ops =3D {
>  	.get_ts_info =3D ethtool_op_get_ts_info,
> +	.get_ethtool_stats =3D ethtool_get_ethtool_stats,

You also should implement .get_strings and .get_sset_count. Have you
tested your patch with "ethtool -S can0"?

>  };
> =20
>  /**
> --=20
> 2.1.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f5dk3iq2kvsfzpmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmT19ikACgkQvlAcSiqK
BOjKKwf/XqBeS89ieZVoVrZnmkm/eKWi/h6aE4Oueilc6bRGc0NImrOHvmfFNfad
ZZ/uNxK8Na5EafNjeI/Blh4H1Pk1KsxuK3wrb8YmrrajrZZwbIhQF+/wRMHW+ops
CY34A+HZN/dsMseSLORDKTrvexxI0iKqbdLfnBwvVh0gAfEIxsUPzqWp+/Qz9DeW
b2CHj8te4m7Ovk/KMjlJuipZWwkgjSL6d5D++Z8uTjQWHm0yNvCeCA6CpRTDdkwY
Ckbb6qDi1I5h37X9JCtOOOgl1TQBaDZeGl6eBGuJDtIUNawL5naLDcPe4BoKyul1
Xu4th/hAOGXGYrhclCMIjjT4rUAwfg==
=FRQF
-----END PGP SIGNATURE-----

--f5dk3iq2kvsfzpmv--
