Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E729791A40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbjIDPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjIDPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:05:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23BCC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:05:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qdB80-0004jF-14; Mon, 04 Sep 2023 17:04:36 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 10B972186EF;
        Mon,  4 Sep 2023 15:04:35 +0000 (UTC)
Date:   Mon, 4 Sep 2023 17:04:34 +0200
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
Subject: Re: [PATCH v4 2/3] can: xilinx_can: Add ECC support
Message-ID: <20230904-postal-easily-aaec334f8d65-mkl@pengutronix.de>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
 <1693557645-2728466-3-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lna5xr3anxve76dv"
Content-Disposition: inline
In-Reply-To: <1693557645-2728466-3-git-send-email-srinivas.goud@amd.com>
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


--lna5xr3anxve76dv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2023 14:10:44, Srinivas Goud wrote:
> Add ECC support for Xilinx CAN Controller, so this driver reports
> 1bit/2bit ECC errors for FIFO's based on ECC error interrupt.
> ECC feature for Xilinx CAN Controller selected through
> 'xlnx,has-ecc' DT property
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
> Address review comments
>=20
>  drivers/net/can/xilinx_can.c | 129 +++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 114 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index abe58f1..798b32b 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -53,18 +53,23 @@ enum xcan_reg {
>  	XCAN_AFR_OFFSET		=3D 0x60, /* Acceptance Filter */
> =20
>  	/* only on CAN FD cores */
> -	XCAN_F_BRPR_OFFSET	=3D 0x088, /* Data Phase Baud Rate
> -					  * Prescaler
> -					  */
> -	XCAN_F_BTR_OFFSET	=3D 0x08C, /* Data Phase Bit Timing */
> -	XCAN_TRR_OFFSET		=3D 0x0090, /* TX Buffer Ready Request */
> -	XCAN_AFR_EXT_OFFSET	=3D 0x00E0, /* Acceptance Filter */
> -	XCAN_FSR_OFFSET		=3D 0x00E8, /* RX FIFO Status */
> -	XCAN_TXMSG_BASE_OFFSET	=3D 0x0100, /* TX Message Space */

These look like unrelated changes to me. Either move them into a
separate patch (before you add the new offsets) or remove them
completely. Please use tabs not spaces for indention, as the rest of
this file does.

> +	XCAN_F_BRPR_OFFSET	=3D 0x88, /* Data Phase Baud Rate Prescaler */
> +	XCAN_F_BTR_OFFSET	=3D 0x8C, /* Data Phase Bit Timing */
> +	XCAN_TRR_OFFSET		=3D 0x90, /* TX Buffer Ready Request */
> +
> +	/* only on AXI CAN cores */
> +	XCAN_ECC_CFG_OFFSET     =3D 0xC8, /* ECC Configuration */
> +	XCAN_TXTLFIFO_ECC_OFFSET        =3D 0xCC, /* TXTL FIFO ECC error counte=
r */
> +	XCAN_TXOLFIFO_ECC_OFFSET        =3D 0xD0, /* TXOL FIFO ECC error counte=
r */
> +	XCAN_RXFIFO_ECC_OFFSET          =3D 0xD4, /* RX FIFO ECC error counter =
*/
> +
> +	XCAN_AFR_EXT_OFFSET	=3D 0xE0, /* Acceptance Filter */
> +	XCAN_FSR_OFFSET		=3D 0xE8, /* RX FIFO Status */
> +	XCAN_TXMSG_BASE_OFFSET	=3D 0x100, /* TX Message Space */
> +	XCAN_AFR_2_MASK_OFFSET  =3D 0xA00, /* Acceptance Filter MASK */
> +	XCAN_AFR_2_ID_OFFSET    =3D 0xA04, /* Acceptance Filter ID */
>  	XCAN_RXMSG_BASE_OFFSET	=3D 0x1100, /* RX Message Space */
>  	XCAN_RXMSG_2_BASE_OFFSET	=3D 0x2100, /* RX Message Space */
> -	XCAN_AFR_2_MASK_OFFSET	=3D 0x0A00, /* Acceptance Filter MASK */
> -	XCAN_AFR_2_ID_OFFSET	=3D 0x0A04, /* Acceptance Filter ID */
>  };
> =20
>  #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
> @@ -124,6 +129,12 @@ enum xcan_reg {
>  #define XCAN_IXR_TXFLL_MASK		0x00000004 /* Tx FIFO Full intr */
>  #define XCAN_IXR_TXOK_MASK		0x00000002 /* TX successful intr */
>  #define XCAN_IXR_ARBLST_MASK		0x00000001 /* Arbitration lost intr */
> +#define XCAN_IXR_E2BERX_MASK            BIT(23) /* RX FIFO two bit ECC e=
rror */
> +#define XCAN_IXR_E1BERX_MASK            BIT(22) /* RX FIFO one bit ECC e=
rror */
> +#define XCAN_IXR_E2BETXOL_MASK          BIT(21) /* TXOL FIFO two bit ECC=
 error */
> +#define XCAN_IXR_E1BETXOL_MASK          BIT(20) /* TXOL FIFO One bit ECC=
 error */
> +#define XCAN_IXR_E2BETXTL_MASK          BIT(19) /* TXTL FIFO Two bit ECC=
 error */
> +#define XCAN_IXR_E1BETXTL_MASK          BIT(18) /* TXTL FIFO One bit ECC=
 error */

Use tabs for indention not spaces as the rest of the file.

>  #define XCAN_IDR_ID1_MASK		0xFFE00000 /* Standard msg identifier */
>  #define XCAN_IDR_SRR_MASK		0x00100000 /* Substitute remote TXreq */
>  #define XCAN_IDR_IDE_MASK		0x00080000 /* Identifier extension */
> @@ -137,6 +148,11 @@ enum xcan_reg {
>  #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
>  #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
>  #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
> +#define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error count=
ers */
> +#define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error c=
ounters */
> +#define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error c=
ounters */
> +#define XCAN_ECC_1BIT_CNT_MASK		GENMASK(15, 0) /* FIFO ECC 1bit count ma=
sk */
> +#define XCAN_ECC_2BIT_CNT_MASK		GENMASK(31, 16) /* FIFO ECC 2bit count m=
ask */
> =20
>  /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
>  #define XCAN_BRPR_TDC_ENABLE		BIT(16) /* Transmitter Delay Compensation =
(TDC) Enable */
> @@ -202,6 +218,13 @@ struct xcan_devtype_data {
>   * @devtype:			Device type specific constants
>   * @transceiver:		Optional pointer to associated CAN transceiver
>   * @rstc:			Pointer to reset control
> + * @ecc_enable:			ECC enable flag
> + * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
> + * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
> + * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
> + * @ecc_1bit_txolfifo_cnt:	TXOLFIFO 1bit ECC count
> + * @ecc_2bit_txtlfifo_cnt:	TXTLFIFO 2bit ECC count
> + * @ecc_1bit_txtlfifo_cnt:	TXTLFIFO 1bit ECC count
>   */
>  struct xcan_priv {
>  	struct can_priv can;
> @@ -221,6 +244,13 @@ struct xcan_priv {
>  	struct xcan_devtype_data devtype;
>  	struct phy *transceiver;
>  	struct reset_control *rstc;
> +	bool ecc_enable;
> +	u64 ecc_2bit_rxfifo_cnt;
> +	u64 ecc_1bit_rxfifo_cnt;
> +	u64 ecc_2bit_txolfifo_cnt;
> +	u64 ecc_1bit_txolfifo_cnt;
> +	u64 ecc_2bit_txtlfifo_cnt;
> +	u64 ecc_1bit_txtlfifo_cnt;
>  };
> =20
>  /* CAN Bittiming constants as per Xilinx CAN specs */
> @@ -523,6 +553,11 @@ static int xcan_chip_start(struct net_device *ndev)
>  		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
>  		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
> =20
> +	if (priv->ecc_enable)
> +		ier |=3D XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
> +			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
> +			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
> +
>  	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
>  		ier |=3D XCAN_IXR_RXMNF_MASK;
> =20
> @@ -1127,6 +1162,58 @@ static void xcan_err_interrupt(struct net_device *=
ndev, u32 isr)
>  		priv->can.can_stats.bus_error++;
>  	}
> =20
> +	if (priv->ecc_enable) {
> +		u32 reg_ecc;

It is better to read out all 3 counters directly one after the other,
then reset them. Then do the updates of the stats. This way you can keep
the lock short in the next patch.

Marc

> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BERX_MASK) {
> +			priv->ecc_2bit_rxfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: RX FIFO 2bit ECC error count %lld\n",
> +				   __func__, priv->ecc_2bit_rxfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BERX_MASK) {
> +			priv->ecc_1bit_rxfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: RX FIFO 1bit ECC error count %lld\n",
> +				   __func__, priv->ecc_1bit_rxfifo_cnt);
> +		}
> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BETXOL_MASK) {
> +			priv->ecc_2bit_txolfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXOL FIFO 2bit ECC error count %lld\n",
> +				   __func__, priv->ecc_2bit_txolfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BETXOL_MASK) {
> +			priv->ecc_1bit_txolfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXOL FIFO 1bit ECC error count %lld\n",
> +				   __func__, priv->ecc_1bit_txolfifo_cnt);
> +		}
> +
> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
> +		if (isr & XCAN_IXR_E2BETXTL_MASK) {
> +			priv->ecc_2bit_txtlfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXTL FIFO 2bit ECC error count %lld\n",
> +				   __func__, priv->ecc_2bit_txtlfifo_cnt);
> +		}
> +		if (isr & XCAN_IXR_E1BETXTL_MASK) {
> +			priv->ecc_1bit_txtlfifo_cnt +=3D
> +				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
> +			netdev_dbg(ndev, "%s: TXTL FIFO 1bit ECC error count %lld\n",
> +				   __func__, priv->ecc_1bit_txtlfifo_cnt);
> +		}
> +
> +		/* The counter reaches its maximum at 0xffff and does not overflow.
> +		 * Accept the small race window between reading and resetting ECC coun=
ters.
> +		 */
> +		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
> +				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
> +	}
> +
>  	if (cf.can_id) {
>  		struct can_frame *skb_cf;
>  		struct sk_buff *skb =3D alloc_can_err_skb(ndev, &skb_cf);
> @@ -1354,9 +1441,8 @@ static irqreturn_t xcan_interrupt(int irq, void *de=
v_id)
>  {
>  	struct net_device *ndev =3D (struct net_device *)dev_id;
>  	struct xcan_priv *priv =3D netdev_priv(ndev);
> -	u32 isr, ier;
> -	u32 isr_errors;
>  	u32 rx_int_mask =3D xcan_rx_int_mask(priv);
> +	u32 isr, ier, isr_errors, mask;
> =20
>  	/* Get the interrupt status from Xilinx CAN */
>  	isr =3D priv->read_reg(priv, XCAN_ISR_OFFSET);
> @@ -1374,10 +1460,17 @@ static irqreturn_t xcan_interrupt(int irq, void *=
dev_id)
>  	if (isr & XCAN_IXR_TXOK_MASK)
>  		xcan_tx_interrupt(ndev, isr);
> =20
> +	mask =3D XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
> +		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
> +		XCAN_IXR_RXMNF_MASK;
> +
> +	if (priv->ecc_enable)
> +		mask |=3D XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
> +			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
> +			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
> +
>  	/* Check for the type of error interrupt and Processing it */
> -	isr_errors =3D isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
> -			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
> -			    XCAN_IXR_RXMNF_MASK);
> +	isr_errors =3D isr & mask;
>  	if (isr_errors) {
>  		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
>  		xcan_err_interrupt(ndev, isr);
> @@ -1796,6 +1889,7 @@ static int xcan_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> =20
>  	priv =3D netdev_priv(ndev);
> +	priv->ecc_enable =3D of_property_read_bool(pdev->dev.of_node, "xlnx,has=
-ecc");
>  	priv->dev =3D &pdev->dev;
>  	priv->can.bittiming_const =3D devtype->bittiming_const;
>  	priv->can.do_set_mode =3D xcan_do_set_mode;
> @@ -1912,6 +2006,11 @@ static int xcan_probe(struct platform_device *pdev)
>  		   priv->reg_base, ndev->irq, priv->can.clock.freq,
>  		   hw_tx_max, priv->tx_max);
> =20
> +	if (priv->ecc_enable) {
> +		/* Reset FIFO ECC counters */
> +		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
> +			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
> +	}
>  	return 0;
> =20
>  err_disableclks:
> --=20
> 2.1.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lna5xr3anxve76dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmT18f8ACgkQvlAcSiqK
BOi6IQf/dYXOS7S7D3JvciQWJq91bilzO0zV4FOfvVIFxD6MWGG0pCztgbxDJa8a
Qd7VKa5VegGZuyRxdFvoaFjiZtSfTDQOp7xAbCc+IlaceEpJCurA7Zbx/JR7Te/Q
6YczQCl5HEuosPwJBVALGYFddXmtSxGlXPcLdfc3w09fzQ9Ce05E88jRrJeYtv+j
TmoWYTH3V61IyjpyjqsXKXK68SY6VkzlC4x0SPrpm0sMYlICgSgmgC/bk5vhs1kd
2zyEOyPxTOAlm8YE3x2vLMK7RLzYWNGyrsAtE7zqkgXkKtu7SKF9p4GK7UyBu46J
vo+3g75VAQvF0uPJL1Ej2DIj4JJUqg==
=pTrN
-----END PGP SIGNATURE-----

--lna5xr3anxve76dv--
